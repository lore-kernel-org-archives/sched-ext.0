Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110131;
	b=1d9gMX52A1gCBpiR34NybGLrFZ8ALRTxupSuHIqcvubpGXGNIBIfItX5/KMikDLeFLlA
	 Do7mmSKy12wSD/0gwEp8XhoWXJnRRw9S4627OSJMSu3ynVlb//OqOAHvT73pToxwr3O2U
	 Hdsv0DmMprYT3bnICNEyRUP5mJ9Eux3MjWlNE1UchtEWUsSOfiUIOTNxQgzM2aW+GK2Fk
	 GYX+i/vmDvM/6dcN5X11aZpmVyx44GiPidKacmrmeXMnSfhLOGK/DrN9OygVyh0kQW3M0
	 Eem8xXUARLjKamXneA/WkL3xBcdQMjy+T96TYIivNffZHpkJVIQJNNHotdtyakdw9iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110131;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZpO7H9AU4vfyL8Hvvsk2x0lIjTRy2eJGqIesA8hsgPg=;
	b=hHE3kxk+LfxJfW60ESaUGe2vO/Hep4gmPZsgobol2ae9ksosnub82fdmNeutb9QEzd0H
	 u1k2biiCBPtlpur49jmFpr3SnmPfShjYouwVANBALJSa23zFCkjgoYhyrYSHSeq29aB3e
	 uZbcFaFFEJH07W+Bko4Vgiaws812VoymHs9mDE3KZiX3kq4GLh4u/ITwN7RYxxZldJ7Kj
	 Lr/if06M9PHYiPqWsBDTwzPjgMDq8p2zmYgsAftDtbKtfWr6LqrHuG/nyMkiaQb1obDpX
	 G456lCJz2scER9PjrGeMCaPJ2gSSyUjGUsFsUOIl7aihzIOjypTl4V5erRJJUAYDr/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFq7VLIG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332CC60A260B;
	Tue, 27 Oct 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFq7VLIG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB3D1F031E3;
	Tue, 27 Oct 2026 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110131;
	bh=ZpO7H9AU4vfyL8Hvvsk2x0lIjTRy2eJGqIesA8hsgPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jFq7VLIGqr/z4Rap91ja52FCKYrobSoFEs+IGeIOd6/fXzdg9+WVSU38TDbkFVjxx
	 /Nbg8DGXn/ft6e07UC7BVD3Wp9N72K+Fe7K8+xbnkidXPdYZxKnjXtKpkgA0jerEpc
	 SU8WyrzeIsBwaTAlcG3v8qv9C624kThb8E9rC7aA5ShAUJHqzbQUE7Tae7dyMSfmVG
	 MDnIrnLzSWFFNVqlJ4mdE2Vr62mhGO6PVynO2e2V9DS732N5NVBz8/n4Y89dr/82o0
	 dteamIPRvNX59Ldkpi6k22LAZkWYrIpv6nk4uonB0Ixqo5eOK0Z8S9dAyoG0UBeJy0
	 IR4+fcnvn2lMg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 20/18] sched_ext: Fix the rescue overload pick ejecting the wrong sub under bypass
Date: Tue, 27 Oct 2026 04:08:48 -1000
Message-ID: <20261027140848.2280121-2-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027001749.1821379-1-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
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

An earlier patch sends a bypassed task to rescue when its host lacks
SCX_CAP_BASE on the cpu. The task's rescue time is charged to its owner, the
bypassing sub, which is usually exiting. The overload pick skips exiting
subs and ejects an unrelated sub or nobody. The host runs the task and lacks
BASE, but carries none of the charge.

Charge the sched running the rescuee, the host while the owner bypasses.
SCX_EV_SUB_RESCUE already counts on that sched and the stall watchdog blames
it.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/sub.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index e0aed3ce9735..068ca57d1bb7 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -479,9 +479,13 @@ void scx_rescue_charge(struct rq *rq, s64 delta_exec)
 
 	rq->scx.rescue.budget -= delta_exec;
 
-	/* per-cpu usage average feeds the overload victim pick */
-	pcpu = per_cpu_ptr(scx_task_sched(rq->scx.rescue.curr)->pcpu,
-			   cpu_of(rq));
+	/*
+	 * The per-cpu usage average feeds the overload victim pick. Charge the
+	 * sched running the rescuee, which is the host while the rescuee's
+	 * owner is bypassing.
+	 */
+	pcpu = per_cpu_ptr(scx_exec_sched(scx_task_sched(rq->scx.rescue.curr),
+					  cpu_of(rq))->pcpu, cpu_of(rq));
 	pcpu->rescue_avg = scx_rescue_decay_avg(pcpu) + delta_exec;
 
 	if (!scx_rescue_slice_remaining(rq))
@@ -665,7 +669,8 @@ static bool scx_rescue_try_admit(struct rq *rq, struct task_struct *p)
  * If the oldest waiter on @rq's rescue DSQ has been queued for too long, rescue
  * demand on this cpu persistently exceeds the configured bandwidth. Eject the
  * sub with the highest recent rescue consumption instead of letting the
- * scheduler stall path blame the waiter's owner, who may just be crowded out.
+ * scheduler stall path blame the sched running the waiter, which may just be
+ * crowded out.
  */
 static void scx_rescue_check_overload(struct rq *rq)
 {
-- 
2.56.0

