Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2334B43F
	for <sched-ext@lists.linux.dev>; Wed, 17 Dec 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986556; cv=none; b=RaGLUorXp/aeedNdHUXIEI6N5NuG1bSJas4UUP7E21x3G7XypsCMcTKmfHhKUKJit4PRNQSRvF3uwZoPOWftCtucbD1PlehrJyDAwfCx7TvPZfI+Qv3vGS6A8j1VjV4hUGVzkFy3lVoh8DPO3Jzk/ugEKq7B+Y2jvihO4EqNPv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986556; c=relaxed/simple;
	bh=ej7TTVTeGnBUqaRwlQnvTPhYft8GTVTgUYErJC5s1Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I+hi3Ba1//kq5Mz19hAbXG9h5PgjebJYbpyLafk/XSbBvtzygtI4HR+xk4P4EX+KSJ4hsteQEUmB0bJ1QdN+gT/0HvsFnDQYJBMtMGg2BftohFrK9RM01B9OCO3QFg87vsg0kejuEoVX5FIcm9/SBxvudWmv/4WruXjfheTAjlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ca2NqY2Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ca2NqY2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765986553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bJTbj2QHR/bxiaOEFbouYE+C6nf3xnn/6jMSMVKkAk=;
	b=ca2NqY2Z+LsZs1Ai3rL7BxhuR0P9r0LDGgzf1c3lMXkjAipVXBAT0tgEFSBvOJqaI9639N
	ug+UWYM8582plrwrTWTejdI/rxBcIdDwgy+LeD1e3g43HCBPzvvDxnPdnW9UgWnAN8nswh
	uiA7vbyLDBnF5M7Yg52yn1M1rgmYeoI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-5mNzvYwbP0K8ntcbTf1Jcw-1; Wed, 17 Dec 2025 10:49:12 -0500
X-MC-Unique: 5mNzvYwbP0K8ntcbTf1Jcw-1
X-Mimecast-MFC-AGG-ID: 5mNzvYwbP0K8ntcbTf1Jcw_1765986551
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso40923885e9.2
        for <sched-ext@lists.linux.dev>; Wed, 17 Dec 2025 07:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765986551; x=1766591351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bJTbj2QHR/bxiaOEFbouYE+C6nf3xnn/6jMSMVKkAk=;
        b=L4eWquh4tUSTuaxWZLqKoDhvu16Vj0HGGQyqGDinQKTp9mZSdu+vAuO1+P/npoA6d9
         ra2L9pCqMq0klstPXUrfSUwujCmEg2Pkglyt+FNc61brDT+s0MYY91WSkEz51jOgiEZC
         KHczm1TqazbNZWO12d5yRrsiHJZIfQUZGUpbMmTE1OYkQAzGrLNxi0URTb3Nyw8qP9No
         0F5XaHTN+T+JzzuG90d4sKQhXPXkdjIw3eFN6rsgZEFK4tsDsReavW8GoOqKX9zreW4x
         J2jKIiKCWaJViNXp+KXXHgWeWq3zN0pkGBapRJ93t22bZeI+BdFcaPwCvDOblnx/ZWwY
         Shkw==
X-Forwarded-Encrypted: i=1; AJvYcCUkGCXnfL2jZOsRa9fgBqTgAjknUniYgEtzDSf3Zn+s8sj5Jkoz1pWIStSFWJbvqcqV8iDY93jtzDA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwrNTGQpdQvBs849p4EToin0+8PNydR+cSaJ8QCPTBjz0E3k+i5
	RxAhoWE5f4+eslOVEGZJQXMWSl5hcLrfHcwVEmHrR09b4CITStZ59RfxqXWl720hrTTl9mgdORW
	Jx9z292D6o9n1khq0cdRoa5GTyqGb1x1fokjUFYPDvTLmazSDMVb6xB1VzXnF6w==
X-Gm-Gg: AY/fxX4uXFLjq71JlMR9R9xsdqaTF2lOPK1qv2cWaN5VapYA0MmJ147gjT1ouHg+qgy
	ocRo8hGgKZMS3giD7RmCSxKZUnMf9JbxYI7BZjBoZ6t9B/LVdDgAJ/WMByMwXu80eTpUKJyH8Xi
	RAwvmLL3HMjnxgv4Lk75jmMwcinHr7bxGJ6iGbZ1NCBz7ZiWAWQQxWAWol1lGz75ZpnnwWdD6Wg
	AXJT+2i/sq3Qwz12H+sx6zQdtCJ/UKUPnuOCLHK1+85FP4uWI8O4z1uOlH02IzaNKGsfzYkkSa/
	ZTZoYBXfem35UGe5ojytrTRFzB3b7hhinedRb6/gskS/g4NcllBZM0dES7HCzLHnYLQJhEylkjL
	2QnYOlgWBkx/isBqsxiqRu1nGQJbg6WLCpOuj5/E3
X-Received: by 2002:a05:600c:1c88:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47a8f917533mr206284005e9.34.1765986550787;
        Wed, 17 Dec 2025 07:49:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ+ughGVWwzvXsaWm1dblcs5eRzcKirhAt+kak2tJQKEnBlZisL9+a1O+Ahuhxi1HwalxGKQ==
X-Received: by 2002:a05:600c:1c88:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47a8f917533mr206283615e9.34.1765986550400;
        Wed, 17 Dec 2025 07:49:10 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bd911a9bcsm32202995e9.6.2025.12.17.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 07:49:09 -0800 (PST)
Date: Wed, 17 Dec 2025 16:49:02 +0100
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
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aULQ7kPm-RqHWGDL@jlelli-thinkpadt14gen4.remote.csb>
References: <20251217093923.1556187-1-arighi@nvidia.com>
 <20251217093923.1556187-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251217093923.1556187-5-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ocWSPD_cBQGhZGDWKXgQ0XSDwXCjDFr9pqI950wWa1c_1765986551
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On 17/12/25 10:35, Andrea Righi wrote:
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.

...

> v4: - initialize EXT server bandwidth reservation at init time and
>       always keep it active (Andrea Righi)
>     - check for rq->nr_running == 1 to determine when to account idle
>       time (Juri Lelli)
> v3: - clarify that fair is not the only dl_server (Juri Lelli)
>     - remove explicit stop to reduce timer reprogramming overhead
>       (Juri Lelli)
>     - do not restart pick_task() when it's invoked by the dl_server
>       (Tejun Heo)
>     - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
> v2: - drop ->balance() now that pick_task() has an rf argument
>       (Andrea Righi)
> 
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

...

> @@ -3090,6 +3123,15 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
>  static void switched_from_scx(struct rq *rq, struct task_struct *p)
>  {
>  	scx_disable_task(p);
> +
> +	/*
> +	 * After class switch, if the DL server is still active, restart it so
> +	 * that DL timers will be queued, in case SCX switched to higher class.
> +	 */
> +	if (dl_server_active(&rq->ext_server)) {
> +		dl_server_stop(&rq->ext_server);
> +		dl_server_start(&rq->ext_server);
> +	}
>  }

We might have discussed this already, in that case I forgot, sorry. But,
why we do need to start the server again if switched from scx? Couldn't
make sense of the comment that is already present.

Thanks,
Juri

