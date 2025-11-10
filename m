Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D1F50F;
	Mon, 10 Nov 2025 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812490; cv=none; b=F73dg/sSU5AWO+zQUgRuYHszvUItx6kZzHHEzj5nVAmgPfCJ6MbrDLPBOh46TqKoUJE1az7l6dDogpKbPXp/fCfZ1qzZjDpK0Aku8UjHqJUzDuWLwMyORETRIyzUygXuAY/SndzaEtxmEhgtDU0KkOP28i4fEm3eqlwRizOzA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812490; c=relaxed/simple;
	bh=QcNOW5NQf3d2H3CU/o4Qj6FoGkQmNS1yvzWb9gL9UCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+SB8lgk1H0w9gapysp+lpX0Ujauo07qkkfKg2OYLaURo+ZL6j9S9Ctk40zMLXIqFgDKxP6+oVgDi2jYjECkDVgG2hgDeX9Ddw6Nzm2xCyA/WqLsFZerU+rx+u9SIrJdmrWdItEGI3u3F8aP9OFpWMs+mGHMmkH0iVCU9euqFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5mLh+Z1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5mLh+Z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE547C19425;
	Mon, 10 Nov 2025 22:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762812489;
	bh=QcNOW5NQf3d2H3CU/o4Qj6FoGkQmNS1yvzWb9gL9UCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5mLh+Z1XWUdD3M+2RuGujQYRrul92YMpJdXDykJdgxYf6yPNGx4Dwmrn/3dBv/N3
	 1zdMhQC3t8ti+LDeBvIavQ1fJws5J4hzp8TUGxBblkUcZbQumulFx/nNntDQ6ZbrDk
	 Xdi1SRa/puIkRVVzNjT3zw5xxrgaDTkN5KJVfGxkrSBw8/9wOivwfTP0VDBU1eei+n
	 6W3yUjjfT7xAvFxAQ7gL/fMhEjZsEdL+L1tlf56yk5wyVBGJJ/oxS8jJs0Ihif+DiT
	 N1lxZH9e6M0tQ5f7RWWPdyGfiGxiOilCA0kZzXtiXY7U5DTJHtp+49kL58PQ3PoH6d
	 ja6+IYYN52ryQ==
Date: Mon, 10 Nov 2025 12:08:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] sched_ext: Add scx_cpu0 example scheduler
Message-ID: <aRJiR7H3RQHmgCct@slm.duckdns.org>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-12-tj@kernel.org>
 <aRGkHhAWTWdWELAY@gpd4>
 <aRIyfJWJ6fcW5frO@slm.duckdns.org>
 <aRJT1dbGTmPRw4-p@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRJT1dbGTmPRw4-p@gpd4>

Hello,

On Mon, Nov 10, 2025 at 10:06:29PM +0100, Andrea Righi wrote:
> I agree that if a scheduler uses SCX_SLICE_DFL it shouldn't care too much
> about the exact value.
> 
> My concern was more about those schedulers that are quite paranoid about
> latency and even if something isn't handled properly (directly dispatching
> to a wrong CPU, a task being rescheduled internally, etc.), we'd still have
> a guarantee that a task's time slice can't exceed a known upper bound. But
> this could be managed by being able to set a default time slice (somehow)
> and it can be addressed separately.
> 
> So yeah, in this case the exact value of SCX_SLICE_DFL doesn't really
> matter probably.

AFAICS, all cases where we use the default slice can be avoided by setting
the right SCX_OPS_ENQ_ flags and not letting through tasks with zero slice.
ie. If the scheduler needs to control slice distribution closely, it can do
so and, if something leaks, that can be detected through the events although
it may be helpful to add a strict mode where these leaks can be tracked down
more easily.

This is not necessarily an argument against making the default slice
configurable. The fact that we use the default slice for bypassing was a
reason to be more cautious with exposing it (as that can affect system
recoverability) but with bypass slice separated out, that's less of a
concern too. So, yeah, I think making it ops configurable is fine too.

Thanks.

-- 
tejun
