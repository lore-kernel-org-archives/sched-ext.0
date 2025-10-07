Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368B2D7D35
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831692; cv=none; b=UlwUxRoIhEPguk9sBWtQZl/vXQW3Y7Dfh00AznLZ9TpFggymRt/tjPkidC98LfWTgmidw1YSj18JwYuW0txuSs9Ypbtg5s9Necmaci9TGAuvx9Z3ZWfwE7ROEuvlHadRnD46RekeuOED5Gu6C87aOlOgBa9VJwtyo9T037MKO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831692; c=relaxed/simple;
	bh=X1iciAMY8PqRMVBzYSqFJyHJLL4pQ951fQtXxmSzeas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WmwzEtys/wzE77XC0zxGpaq41UkdANpsn4q1cL0kIv3vv9Ap271FTHTJTfCTYkQDf7DLezrip06l1YhK+qBfQcE2urY0gfOKLBkIO4xs7oo/wd/p9JQEHMfm6WGJEGnNUFkq0A1i/D++Pgq9d4tBom0qghaygx0WzRwECF47r1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFkf4gje; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFkf4gje"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759831688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mtcU9rV2NIG8/Fsnv3bz5W3lOoU/FoKHUxf6Q1GCxg=;
	b=bFkf4gjeBOdM8bIIO3o1zI93ozAqQNcNPfoXklkK579WKrAHdsvSGJqpvtf5VIzL2FaSt8
	guRtzxkkXKYkGX0QGw0xbFfdmocmA0hdE4kJnvVcJRH8Gse4fymYnic0UOJBVRDZ0TnZ9D
	nvMEjJqbe4q/XWb58VN48lJdQMvkiKk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-y85umpjpPfex3OIJOApxcw-1; Tue, 07 Oct 2025 06:08:07 -0400
X-MC-Unique: y85umpjpPfex3OIJOApxcw-1
X-Mimecast-MFC-AGG-ID: y85umpjpPfex3OIJOApxcw_1759831686
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee888281c3so4365836f8f.3
        for <sched-ext@lists.linux.dev>; Tue, 07 Oct 2025 03:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759831686; x=1760436486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mtcU9rV2NIG8/Fsnv3bz5W3lOoU/FoKHUxf6Q1GCxg=;
        b=qQU/g0N7t325NzcflEe52cZepIdVsnTowbaw/VtSjbj//f3JNyGZH3SJskelnvk28R
         MB6zFzvVtzTKOfdekRAMgDXaMaj45MrTsFxPXA+D2C033p1hhvmVgme/NpLybbBLOBkZ
         Ap4kmByn+Yvh+BlwGo6jd/B0ymoeShPPDQdEPxOejdMDW1m6Y0x84FB4p4d1x7HFFchy
         kzTAMMqxtb9emdn+NRba8s1apDr1/QAq2SzJnc6+KmwtgfzhU55SKkQ0jtnPNnuKdQ3E
         B91YR8li7Ej/1cKIxiuKy8Rzh97MwSSTCQWUvVKAzOh6ol+O8e6fpjTWhPi+NJ9QWCF3
         HKTA==
X-Forwarded-Encrypted: i=1; AJvYcCXxHwAhK9G27RkHamYkJCP+kpBcBrzx3hcUUhOtojiJVZ1JwojpfM2njZgWKO9hxm3Lq9TAOW9z9Mc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzLDJoB++QglPlKvLSuYlnYGxhmJZV9vo+4PJK4hq2ZVc+rj7R+
	x7ZcOQZjKQ/7Cck97kWp35By7BpB9WOjQrR12qhaIztMr8qqurfhRwwLOI/UOm8Z+HEujYdyrIJ
	1Qsp/aO8Vb5jym/mS2SdALu0RjyCEO9WyGXtpCbHmNCeIccj/N5pIOJ5CmzjGGg==
X-Gm-Gg: ASbGncvz9UKRwHU9MgscENbOhxiDEDBpEMfeRrUf97gdogcQz+a+ZO0lhCFLFUKcYT8
	iApbAmBLmEQalsKTLVSkNEi+VJbOiL9+Redm8wHA6Qv9EMA0ueRSSlb67oqNTconqgtbsxa1l9h
	5PZ34iAhB2sy7WtkOA42FTIdlMRbbvBbHNPM3sI13Fg+zQZAQnUS4G0CWr8d/NR05UMF4MwsKET
	4gqYAnQgZbJzCC8ACL4oXGbx33e//3E6j2MBa9pV8VUFLhAHE5aUWQ8IDK/XokI/1CbtoXMZ+4M
	UBr7WcNIlktUDL/CeAAZ7DE+LRhUDx5SjhPpO3YyNxBVMOleuS4sWDhEvnnTLDrCDTnjd+3DDgj
	JJA==
X-Received: by 2002:a05:6000:2484:b0:3fa:87ad:8309 with SMTP id ffacd0b85a97d-425671c5e22mr12150996f8f.56.1759831685978;
        Tue, 07 Oct 2025 03:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoOnbt3zl/Z0zIFMaawiwiieruc6RIjDSa5Y4OtsLc9P/dDQ+rp/oPqBnApnJV75iKliXKtA==
X-Received: by 2002:a05:6000:2484:b0:3fa:87ad:8309 with SMTP id ffacd0b85a97d-425671c5e22mr12150970f8f.56.1759831685538;
        Tue, 07 Oct 2025 03:08:05 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b0068sm24882138f8f.26.2025.10.07.03.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 03:08:05 -0700 (PDT)
Date: Tue, 7 Oct 2025 12:08:03 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 1/3] sched: Detect per-class runqueue changes
Message-ID: <aOTmg90J1Tdggm5z@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104652.630431579@infradead.org>
 <20251006105453.522934521@infradead.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251006105453.522934521@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6pRWCWdh-YrAaRtITP1pYlPsrx8ff0Wp-9kNEEyuzKI_1759831686
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

On 06/10/25 12:46, Peter Zijlstra wrote:
> Have enqueue/dequeue set a per-class bit in rq->queue_mask. This then
> enables easy tracking of which runqueues are modified over a
> lock-break.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Nice.

> @@ -12887,8 +12888,8 @@ static int sched_balance_newidle(struct
>  	if (this_rq->cfs.h_nr_queued && !pulled_task)
>  		pulled_task = 1;
>  
> -	/* Is there a task of a high priority class? */
> -	if (this_rq->nr_running != this_rq->cfs.h_nr_queued)
> +	/* If a higher prio class was modified, restart the pick */
> +	if (this_rq->queue_mask & ~((fair_sched_class.queue_mask << 1)-1))
>  		pulled_task = -1;

Does this however want a self-documenting inline helper or macro to make
it even more clear? If this is always going to be the only caller maybe
not so much.

Thanks,
Juri

