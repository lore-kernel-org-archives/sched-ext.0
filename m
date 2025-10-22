Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1162417DE;
	Wed, 22 Oct 2025 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150892; cv=none; b=ZgQ7dWokgHnUDibUxWjCHk2V51q7j4SL1/id4PqVEbpdUUgqnP+3ihR23FT3icE23iAh9vXAF+Bw8cDTbkaytPw8i2R6w3tZ9jSdgUl2vFXE6cOpARxXh72T7wI5/t/H6+/fy8TQo8HQVw2Ro9B9+MyKcABqHiuYIAQOJEOy9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150892; c=relaxed/simple;
	bh=AngP8/mlQWQYwojKFyXedg6xPWRyaDsaL7RxI6w7Ovo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKk/YbRCb9uNGqNabNIG703GvBlq0Y1MbXXcYgRD7RxoFmi38UyZau/K8l+3INrxYTJOtmVks7TP58TuKjL9ZiTiHqeyGuxcSHiuFNuY8/sOT/Bt48RrwU/B2e/+01p9ECnEen3xSsV2eHNzrjEkWsVoQnWuFlSBLYudWe9tekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH7cZwPd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH7cZwPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BBAC4CEE7;
	Wed, 22 Oct 2025 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761150892;
	bh=AngP8/mlQWQYwojKFyXedg6xPWRyaDsaL7RxI6w7Ovo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EH7cZwPddvMinVu2oho3mPHwKsT8hmzKVvxpCK/P0kGxNB8QkQ86LT2VM4ajeb3Rn
	 ptEGKhy1BddyuqcE+FFRzAJdop3ASVm725WpxQ14ZbqPPSLt2BtVylVQFtxnr8phFK
	 Xz3Rd4U+iVTRF7I2/hzFESCTMBi1YmzkNbdxsvqU9su+QVju+cFApxXeHJ2o8udg7u
	 Z4mbSgGwcSctBn42QYexFO+X++7JCk/NZmCv0qawYv2M17/iuozZInD7b/mkV/gnQ+
	 7B4Xv2/32saFv+E+jtffHHe/+A+/YqwhZjZ21vM02g5V4VwnU5//8mF1LcIEsd7/rm
	 yLYOaBGRZARiw==
Date: Wed, 22 Oct 2025 06:34:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-6.19] sched_ext: Use ___v2 suffix for
 new kfuncs and fix scx build errors
Message-ID: <aPkHqpPGZ-9EBGUz@slm.duckdns.org>
References: <20251022093826.113508-1-arighi@nvidia.com>
 <20251022153610.20111-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022153610.20111-1-arighi@nvidia.com>

Hello,

On Wed, Oct 22, 2025 at 05:36:10PM +0200, Andrea Righi wrote:
> Following commit 2dbbdeda77a61 ("sched_ext: Fix scx_bpf_dsq_insert()
> backward binary compatibility"), consistently use the ___v2 suffix also
> to the new scx_bpf_dsq_insert_vtime() and scx_bpf_select_cpu_and()
> kfuncs.

It's a bit subtle but the assumption around ___VER is that that isn't (going
to be) visible to BPF users and will eventually be dropped. Here, it's a bit
different. The arg packing is something we'll need to do indefinitely unless
BPF lifts the limit on #args. So, we will continue to have the internal
kfunc which takes the packaged arguments and user-facing wrapper that hides
that. So, I think __ prefix (something more explicit works top - e.g.
argpack prefix or suffix) is a better option here.

> Introduce __COMPAT_scx_bpf_select_cpu_and() and
> __COMPAT_scx_bpf_dsq_insert_vtime(), to ensure schedulers can transition
> smoothly to the updated interfaces, and temporarily mirror the
> definitions of struct scx_bpf_select_cpu_and_args and struct
> scx_bpf_dsq_insert_vtime_args to prevent build failures on kernels where
> these structs are not yet defined.

Given that there is on capability difference between before and after from
the scheduler POV, I'm not sure we need to make __COMPAT explicit. There's
nothing really gained by adding the prefix. This has been evolving over
time, but I think a reasonable rule of thumb is:

 If the SCX core introduces a new feature which may affect BPF scheduler
 operations in a noticeable way, that feature should be gated behind
 __COMPAT. The BPF scheduler using a __COMPAT prefixed interface should then
 be able to handle cases where the feature is not implemented. If the BPF
 scheduler depends on the new feature (ie. it doesn't want to stay
 compatible with older kernels), it should use the interface without
 __COMPAT.

Here, there is no noticeable feature difference before and after for
existing schedulers, so I don't think it's necessary to introduce __COMPAT
prefix.

Thanks.

-- 
tejun
