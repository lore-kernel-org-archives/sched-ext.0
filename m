Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156C2E6CCE
	for <sched-ext@lists.linux.dev>; Thu,  6 Nov 2025 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426818; cv=none; b=n/X4EkX+O+Z1oIEC5czI6M37/utRma2X3ldjyhE++nPV4Si1wbjwqpejJh/BeKEVXQc3eFKYnBk6qetp3MUQbigDhNFi5IEk3UECD/yUIrXSRzrqPT9VTpQ30Cuyp6G/EkrPA9eakaWyNR9xbjY/9PMSRLG747QptCXuiHp1+gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426818; c=relaxed/simple;
	bh=XhdNPhgcKwRHGpsghZqwpvIX6EwSAeLHReIqHW0vxw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BNfpaaRYhOeJDewBmvNZIeWFJv9jl0B3SQRtRGOitF+AyskxpLwWLzs/Oil7Axb+3BPDlEdLHgxaekTxS1B2R9NnkCxJ8Kzd3Z11N9EAGM7RGzRKRJAEgKll9um0t+QYbx0CDoDciuQH2wl+VzzjaXIe4Rz5EtkTE0GLlKRfBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wn4jl6Nf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wn4jl6Nf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762426816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dukGyhpRYfvrs4wKeywqzuHqeO7YctCXQ09D1HJF/+g=;
	b=Wn4jl6NfI+6iQD5clKwhZupkRBSdm0qMPi31CckODojomXxMpFBT8N7kCpUlidI1ZFk3uz
	shcZkLlW5DUt2fsOBgx+2NxeES5UefBsLt4uvEwwPvA1FkfNTGNc6TLUbNwiamoe0aGRFh
	akqbJu1qo09FdUT8uMtttq0vguPfqlM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-8MOfGFW7M4O-nqiAOTU-ZA-1; Thu, 06 Nov 2025 06:00:00 -0500
X-MC-Unique: 8MOfGFW7M4O-nqiAOTU-ZA-1
X-Mimecast-MFC-AGG-ID: 8MOfGFW7M4O-nqiAOTU-ZA_1762426799
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471001b980eso6441995e9.1
        for <sched-ext@lists.linux.dev>; Thu, 06 Nov 2025 03:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426799; x=1763031599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dukGyhpRYfvrs4wKeywqzuHqeO7YctCXQ09D1HJF/+g=;
        b=U716J7aKIDQh88O+HuYbcjvP8JxWiC5KlDD8OHrhiG88p/FW2NpHFnyDM7UMTGPhQC
         9jjrccZNENykUs+fSejp5y70T/ZWegyfzQFLU5zSO3WAYF8U9f3BN5V+HoBJypzOkXxB
         BN+X5Rvvr8jKcJVu0IIRq+xZfdoSmL/pIWAas3PIBJldTxwgxDvwceaKnAM8L3bAN1dk
         ir65MnWqu9iS+nfEGTNON02WuOjFHPqRr8GqkUotXRjjXllxORxYsOQeC6azHb4EyC9o
         Xb9vVab+mrGjdT6xh5fL9LbPwZc+O8slvMqEf+6zD442AaLpiaPBQ/bb8XMlzp9l3Gby
         FjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgIex772JV1A0huXG9MaSjnX58A6S0V03PTGuVL4OmL6lwMrI3bU1ROCHrovpCAw5MI5ZrgO0NO2A=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd7uNUyGpbYHgfHtvvoOeDk0L3b0p7FI4uyeG7NUtg05eSe6pG
	Px5TAJYYPKbWl0Nfc42HYQGAKFBDvkFB9XEaDeBzOv2vz2pEF63F9yrRIDqjvADa6QE54AJU5Ky
	Rk0WI59Xo6ejVgtoviS6v5X+MFI4DC1TmTIvXN10ay52QaoEty+Oc8YOlipKifA==
X-Gm-Gg: ASbGncs1+t8uDZJ82z6/75keu8C+ZVYaPDw3YgIO+G3kygXOkNcGzWoSKESYuxbywhG
	9MJvO6cmyLYZQ07i4S5TnsrIWPuByg6qdmVKyNWEX7zuRYmrNA7nPW0WLVahcIWYhjDjLdoFn5u
	MSudycBprFuVux5SXbXtuGujr9oo2bezNg9NIWNUtyjDe09LBBTC4bipnph6QpvIQvyyePAxLVG
	RL2/o3csbNMFF0rINqIbH9EH775rG52OVzjjVdMvoUxIUNaZBAf07nqLXnMjwUM8NYaQOx912Or
	yLG58iOgB9WYgFymCCdSzcmOQLQua3YIogxoCX0s0K2RANHrzA6e2gMi8X+cBvI8SjcUmgatw6t
	HicRmGu1QV7hSdUbztBU5QfNYj0eeQw==
X-Received: by 2002:a05:600c:4e88:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-4775cdad71bmr51439575e9.1.1762426799380;
        Thu, 06 Nov 2025 02:59:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW1NbZGtrlA4TV+fO55QhvpfF+mYk65ZcCXIRCNO4lkLe3raDP0AR7WU3owI3VJ3NsULGBOg==
X-Received: by 2002:a05:600c:4e88:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-4775cdad71bmr51439335e9.1.1762426798983;
        Thu, 06 Nov 2025 02:59:58 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm108508305e9.6.2025.11.06.02.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:59:58 -0800 (PST)
Date: Thu, 6 Nov 2025 11:59:56 +0100
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
Subject: Re: [PATCH 06/11] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aQx_rJccmaJEOAUk@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251029191111.167537-7-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S-F_Zev8GhajTSyiRqwdnK9AOTWgNm58EuIL6k8CbFc_1762426799
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On 29/10/25 20:08, Andrea Righi wrote:
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.
> 
> A kselftest is also provided later to verify:
> 
>  # ./runner -t rt_stall
>  ===== START =====
>  TEST: rt_stall
>  DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
>  OUTPUT:
>  # Runtime of EXT task (PID 23338) is 0.250000 seconds
>  # Runtime of RT task (PID 23339) is 4.750000 seconds
>  # EXT task got 5.00% of total runtime
>  ok 1 PASS: EXT task got more than 4.00% of runtime
>  =====  END  =====
> 
> v3: - clarify that fair is not the only dl_server (Juri Lelli)
>     - remove explicit stop to reduce timer reprogramming overhead
>       (Juri Lelli)
>     - do not restart pick_task() when it's invoked by the dl_server
>       (Tejun Heo)
>     - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
> v2: - drop ->balance() now that pick_task() has an rf argument
>       (Andrea Righi)
> 
> Cc: Luigi De Matteis <ldematteis123@gmail.com>
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

...

> @@ -1409,6 +1412,15 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
>  	if (enq_flags & SCX_ENQ_WAKEUP)
>  		touch_core_sched(rq, p);
>  
> +	if (rq->scx.nr_running == 1) {
> +		/* Account for idle runtime */
> +		if (!rq->nr_running)

Hummm, didn't we just add_nr_running(rq, 1) before gettng here?

> +			dl_server_update_idle_time(rq, rq->curr, &rq->ext_server);
> +
> +		/* Start dl_server if this is the first task being enqueued */
> +		dl_server_start(&rq->ext_server);
> +	}
> +

Thanks,
Juri

