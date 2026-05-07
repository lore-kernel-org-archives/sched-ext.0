Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2F36AF6
	for <sched-ext@lists.linux.dev>; Thu,  7 May 2026 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778122217; cv=none; b=LGPtM8Z0MtYuSrsZGiuM8WGVxrtYppAg66jldaCGyQzew0wTGoCHpYEr19lD+7O5c1z7LxkQipRLp3HPNIJIH6n2xD1jgzcGjQtF9S+iSUVDtrlMmDW87Vg+u3xFWI36pSX/1gz9GhY1iyqf6+7yh+sfCsaxIfNI3QNMiogH3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778122217; c=relaxed/simple;
	bh=YsvHE0bgtEf7sOTMYOc4PB4RHZ3dEsNhhvn8pGkZnQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YwsERkN2tCeLGArS44RWf/ULLa/gGml/ZF87LIonKmSwiXdTYOyvQR9WaHb1UPEzGz8SgPwrPeedaSgrhAwjbiHTsNp1XaS2xE+ds3HFNQcCQOfOzKEU8f4d7vBQU8CAJHF1m/79CBWIaFsB7Rcu6eEo12uy1UnZKaP9Karhi6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/yHCfeh; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/yHCfeh"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8028fa6039so185638a12.2
        for <sched-ext@lists.linux.dev>; Wed, 06 May 2026 19:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778122216; x=1778727016; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx9CTrNduwwT9IqwPYPsPJELavITGXCS33lFUkmDQcE=;
        b=C/yHCfeh4NijVqr9mTl31Z6jjg1bzXouDCKFjJCc1ls9ZjXsdu7q6i/5tV/6k4IjCn
         lpAefx9R1jWDm4IDEaETm0X72A598IVMuuMQkGZkOeudj27r5CKvYSRjIEUdMuXZElFu
         l7uZP1gBPFmsaz2EZa4RrZ+2XlPD7vBaaxwpbZn07gAbVj9wq5HkK5+C2RquP/8pDqMS
         i9zyP6X+UoJeXHZ683WcSkqkLuYxl8+XHDxfSuWaHjgKCcZkBI2WO9JdmHvXDuTZb6e8
         nE+cp2P6CwGrP8y0MSahQ9EVuT2t8kKj8JyHIE1VddOcrj8FZD4HQK5XIitTy+Ze4uAr
         KLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778122216; x=1778727016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx9CTrNduwwT9IqwPYPsPJELavITGXCS33lFUkmDQcE=;
        b=CBUOPNuWkfM5qN4aJnlPoG2d92rKCBt+xE/DoFTb/7TMvAKOYGs/7EcNJxdcgUHZ0J
         kK/VBT0E11/8hJjlpoY0ivi/cspP/lB/P4zbjejh/aGVq+/VbEK51v1Bc2j5S41bm3so
         OLDxlOZE8U7ITdW6GVdID9/I+xUubyQw9bcN1lAoGaocyNUwYxCLz1QUPjRk/Askl/82
         P5zajYGHvz+uMMuIT4pwuSecbUZq/2H7oaQd9PiHhRvA5D9GAj3Cayb0FFgcE9R3rBVs
         b33J7QqY56CjH9EKyDR+p2LdnbAGmDMNMvzxkyjQrrGLyZ7FpsnB+AhcWWsSdEXe8lsf
         3XYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+X+++9dCTbKQtWex6VcsSXMakEkJ1h51aaPXUqNy+ny5c07l0EvUBKAA2oCg0zDJEkQka9cKWxBCE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzMA8VWBlohrlrKw3ATBRrI4ljO0Y1FxRNt10sh/inFaSKQYIuU
	KTaO4hCtUQNdxQMiVyfboeRDN3hC9jfJeYLLEu7RSbVZuMew/k+9Tkct
X-Gm-Gg: AeBDieuL6WHt7pBy4I9k6MfdjGh6UJm33FVx9s7Cr88fTckbLijSyZq2mixyw0g5jPh
	DOKysS8OM+XNRUd8mnKw7vWjDnvmQI8MF+bAStfVtN9IQbTsXm8b+G4FhH8r/jP3XDxzOAFNE5z
	4smqJtWwqcb0J9oM/jCJITUgsqXPTP7oYaF4i7ibGiqeYvIoS5PhSFDeortFY6IkhgjScDdaK9P
	rLUI0iYwUpZABpiv/X37E3oySjm7EGBT6PGCWOFcUIAxLr5Ze+khSGt85yF9JTOmRIjfA1xlssa
	0aHLKlK3L8fYFJW0ndGuVz4vibdEJlBT1TtmXI/JK5pO8I6JzeEFp3QE9xN5cMuodHh8Z5MTair
	EozgK1cHE9cVzm33q/mwqnEIuH72P7TxG/dFcD3ITIcBYLjT4PqL3Qw3Gnsb2WD56pgQti6lXUu
	hUExNv/CNM/X3QoWyrzWiQ04jvVG0MalL/se3UE9lgeCizhV45/wf3okdNpoOo
X-Received: by 2002:a05:6a21:999b:b0:39b:9644:6e93 with SMTP id adf61e73a8af0-3aa5a8310aamr6411416637.6.1778122215696;
        Wed, 06 May 2026 19:50:15 -0700 (PDT)
Received: from SK-20220728IVMR.localdomain ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm7071017b3a.19.2026.05.06.19.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 19:50:15 -0700 (PDT)
From: Wen Jobs <wenxiaolong123@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Wen Jobs <wenxiaolong123@gmail.com>
Subject: [PATCH] sched: Fix typos in comments
Date: Thu,  7 May 2026 10:49:40 +0800
Message-Id: <20260507024940.2739-1-wenxiaolong123@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several typos in comments across the scheduler subsystem:

- kernel/sched/core.c:     'compability' -> 'compatibility'
- kernel/sched/ext.c:      'upto' -> 'up to' (2 occurrences)
- kernel/sched/fair.c:     'faireness' -> 'fairness'
- kernel/sched/sched.h:    'actualy' -> 'actually';
                           'exhaused' -> 'exhausted';
                           'thottled' -> 'throttled'
- kernel/sched/wait_bit.c: 'condtion' -> 'condition'

Signed-off-by: Wen Jobs <wenxiaolong123@gmail.com>
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/ext.c      | 4 ++--
 kernel/sched/fair.c     | 2 +-
 kernel/sched/sched.h    | 6 +++---
 kernel/sched/wait_bit.c | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c6..a1993f97bec2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10677,7 +10677,7 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
  * acceptable tradeoff as it completely avoids complex serialization,
  * memory barriers and atomic operations for the common case.
  *
- * Aside of that this mechanism also ensures RT compability:
+ * Aside of that this mechanism also ensures RT compatibility:
  *
  *   - The task which runs the fixup is fully preemptible except for the
  *     short runqueue lock held sections.
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 38d90baf78cf..fa99ba358c09 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5203,7 +5203,7 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 
 	/*
 	 * We don't want CPUs to have more than $nr_donor_target tasks and
-	 * balancing to fill donee CPUs upto $nr_target. Once targets are
+	 * balancing to fill donee CPUs up to $nr_target. Once targets are
 	 * calculated, find the donee CPUs.
 	 */
 	nr_target = DIV_ROUND_UP(nr_tasks, nr_cpus);
@@ -8025,7 +8025,7 @@ __bpf_kfunc_start_defs();
  * task is inserted.
  *
  * When called from ops.dispatch(), there are no restrictions on @p or @dsq_id
- * and this function can be called upto ops.dispatch_max_batch times to insert
+ * and this function can be called up to ops.dispatch_max_batch times to insert
  * multiple tasks. scx_bpf_dispatch_nr_slots() returns the number of the
  * remaining slots. scx_bpf_dsq_move_to_local() flushes the batch and resets the
  * counter.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 728965851842..2a3025bce927 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13728,7 +13728,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 	 * If a task gets attached to this cfs_rq and before being queued,
 	 * it gets migrated to another CPU due to reasons like affinity
 	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
-	 * that removed load decayed or it can cause faireness problem.
+	 * that removed load decayed or it can cause fairness problem.
 	 */
 	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 		list_add_leaf_cfs_rq(cfs_rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f63b15d309d..22d8924854a8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -394,9 +394,9 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s6
  * between defer and replenish but never actually enqueue the server.
  *
  * Only when the target class does not manage to exhaust the server's runtime
- * (there's actualy starvation in the given period), will the dl_server get on
+ * (there's actually starvation in the given period), will the dl_server get on
  * the runqueue. Once queued it will pick tasks from the target class and run
- * them until either its runtime is exhaused, at which point its back to
+ * them until either its runtime is exhausted, at which point its back to
  * dl_server_timer, or until there are no more tasks to run, at which point
  * the dl_server stops itself.
  *
@@ -405,7 +405,7 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s6
  * subject to CBS wakeup rules -- without having to wait for the next period.
  *
  * Additionally, because of the dl_defer behaviour the start/stop behaviour is
- * naturally thottled to once per period, avoiding high context switch
+ * naturally throttled to once per period, avoiding high context switch
  * workloads from spamming the hrtimer program/cancel paths.
  */
 extern void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec);
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 1088d3b7012c..47ab3bcd2ebc 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(init_wait_var_entry);
  * given variable to change.  wait_var_event() can be waiting for an
  * arbitrary condition to be true and associates that condition with an
  * address.  Calling wake_up_var() suggests that the condition has been
- * made true, but does not strictly require the condtion to use the
+ * made true, but does not strictly require the condition to use the
  * address given.
  *
  * The wake-up is sent to tasks in a waitqueue selected by hash from a
-- 
2.34.1

