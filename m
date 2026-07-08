Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808093F4DCE;
	Wed,  8 Jul 2026 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545885; cv=none; b=Y+N5OJmXBpgWxE/Z+l9pZNyr7WOMFdoj62hARA+5NYwWVAQsCATZ6nwttxg8AHYFtQTfTVcfn08M8HX0rJhxbgYc2rvPS6pu5iwI8Iuuga6aY+wD4UyXXyJrz2afdb7aOO7DqnYFHMyOw8v+lInwNKa2eGXfLYH4KwcYa4ix4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545885; c=relaxed/simple;
	bh=tWSAn+gLPo6QyRKRat7UuxhjP0IUgtl7TOesjwpq0FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGFJhUeF0qU8Bcdj8ymrHpPFfmjPhhlm+klEQlcaSEwKCU6KTcRP52ByLKq/NTxYQ1QSuz1gbzXektMWOxwXqa+AYkO609d69mAQRPvw7MwFKfwFQv7xE0d3mDhF3ZTTETnCHqiMeW5g6IXgvxgoBsJTPdoxwysaugCVbtynil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWZqfBYx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWZqfBYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365501F000E9;
	Wed,  8 Jul 2026 21:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545880;
	bh=eHrouy5BCa2Pc/7gOfuw+oBzpZi8n1ia45HjwfR/J0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bWZqfBYxI+lBcJl0gO+Qizc4NcViH0aWMxt5n70wkVGfZBTfWzntU972t3dU57t3k
	 vT+UjJPCyyn9sEi9OgYxmyy3PkuWXOOV9GH/uyeC0t9OCTQXPVv1Kvdpb8moTIVeqb
	 bLB3qVDg2pLdGjIJgkDScSisNjLi39f5Zn3GzdhBekHqeKmtVpRg1lOjgtOvfFuDbu
	 pgdQJGNXdOObQmJ+qKzAeF7N9dS13PowfpZHcYcM3WxOtH/zNrfklBEJ4+/Rz3YDd3
	 2lmkWxdcAH1iptYE4GiaoPVspa95s2koiEpFK8a4qkEEOXzy0NKWLKMyCSC4D36dPb
	 0SM7oDC3INGyA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 09/40] sched_ext: Make scx_bpf_kick_cid() return void
Date: Wed,  8 Jul 2026 11:23:58 -1000
Message-ID: <20260708212429.3405787-10-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
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

