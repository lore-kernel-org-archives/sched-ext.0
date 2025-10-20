Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863F2DCF4D
	for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968017; cv=none; b=X7JYunkzxCh7ZpuO3LGgouYu0NwsCe9C9cbI3PvHo/lsLoaYT6QyuYfHZB0tohriH5lcdS/zuX/wuLayyuJ/KtJNvdv4j/Ewdw7ocbt3Na4437s0ovTQUXaOK9QW0dh+30QE5jHRhYuA9AxXPFPqgIpSRwbObLkFR1e+lTm2GtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968017; c=relaxed/simple;
	bh=Sq5libX+JM3WPG7zqMDxrV8+aH4+q3XRl1ghvIEgb7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ku9+iZxBeYOYHd19UFC4Im+EkIzywUJYXr/1wxrB7FspUR34DT5ixv4V/D73kKh+/2NxnLuvVAvzzqysHS3BJEJLKm/XDAyP03GoBuwCRKOR3GoAOf2lGsFUopNmhER9Ly4GeAYlacJ8xeVZCVzR8WBOBAbBMQOcAp1xaZotzTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7hZD76J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7hZD76J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760968014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PeJ1Du+aCXhUYBm58dq+DSQq/mNgrM7c9de43cjduZY=;
	b=W7hZD76Jf8i2NHg1Euy+rfuwZCSCLUjpFGWDJSeGd6s3CvnpkyP3XAnvGJCMwx+TAvckV2
	L6ru1o3VkMUDnupRmC7l4K7U4EupOv/w9mmSvSlw+FTvn4cuxfiiUW6qwYAaTvFVvHXqiS
	rACUIhGo2Wn/4eHV+aEYxt4jmrGWTT8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-KnNg5r-TN4ankAabgSHZOA-1; Mon, 20 Oct 2025 09:46:53 -0400
X-MC-Unique: KnNg5r-TN4ankAabgSHZOA-1
X-Mimecast-MFC-AGG-ID: KnNg5r-TN4ankAabgSHZOA_1760968012
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so5415958f8f.3
        for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 06:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968012; x=1761572812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeJ1Du+aCXhUYBm58dq+DSQq/mNgrM7c9de43cjduZY=;
        b=n7KcIF/q8GfdFQ/Aaoqf5c6uvPMHwkbK6agEQguFpW64XsRWTB7aMmKtgARFKENIrD
         dbui6hrtd0SFbb7O0+yuwhgtu+0qpUrG3gMG+nerttEeQrjqDFiKzkbQHAu3EGk336KY
         HD4Kfk/iKma7lxVFYHWB/E1X8ab7jK7PNqZXsYh2OJiTO4o+Xz/Cue2F7aLNmMYnnN0i
         ufP5/9a3QXsGDD4iI5ldoSsyLh/C4tCimWLenddu+gAEJL9yC6iEIFrIXCHTfP6ECrAT
         VVHDjf30lKonA+muf+wMDMX47he+/weHhs2jBBnXbEeg8uI7vQdjqHL3IPEsItPJtVtL
         VrXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWS9BFEhnZwSyjmQxX1Pd+AuPQITK6yR7OhtTMP5uBjvCH59lCjY6Dh5+kNet8Pl/ayFA7XVEiwtY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1cY1IL4wng5aNDP5YpqOL1JHXfoDvrF38ueMcCNP6LhDBev9L
	6C5SkOjtjPVyNHnJn0zcf0cUkhCqCOLnT3ZWZcMzKwfQfsCNla8YDBejdV5GaciHNV8Kw4bjuIl
	qPFnqrmDO6+154uEb9aEr1ZyJjJqbuor/JKTpbLJEf4t1GV6dGzxVmxHRQqbkEQ==
X-Gm-Gg: ASbGnct95S7BzrklNgYPOtkUk6ip2Q2KtzvvmPhZ/OMXoLZQkrbje4lorszf8zMHqBo
	UMyS0LLRaSu7EQLP0APGsxKnMKGmVyvI0aa2lLXYVOuRqtcospDGUOSNFq+A0pKnhRFQ8zoEmSL
	gw6251mCLNwdPZYcIr+S7NzeemVWhPtZxz8wcyJSLJseWJPGFqYMlheOzU0kXCUbSKWh18KPMbn
	kFLoqPsAiM7V4WKQFfZbwZ/WjFexQrlJpI9KruGgj7Zuaf0hV9cCjjAakdO0QA+wDzxIXugPgHo
	YVTeFw3tjeSpUp0//Vrhqo2FDAFxWuMhZLHELOSuvGFnggS/cQIczRjq96xrXfk8G7dH+QQ4a1R
	XowWsakXqRk13Z0JmAqTFwrcqGF92RA==
X-Received: by 2002:a05:6000:4285:b0:3ea:80ec:855d with SMTP id ffacd0b85a97d-42704d6c57amr8277574f8f.19.1760968012135;
        Mon, 20 Oct 2025 06:46:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYsUAywsoBSSavZPjR8dWhxCz2PQ6rM3m8YxB0dm+4iLqXx6iaMKdrToBp9kl1vWXEwcQwuA==
X-Received: by 2002:a05:6000:4285:b0:3ea:80ec:855d with SMTP id ffacd0b85a97d-42704d6c57amr8277550f8f.19.1760968011693;
        Mon, 20 Oct 2025 06:46:51 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d3843csm146424245e9.11.2025.10.20.06.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:46:51 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:46:49 +0200
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
Subject: Re: [PATCH 08/14] sched/deadline: Add support to remove DL server's
 bandwidth contribution
Message-ID: <aPY9STUzTnNwKZ9V@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-9-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251017093214.70029-9-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rRhFWtLdbLqjIX6xbvF9izERhYGMAMJd5pl4trsgQKE_1760968012
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> During switching from sched_ext to FAIR tasks and vice-versa, we need
> support for removing the bandwidth contribution of either DL server. Add
> support for the same.
> 
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/deadline.c | 31 +++++++++++++++++++++++++++++++
>  kernel/sched/sched.h    |  1 +
>  2 files changed, 32 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3c1fd2190949e..d585be4014427 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1684,6 +1684,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>  		dl_rq_change_utilization(rq, dl_se, new_bw);
>  	}
>  
> +	/* Clear these so that the dl_server is reinitialized */
> +	if (new_bw == 0) {
> +		dl_se->dl_defer = 0;
> +		dl_se->dl_server = 0;
> +	}
> +
>  	dl_se->dl_runtime = runtime;
>  	dl_se->dl_deadline = period;
>  	dl_se->dl_period = period;
> @@ -1697,6 +1703,31 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>  	return retval;
>  }
>  
> +/**
> + * dl_server_remove_params - Remove bandwidth reservation for a DL server
> + * @dl_se: The DL server entity to remove bandwidth for
> + *
> + * This function removes the bandwidth reservation for a DL server entity,
> + * cleaning up all bandwidth accounting and server state.
> + *
> + * Returns: 0 on success, negative error code on failure
> + */
> +int dl_server_remove_params(struct sched_dl_entity *dl_se)
> +{
> +	if (!dl_se->dl_server)
> +		return 0; /* Already disabled */
> +
> +	/*
> +	 * First dequeue if still queued. It should not be queued since
> +	 * we call this only after the last dl_server_stop().
> +	 */
> +	if (WARN_ON_ONCE(on_dl_rq(dl_se)))
> +		dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
> +
> +	/* Remove bandwidth reservation */
> +	return dl_server_apply_params(dl_se, 0, dl_se->dl_period, false);
> +}

I am not sure this is correct wrt inactive_task_timer and
task_non_contending. I fear that removing bw immediately might break
other deadline entities guarantees (especially if one then maliciously
add/removes dl-servers quickly). I kind of think (but again not sure,
please Peter and other keep me honest :) we should be waiting for
inactive_task_timer to fire (if stopping before 0-lag) and let it clean
things up at that point (like we do for simple tasks).

You seem to have additional fixes later on in the series that might be
caused by what I describe above.

Thinking more about this I actually wonder if we need this (well it's
coming up with later patches) mechanism for automatically removing
servers based on fair vs. scx state (full/partial). If we are going to
manage dl-servers bw explicitly and separately [1], maybe we can just
leave the burden to the user (or middleware) of doing that via the
configuration interface?

Thanks,
Juri

1 - https://lore.kernel.org/lkml/aPYDhjqe99F91FTW@jlelli-thinkpadt14gen4.remote.csb/ 

