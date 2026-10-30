Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398334;
	b=LoMY+Et1rQ72w0Gwb7SmmHAM1M46Ph3JUCuQwoc4hJ1/OCMIaVqfUOehYpKGkYZsoV5S
	 BjOsi2JAbbS00/N9gsdPuJyPdCIdHlXcQilUQIUaQsnH0kwH3Spuuy1/gMhOMTkKX40kH
	 9Qbff87XHfNlP/l/7M8pXu3qacxL2hWYjZI/pEm5fbJLKJcronBlOVTlGcvPxZRqmlhBn
	 rJxG4/2rZs6T0lCxi7jAFB54ZtRsvZWFDCtTcG1r0fWFKPQZQYmXU0g1fAcKR8399tYan
	 qm6OK9a8iKuG7y/73m/rqHx+qkMgfG68jhUuy14sgxo63NBXdDscgbV2D5r5e8r+huw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398334;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=0fqnYiuVG9w04sGroCCwuRT9RzYJYRDgFtzoo4gOt7s=;
	b=s7UHW5s7NHoCbKqDo/BEvER3Q3U/RrzsLbmReypPsvXmrjyx4hqqis2KH0BMsa4ooXRh
	 x1E1unfc5D8UJ2upnGd9qRGZFU6bxbW4P3OOEE9kozyJdAl8bYyu5MsqgSCsKwq6I0wpg
	 BukPLeggNP6iOAFQldGSC78QxGXwc4x0yfIOEjzKq9B0c6loQBGJfnIBoFiuX1LPjvgJe
	 HZADsxv8LqW4I2ReiZJM9cvMju21TEl+poe7aGKaN1c056NEaVeRFzBcQZ2ARXAB0HUKQ
	 Gc2tJrphDY5Wa6Hk61AKJUCDcI/5z+ESjaKjo014cjFAzFxBNkF/XYq5WWmRJDabAaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEIAxdq1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093AE606A31A;
	Fri, 30 Oct 2026 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEIAxdq1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A531F000C1;
	Fri, 30 Oct 2026 22:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793398333;
	bh=0fqnYiuVG9w04sGroCCwuRT9RzYJYRDgFtzoo4gOt7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BEIAxdq1g/8XSPoawD+yzkxUCKwTtnIvL1br3e7PlBGj5SHY2WyZCizIDv2q40NMp
	 kEnwgfN5crdbTb2jCDALqw+SiW91X/P8Pc1+qoX3/KCUDUYDxPDcXcWgyPicjEWs97
	 /gD2VhlTI88Q6n9naYUfFjl3DhuKAwcPvB4Cyqj9ca+NruL0oY4uk3sy1EJawK7TGE
	 D9hL51HLq61U+mTN188FcKdACa7EDakf8ATbyOZfUYve94g32nU1pNBUk3wETWj6IC
	 jDIP71lmngZJMygfVlo1NBDmyF8jkM6ZFVQQmaVRBQaGS/i6w5IfYZx8l3u9J1xRBX
	 ZcT6VnMwsUAuw==
Date: Fri, 30 Oct 2026 12:12:12 -1000
Message-ID: <4b3da14bdfe196fc08a74a41f70ab937@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Fix scx_bpf_dsq_reenq() kerneldoc claiming NMI calls are allowed
In-Reply-To: <20261029235251.3235814-1-tj@kernel.org>
References: <20261029235251.3235814-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Applied to sched_ext/for-7.4-fixes with the following tags added:

  Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
