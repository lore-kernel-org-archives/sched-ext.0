Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BC126E6ED
	for <sched-ext@lists.linux.dev>; Wed, 30 Jul 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871610; cv=none; b=e0xq1YRAEuapqZ56I3ULDtmgwFRJbYQWfRJ98PyrA8qAuUcZtvlgCmlrfMWw50CyAj0+6cp+aYxxD1bNdXB8+b4+6I8dqGZ1UoJu/A/PHb6/EBvrYQ0jtKEURe4JVmtHDSh/fuBXKX3/JeBy2BSclLqR1Bqt68zhglXkpqMoj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871610; c=relaxed/simple;
	bh=Mgtm+AZHgtiboO81D2klozRHFXTt27P6lDtPoA5yoPY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TdLxhkVMsQ2Sm6JPmLAgXA0hP7z29VgmEHDcK6azn9N+Vkha3wv7D30d0RyV/D9jGZIp7GAG3KyI8fJT71kHMbc72OGHKNULX+3ZXcJcR0tSffMHPYbyw/OxWiq129cCgg/axiSQJTaeIaiCmuCGLbgAW5KL73E1KMXP3eK8+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 962ED1BC0;
	Wed, 30 Jul 2025 03:33:20 -0700 (PDT)
Received: from [192.168.3.124] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9ACD3F673;
	Wed, 30 Jul 2025 03:33:26 -0700 (PDT)
Message-ID: <43a9cbdc-5121-4dc8-8438-0f01c90a4687@arm.com>
Date: Wed, 30 Jul 2025 11:33:19 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: arighi@nvidia.com, Tejun Heo <tj@kernel.org>,
 David Vernet <dvernet@meta.com>
Cc: sched-ext@lists.linux.dev,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCHv2] sched_ext: Mark scx_bpf_cpu_rq as NULL returnable
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
v2: Extended commit message and picked up Andrea's ACK.

 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7dd5cbcb7a06..b734f55f3318 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7599,7 +7599,7 @@ BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
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
