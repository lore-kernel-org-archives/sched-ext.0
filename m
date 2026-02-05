Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE228371;
	Thu,  5 Feb 2026 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770254138; cv=none; b=k0MetR+kNxWNI555Kb0R/jX4t/bn5FcvBBvzEN9TwDyIhzgTwCGMCF0kdxiC+vxDXiG1CtGPwzOTH2u7hRzcFAiFKe5nr8e+Fs+Sl21EaWNTsaS5UMaIC7gMTaAnjzsq/egbIwPFKNJnVMpk+bmn/ITws0AZDPPuvlDuEipIP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770254138; c=relaxed/simple;
	bh=gNvbd5x4XTgLDXwimGlUXHOL75Mof0TJ7p0mcIhoGjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFrwxDfo5vPQ1qfdSg9CmdKUhbzBbm+rBpVP46F6z+ToqmySj1/UPh4UB6cFCJhHV5m3FxxZvlq3VUb90jhUtWERm9+2FJQnlkyrlTtMhEoYk1Y5NSzUtFDGdz+6K7cUQuPKnJZXGtmrADiajlF/NjUhU0fFgUodBkLEse9VKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pkd90ok4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pkd90ok4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604B3C4CEF7;
	Thu,  5 Feb 2026 01:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770254138;
	bh=gNvbd5x4XTgLDXwimGlUXHOL75Mof0TJ7p0mcIhoGjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pkd90ok4YuhjK5L8EJTtMou02BEHC/QzrMo74Ha/7rTOK5fbw49M5jxnPjj1n8Pi+
	 f88xZXo0NBOMr+t7yjT/TL5dDdTHRwlgZTw5mKXs83j5YU87SWy75E0ksP88ia+LCV
	 RKTIwpb1sxDJNRE1YR5GkxobQWsxbacuTPi+GxBu65LNopCCUBuXQQygwiZ9fj+fVQ
	 7OmzH3FBF5NlFI4CoAKt18WhxrjFFxE5rfHPGUgBWZFLJi7C6+buT0VyyUQV9u2k9G
	 Mm8z3QFuGEv6yLZI+ggNlEMffqXjqnpbEOCYAgJv0mXiC2LO9fZrJZvRhaG36mpEYE
	 aNO4OWcJsrpPQ==
Date: Wed, 4 Feb 2026 15:15:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity
 changes
Message-ID: <aYPvOXyGJTyHV-eY@slm.duckdns.org>
References: <20260203230639.1259869-1-arighi@nvidia.com>
 <aYPW121Y6vGtmtST@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYPW121Y6vGtmtST@slm.duckdns.org>

Hello,

On Wed, Feb 04, 2026 at 01:31:35PM -1000, Tejun Heo wrote:
...
> I wonder whether we should define an invalid qseq and use that instead. The
> queueing instance really is invalid after this and it would help catching
> cases where BPF scheduler makes mistakes w/ synchronization. Also, wouldn't
> dequeue_task_scx() or ops_dequeue() be a better place to shoot down the
> enqueued instances? While the symptom we most immediately see are through
> cpumask changes, the underlying problem is dequeue not shooting down
> existing enqueued tasks.

Hmmm... in fact, this is all happening already, right? Isn't all that's
missing the BPF scheduler's ops.dequeue() synchronizing against
scx_bpf_dsq_insert()?

Thanks.

-- 
tejun
