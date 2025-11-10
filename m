Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CF2F8BF0;
	Mon, 10 Nov 2025 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808208; cv=none; b=ETtKKPJyiVhGmJdCAiBfcN23zNnosoTjFHFOmBNL3eGP4DrRwJ1pi+9UDD+sahDJpD4tuBZHS3gf7T9LJrLdtAuFhDJ376Z9+pHvchhToeg3cJ/hKn/M5X1utng4pPhxHc8ij66n/EhoB7gAXDsdL6IqONuPQBZYzqzneqeTySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808208; c=relaxed/simple;
	bh=Wx1ilLb2Xph1VdCZIdWgwNSK6S4Ii/+E0wSKlOVtxB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxOp8KqsXnoXqSFjR/uS2uxmoR21v7JOIwCZceqcfcqSuQ+AZG2O2WpBm8kAhSwijNeC0DYRrCcSS0P/5rcKUpuRGA2cq5eIGf+RZEA+SL1k39iM3/U+1aYBLDqljq3DTQ7PbkNma3K1w7zp+GpgpDgXICx/wcpOPm/1nqRkxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrcTNx17; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrcTNx17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9175C4CEFB;
	Mon, 10 Nov 2025 20:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808208;
	bh=Wx1ilLb2Xph1VdCZIdWgwNSK6S4Ii/+E0wSKlOVtxB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UrcTNx17oBlvBqqzWfmJuxDEpN+ZFGofETPrupW+5V2FclGtxaG4GgDJEyhWCBamP
	 +uTE0If/OpF0dJG2GI8P2/HfLrUzo9I30nUbnmld4HSzjTfNvwGlvdrG8fUBNblPGZ
	 fMf5z2fwvtWb2DT2T4qMcz+Imz+UgtMN5Ee/7bxqT5SUckAyWMseVJbbCmeSC+NRPW
	 6pMSp9jqPOBoeDHeCyBUxLkdkqQLTdMxC0xpGIhl3xB+hWNs8vhe40wyDNq4pFBwoi
	 8XrjWmbN3z03Qwg/lgp8TxsXjcsQVRJV5WBfzzyHSm/3d8lBCMLlq1z/VrMKDC5Cdq
	 3If9f3P+iSYpg==
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
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH v2 10/14] sched_ext: Hook up hardlockup detector
Date: Mon, 10 Nov 2025 10:56:32 -1000
Message-ID: <20251110205636.405592-11-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110205636.405592-1-tj@kernel.org>
References: <20251110205636.405592-1-tj@kernel.org>
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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  1 +
 kernel/sched/ext.c        | 18 ++++++++++++++++++
 kernel/watchdog.c         |  9 +++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 3d3216ff9188..4b501ad7a3fc 100644
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
index 566ef100e2be..d16525abf9e0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3707,6 +3707,24 @@ void scx_softlockup(u32 dur_s)
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
2.51.2

