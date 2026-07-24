Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB20372056;
	Fri, 24 Jul 2026 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920617; cv=none; b=gXtj+n2IZvaGQzeGqBFeAbS8awQQoKXzgW/RbccJ41MWjWXQqJI+RJH4/V3FowixevH31ssGIqgactQ3fgqIdUsXvJRjfDqjvOpXIlKMz23q+DstfUnFq4uNSOBtcxg206LuU9HlXbOA5mrCssIcCI8WVZeq+YU9sjC9sgE0Y2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920617; c=relaxed/simple;
	bh=4OJdglxeMFMFhyMlEBS6SWDckYYt80WsKWZRWN6smVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrB3Hf6n/dxtYiwNyZDHUFCPNAYI9QMxXu7I4e7hC04SrkT9nsRnwiJurTAR0VJw2FUum2a+SjZO1u9TxUQUVMeUNKCNUZzkVfikjpriamIrcGLCcytyheP8Bmg/5T3RUpIlW0t+1/qxZf5j00HLtWeYwYGBDZfiGlyuy0IC3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNBYGl95; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNBYGl95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC231F000E9;
	Fri, 24 Jul 2026 19:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784920614;
	bh=6qeurfsUzj3xkyaUaOCSI0sTEi+XPfVRaXP02g9gMV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNBYGl95iMRbEsKHip1ffHMCauWI1de4EmON9w2HKrvBatWXULKrf+AVxoIDYjSKk
	 znj3HaXihIvydWFtU3cV2k9ncQOuSuAV12DLog4zIxaTbB4PeJ0VPSvDVayLYw0eli
	 /Dykzp/EafShA9dypVY2jbjUk7ZOcW0kMwv/uUoUth5PikLmP1y631EtJDLAq5n30o
	 4fm3KfhBK1fymfmv5Yz/WMqzbpBNwgbXR+HId/BXvQ5PCub5p1JpGcZ2Tj6udo4mwN
	 Mi7bU4R+a5P3PAJqca5u+eAzWOMWt0LiFVjJ52dYUbT2m9OnvJX85xWOjVdYgN8nRf
	 7ShjTGRwJIcIA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] sched_ext: Gate local DSQ reenq on baseline cid access
Date: Fri, 24 Jul 2026 09:16:48 -1000
Message-ID: <20260724191651.1040227-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724191651.1040227-1-tj@kernel.org>
References: <20260724191651.1040227-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_reenq() with an SCX_DSQ_LOCAL_ON target schedules deferred reenq
work on the cid's cpu, raising an IPI when the target rq isn't the locked
one. Nothing checks caps along the way, so a sub-sched holding no cap at all
on a cid can force its cpu to take IPIs and rq lock cycles at will. The
analogous scx_bpf_kick_cid() path gates delivery on SCX_CAP_BASE in
kick_one_cpu() to prevent exactly this.

Apply the same rule at the reenq scheduling point: if the calling sched
lacks SCX_CAP_BASE on the target cid, drop the reenq and count it in the new
SCX_EV_SUB_REENQ_DENIED event. The check is lockless, which is fine: a reenq
slipping through right after a revoke is harmless, and a wrong denial can't
happen - if the caller has seen its ownership of the cpu, the check sees it
too.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 12 ++++++++++++
 kernel/sched/ext/internal.h |  9 ++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 81c2d8eeae41..fd88b4d4f12a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1071,6 +1071,18 @@ void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 	if (dsq->id == SCX_DSQ_LOCAL) {
 		rq = container_of(dsq, struct rq, scx.local_dsq);
 
+		/*
+		 * A sub-sched lacking baseline access on the target cid has no
+		 * business triggering IPIs. The lockless test is fine: slipping
+		 * through right after a revoke is harmless and a wrong denial
+		 * can't happen - if the caller has seen its ownership, so does
+		 * this test.
+		 */
+		if (unlikely(scx_missing_caps(sch, cpu_of(rq), SCX_CAP_BASE))) {
+			__scx_add_event(sch, SCX_EV_SUB_REENQ_DENIED, 1);
+			return;
+		}
+
 		struct scx_sched_pcpu *sch_pcpu = per_cpu_ptr(sch->pcpu, cpu_of(rq));
 		struct scx_deferred_reenq_local *drl = &sch_pcpu->deferred_reenq_local;
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index a9a853a71061..1bdf34f3fc3c 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1193,6 +1193,12 @@ struct scx_event_stats {
 	 * kick degrades to a plain reschedule.
 	 */
 	s64		SCX_EV_SUB_PREEMPT_DENIED;
+
+	/*
+	 * The number of times a local DSQ reenq was dropped because the
+	 * sub-sched lacked baseline access on the target cid.
+	 */
+	s64		SCX_EV_SUB_REENQ_DENIED;
 };
 
 #define SCX_EVENTS_LIST(SCX_EVENT)					\
@@ -1212,7 +1218,8 @@ struct scx_event_stats {
 	SCX_EVENT(SCX_EV_INSERT_NOT_OWNED);				\
 	SCX_EVENT(SCX_EV_SUB_BYPASS_DISPATCH);				\
 	SCX_EVENT(SCX_EV_SUB_FORCED_ADMIT);				\
-	SCX_EVENT(SCX_EV_SUB_PREEMPT_DENIED)
+	SCX_EVENT(SCX_EV_SUB_PREEMPT_DENIED);				\
+	SCX_EVENT(SCX_EV_SUB_REENQ_DENIED)
 
 struct scx_sched;
 
-- 
2.55.0

