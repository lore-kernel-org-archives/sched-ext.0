Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D33F1ADC
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235179; cv=none; b=NBodYT/y71IdYu4xqsTCCY8LjE9EZOtwxhiBfUz4KcxP8iNX6xriPNzk6wn7zv0fr04GX6ICWG3y/ylf5t6y+C2Bf7+GCwM3Px3EiiPFEqdeV2e+DxdeJ76WWFLuFCtkE5qoC+fYjHjSG/R+kDe4PAJioIX/fwjOGv6ME6uMZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235179; c=relaxed/simple;
	bh=qpSpYBhIpJtMXaX73sqUbb/dClW7iZn/LKMcEnuzdf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ7ejkZZWOzI6FpPSpxmYm6mqa15+4ToJ/1I6wM9xEos3TApRZXEbzNO+9tEBpvxH85yLDGZGXmtoshDdQU/cgjwGk1r0INUK1CDIK4LWzRUpqr28Uj+hJNajyttRzCN1Fdv7ZvR8B8XH479aIkxsvm750FACjPIGxBy9znvAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=zlwvHa4q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="zlwvHa4q"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso18755195e9.2
        for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1785235176; x=1785839976; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hh9GGg57kuY2hD4zZm36wFzr1EZULMRj8TJL33H+8H4=;
        b=zlwvHa4qeiyWDpmp6/S6T1Nja4ODAs3+1rE1iWeFHLBL1tbIMEfSmANy857q7CpNYZ
         rXKjLMzv7VHNYGAtSU9SP0XrM2OkIfNA//+6gS0ThUzilKOubUG+s4YHgUPZ1NZihV/e
         dMCjT8/C/f5Frs+oWkMaDwYmASbMoxiTMguC9OCIjEe0mm2e6q2R8kXCjBqQc+pInW9f
         8eRCDhsL0D/k5Ir7N/JIEahdLGAdpDPf6j405Kl2y48/u3tulmfd18krwjP8E9CyWNvr
         aqwLLiLH/V7ysnGNz6AVkiQWddE5HpHHQOnVhgU3HQ3k3stpthUBYvFi84rYS+Yl0W3w
         gggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785235176; x=1785839976;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hh9GGg57kuY2hD4zZm36wFzr1EZULMRj8TJL33H+8H4=;
        b=nODTcUT09/TJTCq3uYd1uGQug+Kws2CPe32BBuXn6Ovb3QEpg5HAtXliXjq3652Qvg
         XJb67EpVoEF9dvJfq3iXWZB6uGi2TUCZDl6/Qu9NnWhuoW+rVOZjdz1FksgnVeODAOKS
         N1WtyXN8FxEMW1rZD7BQdTVpTKlVg/YknYRr1gxv78/x03nMGz+5iD25K3eXYSVlEphr
         NGM0kBYjNsVwboiZAllmp5NY792eSafst2EnY8duC7npjELrOe9nKQuHKnR/O1xdhT06
         WdvTxFMV6svbq/64eAh7Sms/vyFAkHtShCJmkXdMyhsTJ5MT0seJYSZj7mvjisVSdB+h
         7qhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1D1W9+nAC6cKAER+EKxB3UV5sq9kWgsZBhlgu6fNRxCdSx7xgjI/hmFKRMux70C2OxISeisX0dsg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz7g+8A4QDpIymGVXjs9zIBKMUj85rpgXxaORrRNTxMLzlH8q6
	IGx9tRifnX03KDFajUt/YGUWv4nmLTxr9hzaireJmEjbg6vvVGyRJdQ9oVqK/4IAe8s=
X-Gm-Gg: AR+sD111Qez/Qcbiko09xmDSTUL1WVNVQO7V38H/DQGfjb73caOkzYS+RS8kmkA4jJ8
	qirsyAMkaXP3oobBMjS+QOFuasaW534Hia9KkIfCRUxD66tQtfoQtesxW1pKdnya9PiPl631to8
	HXu2mA+sxc2AopKvIu/hTUJ3Wa2Ru/ywafZNASZPzRszJiFmc99NvQze5RCjhFGQHDlykpCU7LB
	PVasFQORIR0An/g+y62ei3RnHwqJuo2H26GYwe/uEcuLBo8gYKg5lgbKqkCiC0FlsVbVI7lTI/D
	Kif6B9LQWAkD8GE0he0MA/3VfOYs6f5fUHy3rGCEb7ntCMW6g/6eFpMo/ja7TiHZekthEGt+YeU
	gIawL3ARRmTUB0iFBLQ2XjK+mYVW3GEAU8H1NWuoegUgFvf/MdnLtRfUXs8iwgwPjiyk8bS5DpA
	==
X-Received: by 2002:a05:600c:8b74:b0:495:4b42:8677 with SMTP id 5b1f17b1804b1-496c657651cmr19071605e9.18.1785235175708;
        Tue, 28 Jul 2026 03:39:35 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:26a0::3d9:b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfd1a60sm293299405e9.2.2026.07.28.03.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:39:34 -0700 (PDT)
Date: Tue, 28 Jul 2026 11:39:33 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH] rcu-tasks: Defer IRQ-disabled callback enqueue to
 irq_work
Message-ID: <amiGJWJ-tzUMYizu@matt-Precision-5490>
References: <20260713101245.3207634-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713101245.3207634-1-matt@readmodwrite.com>

On Mon, Jul 13, 2026 at 11:12:45AM +0100, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> call_rcu_tasks_generic() can be invoked with IRQs disabled, and on
> older kernels this exposed an ABBA deadlock against the scheduler
> runqueue lock via sched_ext's task-storage teardown path:
> 
>         CPU 0                           CPU 1
>         -----                           -----
> sched_ext_free()
>   task_rq_lock()
>     raw_spin_lock(rq->lock)
>                                       rcu_tasks_one_gp()
>                                         raw_spin_lock(cbs_gbl_lock)
>   scx_exit_task()
>     bpf_task_storage_delete()
>       call_rcu_tasks_generic()
>         raw_spin_lock(cbs_gbl_lock)
>           <blocks>
>                                         _printk()
>                                           console_unlock()
>                                             try_to_wake_up()
>                                               raw_spin_lock(rq->lock)
>                                                 <blocks>

Hey Paul, it looks like this didn't get picked up and now won't apply
cleanly to your tree. Should I submit a v2?

Thanks,
Matt
