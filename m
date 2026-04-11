Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B7390237
	for <sched-ext@lists.linux.dev>; Sat, 11 Apr 2026 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775920192; cv=none; b=AwoBiUgxlzCmb2hyQ+GVCxDDOnzSjkb6fJ95AvN0pfKcVH8rlUM1yls7Bu+HXFdGIqPNSXo5xNJclZmVfN1XOfqzP0glu/+y8HjFoDQfz2enEqQg0u4YDlyFvVg1LhRn1QVCBWPnuqVj45i+8l7Gw5TKLEn5+Ip4/j0sPo4c+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775920192; c=relaxed/simple;
	bh=2mBgIUpk5PT+jzVy/e2ec4iWbsOT4oLJY3trvERvd48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEB31f7qN4kTkvQryNUK75Fw/vastWOCUwd5Z6B7xmmYOVKM4/RgT6dHI2YvSlyMLzG7smGsu4Dm/LJkKTvAvOB4PZXhfY6eJjfVN2VliLXDjSFLTvHVl2m+gmmqVsjsouCiwIzC+mbUqKfvz+z3dfZKJfX2nmRPKHhtoHYcfMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+59o0hI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+59o0hI"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2adbfab4501so12457155ad.2
        for <sched-ext@lists.linux.dev>; Sat, 11 Apr 2026 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775920190; x=1776524990; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+tnLgQ1yCFjaQCYF2CBUftQ5ucVloLEn+CgT/EJNVs=;
        b=M+59o0hIrVWf4DbHiDXSyO/dLNABzfdi1cbVyOiaakHu8lmDw6x2k/QFZoxTN/LgBi
         eJ5z9uHuJEQdzoPXbYiV0Igklft7+yrEIMhxKHz0zEUeSa40xJNN6a7x5kWrY120jbRc
         Nj8TJPiSqZaVQEl7yMrrfPHTKDsQwnzrE3YGNZ+mcDmTsXDjqz4UnErRKrh+qoKR307I
         DGldRQbAzw3EYsFnMgd6RgDJTE5TP9A34riaXakO6tApVmabVjSuA6lVABaamxp9ywjt
         XzaRvxmhkkAaWv3Y7ZLUyflYVyymrOW88oM+yZuNTs0se/xDlZiVECDkK5s8ZU7rfv+m
         /G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775920190; x=1776524990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+tnLgQ1yCFjaQCYF2CBUftQ5ucVloLEn+CgT/EJNVs=;
        b=PWliZ+3Gu3WG2h5UQySJQpcdMUhux8bpLLB9BHnWiVs+efqQ3mMX05N14UVjDXkItb
         O8mjiJ0X/mGKb3D/WbjDGA7K+bMcKq29P32KKZxuj7rbe5jox26yAB+u8EfNancsO82C
         3um4tloFKrdeEdBTWtXuDHMgvGrDQqDOZII2EWskyXbjxrtEfqaa9CE9w2OsC3SeTlrv
         FQfIQfBlpMgP3fm+AryFRWK435iCJ3pffmrlSRQwHDn4RQaVWl7hbLF3FdMH5IBIloM8
         QPfuv7Y4vTCQHIgwpiCg+Ctzxo1kyw+tQ4DVQCsERu0mNuxjpN+cyZMt26lwaMs0cCf8
         ORLA==
X-Forwarded-Encrypted: i=1; AJvYcCX42W8GzLj6jpbeG9AxcPUb8POhD4t6YLBO9MePMi+s4HRpCoD4TsUiaOoayHDLXMoZqnCvRYLfgDc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6L/uCGemfCbfpgenlImgriTIpEjuCCrXKoEnJn6jBPn0x7cfY
	EAknFvCfyDItSczRvBWrVbpL9nsKd24dXsf1gDMnYbPrRGxlYQTJFrt6
X-Gm-Gg: AeBDievVPbxwHORe+lfXtcSW1yc6xnGQXQkpO+tDvPUKRSzl4hVNUkfOrIj89XejvcT
	vB98KNhRRHw6m7HvZhjz/WPP1F5twI5kHXOu50T4MYRrTeXZx7bCStD0o4B5QOmo0qTh6iBP8Wz
	pAaGOyS0CmCrYIx/uXtNpviitwz27H5vV9hoPuWNdS5NY1Wcz/XM9ByXyhS2WPvBw45ssUgAZ61
	Qsq+53J/UiSLbBg9bFsSneg7lUWvRPcWNprLJ33cClWmWcizYqpQL8nOSbT4NOo4YJ7J3KUyruA
	RigBfKo3OBURBZCkLz7DStzZAI5BVBtBkG3QNgXi2CbnAJu/DPwQIzMpHueMbU+5SZBjZ6XGnN6
	l1e7dEdTgIfZh3B3pdlv+CxWVcbZvg+t4Ic7shzjJ3AhT6/fYKHO8469m+oMhPWG3EEcgSWYI+c
	UeazxChKYy9j2eGd9XB4ypDlR7NHmb
X-Received: by 2002:a17:903:1ae8:b0:2b2:497e:3f60 with SMTP id d9443c01a7336-2b2d5a6d679mr79615375ad.33.1775920189966;
        Sat, 11 Apr 2026 08:09:49 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:4440:b527:db2e:c93f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dabca4sm61221555ad.15.2026.04.11.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:09:49 -0700 (PDT)
Date: Sat, 11 Apr 2026 23:09:44 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Juntong Deng <juntong.deng@outlook.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1] sched_ext: Add verifier-time kfunc
 context filter
Message-ID: <z24pxjqtffpapups2bemfo7q7ys6dibb2nstnsdn5brmee7oty@t4n4z753ws4p>
References: <20260410063046.3556100-1-tj@kernel.org>
 <adk3PF5tJOwJbeop@gpd4>
 <aa6dotiucffrhwylwuwezvmtkew5ekzcnpt2eb4vvf2yquame4@ewd3arfzvozy>
 <adn7PVYWR2FVnqFQ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adn7PVYWR2FVnqFQ@slm.duckdns.org>

Hi Tejun,

On Fri, Apr 10, 2026 at 09:41:49PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sat, Apr 11, 2026 at 02:17:37PM +0800, Cheng-Yang Chou wrote:
> > Regarding selftests: do we need to add any for this series?
> > It was brought up during the review of Juntong's v3 patch,
> > but I haven't seen any further responses regarding this on my v4 patchset.
> 
> It would be nice to have a test covering all combinations of allow/deny
> matrix and that's how I tested but I'm not sure there currently is a good
> way to include such tests in the current testing framework.
> 

Covering all combinations would add quite a few BPF files (7 contexts *
5 kfunc groups = 35 cells, each deny case needing its own program)

Given that all demo and out-of-tree schedulers are working fine with the
new filter, I'd lean toward leaving it as-is for now.

-- 
Thanks,
Cheng-Yang
