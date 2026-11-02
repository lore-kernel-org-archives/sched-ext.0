Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606581;
	b=cPWvsp/hL+4RwwbkU5AR9wZKet0lOeyi5Ro+Hfe6U8nFI7O2x/GxCIqqUiR4834lapD8
	 w6/IGMOf1vFHm01KRTVIljyBX/WkiLaVen9Sjx39hyml/eB3MA0wyJl3TEW0qz+QAgzCY
	 2cgPRd6ZSs50BzThlfXZlTtF6hOIas3KfLLFnuIOn6HAlfkP6V4EoKinZl+raSxabKGpW
	 1s++rnigxZ9i5AcRBNzScAsmLHr1d3esZwKhgvmxm6z6RIfF63vZGFhRh6bRmExVZ0H5s
	 qQHefY7DMmJs0NOMV5U90KS6DJEf86AZ0NxPGZSBqSvdPRE1byjRLjASlw8NCYFJdXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606581;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kjzDJVbslYRFHwLeU4s4Hav9LIqixJ+vRMkjEDgPtR0=;
	b=n7dKCfN+jSaOaiTLsRVQd0y48eWlxs5R5EZF1T3tMbKxAsTc7+XH27UHwAFjmVTYMAig
	 OqCUSQ11UPd8wGviL3GcKPzbR9UPs0pZ3snyWfUgrh9PbvFAcPBySEygSElKuQ5drk9DR
	 Jq2kI16bSMoAiZD05Z35W+kZ5IhsV8kI8ipGhzc5La37kWan8xaqqn/Y8/NcD9fVZL14K
	 7afUN9dx7fBoViPpuDIsv3tiLETxPDoMNihofIKIVxBcHWRseER+CDZ+Snu2gHqJy9NMY
	 /+qgAvF72u7oePHbwbdikZreaq28iOe+VtNxyXaeOME7s7+nPEG7NTwC62fbUoQW3Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2wJZkgT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57F606A324;
	Mon,  2 Nov 2026 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2wJZkgT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8AB1F000C1;
	Mon,  2 Nov 2026 08:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793606581;
	bh=kjzDJVbslYRFHwLeU4s4Hav9LIqixJ+vRMkjEDgPtR0=;
	h=From:To:Cc:Subject:Date;
	b=M2wJZkgTJ4G/ouEIdczHzOudGHN9lFoA3o+KEwwxJRKvjbu6oEdAKBfDHnxpOm5U1
	 ars0Ogk0ADzNfFAZE4jwzkpI/Elo3Qwls1yg2UGqiy8i/enGDLPZyC0RzuWr4Ozo1t
	 xIp5mVw80M7q/KorAD3bazUn51YsThsSQ+blJPXGGmuK789vM/hoWPnQ4eEMi+mNFX
	 ebtUnJW+GYJ9b2UXPO2VMXqVdOzqJF1lUf3Hog4VcbLSNRW7g6l50F2YMAjRBaF0qm
	 wPRugrA7Sq+P0LurjCWeh4U132vn88jc9BKgZqgGCZcH9EPD/dClEY98f+emjhi8eS
	 GJQ3Uj+UZ/faQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.5] sched_ext: Say "hosting" instead of "running" in scx_exec_sched() comments
Date: Sun,  1 Nov 2026 22:02:59 -1000
Message-ID: <20261102080259.1509843-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
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

scx_exec_sched()'s comments call the nearest non-bypassing ancestor the
sched running a bypassing sched's tasks. ops.sub_cid_sched_updated() uses
"the sched running on a cid" for the sched owning the task running there.
Call the ancestor the host, as the bypass dispatch code already does.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/internal.h | 10 +++++-----
 kernel/sched/ext/sub.c      |  2 +-
 kernel/sched/ext/sub.h      |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 80c746054ce7..c20326d6eed8 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2756,14 +2756,14 @@ static inline struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL;
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
 /**
- * scx_exec_sched - Find the sched running @sch's tasks on @cpu
+ * scx_exec_sched - Find the sched hosting @sch's tasks on @cpu
  * @sch: sched owning the tasks
  * @cpu: cpu of interest
  *
- * A bypassing sched's tasks are run by its nearest ancestor that isn't
- * bypassing. Return @sch if it isn't bypassing on @cpu, otherwise that
- * ancestor, or the root if every ancestor is bypassing. Hold @cpu's rq lock for
- * a stable answer.
+ * A bypassing sched's tasks are hosted on the bypass DSQs of its nearest
+ * ancestor that isn't bypassing. Return @sch if it isn't bypassing on @cpu,
+ * otherwise that ancestor, or the root if every ancestor is bypassing. Hold
+ * @cpu's rq lock for a stable answer.
  */
 static inline struct scx_sched *scx_exec_sched(struct scx_sched *sch, s32 cpu)
 {
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 8962498e937c..9732809c09f8 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -950,7 +950,7 @@ bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p)
 	if (is_migration_disabled(p) || p == scx_rescuee(rq))
 		return false;
 
-	/* check caps against the sched running a bypassed task */
+	/* check caps against the sched hosting a bypassed task */
 	missing = scx_missing_caps(scx_exec_sched(scx_task_sched(p), cpu), cpu,
 				   scx_caps_for_task(p));
 	if (likely(!missing))
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index eb1dba6d51e2..41099218e38d 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -238,7 +238,7 @@ static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p
 	if (unlikely(is_migration_disabled(p)))
 		return true;
 
-	/* check caps against the sched running a bypassed task */
+	/* check caps against the sched hosting a bypassed task */
 	return likely(!scx_missing_caps(scx_exec_sched(scx_task_sched(p), cpu), cpu,
 					SCX_CAP_BASE));
 }
-- 
2.56.0

