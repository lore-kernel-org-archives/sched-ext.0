Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978413;
	b=JZN6BRcWPVsX/J6HOstLqJooyCmM1yPor/qN9LAFWT7pd/RuHmQA38kSISzU1df5eUp6
	 wDXfxh75EKSzSQzq5Mj2ph/UFrZ3v/iMt/OeHJVMbCXqIAY91M4CL0aG0wf/r4jzTE4ek
	 U6/pcvcih/9L8H+obgsDwPyuo+vuEs+Fk/YFFhr9U0PqxNTbahHskB2+MzhSojzydpH/Q
	 fotZuP7E1KM2ehg5X98xHORpPdTc6m5mAa1pVSiSScuzSF9wAXArEa4SJwxd5vPa09V47
	 wFk7p/u2uBPqVeEjmHTuYSejasH/YRX9x92xVbcTaNA5RKMy0/vBA4wMk3V+8U7xuJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uTux42or8tslpeNsQeZIKjxhj1hCw7fR6WEWeRorK0M=;
	b=QRpO1Fc/x8JfHZiAyiSOAXorShvW6468XiWXQcwzlOmaSnuPKs/2mzVzvKvddaNGOhf+
	 RRaF+pP5g5wHI3i13GZ3BtThjgE3TnzAkwJoUcbjMVjBZ1yaOdGPHr79NXJgA3XNNnYW+
	 kxzCBq1XN381aZcpJdy8Ay6tfe+DpflAPToG5ey2F2ykW1kTJva/dJ/JCK6ujmbEE6vQS
	 r0Lp5TJXItDo6iLrfb/Hvj+10ugmocbFYN78ssuTR5JDRsLXebOMFzEzP1vVHR9FeRIn3
	 vMAPmRjlpg06572IqhHbv+NH7IrJmOYJAuIA3My7ZkTDzZOeuhzvS3IT8SVKTsHygEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jx2hiLc6;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8746D6082BCA
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8746D6082BCA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jx2hiLc6
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e4831c028so773841f8f.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978412; x=1794583212; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uTux42or8tslpeNsQeZIKjxhj1hCw7fR6WEWeRorK0M=;
        b=jx2hiLc6dcApJV5/CYdbLCLF4H1opkEZjrQ+mjMjbM20+wK2x8nLeuk4Mhi9PQpE2r
         JTK+82ZPaPGKC2iE5WlSTV0rTezSob7WAso4PVC75f65LRYN2Dk3SaKzEC35+v/BLru1
         FqKSJ1otJstwZYDzNH/Gl4oVGjmtXaEM5NKH2iT7YlxhkCovX4kR7b0pYkHpi0awNojj
         wQMKLZBG6OM+2TRsJmnW/tbrFohyMpXBeI3h7saY5VC9gmUL5xHH7qEbwXOGrRkeEOpB
         kJ1ITbn3hxp4+U0D1DhCmtkuzgDjjZJzhGM4A/GbW+3YKjQKKNL1ugdUonz9MYgA2bQR
         QMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978412; x=1794583212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uTux42or8tslpeNsQeZIKjxhj1hCw7fR6WEWeRorK0M=;
        b=FYy9GtzgQLvBq3RNDpEOmTscfP8xQTJvEhAC/suZu5c+sAVC+mt/WrKW4QI3I54Lmq
         a9W0wjoZDG4WPIZ5Y0JCpIK7L2hmBtTzSwuSVyzBYdQEUifWSWp+FWZUenIfjkuxeI6A
         sdSljCfJ8PmpBBqf/lCUr+sls4JYNdIlTFrW8W2PRn2qBvOBziieVmDwRky09czdm4Kn
         pUGwbdNVvRZxLl3G3TL73wj/ui00AmRDVzJK5dIAJt6a6QvYWQM1VnSTEvygl4tN2B7V
         2zLZWddI8X3V6QPMOmyO9O/ZMpN7HXJNFlVNEceuYANCM62ppqRujy6AQW/XHcmOYQuJ
         InTg==
X-Forwarded-Encrypted: i=1; AL+hErHC+AUsmqEsB70WWiDSu/35wMpxaGLbFhFC7HNGHeIfnlw+qijEj3tv16CItLpFKMEW+v6c6VRuNyY=@lists.linux.dev
X-Gm-Message-State: APuU4Z8XXcLDcOO0YFr+KERp3SbFEHaZbt69bHks033GaTttV9RJe7/w
	iur6+1j9Ft2mb1q7X1eDj/DdOckIXRL8ImQ0Ge6rGH7hLQE9HWOpSHadvQD+oIBbzUE=
X-Gm-Gg: AYBFou1i8sQbZ/aWg4YvR4aVhOSpjVCbtf1u1C1UX2ZMyyU/X5dL4xfmQx2WlVLWOUc
	S8JNQ6ezKpB3jPpMH7flqmbI74SKzTS0uKpVK323VZLPV+rC9495SaJpjbGCnAcRO9dOPoPb5Gn
	IbrU55HiOKGVlG5mdgwbQIGZf5293aHTJzL8DHO2jqjIg7ZTTmsPLhMYP7NAycFWv/8Y/sVzUxN
	BeMneBf6Ztsbi5SVu2SuQbmFuDbfnHGjJI04m+WIum5FQSNoQ8h0VJROYMXj0b90fnkCk8TmvGn
	hD2vtc+GYVAfrrCjHEA03GPLliNdHSVyOsxBd1bJVM9ZjVgEssLm2UL53LMrFp8Truy5mmf8Hjz
	T4bADQAZj9nwI1S2jn7dtt3IHanAHLe5BLk96bor18hlwsf1MFtte5bb03t8nSdoL4fC9Z5e1uO
	tOPPyeu9QIeBJX98YxSKMwFEh/sKuP5+CVXWLrEeiITrObVSHmScBCuzcMZwpSRgLpE2qFTM1Jl
	WS1xEl74XC/gTw9+Gs/Y+IvcMBnpZYbSZ4aFGxYYTQ62UZTxfzEhCgb19JxHZ9e6ocKjy9IT1YE
	gBcDmZleySKPFab/nZb5hrg4/Lt4OKMQlchQr+QXdgL/0wM=
X-Received: by 2002:a05:6000:25eb:b0:490:421f:1555 with SMTP id ffacd0b85a97d-49275b1bc23mr5251354f8f.22.1793978411922;
        Fri, 06 Nov 2026 07:20:11 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:11 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: qyousef@layalina.io,
	christian.loehle@arm.com,
	pierre.gondois@arm.com,
	sshegde@linux.ibm.com,
	kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 12/20 v3] sched/fair: Support not wakeup case in select_idle_sibling
Date: Fri,  6 Nov 2026 16:19:39 +0100
Message-ID: <20261106151947.3991524-13-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106151947.3991524-1-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
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

With push callback mecanism, select_task_rq_fair() can be called for a
task that is already enqueued. Task into account this case when choosing
an idle CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f2a0d2c2bb63..980eda9c935a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8187,10 +8187,27 @@ static int choose_sched_idle_rq(struct rq *rq, struct task_struct *p)
 	return sched_idle_rq(rq) && !task_has_idle_policy(p);
 }
 
+static int idle_rq_without(struct rq *rq, struct task_struct *p);
+static unsigned int task_running_on_cpu(int cpu, struct task_struct *p);
+
+static int choose_idle_rq_without(struct rq *rq, struct task_struct *p)
+{
+	if (rq->nr_running != 1)
+		return 0;
+
+	if (!task_running_on_cpu(cpu_of(rq), p))
+		return 0;
+
+	return idle_rq_without(rq, p);
+}
+
 static int choose_idle_cpu(int cpu, struct task_struct *p)
 {
+	struct rq *rq = cpu_rq(cpu);
+
 	return available_idle_cpu(cpu) ||
-	       choose_sched_idle_rq(cpu_rq(cpu), p);
+	       choose_sched_idle_rq(rq, p) ||
+	       choose_idle_rq_without(rq, p);
 }
 
 static void
@@ -12968,23 +12985,21 @@ static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
 }
 
 /**
- * idle_cpu_without - would a given CPU be idle without p ?
+ * idle_rq_without - would a given CPU be idle without p ?
  * @cpu: the processor on which idleness is tested.
  * @p: task which should be ignored.
  *
  * Return: 1 if the CPU would be idle. 0 otherwise.
  */
-static int idle_cpu_without(int cpu, struct task_struct *p)
+static int idle_rq_without(struct rq *rq, struct task_struct *p)
 {
-	struct rq *rq = cpu_rq(cpu);
-
 	if (rq->curr != rq->idle && rq->curr != p)
 		return 0;
 
 	/*
 	 * rq->nr_running can't be used but an updated version without the
 	 * impact of p on cpu must be used instead. The updated nr_running
-	 * be computed and tested before calling idle_cpu_without().
+	 * be computed and tested before calling idle_rq_without().
 	 */
 
 	if (rq->ttwu_pending)
@@ -13027,9 +13042,9 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		sgs->sum_nr_running += nr_running;
 
 		/*
-		 * No need to call idle_cpu_without() if nr_running is not 0
+		 * No need to call idle_rq_without() if nr_running is not 0
 		 */
-		if (!nr_running && idle_cpu_without(i, p))
+		if (!nr_running && idle_rq_without(rq, p))
 			sgs->idle_cpus++;
 
 		/* Check if task fits in the CPU */
-- 
2.53.0

