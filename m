Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EB528FA9A
	for <sched-ext@lists.linux.dev>; Fri, 23 Jan 2026 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152303; cv=none; b=YgFSEAEoe3B2+kRaHxWHpoijtT7DrkcUjk+iiWCnxROHtQvkiea1JNowP3JP3yfaKh440kvftjaqve3ixDBRKhb+BL0kf/ddMXJ0Av164aSuaS8EIyuXkblQAVOPB5Sl9+kHW7t0JqXqY0P8LugUbAMkSAGU3lgOLkYmFE4s7OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152303; c=relaxed/simple;
	bh=R7Bm5PZ8wiVGLs8ZuDcwaTr7E9iru1NkzD4OuDHVvH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=el5vk4UKq11qF1zA8SuqO5Glbtd9Y9UxwztuApovxnFf4zAV9T53TamqAf593qthMN71eDYQuzy3+ndemPY0ObACWxomAB0dVh2tMq1tBaYMckOzhy5P8Zi8n6qo31q5qENOAgPch5QalQz9Se9Cf0+RvgV9ykRODLxp9pn+d5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lz//zExV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lz//zExV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769152301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n6b1cjawk6zPGklti7vHmLYuyCRZ99pwdI/+iQMQVqg=;
	b=Lz//zExVc+++8lI6OObAnC3jElQwHgjdcT8mzi+Lq+UOM0jP2eIzA8evQdfcopRJaQ6knz
	zopWF+Ya8HGNZzZk2ArfZPov8nk/UNMieIrXK80hOuKiMKq5LAsSwlZEu2z3o5P22BuT5Q
	qKifXYI7JMzNMCKby7a9FBoLbw55VUE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-KKZevIAkP12T6ABbGiWUdw-1; Fri, 23 Jan 2026 02:11:39 -0500
X-MC-Unique: KKZevIAkP12T6ABbGiWUdw-1
X-Mimecast-MFC-AGG-ID: KKZevIAkP12T6ABbGiWUdw_1769152298
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43065ad16a8so1149417f8f.1
        for <sched-ext@lists.linux.dev>; Thu, 22 Jan 2026 23:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769152298; x=1769757098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6b1cjawk6zPGklti7vHmLYuyCRZ99pwdI/+iQMQVqg=;
        b=lJ09b7vQprsrj8CIFlYAf11WnXUYSFka9Wit2BiOfk98AJjyidIu4fqT7l1unUx9mA
         hlreWU2/btP4OnxtoSZ5Clpl3JxrfS+rVkAnCnhgId2hXPONFm2Db0NUWfeahAXiGKFI
         EvwbirVZTTF31r15S3oSfmxyjRkXfPrKdbYt6GNKZKp12CNyg5Oa/rGxXCnIIniZUYeU
         vCRSw7wwymrGmqEc0nFWIcbrD3XQVseSsfCFw7VNHLANEhuVWFDyGsKpQwwIEZB+9sFo
         dtlzpT79zw6SV0xxoCC18e7Jr3Va6xxtQ5JweuX6qdEh7gBhp0g1m2Ey7YR1Nw3aPli/
         Iwxg==
X-Forwarded-Encrypted: i=1; AJvYcCWh+uucrCe71W6hYhGoFS4cEzSCtXgnDq7nLiuAs3dgiHpGWzfftnskUC305Rqk5OJ1gTJ5fhfH10A=@lists.linux.dev
X-Gm-Message-State: AOJu0YxDYxQChSyjbHRPSf7ldhrj7/X6WCBNUscS9a93W4o9kmvzUXyr
	quAv+SF4u9zI29Hz90LcjtbhgqA7Glf4gWQnApRGsrRvaDblA7aactfIK4zoWo88r5p//1KQWuk
	4A1rdfG00le0HjuTs8r247YgOvy5hHCBQ0rSdBOeeiVJLLUm0vHoyFywDUpo88A==
X-Gm-Gg: AZuq6aKaFYdB5Ic1UERTnWnawChMCP4vRCvxHhIFptPTqIttBEZIX4oWgL89FAbWCC1
	AxAEjwHnJgOvXbLKzzcXb9csU3vIdVO0+8w3JIWbXipQSU6eFS+74qpftlafownyG/wnHQzGu/m
	/eWIYnufu2wTv0XUd9QzhQ9ireIk5UdqgRddb/rr67UqLTnlPywxniK8kszDPNiOMqiehEuIgZ8
	TYlazLVWKairWw87WuPrRQ+TJxN0UKXtjg5Rby6oa9LtDVY9sGpmSvC4R/9nybvBXs5LV7T1FvL
	65owLgKmlz4Kb5/Xvw3/ZZmPtKtaKHz88A0G8xCDsnVkujEhAQ9j7Fkkwy62bJ17Z77TGwopdCr
	A4Z5/9GQEsrr5SxptsHwAVocnSUQ22uE5tnkeORyF
X-Received: by 2002:a05:6000:2c01:b0:430:f62e:d948 with SMTP id ffacd0b85a97d-435b158a313mr3012468f8f.9.1769152298429;
        Thu, 22 Jan 2026 23:11:38 -0800 (PST)
X-Received: by 2002:a05:6000:2c01:b0:430:f62e:d948 with SMTP id ffacd0b85a97d-435b158a313mr3012432f8f.9.1769152297985;
        Thu, 22 Jan 2026 23:11:37 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c30293sm4719683f8f.19.2026.01.22.23.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:11:37 -0800 (PST)
Date: Fri, 23 Jan 2026 08:11:35 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Reset dl_server execution state on stop
Message-ID: <aXMfJmG499rhMjo5@jlelli-thinkpadt14gen4.remote.csb>
References: <20260122140833.1655020-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260122140833.1655020-1-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mImZ5bxAk6TueXeMjSflgGJJyPjBIPa4r86-IymGRDM_1769152298
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 22/01/26 15:08, Andrea Righi wrote:
> dl_server_stop() can leave a deadline server in an inconsistent internal
> state across stop/start transitions, causing it to bypass its required
> deferral phase when restarted. This breaks the scheduler invariant that
> a restarted server must re-establish eligibility before being allowed to
> execute.
> 
> When the server is stopped (e.g., because the associated task blocks),
> it's expected to transition back to an inactive, initial state. However,
> dl_server_stop() does not fully reset the execution state. As a result,
> the server can be logically inactive while still appearing as if it was
> still running.
> 
> When the server is restarted via dl_server_start(), the following
> sequence occurs:
>   1. dl_server_start() calls enqueue_dl_entity(ENQUEUE_WAKEUP),
>   2. enqueue_dl_entity() calls update_dl_entity(),
>   3. update_dl_entity() checks (!dl_se->dl_defer_running) to decide
>      whether to arm the deferral mechanism,
>   4. because dl_defer_running is stale, the check fails,
>   5. dl_defer_armed and dl_throttled are not set,
>   6. enqueue_dl_entity() skips start_dl_timer(), because
>      dl_throttled == 0,
>   7. the server is enqueued via __enqueue_dl_entity(),
>   8. the scheduler picks the server to run,
>   9. update_curr_dl_se() detects that the server has exhausted its
>      runtime (or has negative runtime), as it wasn't properly
>      replenished/deferred,
>  10. the server is throttled (dl_throttled set to 1) and dequeued,
>  11. the server repeatedly cycles through wakeup and throttling,
>      effectively receiving no usable CPU bandwidth.
> 
> This results in starvation of the tasks serviced by the deadline server
> in the presence of competing RT workloads.
> 
> This issue can be confirmed adding debugging traces, which show that the
> server skips the deferral timer and is immediately throttled upon
> execution with negative runtime:
> 
>  DEBUG: dl_server_start: dl_defer_running=1 active=0
>  DEBUG: enqueue_dl_entity: flags=1 dl_throttled=0 dl_defer=1
>  DEBUG: update_dl_entity: dl_defer_running=1
>  DEBUG: enqueue_dl_entity: SKIPPING start_dl_timer! dl_throttled=0
>  ...
>  DEBUG: update_curr_dl_se: THROTTLED runtime=-954758
> 
> Fix this by properly resetting dl_defer_running in dl_server_stop(),
> ensuring the server correctly enters the defer phase upon restart.
> 
> This issue is quite difficult to observe when only the fair server
> is present, as the required stop/start patterns are relatively rare.
> However, it becomes easier to trigger with an additional deadline server
> with more frequent server lifecycle transitions (such as a sched_ext
> deadline server).
> 
> This change is a prerequisite for introducing a sched_ext deadline
> server, as it ensures correct and predictable behavior across server
> stop/start cycles.
> 
> Link: https://lore.kernel.org/all/aXEMat4IoNnGYgxw@gpd4/
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/deadline.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c509f2e7d69de..214fe62a59723 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1813,6 +1813,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
>  	hrtimer_try_to_cancel(&dl_se->dl_timer);
>  	dl_se->dl_defer_armed = 0;
>  	dl_se->dl_throttled = 0;
> +	dl_se->dl_defer_running = 0;
>  	dl_se->dl_defer_idle = 0;
>  	dl_se->dl_server_active = 0;
>  }

The fix looks good to me, thanks!

State machine above dl_server_start() might need updating, though. Don't
we want to add dl_defer_running = 0 under dl_server_stop() for case [4]
D->A? Also for '[A] - init', dl_defer_running = 0 (remove /1)?

Best,
Juri

