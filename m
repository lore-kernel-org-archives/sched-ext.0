Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A537F8CA;
	Tue, 17 Mar 2026 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770980; cv=none; b=NV6A0bIDG5k7eVgpCAE+N/bEfGxgHEl/iwD9NYkgbCFiiZz3fkplqgcHUCLPTbaM2MyU0NapqsaeMOduhtAKKB2dXOguonr6Yu2/taccVlstMciANrswIgmAwPoSHIduWZ01181wJsIAR2mnAd5c9e4Bd0tFBJGUIMKS7A4YgLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770980; c=relaxed/simple;
	bh=fDkbcG3jLC+zaz2cKHvPO9FZpzAHnExSgaJTQJ7dPRg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=k3scOUU0gCnvZfwZGK2kmlnO/2xcOpcL+W1N28dj1mZTwZWqTfx97JBhppHiTOKK20YB0DAu+5czLbdxaW7gzShc60uupph4hrFDIbyyMeywq3rUhfHw5rE1EYdWYzoLEz4NxzqvEKe99ly8WU0JW1pH2ejkmprzVa1VhvMdzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BL6F5ujG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL6F5ujG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA6AC4CEF7;
	Tue, 17 Mar 2026 18:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770980;
	bh=fDkbcG3jLC+zaz2cKHvPO9FZpzAHnExSgaJTQJ7dPRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BL6F5ujGsAQHpazQCEpYijo9+1FVcZauhyVI0bxnbE5/Dki53TktcQbvaT8pf3ZbB
	 +nycTL1hoMvBlgSfMV5eV0Q4cbwj82d/TBSvPkp5hw0eaoDzfAfBMuvVsxqA+dk5xo
	 7n+w43l8rzWFNQO0VoT/3XkMcP1dax0N9c9HyfExUUp6KgcSlUkdFWDjdL6Ow7LzGs
	 I4kGHREkGtcWXpsQlczdb9Ncmx21PDKHYYIAXSsbhRef5LKh2AFGKYsVRn0mpsFj/C
	 VjY+GS0Glwk4xub8+wXfNGxPmghU3CyMP2URQ5QNBODXs+a+tVj0fTm0yMzIBUFrLT
	 YrrdVMef7+vGA==
Date: Tue, 17 Mar 2026 08:09:39 -1000
Message-ID: <ab7caad06bd6990657c2bfe5d11c5043@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext/selftests: Fix bpf_link leak on assertion
 failure
In-Reply-To: <20260317174402.48082-1-devnexen@gmail.com>
References: <20260317174402.48082-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

In numa.c and rt_stall.c, the assertions check for SCX_EXIT_NONE — i.e.
the scheduler ran without error. bpf_link__destroy() triggers unregistration
which changes uei.kind to SCX_EXIT_UNREG, so moving it before the assertions
would make them always fail. Did you run the selftests after this patch?

A simpler approach would be using __attribute__((cleanup())) to auto-destroy
the link on any return path:

  static inline void autolink_destroy(struct bpf_link **linkp)
  {
  	if (*linkp)
  		bpf_link__destroy(*linkp);
  }

  #define __autolink __attribute__((cleanup(autolink_destroy)))

Then each test just does:

  struct bpf_link *link __autolink = bpf_map__attach_struct_ops(...);

No reordering needed — the link auto-destroys on any return, including
early returns from assertion failures.

Thanks.

--
tejun
