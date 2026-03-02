Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A01E8320
	for <sched-ext@lists.linux.dev>; Mon,  2 Mar 2026 06:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772434185; cv=none; b=tNXIskbZ9iR1L0x8ui+WR18bb6E9ub1G5sbeELA/3+bNohHOGKdjd3As4PLRxh6UuggX8jo93UnoTicH0sKUgXzzZ6OO5pxFn2eo/oRCiC62M2k5LRkvMYEFEjmQ+aMW+wUmJoaEIWXjsoHzZiFhZaya3k+6lv7UAuSDYCEIHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772434185; c=relaxed/simple;
	bh=es08QVW7hTl3XMoeEOKefu5ph+RdgJ8wPYzRQfQoFek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=msSuZlOAGspaHWh7L1Wu61egYBnFn4FGeMxWU5ehQZqRC1+2NQyn+uOTS8x2b7PJfoQzoIaoL5idHUokvWHt+Q2sOvna+HYm9LZivisC1muC4bg8Iny1WOJ1JTEYN1Dffolu+WiyM9HI65WIFBciP19qEsPDgrEbUAnVBygvqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Kg8e3DXG; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Kg8e3DXG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kr
	ZO426PFlDorEa2A0nidAbqtyuzFQ2nQjRkAmJV+mQ=; b=Kg8e3DXGgFBcKwu+SX
	nd9eo7loZySauY8873BK24KqNjRL2T0Z2Gu1M1L5hERS8WFmvIhHo5pUhvyvv5Zx
	WW1vOm1607dP9NBnqRe89gTf4fWUg7d9d2FyHXPR3oxHFlOlZws4RvcTL5LJtS/o
	igiTSXcgW6r4LX28qSZ33olXg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnuD7TMqVpFsyuNQ--.14978S2;
	Mon, 02 Mar 2026 14:48:53 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	shuah@kernel.org
Cc: sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/sched_ext: Fix the incorrect logic validation
Date: Mon,  2 Mar 2026 14:48:51 +0800
Message-Id: <20260302064851.370327-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnuD7TMqVpFsyuNQ--.14978S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww48AFyrWFy5GrWftrW5KFg_yoW8JFW5pa
	4ku3sI9F1ktF43K3yxtrWqq3yrWFs3ta1xXw4xJa13AF18Xry2qr18tFnaq39xWrs2y34f
	ZFyIg3yxWa1xA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jePfQUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8RWF-WmlMtUNFQAA3v

From: Feng Yang <yangfeng@kylinos.cn>

When __COMPAT_scx_bpf_pick_idle_cpu_node selects an idle CPU,
it reports that the CPU should be marked as busy.

Fixes: 5ae5161820e5 ("selftests/sched_ext: Add NUMA-aware scheduler test")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/sched_ext/numa.bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/numa.bpf.c b/tools/testing/selftests/sched_ext/numa.bpf.c
index a79d86ed54a1..98423628b05c 100644
--- a/tools/testing/selftests/sched_ext/numa.bpf.c
+++ b/tools/testing/selftests/sched_ext/numa.bpf.c
@@ -44,12 +44,12 @@ s32 BPF_STRUCT_OPS(numa_select_cpu,
 	 */
 	cpu = __COMPAT_scx_bpf_pick_idle_cpu_node(p->cpus_ptr, node,
 					__COMPAT_SCX_PICK_IDLE_IN_NODE);
-	if (cpu < 0)
+	if (cpu < 0) {
 		cpu = __COMPAT_scx_bpf_pick_any_cpu_node(p->cpus_ptr, node,
 						__COMPAT_SCX_PICK_IDLE_IN_NODE);
-
-	if (is_cpu_idle(cpu, node))
-		scx_bpf_error("CPU %d should be marked as busy", cpu);
+		if (is_cpu_idle(cpu, node))
+			scx_bpf_error("CPU %d should be marked as busy", cpu);
+	}
 
 	if (__COMPAT_scx_bpf_cpu_node(cpu) != node)
 		scx_bpf_error("CPU %d should be in node %d", cpu, node);
-- 
2.43.0

