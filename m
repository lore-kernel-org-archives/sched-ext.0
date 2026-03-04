Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2202C3321D8
	for <sched-ext@lists.linux.dev>; Wed,  4 Mar 2026 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648048; cv=none; b=YVfzaj+W9GTysLhHsCT18VN9eXTAM5k38UezhlHDfS9bELt659rQKh4TkXis3ZT+g8XvPzxD93Oa+B30HLLOd01UStygneOhulbLc5N5sa71cOp7YSVbXOLP95t52dSFmStgeBHDl8qc/ZvMmAzXSv1ZU/IkcVb/aOGcmP8X7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648048; c=relaxed/simple;
	bh=9wByyb32/MlhuQ/s1NPvuuoZGKDMW8nLXRhL/P/nsJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7ybAU+JCyR5PV1wFLm8vGDaRKyIcMfaLjmH2d9O2eGWpJwy4sdEJKNAej1W5OYc/eSjFw8tLB2yAUN4Ks4qC7TT0AFiZL41YNYrmsh3meAJvK27USMHzEK90jZOuEMaAXRIGAtBRsGGNvSuUau0acTSoXZ+kIWUUEVQwUxXxcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT6kDjYt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT6kDjYt"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-827546f228aso5096864b3a.0
        for <sched-ext@lists.linux.dev>; Wed, 04 Mar 2026 10:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648046; x=1773252846; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUBQ1bKCHZy2IfgpdrioT0e4cwEAbYXcjeDSWYOjyhw=;
        b=XT6kDjYt3WzJovOntfStJbsQd+4EaGDxYzPT4Gh3kHh2If6zuJ4NSMSBDL2drOSuTR
         WoQMqkVH3yj7MaGgZKAOEP7XJ3mM4Ijpe/8cUDQnKKHUNcJmNo7XJjbr6aV4KNwqx6F0
         UQvN3fsIikmh0qp1FDa/LyM9xhpwbYBq65cYMHqlVoZD+/BygYqgUq4Ui+hy5RrfDrdb
         JB1ypMuMErnrXGbTlBSYYzaL19Ji5rah4kJxBauMSvwYYJoqXJK7JRN+n2W0d/vc8HZB
         OMBoWSTec4BMYE5t9bRDXge85dYArnf1Ma+9PGSDy6iXqCNKBANUVCqHUS06r6izIxIx
         5JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648046; x=1773252846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUBQ1bKCHZy2IfgpdrioT0e4cwEAbYXcjeDSWYOjyhw=;
        b=bmpVBwABVCtGcIsY2sKgIG7ph1s8Uw4Nj7TOX6q2uTgpH1iEVGIE2fpocAYaw6in07
         j17FjbIKHrKA1I65NfOFjMiRANGr7BsUjNIV5YBcP94VtXE/Fc/q3555y4jMog0uZZl3
         YvOxVw5Qo4gp+N6HE8z2p/bXWnpPpKqWISBGlxK5EqdlWx+KaOiZh781F11Uhqb/J0Tx
         e3RN3qUoveNjuTS8gw8Fq/7nkL3uqCy6ZY5T+3bCaCuqX7cFoSwpzF4vSWrGg0eTxI4f
         fjaJyXYf89URN1HgrC8C3da506oJfeFwUD7mI3VzXEuyd+1hVpQZhX19vBikO2uFEyHF
         9lEQ==
X-Gm-Message-State: AOJu0YxtiIMC5m/cGL87zEWIHQTNvvz6nWfLuw4lwF0MmA6ET2zvj2Lz
	VjbRxLysuZ2J6l/dTtW6mw/9CH58eVkoaQxvFpPHaLdB7CbUj5bBB5Gz
X-Gm-Gg: ATEYQzxy6mE2sHaHhKFhzBbPKNcvmDWPH/NbQHuA+bWeJcWMuNsdNVlOTaqwrB+YmQl
	5dRXgp2AAkaR52AXjsccKsNGdKXzyId7THWTEuY2qRJLrK2XP7ZS1JjGwyDgy4DOM+JQ+Y8JzvY
	Leg2FNnnhd5k3OdH0QliRk44mE/2CwfzuU9wSC/EEc1ElOrB2DkFyXt3QcMFvPUrULlngjrol/U
	zk/HYn3cRepHkMhCfyY5dLUyUOuhF2LUz0dXocg6jcKSj5Y5keUOEDwG1GL9YjfO83+l2/xI1VC
	6UwEiFKIsoBb/QFfOjEEXKJFTWvMrAUbuwxwmenY2osYD/9kiXbezZ9XF12Y2sUtQ8GB6nM698y
	OXO0dLbTHgy1Y6XkBYNqk25EqbzrvcdLS0g7O3yEyuDwcEdZXEvvmNWHkRJXHI9jBZfWP4t/MLP
	tX44As1Fql5BUwfULFacX5iRI2aZUeVL5FXOZGj9w=
X-Received: by 2002:a05:6a21:a518:b0:38b:eadd:449a with SMTP id adf61e73a8af0-3982e1f1723mr2588279637.38.1772648046314;
        Wed, 04 Mar 2026 10:14:06 -0800 (PST)
Received: from eric-wcnlab ([2001:288:7001:1099:61f1:eed6:e317:b900])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa62147esm17410396a12.12.2026.03.04.10.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:14:06 -0800 (PST)
Date: Thu, 5 Mar 2026 02:13:58 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] sched_ext: Add missing braces to multi-line blocks
Message-ID: <aah2Zv6kLdGFusuy@eric-wcnlab>
References: <20260302071332.3957905-1-yphbchou0911@gmail.com>
 <aahoG6u551ACsILA@eric-acer>
 <aahw51fT1ANEhIUh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aahw51fT1ANEhIUh@slm.duckdns.org>

On Wed, Mar 04, 2026 at 07:50:31AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Mar 05, 2026 at 01:12:59AM +0800, Cheng-Yang Chou wrote:
> > On Mon, Mar 02, 2026 at 03:13:32PM +0800, Cheng-Yang Chou wrote:
> > > Add braces around outer loops and conditionals that contain multi-line
> > > inner statements in both ext.c and ext_idle.c.
> > > 
> > > According to the kernel maintainer tip bracket rules, brackets should
> > > only be omitted if the statement following an 'if' or 'for' is truly
> > > a single line. This improves reading flow and prevents future errors.
> > > 
> > > Link: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules
> > > 
> > 
> > Gentle ping on this minor style fix.
> > No rush at all, just making sure it didn't slip by.
> 
> I don't think these trivial patches are useful. Ask yourself, is the code
> meaningfully better afterwards? Maybe as a part of some other big changes,
> these might make sense, but, by themselves, it's just noise, a busy work.
> Please don't send these patches.
> 
> Thanks.
> 
> -- 
> tejun

Understood.
Thanks for the feedback!

-- 
Thanks,
Cheng-Yang
