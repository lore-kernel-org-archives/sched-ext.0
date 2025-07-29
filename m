Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D8B18C322
	for <sched-ext@lists.linux.dev>; Tue, 29 Jul 2025 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805022; cv=none; b=iuiNtq/HnNuuIamvvmYub+o7zBkPUyrmme5KgroGdBynwYC2WJg832W4CVb9WmIJIZpxBkg565AD1VczEMvvc4E/wtngxZM8OaswFF3pzAKLiWxjuj0r8M3Njw6Y099Boh4Doza3vocvmrryU3qh+MJvkk5kdBxTdmMR+j6JhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805022; c=relaxed/simple;
	bh=JALDSuCHo6yW/v3LgSW8wFxn0wXqBjCTPFZyDX9BKUE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=npEEORI2mAA43Ujb2svYml51U77iowt4LgtBaNxJzxmgKvnMjIPxQ5F0JCMdw4etmk63/yf8xF9+3fU5PR7M8AXLCGONaIsSfAUB86Ewltq8J7+xKTPHNjD0dNH6OJxsDYRR7N0IGg9f57bWsYDLVWu0sijGOb4ChAICi28LMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D541A113E;
	Tue, 29 Jul 2025 09:03:31 -0700 (PDT)
Received: from [10.57.69.185] (unknown [10.57.69.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3222E3F5A1;
	Tue, 29 Jul 2025 09:03:38 -0700 (PDT)
Message-ID: <0b8111c6-1b14-41dc-a674-14a6361992b3@arm.com>
Date: Tue, 29 Jul 2025 17:03:36 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, void@manifault.com, arighi@nvidia.com
Cc: sched-ext@lists.linux.dev,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] sched_ext: Mark scx_bpf_cpu_rq as NULL returnable
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

scx_bpf_cpu_rq() obviously returns NULL on invalid cpu.
Mark it as such.

Cc: stable@vger.kernel.org
Fixes: 6203ef73fa5c ("sched/ext: Add BPF function to fetch rq")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
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
