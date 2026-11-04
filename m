Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823691;
	b=RZib46uDSfTgj0iGhFL7HCtdnTusP4XWV+IJx8RyyFlCOXyUzPfwLERgR6rBTXsjuZ2A
	 HjD9guizceSg5vIk9zjocmiCokV8alKnMNIck5NuQ0wS49tGOfK1e7rqljPZNc7jIej+l
	 PCMf1HJg18OPKP9bBq4c3MZjwvMYZXRP65e8jH8RTwQC0yMwAJfOWnKb/TQ0bBq8W5pDV
	 crCvsgWMMGFln+mJLDRthoRKxNce+tYwzV+zAFbsZR5T8f+k46WOs9Whi7ktpFzuYvDEU
	 X2kCyFVdiPlUhPBKLNwkHG4PKdmjiKnVx7r9eWhloIolGOCMq0LwY9je2SThbYWBXhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=+1YoVC5AL6mwQdUlymRFFKElBBXM5Kk1X54PH2hsQCU=;
	b=BCH6PZyM1U08jDza6trp+KBPAlBiQCNNkEovwZgMbEId5rodz8n3/U9lWMlCsutWwUGK
	 ngtJgEKLPCUevRWwdfOna5yx85UgHbRRBlbSzENG5lpwnF7rdjxDWfIRsVaAPTVB1pPlL
	 X9OtfbSv2J4tZTujpSMG7eCTdh4izrxvn2NUB2UKMQfxrGmrB6ifJ4xwnqy1dCTqFaTtV
	 +wRl1LBXK5ZDydMo/uugnlkDFy51gc2MQcjbh3XltYljSiKKeBjAI+/k6bowj6QZRdg6a
	 XxZpKg1NR+39s5MlhiDwUQne3jvLJaGFW8KykKheC6n+fzWluboLtXbecHYdyqH6fHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtoradnan.com;
	spf=pass smtp.mailfrom=realtoradnan.com;
	dkim=pass header.d=realtoradnan.com header.i=@realtoradnan.com header.a=rsa-sha256 header.s=google header.b=bafoBO4Y;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA986070418
	for <sched-ext@lists.linux.dev>; Wed,  4 Nov 2026 20:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAA986070418
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=realtoradnan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtoradnan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtoradnan.com header.i=@realtoradnan.com header.a=rsa-sha256 header.s=google header.b=bafoBO4Y
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93cc1ab5f6cso127203485a.0
        for <sched-ext@lists.linux.dev>; Wed, 04 Nov 2026 12:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtoradnan.com; s=google; t=1793823690; x=1794428490; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+1YoVC5AL6mwQdUlymRFFKElBBXM5Kk1X54PH2hsQCU=;
        b=bafoBO4Y+jUXFKSDRMCiCIrN4yZvgYuHgroqSTAOJGfyFbXRsskXNiSY1dxOsL1Bv2
         PNby7NQEl4vA9ZKyhL4VOS61iv1lmcoWQauB0d3HWXL3TBSIxsNNwoDgJ9WxoGL+Z2DI
         JwrqS4zW7RnINosqisucy1FJKvwTUne8LSb6GLTymu2uAYNhsxm1s6YG8F0mOtu2/BkA
         yuvzaYk1mFx5A7CbsnmVJ/B6uEFXkvktsKoT9jtI9PUw4xLX2UmhJkXCXW/MhJrkNOSB
         9pGWdqVFKGoPKMuGYMD/v1N9iQlRfs6uQNIrRtloZxtqeJgweB7QKKEh+nMHZwWBMawi
         zX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823690; x=1794428490;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1YoVC5AL6mwQdUlymRFFKElBBXM5Kk1X54PH2hsQCU=;
        b=K3omhs4ke2Wa3jQB46+oFWFO6Z044Dk0wz89vmofnWQwGM/+5HXCdC3VHrE5zJpZj3
         yDOgrbZbxxC0u9I3BEJit00enkd9rFddLSTLW7jd5eSUVvqPL+3F2N1v3+y4dYoNNQFq
         YbItXde+RvmR4afklV6mmcrvIpuBeyzDngsg8YpK/vNCaBr/zHvCmupW7PYXjJLGOyL2
         WvKyFfU0z4dYPLtskvJ284+yZvxw8lUNOr4HMbeNq9WNP3CWmezcML1C4elAbm6FZ0vz
         XnPDhdTbiutKBxxiNV7DIFJKNTeUoSfSNcsV3Wjzv/bW1RNqknzFsBYWIBeImbErNtJ2
         S73w==
X-Gm-Message-State: APuU4Z9CZZ2PbWt6uj9uQn2EgEQ2jG/zirNAyJrLE2QQjuJQgi5twMm7
	Hxh72WSWI8CbgMZVz+CUktBtszejtnWQQex+dzs1oRsEeEJx2HIcvwPsnVvtfIDW5q1w1ZBw/pP
	WuXHeTfYNROA=
X-Gm-Gg: AYBFou3sFoNC3gRQBjzo7gc31omleXZ2e7zxVxlL8JpN/NrlnLdm6BNZbN95i6bifSW
	ftM8bm6/QfB57OsBYjF7C6V9gKfho9YtooQUZILwQNAi0qnrn/KF5WeDOHrdexaoW/T3z655+uF
	tmIKDl1JiQ5BtoRs1BFp4slkYtEg+PuMW/IRTkLp9k5XBabOSrwF/+1civRuxKLNaJu4NZ7QXWT
	atlmuKBFh0nVFDrKWlq5lfuAl4wsJWlwiwnC2yGxOyd1meuJ0cbKrQYOcXeVghq0r+16EWUYM19
	VkQwqNeDMJxYCLOUQ6a8KCw5m6FfJqtoNwqdkEptwbYZvkuuKwdR+zG8nz90VGCTb73YxV9RBJN
	T7C9UwsirX1r/jF3o2EQXtVR0h7NC5x72SWTSsxZwIZAPDigi2BXLAH/j4DIAlrAmkEAlWGpI26
	S23R46bnXg8UuR+iFrR6s2inAuatKJ0DH+mgLSGAuZqS+uIlHbktVDkG2ksAwTNFKEVToG4zkWB
	ZS7CJS/8Mw/sDtbSY5J3mlFB62aT2Z8M9mtGVDihykBx43Ootk/M1KlbFeywqPX8Mc0KqAurHVC
	6b72evJ327iMqTf+NGlLcED7N3fABnUQrXS8pyw3YWrf7xMTLS9DG1FKl3jtRUCki5bKDT+5fOk
	HfJD0L/K99Vw=
X-Received: by 2002:a05:620a:4413:b0:943:faab:a149 with SMTP id af79cd13be357-94421700a82mr2948988885a.63.1793823689768;
        Wed, 04 Nov 2026 12:21:29 -0800 (PST)
Received: from realtoradnan.com (vmi3719414.contaboserver.net. [80.190.73.126])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d482eb96sm289099985a.23.2026.11.04.12.21.29
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:21:29 -0800 (PST)
From: Troy Cross <troy@realtoradnan.com>
To: sched-ext@lists.linux.dev
Reply-To: Troy Cross <troy@realtoradnan.com>
In-Reply-To: <2f393418-7255-4743-b185-248dbce5c845@realtoradnan.com>
References: <2f393418-7255-4743-b185-248dbce5c845@realtoradnan.com>
Subject: RE: schedkit
Message-ID: <65c5db2e-bdd8-4266-b975-f786b8a8415d@realtoradnan.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:21:29 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Sorry, just making sure you saw this.



On Mon, Nov 2, 2026 at 06:16 PM =
UTC Troy Cross <troy@realtoradnan.com> wrote:

> Greetings,
>=20
>=20
> Do you have any interest in=C2=A0schedkit .com for 500 usd? i noticed you=
 own=C2=A0.io version, so maybe you will be interested in this one as well.
>=20
>=20
> Sincerely,
>=20
>=20
> Troy
