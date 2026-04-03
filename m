Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58D347BB5
	for <sched-ext@lists.linux.dev>; Fri,  3 Apr 2026 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775189652; cv=none; b=d9n3yoYKh23dv9cx6yOqS9q55MqQbpC7/f/QtV0oqpImfbjt28n1/1yRYTncWSdMwY4n49GKGJPJtFmU68CfGEex3Zd1u1cOMENeFKGWotZZIy1ZwnRoWSZfrrruv4Li5vRX5kmO4cbwe6NXzJFRfZmrXiw6TjY2kX2JXsa/f1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775189652; c=relaxed/simple;
	bh=UH1+BD0ZJvJQwo/6Zmm6aqttdDm5V+2r6aTkcZ4LUSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mofPNkF/Wt8BHGPmAZvuIY6xOK15u8aX6ZuZ2AL69H3nrQ5sVeFtsU0Ia0r75tOvmJJyR+M/dkyWd/HehDoY9EsmWzl0xVqjXBEpOUqVYsBPGbudWPN/IjV0vYXn/JI0R/7zMmpbsZlAvtzQDFiXuNeT+rtJ0jQ0VkLbL6J1+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfnceTy1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfnceTy1"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-823c56765fdso772804b3a.1
        for <sched-ext@lists.linux.dev>; Thu, 02 Apr 2026 21:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775189650; x=1775794450; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tpx+mmzpr/yfM954FFPOA51XWoq4aBIewIm48630/6w=;
        b=nfnceTy168gsQYrhMcJ0uARJ3KcQhsgKRMZqma2tC7dpT2uK5o8GGwMggafuRdYZrb
         GbrqdH9+vpMmUms4WtbbJezvQaxKzWfwVLGlq20xl7qOUZrhWEmzpTqhCc7pM8v0lox8
         fcUerY6sPi9GsxsgeXcR9Xe30W2mYbHgnN1tK+gKneGxi//tiMZ+IR16sDtSfOPjZGby
         M4etMV1ztHNJpWOtsxCPAAGX/+U6IIA4aiD18VVJze9+IG/cSgkNTuNpuN+LT4Sb9h/d
         bdHu8/d6qxQul1vXv/cI47T5t/hHK+PATCHHm8NVp+dHSaDKOR1i0zCrmfZ84XU5TLtO
         bz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775189650; x=1775794450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpx+mmzpr/yfM954FFPOA51XWoq4aBIewIm48630/6w=;
        b=Zjp1wyqYfgpXc9poz1n8Xe7C6nJMy+IEaVxY2WPrFSPr1Omh0wuFqVt2AMymucFc6K
         HuxjHuQsLJIYUlLJKWBH2fW9Xjou/LGH9FkJ7XPPsXEAbd0ZgWEUTcLl4IPY6/OAnufb
         tPQRhS60w6Blxz+mQaWNRfLxekJMCgGH156u9SWq4tUn2yrREGKrWoNUnX+SaFlj5SVa
         vOsWFZXpnn1rgHFvYtJmaY+6Dg8UhbRsKZ5cJ0ubZohy4ficGhhTaLvTgsT9UmRnxe86
         esxSJJIHt8XZxSlJn3MRw5SwSJeV9++1yXjXwPstaG8n2KpCWJcaLk4fGUsrfZMBtM5z
         RNAw==
X-Gm-Message-State: AOJu0Yy4qQx6PZrryoJxSEghCGBiKEr+cWHwb9+y26kyKLnHjs4gY5MX
	lWM7IjCOrxrEdEOHAi5vGqtpN8jpBPjC8B01I455JH3hc3hFuuovVyIh07cSKg==
X-Gm-Gg: ATEYQzzEKtCOJ9C0kP8CY9FUadsX9RU3KhidKXHcVUR0NF9mLWGqDYwFOnTebDIEsZn
	ENxQFLnNTyCj2gUHxrdWnypzaw2hijcNhxQe84+0lbvF/0JaN5/3g60otpPjMu7Dek9ADytUtbA
	o8yBCbGpKs5wu/4e8vQMD4AIPOBv9vioXnZxuv1x73v6mf7OeAyRUwZUULxKHFzQBqWC98Uq247
	J07Z0rB8PvD2MkHBS3zmBEAc/+MCEh6TMnykJVgSr76T+Q+v0LXtGklJbQLstGG4AhUZym4IlDQ
	xgTWd3QsGTdzk3OMm17mXGIaw5OC5nLmgEJJI8rRoczKYYOcymqbOmWEkYpO66JXvT6GYkIOEAr
	34JhEmTEN5JVa1A+V/bpex8iKBlbuOAco5JiSx4o2jkieP5rigCbEduTKvIUDxZHhmXCa0WBKDr
	0o6c35H7UgExTdJJXSBxUhtDaJf9KE
X-Received: by 2002:a05:6a00:94c6:b0:781:2291:1045 with SMTP id d2e1a72fcca58-82d0da44f8cmr1615407b3a.8.1775189650315;
        Thu, 02 Apr 2026 21:14:10 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:566e:8ca1:fcf3:4f49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm6039372b3a.41.2026.04.02.21.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:14:10 -0700 (PDT)
Date: Fri, 3 Apr 2026 12:14:04 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sched_ext: Fix print_scx_info() build error on
 !CONFIG_EXT_SUB_SCHED kernels
Message-ID: <o2p4qreec6pvx7laidg6zyqgsjdgx6m4zzzmg6p6ue5r53pvwi@yqu2rnmozcso>
References: <20260403040913.610756-1-yphbchou0911@gmail.com>
 <20260403040913.610756-2-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403040913.610756-2-yphbchou0911@gmail.com>

On Fri, Apr 03, 2026 at 12:09:03PM +0800, Cheng-Yang Chou wrote:
> scx_task_sched_rcu() is only available when CONFIG_EXT_SUB_SCHED is
> enabled. Wrap the call with #ifdef CONFIG_EXT_SUB_SCHED and fall back
> to rcu_dereference(scx_root) for the non-sub-sched case, which is
> semantically equivalent.
> 

That was sent by accident.
Sorry for the noise!

-- 
Thanks,
Cheng-Yang
