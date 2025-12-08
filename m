Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852732695E
	for <sched-ext@lists.linux.dev>; Mon,  8 Dec 2025 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765204071; cv=none; b=SHzg8+DuYb2O8NA2SiBkRgCpbhcKGqxBm5t2tCsY0GqPyz6X05yoFBI6XgQzr/ueV+fPmktEsoxxAoTc4zblOHnBfsOzArf9PYAyEtu8dCvkZt1Wf6h3eEsKzwPZybINrjcX1C/KNUZ0V4A+bAgcqf+JiVOgjE1Ob0zo8WXmgwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765204071; c=relaxed/simple;
	bh=jTnfF7MrLhHRJSIMgSg5/ysyFxsWRn2a0qBx+Ru1f9Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BYoff40HUd19wgzWCN8H0Ow49jkS/yI6WWSKUMbMfZt80MLvn4p4Mq6T0ecgbYc8pkAECAu2vwOhM34VMmgkIWfdJGIo72BqRMmpFQXPQdvDtgM4K9dIKa8mvoH58SVBOAiPHdw+e59sarDtNgtBRTDP9H4KgHViVGxl8d9+RD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1hn8peGQ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1hn8peGQ"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42e2e5ef669so3816984f8f.0
        for <sched-ext@lists.linux.dev>; Mon, 08 Dec 2025 06:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765204068; x=1765808868; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/8cz3hpeRpzvKw2n2JmBACMdfDswKtcYuMr2lQefSM=;
        b=1hn8peGQxypwnuUdYyF5UP1+oS5zS2Ix/QF1VRkCj++tG712G9Y3/2iF5swV/21jZx
         /B4tSPKJ5c3Ou103LR7VG6ucsvE2G9jrLzTX5HjBGmCihGMWWByTJ+VjJXViHaQ8Dj87
         mDPbEZFSTKCuwSoOG4p1cjl6tUhoeyLkcwQRrKyhIkJeuhuC2Q1DJuOu3lWR4wJ0q3tE
         1hBdHGUSrjy8skBZawYQhpcQ86MzQHQrqwRgb1R8jCohRUU0q4gmiv8K1I5ZWddggAsK
         yhadO0ZHO8Q87Av+c2hi7E9MyhJPFBPJwu+M8Sj4O0K9kFGgw8kPmem75Z4jL0sbVMJa
         hC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765204068; x=1765808868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/8cz3hpeRpzvKw2n2JmBACMdfDswKtcYuMr2lQefSM=;
        b=lX9uTUPxW2ctsA2MfsUYYltOpaCGQVKp7/jaMTBJKTAkmkTZxnmOzhmu/4iYil5mgo
         ERIIogtg93xJvC+Whx5dJF4Fk+kANxCVEwv+/3QJ1O1WiMaSqTiiYuVmVPx03FUCjUBz
         nP4Z3huoEinC2HK9yKL+6xibCbm3DuAdwE2l60MOjbPcaTZRjOJpWq1nmHZlOyBTDzuR
         1XLkGkCgVaobQR8zT7nBUbN1KdZ/OkGfQFaVqVirKuxRzD0Nkk38k91kcCMNIPIf2f7L
         SHmYEUnrcAIQeYkO+thp0SfXrRfyS/SGYh8c45zsqwJkaNpqJ5XxI+22EBoe9Ly+Gj7f
         lyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrET+y7781MaYDhZQuIwf7V4xxtlRlojOdgJxiZPDlv5fdzSTD9VbziH3byBPVjqcc8exO6h6vN6g=@lists.linux.dev
X-Gm-Message-State: AOJu0YxUfoJ2UVa0EFOES4oRfKeK+oBRA/yblhIWbZ/axFvGjb2DiCon
	TTyrbDclJvFfnlwGi+zmlFXkQy0c4GYcEM3J6qDWYVQ2v1r/8S7B3MK6ssfLNXBq+641QpKgsVP
	hTBr93qTAziFY1Q==
X-Google-Smtp-Source: AGHT+IGrufoKKJrGvK9dOr6Y0/ltfC2fuziKEeCBQOmAJaNJdztrUUqNhyxDTP3VmaVgSGmIRZqIRsYinDhiug==
X-Received: from wrsy4.prod.google.com ([2002:a5d:4ac4:0:b0:42f:7623:682e])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c13:b0:429:d6dc:ae10 with SMTP id ffacd0b85a97d-42f89f453e9mr8534652f8f.29.1765204067883;
 Mon, 08 Dec 2025 06:27:47 -0800 (PST)
Date: Mon, 08 Dec 2025 14:27:47 +0000
In-Reply-To: <DESSIU61C2DE.1R156AQCNP80C@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251206022218.1541878-1-jstultz@google.com> <DESR4ZKLE36H.3MT2T8V3VLV7U@google.com>
 <DESSIU61C2DE.1R156AQCNP80C@google.com>
X-Mailer: aerc 0.20.1
Message-ID: <DESWM9HEHSK3.34TGESJUP6IW8@google.com>
Subject: Re: [RFC][PATCH] sched/ext: Avoid null ptr traversal when
 ->put_prev_task() is called with NULL next
From: Kuba Piecuch <jpiecuch@google.com>
To: Kuba Piecuch <jpiecuch@google.com>, John Stultz <jstultz@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, 
	hupu <hupu.gm@gmail.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, <sched-ext@lists.linux.dev>, 
	<kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"

On Mon Dec 8, 2025 at 11:15 AM UTC, Kuba Piecuch wrote:
> On Mon Dec 8, 2025 at 10:10 AM UTC, Kuba Piecuch wrote:
>> It looks like it's impossible for an outside observer holding a CPU's rq lock
>> to observe a task that is running on that CPU and isn't queued, i.e.
>> 'running' implies 'queued' (I'm new to the scheduler so I may be wrong here).
>
> A task that blocks in __schedule() can drop the rq lock while picking the next
> task, which is after try_to_block_task() dequeues prev. So it's very much
> possible for a task on another CPU to grab the rq lock and observe prev as
> dequeued but still running.

Even with that, I'm not convinced that it's possible to do a NULL deref with
the current code.

In order for sched_change_begin() to do the NULL deref in put_prev_task_scx(),
we would need to have:

* rq->donor == p (for sched_change_begin() to call put_prev_task())
* p->on_rq != TASK_ON_RQ_QUEUED
  (for sched_change_begin() to not call dequeue_task() beforehand)
* p->scx.flags & SCX_TASK_QUEUED
  (for put_prev_task_scx() to enter the branch with the @next deref)

From a brief survey of the code, __assuming proxy execution is disabled__,
I don't think it's possible for a remote task holding @rq's lock to observe
the second and third condition to be true.

Every time p->on_rq is changed away from TASK_ON_RQ_QUEUED, it happens under
the rq lock and is paired with a dequeue (see block_task(),
deactivate_task()). dequeue_task_scx() always clears SCX_TASK_QUEUED from
p->scx.flags.

Every time SCX_TASK_QUEUED is set in p->scx.flags (i.e. enqueue_task_scx()
is called), it happens under the rq lock and is either gated by
p->on_rq == TASK_ON_RQ_QUEUED (see ttwu_runnable(), sched_change_end()) or is
paired with p->on_rq being set to TASK_ON_RQ_QUEUED (see activate_task()).
It also happens in proxy_tag_curr(), which is a no-op if proxy execution is
disabled. Even when it's enabled, proxy_tag_curr() does a dequeue-enqueue
cycle while holding the rq lock, which doesn't look dangerous.

I'm not trying to say that we shouldn't add a NULL check, all this is just
for my own understanding.

