Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312941;
	b=nVcbkfkp06FbLtrvmhzdW37sgo9gesj8m5jG/z7kqIUQn8nmrOe6PqGqEPWTQgy/lTuQ
	 RmwpATAruUNdNwljiHkoc07UYnPXntLHbO7sBJCU6jd3JNWqVy6/t4nRS5hBFoYOj9UQS
	 tJiz4Xd1V8gzto+HqQjJDBMbiUv8U+LxJgeAAv48mINwFqclWUzrS6dtkZUrWNLgr3eBH
	 UZGFW6ASLj7owkZsDafbPdAKSvX5PznubMCcNgAOtWlQqjluoyyvECNGWn7hduYL5hHTR
	 AKWMrLdTEQ37sW0ZmHexvTwzWVKIKAymHScTK278ha36MsPMcMd4Aw22xlC2dDGU03w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312941;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dSrpTbE1dXj8nR6ORHha8WKfVNKmiBLbPt6AXTRxS08=;
	b=ECqMTwjloWOSzQe3F1/2Uaa5SYXW6x3kr4qaHPh5gVHZvNVkfYNIYPYJnJlX0f44tcZu
	 HYmgi1a14mxsuPZhU7r8sJ8s4makU25ldu1Y7kb2FqtEJtvU79mROyiFdP8xaWQGPbEf4
	 +Js5FMslqCmnxWDlIo142eUitwy1OTIGGOKOjel0kv2nON5JZ9no78gZc8Dp1PPrytp/M
	 lFlYOFySfzJauVvrytCh+VAORTkZzcgJYqEhI1klXqs1/H/aJG11e4AU9fpmQwe0qqQPP
	 05fA4KxKGCeCTHFVMXoSejzSG8cVrgkPGTz6rLQISRxdZRKHDR8JAOgDukzf0pwqPeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrqP4l0k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3582606A31A;
	Thu, 29 Oct 2026 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrqP4l0k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DDB1F01816;
	Thu, 29 Oct 2026 22:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793312940;
	bh=dSrpTbE1dXj8nR6ORHha8WKfVNKmiBLbPt6AXTRxS08=;
	h=From:To:Cc:Subject:Date;
	b=KrqP4l0kM+9lUuj8Oxd4jiLpRZFtxF5lJ6H/17R4ckdd6XJ4AL4VqW1876PAIuQtB
	 t1yU5ngmugDtTFceVuCyoLKX/QU9r5Jy/wuh9beQ3lHhjW9TrQzm10ksumwZ6fC6Ei
	 F8gUPq+pLK0VOVqL9kCgL5DA2ng7QzGIxBKqKw7wwDWQGd6DHunYvjGwLmdQH1z5w8
	 Qxyi8QqdnjykdWuPzmbkV3909d0FWnke1sQMtq8Xlgy0VxhfTXelgQWe+/9+SuviP8
	 zp71UHNpHhl9Vo5raq69HcOLAyz4Ai5Gb8frMUXjDm9ckTyaK+LCcW3DNNg8M9BifV
	 H9v/QSaVgamUw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.4-fixes] sched_ext: Call ops.sub_attach() only while the cgroup is online
Date: Thu, 29 Oct 2026 12:28:59 -1000
Message-ID: <20261029222859.3099324-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parent's ops.sub_attach() runs before the enable work checks that the
cgroup is still online, so the parent can get an attach for a cgroup whose
rmdir already returned. That complicates parents where cgroup cleanup and
sub-scheduler attach race.

Check CSS_ONLINE and call ops.sub_attach() under cgroup_lock(), so that the
parent sees an attach only for a cgroup that is online.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/internal.h |  4 ++++
 kernel/sched/ext/sub.c      | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index ff0a3d508533..58652370da5a 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -869,6 +869,10 @@ struct sched_ext_ops {
 	 * @sub_attach: Attach a sub-scheduler
 	 * @args: argument container, see the struct definition
 	 *
+	 * The sub-scheduler's cgroup is online for the whole call. If it goes
+	 * offline after the sub-scheduler is accepted, ops.sub_detach()
+	 * follows.
+	 *
 	 * Return 0 to accept the sub-scheduler. -errno to reject.
 	 */
 	s32 (*sub_attach)(struct scx_sub_attach_args *args);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index b5d92d89629b..6bc6b93ca63a 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -2340,8 +2340,21 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		.cgroup_path = sch->cgrp_path,
 	};
 
+	/*
+	 * The cgroup stays online across ops.sub_attach(), so the parent never
+	 * sees an attach for a cgroup that rmdir already removed.
+	 */
+	cgroup_lock();
+	if (!(cgrp->self.flags & CSS_ONLINE)) {
+		cgroup_unlock();
+		scx_error(sch, "cgroup is not online");
+		ret = -ENODEV;
+		goto err_disable;
+	}
 	ret = SCX_CALL_OP_RET(parent, sub_attach, NULL,
 			      &sub_attach_args);
+	cgroup_unlock();
+
 	if (ret) {
 		ret = scx_ops_sanitize_err(sch, "sub_attach", ret);
 		scx_error(sch, "parent rejected (%d)", ret);
-- 
2.56.0

