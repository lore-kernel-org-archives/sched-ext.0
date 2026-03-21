Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4BD46BF
	for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114282; cv=none; b=ocx/azFsURuWv1+5sKKOlATA/2I8R3YDZEbXH0xV1L1inwZqx3eqjufOBc60ymrPYRHIbXlRbg24XWTHa43Z218hNHvrkvERIAoxl3WfXm29LmVPeDO7nXEq0qJ/Mg5NcB5sEYm9gtm5Q/KbFluz23fpf0p329Az/HTckxwa5vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114282; c=relaxed/simple;
	bh=Jn/aRTq1WjBnmAYVgdfBeRcaBC/w/+zC/xEvqe5y6pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWfK/zTBidCxTQF3wnmKa1eFR6iGgiztY3cZ3HY5Uu57LAx3Uanyo46K4n7ug+nrFYHWDtZ6w/loxpMfPd492jP7EsoILosneRLHXRICqonkZXh1lWAdJDL/TJy/MzrUDSivON/42dvhp5vkimg2L4QPy87YnGiP9pedZjdjn1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9napvku; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9napvku"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a871daa98fso13123215ad.1
        for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774114281; x=1774719081; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLNBSxRzye3XBBwLh99ajHOYMU4FjxaLAkI4aDyFYTk=;
        b=Y9napvkupyEyrbNgebBkj1glFRVAGxDaJYxWP0/beoYYmMiJBAGc10F1ZtNlzWdtmh
         CwG6ITWQGkfZ0JqwfnKkO7H9ukkMbSDfyPnyJaSEAVAMPo4QprvjW5e54lWI5CLNAYkY
         u7ukwlD/bcQQN/R8tuxuvoRhyuyaQOeJXrL/WjeYWQf2lV60nRno7knzW+V4VjGaOv8X
         T7iCA1qDNt6/oWLjf+YZ14BvHimXBJO2TUD5nWYOZIBbfqhVgYtjUHfY5K2FLgaPHfOW
         6BTQwQyDB+fHvf1phmAhnbvx8DUEHkO04M9ZCrisI3pa8D5uoaSEdnOb+Zn1AsaS9GUK
         F1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774114281; x=1774719081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLNBSxRzye3XBBwLh99ajHOYMU4FjxaLAkI4aDyFYTk=;
        b=eV1o7X2qAQrSRLv99PapWTbXARAJCQ0HiTQmCKmBjXNA2F1CunJP5QDxZFaFJ12WkO
         yWGEfLdPBTBU9xPhv+ly39+giaoUKGmSLZSDwRi7ouUOxgeKtaM0gpMPDzHpDnl0yulv
         vMt/wOX2arL8chpnhEnasxsmfL1pxpy6z0KB2u2L/BiQQvM/8vYBLtHC/IZBob3q1HYQ
         F5d85m/ZY3vArQcDmJ6EzZ6HOtHV0QlbR8MAz0e2Zz5qC6wz1waZdBuOJDZn849TQNlD
         7sYNF5++vqqvdIGV4B74gI+DAD0awMcjL8SZI8RclFbSIuDnbdalEe3PyNGuJhAgiVo9
         RYXw==
X-Gm-Message-State: AOJu0Yw1l+BtroHzO5IaUPYG2MJwWaSdliowuzCBkPxy0wk36AnaLFVv
	q0EMwJil3/Y31JaDZiHWyfntnK4kb/dIZAzgt0czjC3thvcwchxnBviT
X-Gm-Gg: ATEYQzzsknWIzdhvYq9Oz2muAmthOLkaGrauO4o28o4J4994Ya+Okl6vA90UyWJwlHE
	RqBklyCPiuJ5IXVR9Szt1UbnJXMD8BZsdNV5F9xsYLa4yv8MfwMTr+8KxB0bTrMu5apUUQ1cEA4
	StVdh3jCx51u+nEK/8uQrcdHtlaVklRUqTGpo/QPVLjGqB8kT4jIsOnTmpZ3MtlPhsxA2mjP3yy
	gJEb5edPHohLNmUc7UotOQaZ/FkZlH1tNWs7yTdjnt6Og3+eWonLNLGgprlBSv+me8+rIeLT7bF
	XjSz7uqWvSnTc6emD/IJGbq7A4FeuRWGv0SyJGJQpSQCjm+QCEtO/bbp60Edczxnz3Ahq7QIQ+b
	GeBEMaDUdCDrfo++K5x0vqs7/yzyFt+1ncG8vlxrBf9EhXtnJBzHx9161vbzHriQybr3Q/dqN71
	0gSoscjFkuEr+h3bTjBuYFboC1+XPO
X-Received: by 2002:a17:903:1a4c:b0:2ae:71f1:5a68 with SMTP id d9443c01a7336-2b0827c9b6amr58095595ad.43.1774114280792;
        Sat, 21 Mar 2026 10:31:20 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:e49f:fa98:a4ba:8111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08368ea1bsm71318825ad.68.2026.03.21.10.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 10:31:20 -0700 (PDT)
Date: Sun, 22 Mar 2026 01:31:12 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sched_ext: Fix build errors and unused label warning in
 non-cgroup configs
Message-ID: <yuh3nmuuw3l5lkardtnkqxtaftcsmyiqan5uhazfmtxtwblygn@xikzjdwqgoez>
References: <20260321070605.691776-1-yphbchou0911@gmail.com>
 <ab6sqIW4p8QKYQXA@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab6sqIW4p8QKYQXA@gpd4>

On Sat, Mar 21, 2026 at 03:35:20PM +0100, Andrea Righi wrote:
> >  
> > +#ifdef CONFIG_EXT_SUB_SCHED
> >  err_stop_helper:
> >  	kthread_destroy_worker(sch->helper);
> > +#endif
> 
> CONFIG_EXT_SUB_SCHED is always defined whenever ext.c compiles, so this one
> is unnecessary.

Oh, I see the dependency below. Thanks for pointing that out.

// Kconfig
config EXT_SUB_SCHED
        def_bool y
        depends on SCHED_CLASS_EXT

> 
> >  err_free_pcpu:
> >  	for_each_possible_cpu(cpu) {
> >  		if (cpu == bypass_fail_cpu)
> > @@ -6514,7 +6516,9 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
> >  err_free_sch:
> >  	kfree(sch);
> >  err_put_cgrp:
> > +#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
> >  	cgroup_put(cgrp);
> > +#endif
> 
> This ifdef around cgroup_get()/cgroup_put() also always evaluates to true
> because EXT_SUB_SCHED is always true regardless of EXT_GROUP_SCHED.

Understood, sorry for the noise.

> >  	return ERR_PTR(ret);
> >  }
> >  
> > @@ -6603,7 +6607,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
> >  	if (ret)
> >  		goto err_unlock;
> >  
> > +#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
> >  	cgroup_get(cgrp);
> > +#endif
> 
> Ditto.
> 
> >  	sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
> >  	if (IS_ERR(sch)) {
> >  		ret = PTR_ERR(sch);
> > -- 
> 
> This looks like a false positive, the kernel test robot likely tested with
> a manually crafted config, so I think we shouldn't apply this patch.


-- 
Thanks,
Cheng-Yang
