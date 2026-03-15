Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40EC35A933
	for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773598228; cv=none; b=KRzQeyc8cWqHSZn6TRfA+VJs1fgvbfdxthl4UQeDopdJuYp8zhM1SDvEt7eEEbmwlyaajK7gu2uXHFkWgDd1VU76ZeiJ0fyZNVpJut9JZg2NuJipYRlWpTZBMxs5/euYpiULlecVseuS7eY9/nGZ7q38OJ43Wt9Mqwf9KEVrDAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773598228; c=relaxed/simple;
	bh=9+E8lSHW1nogNg2zTBvUQTIgxNWWo4UjlfVhBZqWIp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dudlV9wAo0lHe8jmp/qYaiufYYfkUng9tET17WbuFtQuiqtIqmskdKNIKqgniB9cfinxiKIsWvrmDcxAV3BcsXI2FAnNSduVaVSXV4RIH3h7JrbWVbUUbZWrsgvKAu1jIzChZAOLy0FniyfB380ipNsC/5RvvCwSYh+/LgzeXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/Tp0Xd+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/Tp0Xd+"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35691a231a7so2102704a91.3
        for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 11:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773598227; x=1774203027; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H12fPMCOAO/O39I7rbKCm2i4W4utibRo+hpS57Khl80=;
        b=V/Tp0Xd+rUtFE9g1iLYZ0xgnr/gFgH/YBTNpMC6uXHarT8W6ssio3FbQ/VtZEg/TjT
         uOIO6o3Tlvihqq5A+BY6+t1WA08y7hGLvsq/Ijg3Oq7tm/xDaBoPAQUoe5TLbXTdoX9r
         LUsZ4//L85TNkptHMDJrd2J94uBqdHjitxPsTHIUvNtfNtwokq9RZxJxLk4zeF8QW+yV
         S3YipzS9AvB1QZoJFwKBbjcHg/rxuzZz6ZXdae052mMwT03QtWD6HUzr4wehO7yZpOyQ
         V1mO2qud2ksBkRbSknw4gQhX4hxcde4fv4c20qlyp/kogvRmWo41ZkB9zNU7HIIspdzd
         B2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773598227; x=1774203027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H12fPMCOAO/O39I7rbKCm2i4W4utibRo+hpS57Khl80=;
        b=E12XT3BxGjj/ZbbJxigy5DLsjzFGpu8+XVvXN/cchxReILAe1Aj0JhMjDFJpKJpY0W
         vALZ0eJMn3IjEqS1dVGK5JNMZIIEdKdJ/CWHgLMO/uL67ilkRqSLREr29FFcAUFKiaQt
         9wRkqR3y2x8yu06dmrNkiwysz1pWRrXwLHIVIIdqCfuw7+mkVaAZx7QBA71w3hasjPjc
         xJWPotTOQZH29OMEmzg24mxfXDvRRzSpUm5IIyQj/AYt1yOkQyeys6vQcN+18cfpWD22
         tO6NhGikaEcskaQUBbYfOfYULa0eB9CMlhH2c1zDPzLT3rQHRNdGlRbCVC31GZRJ8IhB
         z2Kw==
X-Gm-Message-State: AOJu0YzvdDHy0dEUNod+89YuWNnTppbjuq/JBq1GAkzrR1KDXbwr2e9G
	ZxAeHXTQBqKACJcPjgTGKLZkaeCTNHImAdz73KJ82qlA8IUFXkRj0qK0Emd9x4tu
X-Gm-Gg: ATEYQzxYLtszBjyfo/GZtOAQdlTVuon5inB1DGXKZEGTpiPl5iwTj0G4uDfZSHFkUOp
	nYJl9EYJCrnjljBfJXFt5iRF1br8929TbCaPML1YLcZVZW2f6bVe0KWCUIqLIExJhZIdNxprlaI
	sCDmnZbF5DwpT6tSNMSrhbaNRs0pnYmDeR55Hr8nW4kQ1inr/TXSzgSOPe8WQd20PucufD5Lply
	xlPr8CkGd/p/DLfdHNdvq46STrEDeAMW/jLeTQO0GHQRrvVBtcXLwToyhSDPM7wf6vtZjzNjy4s
	+ttq7tWzoboDRszCygUWnpuwUr1iABhkDkQdrwbqFvzeOBGx1nns1tITUfHn/FvETpEtNxgWdlB
	NxUyC/Kym0KjV8FFTZlJw/KvAOIqJM3MGN4atJVFiZNuRZJOi99FRmxRwMXxFCk9HOQpDjqAiv2
	cFL52REDHFgh0PrhdzuOUmQi6MwyubfhahrL4oyB4THbOoJk4RvO8N
X-Received: by 2002:a17:90b:2e45:b0:341:134:a962 with SMTP id 98e67ed59e1d1-35a2206fb36mr8984179a91.28.1773598227008;
        Sun, 15 Mar 2026 11:10:27 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c21f:f7d6:f4bc:6198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9b797ab2sm1537624a91.7.2026.03.15.11.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 11:10:26 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 1/2] sched_ext: Cache per-node NUMA distance order in scx_idle_init_masks()
Date: Mon, 16 Mar 2026 02:10:14 +0800
Message-ID: <20260315181017.1377138-2-yphbchou0911@gmail.com>
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

Add scx_numa_node_order[] and scx_numa_node_order_cnt[], per-node
arrays that store NUMA nodes sorted by increasing distance from each
node. They are allocated and populated once during boot in
scx_idle_init_masks() using the existing for_each_node_numadist()
O(N^2) traversal, so the cost is paid only at init time.

pick_idle_cpu_from_online_nodes() will use these cached arrays to
reduce its per-call complexity from O(N^2) to O(N).

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext_idle.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 03be4d664267..623a0356d6c3 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -144,6 +144,14 @@ static s32 pick_idle_cpu_in_node(const struct cpumask *cpus_allowed, int node, u
  */
 static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
 
+/*
+ * Per-node sorted arrays of NUMA nodes in increasing distance order,
+ * pre-computed at init time to avoid the O(N^2) traversal on each call
+ * to pick_idle_cpu_from_online_nodes().
+ */
+static int **scx_numa_node_order;
+static int *scx_numa_node_order_cnt;
+
 /*
  * Search for an idle CPU across all nodes, excluding @node.
  */
@@ -685,6 +693,36 @@ void scx_idle_init_masks(void)
 		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_numa_idle_cpumask, i),
 					       GFP_KERNEL, cpu_to_node(i)));
 	}
+
+#ifdef CONFIG_NUMA
+	/*
+	 * Pre-compute per-node NUMA distance order so that
+	 * pick_idle_cpu_from_online_nodes() can iterate in O(N) instead of
+	 * the O(N^2) traversal required by for_each_node_numadist().
+	 */
+	scx_numa_node_order = kcalloc(nr_node_ids, sizeof(*scx_numa_node_order), GFP_KERNEL);
+	BUG_ON(!scx_numa_node_order);
+	scx_numa_node_order_cnt = kcalloc(nr_node_ids, sizeof(*scx_numa_node_order_cnt), GFP_KERNEL);
+	BUG_ON(!scx_numa_node_order_cnt);
+
+	for_each_node(i) {
+		scx_numa_node_order[i] = kcalloc(nr_node_ids, sizeof(int), GFP_KERNEL);
+		BUG_ON(!scx_numa_node_order[i]);
+	}
+
+	rcu_read_lock();
+	for_each_node(i) {
+		nodemask_t unvisited;
+		int node = i, j = 0;
+
+		nodes_copy(unvisited, node_states[N_POSSIBLE]);
+		node_clear(i, unvisited);
+		for_each_node_numadist(node, unvisited)
+			scx_numa_node_order[i][j++] = node;
+		scx_numa_node_order_cnt[i] = j;
+	}
+	rcu_read_unlock();
+#endif
 }
 
 static void update_builtin_idle(int cpu, bool idle)
-- 
2.48.1

