Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1352D3A60;
	Thu,  4 Jun 2026 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538437; cv=none; b=JbI3kjcdWpf1w0pBu6AhicD3pZom2aEzKrL4Gy5DO21A5VW6LRpynndZ7fLfva/jL9N63iOYa/mif/nRWuPIyHLNaz08LQvCyaoBHtYJepOzvCcMaBvdSUlvOdOuHp3CNaME0TcXj4r3vsPOBge6abFsfm89rKySo2J9QPByKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538437; c=relaxed/simple;
	bh=lD4JantaEW6EUWsAdJMk2hJu7ps5jtEEcxIxkBsdZUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtWlvQInjpYsjzJGb5969NFFPPSs3tsyVDzlnQQgg+qH5F5oDqKX4KY2RqwOQaugdXJAwyus++YQQjeEQrNRig6FfDiRqIeo7kgpkoBbfWvK6J7Q5s6HapV+ZjAAND8WGMiUdY6SFKwktJVHT0BWvZIb90orqmtqAYBaFevO1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ30lVXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ30lVXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959751F00893;
	Thu,  4 Jun 2026 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538435;
	bh=1URql7AQOmIMT96IwwrJzeaD6aNUizQsL+qXvcLuAUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XJ30lVXj/zVcPV4ZRGkVIq4gJn9Y+fuWfBikJUnLaFVboDrsxk3M6zPcjkawi8vdR
	 Y4oVZApn7o/fXimSvX3/ClHyDe/4eVtzabMf+osx4rumJADtM5O+MUWUMXX5NbAW3T
	 /1SD6EpOI9jLRJSA70TDL4yHe3JJ7Old0XNMzA/78jRwN1WXjHy7F3zdNa6p9q44k5
	 o6xmBWy8u00Bmx4P2BmC4d9uNlgVqaC8/8XAT9cQn/zNClJrfgl/VZV/N+ugeysYPy
	 ukhiAGzrmv/UvduzbcwXVHMDfGoxZQPntTc9YPbd/qrH8cmj9CqmtGsvs1e3+tzMaE
	 vpFXb6MibDzwQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] tools/sched_ext: Order single-cid cmask helpers as (cid, mask)
Date: Wed,  3 Jun 2026 16:00:30 -1000
Message-ID: <20260604020032.3536466-3-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604020032.3536466-1-tj@kernel.org>
References: <20260604020032.3536466-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF arena single-cid cmask helpers take the cmask first and the cid
second. Reorder them to (cid, mask) to match the kernel-side helpers and
the test_bit(nr, addr), cpumask_test_cpu(cpu, mask) convention. Range and
iteration helpers keep (mask, start).

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/cid.bpf.h | 60 +++++++++++++--------------
 tools/sched_ext/scx_qmap.bpf.c        | 12 +++---
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
index 70f2a3829af4..9d89bb57e201 100644
--- a/tools/sched_ext/include/scx/cid.bpf.h
+++ b/tools/sched_ext/include/scx/cid.bpf.h
@@ -40,12 +40,12 @@
  */
 #define CMASK_NR_WORDS(nr_cids)		((u32)(((u64)(nr_cids) + 63) / 64 + 1))
 
-static __always_inline bool __cmask_contains(const struct scx_cmask __arena *m, u32 cid)
+static __always_inline bool __cmask_contains(u32 cid, const struct scx_cmask __arena *m)
 {
 	return cid >= m->base && cid < m->base + m->nr_cids;
 }
 
-static __always_inline u64 __arena *__cmask_word(const struct scx_cmask __arena *m, u32 cid)
+static __always_inline u64 __arena *__cmask_word(u32 cid, const struct scx_cmask __arena *m)
 {
 	return (u64 __arena *)&m->bits[cid / 64 - m->base / 64];
 }
@@ -122,11 +122,11 @@ static __always_inline void cmask_reframe(struct scx_cmask __arena *m, u32 base,
 	m->nr_cids = nr_cids;
 }
 
-static __always_inline bool cmask_test(const struct scx_cmask __arena *m, u32 cid)
+static __always_inline bool cmask_test(u32 cid, const struct scx_cmask __arena *m)
 {
-	if (!__cmask_contains(m, cid))
+	if (!__cmask_contains(cid, m))
 		return false;
-	return *__cmask_word(m, cid) & BIT_U64(cid & 63);
+	return *__cmask_word(cid, m) & BIT_U64(cid & 63);
 }
 
 /*
@@ -140,15 +140,15 @@ static __always_inline bool cmask_test(const struct scx_cmask __arena *m, u32 ci
  */
 #define CMASK_CAS_TRIES		(1U << 23)
 
-static __always_inline void cmask_set(struct scx_cmask __arena *m, u32 cid)
+static __always_inline void cmask_set(u32 cid, struct scx_cmask __arena *m)
 {
 	u64 __arena *w;
 	u64 bit, old, new;
 	u32 i;
 
-	if (!__cmask_contains(m, cid))
+	if (!__cmask_contains(cid, m))
 		return;
-	w = __cmask_word(m, cid);
+	w = __cmask_word(cid, m);
 	bit = BIT_U64(cid & 63);
 	bpf_for(i, 0, CMASK_CAS_TRIES) {
 		old = *w;
@@ -161,15 +161,15 @@ static __always_inline void cmask_set(struct scx_cmask __arena *m, u32 cid)
 	scx_bpf_error("cmask_set CAS exhausted at cid %u", cid);
 }
 
-static __always_inline void cmask_clear(struct scx_cmask __arena *m, u32 cid)
+static __always_inline void cmask_clear(u32 cid, struct scx_cmask __arena *m)
 {
 	u64 __arena *w;
 	u64 bit, old, new;
 	u32 i;
 
-	if (!__cmask_contains(m, cid))
+	if (!__cmask_contains(cid, m))
 		return;
-	w = __cmask_word(m, cid);
+	w = __cmask_word(cid, m);
 	bit = BIT_U64(cid & 63);
 	bpf_for(i, 0, CMASK_CAS_TRIES) {
 		old = *w;
@@ -182,15 +182,15 @@ static __always_inline void cmask_clear(struct scx_cmask __arena *m, u32 cid)
 	scx_bpf_error("cmask_clear CAS exhausted at cid %u", cid);
 }
 
-static __always_inline bool cmask_test_and_set(struct scx_cmask __arena *m, u32 cid)
+static __always_inline bool cmask_test_and_set(u32 cid, struct scx_cmask __arena *m)
 {
 	u64 __arena *w;
 	u64 bit, old, new;
 	u32 i;
 
-	if (!__cmask_contains(m, cid))
+	if (!__cmask_contains(cid, m))
 		return false;
-	w = __cmask_word(m, cid);
+	w = __cmask_word(cid, m);
 	bit = BIT_U64(cid & 63);
 	bpf_for(i, 0, CMASK_CAS_TRIES) {
 		old = *w;
@@ -204,15 +204,15 @@ static __always_inline bool cmask_test_and_set(struct scx_cmask __arena *m, u32
 	return false;
 }
 
-static __always_inline bool cmask_test_and_clear(struct scx_cmask __arena *m, u32 cid)
+static __always_inline bool cmask_test_and_clear(u32 cid, struct scx_cmask __arena *m)
 {
 	u64 __arena *w;
 	u64 bit, old, new;
 	u32 i;
 
-	if (!__cmask_contains(m, cid))
+	if (!__cmask_contains(cid, m))
 		return false;
-	w = __cmask_word(m, cid);
+	w = __cmask_word(cid, m);
 	bit = BIT_U64(cid & 63);
 	bpf_for(i, 0, CMASK_CAS_TRIES) {
 		old = *w;
@@ -226,43 +226,43 @@ static __always_inline bool cmask_test_and_clear(struct scx_cmask __arena *m, u3
 	return false;
 }
 
-static __always_inline void __cmask_set(struct scx_cmask __arena *m, u32 cid)
+static __always_inline void __cmask_set(u32 cid, struct scx_cmask __arena *m)
 {
-	if (!__cmask_contains(m, cid))
+	if (!__cmask_contains(cid, m))
 		return;
-	*__cmask_word(m, cid) |= BIT_U64(cid & 63);
+	*__cmask_word(cid, m) |= BIT_U64(cid & 63);
 }
 
-static __always_inline void __cmask_clear(struct scx_cmask __arena *m, u32 cid)
+static __always_inline void __cmask_clear(u32 cid, struct scx_cmask __arena *m)
 {
-	if (!__cmask_contains(m, cid))
+	if (!__cmask_contains(cid, m))
 		return;
-	*__cmask_word(m, cid) &= ~BIT_U64(cid & 63);
+	*__cmask_word(cid, m) &= ~BIT_U64(cid & 63);
 }
 
-static __always_inline bool __cmask_test_and_set(struct scx_cmask __arena *m, u32 cid)
+static __always_inline bool __cmask_test_and_set(u32 cid, struct scx_cmask __arena *m)
 {
 	u64 bit = BIT_U64(cid & 63);
 	u64 __arena *w;
 	u64 prev;
 
-	if (!__cmask_contains(m, cid))
+	if (!__cmask_contains(cid, m))
 		return false;
-	w = __cmask_word(m, cid);
+	w = __cmask_word(cid, m);
 	prev = *w & bit;
 	*w |= bit;
 	return prev;
 }
 
-static __always_inline bool __cmask_test_and_clear(struct scx_cmask __arena *m, u32 cid)
+static __always_inline bool __cmask_test_and_clear(u32 cid, struct scx_cmask __arena *m)
 {
 	u64 bit = BIT_U64(cid & 63);
 	u64 __arena *w;
 	u64 prev;
 
-	if (!__cmask_contains(m, cid))
+	if (!__cmask_contains(cid, m))
 		return false;
-	w = __cmask_word(m, cid);
+	w = __cmask_word(cid, m);
 	prev = *w & bit;
 	*w &= ~bit;
 	return prev;
@@ -671,7 +671,7 @@ static __always_inline void cmask_from_cpumask(struct scx_cmask __arena *m,
 			continue;
 		cid = scx_bpf_cpu_to_cid(cpu);
 		if (cid >= 0)
-			__cmask_set(m, cid);
+			__cmask_set(cid, m);
 	}
 }
 
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 8a2d6a8ebd8e..fd9a82a67627 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -214,7 +214,7 @@ static s32 pick_direct_dispatch_cid(struct task_struct *p, s32 prev_cid,
 	if (!always_enq_immed && p->nr_cpus_allowed == 1)
 		return prev_cid;
 
-	if (cmask_test_and_clear(qa_idle_cids, prev_cid))
+	if (cmask_test_and_clear(prev_cid, qa_idle_cids))
 		return prev_cid;
 
 	cid = prev_cid;
@@ -224,7 +224,7 @@ static s32 pick_direct_dispatch_cid(struct task_struct *p, s32 prev_cid,
 		barrier_var(cid);
 		if (cid >= nr_cids)
 			return -1;
-		if (cmask_test_and_clear(qa_idle_cids, cid))
+		if (cmask_test_and_clear(cid, qa_idle_cids))
 			return cid;
 	}
 	return -1;
@@ -534,7 +534,7 @@ static bool dispatch_highpri(bool from_timer)
 		if (!(taskc = lookup_task_ctx(p)))
 			return false;
 
-		if (cmask_test(&taskc->cpus_allowed, this_cid))
+		if (cmask_test(this_cid, &taskc->cpus_allowed))
 			cid = this_cid;
 		else
 			cid = cmask_next_set_wrap(&taskc->cpus_allowed,
@@ -656,7 +656,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct task_struct *prev)
 			 * document this class of issue -- other schedulers
 			 * seeing similar warnings can use this as a reference.
 			 */
-			if (!cmask_test(&taskc->cpus_allowed, cid))
+			if (!cmask_test(cid, &taskc->cpus_allowed))
 				scx_bpf_kick_cid(scx_bpf_task_cid(p), 0);
 
 			batch--;
@@ -913,9 +913,9 @@ void BPF_STRUCT_OPS(qmap_update_idle, s32 cid, bool idle)
 {
 	QMAP_TOUCH_ARENA();
 	if (idle)
-		cmask_set(qa_idle_cids, cid);
+		cmask_set(cid, qa_idle_cids);
 	else
-		cmask_clear(qa_idle_cids, cid);
+		cmask_clear(cid, qa_idle_cids);
 }
 
 void BPF_STRUCT_OPS(qmap_set_cmask, struct task_struct *p,
-- 
2.54.0

