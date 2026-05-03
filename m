Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA77B3C3452
	for <sched-ext@lists.linux.dev>; Sun,  3 May 2026 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777813865; cv=none; b=pkbJMeIBrn///+VRq5+STayzJZbBTnEQ0NUAXmYrwpIX6qmHSOHay+8hZiOBNBcoY14gQFFQM1ZawD54A8gxFkDNjnB2a1Zu21quuQYESMBEz/HL+nk7P4rWZOuRqLyBRRwiZZWuNML2h6Y+GAvuTYf6lKUriIVGXs1wbYIKLmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777813865; c=relaxed/simple;
	bh=ai5V+UUkPLDazc6YAKJCX9JXd8sc9Quh73GltaoiBCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddBfCgVZ3xXmKqe6mAjmwv/rDRPjMtl9cYqP3V3wcZleWneKHe7YKP98zuZOjHi+BMJYAr7npOoRJQS20WEQh8rOqzxsoCSBzsCKhiiLpj9FhLRdX2bIorwnJT6wgwV+8jJMEGi6PrLCNjxgGDxJNIvjwy/LqdVnMldafCxrs2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNweBjr2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNweBjr2"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-835c98b659eso172768b3a.0
        for <sched-ext@lists.linux.dev>; Sun, 03 May 2026 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777813864; x=1778418664; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q8HIXa9UkVZApYilYIFuxVyZm+x6ADD5Wp80rFVE9pI=;
        b=CNweBjr2Ht2ZiT5YetvuUM2fsLyP9I0LWP4pS8Twuu08diyIepfKn/KajMJ1cOVB2D
         AVkz+X6phS+VA7SKQkxdXZaJXM4hd9bEgRYje3TrT0gEJ6Ik/4QY9JhvQVvPLfzm2Mwh
         Cww5wu5NYZ/88ouBeBsMGg+tyPH19mav2Q9UtorbFH4mCJr94Dl+lF2rBcMDXiPu0Szt
         ynzgDW2ALsfJGkAisy3VHoKCzsWCtWWZK+iRzYm60SxZm20cb1ofSEi+3IRcH9iKGHfX
         iwoAekSrmvT//ixzkuRvVM9XSfakuLH+RbR1Xb2LJ/uKI3uHpg/0Eg0DTYiegyrzxP3+
         FvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777813864; x=1778418664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8HIXa9UkVZApYilYIFuxVyZm+x6ADD5Wp80rFVE9pI=;
        b=nqifvuLdzWds8dLgiE+esqION+XTwvJWWjgQmOFCX9mGuBvydc7MAWi22pwYWuCPvp
         r1gN2Iru9ku74ruvsfrZQ8nwL76FN5XZJi4RVKWyXjx/Edkjs+ZQQTCSqTEdIUzzChhG
         eY7M1P3VRGbW7BtRHG/0HgedT8H+CgMEkMWx1+9sFHMnolbF2JKT3UPu8brWxKzXUw94
         EBGK/bO+rGNftGV/VgUKtQzL4vMZ/BypMR2GXLRHQrUQFAHGQ+iP2iXj0em4iC6Z5YjD
         X2jD7ZLu2OodsyY3QehvIITj/qv8N03ObE7lUvc/ewa5q+TmrudUNgXDWut+pnf/6Ma8
         fPKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+h61rZkV6/VHoQSp0MrRCNt6ajES6eMuFCxutHx53hY7ZALKg7JJx/mkrrTX/nzxrwgC4T6QGJlzs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwnjQKd7bUKgbyzVNxds81MoMK4OIhjG9nv3Xjw/ej/ft7u19hV
	hYVbaAt4XCrno7my8ohWTOhkLYwHqMi6PRoXOb6GCjwx2J8oQpvDQ6x5
X-Gm-Gg: AeBDieufUsQO70luJ6nja/zyykK2Yxl2S+uSyRnMwRTgrTbexgaxvMI9PSHoa9JMKzR
	5KX6mJDXsaqVBDcMIhYrpCkjhU2rhMtwL4adbqHHChIPpWtTksJdGa5QUARYPgpuTgdKldRwfrG
	qITXkMvzGRB9ZKfsM0p6G9BKJoscHC5UbHs+9GxQUL6fKUE5mO+j2P1vqgqbw1jpadXm4sDDWWI
	2yIVK85fawLTH1K7vzIlbHXyYbaRZP/HFRYHgC0azEefmZj+cd6/MALTIp6YckqUzqWbc+9O0PY
	mmBXXsMzk8f+lO0tpaFaqC3uBT7BQ74xcBhDFZjlQyYWJ6xOF0FK4ypO8N6WO/G6oH43kn3LV+6
	AMJMh9NBBfRfXAa96BhWP1434BMO7bnI8mtE7fO7H4tUXW2DuPFC85BKOlTZ5DhQSpx5zf49l1h
	61rqLtzzuzttxD7/D6oeAZuGYNYBmQazQR74v/DqnTVUFZAAKvjTSygnXKNlWJH5efU3ZOSXdKE
	bwtv7fXfIA47gI6
X-Received: by 2002:aa7:9f07:0:b0:835:388c:9764 with SMTP id d2e1a72fcca58-835388ca073mr2974452b3a.37.1777813864051;
        Sun, 03 May 2026 06:11:04 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-77-225.dynamic-ip.hinet.net. [36.225.77.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835433e5bf7sm2503890b3a.10.2026.05.03.06.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 06:11:03 -0700 (PDT)
Date: Sun, 3 May 2026 21:10:59 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: tj@kernel.org, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: Remove redundant rcu_read_lock/unlock() in
 sysrq_handle_sched_ext_reset()
Message-ID: <20260503210256.G4259@cchengyang.duckdns.org>
References: <20260430084543.25137-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430084543.25137-1-qiang.zhang@linux.dev>

Hi Zqiang,

On Thu, Apr 30, 2026 at 04:45:43PM +0800, Zqiang wrote:
> The sysrq_handle_sched_ext_reset() callback has already been
> executed in the rcu read critical section within __handle_sysrq(),
> this commit therefore remove redundant rcu_read_lock/unlock() in

Nit: s/remove/removes

Looks good!
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

> the sysrq_handle_sched_ext_reset().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  kernel/sched/ext.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 45a2668284bc..0f3e9d088151 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7953,13 +7953,11 @@ static void sysrq_handle_sched_ext_reset(u8 key)
>  {
>  	struct scx_sched *sch;
>  
> -	rcu_read_lock();
>  	sch = rcu_dereference(scx_root);
>  	if (likely(sch))
>  		scx_disable(sch, SCX_EXIT_SYSRQ);
>  	else
>  		pr_info("sched_ext: BPF schedulers not loaded\n");
> -	rcu_read_unlock();
>  }
>  
>  static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
> -- 
> 2.17.1
> 
> 

-- 
Cheers,
Cheng-Yang
