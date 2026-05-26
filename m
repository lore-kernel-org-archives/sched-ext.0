Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052B3BD62C
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803544; cv=none; b=R44rCwJ6ThsR1UPnfGTu2uNcGGnCukF6B8MUpsFJFC1djPSa8eSK9ls2+3iClFQNvsuQWbq4QGeYKGjYPjIoE7H1kEjCayUQZEucareA4uW3s5s/mrUMZp4+emAiCN+zSynv7K2uMv5lYdkVF8HvEC7uXfIbImWwl/Xqq/radgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803544; c=relaxed/simple;
	bh=p4RLZLouPGRG5b0oIjf5J/oIFDX8Z4mLOIqvC7/mHZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNXjVrslXwMw4xAG8a/UHtHKps2LeJW4C0FV1O+EsSQTz2Pj3qysdaoQ+3iDLd/xjuOrsdiTbLuUHW3l8V5/vpuQnUGC2Qje2RIQVDJofgFTy3a0qye7bCbPym0k/+5p6cvaEtocpNKbHKjH9wX3CcVtfM5/aIDf2EKtTrv88xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNeNY6b4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNeNY6b4"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36ac67f489aso1576288a91.0
        for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779803542; x=1780408342; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kpg4lcDOtpiAI4ebPZufD85Jwn4evGuwEOuK2PnqavE=;
        b=QNeNY6b4/cy8srgmASliJtcWCztBp/xEEasRVpnFb/J0kg92cGVCzcIs2EZH5bEhGx
         qN1KG9T3dG/tnkXsMLuk+oZyfUJr6Ae/QxYTIp9UsgcvCOIaLFztSXm4M2rkak7RqgzM
         UrCzSVNFxmuNIq4k6VvZFrdGIpgsZtKP/CfqC/DPpkLIiSHZBxzE/kiALvMzxUW/7pyA
         IIeucJOFp9S++AkRSP+pQP9+GkwSUS+AaMVY4IBJ2V7aXqu+SyIqGg615XS9MNOFwS17
         Y6eKDWLcPTeTnRasX2ZnhyQRBKadu49ZVcgNqiFdbUjXauOSAhNAcpZHkddGdHXr1Nts
         onqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779803542; x=1780408342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kpg4lcDOtpiAI4ebPZufD85Jwn4evGuwEOuK2PnqavE=;
        b=lyB2du4gyRCbnrs8JC5thQSJQjRXljIHKPlKr/p9ShON+d8CemmRnwVhLYFfU7ciXI
         5f+HXoUDxWBIq8yTQYq+YBGVMZOBUVay9g2faXXUCWZLF718qyMFrCKv+uCS6nXgQERK
         tsD8352EXq/l70s8fyWrlBIHppgT6yq/tHOSUKZbd9nrjw5d/VnNHjDZohG9Iyg/WSSc
         KpKN6m9G4VQafbsazej427ObHWGwG9/mBfRgFAOXrQuiGKFI8sUkqpexKqMT9mh2pH23
         22yXhZQr2VBPwbTszySF0riUJ0DopZBywoNF87WJL75RhY5ksrztuId/Mx2n4VoI/+f4
         zOng==
X-Forwarded-Encrypted: i=1; AFNElJ8l3zBCaXj1Oq30SlxTjA38FEewTiuuF8xhMbXOTQNCFXYsJcRdRXqzNd5y56C8RORWhoXgMO0d5aE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyv1y7S++Lw4qbuWa7xmAjWrViOfN8ESVGiJD7+xMrt+OKW5rRD
	xw3i/9gFCNL4wP75L1BVWkiyM14fzIQDxtaO1wWBjtbqjufi8MR7CTeT
X-Gm-Gg: Acq92OGvEqy6oSrXWQrYTTToRdY5RpRWga8zQfCLeQOB8tLrSlV9v1HLRTa8OPm4Nto
	HjHHShjyy/oP8sZ6hYX9XsTVWIVibzBiqoGKZht+sRD4zJ6LQsZdNs7CL3zgCVEpfJKgwajCGmC
	eUeHQ4eZzW7OCzm/qWEdoe+0ICUZ5z/l0K3OQrrc0FhSQaiR4TUjt5WshFmglCP4ZLZzj3oUbKE
	SKBmJxlnVFe+x7644A5NHm71QhfEodvEfKXDvBtoK5i6Ku7VyNBim1JukA8hq5hVphFQoQn3e7e
	NdYpOiLI5L62FCKcJsYZg8e0LARmGV1SNO9/VJuTFTFd1xxoZ8K9BcI8yhryPUoZFsvsxqAWCt5
	bKmPRiMbDtAJVkOrCiSJk9mSqsUr7O6eD/bPoCRbhBTrf/3tWplL37qgrfgfCKopodqWUjYtWGm
	cfVPEO0uKrSqpdPkZqd8AzX5wfc0qm5YzHnhrz1ctd+hr6u9pho8+62lB1Vw==
X-Received: by 2002:a17:90b:1d44:b0:369:7944:d723 with SMTP id 98e67ed59e1d1-36a6bb5a6bfmr13510687a91.4.1779803542162;
        Tue, 26 May 2026 06:52:22 -0700 (PDT)
Received: from DESKTOP-QGNVECK.localdomain ([139.159.170.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721c7cf9sm12826858a91.10.2026.05.26.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:52:21 -0700 (PDT)
From: Zicheng Qu <quzicheng315@gmail.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.co,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	haoluo@google.com,
	joshdon@google.com,
	brho@google.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: tanghui20@huawei.com,
	zhangqiao22@huawei.com,
	quzicheng@huawei.com,
	quzicheng315@gmail.com
Subject: [PATCH] sched_ext: Rebuild fair weight when disabling BPF scheduler
Date: Tue, 26 May 2026 21:52:11 +0800
Message-ID: <20260526135211.1892261-1-quzicheng315@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zicheng Qu <quzicheng@huawei.com>

When a BPF scheduler is disabled, scx_root_disable() switches tasks
from ext_sched_class back to fair_sched_class directly. This does not
go through __setscheduler_params(), so p->se.load is not rebuilt for
tasks returning to fair.

For example, after enabling a sched_ext BPF scheduler and creating
CPU-bound tasks with different nice values, disabling the BPF scheduler
can leave them running under fair with stale p->se.load. They may then
split CPU time according to the stale weight instead of their current
nice weights.

Rebuild the fair load weight when scx_root_disable() switches a task
from ext_sched_class to fair_sched_class. Use set_load_weight(p, false)
so CFS gets a native load_weight derived from the task's current
policy/static_prio before the task is enqueued on fair.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 kernel/sched/ext.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 65631e577ee9..e5b8509ce7ee 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5967,6 +5967,10 @@ static void scx_root_disable(struct scx_sched *sch)
 
 		scoped_guard (sched_change, p, queue_flags) {
 			p->sched_class = new_class;
+
+			if (old_class == &ext_sched_class &&
+			    new_class == &fair_sched_class)
+				set_load_weight(p, false);
 		}
 
 		scx_disable_and_exit_task(scx_task_sched(p), p);
-- 
2.43.0

