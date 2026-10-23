Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792797668;
	b=hQJFiF4vJgwwZJViNsXYSuFC4rvytaIG+/nByczUpbjt3kE1K5ZzNPJCzWkd0e4ZP6W3
	 X4Y7YtlZLbib6GsSMLGxC5V69q3xX8Et00zFharUOtMk9D2/7RWZYsvktiKrwMNc1O4Ia
	 tPM9UXq6K312BBGlq7VmHScCk7TTJjwHKh4XO2YggJLgKDbTL/9bkW9QKXxUCEgLnWwBS
	 KEZVW/e5FdkXFswWiin/9RBUMRyS9CPl6bbW4e+u6DaQ9N9YTbfiyTJj9Je+T7CeKNM/1
	 Zko9ygcB4hhm1yofalsICPM+jFaWv+PPv2WowbbvZgUdojypFNnJonlmzFArzmCEgag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792797668;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DP8P5k9s+Vgq0rAx5U8N2lMMuwH/iK3Uoaoia9Rowxk=;
	b=vkZyafFm3R9EZSM7Dumxv6DafgQH9RkHi5iRV/TQmzQUZ1BI6ctn667/7zlI7xZ0V7yr
	 9lSWUy8dRJeO4g+61gIrvQCng5a+DYfMereIIZENQM2LJ3WXCo9SCstkoKTgeB+4XSXP4
	 LDOGqkJGnJvlxgjswm3XORpgxAaIOkYhLZRvDffAeODqnDcewq6l0nxUfXx/yvGwd9APZ
	 gD7fWAV/OvBP0atTpjOoQPmeO60rVPsrIU/w6aKmAClBhLWZeufoUgOYGTJDDz5afoJES
	 yUW+bEQOliTj99NyZiKvx6LIaKVc4gM1MaTUkTydy889lgap9E85gINQU1pKkh0g9aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cfj1RE2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2298E60A263F;
	Fri, 23 Oct 2026 23:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfj1RE2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46BA1F01828;
	Fri, 23 Oct 2026 23:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792797667;
	bh=DP8P5k9s+Vgq0rAx5U8N2lMMuwH/iK3Uoaoia9Rowxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cfj1RE2/SnS4P2jIZq9v8c+jqOoa8or+YmOurAhe6kXrMV1Zy6GWU/vIIr2ao1uUa
	 WagfSEbf59/bCcbNOcwhTl558lGBfBOXY7t51zm1tgsVjYZeQIrW1MngRCzww89b4m
	 oztBxrs5Nes7GTRptGvhn7pLuD5seKp6DE189+GQCr4gt5bvh2Fw0EMBZ66urJ9X15
	 PH1wk9PDhU9dCTifv0f5qNGH2OGSB6Rdq9lQ+hceGsQ4GXGX/CL5wLT+EtWixkTKRn
	 0Vy6YQkfXschBXf1Bcrue9xGz6wQqlmYy/Nx3DUn0eB+mev+ucSMPWb/qfcZ87GJbf
	 pMzdIZgEX7HyA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] sched_ext: Drop stale entries from the enum lookup tables
Date: Fri, 23 Oct 2026 13:21:02 -1000
Message-ID: <20261023232102.1124938-5-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023232102.1124938-1-tj@kernel.org>
References: <20261023232102.1124938-1-tj@kernel.org>
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

The enum lookup tables, enums.autogen.h and enums.autogen.bpf.h, are
maintained by hand despite their names. Five entries name enums the kernel
no longer has. Their lookups in the running kernel's BTF store 0, and
nothing in tools/ uses them. Drop them. No behavior change.

Suggested-by: Andrea Righi <arighi@nvidia.com>
Link: https://lore.kernel.org/all/atr0I5EF7hmM_m7Y@gpd4/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/enums.autogen.bpf.h | 15 ---------------
 tools/sched_ext/include/scx/enums.autogen.h     |  5 -----
 2 files changed, 20 deletions(-)

diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index db23be9cc88b..8c9ecad561c9 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -22,24 +22,12 @@ const volatile u64 __SCX_RQ_ONLINE __weak;
 const volatile u64 __SCX_RQ_CAN_STOP_TICK __weak;
 #define SCX_RQ_CAN_STOP_TICK __SCX_RQ_CAN_STOP_TICK
 
-const volatile u64 __SCX_RQ_BAL_PENDING __weak;
-#define SCX_RQ_BAL_PENDING __SCX_RQ_BAL_PENDING
-
-const volatile u64 __SCX_RQ_BAL_KEEP __weak;
-#define SCX_RQ_BAL_KEEP __SCX_RQ_BAL_KEEP
-
-const volatile u64 __SCX_RQ_BYPASSING __weak;
-#define SCX_RQ_BYPASSING __SCX_RQ_BYPASSING
-
 const volatile u64 __SCX_RQ_CLK_VALID __weak;
 #define SCX_RQ_CLK_VALID __SCX_RQ_CLK_VALID
 
 const volatile u64 __SCX_RQ_IN_WAKEUP __weak;
 #define SCX_RQ_IN_WAKEUP __SCX_RQ_IN_WAKEUP
 
-const volatile u64 __SCX_RQ_IN_BALANCE __weak;
-#define SCX_RQ_IN_BALANCE __SCX_RQ_IN_BALANCE
-
 const volatile u64 __SCX_RQ_IN_DISPATCH __weak;
 #define SCX_RQ_IN_DISPATCH __SCX_RQ_IN_DISPATCH
 
@@ -103,9 +91,6 @@ const volatile u64 __SCX_TASK_READY __weak;
 const volatile u64 __SCX_TASK_ENABLED __weak;
 #define SCX_TASK_ENABLED __SCX_TASK_ENABLED
 
-const volatile u64 __SCX_TASK_NR_STATES __weak;
-#define SCX_TASK_NR_STATES __SCX_TASK_NR_STATES
-
 const volatile u64 __SCX_TASK_DSQ_ON_PRIQ __weak;
 #define SCX_TASK_DSQ_ON_PRIQ __SCX_TASK_DSQ_ON_PRIQ
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index 369f8d88c7db..1df2b8a505ff 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -12,12 +12,8 @@
 	SCX_ENUM_SET(skel, scx_consts, SCX_RESCUE_DISABLE); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_ONLINE); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_CAN_STOP_TICK); \
-	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_BAL_PENDING); \
-	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_BAL_KEEP); \
-	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_BYPASSING); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_CLK_VALID); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_IN_WAKEUP); \
-	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_IN_BALANCE); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_IN_DISPATCH); \
 	SCX_ENUM_SET(skel, scx_dsq_id_flags, SCX_DSQ_FLAG_BUILTIN); \
 	SCX_ENUM_SET(skel, scx_dsq_id_flags, SCX_DSQ_FLAG_LOCAL_ON); \
@@ -39,7 +35,6 @@
 	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_INIT); \
 	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_READY); \
 	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_ENABLED); \
-	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_NR_STATES); \
 	SCX_ENUM_SET(skel, scx_ent_dsq_flags, SCX_TASK_DSQ_ON_PRIQ); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_IDLE); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_PREEMPT); \
-- 
2.56.0

