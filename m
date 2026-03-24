Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84FD282F3A
	for <sched-ext@lists.linux.dev>; Tue, 24 Mar 2026 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346239; cv=none; b=dAvSG0gSx32zc/CAsAGezAFligv9Lvf5oeZuGAN2KHtNiu/3Iv5gXzsoxSgJvsVY9nRZV0zc+42v40XpzyWuNLj5t273g+gZ+7M8VMDcvOZpntdnSSDd1pxPka8Vy2Y/9bOYZlsZh3R9MwxzWPs8rVnnACJ7ZPawL5STUvkz0tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346239; c=relaxed/simple;
	bh=s1Pe1NUeuOv+3uFgywpTioiLJeuBVzQJljOo4ADD5z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYrb2Y7qQE8q+KOqXm24Drysxz9QdgX6Co+uZkFOl0HVUofCwO7hOgu6CkwQMWjO0kyz0RrKzY5PfPZTOsbOg0tHdeLGv3RLy1TKMMZ/wdgDTUCjRC+ksKw4Y8T+mNw60ttd/me6oT+XKd6xboaCek9fnI9QW5hfQT7JouO97hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMXbiqxX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMXbiqxX"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2adbfab4501so16147925ad.2
        for <sched-ext@lists.linux.dev>; Tue, 24 Mar 2026 02:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774346238; x=1774951038; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oP2P5vyX163jYlShSRrM1bs2xCmEiHmJSn2ftQF/2Pk=;
        b=hMXbiqxXk6GIZxj11VbTUXxsSCJvA/Jp8sWS/Z5xGxDN9xRQPk99d6MlRA3CZg+6wm
         Qf3anDRWkJUWJH+RPMgkrOLNMZNfgAFFo3/KO0L2ZkIV9apwi0th604WTMOMOUrO1XSC
         0O0mmBQ9zV6nmG0Wfz4JqmGk0abaCYPqZNtyXV07lfaFCYl4CdLYEnbJU3/7eFvbA5FX
         6iIyEHzjZPlesG+FGw+iI/eDTISs7SdhzLKuAFAg8ZZ1A4vp0jUF0+MUvqF1XFKjX2IK
         RnRfmJM0FqEC1kvmIG8vNugJ6iwAYjIIyk7oa1/RffoIIIAv9zjN/E5/FdtvwVnSP+4E
         2OfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774346238; x=1774951038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP2P5vyX163jYlShSRrM1bs2xCmEiHmJSn2ftQF/2Pk=;
        b=VWzGUvCFsbWTX+uuQaogE9ROvOsKOfVUMADPX14yBaugJzML3n3jVSMhvAbioors+k
         lexADdWdqXCqCM2obQKnsZ1cKqz264lQTgbHid3EEMlg60Fdv0sb58854oUHDDJf710j
         RR6gnc8nKPKIytSZpRHw6O7KIJletlqiCHrtzYo/flxBgKMG/aYdUaKTxoX/gtvmGEnf
         A+UAT5OdKFB2Las6Zxl8oD+F8eNB8PggeWpQc+ZC8oHC04FM/8h5gwAmEzXbWbMxeBwb
         ry0CVuxDP77LKiQ/pJ0XsVbziY6DRsqaF6DvkUTOZtBVOJU/zMVIfM4zCgcHQhhZJGH/
         066Q==
X-Gm-Message-State: AOJu0YwKr2myXYq+yekGJbZqirm++t4r9l9X7NIt/iPR4HJR5Ngr4PsA
	UWICnqZ2EwyK4SMNwvoFAoF9vTEUvesPkHqOOOM0nin/oYU1+WJmcmks
X-Gm-Gg: ATEYQzz8I/i0VTZEUABtNuLaI6V036broZSZF9FpiJd098BmhRjHO6Zt/WOmE42p11k
	Ps/xYPNUqUlkLxg/b12FwtjB4+y1n4+Jij3Tcxgqw5AcmiodRTBMokajx4OKdnDUnmXMhWC/eRX
	I8C3T4nplGyNqAnz4AC6Pt0XKTS40VIu7sDMf6uelRkCddhujxNf7oWfaBmh/mV/riOkfXhuY01
	yQQmlKR4Mnp8bgqOzH7KFS/MevIP6OgBnODGA6Id8B/AACV5nzDHeadbhSgFlOr1ttiSd7J5stq
	DiG0ajqfkSpHmFB8OMNeKFcSN8i8k5WJ6JQcZMq32ocTmqKeS+Oq2hkJamyMV8sQeJar3KjphSL
	oHXCC5xKWKhWJVdhNa9pUlc34TDASnOsFSbWuxfmv6pin9PAjyMoGWvyCe/Qe03E+xY1fhSOzQy
	kQbg1bqdunrbNkOHiFrOKuLlKvRTcZ
X-Received: by 2002:a17:902:d60f:b0:2ae:48a2:1c3e with SMTP id d9443c01a7336-2b0827a7705mr134782245ad.27.1774346237986;
        Tue, 24 Mar 2026 02:57:17 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:c95d:66f0:4661:427f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836554acsm182525255ad.51.2026.03.24.02.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 02:57:17 -0700 (PDT)
Date: Tue, 24 Mar 2026 17:57:12 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Fix invalid kobj cast in
 scx_uevent()
Message-ID: <cnjljlotrq3325xs2cqpffnsb7pbbc2huoryvjd4bjt6azc3cq@cozhk3cxloxu>
References: <20260323104848.3879920-1-yphbchou0911@gmail.com>
 <acF8zKIsBST6Gha_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acF8zKIsBST6Gha_@slm.duckdns.org>

Hi Tejun,

On Mon, Mar 23, 2026 at 07:47:56AM -1000, Tejun Heo wrote:
> I'll apply as-is but you don't need to move container_of() here. It's just
> address calculation, not a dereference.
> 

Ah, I see. I'll keep that in mind for the future.
Thanks for pointing it out and applying the patch!

-- 
Thanks,
Cheng-Yang
