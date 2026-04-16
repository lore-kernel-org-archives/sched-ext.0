Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF26270540
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356146; cv=none; b=jexeZSfpkaV+f8hTuXVytqJwXC25Di/eJHzYdShJWTkKVTUaL3XZ1wnJLeOjW3Yb/a50uggeOf1G2Qf7N4XV/G5DPkZx0HoT3uyyTa1jEZS2iDJuXZa2Cm4zg2XAXdMCm4iYiUODQBlFWZWUOKpJAP7XfkKgQAobgPXsEKk7nNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356146; c=relaxed/simple;
	bh=UDmk89U+0WNvfvck9D4CTjXytQB3sZBrrJCDd4389Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V74y982Bx7Kq3qKorjzomY1QbPs/1SHX++17iVWBLMwjnGTG2qtopCQwnUnLF2T/J26jSBMfsZF3wW0svnYcHpyqJ3mYB4UV7kTGTCljasXTmx0EVOYtqOJDCy7heJRdOc6ayU+IFxyzHu/wVnuVmY3uiT26s8gfOClotlYTpn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+rfNAtl; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+rfNAtl"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35691a231a7so5230407a91.3
        for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776356145; x=1776960945; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0JXdFQpAumciSdmN1aS/pXRjTK8zOqMCmu+yk576xk=;
        b=C+rfNAtlzlFmrHxcgdtkQcGiwFAJhuFyaetf07vuSQAu9Dx5r0Cu+ZX9pcT2AU5+rX
         FTQOmUSeoZBvaS9jTjqLbIinwORwNxDQt+MZNz0xpTIMUsjetGvxkjH5F0J3dgoZEdie
         Lez2JmGEU7HiwFAd+ZMk3mAfmIxW6orWFSnMLSXo3PsCTSOqtRrwwGWOW2bvOCBGaJ1U
         RoFk7alNo2eChaPyAYqk+39CjBbK92rZnLYiSuiAotMerMokuh89KdLrTbXr3MOlffF3
         IHtubEF2inoRqJK+7LJ2PANzXKqAQe4Os6SRpfO6WxGoZyDg+anH1xPgP5hsvvPrsqAU
         bAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776356145; x=1776960945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0JXdFQpAumciSdmN1aS/pXRjTK8zOqMCmu+yk576xk=;
        b=Ggd//sY6aHRZ0iBuHdY6EG4jI2lKR1Fq+Plt+Z4LgVq9+k8+qUjGz96D7Byb8QMshj
         u+C1iDqoo254Ub1huoxd04eDYyXg8u3EFstVo5wvGWfFscvIZRmrU3xNT1coOoygnPE+
         tTCL3j8Y5wqmea1ghvUSk1eJifDq7/aI1gZ/doH4Ll0vRAPHWUjpLSGXxzlQTT6G1iuU
         K8NE7d1Rl4uENAULJAL0sfvuQbpEoLEMaOhgwMi0rpzNVNEPXEEKLKJ9OmQg8bFmri0t
         uOzcD1Wwt4I6FqdV1BMpAnLNxt9KToi7pePdm7iLwfkJZ3KL09+iRVEPmp+NqeFCW7LO
         tKDA==
X-Forwarded-Encrypted: i=1; AFNElJ/6hfdXGsbtNC700Kq+Ulhyh/b6aREuKt4VnAqJxjAtwAkolJOZtQ2HiRunUtR0VVdgluPGOuLsevE=@lists.linux.dev
X-Gm-Message-State: AOJu0YyN5HQzjvGJQIGG438PDTJ2f9mnUY6/cW8Y52oaSkLpO+CxnyXu
	lJLdJGj++fDVlQUIC6m0mpS6T4SqOLkw6rPZbVbpfe0krXsqYr9H9dpV
X-Gm-Gg: AeBDievISbY8UG2e1KNkpsvSw21DxQGpOP0Off/9ppnP8VxA8biL5kSsw3pMv7Dswnk
	YYiWxCkKH+Zo9kn5qhfiOsFNMLOVOkQCkO5hdmBpFBnLSbb4MM4lMC3k20gC5JsqO8E0pJMxJ47
	AjWGk6U9RWbAOuByzWrDE44BQ+r6QinwMCBeoZVnyhmPjRMVRa7n3RYobqndODUFLQy8QcfVW2P
	ChvaNiYqxlaPU6vye/r4Z29fSflchksTaPC3VZcH3YRF2L15A5DrLcUKk5ukGGWbSOG2eQYlRwn
	XvZHwoitLKvKzBUtqLWV7bKfcpyYYqinOgY7patWTblmvYK3VwyOR/MfEKmfnhY2qWJnZJePH3O
	gvCp2HhcgssAkBiBR49LSsduAYGf+3d1XtHQ//BTBK198iZ7Edu1VqEuo1YelkktFInH5ZQnhvi
	5OR9lJlmtJZJeMrUyH95sYWBXG+iwkgimv040cdf8=
X-Received: by 2002:a17:90a:e7c4:b0:35b:e529:2d60 with SMTP id 98e67ed59e1d1-3613df1393emr14158a91.8.1776356144655;
        Thu, 16 Apr 2026 09:15:44 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:63e5:58f4:9e1f:ce0d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132c8953asm2964592a91.4.2026.04.16.09.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:15:44 -0700 (PDT)
Date: Fri, 17 Apr 2026 00:15:39 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: tj@kernel.org, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhaomengmeng@kylinos.cn
Subject: Re: [PATCH v2 2/2] sched_ext: Print sub-scheduler disabled log and
 reason
Message-ID: <ai5o5pkb2yguejjrr74relhayimvcf5djit6tofco4mpcjnoep@mfdme2xwy22z>
References: <20260416012629.48414-1-zhaomzhao@126.com>
 <20260416012629.48414-3-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416012629.48414-3-zhaomzhao@126.com>

Hi Zhao,

On Thu, Apr 16, 2026 at 09:26:29AM +0800, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> Take scx_qmap for example, when sub scheduler is attached, there is
> 'BPF sub-scheduler "qmap" enabled' message, but when dettached, the log
													   
Nit: s/dettached/detached.
Overall, looks good!

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

> is missing. Add a new function to do the log thing, it can be used by
> both root scheduler and sub scheduler.
> 
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

-- 
Thanks,
Cheng-Yang
