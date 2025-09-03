Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FEF308F01
	for <sched-ext@lists.linux.dev>; Wed,  3 Sep 2025 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911248; cv=none; b=n021fTnkgLuyjhxWdOst+AyBWuSJNyXadefe7480Q1dAExqLY+JQEnlSgrj1ntWgNjSpHsAcfj/gHYE28+3/BrJJgvOx4KbaINpcoPRHZh6qIN3QJZ6xtVA/xRVla51g+Duo07DDDsOTo3XfXEH/A3D4ldlmGqrIs4LuTn8vcPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911248; c=relaxed/simple;
	bh=D09xO5RtMUNz+lUT9eFiY2W62ZdVcE+VZvtzoAaVQOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KXsWR+12SuWKBJzxiJDO0giDVc7JhveE8kyj7kW4H1uW1Puc64p3SGUrRsQ12dkZC6MgmnL6UvvMlZ1q57f0HHz+3oYIhEltR6ND4USPJ9zrojF+5G4J2lsHAQVSCV4qivnU4rXus3srVMB2gUeP8OZVQ4F8GyNKAjgD2yJBEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P89TTnK2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P89TTnK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756911245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2MyENo2QT2Z2l7/9urVI2q4UwayK4sw/QbcWj6VjSw=;
	b=P89TTnK2NxRhcy9A8bNpypnAoD9Sbm5LXOHW/eM7BpQn/zjGIbJTa6Jdt4LtKemAUbgPI6
	i4dnTXdNHE5jXolxV2nACXiYni5Wd1UZM4x0Y6viMxqCG41NkxhF7HtqBkfzDy+0+vEfB5
	axs+k040PWE1DFZ602aYFlLtqpJA5aY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-KoWMdDmjMGq0iPnXsTGoPg-1; Wed, 03 Sep 2025 10:54:04 -0400
X-MC-Unique: KoWMdDmjMGq0iPnXsTGoPg-1
X-Mimecast-MFC-AGG-ID: KoWMdDmjMGq0iPnXsTGoPg_1756911243
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ce059e3b83so5222f8f.3
        for <sched-ext@lists.linux.dev>; Wed, 03 Sep 2025 07:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756911243; x=1757516043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2MyENo2QT2Z2l7/9urVI2q4UwayK4sw/QbcWj6VjSw=;
        b=f6ibzIYMTdJLp4jxAkOCBSThdYiCKbFnt8ov9rFulcWoK10U3vT3w84UzMDMAKmCE1
         b1PLYOuCflJPiz1ATaKcZV5rViA3WJzF4C4MsTZNfTBcbHl6uMPYi8orfOKgdsc0omfN
         Tw/r9VShY4op/6V9PpyD8osKdEl3YICnvHRVDnLMM2nWx2BjN/1QjQB67kNlDZSPLEeC
         VG1VC+R0GqAeZJ1rScsSzEe2DHneHj0607+OGQpBEmLEmp1qD2Zy+4v3TLQoKeQN8OeA
         4KwKn6jqFaN5sBP7DQt9LwccSMz+3GLVuHC0nZ64Rio7NIvY1cut/0KWRW4TQJzBv/Qv
         9xfw==
X-Forwarded-Encrypted: i=1; AJvYcCU+0edOySIwz0ywrupvNUxhlMG0F49XHgK/oGicweAYd17WYZ/7rVMiLEE6RJ26Q5eiwZk9HhUI5LY=@lists.linux.dev
X-Gm-Message-State: AOJu0YyGM32mS5HLfWVK7DcArEA1pzuBHEk1lh0esxuszjRzliHI1yXV
	ktMAM4UX3at/frwRNwzNL9CIsa1WqBzP5dU6oVz/AKXSaoehUAXRJ8LcU4zVN38Na1hVQSJ7rWw
	1J3F2LLE/PZejtMwDNQvIL/AEEYrX+Vb6WSsBidSa56mpfb0Wh23GvP7TKEFhcw==
X-Gm-Gg: ASbGncsWcyZUzSwo5j8tN3eUSVPKLYI4CnqBgD98uHh/SYSyws69zVW0bFT2FlJpqac
	9a7rGge2rqy9jUISExIKVKVN5uOWBQM2lHnbYBhP5Ejt0V31ETyC/CaXO+J6U5LYQcCTCG2e4Hi
	NJ+s3nQlz4pOnz0QFvxEfmk16K6iKIemCit00jGdaLGqWLEEyT+V93ayfcl2dIugdGrC0s6xrfB
	FdR8Zw/3liXK0uQZ+OHw9OXjJbiLZk6BRp8Z0ZTycFKuo2wwMRLcXhzT8a/9DzZYaOlCCR16Q+f
	4ZXKjujtW3K+QvYL9PtFj6NFGX95/grLmsPedZMTsW0vjsCqMRCvw4NPk7Cyl2lHLb5gnqo=
X-Received: by 2002:a05:6000:22c7:b0:3c9:f4a3:f146 with SMTP id ffacd0b85a97d-3d1e0a998f2mr10956000f8f.62.1756911243317;
        Wed, 03 Sep 2025 07:54:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD8shCJ79KhLYK9+uhC+SBWdMCfYQ++ofyEC0akwGhyiSFjwx2jya62N77J1MtC4Rs0XVkqg==
X-Received: by 2002:a05:6000:22c7:b0:3c9:f4a3:f146 with SMTP id ffacd0b85a97d-3d1e0a998f2mr10955970f8f.62.1756911242865;
        Wed, 03 Sep 2025 07:54:02 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dcc19a386dsm3544726f8f.4.2025.09.03.07.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:54:02 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:53:59 +0200
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
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>
Subject: Re: [PATCH 05/16] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250903095008.162049-6-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VGJvecEvOX2JyBj_1GzaWHrWdyXoYvp-Cugve6KbxTw_1756911243
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On 03/09/25 11:33, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Hotplugged CPUs coming online do an enqueue but are not a part of any
> root domain containing cpu_active() CPUs. So in this case, don't mess
> with accounting and we can retry later. Without this patch, we see
> crashes with sched_ext selftest's hotplug test due to divide by zero.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/deadline.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3c478a1b2890d..753e50b1e86fc 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1689,7 +1689,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>  	cpus = dl_bw_cpus(cpu);
>  	cap = dl_bw_capacity(cpu);
>  
> -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> +	/*
> +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> +	 * with accounting and we can retry later.
> +	 */
> +	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
>  		return -EBUSY;
>  
>  	if (init) {

Yuri is proposing to ignore dl-servers bandwidth contribution from
admission control (as they essentially operate on the remaining
bandwidth portion not available to RT/DEADLINE tasks):

https://lore.kernel.org/lkml/20250903114448.664452-1-yurand2000@gmail.com/

His patch should make this patch not required. Would you be able and
willing to test this assumption?

I don't believe Peter already expressed his opinion on what Yuri is
proposing, so this might be moot. But if we go that way all dl-servers
should share that non-RT portion of bandwidth I would guess. And we will
need to probably add checks and subdivide among active dl-servers, don't
we? Peter, others, what do you think?

Thanks,
Juri

