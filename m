Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398335;
	b=z70xyGyskBu5nqP2OyyvDSL5NxGqA03OuoRCEiKkVJZ9ZKFhgTPCKZQOUs5/TuPiQgti
	 ZwUidbS5obKrbm9mhm9293Bam3fOobPQHCYMq3+0VujPU3TpoDXGV7ayLkh/8r3Xd4ThT
	 e5r1sd2Eo/s2CwWl/XgOUy6y+pkKMYiYqoZqM6eyx+2Bbkgt/7UbsgpYARlSdiRtpmR/4
	 6GKwj/+iSZB/sY60VnzQQxDx4QGNSc8rzV3XyhatT/hGimUyB+Asw8jHm4aLQ2Wpq75jc
	 waG1dDCiYoFkRClfini3yd+hJHC4q5UHBV2OI49NglOKY4VYSRHN+o8lNeTsRzbGBzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398335;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=kzCCSxGqIOflYF/5kOzEFXx9NL4cCf/soNclBud8pGk=;
	b=YJYzxVciSw9dC5I04vLSp/TwUrUfn5JnWd6przSFWjAVpqhFlCQK4Zv6i0hELsI6LctE
	 AgCJf0SeENNdsFMz+YELYjh7m27ZPAB2B7M2fktpzOH7VJM94weNhjlZK8+pAA6EZm4x/
	 EN0tCgg1u/VXvJZPCUpKVT2Gc7xr35bVGdJ75tVUIfqy/MZXRNphN9nyXEjtMjNb/qThx
	 P3ZDxxRY2zVAboq0mUyGaOC8en0Fwg3jlySBP3iMRdvxn4/qYXWUhUUs/07dIoZEScsD8
	 BqtDZkXEKACrlqoxeEIi5igaPfVX7LCressRTTDCDXF7OUDYCZzSne1qxvHR1KzK73w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqSGe9Wq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC82606A327;
	Fri, 30 Oct 2026 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqSGe9Wq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869F11F000C1;
	Fri, 30 Oct 2026 22:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793398334;
	bh=kzCCSxGqIOflYF/5kOzEFXx9NL4cCf/soNclBud8pGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cqSGe9Wq9FwhfS7B56qQcTJWIq4chYZAVO+/gFuqBB1bJ1io+VyxijrGqopEId8mb
	 3QPwSmbpbXpzBvVktIj5orWxD2KeOh8eTMzTR6suk7CJr/dkiImwDJOU4PVysX5+6E
	 jfcP+c1ef1TKxJMfyXq7tSPowWy/y+kNwKTAKu3PAjClCysjjTI4dLI3vJNO9sk21g
	 UPaknYKlgY7Izafx9VP/Vb6hW6xn/mlLclRuVipUW+9Rab0ryV2tl/Bh0Pl+nWtzQu
	 CRQwhm0q2/rs/Z0YSxvOGzJeAzi0TL+DhtglGRjrK8DXDRJbiP1iKu/Ykkmp6EnAS4
	 O4mgLuX/YAOsg==
Date: Fri, 30 Oct 2026 12:12:13 -1000
Message-ID: <4901eb825b71d347ac6d94e13afd49f7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Call ops.sub_attach() only while the cgroup is online
In-Reply-To: <20261029222859.3099324-1-tj@kernel.org>
References: <20261029222859.3099324-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Applied to sched_ext/for-7.4-fixes with the following tags added:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
