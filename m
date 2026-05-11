Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F074D90D3;
	Mon, 11 May 2026 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535663; cv=none; b=WRnE517vmAV8jTkjx0L33kqca9/ytnx8pDzIM9dMxvEHPpYFR6tNKgXHAZ7Yh8qf2j+UEdNTDeuNOaZfPN6UbgKJNRH9tY457fpTVnMPdTv4z/v3rBVDnobe9NZwoCGE4SaUAZsOrva/HhXlzhM7ziXEwSpDxLjQHdoOBuH6y0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535663; c=relaxed/simple;
	bh=lk8h+Lc59lClblU+lZ49jR/w9InzBCf7BCBdtUTA0tU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=GsoPOp8khL/nOiUUc7qQNx3S5JgR1yoJ8qSfLTcIQeezJEGFGlr7G8+2dyanO+kTUa8/IQU0TiLb9WzYa9VC/wXk/FLzUoB8uTd9MIcHp0KMdzv7hBGnBI9RQSSBDsvwuYneLg9RcNv3y19QZx1NBRpBhFPi4npK6OoqfDWtcXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm9+AmFi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm9+AmFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CDBC2BCF5;
	Mon, 11 May 2026 21:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778535663;
	bh=lk8h+Lc59lClblU+lZ49jR/w9InzBCf7BCBdtUTA0tU=;
	h=Date:From:To:Cc:Subject:From;
	b=nm9+AmFiIyCO/iK31Hfd14Rv6+vO9jTRG0GepmCmi9Tu64FNxtdFSX5cj5filVxhJ
	 IeJZolcFt7kFkvoYdL/6QSGUuIoM/LPbgh1trxNJUeVB5FI6A1bDNFGI+KRJs8JXmQ
	 GVm/QwdQXpOTPfnB0z0iMaxo3a1ToXulfFUd/MS7LKIPshm/P4TC7w/33OazvBRvkf
	 er0RuUZ3Jev/aQEgipUSYvSuf/FmBC0HRuyhWXtmAeo2Aayxf1E7zzrf7VJOEE6/2q
	 XXz9JLnZ4Jg4XfHwUCaxNpbD1WqL78Q+pSVmgAXi8jmKZNVg0BlzmP5oJ2DL/yQJq9
	 A1b+hiK3kOtMg==
Date: Mon, 11 May 2026 11:41:02 -1000
Message-ID: <0d690b2a5b4497032ad19f61e4574566@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.2] sched_ext: Mark !CONFIG_EXT_SUB_SCHED
 dummy stubs static inline
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Mark !CONFIG_EXT_SUB_SCHED dummy stubs static inline to avoid
-Wunused-function in configs without callers. No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          |   20 ++++++++++----------
 kernel/sched/ext_internal.h |    2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -323,9 +323,9 @@ static void scx_set_task_sched(struct ta
 	rcu_assign_pointer(p->scx.sched, sch);
 }
 #else	/* CONFIG_EXT_SUB_SCHED */
-static struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
-static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
-static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch) {}
+static inline struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
+static inline struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
+static inline void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch) {}
 #endif	/* CONFIG_EXT_SUB_SCHED */

 /**
@@ -4649,9 +4649,9 @@ static void scx_cgroup_unlock(void)
 #endif
 }
 #else	/* CONFIG_EXT_GROUP_SCHED || CONFIG_EXT_SUB_SCHED */
-static struct cgroup *root_cgroup(void) { return NULL; }
-static void scx_cgroup_lock(void) {}
-static void scx_cgroup_unlock(void) {}
+static inline struct cgroup *root_cgroup(void) { return NULL; }
+static inline void scx_cgroup_lock(void) {}
+static inline void scx_cgroup_unlock(void) {}
 #endif	/* CONFIG_EXT_GROUP_SCHED || CONFIG_EXT_SUB_SCHED */

 #ifdef CONFIG_EXT_SUB_SCHED
@@ -4670,8 +4670,8 @@ static void set_cgroup_sched(struct cgro
 		rcu_assign_pointer(pos->scx_sched, sch);
 }
 #else	/* CONFIG_EXT_SUB_SCHED */
-static struct cgroup *sch_cgroup(struct scx_sched *sch) { return NULL; }
-static void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch) {}
+static inline struct cgroup *sch_cgroup(struct scx_sched *sch) { return NULL; }
+static inline void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch) {}
 #endif	/* CONFIG_EXT_SUB_SCHED */

 /*
@@ -6039,8 +6039,8 @@ static void scx_sub_disable(struct scx_s
 	kobject_del(&sch->kobj);
 }
 #else	/* CONFIG_EXT_SUB_SCHED */
-static void drain_descendants(struct scx_sched *sch) { }
-static void scx_sub_disable(struct scx_sched *sch) { }
+static inline void drain_descendants(struct scx_sched *sch) { }
+static inline void scx_sub_disable(struct scx_sched *sch) { }
 #endif	/* CONFIG_EXT_SUB_SCHED */

 static void scx_root_disable(struct scx_sched *sch)
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1601,7 +1601,7 @@ static inline bool scx_task_on_sched(str
 	return true;
 }

-static struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
+static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
 {
 	return rcu_dereference_all(scx_root);
 }
