Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D004B0481;
	Sun, 16 Aug 2026 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838463; cv=none; b=O1FNZ4TqEAkkyE/iGnJIwDprGQgyuWcK6+Ein9HgDUNxrIg4VVd3bZ8Ifprqik+ypNUfRECkXAFewqAHFNC1knap+ux3ddnQRTfi3W8rztYTS/AWwplNUfdFCcJBT+YruVpG4725GD3TR9xPBZaupGzwFZ2ZCSb2PGoEqxBerIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838463; c=relaxed/simple;
	bh=C3FLa3Br2SlMY/ITDDU/hvuCCUatmhcW0Q2SCSDY6p8=;
	h=Date:Message-ID:From:To:Cc:Subject; b=l1Do0sfwiixlwTMaafbwupRjuwGqtZibnp9rkh1aMl1eUEe9eydgS8sToaeBXdLKyXia/CTpji/EF15DgXELjeAKNdvpw2IJ2pXiY68mkyg35zVsHJmtZlyanXIA9nB5/ZWUyEdmTT5HKt071ZhORYN/4mCKDdrJqfXTHO3IeN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrnYoi/p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrnYoi/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989581F000E9;
	Sun, 16 Aug 2026 00:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786838461;
	bh=Z+EubGdcgpXDqM4Z4lT7X0UZN+uzLw1jLc1Hsx+RK3c=;
	h=Date:From:To:Cc:Subject;
	b=TrnYoi/p6O0B8rLg5+uYitLq77ArNcvGe4/94NiOQA+F9pEDgrcVbESUjJgg/C5cg
	 4fnLBlmoqMcGBEOQfQb6M17imKZ/+ghTr6WBVKyJ0+Z+qQJG1u6H0CKaZd1/odHSQ6
	 PK6XZ9AInA8mDqsejXXuXJuyunt74eIZ578c0vE5HfKvkpRkxs24bt5R5R8tjJvMCA
	 /8NcRgqSlTAMFFulLrBDARhfPieEYIOxerbvdmngIQYQdi7c7nJ3A+zGOYYaFzrD9J
	 RlolLoitSDOjtp8iGgiC9QHj7wP7OmhKD14swC0k57NAX6Ze3qrz81m7VwI/eA3J7F
	 1GsVoRU8ms/Rg==
Date: Sat, 15 Aug 2026 14:01:00 -1000
Message-ID: <1f50a8edb9b37d10adb80552b08f8636@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.3] sched_ext: Move the config-off sub-cap kfunc stubs into sub.c
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The EOPNOTSUPP stubs for the sub-cap kfuncs live in ext.c under #ifndef
CONFIG_EXT_SUB_SCHED while the real definitions live in sub.c. Move the
stubs into sub.c so all sub kfunc definitions live in one file. Pure code
move, no functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c |   29 -----------------------------
 kernel/sched/ext/sub.c |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 29 deletions(-)

--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -10682,35 +10682,6 @@ out:
 }
 #endif	/* CONFIG_CGROUP_SCHED */
 
-#ifndef CONFIG_EXT_SUB_SCHED
-__bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
-				  const struct scx_cmask *cmask__ign,
-				  struct scx_cmask *denied_out__ign,
-				  const struct bpf_prog_aux *aux)
-{
-	return -EOPNOTSUPP;
-}
-
-__bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
-				    const struct scx_cmask *cmask__ign,
-				    const struct bpf_prog_aux *aux)
-{
-}
-
-__bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out__ign,
-				 const struct bpf_prog_aux *aux)
-{
-	return -EOPNOTSUPP;
-}
-
-__bpf_kfunc s32 scx_bpf_sub_kill_bstr(u64 cgroup_id, char *fmt,
-				      unsigned long long *data, u32 data__sz,
-				      const struct bpf_prog_aux *aux)
-{
-	return -EOPNOTSUPP;
-}
-#endif	/* !CONFIG_EXT_SUB_SCHED */
-
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -2648,4 +2648,37 @@ __bpf_kfunc s32 scx_bpf_sub_kill_bstr(u6
 
 __bpf_kfunc_end_defs();
 
+#else	/* !CONFIG_EXT_SUB_SCHED */
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
+				  const struct scx_cmask *cmask__ign,
+				  struct scx_cmask *denied_out__ign,
+				  const struct bpf_prog_aux *aux)
+{
+	return -EOPNOTSUPP;
+}
+
+__bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
+				    const struct scx_cmask *cmask__ign,
+				    const struct bpf_prog_aux *aux)
+{
+}
+
+__bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out__ign,
+				 const struct bpf_prog_aux *aux)
+{
+	return -EOPNOTSUPP;
+}
+
+__bpf_kfunc s32 scx_bpf_sub_kill_bstr(u64 cgroup_id, char *fmt,
+				      unsigned long long *data, u32 data__sz,
+				      const struct bpf_prog_aux *aux)
+{
+	return -EOPNOTSUPP;
+}
+
+__bpf_kfunc_end_defs();
+
 #endif	/* CONFIG_EXT_SUB_SCHED */
