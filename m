Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D65229B36
	for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953801; cv=none; b=qoLpVTkIkBe0AFwfIdbbwLL81PUQA2K4M58CgX6NSX+sMg+W4fbpwWj0aAWY2K7HQcM+E7+Km91MDJDiBRMrjkyt/Tn3F/mJ6+2GFxisER43Bg/gU2UdugxAbYyjjrZ0w/1xB1IwPyPMEzTAbFmEw88mcKt1eWShzSyEI2ySpG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953801; c=relaxed/simple;
	bh=L88CURN76sT3+kKjYcMn64mems4KIaIBpiqCE7sLYgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jYtiH7dczzG3y3b9tPsZA5z62zvofIodkIw63ZjuyOe2IE9xOUsAy38MMeb5nNizSKn4vpBNPiAtQyvncF5g5PULIvpLUWs9ZKTgGNP7pbguQ6cNQywaZ3g6saPbPTskUD3fakKUE4bx3falEqBrqhMjMhDXVrpmzqPXSZczOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggfuuO7g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggfuuO7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760953799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFTTrhJcTtAwy2zqRcI97c2G9J1jPFu8DQY9tZIK604=;
	b=ggfuuO7grY+qhtSFvX25IkkYqXgH+5eDrTuqzKZkrWRXmGe1XutttjInyb4itLsnqoZSq8
	D26wy5qEoFpX5pko42hiwfaDgAxohKq77w2Pm437jf9bq7xhxyACisAosCCjc9o7ZI6tIl
	dKoX8NLsAy/CztHTsqUWqEn5UFO+MtY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-V1xk_h0gOtCyWknMi6W7SA-1; Mon, 20 Oct 2025 05:49:56 -0400
X-MC-Unique: V1xk_h0gOtCyWknMi6W7SA-1
X-Mimecast-MFC-AGG-ID: V1xk_h0gOtCyWknMi6W7SA_1760953794
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4270848ceffso4521064f8f.3
        for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 02:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953794; x=1761558594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFTTrhJcTtAwy2zqRcI97c2G9J1jPFu8DQY9tZIK604=;
        b=PKkdGbrdCGei3wV/8X2+qYOI/hKQb4je4K4oot/ahowBQ55u+s4Plb7XaAO5RzxmJi
         RYJ7PVz6+2do8NkuqzYZkyvvtJ5I9UZPSHgkHZXs2uudWlg+UMuerK/kdI0dZHhyFC0r
         3TsC162aQL2GQhD/KeI5DGjS13AwL1C1i2L/bG7eCVfLbTT/lhKuGdMQx5tUdOHAACK6
         HJ+y6FPJ83o04+jRAcp0nzT3E2mcIfBLtl/OdWJpphSXCXyXwLS3RgMA1cjPsNxIobSW
         Qyc/1bPgc4sApHYl0c2aXHbyGUWLtwtL0kYTX2gm3mDzgY7TZam8aLVKhWLU0ewxPtW8
         Ia6g==
X-Forwarded-Encrypted: i=1; AJvYcCXvnjDXQd1FYKhUE9C1h3VdAz7osH6FZ+Z6B3E3YC2Vd/UQwo2FD0it7rSamDf1/eLIothUX4K4vsk=@lists.linux.dev
X-Gm-Message-State: AOJu0YwjHgQY/JhDet5uRBShY2nrdMOHJWK67WUcrhwuZMi8SRMHdzfJ
	oziLC9DydP85qnweYD84OmpGhImIoQb8doQ9wKR3H1GCIdGEE0ECFSubDW7jtYvh4bR63v/RH2H
	O7wnEN/HEQuKHT91VF53vUc2WC7zD0Ck11C7zvkS0rHCRiUlQVki2LSwnFuHxsg==
X-Gm-Gg: ASbGncs1TZ+pkuuP49iqWqq7vlf+DrMwCjFqE7OGaVWH5mDJBObtQziRmrMZdma5LbM
	7yGnk2ZrGgPI/Fy6hvuPsZVdpcGFfsMguWYWoHZJ9rqbQpF49xDZlzjzN4ZaMndFGTVYwxMzCdE
	AHUYn8jnnCv1BcNSMm8SJFIhLA3XEP0NNLmt77KawWHEmd5oVTgzBCuvuc/iPbtWuOI/aH4zZL/
	BV6YD+2imADm9bn4SjMjQSBZLlnG9/xH28yUE2yEysCNZKxCj8YO1B1fkHsUEoIfwBBqbMiG43t
	d4plMNbYaRVmmPbpcBWeaOzjK3TSJX/uDSqFxoPOEVEKqHnWuuv7nc3MyDTKqrqzjpVodDkjF6y
	TnRJ1R9qcLIj8SxNUHEeRuSCT1i+d2pQ=
X-Received: by 2002:a05:6000:240c:b0:426:ee84:25a1 with SMTP id ffacd0b85a97d-42704daed04mr9407331f8f.38.1760953794299;
        Mon, 20 Oct 2025 02:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEircX9r4vwBahUAWz08Ch5Vp4KLieMSMxL6ClC8S+P82LJBqd/Fmi99o4l9qj8yYvXucqwnw==
X-Received: by 2002:a05:6000:240c:b0:426:ee84:25a1 with SMTP id ffacd0b85a97d-42704daed04mr9407306f8f.38.1760953793898;
        Mon, 20 Oct 2025 02:49:53 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a9a9sm14899561f8f.29.2025.10.20.02.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:49:53 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:49:51 +0200
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
Subject: Re: [PATCH 04/14] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aPYFv6YcxqWez8aK@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251017093214.70029-5-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2XUduQ9nO1_aLrEnK6eGo4IlYJDC8aNruKbTdURjpYo_1760953794
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
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
> index 4aefb34a1d38b..f2f5b1aea8e2b 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1665,7 +1665,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>  	cpus = dl_bw_cpus(cpu);
>  	cap = dl_bw_capacity(cpu);
>  
> -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> +	/*
> +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> +	 * with accounting and we can retry later.

Later when? It seems a little vague. :)

Thanks,
Juri

