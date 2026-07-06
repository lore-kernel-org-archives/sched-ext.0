Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD92236E0
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381245; cv=none; b=PL7kFDNtdIsd6Z5NdFdJSw6tFJvisFr8Ob23Rl6hqpAZ4otdOQqbHBpDBXqxEaxAn44JLMgIrJtJsW1c3UZuXHvMNBY4uwGjIf1M//CiOXaaHHnLMbwSlu+Q3mQCA/ZreeoHBmmHhTB/0nh991mm752gbdaODOrUS+vvde8i7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381245; c=relaxed/simple;
	bh=+Uh8KI1OCZZEvlkL+1AhjIQSkDty5SGA75q/9mk8MS4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=NHZXqyyS6fiKYHNXc4jeWwfZEWdJgLmFZG7hEUTpW5fXAgLascMw37mARdM5sajC4xcon5ktM119aE/HqtV2axfutt1QIPAhUK6LPjBMp+ItJXkG1NePtithM4XizxIxoOZwShvhgd93e4weMDsFv7Day6a1It0xq1qsVtwC2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVmbrRF7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVmbrRF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09F61F000E9;
	Mon,  6 Jul 2026 23:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381244;
	bh=+Uh8KI1OCZZEvlkL+1AhjIQSkDty5SGA75q/9mk8MS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oVmbrRF7C8fa8Q9SmhfF/xCuKRKNlBe+HkFpcDCmCcJvBZI/IFBV6DVKsboSwH/Tw
	 dYVbIHWwT+rR/rLg/zJcetYZdjjRn/ck1zLlfaD/HVnh7nu+mSRzP/PFWQFD5nrn4B
	 3ASw5drobp92MPeG8JErYG3ykeiQAYb4M98A/ctnLazTCZJ+XRaPH+beYaoNyrTlOF
	 rDEaoqTXZ7wQf4AZrv/RXDKiu6+pFaebbPP4LbkJXuYhigS9zfxhG4xp21gcEC4tHv
	 NiigMksiXezObqXW+IKvXaJPCOsQdjZB7ZDzvK7K1LUQNFHaVo5BBje59tiYY/SbGB
	 WeW7CXEW07exQ==
Date: Mon, 06 Jul 2026 13:40:43 -1000
Message-ID: <8777fe49a17c2f70af92fd2f8b5712af@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 19/36] sched_ext: Add per-shard cap delegation for sub-schedulers
In-Reply-To: <20260706021322.72F731F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-20-tj@kernel.org> <20260706021322.72F731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:13:20 +0000, sashiko-bot wrote:
> - [High] Concurrent BPF execution can trigger a NULL pointer dereference in scx_bpf_sub_caps() during scheduler initialization.

Confirmed, fixed for v3. scx_alloc_pshards() now builds the array fully
into a local and publishes it with smp_wmb() + WRITE_ONCE(); the reader takes
it with READ_ONCE() into a local before dereferencing. This is plain
publish-ordering (message passing), not RCU - pshard lifetime is separately
covered by the sched's RCU-work teardown.
