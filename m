Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE60305953;
	Sun,  9 Nov 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713085; cv=none; b=MXzKaPz1qhKMKN86ZvU0yeejl7z8x4XYeRyH+mm9U3SDWpYC/LCac0PlFHRXqbQNF/0RgHJBq9x+II46E35um0dnutoQXfHvIQEEAdj2O+3P2xlS9bTFUPKwbk43WQvzrgnaH+vxRsFAthzH2zXHvwwkKQCAfXTtowY/fkPfhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713085; c=relaxed/simple;
	bh=hndLwyNShGixwcDPfTu336LvFvXBxKSDH6FIzIhzz9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gx6pX+KxxrWGP94U4EXoB3c56BHkNjboeaNK8QoAAWYo3YXtX2D5miuxcqe5n3zDnDlR6FTlMyG8gLwM4V0p2w1bxfWJNDthJ28ZsW12V6CGx7/8Etxz2Ia0EMjcQCn3pa25hb0u1dbBjdckksPQEDzSW+zIx88Fne/vPY/ZlgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNRy0Ugu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNRy0Ugu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4BBC4CEF8;
	Sun,  9 Nov 2025 18:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762713084;
	bh=hndLwyNShGixwcDPfTu336LvFvXBxKSDH6FIzIhzz9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNRy0Ugut8ZrbnLeOdIqioKXxqIxM63zS7mA/dddWnpqBZ0dET3F0VSvKHkK6ZoHs
	 H0bH5xwmHqjjr+gSv78Zzs1lTzytQOCi2ANnR+w5YqbYdB1l75ciHFVG35SCnIPHee
	 QJUBobs501GziyRkeMfey161OJ4ixalgKWAy2zDoNiiyPSVHz2bP7IT23jAoaUmEze
	 dOc4h+zwZQ3MZBOnbGHBwznBoeIGQLHIWQEV+2/aRxZr/xI1iO2vZ5Ynggafd6mCYD
	 PKtneDocYQjDAXkTqH0JHRGChoiOPo/Qcl3vfLX7CdOtsvrEpaEafzO28v8PuBvb6t
	 a55QwkDpciQEg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 10/13] sched_ext: Hook up hardlockup detector
Date: Sun,  9 Nov 2025 08:31:09 -1000
Message-ID: <20251109183112.2412147-11-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109183112.2412147-1-tj@kernel.org>
References: <20251109183112.2412147-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A poorly behaving BPF scheduler can trigger hard lockup. For example, on a
large system with many tasks pinned to different subsets of CPUs, if the BPF
scheduler puts all tasks in a single DSQ and lets all CPUs at it, the DSQ lock
can be contended to the point where hardlockup triggers. Unfortunately,
hardlockup can be the first signal out of such situations, thus requiring
hardlockup handling.

Hook scx_hardlockup() into the hardlockup detector to try kicking out the
current scheduler in an attempt to recover the system to a good state. The
handling strategy can delay watchdog taking its own action by one polling
period; however, given that the only remediation for hardlockup is crash, this
is likely an acceptable trade-off.

Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  1 +
 kernel/sched/ext.c        | 18 ++++++++++++++++++
 kernel/watchdog.c         |  9 +++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index e1502faf6241..12561a3fcee4 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -223,6 +223,7 @@ struct sched_ext_entity {
 void sched_ext_dead(struct task_struct *p);
 void print_scx_info(const char *log_lvl, struct task_struct *p);
 void scx_softlockup(u32 dur_s);
+bool scx_hardlockup(void);
 bool scx_rcu_cpu_stall(void);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4507bc4f0b5c..bd66178e5927 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3710,6 +3710,24 @@ void scx_softlockup(u32 dur_s)
 			smp_processor_id(), dur_s);
 }
 
+/**
+ * scx_hardlockup - sched_ext hardlockup handler
+ *
+ * A poorly behaving BPF scheduler can trigger hard lockup by e.g. putting
+ * numerous affinitized tasks in a single queue and directing all CPUs at it.
+ * Try kicking out the current scheduler in an attempt to recover the system to
+ * a good state before taking more drastic actions.
+ */
+bool scx_hardlockup(void)
+{
+	if (!handle_lockup("hard lockup - CPU %d", smp_processor_id()))
+		return false;
+
+	printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
+			smp_processor_id());
+	return true;
+}
+
 /**
  * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
  * @bypass: true for bypass, false for unbypass
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5b62d1002783..8dfac4a8f587 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -196,6 +196,15 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 #ifdef CONFIG_SYSFS
 		++hardlockup_count;
 #endif
+		/*
+		 * A poorly behaving BPF scheduler can trigger hard lockup by
+		 * e.g. putting numerous affinitized tasks in a single queue and
+		 * directing all CPUs at it. The following call can return true
+		 * only once when sched_ext is enabled and will immediately
+		 * abort the BPF scheduler and print out a warning message.
+		 */
+		if (scx_hardlockup())
+			return;
 
 		/* Only print hardlockups once. */
 		if (per_cpu(watchdog_hardlockup_warned, cpu))
-- 
2.51.1

