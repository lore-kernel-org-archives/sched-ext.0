Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D72D3EFD13
	for <sched-ext@lists.linux.dev>; Wed, 27 May 2026 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906411; cv=none; b=CN350YT9v7INzpAoDtMaoP0zQglD+Yh5N4HLSE3j6fNYC4WF3aJDqcriT5qTxv8x+8hOtJiZG1w9Z8eYO0Y2STfRPMpFPbh/jao0DtsuDSGmMnfWPEsBUqmzGSBMrVbG+8i6AnKrTgx4I94vTMR1J6ZRUH0585SuwCq6O/YiYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906411; c=relaxed/simple;
	bh=Q2kZqV8x2OwxLuRiPFb2qiRw7sD2R6T08ZV05z0oupM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=gJwBxR4OsgnSBo3791Uhlja/K7hJAFRu9rqknJ2suAkJQzNQns6XrEJIajEgCYIkt5VK7d31QEDw0NjCvmpQc/PMeHI4YNXSjqspe2wl1yyrnWzMfc9hmRvTYgFj+K0EtHqho0HMl0b8IyQNzlznTCMyjRhM+/xNEH2Ir/Oojgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWxTkRra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWxTkRra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABC01F00A3E;
	Wed, 27 May 2026 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779906410;
	bh=6pfLGm7nAfiVyjMzkSRM7uRXwnSBngTqKtnbxCXLoO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nWxTkRravIuTaQWR84vWMRvcS//ysKvhfemPc+S2GXYH0Q5fUMUgx2DFlglzBy7Ig
	 79uqKkTRA+Oc4ohJNKXeH4E4DECpCwFk+fSuS97seaMF4yRsQW3DDmuoDblYVDVPCJ
	 f5vbpMr9emF5tJ7n2ApJ7jKWJiMyn0WOiFoUTdwPwh9xXLZwRSrxsqfpMGnZDr+HvK
	 3qNIiJWMiPTpmFMqxQx++kDbzpKaJAiMdQAMPgfFUQTSsCcbN50NfZMAjm23zqneyy
	 8lhBJ+4tWVZNoMKfm6BtRpnfVw4a/PWYx9H+nxwaESYNrIM/rfcrc5/NFlzxiTlRBa
	 xnp9MBIunv3Hw==
Date: Wed, 27 May 2026 08:26:49 -1000
Message-ID: <c433d3c2e99227deb1af0138fe503330@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: idle: Fix errno
 loss in scx_idle_init()
In-Reply-To: <20260525172315.156381-1-yphbchou0911@gmail.com>
References: <20260525172315.156381-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Tue, May 26, 2026 at 01:22:31AM +0800, Cheng-Yang Chou wrote:
> || is a boolean operator, any nonzero (error) return short-circuits
> to 1 rather than the actual errno. The caller in scx_init() logs and
> propagates this value, so the wrong code reaches upper layers.

Applied to sched_ext/for-7.2.

Thanks.

-- 
tejun
