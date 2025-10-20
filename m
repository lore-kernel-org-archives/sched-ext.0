Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164CA304967
	for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961540; cv=none; b=baaMIKF7YLgnv8ZCH14f7ZhPe48Iy6cu8yEKOygbPWl571SuFRBpgq9E7ZU+YrCo9u8P2Qat+7VK32ykt2C0Wcc4ZOmUjcUTti4SKg2yXm0Dnb2e4sEhu/0BBPGGNWhw2XabOLi0sluRGgcR66QTw8RVcfV0uPZsNVD0yCijE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961540; c=relaxed/simple;
	bh=prBsS/3TdnqRdZW7jgJaElFuOWg9kNn6hLTHuRKrO4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T/7thl/JlJDutZC7nt2fUBAO6UMAMmzfrd9naSuRqB3iwBAyC9anUYaiYVMcXRDS7Wvuqp6NdItPwslJVz+eYQNqJysen41oaA5TNKoQChSXNPLJVuFZDoWObNwJkGmyV2b+2RFNd/uI2muKchNTrlYQpTFXVjoFYNeqDKu/jYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JryeR++m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JryeR++m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760961538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3DGWABDIIB0dwmhK6Y7TeY6zhcql3nAwcUWHRom4zEg=;
	b=JryeR++meglKlec7QLzHMiKOASQW5mIqyhojVPXH56sFZqywOZeIdG3FXdaFxuamduE/Zh
	Aol01/jL39fk01HHYhqVlRck7OnOwNFLkBP0igd5ePMrhUG+nV6SqQrO8ZduE2wFwrpua3
	mDBxkUdvEaKA8DMffcZoF61/ZOfW0sM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607--ZBlMhuoMla3f2XeUfXCGQ-1; Mon, 20 Oct 2025 07:58:54 -0400
X-MC-Unique: -ZBlMhuoMla3f2XeUfXCGQ-1
X-Mimecast-MFC-AGG-ID: -ZBlMhuoMla3f2XeUfXCGQ_1760961534
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47108163eeaso20781235e9.3
        for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 04:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961533; x=1761566333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DGWABDIIB0dwmhK6Y7TeY6zhcql3nAwcUWHRom4zEg=;
        b=iBMyVEsvl4dQWzboYPG2hCPfHAqZ0rxPKmy58zVC9k+DYVTHMdcg65HFX1nYcMsH9p
         lOFj5//wJkwZRtLV29HdDREthceZDMsL4/668Rm4HOpJySLPI3hCcaUvn9lIpRT2ee2X
         qdwBWptdcoHIJ2uosBWyQt1mm8a0PFi9BzQdZVpx3arGrGK2BzhXRn8/E7HPQzzkdriK
         8DyF6TqeDQhV7VKDRnW81lynonfpAXV4is7uRL0GvEFqwZHmAnAi15ZFvRRvH6QR7iZy
         OgxpRsTLrTwqA64pApx1ts1hWa9I2XMf6hrLze6cC+ntAjwqxWRGUsjRl+eZ/uxoBuV7
         aiWw==
X-Forwarded-Encrypted: i=1; AJvYcCU6jgyM9dV1h8z3NH/H6VkZgkscxs4mcpHiCrAlJ/TxJbwgwWGJmHXiraxhusiQxzc6rlj/5QuN+vI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2DNEVGbETSHmqFml+I+B2R8YE8QIO1lGaLo5dKvKB2DgCv1xP
	/ERASxuZZeF7V2ueHQh7YeeEljK0v/sx0BQkOjTMs7SxAQAsWSmsV5/yxjFKAVV/1OaIBRtr4DA
	ADekvISoYuuKe9P4+sXVSC32pMjK++b6cG/NgGAzxq5sE4VrRkW+gkje2YDZvzQ==
X-Gm-Gg: ASbGncs6hGdXbFp8rplPh9GPSBq/5bAin7c88OOzQw887Fj60Fnkix7oNOGkPa55Y5g
	WkPgJFPWgEj4Hl8Vgj1+21doPsrBb/c/WE9/oQLV5wGTO9cW8qhEeDKojExHXlYbNEcA9wW+l7R
	ByNplhqKZfSwKwPiu4AuKeU6G3gpb8oJcwYvqbt1SO919Z2Klfef6gV4tGyYi80euy/2JI/t3i+
	T75bR3SvPTpYVTVvWlBsA2ybrK+OEf8NlAinVcxcGJSZIqbCAhJpdXMhQLKQl2E/GWtZWI2LhnU
	dYyDitj+ZmnMxpeH1U0Oa2geQc53wg5iFy/ttvg4Z0l0yfD6cVjEKBoB6nTjhAmJ+Mh1B09J8aR
	HdftAVa3q32akTkhztl/dvTYX1OqCiGc=
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-4711787617amr91944665e9.5.1760961533614;
        Mon, 20 Oct 2025 04:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3bJRkDnTNsDoLX27C6wNA7H7qPmCVso88dp9ehs0+zp2XESQa1XmzDa+Csu2dj2eVZorh8A==
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-4711787617amr91944415e9.5.1760961533236;
        Mon, 20 Oct 2025 04:58:53 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c900asm229469775e9.16.2025.10.20.04.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:58:52 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:58:50 +0200
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
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aPYj-iOdvgUYQFpn@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251017093214.70029-7-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FY42lsEFqifdsaf4mPEM9goc6xV_NRZbaeWHrDCzNDo_1760961534
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.
> 
> A kselftest is also provided later to verify:
> 
> ./runner -t rt_stall
> ===== START =====
> TEST: rt_stall
> DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
> OUTPUT:
> TAP version 13
> 1..1
> ok 1 PASS: CFS task got more than 4.00% of runtime
> 
> [ arighi: drop ->balance() now that pick_task() has an rf argument ]
> 
> Cc: Luigi De Matteis <ldematteis123@gmail.com>
> Co-developed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/core.c     |  3 +++
>  kernel/sched/deadline.c |  2 +-
>  kernel/sched/ext.c      | 51 +++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/sched.h    |  2 ++
>  4 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 096e8d03d85e7..31a9c9381c63f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8679,6 +8679,9 @@ void __init sched_init(void)
>  		hrtick_rq_init(rq);
>  		atomic_set(&rq->nr_iowait, 0);
>  		fair_server_init(rq);
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +		ext_server_init(rq);
> +#endif
>  
>  #ifdef CONFIG_SCHED_CORE
>  		rq->core = rq;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0680e0186577a..3c1fd2190949e 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1504,7 +1504,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  	 * The fair server (sole dl_server) does not account for real-time

Fair server is not alone anymore. :))

Please update the comment as well.

>  	 * workload because it is running fair work.
>  	 */
> -	if (dl_se == &rq->fair_server)
> +	if (dl_se->dl_server)
>  		return;
>  
>  #ifdef CONFIG_RT_GROUP_SCHED

...

> @@ -1487,6 +1499,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
>  	sub_nr_running(rq, 1);
>  
>  	dispatch_dequeue(rq, p);
> +
> +	/* Stop the server if this was the last task */
> +	if (rq->scx.nr_running == 0)
> +		dl_server_stop(&rq->ext_server);
> +

Do we want to use the delayed stop behavior for scx-server as we have
for fair-server? Wonder if it's a matter of removing this explicit stop
and wait for a full period to elapse as we do for fair. It should reduce
timer reprogramming overhead for scx as well.

Thanks,
Juri

