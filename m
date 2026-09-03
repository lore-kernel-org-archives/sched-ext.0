Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90031351C04
	for <sched-ext@lists.linux.dev>; Thu,  3 Sep 2026 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407888; cv=none; b=OQpvxhTPwuO6HEFnhxLn3pYQ6Z+daYrTh6UPLI6b3Z/NjkU+zMYp92PARwMVnBLmZxLwHlH67wtlc8l8lAep04/QeHrsdnzvyDjVg22PCxOiI7BIABjQUngXNHCWz7/YGezp4611z3Uu9vWekGqD/of4y9JaY4dWgOSALPM+1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407888; c=relaxed/simple;
	bh=CXlpF52qtVFzAMuM4dYkQpB+SckVdivvQaN7BnrTPG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqIh0Esg461PRpAa/hhMIe+DrQm4FIePMqT8QOq8GPTJ1f44SaoZ6l/y9zT/5PoTc2G06RcaLiLq7c65eIIgIpz1vcKOymfsxxL1dFkoEa6gHJw9/2xPJ+wjLyXYyAMC8OZYda8aLCWXXiMKa7OKaKpoQZK177+ETV3fdrQiifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a8fdb6c6a74b11f19a56ed5b684f684d-20260903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:dc4f8f8e-66d5-42d7-889a-9c2ea0254c99,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:015b5d99587a44c40abb399a106145f7,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50,EDM:5,IP:
	nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a8fdb6c6a74b11f19a56ed5b684f684d-20260903
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1298296529; Thu, 03 Sep 2026 11:58:02 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	liwanwu@kylinos.cn
Subject: [PATCH 2/2] sched_ext: Protect the idle-search scratch nodemask with irqsave
Date: Thu,  3 Sep 2026 11:57:54 +0800
Message-Id: <20260903035754.722451-1-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903032953.659847-1-liwanwu@kylinos.cn>
References: <20260903032953.659847-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pick_idle_cpu_from_online_nodes() uses the per-CPU per_cpu_unvisited
nodemask as scratch while walking the online nodes, protected only by
preempt_disable(). preempt_disable() does not mask IRQs and the idle
kfuncs are callable from IRQ-enabled contexts, so a nested invocation
on the same CPU can overwrite the mask with nodes_copy() while the
interrupted invocation is still iterating it, leading to a wrong node
traversal and a wrong idle CPU pick.

Switch to irqsave so a nested invocation can't run on the same CPU.
A stack-allocated nodemask would also close the race, but that would
enlarge the diff to fix a race that is already rare (per-node idle,
CONFIG_NUMA and a cross-node search all at once); irqsave is the
minimal fix for the context that actually triggers it. The NMI case is
deliberately not addressed: there is no legitimate reason to
call pick_idle from NMI and doing so poses no crash risk, so such a
caller is on its own.

Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/d84b31727f04e1ed0d40042ba1c09e61@kernel.org
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---
 kernel/sched/ext/idle.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index d2973fb3af6d..93e2e0b2d1f8 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -153,7 +153,18 @@ static s32 pick_idle_cpu_from_online_nodes(const struct cpumask *cpus_allowed, i
 	nodemask_t *unvisited;
 	s32 cpu = -EBUSY;
 
-	preempt_disable();
+	/*
+	 * @per_cpu_unvisited is per-CPU scratch and the idle kfuncs can be
+	 * called from IRQ-enabled contexts, so mask IRQs to keep a nested
+	 * invocation from clobbering the mask an outer invocation is still
+	 * iterating.
+	 *
+	 * NMI nesting is not handled: there is no legitimate reason to call
+	 * pick_idle from NMI and doing so poses no crash risk, so such a
+	 * caller is on its own.
+	 */
+	guard(irqsave)();
+
 	unvisited = this_cpu_ptr(&per_cpu_unvisited);
 
 	/*
@@ -183,7 +194,6 @@ static s32 pick_idle_cpu_from_online_nodes(const struct cpumask *cpus_allowed, i
 		if (cpu >= 0)
 			break;
 	}
-	preempt_enable();
 
 	return cpu;
 }
-- 
2.25.1
