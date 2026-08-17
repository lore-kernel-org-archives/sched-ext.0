Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4904432FE;
	Mon, 17 Aug 2026 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977113; cv=none; b=WetM7qdw30YaOuYAISbY346qBEkmerw3O9kxYdnaI8pA17TaRwO8vbH1kb2d5CyIt5XwpI49I5cqOoZfs9dSynw54fy2F+xtVtb1p/01BhbCDLVJG4LEQtgDb1Hlzvklcge2oD4E8k3hgwZaqn9hUWD6QFr88VTc0U7HRva4+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977113; c=relaxed/simple;
	bh=zrUJzhpnlXLVnFkqfPcF4LST9uOIgpAzdeSqFCZ01As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P53mjIZI9jE7GHLx+LAmsG6au8Sh5zRBGEbacn5U1mdY0SmfclnwYWDuedE7TjGCc/CGAARkCxhqZQ+RS7Ojc/44MJvCZ6Gm06GfXW8xvBMr+s541GyEtACt27ob+DGiCcEO531wo95rddIU7PNw2QR7AXToloM3puIbFjbyV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Q207Nj76; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q207Nj76"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=hP//wKAQV3uEOAjGKWED5jJsXM3myIIhDRnVw0xciEE=; b=
	Q207Nj766q9d7rqQ7L3e8iDpjvUTnPcz4BlE4nEOOftUURch/vwRsyPlplOXf3uXenUu9UPH7aXWr
	wjUQtW8EUngChSXgZMzgMllFBsqN4NQqfSvJhf6GO7CQEScMw4ev8NOvsuWZEiBZsPuR1X8wvmunm
	aTA0vH+goGuinWF3kKg07HUAX2/PRSwfsjgh6KrVWpPFjmUnv0IvaAaNyPD0npO611y0HvHzlaAHe
	C0sRj+oZp4qb2RcXp/oD2jl7fgVM3paGULjSX7jMTr1m7jxzB6YUcX4RqOe2tmm/j6gEc7fApLrtO
	Eaz5T+xkatFxhygiP6RwlMH/V14SnVzKsg==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wvyNM-004Zyj-H6; Mon, 17 Aug 2026 16:31:45 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: gavinguo@igalia.com,
	kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] compat.bpf.h: add scx_bpf_reenqueue_local_from_anywhere() compat helper
Date: Mon, 17 Aug 2026 23:31:26 +0900
Message-ID: <20260817143126.562923-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817143126.562923-1-changwoo@igalia.com>
References: <20260817143126.562923-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_reenqueue_local()'s generic compat wrapper inlines a v1 fallback
that is only callable from ops.cpu_release, and veristat rejects it on
kernels without v2. Callers draining a local DSQ from an arbitrary
context (e.g. a tracepoint) must gate on a call-from-anywhere kfunc
directly.

Add scx_bpf_reenqueue_local_from_anywhere() to compat.bpf.h to
encapsulate that: call a call-from-anywhere kfunc when present and return
0, else return -ENOTSUP so the caller knows the drain did not run. Two
kfuncs qualify -- the v7.1 generic scx_bpf_dsq_reenq(), which will
eventually deprecate scx_bpf_reenqueue_local(), and the v6.19 v2
reenqueue-local variant. Prefer the generic one; v1 cannot be called from
anywhere, so it maps to -ENOTSUP. scx_bpf_reenqueue_local() itself grows
the same generic-first preference, and the scx_bpf_dsq_reenq___compat
declaration and __COMPAT_has_generic_reenq() helper move above the v6.19
block so both wrappers can use them.

Test each ksym in its own branch: ORing two bpf_ksym_exists() checks
folds into a bitwise OR of the two weak ksym addresses, which the
verifier rejects.

No functional change intended.

Suggested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Changwoo Min <changwoo@igalia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/compat.bpf.h | 39 ++++++++++++++++++------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 03976f5851d9..55f118e40545 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -383,6 +383,17 @@ static inline void scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
 		p->scx.dsq_vtime = vtime;
 }
 
+/*
+ * v7.1: New scx_bpf_dsq_reenq() that allows re-enqueues on more DSQs. This
+ * will eventually deprecate scx_bpf_reenqueue_local().
+ */
+void scx_bpf_dsq_reenq___compat(u64 dsq_id, u64 reenq_flags) __ksym __weak;
+
+static inline bool __COMPAT_has_generic_reenq(void)
+{
+	return bpf_ksym_exists(scx_bpf_dsq_reenq___compat);
+}
+
 /*
  * v6.19: The new void variant can be called from anywhere while the older v1
  * variant can only be called from ops.cpu_release(). The double ___ prefixes on
@@ -400,21 +411,31 @@ static inline bool __COMPAT_scx_bpf_reenqueue_local_from_anywhere(void)
 
 static inline void scx_bpf_reenqueue_local(void)
 {
-	if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
+	if (__COMPAT_has_generic_reenq())
+		scx_bpf_dsq_reenq___compat(SCX_DSQ_LOCAL, 0);
+	else if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
 		scx_bpf_reenqueue_local___v2___compat();
 	else
 		scx_bpf_reenqueue_local___v1();
 }
 
-/*
- * v7.1: New scx_bpf_dsq_reenq() that allows re-enqueues on more DSQs. This
- * will eventually deprecate scx_bpf_reenqueue_local().
- */
-void scx_bpf_dsq_reenq___compat(u64 dsq_id, u64 reenq_flags) __ksym __weak;
-
-static inline bool __COMPAT_has_generic_reenq(void)
+static inline int scx_bpf_reenqueue_local_from_anywhere(void)
 {
-	return bpf_ksym_exists(scx_bpf_dsq_reenq___compat);
+	/*
+	 * The generic reenq kfunc and the v2 reenqueue-local variant can both be
+	 * called from anywhere; v1 cannot. Test each ksym in its own branch with a
+	 * distinct call: combining them with || would fold into a bitwise OR of the
+	 * two ksym addresses, which the verifier rejects.
+	 */
+	if (__COMPAT_has_generic_reenq()) {
+		scx_bpf_dsq_reenq___compat(SCX_DSQ_LOCAL, 0);
+		return 0;
+	}
+	if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere()) {
+		scx_bpf_reenqueue_local___v2___compat();
+		return 0;
+	}
+	return -ENOTSUP;
 }
 
 static inline void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags)
-- 
2.55.0

