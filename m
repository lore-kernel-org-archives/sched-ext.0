Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778171;
	b=jNWNyzQ0tQWOmu8HPnmsVNI2RK2Q3/SV0ZEPdHQ2vje2/fSxVWm3u9MXCXcNwYcdtSDa
	 g1Mz1Qcn4oN4XPdlyAI5HfBcMeedS6pIF06TsXs5ylun2d571V4+i6lJqV2pPwaGW7C7v
	 4DGzU0nAtfF44nVu1500vGJZkVWTpAQr5wi5OghZTw2bzxgAicP3aUkqDyJOXa4Zym+Cs
	 O6yYettvnUWGg2MwNOdTe+XTb6RYvmW5PWLCboxrazs/80KB/oE8xFP0lbtpfjt4o+sx0
	 xzVKtoypM7w8jUL6czL6BhpTicF/XTKJzqX9Mu7WpuWAM4rwCvAAm7F5Ei0nMwrxnwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778171;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OuFRntLsKWVkhln7NLPq021dG4sakpiOgmRybSJ2J70=;
	b=n7CgczQjHG5mEST+vVGxf7MZMoqb1Twe1l+Ab28kcshTtGUdaqqUuHJtej1hWcA9pRkm
	 DNbcFMQM3h3r3wngwRWoiKx+FLbUpJgglZ24NjdvCPzfYiISDBGceWzGip0EQqYh9VYPz
	 lhhVnJbvB9xvtpG4zfTRI0Q2q2OR8j69Cm79jYUYvYP5MaZMPrazLuKAfa/1SE7B56M3w
	 TiGHoB6EVBZ+Y63MQOIR45j1EPQDWuHmYBNnCI2C7AcGkyPnwL49/nrI2fyhKbA8b/Uki
	 +cs3vAYVB+oHK2dyM57ZGNF58qEms1Sj6GfR5/7bE5IZnnfX6eAA4rFon3uAmntK05w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7bgjUOx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB101606A324;
	Fri, 23 Oct 2026 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7bgjUOx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D911F01829;
	Fri, 23 Oct 2026 17:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778170;
	bh=OuFRntLsKWVkhln7NLPq021dG4sakpiOgmRybSJ2J70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O7bgjUOxKre3iyRlT1Z/5uJaa6OInUZnvus2FGtd4wAVZ87DzyQREbcDGKOk9njvk
	 g7ZDoy7FBUt0fVYD2Q2LCCTWaIV8b8vF7PXY3y3fxigia5xTBGJGHED399tzXiRJrN
	 7ey3rM+p6GvEfBsvORM0W933gCT5+Cw1G/ejObLjaMI1DTG6x9ZnB5v76g8Erykpde
	 uy1whXpH1OZgNYeWNBvbsSAdbIoxYSdFzLX5DbMdLz4k8lBaLuE6KmgEsfe8jVJe/x
	 fnu2VK7qY9DrFgoMt7pK9L7wuS8saHnZByDMik5ajvk31O1q3fuG1Tpc1lqGYWynR2
	 er9DhnCss4OOA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/17] sched_ext: Pack scx_ent_flags' multi-bit fields at the top
Date: Fri, 23 Oct 2026 07:55:52 -1000
Message-ID: <20261023175608.4120910-2-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023175608.4120910-1-tj@kernel.org>
References: <20261023175608.4120910-1-tj@kernel.org>
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

The following patches add a flag for a kernel-owned slice to scx_ent_flags.
The two 3-bit fields, the task state at bits 8 to 10 and the reenqueue
reason at bits 12 to 14, sit right above the single-bit flags, so the new
flag would have to take bit 11 or 15, out of sequence with the rest.

Pack the fields at the top of the word, below SCX_TASK_CURSOR, the state at
bits 25 to 27 and the reason at bits 28 to 30, so that the single-bit flags
continue from bit 8.

The renumbering changes the values a BPF scheduler reads from p->scx.flags.
Nothing in the kernel or the in-tree schedulers hardcodes the numbers. The
enum ABI table in tools/sched_ext/include/scx/enums_abi.autogen.h, kept for
repairing enum values that a kernel's BTF truncates, is regenerated for the
two fields. In the scx repository, scx_eevdf tests SCX_TASK_REENQ_IMMED and
SCX_TASK_REENQ_PREEMPTED against SCX_TASK_REENQ_REASON_MASK. Those three
names belong in its load-time enum table, so that they follow the running
kernel. No behavior change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h                     | 11 +++++---
 .../sched_ext/include/scx/enums_abi.autogen.h | 28 +++++++++----------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index efd635a99309..b341c328948e 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -107,7 +107,10 @@ enum scx_ent_flags {
 	SCX_TASK_RUN_TRACKED	= 1 << 7, /* task is in an ops.running()/stopping() session */
 
 	/*
-	 * Bits 8 to 10 are used to carry task state:
+	 * The multi-bit fields are packed at the top, below SCX_TASK_CURSOR, so
+	 * that the single-bit flags stay contiguous from bit 0.
+	 *
+	 * Bits 25 to 27 are used to carry task state:
 	 *
 	 * NONE		ops.init_task() not called yet
 	 * INIT_BEGIN	ops.init_task() in flight; see sched_ext_dead()
@@ -116,7 +119,7 @@ enum scx_ent_flags {
 	 * ENABLED	fully initialized and in sched_ext
 	 * DEAD		terminal state set by sched_ext_dead()
 	 */
-	SCX_TASK_STATE_SHIFT	= 8,
+	SCX_TASK_STATE_SHIFT	= 25,
 	SCX_TASK_STATE_BITS	= 3,
 	SCX_TASK_STATE_MASK	= ((1 << SCX_TASK_STATE_BITS) - 1) << SCX_TASK_STATE_SHIFT,
 
@@ -128,7 +131,7 @@ enum scx_ent_flags {
 	SCX_TASK_DEAD		= 5 << SCX_TASK_STATE_SHIFT,
 
 	/*
-	 * Bits 12 to 14 are used to carry reenqueue reason. In addition to
+	 * Bits 28 to 30 are used to carry reenqueue reason. In addition to
 	 * %SCX_ENQ_REENQ flag, ops.enqueue() can also test for
 	 * %SCX_TASK_REENQ_REASON_NONE to distinguish reenqueues.
 	 *
@@ -139,7 +142,7 @@ enum scx_ent_flags {
 	 * CAP		sub-sched cap miss, see p->scx.reenq_reason_*
 	 * PROXY	proxy state prevented a remote DSQ transfer
 	 */
-	SCX_TASK_REENQ_REASON_SHIFT = 12,
+	SCX_TASK_REENQ_REASON_SHIFT = 28,
 	SCX_TASK_REENQ_REASON_BITS = 3,
 	SCX_TASK_REENQ_REASON_MASK = ((1 << SCX_TASK_REENQ_REASON_BITS) - 1) << SCX_TASK_REENQ_REASON_SHIFT,
 
diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
index 1186daa9cb14..05a460611c4d 100644
--- a/tools/sched_ext/include/scx/enums_abi.autogen.h
+++ b/tools/sched_ext/include/scx/enums_abi.autogen.h
@@ -120,24 +120,24 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_ent_flags", "SCX_TASK_IMMED", 0x20LLU },
 	{ "scx_ent_flags", "SCX_TASK_PROTECTED", 0x40LLU },
 	{ "scx_ent_flags", "SCX_TASK_RUN_TRACKED", 0x80LLU },
-	{ "scx_ent_flags", "SCX_TASK_STATE_SHIFT", 0x8LLU },
+	{ "scx_ent_flags", "SCX_TASK_STATE_SHIFT", 0x19LLU },
 	{ "scx_ent_flags", "SCX_TASK_STATE_BITS", 0x3LLU },
-	{ "scx_ent_flags", "SCX_TASK_STATE_MASK", 0x700LLU },
+	{ "scx_ent_flags", "SCX_TASK_STATE_MASK", 0xe000000LLU },
 	{ "scx_ent_flags", "SCX_TASK_NONE", 0x0LLU },
-	{ "scx_ent_flags", "SCX_TASK_INIT_BEGIN", 0x100LLU },
-	{ "scx_ent_flags", "SCX_TASK_INIT", 0x200LLU },
-	{ "scx_ent_flags", "SCX_TASK_READY", 0x300LLU },
-	{ "scx_ent_flags", "SCX_TASK_ENABLED", 0x400LLU },
-	{ "scx_ent_flags", "SCX_TASK_DEAD", 0x500LLU },
-	{ "scx_ent_flags", "SCX_TASK_REENQ_REASON_SHIFT", 0xcLLU },
+	{ "scx_ent_flags", "SCX_TASK_INIT_BEGIN", 0x2000000LLU },
+	{ "scx_ent_flags", "SCX_TASK_INIT", 0x4000000LLU },
+	{ "scx_ent_flags", "SCX_TASK_READY", 0x6000000LLU },
+	{ "scx_ent_flags", "SCX_TASK_ENABLED", 0x8000000LLU },
+	{ "scx_ent_flags", "SCX_TASK_DEAD", 0xa000000LLU },
+	{ "scx_ent_flags", "SCX_TASK_REENQ_REASON_SHIFT", 0x1cLLU },
 	{ "scx_ent_flags", "SCX_TASK_REENQ_REASON_BITS", 0x3LLU },
-	{ "scx_ent_flags", "SCX_TASK_REENQ_REASON_MASK", 0x7000LLU },
+	{ "scx_ent_flags", "SCX_TASK_REENQ_REASON_MASK", 0x70000000LLU },
 	{ "scx_ent_flags", "SCX_TASK_REENQ_NONE", 0x0LLU },
-	{ "scx_ent_flags", "SCX_TASK_REENQ_KFUNC", 0x1000LLU },
-	{ "scx_ent_flags", "SCX_TASK_REENQ_IMMED", 0x2000LLU },
-	{ "scx_ent_flags", "SCX_TASK_REENQ_PREEMPTED", 0x3000LLU },
-	{ "scx_ent_flags", "SCX_TASK_REENQ_CAP", 0x4000LLU },
-	{ "scx_ent_flags", "SCX_TASK_REENQ_PROXY", 0x5000LLU },
+	{ "scx_ent_flags", "SCX_TASK_REENQ_KFUNC", 0x10000000LLU },
+	{ "scx_ent_flags", "SCX_TASK_REENQ_IMMED", 0x20000000LLU },
+	{ "scx_ent_flags", "SCX_TASK_REENQ_PREEMPTED", 0x30000000LLU },
+	{ "scx_ent_flags", "SCX_TASK_REENQ_CAP", 0x40000000LLU },
+	{ "scx_ent_flags", "SCX_TASK_REENQ_PROXY", 0x50000000LLU },
 	{ "scx_ent_flags", "SCX_TASK_CURSOR", 0xffffffff80000000LLU },
 	{ "scx_exit_code", "SCX_ECODE_RSN_HOTPLUG", 0x100000000LLU },
 	{ "scx_exit_code", "SCX_ECODE_RSN_CGROUP_OFFLINE", 0x200000000LLU },
-- 
2.56.0

