Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0703F25393B
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047545; cv=none; b=tr8Ld63Ijpn+FbaltFEsxWtgq+apDm0yEvKkvoDanHPX8vNYIvZvOQNf1n0CXLi2XyfQ8NQT210hv26XRxcMRUJKfFNImfIHgtaV2VANNG3x/yTU0CmaT3+jPOwTS59o4KE3+8VYUj3KbUNLKhLdVMBOYCvlGOEdPfi2EbdBiVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047545; c=relaxed/simple;
	bh=zDr3lQbxR1KhtYobfofQeY6BhYMWGHAI5Kk5bM3oz7M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=HrX9stLzmdIwAS/iDugkjYWYXknnpo1iU4oZ04i9Gnq55wMnC4pqe18sB9/RiVKe4P5yoE8dsdmlkEAp490R8x+5+P3DtK3s8zufnshlXBVdHLR9P39QjZNV2mJa/VnaO7IUZiGML4m0BVMrr7GHqhPYbxyP1udQYXShxZxgqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjnjNiRe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjnjNiRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89752C116C6;
	Mon,  2 Feb 2026 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770047544;
	bh=zDr3lQbxR1KhtYobfofQeY6BhYMWGHAI5Kk5bM3oz7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tjnjNiRelS7K6DVpJRm5SgRX0wq8RPnLkjmxQc7xtDWtwt9m/ZUlNykqw2IIaocAv
	 eJTqyx6Pru5F9yitJtUUJ8y8tQQDKyEf0vZOyjd5Y39JjFHkA1fq7anaFqham3HGvp
	 bgAFgvGIDS2GUeIAzTIJgpNiuoSw4Fj02cTVJTo9cWy4A7smY6xLDRBSlvpTh07T6l
	 Coj+6T1LpC/3WoSj21WDMPtY6/hZrSc3KUCfuGptRfgy/4xHfRWqGbzlRknTFJ0ecZ
	 zqQreAJvi9eEV5HZEOB4ngiaANMy/Imm+iiCPJJWZHkmiFl9Pimw93nVfbHwK0IHYu
	 3FvlkzaXuKNeA==
Date: Mon, 02 Feb 2026 05:52:23 -1000
Message-ID: <603161684c98d5d8e23a3aab89f295f7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com
Subject: Re: [PATCH] tools/sched_ext: Fix data header access during free in
 scx_sdt
In-Reply-To: <20260202004208.42364-1-emil@etsalapatis.com>
References: <20260202004208.42364-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.20 with the following modification:

  Fixes: f0262b102c7 ("tools/sched_ext: add scx_pair scheduler")
->
  Fixes: 36929ebd17ae ("tools/sched_ext: add arena based scheduler")

Thanks.

--
tejun
