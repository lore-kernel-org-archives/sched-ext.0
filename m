Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E215261B8D;
	Tue, 11 Nov 2025 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888704; cv=none; b=jgVVan19AmbZG+yg51t5IbvOrQuHJk45pupzTI1Cx6VpS2xKZa65yVI1SdGv37jMQRA1q9snE/kVb1/PHiyS5Xha+WUqirVfn6tvFZ0aKpzGUDkoD6D+z8PE4ulrZYAA9aqijw17EVNf3N7RRNVn5xyCCHHttF2OpzH58unWuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888704; c=relaxed/simple;
	bh=vcvYchVdgxL+DU/MXUX3PAFZjptbDISFJLnpHeS1VDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiHEk36s3BSz9dqTTi91uJrcLvYq+RuFRxGwNovNMvI4Vn3jl7ZZhBjtjIHCjiOJPMlV9istZ1Y3kkB3W9fdLO9vAIZ2nhm+dGyhmmmz1rF0cL5EwFEj3H5F6ZSDqEBh9WBdMKtmkP2vKJEtIGhSEiWZsqXyhymqDdr5vHclPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COOF52aE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COOF52aE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35ACC16AAE;
	Tue, 11 Nov 2025 19:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888704;
	bh=vcvYchVdgxL+DU/MXUX3PAFZjptbDISFJLnpHeS1VDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COOF52aEXD0UNBnjLdx/oA3bBCTFYX4RYdVStDjbwAhdE2SbIXW34hAC/2JYesEwU
	 MgX4G5mcUP4rjoJfmSzuX5vI5OODI1+QS5PLOQc3Zqq8Sbg7CSZdZE5Zzv2JjJjb9O
	 cbUUAZ6jH71ANdNiJgAajbX5a8bBRg3/4sEIMWuBWlbyuPvXJSZFm/ed9SIsvurO5Q
	 iPvsQca8c/KV8GkcB4f8eKrppc0eYg0FQuySPZ+FzAUz9R4akts1ut+kjKuTndgAof
	 axkskKVLD9aIADWzxKQW8JfVgy7VwO0yQVrTsVV5c86VGZHBO8ovnBJzp0ZIZVznxS
	 nr1PpUs3QMLdg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH 06/13] sched_ext: Make scx_exit() and scx_vexit() return bool
Date: Tue, 11 Nov 2025 09:18:09 -1000
Message-ID: <20251111191816.862797-7-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111191816.862797-1-tj@kernel.org>
References: <20251111191816.862797-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make scx_exit() and scx_vexit() return bool indicating whether the calling
thread successfully claimed the exit. This will be used by the abort mechanism
added in a later patch.

Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 56a6d453543a..e6e69a7fe105 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -174,18 +174,21 @@ MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]
 static void process_ddsp_deferred_locals(struct rq *rq);
 static u32 reenq_local(struct rq *rq);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
-static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
+static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
 		      s64 exit_code, const char *fmt, va_list args);
 
-static __printf(4, 5) void scx_exit(struct scx_sched *sch,
+static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
 				    enum scx_exit_kind kind, s64 exit_code,
 				    const char *fmt, ...)
 {
 	va_list args;
+	bool ret;
 
 	va_start(args, fmt);
-	scx_vexit(sch, kind, exit_code, fmt, args);
+	ret = scx_vexit(sch, kind, exit_code, fmt, args);
 	va_end(args);
+
+	return ret;
 }
 
 #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
@@ -4400,14 +4403,14 @@ static void scx_error_irq_workfn(struct irq_work *irq_work)
 	kthread_queue_work(sch->helper, &sch->disable_work);
 }
 
-static void scx_vexit(struct scx_sched *sch,
+static bool scx_vexit(struct scx_sched *sch,
 		      enum scx_exit_kind kind, s64 exit_code,
 		      const char *fmt, va_list args)
 {
 	struct scx_exit_info *ei = sch->exit_info;
 
 	if (!scx_claim_exit(sch, kind))
-		return;
+		return false;
 
 	ei->exit_code = exit_code;
 #ifdef CONFIG_STACKTRACE
@@ -4424,6 +4427,7 @@ static void scx_vexit(struct scx_sched *sch,
 	ei->reason = scx_exit_reason(ei->kind);
 
 	irq_work_queue(&sch->error_irq_work);
+	return true;
 }
 
 static int alloc_kick_syncs(void)
-- 
2.51.2

