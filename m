Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9AF2FE591
	for <sched-ext@lists.linux.dev>; Wed,  4 Mar 2026 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644387; cv=none; b=TdmAI0S8OZPl/gFpjEKKIp2VjH7Ug7h1BqyjsFRvi0fkyfgJA5AviIp0IuFNpBaUV1HkBKj5aWhECl5oR0A54iNbRY1SoqUkGBwWydx6dL/8msy/rwvhLcrXbEOl+XEdPeTpj1xTabLHb9wx43oiTj2GDrd4rlh4yu7Mrc+OOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644387; c=relaxed/simple;
	bh=hsby/FuA2RhqwsYZEPnA1XJs1kE6uwX2RwzKAO8vXTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZLL0ZpgkEiSpIeaprdbNTjBrq1FmlopY8sujAgqpGxsE8olvfJueF0u6W8dp77tI4M1lw2CBDIFrn+3WVaQZm0OtOY1qs8k/POcXxaCbaNg7QD6Fbx5a3GgG288iclZMVdZFS5akLJnc2hRT1h1gvnQbzdbme0JOhwDwgyjlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0QT62Bl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0QT62Bl"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ab077e3f32so31262605ad.3
        for <sched-ext@lists.linux.dev>; Wed, 04 Mar 2026 09:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772644386; x=1773249186; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tnbjRj0AGZohyhwq6gXirOtSKwb8yX5ymVLx2p/9R4=;
        b=T0QT62BlQzg8b+IuCrknFuGDfByOHo3qvBjx6YLL2L/kUN8x+3WC21x/5PnsgrAZ6q
         cLryiVWBnl2FkHo/t4JiQlG9O8taADQp0OJ+yhdyhSvpAgbXvHhXEqovHrUC07d7Wm8p
         lpBJrVzuWuKEXJjGGzSeULqtVbcvVM+RKiTK/p5oLAC6oMWfJCjN1kuFLDSXBk7qy8ml
         OmWVTzk463Xcm6tstU7Fb0jUtLzhV6uNJM5uOhC2AyAC112jMX7yMXOxqkzpwgxdBzNb
         iwNU2+FUX5kOiIFmbOgivydgkralfByekVwdpKVMZJtTS5GbtSWLPGtDBxqBXVjKq/x8
         HFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772644386; x=1773249186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tnbjRj0AGZohyhwq6gXirOtSKwb8yX5ymVLx2p/9R4=;
        b=U0jHIp7nbNCcTEn5GBRUgkeNYUAifY2jlhr8/icrxYahpwOj5LP1AwoxEbsX7VHLHN
         VcnauoYrbkIOgXzH8El0iJhqvi8xCiV95JFqKHJbYXOHNff81dNJvenY0XHjjg1gkclc
         WBzbj3pYidYaxd2BAAZLkSGJdUdbQX5SjJoROTLIClguMtRtSqq6vyylY7fW9bzqOhP+
         LJwMwQRHR7z7qq3Q/pLtjpaOtrmDO25XcbuNA/MZVOMg9BghbU6IZ6RPAVDQt/7PU9EC
         j1ZWFfTcRaJeJj3bFqhOM9DHYWqig9fer/wR58Nr8ybtXoVZOTVIzaEg4Et1FbCXD9jC
         KZww==
X-Gm-Message-State: AOJu0Yy4BZ6vSxU1fNH93ZEKcHTS60ZwkL5SXcfRGlvD4fXYaUK9R9fu
	L+R8plLVvi615l7FtpTReAncvYnG/XPS8K85W2uU2a88L4jFXWF85Xip5vxRvg==
X-Gm-Gg: ATEYQzwGf7736fH47m0ApB7J2RXGyVpRmTn3x1bPJoX4ip5sJ0qRs7UeqXYyo422Fm5
	DaEcc710zoft4Lw1O9X7ff2b/CnZYM0gW25mH9oOs+KjzieZy2svIV8HeMPuMFcYMAct9RjpNiK
	9HIIHvuuBW0syMyz5Nw6qxKYQotBjn0w1a4aaWzKJ8J6X+btk+DsSDhcLR62QeQlRSF7OxEqJjg
	pj9wZGlvnA1Td9qpMJYmpYDRQ/PvUKAoyQfpBywfqzkiYHpmg3MCIWqrFqGX6B59QGL5iothzJe
	Hfj+mmCCaYn3j8GEKBQYEZAI8+ouOmyxls7qXNyA+qdH/YIcE8aDrFtvkr98nEwkHkZln41VFDb
	xMvqv1Mpu1willezWJvVVVvS1h4Kw9yxIBDE7bUFl56jKHNaUih4IuigEWarKkiLyOPuZvww5Uu
	cbllfEaezB3sqfG9Bw2U3E+xFhzV9Pz4b7xTn5bJb6v99QE4DgTFp88E9fs8Vd5YaRnJOcTGOUa
	g==
X-Received: by 2002:a17:902:e752:b0:2ae:5fc0:308f with SMTP id d9443c01a7336-2ae6ab28ddcmr33607225ad.41.1772644385361;
        Wed, 04 Mar 2026 09:13:05 -0800 (PST)
Received: from eric-acer (36-225-117-207.dynamic-ip.hinet.net. [36.225.117.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5e1699easm58139735ad.7.2026.03.04.09.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:13:04 -0800 (PST)
Date: Thu, 5 Mar 2026 01:12:59 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] sched_ext: Add missing braces to multi-line blocks
Message-ID: <aahoG6u551ACsILA@eric-acer>
References: <20260302071332.3957905-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302071332.3957905-1-yphbchou0911@gmail.com>

On Mon, Mar 02, 2026 at 03:13:32PM +0800, Cheng-Yang Chou wrote:
> Add braces around outer loops and conditionals that contain multi-line
> inner statements in both ext.c and ext_idle.c.
> 
> According to the kernel maintainer tip bracket rules, brackets should
> only be omitted if the statement following an 'if' or 'for' is truly
> a single line. This improves reading flow and prevents future errors.
> 
> Link: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules
> 

Gentle ping on this minor style fix.
No rush at all, just making sure it didn't slip by.

-- 
Thanks,
Cheng-Yang
