Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE20439F71;
	Mon, 17 Aug 2026 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977107; cv=none; b=r0zyGPJ7jQrEBk4ouY8pS2AhxL9ChFEpO0WBQ0QOncqmyP27Wh5ctsPjHz/yRM0o+afNZyFGJ3YICvSctnX1IYr8Epw8jxcd1WH+NH9v1LzNXnHImGq5ylvh1r7XaBnyMR3A239ogxPLRruN11kyX7Kh+mruHBF91vCd8vWR17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977107; c=relaxed/simple;
	bh=MxiHXBIhiR1FI2gfpS6C2vsSaaQBoNQz0JT+lg+gbNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoT5UWnVoZ1HPrJvaijLsn6sRmL1RoJ5R4wx/6N8LrapxN6ycxQxykHkUrdNZLWbQfLAOfVRZ9iZ0ogrOb/m1WhmpdTCuWrwL5KbcpwLGnPVd9nXKbzMaSPxfEGDb+DiLMLPSKCGHsscIJ76BBF0X5cCPYaQEtiT8W0RohhuArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XmIGms/G; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XmIGms/G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=w5iXU/N+YYn28QNVUEueSF3SrmtkOJMPjyresmGOZYA=; b=
	XmIGms/GLkJDAe3bUSvxQiBVZn4TSARt0DZa6S0wms+bAZ6jaRa/e8hzMqxewrEYLEFEkAXFPqOVs
	u/12AhUXyB53K/8Nd90767KAFcF0WR1Q+Rj/UO2cK67RcjCCxFVKkTVRsszq6HVtv+v8+DfTbs2t8
	eJyj+8wQgsAUOt58ScaRy6UcB4MIK1Dra2eEdAyXe5k2L+8tWEwPNKdVF4t5uJoZjQvoaxW0b92rN
	UkL/FQxTnlyIKM8WF+nCTYZXkKZ5+eAvM41Wi6gxFi0lzhGA/fmWVU8fws0dhKVUMpAmueGLCThqW
	OAa47K+JDuLfp7HK7WEVELxnr3bZGxUp6A==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wvyNG-004Zy3-GW; Mon, 17 Aug 2026 16:31:39 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: gavinguo@igalia.com,
	kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] compat.bpf.h: Gate scx_bpf_dsq_peek kfunc behind kernel version 7.1.0
Date: Mon, 17 Aug 2026 23:31:25 +0900
Message-ID: <20260817143126.562923-2-changwoo@igalia.com>
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

From: Gavin Guo <gavinguo@igalia.com>

__COMPAT_scx_bpf_dsq_peek() selects the lockless kfunc whenever the
symbol resolves in the kernel BTF. However, its lockless implementation
could return a stale task_struct pointer. The stale pointer issues are
resolved only after v7.1 kernel with the following patches:

commit 2f2ea7709266 ("sched_ext: Use dsq->first_task instead of list_empty() in dispatch_enqueue() FIFO-tail")
commit 71d7847cad44 ("sched_ext: Fix scx_bpf_dsq_peek() with FIFO DSQs")

Require bpf_ksym_exists(scx_bpf_dsq_peek) AND LINUX_KERNEL_VERSION >=
KERNEL_VERSION(7, 1, 0) before calling the kfunc to mitigate the issue;
otherwise fall through to the existing bpf_iter_scx_dsq path instead.

See also the lavd patch, working around the bug by avoiding calling
the kfunc when unnecessary and having more context explanation:
ac863374ce4f ("scx_lavd: Gate dsq_peek_task_load behind no-fast-lb")

Signed-off-by: Gavin Guo <gavinguo@igalia.com>
Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/include/scx/compat.bpf.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 3ab642f92c8a..03976f5851d9 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -92,15 +92,20 @@ int bpf_cpumask_populate(struct bpf_cpumask *dst, void *src, size_t src__sz) __k
 
 /*
  * v6.19: Introduce lockless peek API for user DSQs.
+ * v7.1:  Resolve the stale pointer issue of the lockless peek API.
+ *
+ * The kfunc exists on earlier kernels but its lockless implementation could
+ * return stale task pointers. Require kernel version >= 7.1.0 before calling
+ * it; otherwise fall through to the bpf_iter_scx_dsq fallback below.
  *
- * Preserve the following macro until v6.21.
  */
 static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
 {
 	struct task_struct *p = NULL;
 	struct bpf_iter_scx_dsq it;
 
-	if (bpf_ksym_exists(scx_bpf_dsq_peek))
+	if (bpf_ksym_exists(scx_bpf_dsq_peek) &&
+	    LINUX_KERNEL_VERSION >= KERNEL_VERSION(7, 1, 0))
 		return scx_bpf_dsq_peek(dsq_id);
 	if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0))
 		p = bpf_iter_scx_dsq_next(&it);
-- 
2.55.0

