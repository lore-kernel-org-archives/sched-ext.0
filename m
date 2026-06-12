Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EFC3839B8
	for <sched-ext@lists.linux.dev>; Fri, 12 Jun 2026 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277962; cv=none; b=k/RBWbqnnQjfWb2V4CcOVBWgwAlkIDASZeFOJhKsiZp/Z4DMGcsLdfU4RLh/EehEk0lE75BxR3Mz0Iw8LZDhkqpxu/H5rdq6OSOggFtaWk2xMWk6V2kN6weZwoPTljl7lrBzjkceZYsx/N5nEgZ4oHy5TujMZWnMT7MeNJwg0Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277962; c=relaxed/simple;
	bh=ZCGr2ZD7aOZdWJzN41ARCqQ+xGFtFShsMkpdFrnFqv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mWCuN+zElbmB/HjJgCZbPFoa2TOztruUTUlKc3TT3MqJY7t5AhSgGOV+MpgwteSF5EVupzdcqOXTRenDixn4cO7YzOvcUoo7OTQzUmvZgUzdIa07o1dKor5oPXshkKpotCx3iMftGrBWYAGPNnBUR+1wtyfTG4LIkm65NGFdQZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V2fmgDH3; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V2fmgDH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6K
	TNg5pZvks6roP+8nCZzPSVcej9PEkniYMrHCYILmE=; b=V2fmgDH3XELn5GNMkG
	HgOOgKM3LGsgaYl/JFDjdHsm7yfvdYSwpIp+2Iz183I/iiEsvBF7ARMDoNXJNbD8
	OlRj53w+tIVwYyvhVim8pZ3pRaTbrNaN1WSTEgwFefoFUSObYwaaxfpA8VFIRAu0
	lL2p4pSXAyUVggsOuGB8KkBSM=
Received: from cuijian-virtual-machine.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3dy9dJCxqENFaBw--.4480S2;
	Fri, 12 Jun 2026 23:23:10 +0800 (CST)
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
Date: Fri, 12 Jun 2026 23:23:04 +0800
Message-Id: <20260612152304.94821-1-cjian720@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3dy9dJCxqENFaBw--.4480S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1DZw48Gw4DurW5Zw4xJFb_yoW8AF1kpa
	9rZrWUG3y7tay5Kw1Ikrn5WFy8Xwn7Ga1S9FyDJwsYvrn0gFWSqw1jgrW2gryj9rW7Z34x
	trn093ySvw1Yg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USPfLUUUUU=
X-CM-SenderInfo: pfmlt0qxsqqiywtou0bp/xtbC9x7FUmosJF6CqAAA3o

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

