Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6A5245014
	for <sched-ext@lists.linux.dev>; Tue,  5 Aug 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392259; cv=none; b=HVJ1rdihev6ehpwq/fGfklshyT7ryNxw28Dlxo1aS/d9CUMjlWwq3VjO9c+05zihDlxLvQnXeOU+dU9cXlSo1B1Vj0N1nuSEI301p+x033BJ6Dl0bHtptKTtccfLS2gl5HykPlA6HJyFXUw64rsPsCS2zBNANFJxW1/eIxnthUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392259; c=relaxed/simple;
	bh=hjOL3ON5fPPF6nNMGzaUMSvif7RbckVL3EFMwbn3B9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idudNgTu+U0FChW9CNRr/OOlMITxhRuHeW6PPn48E16MpE7l7WARlMFu1sLtGiKl+LgVx328RTvOu7/D0zq3o8hVudLRauhVPlEqk/hCVw7OqJfQLXtNudbmozN2PHKL0gVsWJvRbYLr+X8GoQD0GwiT96WjsID4UZA7EqapHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D99932BC2;
	Tue,  5 Aug 2025 04:10:42 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.27.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D8813F673;
	Tue,  5 Aug 2025 04:10:48 -0700 (PDT)
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
	Christian Loehle <christian.loehle@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] sched_ext: Mark scx_bpf_cpu_rq as NULL returnable
Date: Tue,  5 Aug 2025 12:10:34 +0100
Message-Id: <20250805111036.130121-2-christian.loehle@arm.com>
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

scx_bpf_cpu_rq() obviously returns NULL on invalid cpu.
Mark it as such.
While kf_cpu_valid() will trigger scx_ops_error() that leads
to the BPF scheduler exiting, this isn't guaranteed to be immediate,
allowing for a dereference of a NULL scx_bpf_cpu_rq() return value.

Cc: stable@vger.kernel.org
Fixes: 6203ef73fa5c ("sched/ext: Add BPF function to fetch rq")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7dedc9a16281..3ea3f0f18030 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7589,7 +7589,7 @@ BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
+BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_RET_NULL)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
-- 
2.34.1

