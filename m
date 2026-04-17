Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8A13C9C4
	for <sched-ext@lists.linux.dev>; Fri, 17 Apr 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776417533; cv=none; b=E0MRkjTDG8Tyq7zHCk/0FCfCXpARC+1qJetuKeAkDzTSziuNaDl+30nhc/D61ABT44cEAJhfMdAk9Ou2Ii8j2PE7rVvCBnojzQU3G+PzyFgQIL0W2W7TxaLZ2Y2ikg+B5fKsqbMSQHCqgMzQaco+Mnlg7OuG0sqMnb6sCw7Isfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776417533; c=relaxed/simple;
	bh=UwyksRQ5c86mTTQO9xPq2ziGF9I5fXhPtUbjvh0yeIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cq76zz/9b5BDKRU1VPwnUb2m3A+RtQbEXozPTp342wt7X71HOsfwflZT983/ezJWribqMQVCYyN9Rc3PWrgaVzTM8bcthfOGFIG5Zz7FCHfFVHNvObZ4+WACXmaXHSeM7nbya34BPp5teIp+n8fjjLewNcxBD0IqkPsrGNhaJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Npiq7GaR; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Npiq7GaR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=/G/stN75FhQaLePcl6XX1ad6ZHRO1Odyb/Yxm3VQH8M=;
	b=Npiq7GaROm4BGatvDJeAc3GPK1kfXuu67PVjw9Gv2bdtyxBZZjLwilqWjTjDl1
	ySlZ3Izl5TTFLYpc39hrCzrC1FIlt9GJpDGkLgBIgFNvfHUK1gLJKO/gv/V9uG0Z
	mRrNDkSPWU1peCaDalagSMzaC/qDg0Fk4nV5HKAw3ocH0=
Received: from [127.0.1.1] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3l+jY+uFpMSmcBg--.7149S4;
	Fri, 17 Apr 2026 17:18:17 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
Date: Fri, 17 Apr 2026 17:18:03 +0800
Subject: [PATCH v3 2/2] sched_ext: Print sub-scheduler disabled log and
 reason
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-sched_ext-0417-v3-2-e11b3aed57d3@kylinos.cn>
References: <20260417-sched_ext-0417-v3-0-e11b3aed57d3@kylinos.cn>
In-Reply-To: <20260417-sched_ext-0417-v3-0-e11b3aed57d3@kylinos.cn>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Zhao Mengmeng <zhaomengmeng@kylinos.cn>, 
 Cheng-Yang Chou <yphbchou0911@gmail.com>
X-Mailer: b4 0.15.2
X-CM-TRANSID:_____wD3l+jY+uFpMSmcBg--.7149S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4fJw17CF4rKr1rtr1UWrg_yoW5XF17pF
	s3XrW7tF9Fqay2gan2y395ury5JrZ7A342vr1aka9Fyr1jqr1rXr48JryIvF98Jr95Jw42
	kr4vgw12gF4UK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqxrHP2nh+toy8QAA3i

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Take scx_qmap for example, when sub scheduler is attached, there is
'BPF sub-scheduler "qmap" enabled' message, but when detached, the log
is missing. Add a new function to do the log thing, it can be used by
both root scheduler and sub scheduler.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
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

