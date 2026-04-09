Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723882F12AC
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741458; cv=none; b=bdZKF0odufyk+HFNIR/MmO5BKV6s6ZYlAuYD3/4sri2xL+R5H/8PARdzYksn2qEW+ubz8RBza5xCJJy4Wurwy9QBADp9EjdqCyitx3YEJOkEjoxVCtmEju4g8cqHFrkRrvt5W0PJIhHBzRwEoyq7M1Ten1QRPMsMGFNxyXYWHW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741458; c=relaxed/simple;
	bh=1vDONnPtuQaFBjh4i3xh/2XJZrsnpctlRxF12knVafk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I8C4JqxYPvBDXNMes8aF2tI2m/sV+jgBv4++NRtK6EsIeZs9ljWkDbdvzjJh8WOPk73jIz2mAVYKuUdNCMks26QpCr2APLBF+2xHo4WTqwS+WfFeCR8OWvDVTW/AhBowegcCFcvdYcSXakEQBXpmaovS5m8XP/385wWz5fPJwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9uJ9DZ6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9uJ9DZ6"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488bf01961cso6383125e9.0
        for <sched-ext@lists.linux.dev>; Thu, 09 Apr 2026 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775741456; x=1776346256; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oqa4eqyQLNo9cEyi+LpJijgc0BsEYFeGV08vjeCpB0o=;
        b=t9uJ9DZ6RUmfx06EWdL8gE1xF10p/w5WXinJUbzUeYDMoFSquIElu/VBexuejyZbpa
         /aLCu3zYMMUuooifiGuVYwPioHe0iQoAPzk7ALuiEXVAxKaV3ier4ynwdGvuu29vXBF3
         GavcqTe3QFq9vqvoL2uqnB3NdNGYdEtZNPBTGx6ud25bzXxptWF6+cpIjATmclF7D14w
         S8jlwU1r8o148GBikJthRG5Kz5uRHGQGXLqbV28+npyXJvpqmrycbpKsIJfKdItnjYAK
         gtOjOS2pEzuMfazj/a/SOMJ9IS0ebfFgHucWRcQiFHsfzL3INiBKKSX72XvQWokIYH++
         HObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741456; x=1776346256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oqa4eqyQLNo9cEyi+LpJijgc0BsEYFeGV08vjeCpB0o=;
        b=R4y0necjk6ri5Mqknja7XmuO4D9EBYL40Zuw+RMSG9hOQZsW7Z6QoIels3Ys2hXII0
         drEGgZfYR3gaIA2LdmVS4Quphp61hoAWGxNuD/V1dH7sDdaGeoZ0dD8qGlrNG993EZEC
         39kSIQH1zjnwFsxTnjqJVgWcUkaaJO9FL6OxJtUl9ftWtXPYuYqmtjoxsUT5GR1RXcXg
         1eogZ1QFRhqL/eXGp86t6hl7Gcu78NwBg4BnngwNoF3GoGpFxHnRgYHRsuT3yKGyYTuu
         9MEkBF1lOv0FI43Jv5OkZuWAIVhisy6CMDOby/7nV7yFnLQZITEz23rv3FxEIztdeCzt
         e3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVBOtxt1+2VSpQ5IPsq0ruS4XeR5lR1nbSS2fVJYaBPgVTmqOo+GsSO4VXzzcRduKpL9TC3RBOMGiQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyG7YWmT8kbCEOUOa6M3klLi1vg2wmu2Z7xxSu7KeWAylsIqox/
	H2LIVJpEzylQ8R25qlupxTmq0wB8PH6P8rcNQLCNb0PV6bzQcJ3koxVYNKIrR8Dm53Y+ffiaM2Z
	IZ1vzjay/i0Dv5Q==
X-Received: from wmsk21-n2.prod.google.com ([2002:a05:600d:8495:20b0:488:cae8:3a9b])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c10b:b0:488:b043:5efd with SMTP id 5b1f17b1804b1-488b0436356mr174753795e9.13.1775741455713;
 Thu, 09 Apr 2026 06:30:55 -0700 (PDT)
Date: Thu, 09 Apr 2026 13:30:55 +0000
In-Reply-To: <0e2cb8a7-31fd-423b-8660-11357c08dab8@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <adUxZ5Qp_vH6cBZj@gpd4> <20260408091821.91063-1-jpiecuch@google.com>
 <adY76wiI82pUBYkr@gpd4> <DHNS3RWRB1C5.29B8SXO481CHK@google.com>
 <adZc8caEfOZw8TLE@gpd4> <DHNU5YSWABWC.2B8Q38OKJGVDR@google.com>
 <adZsJZDFNgtod-Bd@gpd4> <DHOHR34ZLGL6.2UIL2GRFLR53X@google.com> <0e2cb8a7-31fd-423b-8660-11357c08dab8@arm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DHONT6QVA0PH.IP79IYRM8PKK@google.com>
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add missing
 calls to quiescent(), runnable()
From: Kuba Piecuch <jpiecuch@google.com>
To: Christian Loehle <christian.loehle@arm.com>, Kuba Piecuch <jpiecuch@google.com>, 
	Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu Apr 9, 2026 at 9:46 AM UTC, Christian Loehle wrote:
...
>>>
>>>     ops.init_task();            /* A new task is created */
>>>     ops.enable();               /* Enable BPF scheduling for the task */
>>>
>>>     while (task in SCHED_EXT) {
>>>         if (task can migrate)
>>>             ops.select_cpu();   /* Called on wakeup (optimization) */
>>>
>>>         ops.runnable();         /* Task becomes ready to run */
>>>
>>>         while (task_is_runnable(task)) {
>>>             if (task is not in a DSQ || task->scx.slice == 0) {
>>>                 ops.enqueue();  /* Task can be added to a DSQ */
>>>
>>>                 /* Task property change (i.e., affinity, nice, etc.)? */
>>>                 if (sched_change(task)) {
>>>                     ops.dequeue(); /* Exiting BPF scheduler custody */
>>>                     ops.quiescent();
>>>
>>>                     /* Property change callback, e.g. ops.set_weight() */
>>>
>>>                     ops.runnable();
>>>                     continue;
>>>                 }
>>>
>>>                 /* Any usable CPU becomes available */
>>>
>>>                 ops.dispatch();     /* Task is moved to a local DSQ */
>>>                 ops.dequeue();      /* Exiting BPF scheduler custody */
> Is this true here? Any dispatch followed by a dequeue?

The comment next to ops.dispatch() says the task is moved to a local DSQ,
so if we assume that, then I think it will always be followed by ops.dequeue().
Same if we move the task to the global DSQ.

Of course, you could do something weird like dispatch the task to a user DSQ,
in which case there won't be a dequeue and the task won't start running, but
that's weird enough that I don't think we need to consider it.

You could also have a property change racing with the dispatch which would make
the dispatch fail and not be followed by a dequeue, but again, we need to draw
the line somewhere.

So, in other words, any _successful_ dispatch to a _terminal_ DSQ is always
followed by a dequeue.

Another case that isn't handled here is direct dispatch to a terminal DSQ from
ops.enqueue(), where we don't get ops.dispatch() or ops.dequeue() and go
straight to ops.running(). If any of the above cases should be handled in the
pseudocode, I'd say it's this one.

>>>             }
>>>
>>>             ops.running();      /* Task starts running on its assigned CPU */
>>>
>>>             while (task_is_runnable(task) && task->scx.slice > 0) {
>>>                 ops.tick();     /* Called every 1/HZ seconds */
>>>
>>>                 if (task->scx.slice == 0)
>>>                     ops.dispatch(); /* task->scx.slice can be refilled */
>>>             }
>>>
>>>             ops.stopping();     /* Task stops running (time slice expires or wait) */
>>>         }
>>>
>>>         ops.quiescent();        /* Task releases its assigned CPU (wait) */
>>>     }
>>>
>>>     ops.disable();              /* Disable BPF scheduling for the task */
>>>     ops.exit_task();            /* Task is destroyed */

