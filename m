Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A037BE7D;
	Mon,  6 Jul 2026 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302070; cv=none; b=KSCekjkji4lF+C/4xQGRoJaXeD9BUlHf4UG14hmihiQ3LEodKmp5J2ObeCkJKF2/QWCcnVGhSWrDTYfJJxHoWToeg4y74f9nEATCJo64FyzJ4lQmObQheUGUwObWIOK57bbTV6zJgLLI1Vogqrm8/PB43oj3kZ6v9LX0iY8kkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302070; c=relaxed/simple;
	bh=tWSAn+gLPo6QyRKRat7UuxhjP0IUgtl7TOesjwpq0FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgSqRxkB73aEvA00qQSZIVy1oGS2kRYbwDo1IahDnp42sM5CZ83YbQhbJdhEvAhIT88YUo0lHf8aLFviMJ5bIVYpN0xOZBjuN3xJZi/2BR8AJaRBPUfyK3LmlonQYfWzzB2CTiTA2/uB1yzI8W+e3ARu5Pu4JinwrTe4e9ldDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/Lb4l6q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/Lb4l6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C33B1F00A3A;
	Mon,  6 Jul 2026 01:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302067;
	bh=eHrouy5BCa2Pc/7gOfuw+oBzpZi8n1ia45HjwfR/J0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D/Lb4l6q4NTtrCo1Hxj6UaqyriePLyEodKmXXIMgHUZJF/jJAmrZEeV8nfCFsmNGC
	 yGW84TpT9VOuVQqJ42JJ7dZM6KUGd52XKHsEwEaCDoW+xCK0nuTK0/kT7G9C72iqW9
	 sSCk9X8W4oe0a0uq2WnikjwmquvNEDEwxaOyL5lmJdZ4Yn7XnfIjLXYoduMbia14H7
	 pHt4XtXgfY1fFueCbONMYUreUsO33vuQgeQbylpa4t0fbnmswfhbmPIyxL3Hp3eZP0
	 zKFUScptEXHFwvqKgN+ERf+HPn9QygQkxYXT4dL3jWIu5/oYJYY3L3EqaXpCjSP2/z
	 tO5KMAwH0Crug==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 08/36] sched_ext: Make scx_bpf_kick_cid() return void
Date: Sun,  5 Jul 2026 15:40:30 -1000
Message-ID: <20260706014058.439853-9-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_kick_cid() returned an error code, but the value conveys nothing
actionable and no caller consumes it. The kick is asynchronous, so a
successful return only means it was queued. An invalid @cid is already
reported through scx_error() by scx_cid_to_cpu(), and a missing scheduler
leaves nothing to kick.

Make scx_bpf_kick_cid() return void to match scx_bpf_kick_cpu(). The
cid-form kfuncs are not in practical use yet, so the ABI change is safe.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c                   | 11 +++++------
 tools/sched_ext/include/scx/common.bpf.h |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index bd3cb59b1dbf..187754d0c3c8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8533,10 +8533,10 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
  * @flags: %SCX_KICK_* flags
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
- * cid-addressed equivalent of scx_bpf_kick_cpu(). Return 0 on success,
- * -errno otherwise.
+ * cid-addressed equivalent of scx_bpf_kick_cpu(). An invalid @cid aborts the
+ * scheduler via scx_cid_to_cpu().
  */
-__bpf_kfunc s32 scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
+__bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
 {
 	struct scx_sched *sch;
 	s32 cpu;
@@ -8544,12 +8544,11 @@ __bpf_kfunc s32 scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
 	if (unlikely(!sch))
-		return -ENODEV;
+		return;
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
-		return cpu;
+		return;
 	scx_kick_cpu(sch, cpu, flags);
-	return 0;
 }
 
 /**
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index bd51986c4c42..e7b3ba491c5e 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -104,7 +104,7 @@ void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __
 s32 scx_bpf_cpu_to_cid(s32 cpu) __ksym __weak;
 s32 scx_bpf_cid_to_cpu(s32 cid) __ksym __weak;
 void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out) __ksym __weak;
-s32 scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
+void scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
 s32 scx_bpf_task_cid(const struct task_struct *p) __ksym __weak;
 s32 scx_bpf_this_cid(void) __ksym __weak;
 struct task_struct *scx_bpf_cid_curr(s32 cid) __ksym __weak;
-- 
2.54.0

