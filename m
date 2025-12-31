Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAB22BCF45
	for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201848; cv=none; b=A29uT5CVUvWMah+JRJyNixsh3lDqZ2cIrb7UWxq8AubFcWVcBonyLYJh6hlUUVvJOABs/MeWwxPicx19ZfHMFBOB+d5CAgD300IPtXppeHS26pSf2DA2LlVAoWHHcf5d4C0OQLJliSn1bxJ0iA9u7M2+AWFlk0qTG+hHPkh7SVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201848; c=relaxed/simple;
	bh=T8Y8ubirw01g5zFTgijalKE+TvYZvn9mJqyF6t4G8Q0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=pR7BlTeD+3PkwHQ12SpVy/DizTNRVgTK95dhtlGVZenG5Fu0KH/JewWKkbsxFBfmrXoIm9urUffys0ue2UhieHzkrcWj0Ol5ytkC6FjIYUMu7Kuwxoy25EaocUVtGMagIFhlSjrRRTo0EKY1kuOYSFl+xRbFyI3aRUNoEWrDmKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcjrNP5d; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcjrNP5d"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so84210035e9.1
        for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 09:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767201845; x=1767806645; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R87JjGL/7Tv48x8Fv9GR/wm2jySKUeW5S5Ujq2orAxo=;
        b=YcjrNP5d2ZmdSIOJ3ZWOw+TC/1NhTyxtGVXadsWcf3CG6Ud8Muc3WWBepUtYHJ9BOI
         tYxyuMjIlKfk2J9eB6H1LV+aHh/McVPDqe3CZ4DRTKyE1HH8QkPCW//YVOsDJ5xFZAdo
         /Tq52iPuvJm/ZLja6wiFPIvxuLnn1j8k11cbQcDuCEZ/PSBicznfshS0ldVzaGVmA4Bo
         rW940eG9gmfOLAQq9IWVAZEhw6Mdgp10rxrtO/KT+RDWz/6n/IuulDLOdSpx6U6oP45g
         e5U+kYcydYP4j94iZJv4SXuxD6e1ZpdVMHZIyswiQvqgAkJ0b9/dlSnhhbiAt4X57iBT
         hawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767201845; x=1767806645;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R87JjGL/7Tv48x8Fv9GR/wm2jySKUeW5S5Ujq2orAxo=;
        b=Dke86deiARSnprnCOfsEEJ+9/0jYKgHG8+HJXWR5j5b7Sb3MP5aWcie+yCaLQ4xiV9
         pUa2ptIPDTn1JHk6dh5O3pRPn3Ynx0YDUAEWe6KCCo9ot+ZBEgde+Q8dNeKFSa7Nsm0z
         ZmjvmjgwkpEL0w/6jF5bOzZNm37k5nNAUu/8Kh4wwZXV9ahwVO5leY0PXDhogF5Rw0Sx
         PVmXkEB6Tmw9ju6shoe49ZeZHCO4h1gxkqH6i52LWAvIMgF6x2g+jprm/9equ4CiMUTh
         Hm8h5xdWLe+mf82+0Eq8vV3DWNjlhhqHAl4K1PieWM6rw7aJsG95i/MfFyI0vWtvfETy
         cKfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWP4MAysaQyEwQwkGd3PA/5pfTkRKgm0xBOWzv10bOLf97BxnBwhkDXKWWnQ2SrGgXb4BnGIbqyyY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwW32WJK7r7v5FDj6jixF8AYkzecXzs9mqmVyiPCg1uzf1GAucH
	28QZhFRFhKj8Af5LoVTjnXhIB32n3gucIzckR83BK/ABtAMOZFEwkvCv
X-Gm-Gg: AY/fxX7wu8UKIvR1KOM4NcP4PZWP11LgkHnxWdZgsxKwU/5gpO1ojUzmaoGfVTjSifp
	bY+R9rQ7q83oRQj+WTG/mTvLWO6wLaVl6RxZbWOhIJvB/ELyMisa7QxqCnlnfv+gYNs3xJeNHor
	9PJLWDY++GVxgxETT3+B5XtwdSUqCZgjNDB8YR90Y0nyIV+OaISq37vdftMfPdRcQTujob0dCQV
	bBKwHhB6J4esUtAQP71P1L2w/q3z5gmOU4SJRvlXUmO3BXu3L7Ybh/Ng74EYzPSB8PCsdJGfrRG
	YHgfriykDvHN0u7GsSz9B5n0Pe4b7Enn0pLZezELSDYUHyPN/6Ma/NL98htRb1kpVlNoe5nIIvQ
	5w4hoQae4BL0N9KBLtuxiewlP4WPV0YZbdkZKs3eXjj4lkmON2QqnwExribi8wWJC6irBRJKY8u
	o3IcGY5PHLfCwLsPxHsbpN4IccBupnaasS
X-Google-Smtp-Source: AGHT+IFdVUAusCYbhXtGHx5jk/mS7YxbHvH2ZdgmHlBVw+Es8g6zXJWrYIKrmmgwqUnSvZCNAmfSKA==
X-Received: by 2002:a05:600c:1912:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-47d1959f714mr510979675e9.31.1767201845337;
        Wed, 31 Dec 2025 09:24:05 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:2944:18df:f54a:f00])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm75005716f8f.1.2025.12.31.09.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:24:04 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 6.19 1/4] PM: EM: Fix yamllint warnings in the EM
 YNL spec
In-Reply-To: <20251225040104.982704-2-changwoo@igalia.com>
Date: Wed, 31 Dec 2025 17:20:21 +0000
Message-ID: <m2v7hmk1pm.fsf@gmail.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
	<20251225040104.982704-2-changwoo@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Changwoo Min <changwoo@igalia.com> writes:

> The energy model YNL spec has the following two warnings
> when checking with yamlint:
>
>  3:1    warning missing document start "---"  (document-start)
>  107:13 error   wrong indentation: expected 10 but found 12  (indentation)
>
> So let=E2=80=99s fix whose lint warnings.
>
> Fixes: bd26631ccdfd ("PM: EM: Add em.yaml and autogen files")
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
