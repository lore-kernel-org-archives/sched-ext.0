Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48204B0E34
	for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576433; cv=none; b=pqnxwFm8OFB2XZU3qab8kN5LZBhcmCNmljzGige+Yvlbjem2p7Dd2yKy+LdkhNysxQTQkQ58f5iFKBaXPsb/gOS3TZHS/MFVLe9ifpF+WNQK3iEGjlUd4l6BsaC/HSaiKsyR8ekjCKfZvxT9sIxS2IWezAynT0exQ/uQ5lYhDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576433; c=relaxed/simple;
	bh=f8N8J/QeuskXk440ymUEmj2Y7405//1kx3L7u8wZWLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOkvS4EQtlhdMLv/AwghmTmNBHonbpbVgKHqccV9EQUP2R3+Kl0V8jpsWKVyOedT37W6ogBnaGeevbT1famcxPvhrGDjDSS27l+FYKO1Kv/6Tpr8DR9TY8RJ2LUvMc6DoZ4MMx6XneigPi4ENd1Sh1ft1N7mp+NyflzA1QmNRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1uOLpXX; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1uOLpXX"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so11197565ad.0
        for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789576431; x=1790181231; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LHB0XwQ4+CIcg+wjl8r2PjYlCOQaNGhUptKJ0BrRtuo=;
        b=F1uOLpXXXDv+q2yhUI0BLUxMtluhFFWp0XBGSgPenRt2GtWEasa5bDBVG+ehPnwmeQ
         jRkC0EIDbqN5rvVHSbdWpeT/enPzvMOTLOL3cAVYPZsNrphtmUQtMUVN8Pb0+Ctf1FEr
         vcYQ+C8hBmnl663CUJ4teg5CSWVEGeno5VcD8Ti2G1oTtLyj+6M9itXiGA4mQjKhGljC
         9l7AFjWt8sdQy7h9eHmVA4YzW1cJba3p+y/mcHxB+fC0Pp/mS0j3MMsQNwL5o8i0s4dg
         UIo19EdnKH3T5rFRJOPFa0AvRgtk4yeO+zuIqHKn37wvhj58SiyhHOmkwSl+yKKma7E7
         snuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789576431; x=1790181231;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LHB0XwQ4+CIcg+wjl8r2PjYlCOQaNGhUptKJ0BrRtuo=;
        b=RYvUe5b8YDPA36nTOZM/j+dEa+F2p7aWVS4PjJe/iogVViySDSW5KPyWQiRBF/9aWk
         /IrxyXpCwgGn9RHDmtbXol7QDel8sPlMt2l9kYbVWR7MPeO0C/R8myCBjhQVJR7aM0U8
         /ZMkFCCXnnM0+u3Wz2iZuMU90Pye+GDPg8NK+WfX9hmscjjE13P+k38ojzvsLoolTAUg
         R57vy2jaGGokU3RkTNx4idKJ1dlvyepYShxwx65EbsLaFK7deVEFJn1LzvFuWp2LhuWC
         SQhoOEKl8UBxikNJsdnzmzTOR9pEv+aabag622o2x9a5zy1VontwYAHdK9w03Ww7+QM3
         D+Jw==
X-Forwarded-Encrypted: i=1; AKwUvBy0ETp0zEh6MgQyvOXVY83RIYDVJbjDX4q5rHuKMEqJ+PB42sLTK7Z7SDEP62is1rjLIqbTuUSR3E4=@lists.linux.dev
X-Gm-Message-State: AFuF++lAdRgeEMR9ayv9E5G35z1WaSM/sfq23Lk8wHXyV7kfhVFG6Z+a
	Uez5XTEm6Mi/lPpxkU+yTcn+3n5QIittvZbl/BtXX3Fnwkomkr8OXaXF
X-Gm-Gg: AYBFou3f8xoTQjsNkMk2CdLTn4LzQxZ+EdNnzusxbCgxpvQF9WZA+Tuxw4KRssuB+zX
	4IFd59wTQIHYFq2sj3IuHrbpLNt6nbGbvvhA89HzX40Ruvllxj946GKf5hUPEOzMi8ATVaw4wOl
	syeBdQXDRzYlBDr6oIsPZUN7L4pucl87AFxsqkeJywYZgjQs6BvyiXmHg7tNn9KtEJ3oiU1ZGt3
	eQcBv96BvKQTgOU+FKo3dfQUwQZNO3prD3rmq6m6qYMa0gz/ENGnaeVbU0lG/Szl/7YNP9+cRep
	Btx4bG4PyehQs/Tqsd9A9MEss4NQvzcFgepfW/3bkyAzNWUj2CEeN5c1s84MlQwS/JdzyzkfwEf
	uJPDp4TUqSF2BT9JNcoqeXfChH5M3a8xmz54U4B7YYKtM+rAspTfAwx8bKLZVW0WUpFGsdZhwls
	j+Mdh+ADofkNjuERdOKD+r10S2s6vjTLJgQQG4nJpsTHUoLWeSJo3zga8MTb6BtMziGAQF/7LZD
	/fWr5nFKRWPZXeNbyO0uqiopAuSQhm5jJHSMYYSt4trky3fyvJH4LDy0ISQ5ueB3LPwbdEIGGFA
	aYGNngxN
X-Received: by 2002:a17:90b:5388:b0:39b:92bb:9eef with SMTP id 98e67ed59e1d1-39e1e509fc1mr7522790a91.22.1789576430914;
        Wed, 16 Sep 2026 09:33:50 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-226-250-24.dynamic-ip.hinet.net. [36.226.250.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e362ea35asm192984a91.16.2026.09.16.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:33:50 -0700 (PDT)
Date: Thu, 17 Sep 2026 00:33:47 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Unlink pending local
 reenqueues before freeing scheduler
Message-ID: <20260917002903.Gf17f@cchengyang.duckdns.org>
References: <20260916145807.3250167-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916145807.3250167-1-arighi@nvidia.com>

Hi Andrea,

On Wed, Sep 16, 2026 at 04:58:07PM +0200, Andrea Righi wrote:
[...]

> @@ -5380,13 +5380,20 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
>  
>  	for_each_possible_cpu(cpu) {
>  		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
> +		struct rq *rq = cpu_rq(cpu);
>  
>  		/*
> -		 * $sch would have entered bypass mode before the RCU grace
> -		 * period. As that blocks new deferrals, all
> -		 * deferred_reenq_local_node's must be off-list by now.
> +		 * Bypass blocks new deferrals, but a request queued before bypass
> +		 * may still be pending. As run_deferred() runs under the rq lock,
> +		 * take it to wait for any in-flight processing before unlinking the
> +		 * now-obsolete request.
>  		 */
> -		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
> +		scoped_guard (rq_lock_irqsave, rq) {
> +			guard(raw_spinlock)(&rq->scx.deferred_reenq_lock);
> +
> +			if (!list_empty(&pcpu->deferred_reenq_local.node))
> +				list_del_init(&pcpu->deferred_reenq_local.node);
> +		}
>  
>  		/* remove the queued ecaps sync so the pcpu can be freed */
>  		scx_discard_ecaps_to_sync(cpu, pcpu);
> @@ -5395,7 +5402,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
>  		 * Bypass blocks new kicks. Flush the kick irq_work so this
>  		 * pcpu's to_kick_node is off the list before it is freed.
>  		 */
> -		irq_work_sync(&cpu_rq(cpu)->scx.kick_cpus_irq_work);
> +		irq_work_sync(&rq->scx.kick_cpus_irq_work);
>  		WARN_ON_ONCE(!list_empty(&pcpu->to_kick_node));
>  		free_cpumask_var(pcpu->cpus_to_kick);
>  		free_cpumask_var(pcpu->cpus_to_kick_if_idle);
> -- 
> 2.55.0
> 

Though I couldn't reproduce the issue on my end, the fix lgtm. Thanks!

Acked-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

-- 
Cheers,
Cheng-Yang
