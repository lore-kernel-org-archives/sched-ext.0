Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123067;
	b=n28jL2SaftN7OCGnbwBfUrWY28X2u67DeQrk95UR7lpmJg6Fvci0CgsrtaUCmeeM3xzz
	 ntP32GnG8F+CcxO+1ATCVn2FYqKu/vSdkLdR1ZfqLW1eiC9/8no/LbrsczjYRVKiXEZYw
	 pxNK8BMR213WIRy4qYuTwnFWkQbQONyhBW9a/GzSSlC4TCitEQ14zxvYIt7z3nRthxcs2
	 vqB4/bVF/xLHIO0LPfGhghD0Ytr/gn3pZjyR4u6SQjqqIraO/j2oTnLa06Olb+9iWjF9S
	 7XNFo9aL5GICtRHx00872HFerowcuW0tmONTGwW1nFtsNBV/EjxufHNAVuWrVvRuWKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123067;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	b=YK4/dUFT8pRYLJxDFOwB1bUF7J6yQm6HUkaf6qZQSHwivLvm1vEWvEBVKfOGKrp6XUsb
	 7b3oFOV9c3bL7YwdcqIzzmia7tASjXJ0Q+vpu1qUhASCsVaiEy0JVVefWz8KtPNj2Du4O
	 LpjVVPa5dnvkJ2c5L0tD5r9eVViW0fg39xYHN3WB9HS9V0Vx0w4yALCcJXMVPHtVmyr5t
	 q0JrERO0IylC5KT8C893hQrVpgOuI0YJNxkno9KhZeGkTSd6PvA6o5D7+seT8Ce6kMds8
	 ZnnKV3u6vqSA8vvqUseyGE2TJH0CX34uoxECgYCIh2GMsM6cAed0BswB5Z89AuGajrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCB2ggcU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F27606A31A;
	Tue, 27 Oct 2026 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCB2ggcU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C6D1F01825;
	Tue, 27 Oct 2026 17:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793123066;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TCB2ggcUiThJpY+hhLksN7S5fIKEvuo9PkKmfHpc3pCHg0WF/vACF2hpCjyUcwurM
	 k/D6ZpOKdUs+oA7D1PrXQM82oHC8N+1Q+M2IL4MWp7xzBdPogKcfC+KcskguITI9uE
	 Rpvsznk5+QbOrniY/iy0BV7OB0syd6jk1RrMnBA4DlQ6gulMHl657MGYdt67ms3pGF
	 ii9kClsGux4DQ34uI9zIW2qHwTg4zgbPg3HRO8i6rtXxGBT1s1eiL19O42H0FGdrGw
	 4Pud3547cP7nBp4z5gOghljBe1+6njjEF5PwMIoENDHkU2c8pr1S54mRKMwqLm5OxM
	 aG49vPwduFe4A==
Date: Tue, 27 Oct 2026 07:44:25 -1000
Message-ID: <93034786192f36a7fbc5b0fb9b587479@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Junbin Zhang <sprooc69@gmail.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Reject rq-lock-taking kfuncs in tracing programs
In-Reply-To: <20261027051634.2009082-1-sprooc69@gmail.com>
References: <20261027051634.2009082-1-sprooc69@gmail.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Applied to sched_ext/for-7.4-fixes.

Thanks.

--
tejun
