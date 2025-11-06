Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56CC26B2AD
	for <sched-ext@lists.linux.dev>; Thu,  6 Nov 2025 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422569; cv=none; b=kSp2OMpt0uEcrM2+NkvjRogN2qqouRDtD7hr8glpzwEpqzstSwdsW5oBKmQBXKbCrguHVplLMFhqJc1mBdm6mkT6H/tme6wTyOP3Opum4ZLlpj1SZL3p2StNbmA2o9qWW6wiXOBUSCeDA/gGzb+e1K9bitaZAPJsmDfdS1ceIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422569; c=relaxed/simple;
	bh=2sMhzj5ZSerndxu5LUketJQ9VpoNWNO3E0MuBLF1XRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GWnBcJSqSwfDMf+L5I607MtLsrKdJfAum4xU0uOLI6qpE3ScRbMcXFynHEGVPyUDb7j/2GoWWo2s5UJE9GPOejY/PqPCOm8eXOQqCqNNAYjRMmERUTMGh/7w5Z3O5AOnp3UquD6IOU76FcW6X1hKI43S0AqB9W7IIQTMIfKQ7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0x/BQ3K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0x/BQ3K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762422566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=97/v+8IzcwHBddy9YosW9MdJRIYiAAxaDT3Ms1fX0hI=;
	b=F0x/BQ3KT1JnuYg7QLGSjzImBWE2ThsmU+s1N8VygJDY5wy0Ltkxw1ecAq9u9LcCnlY5l6
	//JgNFz234nwLHZlzg2Md4QdoHbxCMVxkIkeCG7PlfbgVXWZcfDHH4MosmZjvB1nljRMRl
	1b+Ae3arHyhisvPtsdnHMtqHZnV3fKY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-qy225qHWOYe_Za_60Hjb2Q-1; Thu, 06 Nov 2025 04:49:25 -0500
X-MC-Unique: qy225qHWOYe_Za_60Hjb2Q-1
X-Mimecast-MFC-AGG-ID: qy225qHWOYe_Za_60Hjb2Q_1762422564
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429e31f5ea1so451727f8f.2
        for <sched-ext@lists.linux.dev>; Thu, 06 Nov 2025 01:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422564; x=1763027364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97/v+8IzcwHBddy9YosW9MdJRIYiAAxaDT3Ms1fX0hI=;
        b=S4N4D2rAhP/ST3aZAQ+NuWgk39iwAGNkRh0gys18gYYw+G1WedYc+IN320mV5eZ3Wq
         6VWLQ3DyErQUBLRYipsa32cfQZypIgd2HDBtTSq7DNJa9eNlfOeNF15rAcysRANwrb4K
         73kpzN7VK/EF1jyJyYhtMF8wsrCoK/W+Fx+Ar3wJjqs9BzdNuTqblNRoKCxPyoCWyb3U
         N6G6asq3SDFSfMxJXx8bHeYjQpWJoLVV//Jgw5zwYe4t9VU6VoNBN62pjpRY5oPIE1V6
         My5vV3nN5ksKIKiroZRG9oxgbN5luwWCuOTFmh1+TJbduUgaA8ODEb3ypaYl6muKAuGY
         dtqw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6Nhsu5sFtdVpfj5sAxRgWKUdE3EBvE+6FKvKA3jyDvEm+67xmz+6OjdhoAI74EbvvXqv7Ru40EI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzTlqNnzLvgIB1UF1M7JRtMdlYgVsBOaMcgXpcJ7D2Um7mA7JO4
	DAWo4pLcsYkRk4bNVEHxyEqFO5lZy0x8GsTXZ3qj7qfFuMpGZ4TQX5gmEnyqD33c99HlyoPyc4j
	B7Izo+8hcgGYkwitMUE3bxUgeKX9JhOPYX33vi0lXZJ/hHFF+H3s+ZU5jqWYN+A==
X-Gm-Gg: ASbGnctIHxEe8Z9vL/BwuHpqNX7nGpNVtwu1SMOBqu4BoYSefXS2+mHsJDi/VSEqOMK
	VY/H3jD98vGCON9gmNK44ENV3trDr1rXAf8pbM/oVTBBPQcKSW/7RX6p/jd+US8sqxImS75M+D6
	QFc0NvaVLBn77RsIFh4MHL4SKVT3dsuSvYmu/iGsfI+3TDO2gEZiInagx9oLN+ZpWzOo9lb4gPt
	NyaCivuf3Tw2r5pSXIhqD1yXKiAxAPaxVJaQgZAUzRUhQT+WjDKemM+JKAvo8gh4uxYHLtbychh
	n0DIPmuVVo1Dg6sUyEBUxZ2HFRBvS/ZmjHbto0qShAuLfaYQcs/QP3ubZwqsTacrJdc9Bvp/suh
	8mS/j/MccKMbBApYTVrpyhFn1ulET1A==
X-Received: by 2002:a05:6000:310a:b0:429:c8f6:5873 with SMTP id ffacd0b85a97d-429e32edf7bmr6285275f8f.22.1762422564017;
        Thu, 06 Nov 2025 01:49:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL0R8EQ/PK5EAoW8oq2GeV1D9YmMWfZAWeWYzx+9WjjcHM87V/eC7FnOSgRGl6YpJ+tkE4pA==
X-Received: by 2002:a05:6000:310a:b0:429:c8f6:5873 with SMTP id ffacd0b85a97d-429e32edf7bmr6285230f8f.22.1762422563539;
        Thu, 06 Nov 2025 01:49:23 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403854sm3942693f8f.5.2025.11.06.01.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:49:22 -0800 (PST)
Date: Thu, 6 Nov 2025 10:49:20 +0100
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
Subject: Re: [PATCH 04/11] sched/deadline: Add support to initialize and
 remove dl_server bandwidth
Message-ID: <aQxvIBIwOCDDu60b@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251029191111.167537-5-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0KJGhKlHOLcbWWioQY7c7JXpkwjjwZiIy9bNzCNpvX0_1762422564
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On 29/10/25 20:08, Andrea Righi wrote:
> During switching from sched_ext to fair tasks and vice-versa, we need
> support for intializing and removing the bandwidth contribution of
> either DL server.

My first and more general/design question is do we strictly need this
automagic bandwidth management. We seem to agree [1] that we want to
move towards explicit dl-server(s) and tasks bandwidth handling, so we
might want to consider leaving the burden completely to whomever might
be configuring the system.

> Add support for handling these transitions.

Anyway, if we still want to do this :) ...

> Moreover, remove references specific to the fair server, in preparation
> for adding the ext server.
> 
> v2: - wait for inactive_task_timer to fire before removing the bandwidth
>       reservation (Juri Lelli)
>     - add WARN_ON_ONCE(!cpus) sanity check in dl_server_apply_params()
>       (Andrea Righi)
> 
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

...

> +/**
> + * dl_server_remove_params - Remove bandwidth reservation for a DL server
> + * @dl_se: The DL server entity to remove bandwidth for
> + *
> + * This function removes the bandwidth reservation for a DL server entity,
> + * cleaning up all bandwidth accounting and server state.
> + *
> + * Returns: 0 on success, negative error code on failure
> + */
> +int dl_server_remove_params(struct sched_dl_entity *dl_se,
> +			    struct rq *rq, struct rq_flags *rf)
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
> +	if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == -1) {
> +		rq_unlock_irqrestore(rq, rf);

This seems racy. I fear the moment we release the rq lock something can
slip in and the server(s) state might change?

> +
> +		hrtimer_cancel(&dl_se->inactive_timer);

I am not sure we actually need to force cancel the timer (but still
contradicting myself every time I go back at staring at code :). The way
I believe this should work 'in theory' is

 - we remove a server (either automagic or user sets runtime to 0 -
   which is probably to fix/look at in current implementation as well
   btw)
 - current bandwidth is retained and only freed (and server reset) at
   0-lag (when inactive_timer fires)
 - if server is activated back before 0-lag it will use it's current
   parameters
 - after 0-lag it's a new instance with new parameters

In inactive_timer() we have this behavior for simple tasks, but we skip
__dl_sub() etc for servers (since we clear it up immediately).

In all this I essentially fear that if we clear parameters immediately
one could be able to trick the system by quickly disabling/enabling a
dl-server to let fair/scx tasks execute more than what requested (as
each new enable will be seen as a new instance). But, again, I wasn't
yet able to demonstrate this and I am still uncomfortably uncertain.
Please Peter and others keep me honest.

Also, server parameters changes are root only, so maybe not a big deal?
For scx automagic as well?

Thanks!
Juri

1 - https://lore.kernel.org/lkml/aQiE1ULtInJS6X4R@jlelli-thinkpadt14gen4.remote.csb/

