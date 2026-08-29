Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D3028B4FA
	for <sched-ext@lists.linux.dev>; Sat, 29 Aug 2026 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788006042; cv=none; b=S7pUaQqdwHwiPJWCNeGMi5usazVsivCKCfJNGJQNqq/JeD+sg70JQuj0cMPb9k3WvaPjYylrUb6jK8dhy6mcJc739hMpKDUL0RHlvtzvXoT/flEBM9mHNxKIBXgpov8Quflf/Qxizk8Zs06pAGzWQ+YYBavErkaoNr6H9xj8ekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788006042; c=relaxed/simple;
	bh=On5QLSADWXj7ehvrb5mpi4doFVUA0NCpPYlWd5mFwE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N97NeM/qHEDZ9OgbBN0qqyPikXlq/Q/zU3pHzKRvRARKOJ1bET+gV/3lBu6c9MZvI8ZLnk80nIVVlU7K+UcEfspAwsL9okAXwpRQDJtJJ3XZW+V9q6UoPoLwVbyAkOWRqMtin0iYRE9vNTi/vSzugsnD2Vw+J2aGgbdCC/6SBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJbVzQhh; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJbVzQhh"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48433f36a21so106606f8f.1
        for <sched-ext@lists.linux.dev>; Sat, 29 Aug 2026 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788006038; x=1788610838; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b9Hl9L5OM4zLmYxZt3PdWHTJUIrg0x1d8J+XYA0ccVA=;
        b=UJbVzQhhH7YV7fr0VAJmtciTHSxefXhMCIWAl3L51YtrdU8HXqz7rPaw4Xp2+PwpCu
         qi9lF6EJaIMApkABkd+tDbZNVk0hPTcnqplgIGw4M+bEI3nJT1d/t8PEADiEmjliWY4A
         Z20HxBOJ7CL0omV1dQzx3x2xKLVrxKwa3NQwr9a4BN2rEwitOzNfkJiC+tqApnibeAG/
         SW/AKZ6J2nbSYZ0fHi/EGgC+VESVkYcsWu5Vt111TbxttGu5P+ToyKbJoYS8qnPWTp5e
         f6x1rVKyh/r7/y/jmXylNHq7Qm9sjO8Dts5Coekz8E44/AXlGcDxqZVGsfzMAY13zgtF
         th4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788006038; x=1788610838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b9Hl9L5OM4zLmYxZt3PdWHTJUIrg0x1d8J+XYA0ccVA=;
        b=d2modUR3myGIdFFDEPjc0y4ezp/fZP1y061qdg/U5aMIZKtjV4/yVjODyjurJe1oL6
         cc9pxeMvcTo3TYvKXUaZO4BJiI3+bQwrru1InXOB0BEkcmj9rlq0MiNSf9XZf/ngY+z1
         9VebC3n+Piku9ldX/Op9IfIsd5hCYiC7yC5oSWRituSjON0IrhO7T0ByLuNLojjtxn88
         UzNjGy6l7BnWjZMbUA4s/dzTYlrPJIDYx2IU+qyNmDths46qaeazsOqRBxyBMqtQ/2hB
         06z3kpfuIAJ97Q3VlFo0J2xlV9atkGsX00b4e8ZE5CLGBgMrOxgLQ/AsjZw8k/q2ApPN
         zMpg==
X-Gm-Message-State: AFuF++nCK9REdSrzaOrOKnx4ZJCUP1mhh8vJNuJaafXsDRa5Mhk+syZw
	qvkfEJRM3Yq3YTHnU/aw7vFLRNQ4M2GsS2DDQx/dDFTVgSfdv8y/9v8W
X-Gm-Gg: AR+sD10zKlcxXBYRYD5HH3dBaNMuR4/65mqVSxJ2sFvYIpbQgxxIUMPaKRwkz1YkDoe
	hzJKJ8nlXMz5OUXuSO0lVNY/0eoUji7bvlIbcwFkR3REyJeZGu84WaMecV4DqLfsyBz80h30oY9
	rtpCPMY2SG408rZv8p+zO9vRxE+4tBJqMBIW2wK7h7+DpvPrgCdOSrrtKyHfT+DP1OgW21PceKV
	hXQOEIisJqKXKJRis8DU5ObWVE4A+NichrMk9Mps32MdCQbdrPSX7Rwh6e3XZHwIinEz9gvzsXL
	hxxjcT2nnXTMZeyD38Ov0IFDVgogSHB2SKkbUaHChafxX2VP/5LwvDapj563U9y7OnKSSgjJH/S
	JDqIUxh2soUIO6+4eMKza5ybkZNdi1A2C1D92jZVvg+03DGd8WlMkf7h046BdOq0XhuTzy6Mx+q
	VHqSsN8v2AcYKxh2Cn+IOCyrdz3qqtwOXyoZHyRFbLVrxLbGuqjYVD1wVemFVIoOkR9Hd5z2mmI
	GF+lcrG4l36fJ25wBMw2rEhlz+glEJYdTu59QI/QHoP38oH
X-Received: by 2002:a05:600c:4ecc:b0:49c:ced9:ab7f with SMTP id 5b1f17b1804b1-49cced9abb7mr32848505e9.8.1788006038105;
        Sat, 29 Aug 2026 05:20:38 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b494228bfsm207048685e9.2.2026.08.29.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 05:20:37 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: tj@kernel.org
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	changwoo@igalia.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] tools/sched_ext: Extend the prolog migration probe to cid-form schedulers
Date: Sat, 29 Aug 2026 13:20:35 +0100
Message-ID: <20260829122035.58018-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_lib_init_probe hooks bpf_scx_reg(), which is where a cpu-form
scheduler enters the kernel when its struct_ops link is created. A
cid-form scheduler comes in elsewhere: bpf_sched_ext_ops_cid points .reg
at bpf_scx_reg_cid(), a separate function, so the probe never fires and
the flag it is meant to set keeps whatever it was compiled with. Give
that path its own probe over the same body. The catch is that
bpf_scx_reg_cid() has only existed since v7.2 while this header still
builds schedulers for older kernels, so the new program is "?" and
__SCX_OPS_OPEN() switches it on once it sees the symbol.

Default __scx_prolog_disables_migration to false, the over-reporting side
of is_migration_disabled(current), so the value used when no probe runs
matches what the comment describes as safe. That also covers loaders
which attach the struct_ops map but not the fentry programs.

Cc: Changwoo Min <changwoo@igalia.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 53 +++++++++++++-----------
 tools/sched_ext/include/scx/compat.h     |  3 ++
 2 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 76f5e025e107..be37c451cc0d 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -530,37 +530,29 @@ static __always_inline const struct cpumask *cast_mask(struct bpf_cpumask *mask)
 }
 
 /*
- * True if the non-sleepable BPF trampoline prolog (__bpf_prog_enter) calls
- * migrate_disable() for the current task. Recorded once by
- * scx_lib_init_probe, an fentry program on bpf_scx_reg() that fires during
- * the natural scheduler-attach call chain (auto-attached by scx_ops_attach!).
+ * True if the non-sleepable BPF prolog (__bpf_prog_enter) calls
+ * migrate_disable() for the current task. Set by the probes below.
  *
- * Defaults to true (conservative). Over-reporting in is_migration_disabled()
- * causes local-only dispatch, which is safe. Under-reporting can crash the
- * scheduler, so we err high if the probe somehow fails to run.
+ * Only affects is_migration_disabled(current): set attributes
+ * migration_disabled == 1 to the prolog (returns false), clear takes it at
+ * face value (returns true). Under-reporting can crash the scheduler, so the
+ * default is false for loaders that never attach the probes.
  */
-bool __scx_prolog_disables_migration __weak = true;
+bool __scx_prolog_disables_migration __weak;
 
 /*
- * scx_lib_init_probe - non-sleepable prolog probe.
+ * Prolog probes. Each struct_ops type needs its own: bpf_scx_reg() serves
+ * bpf_sched_ext_ops, bpf_scx_reg_cid() serves bpf_sched_ext_ops_cid, and the
+ * two are separate functions. Both run before ops.init() and are vtable
+ * entries, so neither can be inlined away.
  *
- * Attached to bpf_scx_reg(), the .reg callback in bpf_sched_ext_ops
- * (kernel/sched/ext.c). The kernel's struct_ops machinery invokes
- * bpf_scx_reg when userspace creates the scheduler link, before
- * ops.init() fires. Its address is taken in the vtable, so the symbol
- * is non-inlinable and has been stable since introduction.
+ * bpf_scx_reg_cid() only exists from v7.2, so that probe is "?" and
+ * __SCX_OPS_OPEN() enables it when the symbol is present.
  *
- * Entering via fentry runs us through __bpf_prog_enter -- the
- * non-sleepable prolog that consumers of is_migration_disabled() live
- * under.
- *
- * Loud warning: the prolog adds at most 1 to migration_disabled.
- * Reading > 1 means something upstream in the
- * bpf_struct_ops_link_create -> bpf_scx_reg path disabled migration
- * before the prolog ran, invalidating the probe; audit and adjust.
+ * The prolog adds at most 1 to migration_disabled. Reading > 1 means
+ * something disabled migration before it ran and the result is unreliable.
  */
-SEC("fentry/bpf_scx_reg") __weak
-int scx_lib_init_probe(void *ctx)
+static __always_inline void __scx_record_prolog_migration(void)
 {
 	if (bpf_core_field_exists(((struct task_struct *)0)->migration_disabled)) {
 		const struct task_struct *p = bpf_get_current_task_btf();
@@ -573,6 +565,19 @@ int scx_lib_init_probe(void *ctx)
 
 		__scx_prolog_disables_migration = md > 0;
 	}
+}
+
+SEC("fentry/bpf_scx_reg") __weak
+int scx_lib_init_probe(void *ctx)
+{
+	__scx_record_prolog_migration();
+	return 0;
+}
+
+SEC("?fentry/bpf_scx_reg_cid") __weak
+int scx_lib_init_probe_cid(void *ctx)
+{
+	__scx_record_prolog_migration();
 	return 0;
 }
 
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 7c12df45fdba..3a42f65a9346 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -284,6 +284,9 @@ static inline long scx_hotplug_seq(void)
 	SCX_BUG_ON(!__oskel, "Could not open " #__scx_name);			\
 	__oskel->struct_ops.__ops_name->hotplug_seq = scx_hotplug_seq();	\
 	SCX_ENUM_INIT(__oskel);							\
+	if (__COMPAT_has_ksym("bpf_scx_reg_cid"))				\
+		bpf_program__set_autoload(					\
+			(__oskel)->progs.scx_lib_init_probe_cid, true);		\
 	__oskel;								\
 })
 
-- 
2.55.0

