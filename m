Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602864;
	b=f+eOofoxI5xDg0xj7XTW9LYXSg/LbwKn27aghcZzGSZNi3DPf/nDYBbNMwy60jaqpB0V
	 QznBn5UnSfU8z7Tw5rq150sg5HJv7YGbDWr4LYYg4dOhFoF35Hm53AWzgGDtWDL0+iN5m
	 6I/oO8NzQrKdoPHz7EB66vreTiJSdqienO7E/p6PhFt7GyeXbrLKAIwHSVewOLwzOlplJ
	 EevuKDQN+PoMdF7zYJMWvyvMYYzJP/+dTAmMi1AopybrSvHQLs+zGOMTXmwMCweu8xhSM
	 UQMEicQfeZL2SRg8ZfKsRAqRl7KWI2dw3zbxtB096S9fMtmWM1jV6R4Geoe5WY4gKSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Bh40TMQ5zhqKhhc1ugkinINTk0/FKZGuX15jzq2MuC4=;
	b=t/6Gu3bgnaOQk4gO/68z47VS7/hgfpVTNxsbFCetrgfqtKfcVM3Cs1vpEKkLUIp/pZJK
	 SajqI8+z2cdyevjBGcQjgXIUid5Kr/YJV3oSgcch+39Hw270IxJmLSGmqi0p45MGsR/zx
	 ALb9BnxgDz90lG5lpH/k2sCz8atTtiYYWjCBsxXWZ+7coVhT1+3xbZ9Nm8VKCS71+LcrN
	 VhDiuTqCpxiLLhgo677fhqcoRMe8tbgTBQpgkfl9+uJgxfUfiPTLF/SGnwSpvIZvIT8Yd
	 2sIFVZF/CtLiRpXSand4Rm7kd3niaIIo9G84z1oiXdo5i5gmopQhfBNu4FrK1PE9O7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtO4sPJd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5760A2633;
	Wed, 25 Nov 2026 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtO4sPJd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB561F0283E;
	Wed, 25 Nov 2026 10:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795602864;
	bh=Bh40TMQ5zhqKhhc1ugkinINTk0/FKZGuX15jzq2MuC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YtO4sPJdsOSCmMfmxPBa3Dfa9iRH2Gh7rYDuzbhJUwi27/WPFg5eCf3o9Shc3D8AZ
	 ImbZioyqZ+gubnF2vxoRfKo2BtaghKaFQZ0jvrP1YL+l0j4ulqa0M1tXUw5g0KZFn1
	 ApXKNQP+E+2z5gzwx3s5uYD4w7VBINLKbnemmAnNfQoHOVuXiHn7SCPwLgYXoUUI70
	 8M5KL3owxhJcEDekt/aTpA1EQVNXs1nqAsFU5N/5ARcA+isAsCThTF4wx7PLNi8HJY
	 t+jhGVSi0uXnRsuZLwtcElpu344inEfWPXZPhg7EwV9yBwlZmSuynwheUN2vAMP2Lp
	 tmnSqDkB+WN8g==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Hang Zhengyang <hang.zhengyang1010@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: Start ext_server from the remote tick on nohz_full CPUs
Date: Wed, 25 Nov 2026 00:34:20 -1000
Message-ID: <20261125103420.2785659-3-tj@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125103420.2785659-1-tj@kernel.org>
References: <20261125103420.2785659-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a nohz_full CPU, the tick can stop while SCHED_FIFO tasks or a single
SCHED_RR task run, and ext_server is no longer started from it.
sched_tick_remote() does the tick's work once a second for a CPU whose tick
is stopped. Start ext_server from there too.

A nohz_full CPU running an RT task is now made to dispatch about once every
two seconds while any task is runnable on SCX. Setting the CPU's ext_server
runtime to 0 turns that off.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c    |  1 +
 kernel/sched/ext/ext.c | 12 ++++++++++++
 kernel/sched/ext/ext.h |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1ac779bb34f7..7a8ae8e8d7c6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5925,6 +5925,7 @@ static void sched_tick_remote(struct work_struct *work)
 				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
 			}
 			curr->sched_class->task_tick(rq, curr, 0);
+			scx_tick_remote(rq);
 
 			calc_load_nohz_remote(rq);
 		}
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e081f853a155..c96d94a7767a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4511,6 +4511,18 @@ void scx_tick(struct rq *rq)
 	ext_server_tick(rq);
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+/*
+ * Called once a second while @rq's tick is stopped. An RT task can keep the
+ * tick stopped with tasks runnable on SCX, see ext_server_tick().
+ */
+void scx_tick_remote(struct rq *rq)
+{
+	if (scx_enabled())
+		ext_server_tick(rq);
+}
+#endif
+
 static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 {
 	struct scx_sched *sch = scx_task_sched(donor);
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 366cc1d7089b..6ce6d50ac393 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -9,6 +9,7 @@
 #ifdef CONFIG_SCHED_CLASS_EXT
 
 void scx_tick(struct rq *rq);
+void scx_tick_remote(struct rq *rq);
 void init_scx_entity(struct sched_ext_entity *scx);
 void scx_pre_fork(struct task_struct *p);
 int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs);
@@ -63,6 +64,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 #else	/* CONFIG_SCHED_CLASS_EXT */
 
 static inline void scx_tick(struct rq *rq) {}
+static inline void scx_tick_remote(struct rq *rq) {}
 static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
-- 
2.56.1

