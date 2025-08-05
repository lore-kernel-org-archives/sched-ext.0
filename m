Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F01A24677D
	for <sched-ext@lists.linux.dev>; Tue,  5 Aug 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392259; cv=none; b=RMFgG/Kmsh7AVsToduHgUyPQLgYKstv/li9dGI8T1LDCxnCIPznIt4kFHPa2ZyXciHJUazRxYcl0d2yQndwGBf53uxjphe/+6SDyIy7gldcl+YNWK7jfz9XyqxijisYk01fmQOqmMaLqjvC1k43cnawubga3IVye9Cf4Yo7nXtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392259; c=relaxed/simple;
	bh=PUDAo6grH9DktBE1Hai0CoaFv7psRNK9cyOz30Tu3Uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJQSfETnaoWgjBRbgQfUYUpVr834pFfpfkOOT8XJ/LsLJ6NFaUYDrzi1NB371OORn0hMDiIIT1CUZtZoBycPmUC0LI9kaqNRkBxAfgcMK58yN7tcKKC0MvScZfe+OB3vFTE4dWrUHDaXAxaxdKaoinWlPm6vGyjzGb2OSXeg+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7880B113E;
	Tue,  5 Aug 2025 04:10:49 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.27.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 650F63F673;
	Tue,  5 Aug 2025 04:10:55 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: tj@kernel.org,
	arighi@nvidia.com,
	void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	changwoo@igalia.com,
	hodgesd@meta.com,
	mingo@redhat.com,
	peterz@infradead.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v3 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
Date: Tue,  5 Aug 2025 12:10:36 +0100
Message-Id: <20250805111036.130121-4-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805111036.130121-1-christian.loehle@arm.com>
References: <20250805111036.130121-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most fields in scx_bpf_cpu_rq() assume that its rq_lock is held.
Furthermore they become meaningless without rq lock, too.
Only return scx_bpf_cpu_rq() if we hold rq lock of that rq.

All upstream scx schedulers can be converted into the new
scx_bpf_task_acquire_remote_curr() instead.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3e2fa0b1eb57..a66cf654f33e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7420,10 +7420,20 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
  */
 __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 {
+	struct rq *rq;
+
 	if (!kf_cpu_valid(cpu, NULL))
 		return NULL;
 
-	return cpu_rq(cpu);
+	preempt_disable();
+	rq = cpu_rq(cpu);
+	if (rq != scx_locked_rq()) {
+		scx_kf_error("Accessing not locked rq %d", cpu);
+		rq = NULL;
+	}
+	preempt_enable();
+
+	return rq;
 }
 
 /**
-- 
2.34.1

