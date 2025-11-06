Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAEA2DE6E3
	for <sched-ext@lists.linux.dev>; Thu,  6 Nov 2025 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413228; cv=none; b=bWeFlgJUA8vCcWYrGUjQhzwlwg+I1mm1Fd8+Y87ZxwEiZMZKZhfSKqezqmjIyjr5On9Ztx6Nqiyqmu1AWUAGxVvUsCqoBUMLlTamAtZqcuu2s/so5uL0ueppchYaysvcXoLZp+jzyFzwPvC0HdF0IH+/17FJ1ttq1Y3TesehHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413228; c=relaxed/simple;
	bh=O8Kuzgwo8NxVtUGQ/sqROsYTAZBIAHhIOZ8Fv83q4tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gyGOzP5YAgZVBDL+y1uQ03WGA0TvmFnsPSPT9rtH7dvvF0cYBuMIPJ1juHapQlW3LV7H6Rk2woIeneqFiyNhtf3IpaB4+tBp7Uw1RtV4BySJAkppq11W5KN/c0VmZxaAeqtDqrjmnOPmo0yrY+ipMkfASmkjkmipykNfvQdUB5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6yd/VU7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6yd/VU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762413225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOLQ/S3FFuFAGuSGNX4WWksMd2R4YXO/SrRbOgkSfy8=;
	b=I6yd/VU7kFDTDecxOHd4RW+YKdBDkW0WlZlmLccTtbk1Dbrj7aOHDMqdogz2Tth3ZVwVhu
	WEY/JE5mv9M1aBGIwWtqAK1ZG1qyb/6WfRCZMe6eHciGBw+s7mJQO46rKb3E33bjExIFV8
	6M3HUu3LxSUCgx1IjrmPL6FiWwuRV3g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-AgO5SzbkMeyJKCKxFyUfBA-1; Thu, 06 Nov 2025 02:13:44 -0500
X-MC-Unique: AgO5SzbkMeyJKCKxFyUfBA-1
X-Mimecast-MFC-AGG-ID: AgO5SzbkMeyJKCKxFyUfBA_1762413223
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e39567579so2804615e9.0
        for <sched-ext@lists.linux.dev>; Wed, 05 Nov 2025 23:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413223; x=1763018023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOLQ/S3FFuFAGuSGNX4WWksMd2R4YXO/SrRbOgkSfy8=;
        b=DDKhLd91s8jjBbITXrngq/bdxkpZx0PwFQOc06Yf0o5TaOAN84hPF8S3VgAkL5hKW1
         Di25aSvsPu/CItVeOZlw+nwTpfrWc70hh2qJuJLnWilk6Z04bB9qSQ9r3N8UssCP7TJ5
         8csA+Byf7pP8gltPKFypiv5dsDBhtBCnhX0tBlTC3533cw2U5tiKwyPqInMWYeHMS3Pa
         BY+Ww6n0TvePxcQngFz2+k4PJSKuGeFp9iVl4Zqd5i0E2o0Ar3uHpiI+y6t5ATTHGwiB
         wnfiw3VCK+QhWemqBISlUB7goCUnXwTuFIqvJX8DAcYXlJva6e3FDrXeiNvZbrFE3ZWo
         LWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXISJ85Sw7EdplrKTqGGMVqdWUnLbwzwQQoznn+JCvUekkQhMEqKjGSIE5OLhJ/CKoylaKWMt6GJCA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzxpuXknHTrtqnBKrcL0c8jZZ/BZbbL1C0HeC8Ma0ORfb/LbVe5
	mg2QtpwTL9r3u8IfF4s7wa8SRzCLb7o4rgpJg/dnQb2W6k54UwWTYXsxskqF6ykm31maE5hc81H
	GM7GV0TQ9nTzV297AvNqzqPeGzLzBEV/r6rQKGee6fNDR5xxuOCh/F79T26gHvw==
X-Gm-Gg: ASbGncvkKEPkqt6/TJ0yXqaWl4UNIBPu6ubzi/qp1fHyUPboXEJC100dp2vF2TyZBon
	RuEBiiPzDgXY3bbTIuvxy59v/8s9EWpd2jXeS7i9EYlBHCRqCvpQ1cq9FHhH5sPyoNVcDy7VUk+
	/M7wLJQSPsDZj7ULtk0aJo1HOeYHDQcrMIRjk0XxLZDT69AIpocaVKx/Zt94RI9ux26YMJOCP1O
	KLAI3VgbxJDePiPcmnVl2D5fJ18rHhE3PzBQfdIT3wPvj48qVwwNqAJ37X1fc5mjR1yIwgt/9LK
	nlVOY3TS43WsAqgzMNSqhb1g0xVa3TRT1DwRoN5aRDjAJScaGS+T99SYnnYlHe447XvWToHWlGp
	2Leg0CQnSIpath9CJQ7KpeykbA5y6Uw==
X-Received: by 2002:a05:600c:3112:b0:477:54cd:202f with SMTP id 5b1f17b1804b1-4775cdbd575mr53958465e9.3.1762413223141;
        Wed, 05 Nov 2025 23:13:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUu7ukY7OdyVbeRYFijYbMWBIebeXNAL9BcWIWvL8Cng+u4L3PwJcTQmxc3W42nkhzCF1KSg==
X-Received: by 2002:a05:600c:3112:b0:477:54cd:202f with SMTP id 5b1f17b1804b1-4775cdbd575mr53958155e9.3.1762413222738;
        Wed, 05 Nov 2025 23:13:42 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4adde4sm3235490f8f.46.2025.11.05.23.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 23:13:41 -0800 (PST)
Date: Thu, 6 Nov 2025 08:13:39 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aQxKo68TJge5dRZI@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251029191111.167537-3-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: itxNPSJbM3uew__qX3v-abrUgKN2B6MrOiKeN8DS7kk_1762413223
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On 29/10/25 20:08, Andrea Righi wrote:
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
> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/debug.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 6cf9be6eea49a..e71f6618c1a6a 100644
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
> @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  			return  -EINVAL;
>  		}
>  
> -		update_rq_clock(rq);
> -		dl_server_stop(&rq->fair_server);
> +		is_active = dl_server_active(&rq->fair_server);
> +		if (is_active) {
> +			update_rq_clock(rq);
> +			dl_server_stop(&rq->fair_server);
> +		}
>  
>  		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
>  
> @@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
>  					cpu_of(rq));
>  
> -		if (rq->cfs.h_nr_queued)
> +		if (is_active)
>  			dl_server_start(&rq->fair_server);

Something that I noticed while reviewing this series is that we still
start back a server even if the user put its runtime to zero (disabling
it) and I don't think we want to do that. It's not of course related to
this change or this series per-se, but something we probably want to fix
independently.

Thanks,
Juri

