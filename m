Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7723AE1A2
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753887; cv=none; b=qYPJXi+Yrr0XY3gQBvYybj5fTk9621ghKo5R8oCfvAuiKqHOZqeuAefEI3EQWqMh+md48ZNlx5HBWn0IW5eXE7N8hZrUvD4BJK6Szs/4SdtmUn91S12q6kOQ6Av7cmzzNDyYV5MkuwEHJnnlpjMEn9uLAWe4noMNWRLr+5RyJew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753887; c=relaxed/simple;
	bh=737PKe1Z1dqWHfIiV98Y0bpL/Qhu9WE+6ejlzFcnf98=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UShqugZBUNaCb/NeyH3NqQrMTayiypI5NhMXUjG3jMQZaACEDSTI47mYqkDGuL71UO8rYszUPQfWlJuyRgnJHfuRu3aDdBDaa2hMG4bnoE0LWp04Og5zlqiysrXL7fz/Wu7IY7UZUmh2XY7pHQLXa3SMS27Ix/ZFVsYOo7338oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyuPOfrq; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyuPOfrq"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-66c1806dd5fso962278a12.3
        for <sched-ext@lists.linux.dev>; Thu, 09 Apr 2026 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775753884; x=1776358684; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hTeITRTwBV8u77vwqAF9dL2LE0U+mcOwYTEg5q2jVd4=;
        b=WyuPOfrqL14anH9KWIui5H28J76sCeIdSh2K38qwbGR4ot8+hb2/8yh03CZbrxa+pJ
         gDxXlzZTjkoUP2xbSn2yPE8vpRPrHd7sZ9oC4GjoNhdnZ0NjfSttg6RAxwc/w9vDKgB2
         xtH6EzYIKhkmwFebpjLVbmYc1LyO3heCGRqrUg7ZVKtuWJhRSazrUAAzXWAaaTOH5Nr0
         svvHJyz+O90fiL9tBL4jZkJNoIiJXQVA6zGgEjF7aWJsr1WUXf0zTB3vAFvl3pNytu93
         SKqGyjhDQviwpEuMb5NE/rMPC9O83PtfsC+BTxBxSHa5eIwtImCw/lNW68h1PYHaovCJ
         5qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775753884; x=1776358684;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hTeITRTwBV8u77vwqAF9dL2LE0U+mcOwYTEg5q2jVd4=;
        b=Q7ggNnTdQ748CfbaXcH7I8FchjJ+UDL7oaIEvIEb+wrdeDJDfS5tVeKMb5exZiIDXM
         RXHkRsS0KEplaKHTTp3dcAnh9C9UFN/Bwz+QD5r69I9WMKRWxrNzjFyJRBUK4A1kNzyg
         8FwpeHvNLEmTB1Hb/muhBxSEq1wXNyCh2R9MsWx4LtsWWBhov3f/u7M13gJxOGozDjWD
         xVVi9NrUWY2hpm3mRxQogyEL3stL1cEGVuXP80wj1ZiXc2RoW0QT5sB7xTj6JZYPoK/e
         dcH3d/UubNHSiSVPfzC6h4kWIIOhpap6KuGaxeEBnzleeM3ElXSZsjQdqKjgNDGZUlpw
         KXBw==
X-Forwarded-Encrypted: i=1; AJvYcCXt0yELDEpOrypkaufbv1qSiT2RG0cYuEpqCcXKflnTfiUFZbgBNWiYIItT7XIUG4zMMHsjDRYW3pg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx22uOT6OE51O5IcxuS1dC0n+cWhzM6YxqsKCp4+ElRUYyDDoej
	3tE91ijIicZC++A9+KmWDxQ7Gu3yqaX9nFVSW85tRW3N6QMXB/3pM3Y6GIJy28EHC5w27jXMQjB
	PS6HfoPWL9xaalw==
X-Received: from edud13.prod.google.com ([2002:a05:6402:d:b0:66b:eb26:53d8])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:46ca:b0:66f:76d7:56a4 with SMTP id 4fb4d7f45d1cf-66f76d75775mr4491020a12.26.1775753884259;
 Thu, 09 Apr 2026 09:58:04 -0700 (PDT)
Date: Thu,  9 Apr 2026 16:57:44 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409165744.1526489-1-jpiecuch@google.com>
Subject: [PATCH v2 sched_ext/for-7.1] sched_ext: Documentation: improve
 accuracy of task lifecycle pseudo-code
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>, Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

* Add ops.quiescent() and ops.runnable() to the sched_change path.
  When a queued task has one of its scheduling properties changed
  (e.g. nice, affinity), it goes through dequeue() -> quiescent() ->
  (property change callback, e.g. ops.set_weight()) -> runnable() ->
  enqueue().

* Change && to || in ops.enqueue() condition. We want to enqueue tasks
  that have a non-zero slice and are not in any DSQ.

* Call ops.dispatch() and ops.dequeue() only for tasks that have had
  ops.enqueue() called. This is to account for tasks direct-dispatched
  from ops.select_cpu().

* Add a note explaining that the pseudo-code provides a simplified view
  of the task lifecycle and list some examples of cases that the
  pseudo-code does not account for.

Fixes: a4f61f0a1afd ("sched_ext: Documentation: Add ops.dequeue() to task lifecycle")
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---

Changes in v2:
 - Changed && to || in ops.enqueue() condition (Andrea)
 - Moved ops.dispatch() and ops.dequeue() inside the if statement
   (Andrea)
 - Added a note after the pseudo-code with examples of cases that the
   pseudo-code does not account for
 - Link to v1: https://lore.kernel.org/all/20260408091821.91063-1-jpiecuch@google.com

 Documentation/scheduler/sched-ext.rst | 43 ++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index ec594ae8086de..2d77ab4816a63 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -408,8 +408,8 @@ for more information.
 Task Lifecycle
 --------------
 
-The following pseudo-code summarizes the entire lifecycle of a task managed
-by a sched_ext scheduler:
+The following pseudo-code presents a rough overview the entire lifecycle
+of a task managed by a sched_ext scheduler:
 
 .. code-block:: c
 
@@ -423,20 +423,25 @@ by a sched_ext scheduler:
         ops.runnable();         /* Task becomes ready to run */
 
         while (task_is_runnable(task)) {
-            if (task is not in a DSQ && task->scx.slice == 0) {
+            if (task is not in a DSQ || task->scx.slice == 0) {
                 ops.enqueue();  /* Task can be added to a DSQ */
 
                 /* Task property change (i.e., affinity, nice, etc.)? */
                 if (sched_change(task)) {
                     ops.dequeue(); /* Exiting BPF scheduler custody */
+                    ops.quiescent();
+
+                    /* Property change callback, e.g. ops.set_weight() */
+
+                    ops.runnable();
                     continue;
                 }
-            }
 
-            /* Any usable CPU becomes available */
+                /* Any usable CPU becomes available */
 
-            ops.dispatch();     /* Task is moved to a local DSQ */
-            ops.dequeue();      /* Exiting BPF scheduler custody */
+                ops.dispatch();     /* Task is moved to a local DSQ */
+                ops.dequeue();      /* Exiting BPF scheduler custody */
+            }
 
             ops.running();      /* Task starts running on its assigned CPU */
 
@@ -456,6 +461,30 @@ by a sched_ext scheduler:
     ops.disable();              /* Disable BPF scheduling for the task */
     ops.exit_task();            /* Task is destroyed */
 
+Note that the above pseudo-code does not cover all possible state transitions
+and edge cases, to name a few examples:
+
+* ``ops.dispatch()`` may fail to move the task to a local DSQ due to a racing
+  property change on that task, in which case ``ops.dispatch()`` will be
+  retried.
+
+* The task may be direct-dispatched to a local DSQ from ``ops.enqueue()``,
+  in which case ``ops.dispatch()`` and ``ops.dequeue()`` are skipped and we go
+  straight to ``ops.running()``.
+
+* Property changes may occur at virtually any point during the task's lifecycle,
+  not just when the task is queued and waiting to be dispatched. For example,
+  changing a property of a running task will lead to the callback sequence
+  ``ops.stopping()`` -> ``ops.quiescent()`` -> (property change callback) ->
+  ``ops.runnable()`` -> ``ops.running()``.
+
+* A sched_ext task can be preempted by a task from a higher-priority scheduling
+  class, in which it will exit the tick-dispatch loop even though it is runnable
+  and has a non-zero slice.
+
+See the "Scheduling Cycle" section for a more detailed description of how
+a freshly woken up task gets on a CPU.
+
 Where to Look
 =============
 
-- 
2.53.0.1213.gd9a14994de-goog

