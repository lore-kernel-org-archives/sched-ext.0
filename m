Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABA40488E
	for <sched-ext@lists.linux.dev>; Wed, 27 May 2026 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885391; cv=none; b=l4wrpSTqZ0xMWtIxrAsRi6fLbdgl0ZO0383P4eIl2wejgyfSA41uLWu2o6RovDd1n4p3e4NmDaWRI4CS2QXVGxw5Zi/d2B3YtPPDTK9fGeR/AKJDpi/xigadCwErj8pZHeQ/fobFq6VsneTYG4hYoEe+gpYjOnbs/jIlr+lHw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885391; c=relaxed/simple;
	bh=z8SnESy3gnQbn+QFOulHBCRjZrTL9spqdHBcQCXi3o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lK0/0mwLlrdjyHxd272fnJWrIpqpRcfl5kNJKtf+fyPnoF5j/siW9wLcCl9ihHQdGw2PidWNQuZZ2uICtqjpzWatCVN9FhaDVPvgtq1jjWQE87yYdlcNBGQaQ4XK5wyc8v1Qml3zv7dO2NwEg+U0ijYHORK4FiOvHingtTBE4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwDyrKAH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwDyrKAH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779885386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00VwKjTB9kl8nKM1Psf7Af/EO1i5jirjpXmjK/eUEG0=;
	b=DwDyrKAH5BQYHgB1q638zCAmLDPhAIoVUqK3STDfIW/IwEDYFNPLOr1lZriE0I0MqosZ16
	eBETYAhhsYOhadQVcnsmIyR04yomfJKXSQuww0W1tAYSRvSL0Fo9meuQGnpn0dv2xUaGDc
	NHrQIdElxby59q7YjJqpf9Y0fDKoCBE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-I9TNDJOoPra7Fj6JKJDDDQ-1; Wed, 27 May 2026 08:36:24 -0400
X-MC-Unique: I9TNDJOoPra7Fj6JKJDDDQ-1
X-Mimecast-MFC-AGG-ID: I9TNDJOoPra7Fj6JKJDDDQ_1779885383
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e79219704so80659635e9.1
        for <sched-ext@lists.linux.dev>; Wed, 27 May 2026 05:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885383; x=1780490183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00VwKjTB9kl8nKM1Psf7Af/EO1i5jirjpXmjK/eUEG0=;
        b=Cdf3y2Y+JJN5EwEZMq7e6534+p4yM5R4LSAa0QVljKQsHtsYX6BXbl2k9nuhmuKvIT
         qcYk1OjjoQvxQFLXLzNMLpJcFj7/RXqhPX8jSubNR8iBDx8LUJxWa+NySMNDUFrfrpgW
         phD5YiWkyj2hOEftQCKoUn1Lv496gMnhLXBIvr7+nONisjA9nHomELY7zSxv+dOJXZpn
         RgJtWljVphYcymLD+hFCVOe78z7Z/afaaPkaxcA5gUzjoEHxoHyrgbBpOI2g94R5xxeB
         +vpw+yzXP3Nd0WDz2tANB7e/x3IysVdj3G2bD4VuKf8bJKMqQQZXYNBusCKR/9BX4dxa
         9RMA==
X-Forwarded-Encrypted: i=1; AFNElJ+WB6E4pl8+IN1EVSV43bFGigU4dHw1PMPnQ4woD2d7oqRqKt4OeesWviVdP/7sdqmC4Tp3kqZONKc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzSmdhFuV4+DZS7XTIp/7HqicV5/3neAnn/Y9tTZ44m/szn1E/f
	o8ONNlgqThc308uvH1txYH/e2c8o4p+WZippDqkKzCrAmkWZMeZvLdOjvmHjTdpmFuW74Wd49Jh
	yNfqMP1NIYuOcLuk45R4G5Tq57+A89++VYqrWZEpCKVyfAOZvY74eiDc0YQRctQ==
X-Gm-Gg: Acq92OGdAqZ/BqFE1l1zq4ZWu3lqYu5iIatzdYGDOapLZXGpJC2u4cVqCbAF+YDRoLN
	R6Mak6NBrNAxfmdl/ZMcBSSRh75sa6ZFWhTdw8ZZ75EsZz6kxk08rs7QO0TNbSEj6LJwxrzAS6s
	Crm4xQj8uTGGRWxbN4z7xzOaoSwLNPdOWctP24ihEz6+5ycWuUynvA83s8UTrHzOr4qp57F9Ago
	5xEGz1ThUrorRoutdF5lHhAbAwizh+G1+meZGovj4Q/di3MVWiNSJ5PkAfM7oCLlmrih18R8g14
	wE2JtuJkgN8vokjYS6tbJrPwtYYXsADcvvh6P6eDOOIauN/QbNyagqQRghIt1WNM0T983cH0ql0
	xgHT9tVyRB7RgXos61YyEZXM07y5xwXviKmnYPOimhukG1LrllC0I9gTC1X8ArJA=
X-Received: by 2002:a05:600c:83c8:b0:490:601f:d783 with SMTP id 5b1f17b1804b1-490601fd8f3mr246216725e9.4.1779885382959;
        Wed, 27 May 2026 05:36:22 -0700 (PDT)
X-Received: by 2002:a05:600c:83c8:b0:490:601f:d783 with SMTP id 5b1f17b1804b1-490601fd8f3mr246216325e9.4.1779885382555;
        Wed, 27 May 2026 05:36:22 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.44.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527f7f7sm588107325e9.7.2026.05.27.05.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:36:21 -0700 (PDT)
Date: Wed, 27 May 2026 14:36:18 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>, Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-7.2] sched_ext: Auto-manage ext/fair
 dl_server bandwidth
Message-ID: <ahblQnYT6Y9CTJMJ@jlelli-thinkpadt14gen4.remote.csb>
References: <20260526164420.638711-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260526164420.638711-1-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LY15mJG5OmejiLvutcXzLkQWxqEP3yrApId1UmhNWTw_1779885383
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrea,

On 26/05/26 18:42, Andrea Righi wrote:
> Currently, a fixed bandwidth is reserved at boot for both the fair and ext
> deadline servers, and this reservation remains unchanged unless explicitly
> modified via debugfs. As a result, both servers permanently contribute to global
> bandwidth accounting, regardless of whether a BPF scheduler is active.
> 
> While unused bandwidth can still be reclaimed at runtime by other classes, this
> static reservation prevents RT from fully utilizing available headroom in
> situations where one of the sched_ext or fair class is guaranteed to be inactive
> (for example, when no BPF scheduler is loaded, or when sched_ext runs in full
> mode and replaces fair).
> 
> As discussed at the VIII OSPM summit in Cambridge [1], a better solution would
> be to dynamically register and unregister deadline server bandwidth based on the
> active sched_ext state. This allows the kernel to automatically enable bandwidth
> accounting only for the scheduling class that is currently active, while
> disabling it for inactive ones.
> 
> This patch series implements this automatic register/unregister logic. Moreover,
> the sched_ext total_bw kselftest is also modified to validate the correct
> behavior across the different scheduling configurations and ensure that
> bandwidth accounting follows the expected state transitions.
> 
> [1] https://retis.santannapisa.it/ospm-summit/
> 
> Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git dl-server-bw-v3
> 
> Changes in v3:
>  - Don't bypass __dl_overflow() for detached servers in dl_server_apply_params()
>    to reject oversized configs up front (reported by Sashiko)
>  - A potential divide-by-zero in dl_server_apply_params() reported by Sashiko
>    has been fixed in a separate patch (not introduced by this patch set):
>    https://lore.kernel.org/all/20260526100502.575774-1-arighi@nvidia.com/
>  - Link to v2: https://lore.kernel.org/all/20260526082954.550958-1-arighi@nvidia.com/

This looks now good to me.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri

