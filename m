Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059322E62AC
	for <sched-ext@lists.linux.dev>; Thu,  5 Feb 2026 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312014; cv=none; b=ojIqqR7GiKYvrvAop2HUn0Lp7h93zZZg3OsgXPnNO1ueYsQUj507fkxtTERpfU/zSUZMJqtB9Z/kPrkMeJe3f06sMvkwlxOfzUCQnPcn0+OHGC1/wBIF5t7aBXPUbhoBLa0kJdUIxeirQvZ27fDKkLwUf09rjMG/q62JLGwbzBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312014; c=relaxed/simple;
	bh=N+O5b3okJf58AQ08ZBJ3usQJByw853lkyTtyp3tH3oo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TCMQxjNr9pnD6xCIwr5DynaPv4GHOBacbhY9vHaGAgFHvlD3PoeNOHRwzblIex4pjp6W5Er5GNjsfy6vHsrRCSO7S8Z74vy3mHz2vA5yXpDlqny2dNA9tqpcWvyl0Nqwf2cJsuYpgA3sj8rGd1YXpPkNa1do08jBU16rNhTEjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRJ8sIWt; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRJ8sIWt"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8735332877so191818366b.3
        for <sched-ext@lists.linux.dev>; Thu, 05 Feb 2026 09:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770312012; x=1770916812; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8uZLSyUXyfuziZ3N+5Sv1fvm6p2ygn8U5LDj189v4+k=;
        b=hRJ8sIWt0ZyUX9vY5Sxy9hyiwOCmQQDNKhMI99fbSk6VqFshTDNyGQ/e9In4KZbIXy
         G8fzpl3cwL74esfxu00QroMC8ivB5IQvBOAlQAs1tm2VvBQLQrAfdTSZStWNt1Dsqo4r
         /5jBtRBV86f8Wc1BRtHqyCu9RUW+TqD6TS9cxNkPQWkWnh+AvuAAIe7CD4iKSIy+90O8
         GEDMalUU9Id6Jy/QpV30YT/VZtzhbjAsb+A3FSHCKQc6MvHcDogpfxiF7nhVzmpVFIrZ
         QajXa3xVp4bBo6Vu3ExaO/rYzUJaVX5zLqfc5q/xKJ7TyhV9uqsL1jEGeJnZxuk2MGS0
         dqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770312012; x=1770916812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uZLSyUXyfuziZ3N+5Sv1fvm6p2ygn8U5LDj189v4+k=;
        b=h57SDNndnQEKUWaBnAb8iOUDIvlYtExCpEnV4ga3RWejlJ8ffxdoGA68dowZ4MqDg+
         ZOZpOJLXO3b2BeVDdFBU8C75SPqKVUSi1DGKKys2ZTh0BxlEW3FdfXSHZ+1LKoTbdkH9
         TFqw4Dgck4m6WJbVgXwpZGwsJaq2h5QdkoouHs4ImfdVYgzctZICHPmdgrDqdZvXpY1J
         uEcHJ/B22d6T1JJOGcuMQhwGEJQIkwRx2EctB4xxB/J7Q5iWRd/+smtLQV7P+dPllV70
         W/aOuHJtmLNlWfu2FdoH7F/OvpsyZXKmLiCCfC7WGvfts2BuaJgZtqKzAD/SbRppmQx0
         M8ow==
X-Forwarded-Encrypted: i=1; AJvYcCXmkN1bqQq7UidecJVW4EU1OvxIkszwJCgG3t1xYFGdZSW7KRzS3rA0yjLxntmYQ/qQYIuvEedGSmk=@lists.linux.dev
X-Gm-Message-State: AOJu0YzMwTcHOATuCqotexETnnpkaEsf0LBq5YcPzMK2qL1rzrR2IRRK
	zW/Bjd0yXXllMDBLE6O9cj8bJQl8ZkKBfoxhzHirNQnbi/tPMTkaGJHtKTm2BVrjG3EHwLGz+jU
	R8RpLXWNHS9L6+A==
X-Received: from ejbbi18.prod.google.com ([2002:a17:906:a252:b0:b8e:a380:b5ba])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:842:b0:b83:95c7:f87b with SMTP id a640c23a62f3a-b8e9f2e22e5mr471838766b.37.1770312012102;
 Thu, 05 Feb 2026 09:20:12 -0800 (PST)
Date: Thu, 05 Feb 2026 17:20:11 +0000
In-Reply-To: <aYOIRZosqGk-k3l-@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260203230639.1259869-1-arighi@nvidia.com> <DG67IMOVU2GX.2CKP769EXJS12@google.com>
 <aYNnmI26oS7YNuMP@gpd4> <DG6C5HB3PHH3.2JRZX83QMLK2X@google.com> <aYOIRZosqGk-k3l-@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG778ERAXQH6.WKAOVK8AGLNL@google.com>
Subject: Re: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity changes
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Feb 4, 2026 at 5:56 PM UTC, Andrea Righi wrote:
> Right. At this point I think we can just rely on the affinity validation
> via task_can_run_on_remote_rq(), where p->cpus_ptr is always stable and
> just drop invalid dispatches.
>
> And to prevent dropped tasks, I was wondering if we could just insert the
> task into a per-rq fallback DSQ, that can be consumed from balance_scx() to
> re-enqueue the task (setting SCX_ENQ_REENQ). This should solve the
> re-enqueue problem avoiding the locking complexity of calling ops.enqueue()
> directly from finish_dispatch().
>
> Thoughts?

How would these fallback DSQs work?

1. Would inserting the task into the fallback DSQ trigger ops.dequeue(), so
   that we can later balance it with the re-enqueue?

2. Which rq's fallback DSQ will the task be inserted into? The one belonging to
   the CPU doing the dispatch?

3. Is the re-enqueue going to happen inside the same call to balance_one() that
   tried to dispatch the task?

I'm not opposed to the idea, I'm curious to see how it works in practice.

Thanks,
Kuba
