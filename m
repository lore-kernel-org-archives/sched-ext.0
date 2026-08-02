Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6F3D9552;
	Sun,  2 Aug 2026 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707700; cv=none; b=eEemPYUYEpk67beNAVHfLhCfi8JRv2+1EOfPzSPJ5FcFSHZQDkhIV0+pjwfA7QjfVE2505LkMcx0HodZBwOAz2dN59M7JSyRqPCaQsfvDX2h2K0bXZ+Ny+0z+vGISBESCr5xMCz4wthFZd5pEAIZjYYn6/jdBvS4w912/s4Cov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707700; c=relaxed/simple;
	bh=3V8z1laSbz8z1fSIHVpII8dbt4ouipUuNNNedeFW3iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUQGcWQlNhze+EDxTlIso3/wfSiWQZZaet+7zMBGXjbQyC4z8uD82Xn6L7AcOYHhTZAUg6LWMqTFt2y35hNKeCwPN4elIhv+akR7N/3vXyJ6GYPQGQD15R2EPLa4lD/65NTJPwR7rZbFCStejNIQq9qEAALJLxkF3gg/RTuJKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmLj8eZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmLj8eZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E521F00A3E;
	Sun,  2 Aug 2026 21:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785707698;
	bh=AebX73dUqN9sKGeNcJv5Vn433RRYMzRd1NRlT2T9kAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SmLj8eZ2UcLfzaBuB0T4oGh4e3Dg/c2+wgo0rKj0lBEdfqFsk4CW2K74P23j2wj8m
	 1yV1hTpAK1BHWwIgOdPeG8VBk8/m1hDDDPvC2eLIsYxW4m6KudH7vwzQK8kEOV3EJG
	 wzf5HKX9/EqipDug7UhcR+szSgkhCS70DlKFSXsPgO7DDFKdl5ABzIee90lal+/Gyq
	 DE8DcxfExjr67yvb+tlMkHHo+wFunZanXkoTNzDIMZXEUfoBLxrPfYBm1CcdsSWFrT
	 nwAXBiUfz1QCmnRuunHuPjydOq3ubywjIOzj334CZf/h3oZttoAzWdoeTAqgJN0kTw
	 s6zhsERwwPX7g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/12] sched_ext: scx_qmap - Idle-check pinned tasks before direct dispatch
Date: Sun,  2 Aug 2026 11:54:46 -1000
Message-ID: <20260802215447.3134509-12-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802215447.3134509-1-tj@kernel.org>
References: <20260802215447.3134509-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pick_direct_dispatch_cid() sent a pinned task straight to its only cpu
without an idle check. An insert onto a time-shared cid is forced IMMED,
which may not wait on a busy cpu - the kernel bounces the task back to
ops.enqueue(), the shortcut re-inserts it, and the loop runs into the
reenqueue repeat limit.

Run pinned tasks through the same idle test as everyone else and queue them
when the cpu is busy. always_enq_immed forces IMMED on every local insert
and already skipped the shortcut for the same reason. The check was the last
reader of the always_enq_immed rodata mirror, so drop the variable. The -I
option still sets SCX_OPS_ALWAYS_ENQ_IMMED.

v2: Drop the now-unread always_enq_immed rodata mirror. (sashiko AI)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 4 ----
 tools/sched_ext/scx_qmap.c     | 1 -
 2 files changed, 5 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 8822ed11c0d8..87612fa7e00d 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -66,7 +66,6 @@ const volatile bool print_msgs;
 const volatile u64 sub_cgroup_id;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
-const volatile bool always_enq_immed;
 const volatile u32 immed_stress_nth;
 const volatile u32 max_tasks;
 
@@ -230,9 +229,6 @@ static s32 pick_direct_dispatch_cid(struct task_struct *p, s32 prev_cid,
 	s32 cid;
 	u32 i;
 
-	if (!always_enq_immed && p->nr_cpus_allowed == 1)
-		return prev_cid;
-
 	if (cmask_test(prev_cid, &qa.self_cids.mask) &&
 	    cmask_test_and_clear(prev_cid, &qa.idle_cids.mask))
 		return prev_cid;
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 3f54796e48be..c4c4cee11f8e 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -315,7 +315,6 @@ int main(int argc, char **argv)
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_SWITCH_PARTIAL;
 			break;
 		case 'I':
-			skel->rodata->always_enq_immed = true;
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
 			break;
 		case 'F':
-- 
2.55.0

