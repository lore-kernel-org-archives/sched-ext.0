Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF73128C6;
	Sun,  8 Mar 2026 02:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772937922; cv=none; b=c7zTEz1kpoNdmjXBGYSZZ7zrdL3nYlKnGmxcWBXTJ3grw6wcSbRnhZsWvlx1u2N3MZFaXNTIUYzwlxrIOj/nNsGPDJUSDCDEa3HNdRBPMYfOhRmvSijzUlFGrccmWEYiYLmyVun8mgjLu1xycF21VPIysPvnow7FYHXUyv7GCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772937922; c=relaxed/simple;
	bh=5U0xGGXZS259TWF1/s9ohgtcZyWy3uKpFRfRJsAibnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMJ5GQQWhC7DtmvKrLvVkdHAByiDd1Ow8QN4EtTM+kB2vnsQTlIawp4rAPj5GsP5XEeETl054KoDjUaeifioEdmZXfBa1RmVFtz2pqhuNlWsH5GEGznQf67E/DGSKU40aNnBlqavUay1SnBKAfCSr/+p5iV+MnwfyP38Dja7oCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcK7k8iY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcK7k8iY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E56DC19422;
	Sun,  8 Mar 2026 02:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772937922;
	bh=5U0xGGXZS259TWF1/s9ohgtcZyWy3uKpFRfRJsAibnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FcK7k8iYpx28LfG7H9NgQnRUJ3V1AvWlpVZpfzf1v6XKEHA+AjUKNeBv3FBXLVe7J
	 S0a/gqpb5gbLSDs234leBqWnzmnxSGmS/dNaj0u+p4/1WdKM4AGkF5BgQlu4NlkReq
	 Pf5vHAZo43l2kQnLJ617AHYLHsLb/Cf4FWaqCJxnGqGLBGwyyjUDn9I6qbx0onqMEQ
	 p3brOYpGvdXQ1Md9HOOFIPlXniNEqdnk2AK0n+4vt5YUcE7zgOEFtMTvOna4A1oyT6
	 DC8bs/TUxuIKYknfrqbVQtJtGztgpboBzTup1VC5FoNKd9ZBuVbTQUErYwPQY3BDtg
	 3XmAfQG+kc3PQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] tools/sched_ext/include: Sync bpf_arena_common.bpf.h with scx repo
Date: Sat,  7 Mar 2026 16:45:15 -1000
Message-ID: <20260308024519.1980564-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308024519.1980564-1-tj@kernel.org>
References: <20260308024519.1980564-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync the following changes from the scx repo:

- Guard __arena define with #ifndef to avoid redefinition when the
  attribute is already defined by another header.
- Add bpf_arena_reserve_pages() and bpf_arena_mapping_nr_pages() ksym
  declarations.
- Rename TEST to SCX_BPF_UNITTEST to avoid collision with generic TEST
  macros in other projects.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/bpf_arena_common.bpf.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
index 4366fb3c91ce..2043d66940ea 100644
--- a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
+++ b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
@@ -15,7 +15,9 @@
 #endif
 
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
+#ifndef __arena
 #define __arena __attribute__((address_space(1)))
+#endif
 #define __arena_global __attribute__((address_space(1)))
 #define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
 #define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
@@ -81,12 +83,13 @@
 void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
 				    int node_id, __u64 flags) __ksym __weak;
 void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;
+int bpf_arena_reserve_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;
 
 /*
  * Note that cond_break can only be portably used in the body of a breakable
  * construct, whereas can_loop can be used anywhere.
  */
-#ifdef TEST
+#ifdef SCX_BPF_UNITTEST
 #define can_loop true
 #define __cond_break(expr) expr
 #else
@@ -165,7 +168,7 @@ void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym _
 	})
 #endif /* __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__ */
 #endif /* __BPF_FEATURE_MAY_GOTO */
-#endif /* TEST */
+#endif /* SCX_BPF_UNITTEST */
 
 #define cond_break __cond_break(break)
 #define cond_break_label(label) __cond_break(goto label)
@@ -173,3 +176,4 @@ void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym _
 
 void bpf_preempt_disable(void) __weak __ksym;
 void bpf_preempt_enable(void) __weak __ksym;
+ssize_t bpf_arena_mapping_nr_pages(void *p__map) __weak __ksym;
-- 
2.53.0

