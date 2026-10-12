Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E13793A8
	for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812443; cv=none; b=i/Mq6350z4x4Ln1y2amYR5VlwvxyCQBKGy/tt2msVKBzMSq4W6yw/PlQNOnqvcvfMsUmLJ3b7pSBhB4RpBoXXXTy+RJiz13OH3HFLaHWOyti9VUoq0HjU4a3WOvUGazWsSyEw9+sn2+permAWAtpg0hBQ/8ga3i25R7OPvOzyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812443; c=relaxed/simple;
	bh=BW1wpLoYKk2pIV/zuM1YKBU+Jk4slTJCsg2kUbro9Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnjPlsy7WScE8OK4GEDekE5v6no4uahRQrkBKWxlAcRBSYMIsm+TODx+V/LEyhPXOzqIMjkiyf9fiBe7yTyx7wFFxwgqHcrNCEtd3te8045Cb+u/JE/xpSC3ix6Y1YThoQjXjn9jl2pwLUKRSDYTBFzUxv2WzVAR94V1ljHngjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp3lEUoc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp3lEUoc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a17ce1dc00so3496325e9.1
        for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 06:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812440; x=1792417240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BW1wpLoYKk2pIV/zuM1YKBU+Jk4slTJCsg2kUbro9Nw=;
        b=Zp3lEUochAWIWz8hCnVCbZTCGOKEXRSTls+8z9PlCgXnV2L7QpPC8geCgJVSKtbieQ
         LAGJapm1mVWXL9vyHZwV/2SGaDRaRjAGB8DISvjV70jsu/KeZG5iR2+hLSC9Sv6QFI6L
         ZUFWSepOXngvanpYPeeQjUPra6mdQ30nPiqq0fVx0w1lqaTv1QEZQibr2/lO34VIt7q4
         pO4SaSko7ML60WKFvfgd6oG4HiRe9Sa4dqSMgtny+49uyMFXYdUsacSTOCubuWt+1TBD
         1V9EfcGUSVwcH5Rxy73yUetndQkcZ9PYfpXkhwggqido8I6QKvn0P5GqR7xeiChbyUn2
         pZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812440; x=1792417240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BW1wpLoYKk2pIV/zuM1YKBU+Jk4slTJCsg2kUbro9Nw=;
        b=ZOc/0/6dpHsJ4DL0qDf333V/KIpcc85SlSXMaf3CMZfF9MS7U7xfbw50NHfqLlWhbN
         aSJBwK0IKk3PYMctXl0885zP2JASauLco4IqeT90UZeSK1Czj4pxc2yMPF2x9zkNAQrb
         oy0gI87BiTymJ3vSfc4v0Urkpt5NXdtXP7WThWBn/s14W16VQlXlTeBTfBGA76BwShas
         /FOaFbDJ5amW9XzIprhpeIblfgOykAMCFZ6ycrrU+ovGFQWvfZCa5nWI9TdeCIfVWzxZ
         67NRn8YlC+L5X2PJiNzvmUT0VUEsmnouBCp2aFrc3R8efP8vMJX39TxaHMmhVwIkibr3
         gunQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5akBck7SniN748YQZij7ejM7b1Vj09dgfGNJLjNLzZic0HdRBENEsW/bkA6/uA1ikRjUXtX3S9uY=@lists.linux.dev
X-Gm-Message-State: AFq9FYKAsnVxYYd98LnTJrtr3RpQGkiUO/RblDnxxTLlf9uq1ocDkVvm
	axcnBY6c2DxJhvR1XzrG22qasgMwJvPM1pCOReq5X4P8avVmXhxE/tcL
X-Gm-Gg: AYBFou3vllKwhahSKD4P8Qf2fkrWTDpQ+CIvXTKYND4QEkK8GT7hrN/JqO9sVxxMX9O
	ombEpcJYxYd9teUXqli841nN402U/jm67KG9uaKXe5Ddej8pmqJfn0IW4gOlBrEd17sz/BN7n/5
	tXpieC0zLO2i2wrZ0b23lPHTTAu0hsZ/Jiwv/d9pGCQTEkwOAvPPyNuymTzucFM14iESCl4Zzj7
	Pf3jTRkGbFBKLbJztXpmIkDk1z33r9b2TzjOtKq1n2BOFbbwEZolDSE/5iGBHMZDG6nAv9H6Up7
	yhwp1b+/uVoge+2Ruzow6gCuH1N/w5SbT10vLmffDGLV7RS9XtMosKo/4mXh5TlLl4vJxCqjOe1
	fRztqxHd6UJ0i/gpUmgkTiloa9LfdJJ7Tk064yl9q/r1BA+foG22u/0tOa+JnTYklVFFGErkPmn
	mjJSySsXe1b1tcR+8zBUQ2jJPkDm761IPPlERajnettY8ROedEU97mGi1pKDN2VXtI3iBY7UAJB
	GIN28Ae6/804MITCLU9ubUD9tXoZLtv
X-Received: by 2002:a05:600c:6285:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4a18e4760demr178450175e9.1.1791812440060;
        Mon, 12 Oct 2026 06:40:40 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a199e5db12sm170767905e9.2.2026.10.12.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:40:39 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: vincent.guittot@linaro.org
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kayracizmeci@gmail.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qyousef@layalina.io,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	sshegde@linux.ibm.com,
	tj@kernel.org,
	void@manifault.com,
	vschneid@redhat.com
Subject: Re: [PATCH 10/18 v2] sched/fair: Add force push task mechanism for fair
Date: Mon, 12 Oct 2026 16:40:35 +0300
Message-ID: <20261012134035.2757-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAKfTPtBDcfk+TEEjD07RBLpCAusKqa0K4AWuFrcCtdw9uGsXCQ@mail.gmail.com>
References: <CAKfTPtBDcfk+TEEjD07RBLpCAusKqa0K4AWuFrcCtdw9uGsXCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The push mecanism part is generic and includes a push on put prev and
> a push on tick when the task is alone and never put back in the
> runnable list. For short slice tasks, we don't use the push on tick as
> there is no reason to push a short slice task that is alone on the
> cpu. The push on tick will be useful for other cases like misfit task,
> EAS and cache aware. The latters are not part of this patch

Thanks for clarifying!

Kayra
