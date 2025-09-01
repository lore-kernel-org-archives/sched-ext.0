Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2615276027
	for <sched-ext@lists.linux.dev>; Mon,  1 Sep 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733181; cv=none; b=T41F739vFopE8kmt5qq2HHJs03Sb7F4Tksgk/E/anoV0d9t1vesuTyBLWZq/2XXdM/yAVQ+pwjRAIQoJOq7l30SFrv1GsbmSL07mZgpFPk2UQZaeFfwyzA2v0ronnjSKhhTQMxgruujcWn2FA6KxwTaRklwsdCtj00PvrCGHGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733181; c=relaxed/simple;
	bh=r8VcXAkw02qtw7l6Sy/d5uVFLeYdstRd+OxMkm9icPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDLoI0/pVP9yeM254IbcdnP1XDK1z/psxsuy6Rb7lR+nEUeqPRC+WBkCK3d0E01qwHhdiu6HyuDdWFVrl93/6Mqs/jn3j7aZK5JAxxbRsp2wR2E+9Tc6mwwUV+4wqFgkYfQCuV28vxoYUrfm5I0X5pe2+rhBL+p+Q5NC+45DDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A67F2682;
	Mon,  1 Sep 2025 06:26:11 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.36.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05F1C3F694;
	Mon,  1 Sep 2025 06:26:17 -0700 (PDT)
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
	jake@hillion.co.uk,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v5 3/3] sched_ext: deprecation warn for scx_bpf_cpu_rq()
Date: Mon,  1 Sep 2025 14:26:04 +0100
Message-Id: <20250901132605.2282650-5-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901132605.2282650-1-christian.loehle@arm.com>
References: <20250901132605.2282650-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_cpu_rq() works on an unlocked rq which generally isn't safe.
For the common use-cases scx_bpf_cpu_rq_locked() and
scx_bpf_remote_curr() work, so add a deprecation warning
to scx_bpf_cpu_rq() so it can eventually be removed.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e242a2520f06..a524d404ad09 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7427,6 +7427,9 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 	if (!kf_cpu_valid(cpu, NULL))
 		return NULL;
 
+	pr_warn_once("%s() is deprecated; use scx_bpf_cpu_rq_locked() when holding rq lock "
+		     "or scx_bpf_remote_curr() to read remote curr safely.\n", __func__);
+
 	return cpu_rq(cpu);
 }
 
-- 
2.34.1

