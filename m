Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA9531987D;
	Wed,  8 Jul 2026 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537773; cv=none; b=qpLOc/y9NoZxJjtsscDaMm5NWD2z5nsGN7u+WDVWCwUTIvJ0I2tgM8wHa+8Hod03hYwr6+40drG5fvLqJ3/mylg4lobARJVfaAJB6oCfNvz8OqqEt90tPsWLREtS6UAK8AA8E2NQjc1MskSbZqWSeoUor95PeTQAi3GWxqH+SyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537773; c=relaxed/simple;
	bh=8mHKBfBDcO7Nr4zMEMWMTaoYsNCrxh1ztabBZN2GaVg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=EZ3vVVKWTru3DxwSynokLKJ67WyZ5Xv1jQFR3XO0A54Omw6h/MOmFDDjlSg0+rCJEjlruOe1GWqD70Z/e5ubfoi0VcmG6Xnj5MjRbGeREyEZPpnue7Qh9r7tBUfN8Omle3UhHHWQzU8Y4WOBhSXWRxDFf+JqTnRmDmARC09QZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=depiG6y5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="depiG6y5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30151F000E9;
	Wed,  8 Jul 2026 19:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537772;
	bh=/3Vd8+rFeGYq8Gzi01t453CItw8iv1qC290+eHRvKJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=depiG6y5tBCSVc6z0a2ZtA10ymUlcMz9D3xxWLIkqAG9vRcVXWj9B2dZxqjZcrA3u
	 prrOtkN6EL1l2DEJZ3m2V1RsWQVRSJ6uc61ytzSzI8T53XeYanUZ0RijmkjPrBY33t
	 BkR78xeGciLnKT0vL2ALvONGW3oLfDIHr4E+XocZpJF6JwFeSlTThdcmTt0iMrjZkv
	 MP87KIXkRwrYzxeV1Xdsey6s0ppFvco/zqMVJXN3JWdvLzAsgsM7ii4+o/ZcAabRvz
	 aIBcUnG1Nm5kY1xZ1/fNMQtrD/jLYX+ljatfuG5m9KN0gka+8A5bCxEoQJli7JF2cl
	 agWqw+YDIIhmg==
Date: Wed, 08 Jul 2026 09:09:31 -1000
Message-ID: <ad593e9b3c1faf7090387d74fb9d37b2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 10/36] sched_ext: Add ops.init_cids() to finalize the cid layout before init
In-Reply-To: <20260707003622.F22591F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-11-tj@kernel.org> <20260707003622.F22591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:36:22 +0000, sashiko-bot@kernel.org wrote:
> - [Medium] Inconsistent ops.init() execution order and silent ignoring of ops.init_cids() for sub-schedulers.

init_cids() is root-only by design: the cid layout is global and
sub-schedulers inherit it, so a sub has nothing to initialize. The
init-order difference has no reader during sub-sched init. No change.

Thanks.

-- 
tejun
