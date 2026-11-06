Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990925;
	b=KxOcneuv7BNDISmzXe8u+Q9s8VYvkwGNYU6Uky8Gc1fhn13Uu2UStu9itftyIix+Dm69
	 M7KsEYS3jJCEDseGdg3OW9NjQT5CEe6hSUzvMHiYZVdcCR82clXEG+BUHG/BfjRm3b1RJ
	 B3/zYneGQoZzAUYr5GtgVoEBfivuLCNx+H6hdTIhY0KOCiY45/SGqq7AkaF/w/snVjC99
	 r5MKQktCkQy1NSejNeZA3nQJLnmMHzY+qqEtQ8vi5483VE5wO97WSXafZ3h23Fl21muJw
	 N6tdxO2m/KJsfJV7IIGJGb1neh7Fkhj2CKPgTZNgiHVeJX/IErG4d2rNUzrgW1Gv3IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990925;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FYah2t2N3a3eOWWExaca0/JbpChilT/7eRA9w9v9nhg=;
	b=5LKvSMrUfkJtobIEbfCtAkP5KulevRivjz9PLu5x2+nQpN1wCXI2Zcz4lekSSRA1Zhl9
	 oLCSfhqBgRsLuS4o4DTTrVDWD5W1mi1330R/bj3vObdRA4UUqbetQ56m0ulpPeBHc4EH1
	 6zFHNpXmTItYBO43VGJvM5h/PNwNBxnn+0LB0T2baYz9c7nothXQgtbIPEV1zxzG4n4Nk
	 SSEEO7JgJc/QWF9ypM7nlbNXliNxbv4+z2o0G3PV+Toc8Ge4NGIdFUg6Y+7CgO3k+SZ8T
	 jT1bka1EWPt83rjYEQTQj3VeKjCm50Pp34WETftpi4C1ja5xYTRYkCxT7OvOKlPonxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ljn3zH3q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB149606A334
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ljn3zH3q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5519B1F008A1;
	Fri,  6 Nov 2026 18:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990924;
	bh=FYah2t2N3a3eOWWExaca0/JbpChilT/7eRA9w9v9nhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ljn3zH3qOCduP0LutBCPBj4N7NrnkAOw6bhfMkI2bDkRrcKFzZIz60MdnGVSBbj2B
	 hwsvEL/fwY8p5B3NYcyPCqgHrHY9zqmzh1zsTHNp4AnsEvBFwgLBe61jaenJbZJqdJ
	 Ne1Rv657wdXBIKb+0i0AYldRLwKrHZWkMGrQ6m+proXlFNxiWONfEh0X/aAS/dqvgS
	 rC8moAmV1XRcBPIU/Tt7gJgi2U/k8wXda9yTS3viYVujpcUoCNAuQW5DcCqnq+xuK1
	 HZ9exEfoRvaD2H8hiyJjxqtS9vrSrVHMOXZWL5XNhX4xxfvN7FS58xgJQ1+Nf4S4aW
	 8aVfCQ31+ppIg==
Date: Fri, 06 Nov 2026 08:48:43 -1000
Message-ID: <8b54675a18fdf659a1c913784d5a27e9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Hui Tang <tanghui20@huawei.com>
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Fix partial-SMT core counting in calc_shard_layout()
In-Reply-To: <1eac08a9-b5e9-b353-b9d1-1e2d32802993@huawei.com>
References: <1eac08a9-b5e9-b353-b9d1-1e2d32802993@huawei.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Qiao.

On Fri, Nov 06, 2026 at 10:44:30AM +0800, Zhang Qiao wrote:
> A core is counted when its cpu is the first cpu of
> topology_sibling_cpumask(), which includes offline cpus. When the

AFAICS topology_sibling_cpumask() includes offline cpus only on mips and
sparc64. x86, arm64, riscv, powerpc, loongarch and s390 clear an offlined
cpu from its siblings' masks. Which arch did you hit this on?

> +		/* the low-numbered siblings may be offline */
> +		if (cpumask_first_and(topology_sibling_cpumask(cpu),
> +				      llc_cpus) == cpu)

The comment describes one scenario rather than what the test does, which
isn't very useful. Can you state the rule instead? e.g.

  /*
   * scx_cid_init() forms each core from the siblings in
   * @llc_cpus. The sibling mask may include cpus outside
   * @llc_cpus, so count a core at its first sibling in @llc_cpus.
   */

The fix looks right, but the patch is whitespace damaged and doesn't
apply. Can you send v2 with git send-email?

Thanks.

--
tejun
