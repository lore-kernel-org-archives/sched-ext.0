Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9F2FDC30
	for <sched-ext@lists.linux.dev>; Sat, 14 Mar 2026 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773456643; cv=none; b=VLni2kpNUOLkT+f8kxMaacMRTYvTNVbDoC1nMT0TEK5dAv6kv/9J+gLYCwhACwudwywfna3x0bxbyC0EuGg5zej4AWu3Dadv5drwOO5iX2QK3/XeSNOlDINggBbdBUEYMf452/H2p+ZrVbVoJCpIOAKsCmhr3684SPKfmsQImPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773456643; c=relaxed/simple;
	bh=Nn3cj96zf9rZEAoxjC3L9W8ZxM4LI2v06RxDT1UDYiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaRZ4pkSSwi5stWb2TUvWtJcTOHNXv90Ex/rtE3IgEbCwyv48YLUF4zaZrduEWgUQ+hc6ICjRu+SOiEd0FYc4yNrggn8pOTmHqHuoMQf+4CFckn03i4qutyIkHV/BvViwWQUCOC6Qm0x0D5Sqb4bjnrWwd39ULFAWhfwk/GSGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntK3gSji; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntK3gSji"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-823c56765fdso1630486b3a.1
        for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 19:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773456641; x=1774061441; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJsJ1xfMxgQHqIfD6SpCVCoG5jssJ8t1mAbhwsi1wd4=;
        b=ntK3gSjiR910l1FeI6ksk9T6/YFa6BqX6UyQC36JB+ca08C69v9DN+q+bf0I9R/VN3
         cPzVygK/ZUpJAkYAfPEyJD+CsUtXx7imeEMlzH0MHYGTyiRY9TNg6oOfFiXDvVqba+FE
         zssHH8aN3uOTNScyie9NiDRyie/FqY1Q6LxiLwI6jc9weE6sKPMOiPvOMoKEDFIs2KXZ
         LwoQPNypgfIyfSsZjnxppPM0lQnu1VzuhZo5p5Tzwv5pzaZlmJ2cKAvHFD/rqGeSnZHw
         dj/6tgkJlW1V+HDAYT8A+Gycljz3CYfe4iAQsIVJNfIrgoi1vxPmFOfbp9656jhnKxHV
         ulDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773456641; x=1774061441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJsJ1xfMxgQHqIfD6SpCVCoG5jssJ8t1mAbhwsi1wd4=;
        b=NsZfxpFjgAeACuqGCMCxTwEiWPfd2ko9anvYiRAQCCzFFCjbIq8PsNkFROtLlK45ao
         ec6iVKvCBWqJEzpODcG+jVw2o7Cj95BACu9Pk6m9oJpmcJ00Tb4nffhu3BVDb/GGnknB
         6gSryL5KT+fYr2z2BamDdOecJDUaSdkbAu1cZvCJAYI8+hkJQJiOmvosDrglWvV5XFLD
         64qEM/5gu5mPzd6XUS14tT/vWavV94JF8ZAPuAqupAwea+0D0B+T0QwOc47jg2CCizkb
         4HiWBW4QuWKyrhIumdkmmy9rtA99WH+Bv17KLiVpNjpQieL7rWB+FjjQsc6k/3L5M5VN
         bVcg==
X-Gm-Message-State: AOJu0YxKx66tyBu/XrH+sj5M9AKx3kMvtHOdKeWivr8FHUEs8Fd9izjY
	FQ9+dPaq7KcIOKMGhPc+MSnKtK/tMwzRKDL4YgFIxnGaEXkVvP2W7/Zb
X-Gm-Gg: ATEYQzx+udueCZsyCE+vx5FqyHVP7aF6h8bt1nyvuP4cLV4MHBo8R7ayHX2cdhbsJN4
	MGygXIwlaM8W4l0MvOXIAxloLapz6W9rjw6+GiwvUD3PTApEqVmI6VEqynSWGxprpGSIg+gMK0u
	qwV7D1XOsi0kNtTyi8LWRaE7I4HwR80u51MwpU/Rq9Zbp7PmopCZQ3sQTAUFPP48ll7+hMJmnOw
	MsqLnnTBd4X9AOgrwgnAu0fjBVRo64eTQgUWNzwnaBf060riHO3UrX/181FebwRHJYaGpdsu6lL
	rFDEYJWlg+9ZTOjQvoEe5nGvjRzEMXGDElpWxCvR2dvWP2/kgNL+mzNSQkJu6XpY91ZAiH4T5VR
	PsBUgR8R1S9bZP/3uQE8OaO1au0X2F6YUGBGfXSAzh59S0+I+KtPxVqVUUFQly3nD1NYBFX3HG4
	+8sFg6oXYOfFhRsNif8uDvqFL++q+5CZPVJZ3xH3p9tkBywKEZ7N/cn1QIDqs7
X-Received: by 2002:a05:6a00:4c9a:b0:823:cbb:a484 with SMTP id d2e1a72fcca58-82a1972111dmr5005355b3a.14.1773456640441;
        Fri, 13 Mar 2026 19:50:40 -0700 (PDT)
Received: from eric-acer (36-225-72-126.dynamic-ip.hinet.net. [36.225.72.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07384a7dsm7417638b3a.57.2026.03.13.19.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 19:50:40 -0700 (PDT)
Date: Sat, 14 Mar 2026 10:50:37 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v3 1/2] sched_ext: Update demo schedulers and selftests
 to use scx_bpf_task_set_dsq_vtime()
Message-ID: <abTM_Rmi5NzZsf2b@eric-acer>
References: <20260313014944.1234667-1-yphbchou0911@gmail.com>
 <20260313014944.1234667-2-yphbchou0911@gmail.com>
 <abRBwZCwaYNqRSpj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abRBwZCwaYNqRSpj@slm.duckdns.org>

On Fri, Mar 13, 2026 at 06:56:33AM -1000, Tejun Heo wrote:
> >  	 */
> > +	u64 delta = scale_by_task_weight_inverse(p, SCX_SLICE_DFL - p->scx.slice);
> > +
> >  	if (!fifo_sched)
> > -		p->scx.dsq_vtime +=
> > -			(SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
> > +		scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);
> 
> Wouldn't it make more sense for delta to be inside the if block?

Agree!

-- 
Thanks,
Cheng-Yang
