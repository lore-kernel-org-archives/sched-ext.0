Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588AF3FEF;
	Thu, 12 Feb 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770916027; cv=none; b=L9o2v23jbRXniW9/wWtnVg5sees/I9ZmubADU92dynJ/K6wdnGYprjo9ZvPS60HewT+a3ZrFrBgqKuKRedajSYka/6MhCJVyA+uPGHJTrUipkqjKhV6qaeKeJO7pu8DAP7FnwRLaafL0RN6e4QY+ORAhzzXelcMdby5vLwaFC0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770916027; c=relaxed/simple;
	bh=8ld1r6w+vDeZny7Su01Q+GjJZsqWuSZQ7p8i57Hj38A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j96ds8gQmkMlWiYqTkwftTuIq6P254lfOXH5Vdmnr4yHmv9VZSikfaauY+9rHypcwD+/Y38g6HVNCngaAPNR8DcOKtbMwjlj/hRRO6Q5pqxg0TFe3qSCCh02yt2/5u8YLgOL2lQljKR7MgXJZav64zbl2B0Wg1TG84MiZu5yZ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJS7pVOE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJS7pVOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB023C4CEF7;
	Thu, 12 Feb 2026 17:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770916026;
	bh=8ld1r6w+vDeZny7Su01Q+GjJZsqWuSZQ7p8i57Hj38A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJS7pVOEr1LjAzWBl9ejkyZQPGD78AaHAVuFqwW9qqDLl+5keZiZ8OtCqAK4wnbfP
	 tI9lpANVagM/quUcIZdMujQJgLnap/efnS2WYXvqwcGbOVMM4kJPEmicXaxRPgnK2u
	 lKNABX/b8C8MmpCJje1BqaUMmjmO2mc9kZobguGWeR6aV3f6G6RHkFz6QL+CL7Q+Q/
	 W7Io50qaBwIhsseYV5b1NBuVuKGSILfGQ/OBXkun/uZ510+OuQiE9FvtA3dZHhNM5n
	 ShuCQJdtaOw/fBkHhEPWSzIENlxlnhbpDDcLi15Vf71n+dc23E8EAF8x7zBILUcYgK
	 tUwt4HpETNf+g==
Date: Thu, 12 Feb 2026 07:07:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aY4IuX59PsmSsi1g@slm.duckdns.org>
References: <20260210212813.796548-1-arighi@nvidia.com>
 <20260210212813.796548-2-arighi@nvidia.com>
 <aYu9KzKTMfNIFDwD@slm.duckdns.org>
 <aYyo_ALV_BT6WaE0@gpd4>
 <aYzc7ZVkSrtdeHnA@slm.duckdns.org>
 <aY0EDpFD1FSrigB6@gpd4>
 <aY0EmUnmo4gGitcW@slm.duckdns.org>
 <aY2ofYcZpni9L0px@gpd4>
 <8dd4bc8d-83db-4812-b3e3-ea0bbbb24875@arm.com>
 <aY31pzTFyZ-nKK1J@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY31pzTFyZ-nKK1J@gpd4>

Hello,

On Thu, Feb 12, 2026 at 04:45:43PM +0100, Andrea Righi wrote:
> > > So, we need a way to mark "this migration is internal to SCX", like a new
> > > SCX_TASK_MIGRATING_INTERNAL flag?

Yeah, I think this is what we should do. That's the only ops.dequeue()
without matching ops.enqueue(), right?

...
> > IIUC one example might sway your opinion (or not):
> > Note that not receiving a ops.dequeue() for tasks leaving one LOCAL_DSQ
> > (and maybe being enqueued at another) prevents e.g. accurate PELT load
> > tracking on the BPF side.
> > Regular utilization tracking works through ops.running() and 
> > ops.stopping() but load I don't think load can be implemented accurately.
> 
> It makes sense to me and I think it's actually valid reason to prefer the
> "always trigger" way.

I don't think this is a valid argument. PELT is done that way because the
association of the task and the CPU is meaningful for in-kernel schedulers.
The queues are actually per-CPU. For SCX scheds, the relationship is not
known to the kernel. Only the BPF scheduler itself knows, if it wants to
attribute per-task load to a specific CPU, which CPU it should be attributed
to. What's the point of following in-kernel association for PELT if the task
was going to be hot migrated to another CPU on execution?

Thanks.

-- 
tejun
