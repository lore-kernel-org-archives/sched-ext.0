Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978403;
	b=j/5Z7T102vhJWpGKkRi4+I2ZnVOqSWvJqyMspHTxM0HnDnr03yJl9vAhnH+FkR9chrDg
	 bCwbaXHRuwtHkbL91P3ie9YMD5Cgk9b4MbCDsT6mEh+76GswbBuzFlOUgubW64Q3ZHwWj
	 ymElX4wuzrCHAqPTXUyMSL4GFbg+qnSPmWXASLq+go71unInwHSLVWi2m9/DEvn8JjLlm
	 GfpTPX3TM1s6tV4lF3z5HpsnomiUCBrLos13UhGMaBBH5uvyfTCvG0ZEJRSmQwgcl3dYn
	 TiGKl7QMFv5bg0MifMyVSwY0cmEo7VEbMVlUin3HIaEA2xDTMnWjRTYkfgEf6wsD5mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bNvYaN9+IditNDhq23YRJI+wa1XYmfweeiUK+nE25zk=;
	b=mz2N6teU9paTF2GNQjpHM04auuXma+h7UwV/uqOBIuKghitSBA/oiVStKcIvNdmf5n0a
	 lCC/DU7YJ87rpj8cB706/k/pNHvKuM5BtCq8avefxYNF5UldNQi5om1gVm5aCwy5RlKcg
	 cezN8p9++kU1cMnAoPiv3kXdf9ms3Q26z9fSYf7Bc5GWWqjJhpsOdZZmoh83ddoKnhWmM
	 GX/KRoYmUAJaEOQpDylJV/Jm9jM+Nx36wvE6GObmlGHgSRFMyJdBFodTx1b9U20ciCH9W
	 E7GTvyNsZKOBiO8FRIDhA6LHlNtiBJkrqbcopXkqCb3bVcEBFNCggzX/iq3Ox7aZFRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FylCWXde;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D8606D801
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 369D8606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FylCWXde
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so7807175e9.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978401; x=1794583201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNvYaN9+IditNDhq23YRJI+wa1XYmfweeiUK+nE25zk=;
        b=FylCWXdezYDxB6U4w6iYLh7RDYgzCiJCd1JaueZirsOfupYq0Q8BEOsANhZuAo7RD8
         htFy8E0JuaWlFuRjV2Q/z4wzHT6g4xrib2Z9aqPHCaIRWfu1Xisgz7YZxeSd0RPuwR2D
         FhM8ogOTxoL4hTLjFkxoCqyPYQxyLaHhvgM2WwnAaWcTJ/qLfDMlcgIDNYseBMJcksca
         muuH29MH1CwKSXyh49rkzNyIwz90qJFGtwCNBbNUYB450QyjfaA+bjIGov0GV9Q25/9t
         cYDqVdgjeSjWgiNdS5OGg0ySTduYGotxxNYevsgZIW1PD0h6nDAp/InxBQRZu4tms4iH
         0k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978401; x=1794583201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNvYaN9+IditNDhq23YRJI+wa1XYmfweeiUK+nE25zk=;
        b=GDwc3LpVVnFQk20Ozhd5MlYCow7b9ajFtFmzGJwY2JlJ01gan4i6iEOn4GiPcDuywi
         XvXQVY7PrUIUGxVjrtWepJQ++yVcwWb63mc81OIIocnacDmMgOpQRmU0AyMtlQxxZBGp
         ZxA7GscXAu6+1cBxKkawOn3RlVJ55Lgpt1Z8ydQyrxsCsEDYF4jIBNT8znfZyJpy+Ir1
         A1my9Kz29BD2KiTEROInEHB15Z/wm5NHCE00VGLTgFiEZccGGzfyWcBh4Mq4tRayOyjA
         /O2WESqcZf56PkXkSNVJqfm/agRmyN5ACpOnwS5hGuq5qrVVCLiSlI47JkSmofAluMIz
         8xDg==
X-Forwarded-Encrypted: i=1; AL+hErG8yQClQl8TYNU5eUaEXv6blbJwl0WjiRHf4LbNdFFYDeClEjH6s6WWLCC/yeWCjmVa6kaqZz56uhc=@lists.linux.dev
X-Gm-Message-State: APuU4Z/LN7SLSP1bOqXCThuXyPyjoIYvHCM+pZvXbRxRNR1k06pC3rfJ
	kJ1Y+zMv+h8RjjRAqFD5hj9XDMYkxaxzLjQe/fJzGDzhPEyIky+QB7cXmpNHCSvh8T8=
X-Gm-Gg: AYBFou3P8OHjxK+8C/ouowDyDghsjMvlxZmrrrYKPeMkVugPWMTBl4XJQpPkH9vwRWy
	zzOpRmptvVc1RfXlTJcRz1zkQO+l0QLiUGcWC+jYx9wvnwleKmooe13tgYpZ36KrBwLyREmXNV8
	Z72MWVv2kVG0VfbFMPyEWR1C+gHIWk3JrH6OmHWzKvgH+37zYYUZIhdFW/LWxb0snQ0tkH7K8c5
	RUoAVtpZ/iGCXLxyyJwYxOnQaUkRsa4Q7iBSJt94eaCqKBnvh/HQyfRTcuvTscSWttjFnfQicWH
	0RRXnf27DtsUoZh0DRJsRyM37KQPBcgyN+rS88Xn6ZeFB2He2B397M2E9/OL/wXznJDe7zPwx5D
	AUq003DdBlAGTLmpLO4uJmI8EmtCugAE2NT1Xahdx8IsgjotcfiE2SuSAQJ208PwDQ0pR6LkBXe
	iAUnXmh/yh45E2l51RJKwm05euFH9MG8+hQ13ubYQEu8UG1AdzAgBIs2Kp48aSZ3ITCnM1piqGP
	ixfkRJqhWD95ntebBWH+LfKOmGjyEACTf7Du/HTr7grzS+avTvipRKrRji79CSG+GF8TXKjXGq1
	zJnbPUN2V57ybXjkKjA2NHDYszcPvdlQyUNPjJX8n66aWNY=
X-Received: by 2002:a05:6000:2203:b0:48e:2a6c:153b with SMTP id ffacd0b85a97d-493cb334277mr304843f8f.35.1793978401501;
        Fri, 06 Nov 2026 07:20:01 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:00 -0800 (PST)
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
Subject: [PATCH 07/20 v3] sched/fair: Prepare select_task_rq_fair() to be called for new cases
Date: Fri,  6 Nov 2026 16:19:34 +0100
Message-ID: <20261106151947.3991524-8-vincent.guittot@linaro.org>
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

Update select_task_rq_fair() to be called outside of the 3 current cases:
- wake up
- exec
- fork

We wants to select a rq in some new cases like pushing a runnable task on a
better CPU than the local one. In such case, it's not a wakeup , nor an
exec nor a fork. We ensure to not distrub these cases but still go through
EAS and fast-path.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 75 +++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 039dce244aaa..8f99c8bf1a80 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6170,6 +6170,18 @@ static void sync_entity_load_avg(struct sched_entity *se)
 	__update_load_avg_blocked_se(last_update_time, se);
 }
 
+/*
+ * Synchronize task load avg of dequeued entity without locking
+ * the previous rq.
+ */
+static void sync_task_load_avg(struct task_struct *p)
+{
+	if (task_on_rq_queued(p))
+		return;
+
+	sync_entity_load_avg(&p->se);
+}
+
 /*
  * Task first catches up with cfs_rq, and then subtract
  * itself from the cfs_rq (task must be off the queue now).
@@ -8802,7 +8814,7 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
 	 * prev_cpu's last_update_time.
 	 */
 	if (!(sd_flag & SD_BALANCE_FORK))
-		sync_entity_load_avg(&p->se);
+		sync_task_load_avg(p);
 
 	while (sd) {
 		struct sched_group *group;
@@ -9318,7 +9330,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * that the task fits with CPU's capacity.
 	 */
 	if (sched_asym_cpucap_active()) {
-		sync_entity_load_avg(&p->se);
+		sync_task_load_avg(p);
 		task_util = task_util_est(p);
 		util_min = uclamp_eff_value(p, UCLAMP_MIN);
 		util_max = uclamp_eff_value(p, UCLAMP_MAX);
@@ -9912,7 +9924,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	target = prev_cpu;
 
-	sync_entity_load_avg(&p->se);
+	sync_task_load_avg(p);
 	if (!task_util_est(p) && p_util_min == 0)
 		return target;
 
@@ -10060,46 +10072,55 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 }
 
 /*
- * select_task_rq_fair: Select target runqueue for the waking task in domains
- * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
- * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
+ * select_task_rq_fair: Select a target runqueue for the task.
+ * There are 2 ways to select the target runqueue:
+ * - The fast path which only looks for an idle CPU in the LLC or the smallest
+ *   asymmetric domain (i.e. the lowest domain with all compute capacities).
+ * - The slow path which looks for the idlest CPU in the highest domain with
+ *   the relevant SD flag set.
  *
- * Balances load by selecting the idlest CPU in the idlest group, or under
- * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
+ * In practice, WF_EXEC and WF_FORK uses the slow path whereas WF_TTWU and no
+ * flag (Push) uses the fast path.
  *
- * Returns the target CPU number.
  */
 static int
-select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
+select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
 {
-	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	int sync = (select_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	int want_sibling = !(select_flags & (WF_EXEC | WF_FORK));
+	int new_cpu, cpu = smp_processor_id();
 	struct sched_domain *tmp, *sd = NULL;
-	int cpu = smp_processor_id();
-	int new_cpu = prev_cpu;
-	int want_affine = 0;
 	/* SD_flags and WF_flags share the first nibble */
-	int sd_flag = wake_flags & 0xF;
+	int sd_flag = select_flags & 0xF;
+	int want_affine = 0;
 
 	/*
-	 * required for stable ->cpus_allowed
+	 * Required for stable ->cpus_allowed
 	 */
 	lockdep_assert_held(&p->pi_lock);
-	if (wake_flags & WF_TTWU) {
+
+	if (select_flags & WF_TTWU) {
 		record_wakee(p);
 
-		if ((wake_flags & WF_CURRENT_CPU) &&
+		if ((select_flags & WF_CURRENT_CPU) &&
 		    cpumask_test_cpu(cpu, p->cpus_ptr))
 			return cpu;
+	}
 
-		if (!is_rd_overutilized(this_rq()->rd)) {
-			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
-			if (new_cpu >= 0)
-				return new_cpu;
-			new_cpu = prev_cpu;
-		}
+	/*
+	 * We don't want EAS to be called for exec or fork but it should be
+	 * called for any other case such as wake up or push callback.
+	 */
+	if (!is_rd_overutilized(this_rq()->rd) && want_sibling) {
+		new_cpu = find_energy_efficient_cpu(p, prev_cpu);
+		if (new_cpu >= 0)
+			return new_cpu;
+	}
 
+	if (select_flags & WF_TTWU)
 		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
-	}
+
+	new_cpu = prev_cpu;
 
 	for_each_domain(cpu, tmp) {
 		/*
@@ -10133,8 +10154,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	}
 
 	/* Fast path */
-	if (wake_flags & WF_TTWU)
-		return select_idle_sibling(p, prev_cpu, new_cpu);
+	if (want_sibling)
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 	return new_cpu;
 }
-- 
2.53.0

