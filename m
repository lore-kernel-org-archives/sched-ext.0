Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B1A26E146
	for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876095; cv=none; b=IhrCG0W/wqEYbUiql3iWPK3YpYJw6wmSHSclpMgZGL6oochCLYK7AOr1xedpTV8jgb6vlAFT7IhycacuZqFqJjmq1Bsb9CysfQidVo1NaFwVl3ZCBbN4FNqi7npqzlIXdNdR4LZ4Gv4Pxc1kMQMJSt+ql3aeHRUw9EFPBttIznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876095; c=relaxed/simple;
	bh=2YsMTLpmOLn95OEADZmPKaAxC+FcbQoGHx2UChouhRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL9biGLfZ8E8xdklY93xMPCRYB3YuPHTuvvPcgJu8osZ9GrAFtBtZWIH0inIzqNTMD5AMHHZB+UrgL9l0EQaAkHmlcIPIW6v0AHxhY4PRIbbMcLcRX/Xu7Mo2mhGTVZzfW4OGcLJbY+jhv81xLV/OYM2TPt3BgpSzCWRrhTGi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3/ujoBv; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3/ujoBv"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8909f01bd00so419251685a.0
        for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762876092; x=1763480892; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zjo+6EqMgK5JhcaDAg4iVPh7lPSM1/wDO/zr9B2pTG8=;
        b=Z3/ujoBvZYdCq5sVqFUrZ/a+Nw8xFbs6kn0zJ7lWMLOHBXj9SZM8Er7bzS1RlHd0h9
         O4uYzuxqu7VfnMBTxeGlgGZOUB4/YYEoYiKt7pTQ7bsf2CrNfHF18YbPBHfB9e72X++/
         qmQQelzEWbnTX5KLev+YbMjxF+ab/kTagfnSAKK3UaLNTnz0PL3YuDqgDCT0xjospBQI
         +yCmn08Dp2e8R67I0PK1EdXzixPAUcAsVNPsH+Ht/bBPVkGzZIJKJpSHiZfowi7CBHqm
         cp8vgwSn3IkZg1M6l+HNIevAjGgdjkDABJTjBTmHM+k2tz3ADcn4jTaTOZa32vRv5+Mt
         Tj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876092; x=1763480892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjo+6EqMgK5JhcaDAg4iVPh7lPSM1/wDO/zr9B2pTG8=;
        b=ryFwA206AE2FWVkZ3CSdFK+J1W5vDbA3FEkedfd3vUbBpRNyakM8ry1P54Tp2DePZq
         MImo4PcdS/JAQ6zuw9RrJy2EFl1kGdcOhQJV/4M4g6TtmYPKcbtsiTWWLWueofRd+FjU
         rujr1QhSMCOhw3FOrG85GzrlD1CpMQORZ/dhaLMpMgylDWAAO4j43RUUSWAaTcjqNwqo
         e3pQaCJtXABb51o781ZqlCI+b/h88DRJRQI4UBoTqVALGzkTxzPekvUfsszwi69LjGj4
         vVxt9T6GkDwGpZxO/ABpIvyP6U/DKq254XbL2CQjseJ2IGe4pWBRS0fxKJJs8FW1cyyo
         Xw4w==
X-Forwarded-Encrypted: i=1; AJvYcCXT3K4NSbnW6xd45EhCrD2Co+1Y/DgrWH2pYuVe6CakCqHfag4biA1XAaCk7VikGIPFy5ECQOCHp3o=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyi3oOXGDjwC1NGgLbkPTR5uRaKr1GSnVJnlHGqWcZllyxoKsLL
	1hCBmDeu26fYExWE1SvgVShrKKClwkU6Y7yh7WP1+Y+xux5rzBXL4dEP
X-Gm-Gg: ASbGnctHwEimoIQPmdHmjqRH0b97qC4rqw8LWBVcp7hqsGa97wBWGNL/PFUm7oISrVy
	csTrBSl0I6MZBAxAWKKIeCwNE8cibiOj11ghvi8UwDZbGFbhF56ODC21PzYitXZosEEWp9AuSuy
	ngZP/8S0fwokn6E31fArDqD2mj9060+RVOBacifPqBVxvI3tRfBoDLiFl4ySgoG7qrqupiGpsl/
	I5c2/HEHRm9lCA2QYYCem0v175G+FPfoNbNDJNuO5BZ5bTR4LOOOGkew03Oonc/UdltVibdFJ3P
	hZRv3u5oOXh8dNzm50lNZmI061yRcsJ1c1TEi/E9JTyQp5SCsnP6diq6QH5l7WtJQ5cg8ty4K2h
	Rhrdhx+fZQzxoqDFjpl+FByV5s/alJsXU6ZMG8feXEM8xzzAcyFsAmTYC6q7Yl4f5yb00v6whxN
	RdzF9LnhEPX782XA==
X-Google-Smtp-Source: AGHT+IFJ5Gk9VZ95D4A12JbFGZOYydzV7K+WeCJvr4ZyANHVoUa1GE7mGCggYVoDXWOhm8w9/nF55w==
X-Received: by 2002:a05:620a:1982:b0:8b2:7ba9:8cf8 with SMTP id af79cd13be357-8b27ba991f8mr817713185a.42.1762876092576;
        Tue, 11 Nov 2025 07:48:12 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:708f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa00850sm5607885a.44.2025.11.11.07.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:48:12 -0800 (PST)
Date: Tue, 11 Nov 2025 10:48:10 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] sched_ext: Make scx_exit() and scx_vexit() return
 bool
Message-ID: <aRNaupq88QaAoE5_@dschatzberg-fedora-PF3DHTBV>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-8-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-8-tj@kernel.org>

On Sun, Nov 09, 2025 at 08:31:06AM -1000, Tejun Heo wrote:
> Make scx_exit() and scx_vexit() return bool indicating whether the calling
> thread successfully claimed the exit. This will be used by the abort mechanism
> added in a later patch.
> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index afa89ca3659e..033c8b8e88e8 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -177,18 +177,21 @@ MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]
>  static void process_ddsp_deferred_locals(struct rq *rq);
>  static u32 reenq_local(struct rq *rq);
>  static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
> -static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
> +static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
>  		      s64 exit_code, const char *fmt, va_list args);
>  
> -static __printf(4, 5) void scx_exit(struct scx_sched *sch,
> +static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
>  				    enum scx_exit_kind kind, s64 exit_code,
>  				    const char *fmt, ...)
>  {
>  	va_list args;
> +	bool ret;
>  
>  	va_start(args, fmt);
> -	scx_vexit(sch, kind, exit_code, fmt, args);
> +	ret = scx_vexit(sch, kind, exit_code, fmt, args);
>  	va_end(args);
> +
> +	return ret;
>  }
>  
>  #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
> @@ -4399,14 +4402,14 @@ static void scx_error_irq_workfn(struct irq_work *irq_work)
>  	kthread_queue_work(sch->helper, &sch->disable_work);
>  }
>  
> -static void scx_vexit(struct scx_sched *sch,
> +static bool scx_vexit(struct scx_sched *sch,
>  		      enum scx_exit_kind kind, s64 exit_code,
>  		      const char *fmt, va_list args)
>  {
>  	struct scx_exit_info *ei = sch->exit_info;
>  
>  	if (!scx_claim_exit(sch, kind))
> -		return;
> +		return false;
>  
>  	ei->exit_code = exit_code;
>  #ifdef CONFIG_STACKTRACE
> @@ -4423,6 +4426,7 @@ static void scx_vexit(struct scx_sched *sch,
>  	ei->reason = scx_exit_reason(ei->kind);
>  
>  	irq_work_queue(&sch->error_irq_work);
> +	return true;
>  }
>  
>  static int alloc_kick_syncs(void)
> -- 
> 2.51.1
>

Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>
