Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9F3368B7
	for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773598231; cv=none; b=qj3v8Yf4dQ8VYLRAnmXy6wdEXNudZLHpblOOhH7umH4APfGco9Uo9iBld6bjaLep1IodmNeB6G6jCyigKM0AiNiZ7BZvCcON2cYIsOsLSfoICpEsdEnnM+9zM/xJYM2arPnR3N8JU7SkIFdZMMb43NATVf+2W9NYeRUCibJ4HWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773598231; c=relaxed/simple;
	bh=emomF28bC2HD9UZ1S5YEBJa3IpbhEs1g/EtIqKyAahU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8RhktmzxAuOI/mXEWrwyqutOqxSUEZHMZFpNS+n7MqO/8dinXq2Kn9XUFGhBriPl2OHI3mMmZ+ZfY7xsERqphCNAyQGNIeLSYAWwc03niSikLOYyqeZAqc6oGFMJMNSzczc1XZaXpmADmJFXgyKTY5GpCtGf9Yg4ilFxGFl+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXiB6aTp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXiB6aTp"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35b88a4f123so544809a91.1
        for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773598229; x=1774203029; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXmvjcx0XP78vVpm+BHrXpbru2P8EyHjwjUISmqRNjM=;
        b=aXiB6aTpOr3/4QGTWZdq+ATthn1u9RNQiyfmstpAeweZ5NRbuvCVX8ZqxtoFjKzYOB
         PD9BgIogfihV+711XEl1AMt5YKQSzRxUDKk/3IlNeMjpfWPHSCWgWDHWfCohJ4nVCEsR
         icDksZ5AKcb+iiTHexsIVHqDSz6ZeFYbv+maqMChK3Tb9M5I1WC0DAdiIrRUINih13ML
         Fhi+PrvSGfIk78fzWXbDKMWv1YIxDdhZVMw46wtj2lk5+iny6l8dRIPCR0FEwLUhoWP3
         rv7Y8WjqFblqqUQlF09e5DHiF8dg2WEEw7XRkeUPbSFXjny88hbBFWV8j7WFfsx1tw0E
         adig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773598229; x=1774203029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rXmvjcx0XP78vVpm+BHrXpbru2P8EyHjwjUISmqRNjM=;
        b=eTTLQMI/AcprLo/IZPMsEYYyv9WwpFqrgm1mqDSU2SKsecyUv/SITdT8WIVCeJXNM6
         HUXCbXhiwUOpH65v4WznB+8Wj0GSWxE+73KhEZpGM4bparBvgCLo17WdBX6JK6TeL22X
         83jmnx/JnrqdbVeBGNr5XUBrsYz2ZTE9AMpX5hZFYui87NTAtubPKT3XuuKZbJFRu/nt
         OrLGJ1gS1p+OlhRzKgZax+X3dkeimr6ghEOqMmJD+xEIAxmwS0BVxuML299MQ0+X/UA5
         qeJAFbLrk6OfDMrsH3k+ttgr2b9gxnIWJRZbVnM+d8PmFmehYB4+AvzoGf0DYNlUu5hW
         hosw==
X-Gm-Message-State: AOJu0Yz3chq9L3jUVKqDGHXG3pcfshuPKi6IwJ97Y0VblDFAMRQRXHR9
	UlHEvW8KdSKfW4jBE2r/qfs/GblJvxUoP2sx0DV+WGluOcz+El/S4mpwYSEFPj5o
X-Gm-Gg: ATEYQzz4HQmRvXiuBz6LwS2Xs2LvYvnB7a+nZlpOFG2b0I80bCFqCY+Fyi+6RBUnVqE
	NkJPA3wvDevkqU/lc57FZhQ2vbpBfGC/uuUgnqoQXejd2KXZEmHX7Fjo7F8aoImmVYtQpPK868P
	mTCw9FivzPCHfSEeIMR3LgwXgtysHF5syfXPVb4NeWf/+mfDMc5BJf7vmqhI2g80y76VIvt9fvN
	gAHMPdPMISwdjStfo9H34xII4YDwIpT6VzcVVfW52jYFHb0NR1VQNGFGmNhfcoXol/zJD25epCi
	xcS2xhK0dbrGQAz6hL1PRZXeFqK6Br4uATuh77XOn0zcMtLgLFQaNrPwZVme72804EmHmHU1vc7
	DjvazvL/IZEJOn9b6xqQ3N0n859qu3OwXZWX/7BfWDIAAoc5pzRl6cYyC61R21W42zBgqxPgJMC
	avORz9BNorHoJJOoUyfhUGmpN8rApjBKL/xURnqG4RnQi0oso5kjaf
X-Received: by 2002:a17:90b:1c11:b0:356:7025:56c7 with SMTP id 98e67ed59e1d1-35a21e9ef5amr8075389a91.5.1773598229036;
        Sun, 15 Mar 2026 11:10:29 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c21f:f7d6:f4bc:6198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9b797ab2sm1537624a91.7.2026.03.15.11.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 11:10:28 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 2/2] sched_ext: Use cached NUMA order in pick_idle_cpu_from_online_nodes()
Date: Mon, 16 Mar 2026 02:10:15 +0800
Message-ID: <20260315181017.1377138-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260315181017.1377138-1-yphbchou0911@gmail.com>
References: <20260315181017.1377138-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch pick_idle_cpu_from_online_nodes() from the O(N^2)
for_each_node_numadist() traversal to the pre-sorted
scx_numa_node_order[] arrays introduced in the previous patch.
The per-call cost drops from O(N^2) to O(N), where N is the number
of NUMA nodes.

Nodes that went offline after boot are skipped with a node_online()
check, so CPU hotplug remains correct without needing to rebuild
the arrays.

The per_cpu_unvisited nodemask, used only by the old implementation
to track visited nodes across loop iterations, is no longer needed
and is removed.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext_idle.c | 49 ++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 623a0356d6c3..90225bf3992c 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -138,12 +138,6 @@ static s32 pick_idle_cpu_in_node(const struct cpumask *cpus_allowed, int node, u
 }
 
 #ifdef CONFIG_NUMA
-/*
- * Tracks nodes that have not yet been visited when searching for an idle
- * CPU across all available nodes.
- */
-static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
-
 /*
  * Per-node sorted arrays of NUMA nodes in increasing distance order,
  * pre-computed at init time to avoid the O(N^2) traversal on each call
@@ -157,42 +151,27 @@ static int *scx_numa_node_order_cnt;
  */
 static s32 pick_idle_cpu_from_online_nodes(const struct cpumask *cpus_allowed, int node, u64 flags)
 {
-	nodemask_t *unvisited;
-	s32 cpu = -EBUSY;
-
-	preempt_disable();
-	unvisited = this_cpu_ptr(&per_cpu_unvisited);
+	int idx;
 
 	/*
-	 * Restrict the search to the online nodes (excluding the current
-	 * node that has been visited already).
+	 * The order is pre-computed at boot time in scx_numa_node_order[],
+	 * so each call is O(N) rather than O(N^2), where N is the number
+	 * of NUMA nodes.
 	 */
-	nodes_copy(*unvisited, node_states[N_ONLINE]);
-	node_clear(node, *unvisited);
+	for (idx = 0; idx < scx_numa_node_order_cnt[node]; idx++) {
+		int numa_node = scx_numa_node_order[node][idx];
+		s32 cpu;
 
-	/*
-	 * Traverse all nodes in order of increasing distance, starting
-	 * from @node.
-	 *
-	 * This loop is O(N^2), with N being the amount of NUMA nodes,
-	 * which might be quite expensive in large NUMA systems. However,
-	 * this complexity comes into play only when a scheduler enables
-	 * SCX_OPS_BUILTIN_IDLE_PER_NODE and it's requesting an idle CPU
-	 * without specifying a target NUMA node, so it shouldn't be a
-	 * bottleneck is most cases.
-	 *
-	 * As a future optimization we may want to cache the list of nodes
-	 * in a per-node array, instead of actually traversing them every
-	 * time.
-	 */
-	for_each_node_numadist(node, *unvisited) {
-		cpu = pick_idle_cpu_in_node(cpus_allowed, node, flags);
+		/* Nodes that went offline after boot are skipped. */
+		if (!node_online(numa_node))
+			continue;
+
+		cpu = pick_idle_cpu_in_node(cpus_allowed, numa_node, flags);
 		if (cpu >= 0)
-			break;
+			return cpu;
 	}
-	preempt_enable();
 
-	return cpu;
+	return -EBUSY;
 }
 #else
 static inline s32
-- 
2.48.1

