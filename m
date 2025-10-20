Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8520F2ECEA8
	for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951540; cv=none; b=osrMqHYT4J5QEfZvN9khsFRf3P+/PyqbcHvmf+nK0glc4RJyXpzW9DsHwu9bGa6fsfK4nKSxbNN62VGNzNa+oXZ1ON/iecnzSKiQcm+DEATpEK3uJxzh+ICW76E5aZe6SYShS51fSzsl7GxzeqOOzH/RTZ9XhlclG9ppFQTezRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951540; c=relaxed/simple;
	bh=ta6LSkk+9A3FVM3mm3iDzNK4zuCKnQq6jaHDvp/Xdvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ua6F1RpqqatdeTOCBqVyqqZ6/F629gtxDsD+SZdj6jE63KY3P3TmBBMHbD6klf4MMW5+dHm2+lj9Epr8HQuhm4KGC1DC3ii4r2hL2+zQUBBCoIICdSCJbqbZtWNW+UgF003bQQVLFoX/uULpTIpbhWJ7f9vbdQvIzijlsg20l6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeGVoTKX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeGVoTKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760951537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ubitj5/uevHZU/7Ly6xrweyvQaOv3M8jgDaIwUyJNQ=;
	b=ZeGVoTKXvEbbW8IPvEYHI1L8b1+Pxr5GGu56qPWq+7kqrux7tYno7Dj27J/pTHaB1xX3Az
	nTtD1D54NMOIx5bnJvC+EYp1+1ZhDTo49J7t2lSKB20e1MwlftEe4qJGkghVGtY1aXlsq2
	yRecLrgmuTL89kHL10OuZVacJTHCtao=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-n9HqlFdrMGaA5W4QjiU2pw-1; Mon, 20 Oct 2025 05:12:15 -0400
X-MC-Unique: n9HqlFdrMGaA5W4QjiU2pw-1
X-Mimecast-MFC-AGG-ID: n9HqlFdrMGaA5W4QjiU2pw_1760951534
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f384f10762so3135457f8f.3
        for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 02:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951533; x=1761556333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ubitj5/uevHZU/7Ly6xrweyvQaOv3M8jgDaIwUyJNQ=;
        b=ELNLp3XyGukhlvgjIvi2/1qCNkikSpbXxCpVUsv5dVg2epskw3DgXUeNM9Rqea+9+v
         v0Mbpdd+2Q0paFzKxoojNjl+7ZTc7D0OmvFE0XPxG7m6NbeYKNms1hjxQcAxt/C2a0KU
         JcK5yjlFZGUL3S+En48rYYdB71ieNrxrtmQMw2u3saJvH48vbakHCxmdVsxgi2G6aa4U
         xn8kR85TU618myg7yU51xjkB7BUD28VVKcK8s1V6xHlyZ62YQQnF3AeN3l6BZmABtSOC
         wDLEV/FRG+ndBFyVyFrelvuNk6NlpgfgThL4lSo4BLiJjLUkaGdZZtYBaLXehveKCXwc
         NqOA==
X-Forwarded-Encrypted: i=1; AJvYcCUy9cUiMxcrzT0FbMzfFNcHKuBeuFcsBwQyYtA/NvqgbWfrzztYvT/apy34ar1KmUtmAqA46LJ9ZDc=@lists.linux.dev
X-Gm-Message-State: AOJu0YyvIfMosDR85qvdtjhx/tdGYVpcj30NCYmNdI3QOKQkUfZIG6kt
	Mfad/Z1Fz+8t1C1hB9u6bPRKbyu+5Asfk42WRHYZ9LqvsSrj8eUR+d+3XsvZgp8SLtQODkNZ1H8
	S5GlKds6S1kltPQgkQaUQo3uj7w649MHV004c1Lod3YyJDrIm7VfUbsmBdHyk8g==
X-Gm-Gg: ASbGncs0t5rD5+a6IgcCgVGhMC4mnvEaPlsudNFZgeYIdymJCW2LkYdvU9IEiNld4dU
	dS/AXZG+HI0AJFjJeBjQ3+tJmU2Fylyzo8caRs1rY1CgimkzPbLs5EBXB+RyJtYmGfeIAdDWveO
	DDtFUb7M1JWr3dP1M7KlaytnAUc2h7xj1MnQZiW3uFU4F9xdwJVdqVpmH6GrQEJooX4HL2X61SS
	NrU/TOLakVFkjYXjucZLeiXV5NkA5dl8pwH7CN1SMau9spF2MB2epAu+TDQWgKoYhNAq6vbuPqu
	eenpZ5XCRngCZHp2kN6aMIUgscJpNIAVz1O7OBZQ576OAAluzzgfyoM8GluBPugNsQhLkXmylml
	Xuqtq/v2Kjuy1HpzcK2/pzsj5CaW3UPw=
X-Received: by 2002:a5d:5888:0:b0:3e8:68:3a91 with SMTP id ffacd0b85a97d-42704e0efc6mr8234677f8f.60.1760951533498;
        Mon, 20 Oct 2025 02:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1x7pXYq8e945UALV9q1YHdxFAo/gpZoHmNBgsdqAAWXDZS350AGwm1xrETAUHltalmZTxLw==
X-Received: by 2002:a5d:5888:0:b0:3e8:68:3a91 with SMTP id ffacd0b85a97d-42704e0efc6mr8234649f8f.60.1760951533088;
        Mon, 20 Oct 2025 02:12:13 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm139474055e9.6.2025.10.20.02.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:12:12 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:12:10 +0200
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
Subject: Re: [PATCH 02/14] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aPX86h9lSEZh0YP2@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251017093214.70029-3-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LsPvQ7dpH6tjWBKgtjs409h75nbepGpFbXebyJK_7sI_1760951534
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
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

Won't this reintroduce what bb4700adc3abe ("sched/deadline: Always stop
dl-server before changing parameters") fixed?

Thanks,
Juri

