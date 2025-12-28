Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808B287506;
	Sun, 28 Dec 2025 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766965083; cv=none; b=KBB912ZimegbzU8KbpV0P3tpOSGsM9eCxrU2WeYXs3a//5+BttaTCK3EhuSH229T74JggXLoJyioXGpaoKDM9htufKRYczDi/U9+Sv5F7L1F6hd0Is+Y2UQ8jiARM4wQIiwtHK5s4jaehwsw2adMwPnUYDURqlB86gwZhQ15dNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766965083; c=relaxed/simple;
	bh=q3X4BljQrM9Q3SzBHeY3QtXC52zA40wlWU9vWwOoQsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stlm7JKeU2irOA3WJ6lNA/YKLWoLbbxSSVlmmiiF7nm4mgHLAbLSJN6AQyhgvgQq6XTjDBKVoq+r/vZoceAoND9WB68vvcpLGVtMi5/w2JCRNfPLj+CCGkCxcNcbvs8Ii2uaQ1CwDgir7YR7ocG3aXUSB+bSQx+kn9GNYITWRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AviIsmT4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AviIsmT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9321C4CEFB;
	Sun, 28 Dec 2025 23:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766965082;
	bh=q3X4BljQrM9Q3SzBHeY3QtXC52zA40wlWU9vWwOoQsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AviIsmT4FHXGry6mRiF8m/rmMDEczxMDt0aHWq82rPQ8maDSNermGSbDlBPK2bRUO
	 3C6FwU22gyxp4hiPXxA6ljb1/kQk5g8a69eEAlLlhU5DVvoecHSDMy2p22+EAjav0A
	 FYl1zptlEHCotzNOY7MD5Xh3iSQkfVo1cd/Iqc3s9TB+X6wx703HxKWtDxU/V7X1Xf
	 aV7vpLrF2mB9UGWTpCLMvinVsDklf9AWaumU/SF+7EqxIh4AAgoTaCwO9QCAc/jGVj
	 5GAnHIxPph0jFiJeGznkd7vrzXHbjPQGvJPEyMBou+DGqK3yGhqvxmUUXRvW9vsg2q
	 J4X81R5F3x73A==
Date: Sun, 28 Dec 2025 13:38:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aVG_WZCq5QlRgrqK@slm.duckdns.org>
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-2-arighi@nvidia.com>
 <aVFmstVjLW_QIQis@slm.duckdns.org>
 <aVG9BBWIQLL8uJrQ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVG9BBWIQLL8uJrQ@slm.duckdns.org>

Hello again, again.

On Sun, Dec 28, 2025 at 01:28:04PM -1000, Tejun Heo wrote:
...
> So, please ignore that part. That's non-sense. I still wonder whether we can
> create some interlocking between scx_bpf_dsq_insert() and ops.dequeue()
> without making hot path slower. I'll think more about it.

And we can't create an interlocking between scx_bpf_dsq_insert() and
ops.dequeue() without adding extra atomic operations in hot paths. The only
thing shared is task rq lock and dispatch path can't do that synchronously.
So, yeah, it looks like the best we can do is always letting the BPF sched
know and let it figure out locking and whether the task needs to be
dequeued from BPF side.

Thanks.

-- 
tejun
