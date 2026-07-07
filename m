Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB454D8CE;
	Tue,  7 Jul 2026 00:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383177; cv=none; b=G+P93nPIyC2AV/r/+48nI2F4fPs6KLa/hBJa1e9LXSB3/ZMuuIpDEjo83VdrmxDWGVULj4IdvnWKHhaTUP34Nko7zBuQxY42OoZjP7P7BoPC0jpZwO966rhXBdAjP/aOmdjsTsWKE9h0p9hUmSwJSwRhIxjHObtrzoBgULO+pU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383177; c=relaxed/simple;
	bh=RWBcWqsHDSfvnqG8vKccaC55lhnBod6r9WMszaf+bS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkX0ATVJru7JLT8W6hhnjBxTp6E9iWzRN8bd0BpmM2mAZBkmXFuT7f6w3cg5IMAQvXT1IOylDBLGtzgl0aVkb30x9RMz43hrWs3Hn99gQ8PO9ywpTy95ffWQI9YjsK2uTppH3/4D04TWOkba0clo9fYv84xQHs6tDsPlxXZ9DQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idljy00r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idljy00r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4E81F00A3D;
	Tue,  7 Jul 2026 00:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783383175;
	bh=3j+qRx4i2Y8qF35jVGC0t3XjR9a5bkOdx+pXpy1ygWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Idljy00rpClSzqON1tMAhYi3FllL9AxVFiSB6DsEEzn3M3YB57DAz0aIng/D4p170
	 MzgQ5k8mU6iyrTx+PokioB66V7xmdnklouviCqQVrvc1CWY9Fa63/hG3MU/DwJdJfl
	 ExNeo1ONmo26qGWCxESDp8XTdQKqtpKWMPFlizQKnSQ9oQ+Df7jd4mB7kKlKNKaFzS
	 mlqE9xZar7ik/PuEwgsuo/3rQ2oBSBMFdoJpd93TZBfsDRWoX64Fk+xZDfxF2WzN1u
	 GPvZVHQaInijj9VxGbPdIyks0GXf5GWNaiyeVg1mRJv7lP4sKQizS7AJNO6lm/2xup
	 lvj/rV24Htx0w==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 sched_ext/for-7.3 26/36] sched_ext: Assign a unique id to each scheduler instance
Date: Mon,  6 Jul 2026 14:12:19 -1000
Message-ID: <20260707001229.1410929-27-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707001229.1410929-1-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Neither a scx_sched pointer nor its cgroup id uniquely identifies a
scheduler instance. A freed sched's memory can be reallocated, and a cgroup
can detach one sched and attach another. Add a monotonic, never-reused u64
id. A later patch compares it to drop a slice request that outlived a change
of a task's owning scheduler.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 4 ++++
 kernel/sched/ext/internal.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index d4e4340fdcd8..d6584ac030bb 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -108,6 +108,9 @@ static bool dsq_is_rq_owned(struct scx_dispatch_q *dsq)
 	}
 }
 
+/* Cursor for unique scx_sched instance ids. id 0 is reserved. */
+static atomic64_t scx_sched_id_cursor = ATOMIC64_INIT(0);
+
 #ifdef CONFIG_EXT_SUB_SCHED
 /*
  * The sub sched being enabled. Used by scx_disable_and_exit_task() to exit
@@ -6450,6 +6453,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		       level * sizeof(parent->ancestors[0]));
 	sch->ancestors[level] = sch;
 	sch->level = level;
+	sch->id = atomic64_inc_return(&scx_sched_id_cursor);
 
 	if (ops->timeout_ms)
 		sch->watchdog_timeout = msecs_to_jiffies(ops->timeout_ms);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 5d4edd505ed1..0f3d98c19f7a 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1444,6 +1444,9 @@ struct scx_sched {
 
 	struct list_head	all;
 
+	/* unique instance id, monotonic and never reused */
+	u64			id;
+
 #ifdef CONFIG_EXT_SUB_SCHED
 	struct rhash_head	hash_node;
 
-- 
2.54.0

