Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6936D50D;
	Tue, 21 Jul 2026 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784673082; cv=none; b=hGCo0LQz/0617kMzg5KZALVEu+GvikcpJEl/uF3gnoN7MXoiFDs4PnoXSl6OREbGw9O5Bye/EtkqWVQjTtukoOQg2/kmj/ItReNNdWBJaozq+qpZhVhs8aTzWPqfwOdHXyHLkEJngGAJNwB6DpfX8/qNyf3znddSw/Z44K6lFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784673082; c=relaxed/simple;
	bh=H0bGavKwtaoELhkAc4sIgBRIQYc4eBDvLsPAP7D1xGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiZMr2ibSr68yxZKIUGPqyUTRU8gVmi1uD4h0gk7E2rGDs/TFujl3makDlPNqKdk04xYLlHZYl1dNUrFPbEX41UG4buio2AXXRE5sb0jho8t0hTrJaRJcdMDkEAerESPN8pvDECQNmb0U8HxzCRIb+35R7azPmmQyIpkyLxnuUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFI28wSU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFI28wSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D441F000E9;
	Tue, 21 Jul 2026 22:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784673081;
	bh=mnWYRQeE4B16JBDsGl8ZDpJMBGLVC5PaN2xZcXsFnLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XFI28wSUid5gKLpjrX2oJsHvorJbMoOqB1PO5FEhGKqaByoamXJPfELC64PZxlWhV
	 ewxjW8gHQ2TwkwEWFJjcFfXhW+v0SVTse5epcIa6uqtw04+APt4SbSpWHKT3GSsVu2
	 2fOLUXmmVFAcv5qO+tWHLpflM/lTJ4cxPyvwkByRha7rDpBpVgzQe2PNWeVtCnjdwo
	 z9oNNXT6b21iUax8gHNPAyOLhO2djMX2e66ReFWKxpgsRdN1KNetWQu4dgasE2K59C
	 AchpMSOe1W1lQfiXxpa4Bwp9d5eF/Ugli4WKjRgTKCskhKrUaVtvBsYSkXNa/pLdp+
	 JXCiigET4PZPA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 2/4] sched_ext: Skip the default CPU selection while bypassing
Date: Tue, 21 Jul 2026 12:31:16 -1000
Message-ID: <20260721223118.2268529-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721223118.2268529-1-tj@kernel.org>
References: <20260721223118.2268529-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

select_task_rq_scx() falls into the default path when the scheduler has no
ops.select_cpu or is bypassing. There it calls scx_select_cpu_dfl() and
direct-dispatches to the picked CPU's local DSQ.

While bypassing, neither does anything: the enqueue path routes the task to
a bypass DSQ before consulting the direct-dispatch target, so the direct
dispatch never happens, and the CPU pick at most shifts which CPU's bypass
DSQ receives the task. Worse, when the scheduler does its own idle tracking,
the built-in idle cpumasks the pick consults are not even updated, so it
doesn't work anyway.

Return prev_cpu without the default selection while bypassing and let the
bypass enqueue place the task.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 96389ec31ab8..e6c4cbe1f182 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3277,6 +3277,19 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 	} else {
 		s32 cpu;
 
+		/*
+		 * While bypassing, the enqueue path routes @p to a bypass DSQ
+		 * without consulting the direct-dispatch target, making the
+		 * default selection pointless. It doesn't work anyway when the
+		 * scheduler does its own idle tracking and the built-in idle
+		 * cpumasks are not updated. Leave @p on @prev_cpu.
+		 */
+		if (bypassing) {
+			__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
+			p->scx.selected_cpu = prev_cpu;
+			return prev_cpu;
+		}
+
 		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, NULL, 0);
 		if (cpu >= 0) {
 			refill_task_slice_dfl(sch, p);
@@ -3286,8 +3299,6 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		}
 		p->scx.selected_cpu = cpu;
 
-		if (bypassing)
-			__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
 		return cpu;
 	}
 }
-- 
2.55.0

