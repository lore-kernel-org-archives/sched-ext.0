Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5E225D6
	for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964359; cv=none; b=pgbIGlwcEPXueH8Kz9FLskOh6zlX0xsSDDjATV2PDHApFxhP2QYJuN8MQaD1Qj0ji6BINRoPMEbvyun0+yKRkZLGbiGZmux0W8VrQ9KIIgZ610Sb52Wr8YA6i+q2iuzyNgfcgOFRFI7XrIHrSgRw9iRcX01cjlvDo3e7EvdHMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964359; c=relaxed/simple;
	bh=pP3A5lVFp+TWJlDAr+FZUeR4ot4uHjyyYG0uyvoNEmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CW+AovfR5O47YfCZl+MKyq5bABl66Ts6N80qkA1zqJOx4orRjiWe38N8+WEIFXbwDm8PA+oHDR0bWf4p4DehhtJIIrDlUFPdsdKJiIwlGzdHj+jgvrLpPS0kWE+eNHB4rSNOtMh8DN6jZQp/zmIwU/clvunOJI0F4NAnY4o4jxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htf+Jfua; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htf+Jfua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760964357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8arYXBG+DW3SodLFxrTiKZROIPvWVTu4xbqeXb0NwI=;
	b=htf+JfuaQCtihPWdLM2F62dIw9LRfDkSkDL/HHwQ/llqmbhuG2h4OcKT0/tLKRoZCqKKii
	WxKjKCB8mA83PGfLyqmvnGqKqQPirPCY8Q8UY2bjL0KYygV+q5JpSkI8A8QtMKNVYWVSYd
	wha21teRc2k+6++zV66ixsIMoEjSGbg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-J3s0_rw9NS-kdEImZJlPog-1; Mon, 20 Oct 2025 08:45:55 -0400
X-MC-Unique: J3s0_rw9NS-kdEImZJlPog-1
X-Mimecast-MFC-AGG-ID: J3s0_rw9NS-kdEImZJlPog_1760964355
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-427091d7f2fso961827f8f.2
        for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 05:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760964354; x=1761569154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8arYXBG+DW3SodLFxrTiKZROIPvWVTu4xbqeXb0NwI=;
        b=fUP8ocQwJv3vknKm/Tvlk0526WJzDfKBjwu822dHW42dHQNci0YQWSeqmzbO6DeNm9
         R21CVk2wZ0z3bczQ3BRl29xem/PR593bzLjtBNhI5w5yoyLIiiHt89TnZG+ZsI/kqucE
         AZBUc77SryH05KViWfIMKW9gBn7HC/ZFRsKT7hM/IvO7511C9CVAKbQSYkseM4XJuTxc
         7pN1R9Dc/ovaQvjEItrTkPbyv049t8DHqeYAacA5dyWVRUjvUP0KmNXo6vqQg/yrzFld
         mFXN/EXa1zXMgYBE7WzhI45wIj9N5DcXUlpLnFTJjNEEaYIQh5gvup3iwl7qmBXM1NqB
         6HEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZUqexnGsS9qjFJIIFzVGGVWOkyKZ09iH54GHypkJqr1PZL8zOHlYHyz1MPgfljTEBkEIbMB/ZBaM=@lists.linux.dev
X-Gm-Message-State: AOJu0YylCM5xD9iMqonCuj4ACkAbdH9G/vc896kQ+OdCC/QT9MrHbvYC
	8h6gA8YPABELay9WFqv594z9YEY7U6kHbmkL1X/mHOt96kFJCUKdE06lonBDZfs8cQiCJ99O4rh
	A2nR2F1fyo7Ag5gVtKHuDmNH1P9VIssvtuMfvnhM8XEP8jd0WYmKZhmmMlwEwJw==
X-Gm-Gg: ASbGnctNmo9rieXZ37Ivs48hEK2gkxszBQjCZ/OWj1WcyNK6AUQnTMhdqXnNqOaKobg
	1KK/VBRScT3QSp6KjbPXrfaXwdujqhFO8d625dOVwdyh+sAzi6fVb2/G6nEU4KMN5TXS+Wsema2
	E4BTZMps/FOhVMBbzG+IMtNPZaToIk7TD2OfFMKhVVjUjwqO7iiaFLW6fXZVQiXvvyQvFwRyrFq
	ligXFfUmsQWUjDsK30QD0jeAy0Nb7G/WDUmxFCzSXk8jMi2mAQs+pLZY9js0XR/Og/kaLfNR36c
	MCiv+k/MwISJE6LSnz5MRBRO12SGhQr58oz1t01Nl2R+witwCG9isY/6BaV78zgSPbCVKpPwfHA
	XVK+euAXynq3ChSHcoVMDGSj5k91OKg==
X-Received: by 2002:a05:6000:2c08:b0:428:1dca:ffdc with SMTP id ffacd0b85a97d-4281dcb253emr5610050f8f.47.1760964354460;
        Mon, 20 Oct 2025 05:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9O5gCxZwTvWdqs5vD1NFCOQQ5mTNsM7VkdHL37Gjdb+1cITrv3BccUNrbtLnGONIEq4LZcA==
X-Received: by 2002:a05:6000:2c08:b0:428:1dca:ffdc with SMTP id ffacd0b85a97d-4281dcb253emr5610016f8f.47.1760964353963;
        Mon, 20 Oct 2025 05:45:53 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a96asm15201768f8f.31.2025.10.20.05.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:45:53 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:45:50 +0200
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
Subject: Re: [PATCH 07/14] sched/debug: Add support to change sched_ext
 server params
Message-ID: <aPYu_obVO4QjbqUL@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-8-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251017093214.70029-8-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xBbeKDbwLeeqhdhUvN9hR68Onk3B0R-wqqGfQ1QOpfk_1760964355
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> When a sched_ext server is loaded, tasks in CFS are converted to run in
> sched_ext class. Add support to modify the ext server parameters similar
> to how the fair server parameters are modified.
> 
> Re-use common code between ext and fair servers as needed.
> 
> [ arighi: Use dl_se->dl_server to determine if dl_se is a DL server, as
>           suggested by PeterZ. ]
> 
> Co-developed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---

...

> @@ -373,25 +375,25 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  		}
>  
>  		if (runtime > period ||
> -		    period > fair_server_period_max ||
> -		    period < fair_server_period_min) {
> +		    period > dl_server_period_max ||
> +		    period < dl_server_period_min) {
>  			return  -EINVAL;
>  		}
>  
> -		is_active = dl_server_active(&rq->fair_server);
> +		is_active = dl_server_active(dl_se);
>  		if (is_active) {
>  			update_rq_clock(rq);
> -			dl_server_stop(&rq->fair_server);
> +			dl_server_stop(dl_se);
>  		}
>  
> -		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> +		retval = dl_server_apply_params(dl_se, runtime, period, 0);
>  
>  		if (!runtime)
> -			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
> -					cpu_of(rq));
> +			printk_deferred("%s server disabled on CPU %d, system may crash due to starvation.\n",
> +					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));

Guess this might get convoluted if are ever going to add an additional
dl-server, but I fail to see that happening atm (to service what?).

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

