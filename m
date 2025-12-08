Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC12EC0A4
	for <sched-ext@lists.linux.dev>; Mon,  8 Dec 2025 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765188612; cv=none; b=Biw5jGeYNBN53AERyCo9qs/xr9pHoVIMj6X9mV0vl0hifc2QGvdOs0p/JlS1ldTigPJIPCUwFl1vZyK156+emCJVHRtouY17/19gOY1q5yYQb8S5DzOZjwp06LpcUjZz5xWGONpNbjphA2NTbMSpUdqTAJtsocu+jg4mjK+OSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765188612; c=relaxed/simple;
	bh=qvAJQgCQy08eM3x14SffjGgY2A3LbBFXHuxiVJj+yho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W/C8HXK1oY5RpVcLCv/ZyJXaLgdf+41hInz/mJHj8JM2kFnzDx1W3FxGstLM1HVqjaH8fuFaJDIP+1g3w/i0aGwCSho4hWaXMeCndNoF+SpAnPahybT7kUNve/ZcODX4x2AhK0Q+OMn+2RPYtmFFXt3uQHM/lS3FOIzhCgznJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GbVKDVXi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbVKDVXi"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4779da35d27so47148135e9.3
        for <sched-ext@lists.linux.dev>; Mon, 08 Dec 2025 02:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765188609; x=1765793409; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qvAJQgCQy08eM3x14SffjGgY2A3LbBFXHuxiVJj+yho=;
        b=GbVKDVXiVcXIUvVFPExH+A20ZwZFF0nkwbM+iZlHuFIEy3zRkQHNWxGdSD4k07xqPV
         mo2CX8FV+eYq8RGQc955zJkEoVl0ZdieON+Aq9vThX3fxGy6Z08m5yPVK1/yZW1UoOlL
         GpRVv2E2xLFPSSX8e2zokWjw/VOnn6gJWnT9XNZEEq6LU786R1kv1sRyILxwKVCoPql9
         mdOk10vnj+jNLriz+u6BW4YnjvNcxSWRgZtItqA3hxuN7PKpwwPCN205TdzIEP+GcqjW
         8Qu0uebnT0mXzDBa8ZKRyYJrHmSABqO5DJtkLJUNPIXsFL/iHkUlBy/JhnhNiy7pATsY
         ZKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765188609; x=1765793409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvAJQgCQy08eM3x14SffjGgY2A3LbBFXHuxiVJj+yho=;
        b=HOLgtnnnL/S2S1jdth4Lmvd68O+TZNSeBbEBQI8arGEGbfBSmH5KVYldUAR4NeUnkp
         ZMFpGm04w9GhxgkKnYsl91iX60SJX4+b6exlxkh/PHKUGHhcYo2Olit3IMJxppSm63Pu
         tUj61/hYCmQ/GmdPyd0QFD1sCLZNrKXzUCt56hXR8SorRqDulzVwb5CU6JMBU2a5G/rg
         qvN3/nkSM7Q9FGButFQkRAfSdHeJXuJpb+3NbghyHbVF7sMU4UPrdexsntNviNZYU2IE
         PGuvK2GaFKPJmu1mDJPxk0kqdieefdJLkrL0ZM1q1v5jU7tc5ZvB9DNN6aKzj/9E1FPQ
         2esg==
X-Forwarded-Encrypted: i=1; AJvYcCVRcHrOrpMxVf9nfOcNWngHVJnDyD+m1fJbzAALIIodtahDFUeMcrZvnQUaYBWjCJa0KC/eChJ5Nfg=@lists.linux.dev
X-Gm-Message-State: AOJu0YySki9rBPF35mISDWSOJ7TDDIporGvtpjvrz+bwBT3zd0rb8xjB
	1vrQwjANxDVlWK9Ul7RThQFNDNiu4S7Hc9+IHHkirG6DHDlWvP4C0Z8M/+PhxtqdFy6jZ+lSvr1
	5BLw41Ts9+eF2yw==
X-Google-Smtp-Source: AGHT+IFKl8n8hUOJ+IkmunqAnw6BgbwqfonOA/p4zto3138weU4XEGITtP+TMgG8BB1qmLKOKhNfIjJ+ykKxHA==
X-Received: from wmbgx3.prod.google.com ([2002:a05:600c:8583:b0:477:9c68:bd6])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1381:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-47939df15eemr74710005e9.2.1765188608623;
 Mon, 08 Dec 2025 02:10:08 -0800 (PST)
Date: Mon, 08 Dec 2025 10:10:07 +0000
In-Reply-To: <20251206022218.1541878-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251206022218.1541878-1-jstultz@google.com>
X-Mailer: aerc 0.20.1
Message-ID: <DESR4ZKLE36H.3MT2T8V3VLV7U@google.com>
Subject: Re: [RFC][PATCH] sched/ext: Avoid null ptr traversal when
 ->put_prev_task() is called with NULL next
From: Kuba Piecuch <jpiecuch@google.com>
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
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

Hello John,

On Sat Dec 6, 2025 at 2:22 AM UTC, John Stultz wrote:
> I can't say I understand why this doesn't trip usually without
> proxy-exec. And in newer kernels there are way fewer
> put_prev_task(), and I can't easily reproduce the issue now
> even with proxy-exec.

That's probably because put_prev_task_scx() with next == NULL is always
preceded by a dequeue, clearing SCX_TASK_QUEUED from p->scx.flags, so we don't
reach the problematic sched_class_above() check because it only happens when
the flag is set.

> But we still have one put_prev_task() call left in core.c that
> seems like it could trip this, so I wanted to send this out for
> consideration.

I'm assuming you're referring to the one in sched_change_begin().
It looks like it's impossible for an outside observer holding a CPU's rq lock
to observe a task that is running on that CPU and isn't queued, i.e.
'running' implies 'queued' (I'm new to the scheduler so I may be wrong here).
That would explain why dequeue_task() is always called before put_prev_task().
Does proxy execution break that assumption?

Best,
Kuba
