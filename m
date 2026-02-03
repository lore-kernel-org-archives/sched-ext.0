Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024C73806DD
	for <sched-ext@lists.linux.dev>; Tue,  3 Feb 2026 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770101062; cv=none; b=HTYBQlB+3BSUmj2OZg2uEfUwHIPSR1hNlkmSpIFM5Ove55o6khB62taD5tVg1DJdtT3ABUvbRZVm0dTUOPsDujCsLdWUJx2DSCB2t0IuQEAX3XsFkig+Nygq4iOZfhEAZkfyA8gmTFUF7JAKWn4DPnbTTSc6y5RDNl25+Q0lnz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770101062; c=relaxed/simple;
	bh=xPrjfL5UwqvxmZ4Tuyb8DauipHhBBgFFs2A3jGN9xGw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZfgfF4IYNWlgoVO6doTTZS6ZvcMxyqKYsjfElEO6nG8uGUwfssH8ad6W+fEXRRIm2cLKPeBYnh9M/yovaHL+/NX16A7r4RuGoUp+82uObbuDtrOWc0IsYjsMhlCZ8g+nXL8Rsg1n3F/mFM+OvdZDUZXssjDAi2zxS/4Ggg/b5qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnsI7GJN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnsI7GJN"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f39438187so3054608b3a.2
        for <sched-ext@lists.linux.dev>; Mon, 02 Feb 2026 22:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770101056; x=1770705856; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPrjfL5UwqvxmZ4Tuyb8DauipHhBBgFFs2A3jGN9xGw=;
        b=CnsI7GJNuszcdJH0wvAyX62KPjLvHOoIJuguvaG1oka0AGnTLglNiyYs4EQcTwGs0/
         Nom5t9EIkBCcFdXQaofS/KnWUKWIxmqdUZrc4Uuh7M1BjTjai6HYsmg8YOhq7OlBxx7O
         6C5un1W2GZBP/RCadMM//bxWLLmNDL6Zl2oQCREwoJF3VeNQdinvEK2gAZHEkhj7CJKF
         dvWJHpshmlvRY/VXJz5HBh8nDPQBC39JD39vTZmfn18OeQPmgbKHeAV5HKSybOSLo7vv
         nYaWVxvL5aMC9OXSQcNA+Ph5h0b7FTKupjn1l8F+jQI3HOjIaqJLXqQgaBDRAsGtR7fd
         yLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770101056; x=1770705856;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPrjfL5UwqvxmZ4Tuyb8DauipHhBBgFFs2A3jGN9xGw=;
        b=YF+EIfKCSJgZkOvmjJbZSFDWLok5BN+khb6KRfLzrxHn7s+tDeAuC5kG/OjmNID59U
         r+FBgf7+w6FPfLYtyumYk8LD6HyqXZh13MedRHrF1W4T9KYEXmTJZGecsoEZgUF01+7o
         +fOVjZrGh3etiSJ6CDGq26VApMIHi++TUJtTaFctn1BMtXbHZIdMZQnq8yzMu6Vi3aNH
         umdDm4Srr1IDMbZdWphE3KYE/kgKC/sN6ElieluAF4+iXoJYJObGLfcvKea1+dV83Wwt
         T+h1pydYnGXaap4o62zhBuUWAQl0diYNRQia/mMWx1nqWaddwAg26kWfRFEnnsq4b7Tr
         NR3g==
X-Forwarded-Encrypted: i=1; AJvYcCXZo/WNe/DHIDLCkUs8vj4HGHk8/aK8Dc5oLtOQbq014HcHFsUIt5rCy98m6JbQ2py5iZpOkZg4UHw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyClm7olqpS/9a/MRH2uqD1nocjD9UMNMx4Y484yOZ4fLu9wbYO
	HH6DM/Z4C6IWUAGlHAKREw55psr6nKBhPSARWF7/SVp22ve4fSMJNca0
X-Gm-Gg: AZuq6aKhvdv+yshWLi49y3lsk/LEM3N5/7D9waHaWIUqMSIlhtnNkDomleyACA/9sO3
	oiKoFHT5j53yjdY25A5h97D4XMruqKTvKBg1/8/t+yrJ5mnaHaGhsrVF372WWoWqAekCOqk6Iu5
	4eldHAmQwZW/OtedfRI35CwcrsK6b2N1UjSKP3v3GiSwY+wm96LFXVP9caUUqjLubXEV+TBTsFc
	e9X9R0nFJyrJiRWTpabPC00184Gahic/roQF1veNWI0epFhHD8OsUsYoSLEjipe4E5Djy2lahnJ
	37NkCzRHWKkKagpWyYoPRk63fDx82TPup1c+M7BNfK/FRPBX6OhY3PfMzhDowURRYGPSLis6nrG
	+moLNhBGTzLquNsud09MWQF818sL8pQBZaNPPVPgrGXQsE3hPqTp3D0NoxsroZxJN9MxNgtqYCb
	lZPu0huaa2z3UP8uXrVY2LjqItcNsH
X-Received: by 2002:a05:6a00:1aca:b0:823:efa:a657 with SMTP id d2e1a72fcca58-823ab7204cdmr12952396b3a.40.1770101055740;
        Mon, 02 Feb 2026 22:44:15 -0800 (PST)
Received: from smtpclient.apple ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c64b4esm17544174b3a.69.2026.02.02.22.44.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 22:44:15 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] tools/sched_ext: Improve BPF verifier arena detection
 workaround
From: zhidao su <soolaugust@gmail.com>
In-Reply-To: <DG50UKIT01F0.13MHQV8KYVF0D@etsalapatis.com>
Date: Tue, 3 Feb 2026 14:44:00 +0800
Cc: tj@kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3AA31BB-AC18-4CD7-B3BC-9A39CF9959B9@gmail.com>
References: <20260203031954.915681-1-suzhidao@xiaomi.com>
 <DG50UKIT01F0.13MHQV8KYVF0D@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Thanks for catching this.To be honest, this change was primarily a =
result of my attempt to comb through and reorganize the code logic. I =
mistakenly thought it was applicable here and did not perform a complete =
runtime test for this specific modification.I apologize for the =
breakage. I will revert/fix this logic in the next revision to ensure =
the scheduler loads correctly.

> 2026=E5=B9=B42=E6=9C=883=E6=97=A5 11:54=EF=BC=8CEmil Tsalapatis =
<emil@etsalapatis.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> This code change is a bit of a non-sequitur =
(BPF_FEATURE_ADDR_SPACE_CAST
> is unrelated to the problem scx_arena_subprog_init solves) and causes=20=

> the scheduler to fail to load for me. Could you please explain the =
logic behind=20
> this patch? Does it work on your machine and if so could you let me =
know what
> toolchain and kernel you're using?


