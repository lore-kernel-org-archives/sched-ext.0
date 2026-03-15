Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34155264A65
	for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773563655; cv=none; b=aofouH2XZoLTg6lLF4bgnb5KAJ9rGo1K46h3YpDAL76bJhgxcv8siqdnIiNHkrysjswKUuGepuhPgvNwMgDRMS8kJ1Wh4XFrcwX3IARzWzJSIRQe6mEfSwnvE9AlDSib1Vtl5Vcj/0vIG7rhRFYasv8a1uF7u14Rpjsb5tlOo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773563655; c=relaxed/simple;
	bh=JswHTJYz9MRngGoFjhu0NOM5RxPm4lbHbUjfClnKEyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PO1lB6D7rAgrw5Gb7rhSuYWOfBlf90dbZ4Hs5GlctC49EH4uwFZfMeTAyxgYeS+jgEKnuDJ3R3dyfCrAoMJaYmDdGzAgs01iDoGxAIo2H2C1Cn+NAJWRAtk43NBMh6nGvOiFn1++nwdzY6fOzgh7PXuSWfuq4FNR1TRX4kmypKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg/pY3Oy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg/pY3Oy"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82990763921so3387941b3a.1
        for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 01:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773563653; x=1774168453; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLFBr3LHRGS0NMGe0BQLsy5cwcrOQ0A4omv5121esfo=;
        b=Cg/pY3Oy6JmNRsQJIbkrcf0/NirgXHhHrxNZmNiR/d+r+ogYe1nVxdOWrokba8aa+7
         G6+16g6X+iZ1muPYWpKWc4a6Aci/tYn0BmrjuDe5rQn6+0czpZiweGuqt+twKZaFvbH9
         IyVKPu4UKv8y1Em6kqP51bDXkA/Qsm0i9dCpcyeunsMBH47u716K1jBTk02E6KJrWApt
         oryvyPZUx2eQEzA0tV5vWBESARjyGSREtDbEEhk9HYWJbbsoXwhT53fEwh45HuzI43u5
         iK4egpBQh4LhRiuuZBxKBYvWegWOL3WZLLJ1VL0+e+/3SNjz8mTUsUDUHjAd8BF6BJuZ
         EwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773563653; x=1774168453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLFBr3LHRGS0NMGe0BQLsy5cwcrOQ0A4omv5121esfo=;
        b=moYAbCk4quES94FzCuzMhYrv/ph74qfiIigUzgDZq6G5k6TzCawnrNY5yXz0SiX0Mt
         LNgrYf+ph5i8lSoz7jEOvI2pnnOuHZD5RKru/caDPOIQkvuRBPwwW/ixKTmn6QJhnM5J
         ufnoILDDt7VH6KPnpH/vJFI/oDj6B/VMMLitBhAaCXyTR4EVeCPPqaDcg0AxWDab6GLQ
         d/AoAXrLcYU9kSwa4iMrozQDjLA80O3OK/JblRREmEC0bajLi5PWJDFfcoA5RI96U571
         aUMLxFNw/5AEVCR8osnUcnaWxtH/EOUeM4s40DHiIegongu5joQ8KJLlf2KdeCTwTvu8
         rC+w==
X-Gm-Message-State: AOJu0YxPC7r5MnjGKG3i9Q98bPCNduhaTz8Pm6/wV/gwHRil/VhLsEgV
	QY1kvfbC9icxgNIry3t1vG33tQegsqxoRp6xLBO4b+L/7XHOjjcfTABsaEP8ISHC
X-Gm-Gg: ATEYQzznGaOJUJZ/0O2A/5KJS9V4MKrewnvUxG4sUdDnRRkFM5W6z0lfCjKRKIuVBqJ
	/BlJ8K4ktKXj1rsjCWit9gZfTRoIOg51ylVN87sT8t95w1WdFdU4K8QPqRGIZVmTEUJmnfUkZ3B
	qq+o6smJQ67nzrTUZQZlDGQHHtAE7+Vj8XRUIO9GuQLw1qhWL93CSVGeisIYJ//c4Gd/0ArnvUY
	w+zrrYED4y6E297OR20K/bOlMx7jzhk9MzIT6JAd6tFD2gzih46SaHVTWTOQOxrRXl2DUEjD0Zc
	JK0NOJfjdGsxCmq4muPcxVJaDwBGJ63bQo9RtIq1jlT4X/1Pt+celKUXQ1Uvd7RWt+qAcyb8rbt
	wNKNThcXN78/SAW9Hbk3pwBfBWirz877EW4ACUImUtpj6AgAIc9btg3OkBR3SjhkqjeTHJs5Z6a
	fa7IcfOY3V8uBBcC+ynL7cBRwxonrXMkKmv2pk1yskUJtg0P+jgsn2aql+p8uL
X-Received: by 2002:a05:6a21:4d8e:b0:38d:eeb9:8f6d with SMTP id adf61e73a8af0-398eca3f446mr8557119637.24.1773563653227;
        Sun, 15 Mar 2026 01:34:13 -0700 (PDT)
Received: from eric-acer (36-225-72-126.dynamic-ip.hinet.net. [36.225.72.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb9966d9sm5963378a12.11.2026.03.15.01.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 01:34:12 -0700 (PDT)
Date: Sun, 15 Mar 2026 16:34:09 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v4 0/2] sched_ext: Update demo schedulers and selftests
 for deprecated APIs
Message-ID: <abZvAf14_s1TrwM9@eric-acer>
References: <20260315082500.597204-1-yphbchou0911@gmail.com>
 <20260315082500.597204-4-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315082500.597204-4-yphbchou0911@gmail.com>

Please disregard this outdated cover letter, as I accidentally sent it.
My apologies for the mess!

-- 
Thanks,
Cheng-Yang
