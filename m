Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAB633993
	for <sched-ext@lists.linux.dev>; Tue, 17 Feb 2026 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771311447; cv=none; b=rqcaogf7kIM2hygn4PzbYATgRi4PXxBnIWjKknt81UIbeJDRfNxw+N2BPL5SwaBRPrfK6+vBmUdKDE/r3JDXTAaFlR/e66Pkwfx1SKnV8pR6Z0jp1Ig0qKs3A8keNXGdnWMX0eX+CvSB9N+5nW94/kABnEhvs0l6/VL/ABqNYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771311447; c=relaxed/simple;
	bh=WHu7LPbM5cAapkRzkkuUt95/zXCYVBbqUvMYaGWiFWI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=DkJ6MqNqAthNH7NSBYs7prhYDVJGii+pJQSqNbQG94grwNXuJCaF+vglklhQchAikN/u0a8dMD4/f9wEIre8a+K7PayEY3l/HJhGy2yVDtWARMr9yVf82QCtmgpsjaCNX1O4LD1PsurEuqldqBedUb4SXh8QCJ/tHq10rUEijGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA4gMmqy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA4gMmqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFCDC4CEF7;
	Tue, 17 Feb 2026 06:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771311447;
	bh=WHu7LPbM5cAapkRzkkuUt95/zXCYVBbqUvMYaGWiFWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DA4gMmqyDxbL08DvmMVnmTTuOaOwl5x5UmUOIFIgDDgO5dav8Nag5ojDiMuj3Gckz
	 WIWIt5KCoo1GzO3F7A1TE+eOkoxhPtd8O5X2R3sSt8Qjr5HJQODg8ftWHviDSo/TUz
	 YwqqGS3ROBWpsIX7n35H2T6Uq0gaTmuQhzl8bMM7F4NWUW9NNaEZk+rpaOhsxd0r93
	 zmbQ19zBTSuetFINnNrvpTDNfTscLrzYzWvtw0rNy60BVbjyNSBcsppQECvgdTWqyU
	 g1Rrjgm2xmAtApodf071Fkj3VhmvkZhj2zHCRD5J0i5bwvbEaeknIsUPBod1R3hpi2
	 azGIh/IW6FzCw==
Date: Mon, 16 Feb 2026 20:57:26 -1000
Message-ID: <cc32f7a7dafb33666dec252ea0116887@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 0/2] tools/sched_ext: Sync configuration with upstream
In-Reply-To: <20260216110014.771335-1-yphbchou0911@gmail.com>
References: <20260216110014.771335-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

AI-assisted review follows. Please verify the points.

- Patch 1 doesn't apply. The pre-image includes CONFIG_PAHOLE_HAS_SPLIT_BTF
  which has already been removed. Please rebase.

- Patch 2 has duplicate entries. CONFIG_BPF, CONFIG_BPF_SYSCALL,
  CONFIG_BPF_JIT appear in both the mandatory section and the bpftrace
  section.

- Patch 2 includes a number of options that are not user-selectable - they are
  auto-selected by arch or other dependencies and have no effect in .config
  fragments: CONFIG_HAVE_EBPF_JIT, CONFIG_HAVE_DYNAMIC_FTRACE,
  CONFIG_HAVE_KPROBES, CONFIG_ARCH_SUPPORTS_UPROBES, CONFIG_PREEMPT_COUNT,
  CONFIG_PREEMPTION, CONFIG_PREEMPT_RCU. These should be dropped.

- "more bpftrace to make that work" is a bit too casual as a comment. Please
  clean it up.

Thanks.

--
tejun
