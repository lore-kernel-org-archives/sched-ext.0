Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AAC36AB5A
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704929; cv=none; b=SA3H+X/9o5Po8kohqWiFTpNOP2WNpBaHgKIG3Rl7yIwanPD7ZEvBrnRHlzC6BeZloDRp/Qk6rZ4kcW2q8O2AWOPnjk16MS6XR4kn+FxwoWPrlbRItJZqmEkAveIcA6v0wimrz7Hp5bDd5hIJvpdNfqZjEzxbe6MXf2ckdUEzndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704929; c=relaxed/simple;
	bh=kuhVHGIMMxlVAZEMFcXBCd95aTOiyrWQXaN265GIct8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qx8Ajw10TWBZUZ7Mzc8guLYN6iU58GOF/rwM9VFMxuQ1iVy1jZ+qQCHQNAfprwQVSb4fXPCPfbOnzOrbTcuvTIFhPfH4W0cItBHEtbho4/Q1rq//IS3FyIONRQ7eCPJTKA4D25W8QViVWLGQlpgoyDD9y4mSz5r3MypK0X2Som8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LqWdwLuH; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LqWdwLuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ah
	mnJ7Z1PPwxAS80TCrKZMd7o1hyLxkkpEVlDV+ui8g=; b=LqWdwLuHwKHh0/fhCN
	iOqjeDLMKKa4eDxT4CrLhUKgXutH1ehay0h6CyPBDRagYORPtjNWSrIlGDwlaifh
	7c7vflqVQTq3fBI4sy9OR9SHk1VsdcKWljVgcIvE2x5frOW5qwgd3zu47UFfaOgO
	qR7IscFACsxIiH+f5/uAqCQa4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDndx5AG9dpKePoBA--.19355S5;
	Thu, 09 Apr 2026 11:21:38 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH 3/3] sched_ext: Use WARN_ON_ONCE to check whether scx_kick_syncs is NULL
Date: Thu,  9 Apr 2026 11:21:26 +0800
Message-ID: <20260409032126.114812-4-zhaomzhao@126.com>
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
X-CM-TRANSID:_____wDndx5AG9dpKePoBA--.19355S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4fGry7Aw48KFWxXFW5KFg_yoWfJFb_u3
	srAwnFk3yrKFn0v3W3Ga1IqrWfKFykJ3Z5CrySga97ArZ5WrWvqas8AFZ8Jrn3Wa1UCr98
	AFsIqFZrtFnagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8KYL3UUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqgInnmnXG0JErAAA3e

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Since we already add checks in scx_kick_cpu() to prevent the race,
replace pr_warn_once with WARN_ON_ONCE to capture future race conditions.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 kernel/sched/ext.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0a2a3c6dc7cc..cc03924842e1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7702,10 +7702,8 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 	unsigned long *ksyncs;
 	s32 cpu;
 
-	if (unlikely(!ksyncs_pcpu)) {
-		pr_warn_once("kick_cpus_irq_workfn() called with NULL scx_kick_syncs");
+	if (WARN_ON_ONCE(!ksyncs_pcpu))
 		return;
-	}
 
 	ksyncs = rcu_dereference_bh(ksyncs_pcpu)->syncs;
 
-- 
2.43.0

