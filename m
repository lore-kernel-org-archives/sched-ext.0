Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31F49620
	for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246900; cv=none; b=INrs/CwLlg9zQ5kaxMg08o6lKraVUesvyk8ZaZLNJl7VVUpW59g/ilnneGne25VouQ00EWS8GyGzF3BfGGzH59JBu9W/dXEndMIe7SZ5TmHaUBhu08Id9Np2Jn33dOdS0wZkeKztPU9YJO9sYa4Sbw/JotrEd4kS48K1/QzdxiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246900; c=relaxed/simple;
	bh=0NPff8qv5ZpbhvzhMc052Lek2kjbyQ46v5mNbWpq0UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bw9wElkx/OSmXXC+b7ExI4uSq7TQ03OBas5Arj35Lpyr3MKuiM9jok2wKXgM8HpcLW08IEobUSeBQ1PAt2WE3Fv/739cTuEmf75QxLiFutPcsq7O0SLN3A8wmCBrZi7ghlJLsdHZfGJk6vjSqZbXMLXxdXmHfn6tRH2TgR7j1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=cW+HKPFz; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="cW+HKPFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=MO
	9zfOHQVMneVVRYJXXzsHNZuKRDVPKnBw+V44zOZfo=; b=cW+HKPFzJMVCf+sVWS
	p3J3++XGfe9q1FmITtudzLBKu7Fkc6Rq66wBmoQ6l7AINKUwVeXtAV7TV0f78szH
	wREiwtgq+HlVy9/Z3Ol8RZvnfFC+CKOhUsyATkWp1th8WQyj33SFCeNvQH0byCg1
	szBXdI+WiRCNszyKaj3u1tAVw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3n3ROYN9pPIBzBg--.58134S4;
	Wed, 15 Apr 2026 17:54:24 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH 2/2] sched_ext: Print sub-scheduler disabled log and reason
Date: Wed, 15 Apr 2026 17:54:18 +0800
Message-ID: <20260415095418.307555-3-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415095418.307555-1-zhaomzhao@126.com>
References: <20260415095418.307555-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n3ROYN9pPIBzBg--.58134S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4fJw17CF4rKr1rZr1DWrg_yoW5Gw4xpF
	s3XrW2yF9Iqa42gan2y395ury5JrZ7Aa42vr1aka92yr1jqrn5Xr48JrySvF98Jr95Jw42
	kr4vg342gF47K3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j40P-UUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqhB+9WnfYFBovAAA3j

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Take scx_qmap for example, when sub scheduler is attached, there is
'BPF sub-scheduler "qmap" enabled' message, but when dettached, the log
is missing. Add a new function to do the log thing, it can be used by
both root scheduler and sub scheduler.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 kernel/sched/ext.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 012ca8bd70fb..229a82900e8f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5526,6 +5526,26 @@ static void scx_disable_dump(struct scx_sched *sch)
 	sch->dump_disabled = true;
 }
 
+static void scx_log_sched_disable(struct scx_sched *sch)
+{
+	struct scx_exit_info *ei = sch->exit_info;
+	const char *type = scx_parent(sch) ? "sub-scheduler" : "scheduler";
+
+	if (ei->kind >= SCX_EXIT_ERROR) {
+		pr_err("sched_ext: BPF %s \"%s\" disabled (%s)\n", type,
+		       sch->ops.name, ei->reason);
+
+		if (ei->msg[0] != '\0')
+			pr_err("sched_ext: %s: %s\n", sch->ops.name, ei->msg);
+#ifdef CONFIG_STACKTRACE
+		stack_trace_print(ei->bt, ei->bt_len, 2);
+#endif
+	} else {
+		pr_info("sched_ext: BPF %s \"%s\" disabled (%s)\n", type,
+			sch->ops.name, ei->reason);
+	}
+}
+
 #ifdef CONFIG_EXT_SUB_SCHED
 static DECLARE_WAIT_QUEUE_HEAD(scx_unlink_waitq);
 
@@ -5696,6 +5716,8 @@ static void scx_sub_disable(struct scx_sched *sch)
 			    &sub_detach_args);
 	}
 
+	scx_log_sched_disable(sch);
+
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, exit, NULL, sch->exit_info);
 	kobject_del(&sch->kobj);
@@ -5707,7 +5729,6 @@ static void scx_sub_disable(struct scx_sched *sch) { }
 
 static void scx_root_disable(struct scx_sched *sch)
 {
-	struct scx_exit_info *ei = sch->exit_info;
 	struct scx_task_iter sti;
 	struct task_struct *p;
 	int cpu;
@@ -5797,22 +5818,10 @@ static void scx_root_disable(struct scx_sched *sch)
 	scx_idle_disable();
 	synchronize_rcu();
 
-	if (ei->kind >= SCX_EXIT_ERROR) {
-		pr_err("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
-		       sch->ops.name, ei->reason);
-
-		if (ei->msg[0] != '\0')
-			pr_err("sched_ext: %s: %s\n", sch->ops.name, ei->msg);
-#ifdef CONFIG_STACKTRACE
-		stack_trace_print(ei->bt, ei->bt_len, 2);
-#endif
-	} else {
-		pr_info("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
-			sch->ops.name, ei->reason);
-	}
+	scx_log_sched_disable(sch);
 
 	if (sch->ops.exit)
-		SCX_CALL_OP(sch, exit, NULL, ei);
+		SCX_CALL_OP(sch, exit, NULL, sch->exit_info);
 
 	scx_unlink_sched(sch);
 
-- 
2.43.0

