Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293F34A797
	for <sched-ext@lists.linux.dev>; Fri, 12 Jun 2026 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286751; cv=none; b=oQsCOWZ42WwmCfsr3QfdXWp/fvbfvi7R5WZrjmmYVAHLTIgqfMBj7zyv5vQPR3kwg3hIYybj2KYwFQi9RjeN+RiZaV9eY2q7PFODgM2cGKW3S+9lqCsq85uNU5FdDsgARIZKpePE2Qmlmj8BysrUui1A5BGcHmqTikyX1twjJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286751; c=relaxed/simple;
	bh=GgF9ivyRAogrDNk+ReFpG1OC8RDPAKZrxZ9fCD5zt4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ShDE4v/MHmkVKU3AcphuGe0sn6JYN5Kw8a+zJMwzNBTB36bgJYhN91aogN1gxPfnyrou08iRfnFPJE8MXZ0KmV5VteQTQra3ba2bXzBbJd23JnX3bO/d7AjAsHxJg9kcphjylzkZWrNAEmWwGwPmXsomDnytqmkd8R8lFflWNxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IhdCGmuJ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IhdCGmuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kT
	cP7YsFNsnzWMwNlVinaIxmzNANOE4+aOqxEn3FCDY=; b=IhdCGmuJ+i+0KJJlEA
	r5FnFeTKyTZRRhE1Gfei1Q/k9ITEfVIOiGR9K5J61agiTMstA3WZv4IBiVMuUbeY
	LSHCrATO3lYnfgdUUD3GqXdrmrBm/aZWCUxKFnvjkKFpH98/45p46RmfXK5XaCni
	ApHfAcCsJJc8LydsHrRiV8mJk=
Received: from cuijian-virtual-machine.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3ddQVRyxqKc9wDA--.47167S2;
	Sat, 13 Jun 2026 01:51:18 +0800 (CST)
From: Cui Jian <cjian720@163.com>
To: tj@kernel.org,
	void@manifault.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cui Jian <cjian720@163.com>
Subject: [PATCH] sched_ext:SCX is preemptible by the Fair scheduler
Date: Sat, 13 Jun 2026 01:51:13 +0800
Message-Id: <20260612175113.110447-1-cjian720@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3ddQVRyxqKc9wDA--.47167S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryUZF4UXw4fGr1xJF18Krg_yoW8trWrpa
	9rXrW8Jw47tay5Ka4Iyrn5WFyrX3Z7Ga1SkF98J390vrn0gFWFqw1jgrW7CryY9rW7Zryx
	tr1q93y2vw1jg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USPfLUUUUU=
X-CM-SenderInfo: pfmlt0qxsqqiywtou0bp/xtbC+BZ8CWosRxYgigAA3m

Hi Andrea,

While this callback will eventually be deprecated, SCX is still a relatively new scheduling framework. Incomplete preemption reason enums make it difficult to analyze interactions between different schedulers, and filling this gap significantly improves observability for existing SCX workloads.

This patch does not modify core scheduling logic, introduces zero performance overhead, and adds negligible long-term maintenance cost.

sched_ext currently distinguishes preemption caused by STOP,
DL and RT scheduling classes, but preemption from the Fair
scheduler is reported as SCX_CPU_PREEMPT_UNKNOWN.

When analyzing SCX scheduling behavior, it is useful to know
whether a task was preempted by RT/DL classes or switched out
in favor of a Fair-class task. The lack of a dedicated reason
makes debugging and observability more difficult.

Add SCX_CPU_PREEMPT_FAIR and report it when the next scheduled
task belongs to fair_sched_class.

This change improves scheduling diagnostics and observability
without affecting scheduling behavior.

Signed-off-by: Cui Jian <cjian720@163.com>
---
 kernel/sched/ext.c          | 2 ++
 kernel/sched/ext_internal.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5d2d19473a82..6e0281218197 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3015,6 +3015,8 @@ preempt_reason_from_class(const struct sched_class *class)
 		return SCX_CPU_PREEMPT_DL;
 	if (class == &rt_sched_class)
 		return SCX_CPU_PREEMPT_RT;
+	if (class == &fair_sched_class)
+		return SCX_CPU_PREEMPT_FAIR;
 	return SCX_CPU_PREEMPT_UNKNOWN;
 }
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index a075732d4430..3ce07bec58a5 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -241,6 +241,8 @@ enum scx_cpu_preempt_reason {
 	SCX_CPU_PREEMPT_DL,
 	/* next task is being scheduled by &sched_class_stop */
 	SCX_CPU_PREEMPT_STOP,
+	/* next task is being scheduled by &sched_class_fair*/
+	SCX_CPU_PREEMPT_FAIR,
 	/* unknown reason for SCX being preempted */
 	SCX_CPU_PREEMPT_UNKNOWN,
 };
-- 
2.34.1

