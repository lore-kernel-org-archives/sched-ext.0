Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE53E47D94F;
	Wed,  3 Jun 2026 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507318; cv=none; b=dSTsjeKBt4NZAWbzewMxqdA/fmXIbxp2r3zd/b1+MmcAQugIiIXuNXUOg9Pnz9r0YGBU9gvnFnG1KYemUEEseseT+skRMvp7lVqqt5/MGOGojp6txOn7Z4bZ7TvIQRVAek5nBUOS3e6ueoxPklkpU9BstEey2dm4ymZ2AsKVpx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507318; c=relaxed/simple;
	bh=DvQokXNT62FHYySHr71cdg2RmMOJnHf9W2YEq4F1ZgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnvqov2o8PYonMj1h8b9o4MuCedPynJdT003iQiXG2b885iDxRFQIb8hLw8Yr5SVbolyteClQrkDStZ54oTW67MRkPX966kdJkbdu87suRXzuXYEykMe8EeZ64uqrGi4dzl0DyvsRxW3wu463cZO+XmfNMKf1F23Riy06k9cbV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4OyhS77; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4OyhS77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FEA1F00893;
	Wed,  3 Jun 2026 17:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780507317;
	bh=vkgEtTSHu7h+I7GdIaqJ32wT0J5pJIkANEDuCCv4QX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4OyhS77ygHm+KKV9rtbm0yUzaEJ2eMbVAGHCto1k/NA02mY65UXtiX7ynViK7IXh
	 ZAdyKI9ZXoaMw8xh9UHms+X7ak3PkbKRmq6vT3yES6pLIrpXdQz4NvFnkSoX4IJw8t
	 PKa0y4uiYN4imwF1UW1kdGGXFn/NMMhgeAHWTK+C21oimIA8wgQp/nObMKgIfkdyzg
	 FqW4J7F/N5K/kE8MZsN2cB+YZ3z0n8oeE3JEbixuVtCq7hcTmmFnYxduWf5RVPZMcP
	 epXam8mtHzIX7kOMLv+b6gAkCmMz96Rs+EwUaW9VtAnNnOSGMYOqKM5OwTw3LhhZfx
	 L9VR2Rv+GT0kA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/3] sched_ext: Make scx_bpf_kick_cid() return s32
Date: Wed,  3 Jun 2026 07:21:53 -1000
Message-ID: <20260603172153.3081861-4-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603172153.3081861-1-tj@kernel.org>
References: <20260603172153.3081861-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch scx_bpf_kick_cid() from void to s32 so future cap enforcement can
surface failures. cid interface is introduced in this cycle and has no
external users, so the ABI change is safe. Subsequent patches will add
-EPERM returns when the calling sub-sched lacks the required cap on the
target cid.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                       | 13 ++++++++-----
 tools/sched_ext/include/scx/common.bpf.h |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 32ebbc351564..fedd501de67e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9405,9 +9405,10 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
  * @flags: %SCX_KICK_* flags
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
- * cid-addressed equivalent of scx_bpf_kick_cpu().
+ * cid-addressed equivalent of scx_bpf_kick_cpu(). Return 0 on success,
+ * -errno otherwise.
  */
-__bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
+__bpf_kfunc s32 scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
 {
 	struct scx_sched *sch;
 	s32 cpu;
@@ -9415,10 +9416,12 @@ __bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
 	if (unlikely(!sch))
-		return;
+		return -ENODEV;
 	cpu = scx_cid_to_cpu(sch, cid);
-	if (cpu >= 0)
-		scx_kick_cpu(sch, cpu, flags);
+	if (cpu < 0)
+		return -EINVAL;
+	scx_kick_cpu(sch, cpu, flags);
+	return 0;
 }
 
 /**
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 5f715d69cde6..9591a6e778ce 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -105,7 +105,7 @@ void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __
 s32 scx_bpf_cpu_to_cid(s32 cpu) __ksym __weak;
 s32 scx_bpf_cid_to_cpu(s32 cid) __ksym __weak;
 void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out) __ksym __weak;
-void scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
+s32 scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
 s32 scx_bpf_task_cid(const struct task_struct *p) __ksym __weak;
 s32 scx_bpf_this_cid(void) __ksym __weak;
 struct task_struct *scx_bpf_cid_curr(s32 cid) __ksym __weak;
-- 
2.54.0

