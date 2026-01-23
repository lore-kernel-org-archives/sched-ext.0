Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD68265CA8
	for <sched-ext@lists.linux.dev>; Fri, 23 Jan 2026 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185387; cv=none; b=T0Y8OLX6Afq64W2beQ+aBpZihpyocDwO6ZIDGYJ83XLCDmEJCPsrwimpyZ+h141vgSPXxecXXtvZyxB43tvdzUSQwnneJYb9QK16QRGQ21Hr8F6fbNj9hpQ/kcLANtr1xH9vOV9la3oU7e9C//s9ao5kGzmko/X5C+iFFZDV8AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185387; c=relaxed/simple;
	bh=xNV2vEmNjEZVVQBMVDIilSG8KNxp/ZJpdk+NB4L+glE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eBX/tO5wki9Ykohn2hiUmvzt5JQBPpPrmnB9SFTZ4xb8paEhH0YgYpVf4ewXWdNALYQE/dqlF1I9AH4tZ/z++u4ZEesntDlnhvJhrAdx2vHzL+GewXri9S/BDrevoz8azMC6pESKl0LNW2C4gty4sWULfJXTh+1b4RQairUxtqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOfo+TWt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOfo+TWt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769185385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jUCqHAaLJvABx8RvoKrKk9TVgKHJIlXccCn91vumbBs=;
	b=JOfo+TWthccp7GZRwHmb47s/oEOXPmB7DSFLETuio9nNOWKu8X0ez25rSJQF3B5icIriHy
	oMxN9qwIGe4LEpaKatQeVvZJX4jrsG5Ehz5M6Y84do4buWdFBzQoFwBmr9bg6voAIHwawP
	7GU9Tyds8j4SEFmU1EiLyO8Qm7dfIWw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-yFQnKLA6PkmiECL6qOdVKA-1; Fri, 23 Jan 2026 11:23:03 -0500
X-MC-Unique: yFQnKLA6PkmiECL6qOdVKA-1
X-Mimecast-MFC-AGG-ID: yFQnKLA6PkmiECL6qOdVKA_1769185382
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43065ad16a8so1523021f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 23 Jan 2026 08:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185382; x=1769790182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUCqHAaLJvABx8RvoKrKk9TVgKHJIlXccCn91vumbBs=;
        b=g26Pi9tlM7Wx8aKaaXUMOp9Xfo9cYKGJsDNnB9dM8qOc9ENdg7Fo50WEgNKkSREOsP
         9i5T2n3EZ0ogr/IvicJwzpDQ5XfZ5gHNm4kotWdEE08jBAgI/Wg0mr/QPv8CliEA/YUV
         r9TYh5QLdFgfJgnZHCKxayR0OocpQGMpizZyt5w+T5lbC44/Tu8NsxYmHQk3R5cQZhZp
         /ZlZIzcuX9ImFA9fo5uE1SbBweQR5FLjQ1TTtjLrLsg1XPYJh2pWdoHT1oxx6icRu2TF
         UnDlZxr9LNqPRgydBFT6GDWgjyDIlmKwTGaU+MdTVklO9NhgkzV9qZWHgvOhuujYBj3C
         KW2w==
X-Forwarded-Encrypted: i=1; AJvYcCXAkEm1qRZT1jN/XoAwd2B5v8rWFojjhROpDMq9Hm+uDl8TWb8Szk5oPN3kzKUa3f4Y5Ty+Rxgp86o=@lists.linux.dev
X-Gm-Message-State: AOJu0YymqKkS3z1ps+xwEEQgseFWTA6VuQ5Lq+0e9AT2TEkCXFb843C7
	wq1vRBNUD39gMo6WRojzJJjl2EC7hgz17J/ajaskCclhHrVWw2VzRAYUz0K7CmquRUrNX+NkrQO
	uPzHMIKoCdSszM21GJAB5F0DeqwGmChMht4JGWOELPh0DFdBNcuKX4NeP/I+BTw==
X-Gm-Gg: AZuq6aKwQRHgTJRU+romeJ8Pot7JWgtfpqqxKWgfw3PFTM/HH71IFxLC6WCoMrTOUr4
	RoFHrPlhcYrCYLrfcJ+ZfqIj1DrCcZHAT6eWmJCB9GPGhGVny954WqecPgcor74tvBMQIELAsje
	pLJNy4iavqH7ps0ptBFDZYMtJupt3ha2qJqkqpTMngT4OgYqy0rl5bMOukx/Zs+ISGtja6OhU0Y
	zebzJgHXnDu5yN81t7PrH9yR3Y1brihw9OHE1gFZ7QdXC++sd3OUpzSlWuzGBTCV/T7E/pXqLqr
	ZrGu2IMgy64fd9xg22oh0rIX3qS4w9AREpCoKQ9CgIQjK1nvQYGSnHLXnzz1Nl01Up44A7kBpAQ
	ebvc95GififIk0VM0KbgE/DRcV49XB8snPNbenWhQ
X-Received: by 2002:a05:6000:2506:b0:430:f7dc:7e8e with SMTP id ffacd0b85a97d-435b15fb2f7mr5719542f8f.34.1769185382470;
        Fri, 23 Jan 2026 08:23:02 -0800 (PST)
X-Received: by 2002:a05:6000:2506:b0:430:f7dc:7e8e with SMTP id ffacd0b85a97d-435b15fb2f7mr5719500f8f.34.1769185382035;
        Fri, 23 Jan 2026 08:23:02 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7c8efsm8361714f8f.42.2026.01.23.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:23:01 -0800 (PST)
Date: Fri, 23 Jan 2026 17:22:59 +0100
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
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Message-ID: <aXOgY2LGO2-heSSo@jlelli-thinkpadt14gen4.remote.csb>
References: <20260123161645.2181752-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260123161645.2181752-1-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xsGqpHhw-LAsGc8MoeCpJqslx3m7ZhtxTbieFo3LsKc_1769185382
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 23/01/26 17:16, Andrea Righi wrote:
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

Looks good to me!

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

