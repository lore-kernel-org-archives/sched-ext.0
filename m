Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B797D228CB8
	for <sched-ext@lists.linux.dev>; Wed, 18 Mar 2026 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796297; cv=none; b=KOM0J0XZW5dZCwsGrUcosU6Bpexw+J2ScgGYSxkqrLGadPW7ODlgqJyfbC06fBZZzcRhPuO5lexNXJB9+rRlf+7DhIsnyQJ9kTu5Evr9Tuup8ls7kOXO2yN7rRKD+SZPW4gqKsHfOvOZ0ohHhsBF3Eww96laagMTy+KKa7FOuMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796297; c=relaxed/simple;
	bh=3av6Hueuy0V18Ux4IR4GlBwrw4O8fKoKMTedBg/5QHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhjedGK7iQusdaVurpJfW8mfaybX+VF8enbP6AMjm6O57HSF+RX4kmhZ0lC2ELxs0VRJqJbT7/4wa5nL8swLtu3hbd7aEBqP3gdh/hAHLlYKbzbFQSX7XhMoCDCHhQLBxrX61rORwSTGJm0uVJx08LVZD285omEyqUD1cCKDWCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg4ih0Mv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg4ih0Mv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aae146b604so40555805ad.3
        for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 18:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773796294; x=1774401094; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z+Vx826MjNzhvcNnkbu+BLj+vkNNIn9NZKPb0U2RyrU=;
        b=Pg4ih0Mv66jARh8P0n+yBOsvdZRCek9xhCy/g908ZPzBBxFiJahivUS047tSdP2Nem
         tNNQLmXZO5arCtdSfcXt27x9z0nUOLanR4wuMr4ouSHzDAQTqLZmkDpw1AYuivUmoen2
         wVZm4ySQq5AiHoXdjYPQOHGYWq0O8oezBeO1h/5y3PMyYjzslyfxgG4yOHLAlCZEbG+5
         0RV1q1rBmyfQpXfTxOhAQF7PY1G6z7QFCR7l0Yz/mTFr4ssgBaS0mrZn5BRy2Sz9EUML
         G0dL+UtWyoeh5w1Cr0kkhNFvBVori1cHsuuUa7azfTBWMSqBQ+xpebarPfJiLggoCDM8
         7LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773796294; x=1774401094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+Vx826MjNzhvcNnkbu+BLj+vkNNIn9NZKPb0U2RyrU=;
        b=Z7Q9NAmiDon1uGyALmY2f2pXgdf0G4s3YWCF+T9aky+Dq3hqj/W/4bNPXJ0OOqTzVf
         uO7X6ajau9uLBv/0nKR3drAS+5xx46t6FiskurFFwkDJjcC3/khWrPDVRJ/8yJkrUh5L
         Nt4/vTfcHpnXgKXRV4j3aHfWv01+bk0qoOzbJ2qBRtgZ+tCR6hG3P+T7T908hA+hL8pb
         uRF7OG/XOPFZNMFl/6YT+XN/m5vLjR4vo2CW7RmieFx7eEbYszWR4d33o9jdB2fdCWCX
         e2r3YZoVzRbWNsbGuWTjUW9xkRWB9obpLm598HT8SekqJtyEokzmtMgLv7aryicmhEi8
         wzJw==
X-Forwarded-Encrypted: i=1; AJvYcCW1AvG1XBICFs0kKQ5kuBtBKX/xLX0m3xAQ9I8lv6VCaA2NUgH+Z+aWJ2/0JMyd2WvLg4TFMaP3DcQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxbRDBQqeAy/uuZXThMEzvQ0PhvMKCYiUDFtlkcOUUif8bXJWsS
	x4QwY5mI0Ct56rOAU+aFZEaTSwh00ONzw5Qq+raDGHTOr2g6C+xLt3z/
X-Gm-Gg: ATEYQzyT3vCVL35QsM7BOTy2tVjTYePZ7SU9QXlQXnI/URCE+eyosHpmr1WZPFWGTZK
	ahdJqjnasNd5xWp4gkUFt09UPkrRPpIMCGyuRqZqWTddD8QMjyMSZ05s5urGZ830Mbty/xnL+z1
	E6cnze7luszErDkViaOMNfKmlMo1lYTr5b/tJZ0f+NxJ7aF89zrzl2Jv5vPSvbsVNR2ViM7mbQ+
	lA9XhAPX37xtIUxDkpiVf8b3RDDyACVDKVdeJkZWLYraKFRgPCsNtAC24fiiqzujwkBg2Y4HF+h
	InIG6TEky+HDRhzj1eZaJd75ha3N7ufaFcuHdXCwrCXO10z6RpgoJFeLpZyFDWNjow3WjQYAgNJ
	fq90h7dW8UogbEHXnYSDVJs5QsFzima+T9ksYben2Ldp2x5y9TAawFyYNnRvG9iWllmiFEOcQwL
	fvV0W20Yl70yzzW1qZ55wJESE6InmTp/EpUwas0rZZItrHQGHZvJ/AGhZctw==
X-Received: by 2002:a17:902:d2c2:b0:2b0:506b:e6f1 with SMTP id d9443c01a7336-2b06e3d3cd5mr16153215ad.29.1773796293907;
        Tue, 17 Mar 2026 18:11:33 -0700 (PDT)
Received: from eric-acer (36-225-83-37.dynamic-ip.hinet.net. [36.225.83.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e5f0f25sm7668215ad.42.2026.03.17.18.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 18:11:33 -0700 (PDT)
Date: Wed, 18 Mar 2026 09:11:29 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: idle: Prioritize idle SMT
 sibling
Message-ID: <mqszomfbraegntun7x4vb5x4u65nwbo74plledtdz23ean3tcy@av7vios3d3ie>
References: <20260318003842.762275-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318003842.762275-1-arighi@nvidia.com>

Hi Andrea,

On Wed, Mar 18, 2026 at 01:38:42AM +0100, Andrea Righi wrote:
> In the default built-in idle CPU selection policy, when @prev_cpu is
> busy and no fully idle core is available, try to place the task on its
> SMT sibling if that sibling is idle, before searching any other idle CPU
> in the same LLC.
> 
> Migration to the sibling is cheap and keeps the task on the same core,
> preserving L1 cache and reducing wakeup latency.
> 
> On large SMT systems this appears to consistently boost throughput by
> roughly 2-3% on CPU-bound workloads (running a number of tasks equal to
> the number of SMT cores).
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext_idle.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index c7e4052626979..e0c57355b33b8 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -616,6 +616,18 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>  		goto out_unlock;
>  	}
>  
> +	/*
> +	 * Use @prev_cpu's sibling if it's idle.
> +	 */
> +	if (sched_smt_active()) {
> +		for_each_cpu_and(cpu, cpu_smt_mask(prev_cpu), allowed) {
> +			if (cpu == prev_cpu)
> +				continue;
> +			if (scx_idle_test_and_clear_cpu(cpu))
> +				goto out_unlock;
> +		}
> +	}
> +
>  	/*
>  	 * Search for any idle CPU in the same LLC domain.
>  	 */
> -- 
> 2.53.0
> 

Overall looks good, just a nit:

The block comment at the top of scx_select_cpu_dfl() still lists 5
steps. With this patch a new step should be added and the numbering
updated accordingly.

-- 
Thanks,
Cheng-Yang
