Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859753F9260
	for <sched-ext@lists.linux.dev>; Tue,  9 Jun 2026 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002059; cv=none; b=moaipVjdTMNP5WWx5yiBTvZE1/48FcFNU+nKjXoZD/1UQdwsmd0+zoO0M5/sf27KmPZt7aNWwmiWTHl+SJztRLwDho1VCXwIb3eH9zi3jbYBXaxTHq52ZcAAt/gfyviHX2pKNCWnIO/afDLqOEnJs+bEpZvKFu6RiTcstl91ebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002059; c=relaxed/simple;
	bh=5BU7BTvCm2MLAN3ZJE6HJEn8mf1z0MvGNLlbq+J5GtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qy682qS1dSH+aRIkF6XMj9gEhinr7f46c4AA6Ip9Sevl6SERGBvkd/ifmNUMDp339CvOXOMmGahi7cVhOzmDEm4xmZrzVnufuE8ntWqu4Bb3u6vr7O+GA49H1/hwjf9XYxTtdvDdZSmxacmKhbuHBVw8v7gl/TUSjdCwL6nON4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=a6XHNQ0u; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="a6XHNQ0u"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490ac357c55so58816335e9.1
        for <sched-ext@lists.linux.dev>; Tue, 09 Jun 2026 03:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1781002056; x=1781606856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K5aAcU4MtL73dOMrhKLE4+sZ4BDx51H3GnN5hUoWvrE=;
        b=a6XHNQ0upDvAwvpX5sL1DftHdx4u57lC1viORtsh2xMX0VxE+krEo0dOKeP+pQf9io
         f0YO6DOqrn5ypTJ5KgnkUhNmlPkAqIUEaFDpepeUoOLr5OZCwR0tx4XHKlLBq5HwreUi
         6AVwWQQkFtdqH2BQ40CLwpEqmRbnL4TshzcOFpPmq5GBnO41YU4KM+a5vS9yfSp5J2Qn
         hAh+jMU1UbzThS2gYNFptHWU2xS1MT+hSlZALYc+9AqTfan9fZ32KkYcyfurRrHsmD5E
         4g9q32x7JW+aTX6yPPd9Eb+TkDXGLpzgu4/u4JXgeWb7nVBm/T0CcgF8BdPIypaiOTmK
         NHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002056; x=1781606856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5aAcU4MtL73dOMrhKLE4+sZ4BDx51H3GnN5hUoWvrE=;
        b=HtUq/Z7fTbUTqabXsBYYzDdR5LAfsE9wCMqys4DHwMlau6mB0N5ZMA77eSp76ARBsZ
         lg1LbRW0MSCBxTlIsTAHFcAZL3U+eoo2FumwWGndGu5xVuZqop2w266UL2O8QAErEXTg
         wDWLwR94nRKAyEf/5Rgbjodqs5tIgT/Ea0PlMdkUihQhoPAnXP4O1rlxm2M5zSAyzgJq
         Rt0u+moGMYH9w93Kzs77FIu2QLx3TIX32P/4Lu7A0ztqKPQ9WD0m0827ctw5zZCdx9TR
         7Kdx48SspU7v3zYuwigKSbeiAn0Y8Mv7BrtF1tjFrW2hVUaN4UeElsKLuQ4R0haTXLfL
         25kg==
X-Forwarded-Encrypted: i=1; AFNElJ+sOLQMGSGpiBPWKrKyC4fWRuUfO9lfDe9UNcQuvEX5VvaCgASBD4DOBNo4RC/GWtWncU/Um4x7mdU=@lists.linux.dev
X-Gm-Message-State: AOJu0YzL8gKWe1X4/oCNOn6cneyyr4Ff5cj9/yu1Zdz+hDQwYTdSOCA1
	AEgjEtTFwcT1Bvq2z+WUwFeltNJ6EdxxQXt6AGQ46K6x3BDiuyiEOZlDBnM07Ky94+XqGq55L9c
	s6uxE
X-Gm-Gg: Acq92OH0wwETVF9o5mIh4GXs69mv9hmcuWaVsmcXO3Wv7+uWUS2VIWEIxCARaEcyfZr
	Il31PDeTXojc4FcxTxG9inNkQpfd+G/zObXN7JEPWmuNB6qBSWf+yoXKEpgn05pNuh2A9ePfAVz
	Qj5hmVY3/O6nYCM1+73+ZZ77+KGVZ/IGDNkw3a4mYWMkAmmxNUdoghBr/A/0BU7Tt0PB6SmCRJh
	CKgw8IMIm9p8+Ev1c6eov8uwvtlSuyr4s/DxxI6WB0qH4ihLtQn1tbyvAsP8J5Qw1YlD3vfIP/T
	A3/XrMiXL7RyA2jlHINtAigNY6zh5HGiXrlFiki0KnKxDjyMhPhjjB6oJnEs/EzPSUe+jAGwivm
	Z7uBh61P8lzcM3J6y98RGxUZextlgSHEpzxf/udY641nSa1BC1v4uNjRtIrEY9Eocd6b3yTJVRD
	biqst5a2EjDo4ppJjjW6vwVH3EVAvXA+zpgIr4NXk=
X-Received: by 2002:a05:600c:3e15:b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490c25f67d9mr319951875e9.26.1781002055673;
        Tue, 09 Jun 2026 03:47:35 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:ebe::178:1cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm457413665e9.7.2026.06.09.03.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:47:34 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
X-Google-Original-From: Matt Fleming <mfleming@cloudflare.com>
To: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: sched_ext/lavd hard lockup in old call_rcu_tasks_generic needadjust path
Date: Tue,  9 Jun 2026 11:47:33 +0100
Message-ID: <20260609104733.1184001-1-mfleming@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi there,

We're investigating a hard lockup on a 6.18.33-based kernel with scx_lavd
running.

The vmcore shows CPU#67 stuck in:

  native_queued_spin_lock_slowpath
  _raw_spin_lock
  task_rq_lock
  sched_ext_free
  __put_task_struct
  rcu_core
  handle_softirqs
  irq_exit_rcu
  sysvec_apic_timer_interrupt

The rq lock being waited on is for CPU#66.

Another CPU in the same dump is in:

  sched_ext_free
  scx_exit_task
  bpf_task_storage_delete
  call_rcu_tasks_generic+547
  _printk
  console_unlock
  wake_up_q
  try_to_wake_up
  __task_rq_lock

The `call_rcu_tasks_generic+547` site is the old needadjust path that
prints:

  Switching RCU Tasks Trace to per-CPU callback queuing.

So the current theory is that a task teardown under rq lock enters
bpf_task_storage_delete(), hits the callback-queue adjustment printk,
then console wakeup tries to acquire the same rq lock again.

We found related upstream changes:

  3063b33a347c ("rcu-tasks: Avoid raw-spinlocked wakeups from call_rcu_tasks_generic()")
  d245698d727a ("cgroup: Defer task cgroup unlink until after the task is done switching out")
  7900aa699c34 ("sched_ext: Fix cgroup exit ordering by moving sched_ext_free() to finish_task_switch()")
  7c405fb3279b ("rcu: Use an intermediate irq_work to start process_srcu()")

But none appears to directly fix the old 6.18 needadjust printk path.

Would backporting d245698d727a and 7900aa699c34 be useful, or should
the needadjust printk path itself be deferred away from rq-locked
callers?

Thanks,
Matt
