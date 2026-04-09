Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291827707
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704929; cv=none; b=jQTKIPC4aRJzYBS6oendarpn3xslgATMew3slZyFlk/i2P3cMWEVebQvlSepwjSmgSsq+9Z/OlGYakZZX4aGgH0j58kikLGRyF1PpaQE24gDHbL7a2fsvrmah4uMWxecYgKjqhtMBPNLU+QrEHM3HuPrXY4TnwZ8zw3PpPtDzGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704929; c=relaxed/simple;
	bh=QalazcFu8iOREwryftfpJMzcVqtrXDg81FW/qQokQ00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcK2zMa76g5piAmsTr9Ev68f8DvOcUw6+zhzMLLEuidJ8F2iX09fb5C/7zlMi38JCklVMMWL+/O84u/GXz3mGSGk4RhOME0G+9MjKvVp2jwLJljgD+m9VIRem/VXfG1PCl22eqhnKa4OTLuHPUc+dRHbJ/j9IytgFwQ2I/LDf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LJtwpSlG; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LJtwpSlG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ee
	TIvJCaqvOOkXamuiiRvwQSyuH2rNzgLdbkztr803A=; b=LJtwpSlG2HYsIgXOXL
	VZf/u5vIAyReBpwG/ehu1X35yp8/ChgGxLSpBkg549pY4RaJVqYhE2nRFbMtkGfj
	+HiGUnMje8zXz/JCUBNf5dOWDkpN0edVOa+9f+OaiHnebURp7OXxkeZg4dLCsiYe
	Miv8b6wYs0nYMFmrL563yAG+8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDndx5AG9dpKePoBA--.19355S4;
	Thu, 09 Apr 2026 11:21:37 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH 2/3] scx_central: Cancel BPF timer during ops.exit
Date: Thu,  9 Apr 2026 11:21:25 +0800
Message-ID: <20260409032126.114812-3-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409032126.114812-1-zhaomzhao@126.com>
References: <20260409032126.114812-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDndx5AG9dpKePoBA--.19355S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4Uur13GFyrXr45WFyfWFg_yoWfuwc_C3
	W3Wr18AFs8GF1ak3WYkr4UXF1FkFZ5KFs8WrWIg393ZF4UJFn8AF1UCF4DuryDKw4UZFsr
	CFs7XF48Zr929jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU81KZJUUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlgEnnmnXG0FMlQAA3T

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Cancel the BPF timer in ops.exit, which is called before
free_kick_syncs(), so that new cpu kick will not come and hit the NULL
check in kick_cpus_irq_workfn().

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 tools/sched_ext/scx_central.bpf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 4efcce099bd5..6c2cd5511a25 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -359,7 +359,14 @@ int BPF_STRUCT_OPS_SLEEPABLE(central_init)
 
 void BPF_STRUCT_OPS(central_exit, struct scx_exit_info *ei)
 {
+	u32 key = 0;
+	struct bpf_timer *timer;
+
 	UEI_RECORD(uei, ei);
+
+	timer = bpf_map_lookup_elem(&central_timer, &key);
+	if (timer)
+		bpf_timer_cancel(timer);
 }
 
 SCX_OPS_DEFINE(central_ops,
-- 
2.43.0

