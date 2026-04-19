Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF06DCE1;
	Sun, 19 Apr 2026 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615534; cv=none; b=N1a1BZMGn6zYuacQycahN9sc9ivh7MmDv4RqzgFXFPnTR36T6Rc6NC0K6l+FrhZxJ+nK1Cd33RCVJggPJhRTYJPiCsOMlxon9v5K2H/A0AEEz6FdJv425W+BBSbW8LqFmo7/6Kr6fWhTtS6gDZITvMclkHp8+HIe5wqXJwE60zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615534; c=relaxed/simple;
	bh=beOyohRE8VULu8jwTBTLt685jL408kRf3prLZt0G/hs=;
	h=Date:Message-ID:From:To:Cc:Subject; b=twisq/yidEr8SObzsVQdJU0LBuXmLT5pI0DlhU7DkOMDtEDIbSca14mNmckFNOjRg2TscE4xuaONHCyk60nzNpF4+jGnbNIuxbSJvbK29No9cLJS/HC8WiI8QOfcDp4wuOGbny7mx/vQQJ7NGdrVRyCCll47Ci8VSbf+danTPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drHm3Kq9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drHm3Kq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D8DC2BCAF;
	Sun, 19 Apr 2026 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776615533;
	bh=beOyohRE8VULu8jwTBTLt685jL408kRf3prLZt0G/hs=;
	h=Date:From:To:Cc:Subject:From;
	b=drHm3Kq9D+4/Y/8N7F8aZwsju37rpnnpeuNTsvKN4ZOsYXt/V5ifI/Y1muNAGEjca
	 QLLj36WkAzwYtxf/E9fusFIClO1XTzgMh8Y490Ewp7+7epKj+EN2soH7sdX89ofVGo
	 eRJgFpLItd07RdcNm1/12uaFZ9n2ApSjqXXEz8Kip2A7HcRwgcY/EbLDw53Japryji
	 G6dwKyUeL0OI4l367ZsqkPlfK1E6he85X8p17DIYBO/utOSS+LB8MQtHF/7NuLueyf
	 csg1WFZae8bivUV7XuD7w3Sq1wXJ3ekV4EGJ/It0zB6xb1hoFEfSEZeRsZGQBb2UMe
	 52Kwd9fUyyU4A==
Date: Sun, 19 Apr 2026 06:18:52 -1000
Message-ID: <75aaaf7a4dd540191bd8550dd181528b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.2] sched_ext: Document the ops compat strategy
 in compat.h/compat.bpf.h
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The comments around SCX_OPS_DEFINE() and SCX_OPS_OPEN() were vague about
how backward compatibility actually works. Expand them to describe the two
mechanisms: load-time BTF fix-up for additive changes, and multi-variant
struct_ops for incompatible ones.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/compat.bpf.h |    6 ++++--
 tools/sched_ext/include/scx/compat.h     |   23 +++++++++++++++++++----
 2 files changed, 23 insertions(+), 6 deletions(-)

--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -423,8 +423,10 @@ static inline void scx_bpf_dsq_reenq(u64
 }
 
 /*
- * Define sched_ext_ops. This may be expanded to define multiple variants for
- * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
+ * Define sched_ext_ops. See compat.h::SCX_OPS_OPEN() for how backward
+ * compatibility is handled (this macro can be expanded to emit multiple
+ * variants for incompatible op changes; SCX_OPS_OPEN() handles purely
+ * additive changes at load time).
  */
 #define SCX_OPS_DEFINE(__name, ...)						\
 	SEC(".struct_ops.link")							\
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -149,10 +149,24 @@ static inline long scx_hotplug_seq(void)
 }
 
 /*
- * struct sched_ext_ops can change over time. If compat.bpf.h::SCX_OPS_DEFINE()
- * is used to define ops and compat.h::SCX_OPS_LOAD/ATTACH() are used to load
- * and attach it, backward compatibility is automatically maintained where
- * reasonable.
+ * Open the sched_ext_ops skeleton.
+ *
+ * struct sched_ext_ops can change over time. Two complementary mechanisms
+ * keep BPF schedulers built against newer headers running on older kernels:
+ *
+ * 1. Load-time fix-up (this macro). For each optional ops callback or field
+ *    added to struct sched_ext_ops, an explicit stanza below probes the
+ *    running kernel's BTF via __COMPAT_struct_has_field() and, if the field
+ *    is missing, clears it in the in-memory struct_ops (with a warning to
+ *    stderr) before load. Handles additive changes - a new stanza must be
+ *    added here for each new optional field.
+ *
+ * 2. Multi-variant struct_ops via compat.bpf.h::SCX_OPS_DEFINE(). That
+ *    macro can be expanded to emit several variants of struct sched_ext_ops,
+ *    and SCX_OPS_LOAD()/ATTACH() can pick the right one based on what the
+ *    kernel supports. Needed when an existing operation has to change
+ *    incompatibly (e.g. a callback signature changes); the load-time
+ *    fix-up above only handles purely additive changes.
  *
  * ec7e3b0463e1 ("implement-ops") in https://github.com/sched-ext/sched_ext is
  * the current minimum required kernel version.
@@ -225,6 +239,7 @@ static inline void __scx_ops_assoc_prog(
 }
 #endif
 
+/* See SCX_OPS_OPEN() above for backward-compatibility handling. */
 #define SCX_OPS_LOAD(__skel, __ops_name, __scx_name, __uei_name) ({		\
 	struct bpf_program *__prog;						\
 	UEI_SET_SIZE(__skel, __ops_name, __uei_name);				\
