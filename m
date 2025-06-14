Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45434CDD;
	Sat, 14 Jun 2025 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864229; cv=none; b=qysM2s7sa0U1ixn+/3HpqHeMOE/ROqT9L5VYLVfEjDJPqdmKwIPLLZorDTxCecjHkY1MG2Tkcavn9r+uTapr+8I01Zj8tfxJtlTjPQfjMO5SBIH9zrL8Wd3HYFfM76kTsFEBK2KHGLZ6ljen+WkKny+uIcJAhEvEH4GB/nTjnf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864229; c=relaxed/simple;
	bh=p5V7ULUZiDWy2MxK/Et7kVkKxqEGHUJ4GGhF/sqXqhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUuhKzFJc+KdqvxDMJXyS47PugSPnx+lX7fIRdo8YL2KaNNnxnHlGEQRAZHzg606y9gqPyu2BAelPc0Cujq/eyQFFTgIAuO71Jv60M/hESFmn+Itk0agk6iQK+pBdYDmIrU+VzSnrcLz9B47fhJV271Aa9RBsm0FAVUoAa6xmVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE1MqI/x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE1MqI/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FDAC4CEE3;
	Sat, 14 Jun 2025 01:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864229;
	bh=p5V7ULUZiDWy2MxK/Et7kVkKxqEGHUJ4GGhF/sqXqhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NE1MqI/xR/zo/91hSObT2xKrGav62ankEwmx8th4bDlr9sppct8jXBiXFHLxy5Lhy
	 RyT34uy+WJ3Xm6xcX3Akw7iQrMpmfkJvF/Ppjxu7pKxxIG8d6etUEuCYj5aljodasN
	 BXeQN3tjew6J5n/dAUsQ4eMQGHEpCST5cHWc0hT6wRXDni7YfweDBqvHH2yYUtH6Jj
	 FMFUWyvro6uDGW5oNfv06guea5tpm0orW7fhsTwT1xgdvV4G5kvCfm1dzj7hMqKmIB
	 JdU6/DAblFguot6NGhteiGLOGX+QaG2zzK+A6ebFOugIwkRmgjuonB3p0v8WQTtOxI
	 /ZkoShhO0VsXg==
From: Tejun Heo <tj@kernel.org>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] sched/fair: Move max_cfs_quota_period decl and default_cfs_period() def from fair.c to sched.h
Date: Fri, 13 Jun 2025 15:23:27 -1000
Message-ID: <20250614012346.2358261-2-tj@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614012346.2358261-1-tj@kernel.org>
References: <20250614012346.2358261-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max_cfs_quota_period is defined in core.c but has a declaration in fair.c.
Move the declaration to kernel/sched/sched.h. Also, move
default_cfs_period() from fair.c to sched.h. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/fair.c  | 11 -----------
 kernel/sched/sched.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6b17d3da034a..707be4570430 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5617,15 +5617,6 @@ void cfs_bandwidth_usage_inc(void) {}
 void cfs_bandwidth_usage_dec(void) {}
 #endif /* !CONFIG_JUMP_LABEL */
 
-/*
- * default period for cfs group bandwidth.
- * default: 0.1s, units: nanoseconds
- */
-static inline u64 default_cfs_period(void)
-{
-	return 100000000ULL;
-}
-
 static inline u64 sched_cfs_bandwidth_slice(void)
 {
 	return (u64)sysctl_sched_cfs_bandwidth_slice * NSEC_PER_USEC;
@@ -6405,8 +6396,6 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-extern const u64 max_cfs_quota_period;
-
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c323d015486c..e00b80cd998e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -402,6 +402,19 @@ static inline bool dl_server_active(struct sched_dl_entity *dl_se)
 
 extern struct list_head task_groups;
 
+#ifdef CONFIG_CFS_BANDWIDTH
+extern const u64 max_cfs_quota_period;
+
+/*
+ * default period for cfs group bandwidth.
+ * default: 0.1s, units: nanoseconds
+ */
+static inline u64 default_cfs_period(void)
+{
+	return 100000000ULL;
+}
+#endif /* CONFIG_CFS_BANDWIDTH */
+
 struct cfs_bandwidth {
 #ifdef CONFIG_CFS_BANDWIDTH
 	raw_spinlock_t		lock;
-- 
2.49.0

