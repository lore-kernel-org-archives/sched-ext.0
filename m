Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F56214236
	for <sched-ext@lists.linux.dev>; Wed,  3 Sep 2025 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910610; cv=none; b=iWE8C35zHNko1mpZNM+M8vdSBn6ZnTTOknmRPg6t4WvBRoUqzSoL85SyPQtTv0mlknuGNJc0osddEQPMRoC6veXERo67iArKglxYY8FicK8/Xr6AXI8kxUZdXPuKFbfh4TWaBBb+ZJ7VUsfeYGUIgD0t0qIYTcb6nBSKLSbeZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910610; c=relaxed/simple;
	bh=qsg5b1hCS0TH3mz58QfmV5A/hWbcjsLvlIP4yl/lCZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HQIdHWlT5PxmFg8jn7LQFYq3yo2ci0qnl3aP9ln7A3tzlPELnsR622BJoRvP52jM2Ri72tiYrRpPbEm8NFLJuCtnYG/Lxqqr2fG2D+4kfxgaKGffzzqpqesT9NEmGn5M2n9fjUCgpVL/xuC3T1maMVpuaUvJE9asvzf+iXkkADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmJBTmVy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmJBTmVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756910606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PCtH6GLs0daKTSTUdfVUnTaEI5cKFQFkvOMaqMYTXws=;
	b=LmJBTmVyKqKPQ3ECDftplN2Y2AuI+53jYd9LzYW2IpGcTpUWg42P7Rj5P+xOeTNBwFlxIc
	14vTVEMpYWmQ+3+2wuuvCtUv2H1TOMvYfVUlWhd9EzgyyjWjbpvrO5jTG/1MmpiqHlFfOw
	k9c6SE1twA3gYsnL9w+Qh78DXJmbAAU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-uNwM_6i_MjexhYelMStR_Q-1; Wed, 03 Sep 2025 10:43:24 -0400
X-MC-Unique: uNwM_6i_MjexhYelMStR_Q-1
X-Mimecast-MFC-AGG-ID: uNwM_6i_MjexhYelMStR_Q_1756910603
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb4f23156so13615e9.2
        for <sched-ext@lists.linux.dev>; Wed, 03 Sep 2025 07:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910603; x=1757515403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCtH6GLs0daKTSTUdfVUnTaEI5cKFQFkvOMaqMYTXws=;
        b=iYeugfHr6JpAO/Jq4vTY0PEMl7pX1GZACJrWFCjmDm8G9m+5z8+uVnb7OtL/0D2V/E
         9PrFq4oj/EzurkO90gulQJxs8LYVJFauwPSc4qNRMAywpMC//m2OXnAQu++U2uhrqcJy
         T5hUfs6CK/oYox+kuGQGjVN6ZAg+Yi7S8BdqXL0dOuPHdj88VE3wzRLzFK/RiFH/cB7L
         9PIwKchluBqYk/OoGuIWh4578DdDkvQbZ6LuFQGS15aGj8xlrnk7T5E4sK0I1i7CZXQe
         eiRGGGoCFZDKZnqMbDwuY7qfuQ/RqC2s68tIG0SdcwnA8JYDTB2/NQYCT045JjDBm1os
         fNwg==
X-Forwarded-Encrypted: i=1; AJvYcCURU2KkoLg8olRQpO+e6lxMo1sCuCWjOi0j8+bDgLCRPpl2o8JFilFxhJHsL8MPe2xnFY0fVEqK6/4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyRJXgSohLAuBjcLWt4rH970RoFA1EGG9NyJrpPjRtStzlAVn+J
	JX98dfaFmnyR9MsUcXF83/Hv3hlRXtQH94YDZ3xx9ZObx5mpnUaSUYacUoMZimbMyALCo3rwo7e
	7fcPhGkOdT2dcFnY+xxFYROvH6hzL+SRR8DLEUZOeT8ZOGo2brbG8yvJZrVQ91w==
X-Gm-Gg: ASbGncvUo4W8HRqHfOIpP8g3iiaEDlqEIGrXeVzDRlCrsjVkqUWEyKOH5hhS2fgrFmc
	xRytymumUWk9lBBW9GqcUafN9pM40C8Jnpaa457zyVEtuiC0ETRquh7V3m4VATbv+g/SOBm0o7s
	6SaO+Glqx1l2Yj19235demnx/OuTUhcPk6pC1BEOTglaPpue7Nu4h8rTYiheD0Baoedh+rTWDUI
	fg7aU6VsCCsYdzF6vcYGr1ujy3pMgHanRMrGaxORY7aMppmyge00Pene1R/bsDI5/O8gpBplH0l
	+PGUdWTrbJ+RF/TWOoQS1HuBKV2tkLp7UQgdb3vLP6dHxM9kCg+CNd2nQvmC3nG59yY97dY=
X-Received: by 2002:a05:600c:1f13:b0:45b:8ab0:59a9 with SMTP id 5b1f17b1804b1-45b8ab05bd1mr108070895e9.18.1756910603004;
        Wed, 03 Sep 2025 07:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF69gAChxFwcluBRYHF0+z51FCVtEVCadQL0dqsUkUmSsfKqXS/cjr5c0WBKbduX2OT6RRehw==
X-Received: by 2002:a05:600c:1f13:b0:45b:8ab0:59a9 with SMTP id 5b1f17b1804b1-45b8ab05bd1mr108070485e9.18.1756910602534;
        Wed, 03 Sep 2025 07:43:22 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b72c55c1bsm342903985e9.10.2025.09.03.07.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:43:21 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:43:19 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aLhUB86NwnaQ8bMf@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-4-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250903095008.162049-4-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n_EMUKJX9iTfWq_ZnnA-PGVVTMcYKpnTrNb-jAoNeO0_1756910603
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On 03/09/25 11:33, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Currently the DL server interface for applying parameters checks
> CFS-internals to identify if the server is active. This is error-prone
> and makes it difficult when adding new servers in the future.
> 
> Fix it, by using dl_server_active() which is also used by the DL server
> code to determine if the DL server was started.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/debug.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index dbe2aee8628ce..e71f6618c1a6a 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  		return err;
>  
>  	scoped_guard (rq_lock_irqsave, rq) {
> +		bool is_active;
> +
>  		runtime  = rq->fair_server.dl_runtime;
>  		period = rq->fair_server.dl_period;
>  
> @@ -376,7 +378,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  			return  -EINVAL;
>  		}
>  
> -		if (rq->cfs.h_nr_queued) {
> +		is_active = dl_server_active(&rq->fair_server);
> +		if (is_active) {
>  			update_rq_clock(rq);
>  			dl_server_stop(&rq->fair_server);
>  		}

I believe this chunk will unfortunately conflict with bb4700adc3ab
("sched/deadline: Always stop dl-server before changing parameters"),
but it should be an easy fix. :)

Thanks,
Juri

