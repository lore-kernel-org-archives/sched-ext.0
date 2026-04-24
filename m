Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D81835AC19
	for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026104; cv=none; b=Phjmw7TysiY/R13iHdi4y+okFyo7fu4TzUIFcAySTjLzgUtja7SQOqVTYdV2C1SqEKtxjx35/XjN8VAsKnbKFnukAEqqGyCeOSC8WxfbrvYEjm4eTrQ3Q69CPvtm9KyiMRcYXV1IA1nCjEr8WjEwLzjoSgM6ywaCLe5PPv+tPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026104; c=relaxed/simple;
	bh=qaDdz0jV8MUkdLrvnrouFxsu7R3J9W0Ihx5KgtjP5rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeN7i2115sDclxdxtqHZBoa2/07YTlWAgMUamep8H9Bfj7wsBe2zu3P4EJjkKqrm71736NGjUjb6+CFVDYGPTGvpVkbi9Xhx3OV3k4mD3lfL0KXE5JN6Ymh9g+xyxuxW5srFMThxS33ccSlAp61v9H2ABrULBtjru0kxRXLY6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHGt8TVb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHGt8TVb"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so5306260a91.0
        for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 03:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777026103; x=1777630903; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+BjyODTE2mXwyLJVsvhOeRAUZL8QbX16EWgYD8rK21M=;
        b=iHGt8TVbUZ3bkkZccdL1ReqGjXVlvn+jcWUgoTu/HOShdxJto0dov11OPzKDCPKz6S
         HJ6TORts0plbDh2RHKpqbhHzfzaVpqdyMoPztuScgHzZy1m1eTOpKJhiaNrQIXs8vQsF
         eoRzdIz6aEODiFJeC7cbhz1ETfavA1oAyjSxW1l0zZ/QZfluvzwjWNPHOcoOO6LXSvCj
         Sml7k9kAmIwJHcjIpYj3GRXu3u0ngI0P2ZC3Q9MyhdvYT7OzrN29G4WWQqgEEU0mhN1k
         er3b7yLUks2lrRD/MgixHV7ADvKreIBd8JvKhS2ZuYRe9n6r9ACe90zlrYcuyxBVn1Ul
         3kHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777026103; x=1777630903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BjyODTE2mXwyLJVsvhOeRAUZL8QbX16EWgYD8rK21M=;
        b=L5V/1ki4/kxpDxJYJi9fFFiAxwZ9/nE4qHlB7hinlipLvbmtOWl2cxgdB7XniW7b1P
         YQyRndYzBgukq6tbG6G0oGMLafcYKmaykIwdq0v2w2vHpRP9ZxrfrCLY0Ns9xHioGA/w
         DF5nrKXkd4kdDb8M/7kAvHtxbo1715FUQzO0YfsKGyScolNIeXosvi1KZHIB5dBeF29H
         fa6L6PoaXRIwJ0mY4D5cvAZ7kmsw5aQf08ZMv59p41BfMgg3fy6FeWKlrjtGqi22BnBl
         u+F4dcbOLM7FCerjjaz7PjQBc/CAQ/uk5HJIKWXBL1/QO0HY9ZtnQ+CqHLJ6/Nz1zbnT
         7qtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LV72PSI6gYsTwqIHrE2kbZYN4/tc6Twbl+QJdwdFzgMZVcUjJD8a5KezfC76FM/B4oP+DzB59yqA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxnYVlPmcwr9Kpo9p6T+uL3sVLRsHdQdiErNjjMLjyQV4KIYM1x
	0ME4ehnZGbwyE7F7vcHmCp/26L2QO079zaAJKCpWIPvN32VDG7JGkwy6
X-Gm-Gg: AeBDiesN5Q2xrIy7WAHyOwPSU0rxbeKE3R4kOuK/CLUCXd6yKARYaiLNY8gmz8I3ypu
	mjGaQFZANl/mqdmL2y1sisrmE4PYB3KIZDwANJoAjQpowme7n439mYE5QXigarLHmqdDl8BAoBb
	tqcB3A99Ugi8i86d8CSdRgl/uV2jsBYRf3vAZ0hjEzAtitLaKQd63R1gxueyyngc+UfDhUjve1T
	hdlO6zlOC/YhZ2V10GrUvv1TUQ2hTPJIrxkfrTVqG4YAhcIbzhhGTfR8w0tR3Y5J9rjIC2T7mF6
	c27XTmoswNrWVpUuO3Qg7EcZK7l21JB+AXT+qvmTwOqlm/OPcewH4tNQjOX55bi4tZwMiKU12y4
	6sNNSBkGESjjzb/G9AZ9AbGHtjQ4TNAnS8Fb0eS6NRRYmvzxV9mUSf+zty9K694ViXIJVIdPcdf
	BedZwyZJnEjJ6envchMSnbRJY7kA4yJMtI32bPYGeoDPGYO6HSW1h7VopQ7EvmFvEiG2dJCl5si
	84YJcRO61Ek40TP
X-Received: by 2002:a17:90b:4c8c:b0:35f:c1cc:fef0 with SMTP id 98e67ed59e1d1-36140473e42mr32501476a91.13.1777026102572;
        Fri, 24 Apr 2026 03:21:42 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-83-234.dynamic-ip.hinet.net. [36.225.83.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614189343esm22743994a91.6.2026.04.24.03.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 03:21:42 -0700 (PDT)
Date: Fri, 24 Apr 2026 18:21:37 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Richard Cheng <icheng@nvidia.com>
Cc: tj@kernel.org, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, jserv@ccns.ncku.edu.tw, 
	chia7712@gmail.com
Subject: Re: [PATCH v2] sched_ext: sync disable_irq_work in bpf_scx_unreg()
Message-ID: <20260424181151.Ge109@cchengyang.duckdns.org>
References: <20260424100221.32407-1-icheng@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424100221.32407-1-icheng@nvidia.com>

Hi Richard,

On Fri, Apr 24, 2026 at 06:02:21PM +0800, Richard Cheng wrote:
[...]
> ---
>  kernel/sched/ext.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 012ca8bd70fb..ff42ac197bfd 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5921,6 +5921,20 @@ static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
>  		irq_work_queue(&sch->disable_irq_work);
>  }
>  
> +/**
> + * scx_flush_disable_work - flush the disable work and wait for it to finish
> + * @sch: the scheduler

Not to be picky here, but I think '@sch: the scheduler' is a bit vague.
Since nearly every 'sch' in ext.c is a scheduler instance,
maybe '@sch: sched to be flushed' would be more descriptive?

You can check more specific comments for 'sch' elsewhere in ext.c as well.
WDYT, thanks!

> + *
> + * sch->disable_work might still not queued, causing kthread_flush_work()
> + * as a noop. Syncing the irq_work first is required to guarantee the
> + * kthread work has been queued before waiting for it.
> + */
> +static void scx_flush_disable_work(struct scx_sched *sch)
> +{
> +	irq_work_sync(&sch->disable_irq_work);
> +	kthread_flush_work(&sch->disable_work);
> +}
> +
>  static void dump_newline(struct seq_buf *s)
>  {
>  	trace_sched_ext_dump("");
> @@ -6821,7 +6835,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  	 * completion. sch's base reference will be put by bpf_scx_unreg().
>  	 */
>  	scx_error(sch, "scx_root_enable() failed (%d)", ret);
> -	kthread_flush_work(&sch->disable_work);
> +	scx_flush_disable_work(sch);
>  	cmd->ret = 0;
>  }
>  
> @@ -7088,7 +7102,7 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
>  	percpu_up_write(&scx_fork_rwsem);
>  err_disable:
>  	mutex_unlock(&scx_enable_mutex);
> -	kthread_flush_work(&sch->disable_work);
> +	scx_flush_disable_work(sch);
>  	cmd->ret = 0;
>  }
>  
> @@ -7349,7 +7363,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
>  	struct scx_sched *sch = rcu_dereference_protected(ops->priv, true);
>  
>  	scx_disable(sch, SCX_EXIT_UNREG);
> -	kthread_flush_work(&sch->disable_work);
> +	scx_flush_disable_work(sch);
>  	RCU_INIT_POINTER(ops->priv, NULL);
>  	kobject_put(&sch->kobj);
>  }
> -- 
> 2.43.0
> 

-- 
Cheers,
Cheng-Yang
