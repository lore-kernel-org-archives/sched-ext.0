Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B739150E
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 02:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776913120; cv=none; b=ZOUSOIX/EjMTkPb+RPMxYKXkh6YNifrV3jFPZu3ZEuSk8R0d5z0nwhTwvi1nHcBUdXsryQ39qRnKPCk1ZeYXtulV43dCy6uj2VD+DVDdjMcSPxM//8hrkuiAnbVdAg/v1yOt7QhiCskcxxKAUA6wKVwn9a9iFPyLcBQ2omBP9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776913120; c=relaxed/simple;
	bh=4vJ1vQBx5aZxCFhVEV9FaApDcxkF9GOzX3LYImBrYFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mizRsE4nfuvJQv3px+jyncP1uCNgXLEi3v3SRJ85ZW5Mn6pYw95HzR4hZt/p/wGJNjB3AO3ZF7RRlQ51REEERh3FWxrwlhJLTEoebXBCJdqe6x5Laij5H2gPROWGkyWH+EuW5Ss224/3O0buDp4SQsqsSnRv1BXAGV0HfyRilAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVw0v2kV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVw0v2kV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2adff872068so30323165ad.1
        for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776913117; x=1777517917; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OkkJORPduwPjHLezrsPZnPFlvN7Sd8ZaerZpPHaabyA=;
        b=bVw0v2kVVG/u0u8TinSifD+iD52zIN0tLVSgHN8BPegZpJAJyIumWebtAOeiSpKq+k
         LtgxoT2hoJvblkbtUJvmSo4CRR9eDOymKI26T+ha3cNT8MkP2nYNSpV+LvonM3subQhv
         Nb3b6aeMXda4dr8EWWNiQ5goyf+hN3krVY3JYRLGzZlPh+mwl60R07IH3MH8AdumagUm
         sk7HFclr9edb3AbAWoMjQ7PnlL26g3nqHhj8tF7OQp4OlKYSsZwgYklB/sw/qc/OqAe1
         nf5V1F0CCsFc7/bK3Ljjp0oumzohJK+A4b1qQlEp1p3t8ZZoyu0CwF5f/8Pgx3RKmWd0
         lBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776913117; x=1777517917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkkJORPduwPjHLezrsPZnPFlvN7Sd8ZaerZpPHaabyA=;
        b=L/rAqY76vlfzwFJ/qOcf88Z9bvz7VBNqBxU/tCFPDm89bG23UtXBtlh4xI/g/HB09C
         y2fLJtuwuO62/39Rns0pVAmP6LZ362lfOTGxZWfFBUMSpuDlBvidHV7DV/uI9zwZO3/o
         zdF67r6AisFC59d44+pSKtDPyyYFfcRxteWugSLSWpZBi+dFvq9MyOpNXr+Nwt37CAUU
         9zNH2cejpa6TJYfJ4+uSwLCWTeouPCE56CTJnWDJ+WkbEc4tPokV3ewI+nkEBgGolawh
         LXqHQ2xXa9HPLe1QqZs5xH+MHev+W82oGUvg6qp7Drk7CHBX2KxHELkA8Ovtu/6aIpHM
         7vjA==
X-Forwarded-Encrypted: i=1; AFNElJ8pvTDCxlysfyFS3ltRpL+PC3ODNM3rV25pMpAMEMcpTB4eCpCMEz5MQep+xUNmUylgnrpqCsLq9mw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyfexbBzTAdkU7et75yOR6rKJqtwxqAhcz5gxKJiDF82fq3M3SE
	8jO1Bu9sDoHF/5fEAR7Ka+Hol68e+nrAa4ubd9kGS4USoy57eBGd/YoP
X-Gm-Gg: AeBDietXPMmm1Dn24+tDlAMpmcc4Pl1sOPRKYt2Lx1/cSIp++iFGJGDXHIp/gyFwRqA
	R//65sr7oQ4vm24+BlcOK2L0dr3yQMTDWSjjjUkp2XqiUeQU2X4GD2pgEz+HHvkDAsroV9QuGZ4
	8NhA5XGixAM9QxZ0nM3nZ2SMF1VsILZFzsDzcbnANClgpUv30lp0z5TshDuebPvmdGuGhOXuUYF
	sxnV93E4hHuLoXxpu1ZDPvMsa4sJZHudAdiLaIvEiqRRcUx7pkFDldgoYnEqwgA3uIgmhXZoFmM
	+OzrtNiJN0NiOOyXM/jFz06jgFJX+IWAo/wBDAgSZbTB6IOQL52SgTmG20kFzfEN3FGACDtMhiZ
	N0qxoK8eaDM620ky7zRDhn5Zo+97hj3E6qjkSgnmcKtJTIm5GBIvfZAs6Qi0VtJOUhJiPvrBEII
	xjTFl8nYHKfNvfOEenALrJOjdbsD9A4iXeOVAiA0qJMt3ZTFeE9+VV3l2StIYtoyA46LsepgcPs
	ylWJT/YkHe1Pw==
X-Received: by 2002:a17:903:c11:b0:2b2:5857:6011 with SMTP id d9443c01a7336-2b5f9f8324dmr182709865ad.19.1776913117469;
        Wed, 22 Apr 2026 19:58:37 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79770587c1sm14153602a12.32.2026.04.22.19.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 19:58:37 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] sched_ext: Fix local_dsq_post_enq() to use task's scheduler in sub-sched
Date: Thu, 23 Apr 2026 10:58:32 +0800
Message-ID: <20260423025832.2654840-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

local_dsq_post_enq() calls call_task_dequeue() with scx_root instead of
the scheduler instance actually managing the task. When
CONFIG_EXT_SUB_SCHED is enabled, tasks may be managed by a sub-scheduler
whose ops.dequeue() callback differs from root's. Using scx_root causes
the wrong scheduler's ops.dequeue() to be consulted: sub-sched tasks
dispatched to a local DSQ via scx_bpf_dsq_move_to_local() will have
SCX_TASK_IN_CUSTODY cleared but the sub-scheduler's ops.dequeue() is
never invoked, violating the custody exit semantics.

Fix by adding a 'struct scx_sched *sch' parameter to local_dsq_post_enq()
and move_local_task_to_local_dsq(), and propagating the correct scheduler
from their callers dispatch_enqueue(), move_task_between_dsqs(), and
consume_dispatch_q().

This is consistent with dispatch_enqueue()'s non-local path which already
passes 'sch' directly to call_task_dequeue() for global/bypass DSQs.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9628c64e5592..6ab743777a54 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1467,13 +1467,13 @@ static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
 	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
 }
 
-static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p,
-			       u64 enq_flags)
+static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
+			       struct task_struct *p, u64 enq_flags)
 {
 	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
 	bool preempt = false;
 
-	call_task_dequeue(scx_root, rq, p, 0);
+	call_task_dequeue(sch, rq, p, 0);
 
 	/*
 	 * If @rq is in balance, the CPU is already vacant and looking for the
@@ -1606,7 +1606,7 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	 * concurrently in a non-atomic way.
 	 */
 	if (is_local) {
-		local_dsq_post_enq(dsq, p, enq_flags);
+		local_dsq_post_enq(sch, dsq, p, enq_flags);
 	} else {
 		/*
 		 * Task on global/bypass DSQ: leave custody, task on
@@ -2192,7 +2192,8 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 		schedule_reenq_local(rq, 0);
 }
 
-static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
+static void move_local_task_to_local_dsq(struct scx_sched *sch,
+					 struct task_struct *p, u64 enq_flags,
 					 struct scx_dispatch_q *src_dsq,
 					 struct rq *dst_rq)
 {
@@ -2212,7 +2213,7 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 	dsq_inc_nr(dst_dsq, p, enq_flags);
 	p->scx.dsq = dst_dsq;
 
-	local_dsq_post_enq(dst_dsq, p, enq_flags);
+	local_dsq_post_enq(sch, dst_dsq, p, enq_flags);
 }
 
 /**
@@ -2433,7 +2434,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		/* @p is going from a non-local DSQ to a local DSQ */
 		if (src_rq == dst_rq) {
 			task_unlink_from_dsq(p, src_dsq);
-			move_local_task_to_local_dsq(p, enq_flags,
+			move_local_task_to_local_dsq(sch, p, enq_flags,
 						     src_dsq, dst_rq);
 			raw_spin_unlock(&src_dsq->lock);
 		} else {
@@ -2486,7 +2487,7 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 
 		if (rq == task_rq) {
 			task_unlink_from_dsq(p, dsq);
-			move_local_task_to_local_dsq(p, enq_flags, dsq, rq);
+			move_local_task_to_local_dsq(sch, p, enq_flags, dsq, rq);
 			raw_spin_unlock(&dsq->lock);
 			return true;
 		}
-- 
2.43.0

