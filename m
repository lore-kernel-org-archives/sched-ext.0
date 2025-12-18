Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A781BC41
	for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042061; cv=none; b=Br25wcjFr/c3Qgcyybmajn3/VUS45GZ1Y7ddA+wRReF0GxJfLYs8IYMP5pOyej5GCzkFkhyHkba0sttwLoaMbVqsMWyQUCB9qbaMVu/YuD2GXYy13vt/xsxE5B+tkB3lJZVblJccxmNHazo3/rD1UjIEeD5av0tQ1wH4jGFDaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042061; c=relaxed/simple;
	bh=pdMUtduMXCj5whENGA9N7DnLbY+JEMVMPlaas2KdqgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZBM8eIUyQkE7sfvMT1eDyBsePhBlcHcLkzsa6imb6sgJYUwzgGpA5VhpOdjV+ykMZmEq6q0dS2mMoibgyz37hqxkPGixfgq+CwrLm5GPAOulw3MKfNDvrjaZLDIb0ZoXGvvD3MOhMTHf4gPKwwdS3708tW3R+6LFRK5Yir2CpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z3xBAiDV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3xBAiDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766042058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNBsiLM1lI5WSv0gDo/xxnKGXTG+8RkXyoth8Hg52dk=;
	b=Z3xBAiDVI2xyab7DNQTWecEsiVGPHegcu9OIRIMs6zxF02X1wHmv05clDp/wgaiuYI6m5Z
	1aojpv0bS/aZ2WFSJZVZdcWuSlP+g8mN8CKe3lFY+q1PUlNLp6333CeJbj+RhZLHoLAfBh
	e10D/HYzpbVgZ7M9xK/Q9lI55gwhUno=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-IKbfBc0TPSqbHoszd-mzBA-1; Thu, 18 Dec 2025 02:14:17 -0500
X-MC-Unique: IKbfBc0TPSqbHoszd-mzBA-1
X-Mimecast-MFC-AGG-ID: IKbfBc0TPSqbHoszd-mzBA_1766042056
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430857e8450so173375f8f.0
        for <sched-ext@lists.linux.dev>; Wed, 17 Dec 2025 23:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766042056; x=1766646856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNBsiLM1lI5WSv0gDo/xxnKGXTG+8RkXyoth8Hg52dk=;
        b=cVWMzZYzB44nnE1YoOy6JYwrYSn2ubTvK2kNLUkNdggFsPI3cJ4bbTHuPNa3GE51zf
         R/TSa7MrbA2GFiH0Qb8yjxZIFcJJRPicXIGIDRMetXwQMz+lQD28zmichYLUk+IxDpE7
         v3qPMxjkXopLi/tlqjyEoeuXUG+vJ/4Y8SGfmNqek6atRsQPPiFVSSpE9aqo+eCzYyQM
         ZZnZKj/HikHzZ+ZEj3/xa/yL6Lqp9snbwIWIOQ2+NwgtlRtemroCZdPCws32Enq1q52c
         LfBvo9a8JMIdz7jxCchwSUnVwLcUbfX5rQJQNBSf37oWOn2aVOy5odgY4C1bbnlWo/Ru
         QMDA==
X-Forwarded-Encrypted: i=1; AJvYcCVRqYd4pB8YGWOoTkJygDuTRWUywk02puBVC6mtgzWtZTw/dausAFJwy3CKZrnlsIgrkgUcUyKb4qY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyo3HIhcvJfBIlDWMBiIhmEmUWBZ7IUPmB6exxNFNAFDuGXqpZ3
	hQVu3XP6WfiW+4BRm2ES2fcs8OAqz1+Qst2qCzNAN2RtLvyun/dKN2HCppqsco6dQkVk4LUpL97
	NwXUyRuCUyKUhFTYYF2RRq/1cAHiDjp/ec5RSF8WOzTVqdwHGtZhW0nEoU4kFRA==
X-Gm-Gg: AY/fxX7COrEDKY/8vGX9rsRN+i9xLGWzzfYueqNS4YAB7zP1IFq+LEPiEqVJN0c4SdZ
	pTLM/emGUYheye4SPmP1KYQ8Efa7hglmm7QL9hjktjXoPVDtnUMBaAUQB0twL23/cHUfGf99sp2
	TomlAblEvCz9un7vTRc8yUaHbkpbXoLBzt9AU0rj7nhR/3ZMo3a3EBQs6VEVq7cCWx554g83dK+
	eQgt1fNY8vMM50rzT39F4+MFm3xfuQpRO04g2UENESHXKcT47fOLeE3R9WJnNkFS3pE+uFGalAF
	C7BL+0k4cgt/d4uNaAHbcQswS3eqzdCeQKTiab/kYl8xfAFW5r8UixdEM91vgj3NH43o9Sp4WdT
	sLXiiOQdEthVtb2/+uOYgtmQN5ib1DIuayraN8Cfr
X-Received: by 2002:a05:6000:3113:b0:430:fbce:458a with SMTP id ffacd0b85a97d-432448b7f11mr2026720f8f.18.1766042056131;
        Wed, 17 Dec 2025 23:14:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmwvfPARt5/oktdF01vTTh+pbj0DvIQNLkJ0QsqlEvJKz7q81ZhZQ2a/z1plKZxslmFO/O2g==
X-Received: by 2002:a05:6000:3113:b0:430:fbce:458a with SMTP id ffacd0b85a97d-432448b7f11mr2026688f8f.18.1766042055684;
        Wed, 17 Dec 2025 23:14:15 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324493fe27sm3248198f8f.12.2025.12.17.23.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:14:15 -0800 (PST)
Date: Thu, 18 Dec 2025 08:14:13 +0100
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
Subject: Re: [PATCH v2 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aUOpxVIQieTOMifV@jlelli-thinkpadt14gen4.remote.csb>
References: <20251217093923.1556187-1-arighi@nvidia.com>
 <20251217093923.1556187-5-arighi@nvidia.com>
 <aULQ7kPm-RqHWGDL@jlelli-thinkpadt14gen4.remote.csb>
 <aUMmuRI-ZljfDuh9@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aUMmuRI-ZljfDuh9@gpd4>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EIyfleaQz_QkYoD1pZrnaSasJE4RYRAX8QpY-kKnx-I_1766042056
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On 17/12/25 22:55, Andrea Righi wrote:
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.
> 
> A kselftest is also included later to confirm that both DL servers are
> functioning correctly:
> 
>  # ./runner -t rt_stall
>  ===== START =====
>  TEST: rt_stall
>  DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
>  OUTPUT:
>  TAP version 13
>  1..1
>  # Runtime of FAIR task (PID 1511) is 0.250000 seconds
>  # Runtime of RT task (PID 1512) is 4.750000 seconds
>  # FAIR task got 5.00% of total runtime
>  ok 1 PASS: FAIR task got more than 4.00% of runtime
>  TAP version 13
>  1..1
>  # Runtime of EXT task (PID 1514) is 0.250000 seconds
>  # Runtime of RT task (PID 1515) is 4.750000 seconds
>  # EXT task got 5.00% of total runtime
>  ok 2 PASS: EXT task got more than 4.00% of runtime
>  TAP version 13
>  1..1
>  # Runtime of FAIR task (PID 1517) is 0.250000 seconds
>  # Runtime of RT task (PID 1518) is 4.750000 seconds
>  # FAIR task got 5.00% of total runtime
>  ok 3 PASS: FAIR task got more than 4.00% of runtime
>  TAP version 13
>  1..1
>  # Runtime of EXT task (PID 1521) is 0.250000 seconds
>  # Runtime of RT task (PID 1522) is 4.750000 seconds
>  # EXT task got 5.00% of total runtime
>  ok 4 PASS: EXT task got more than 4.00% of runtime
>  ok 1 rt_stall #
>  =====  END  =====
> 
> v5: - do not restart the EXT server on switch_class() (Juri Lelli)
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

This new version looks good to me, thanks!

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

