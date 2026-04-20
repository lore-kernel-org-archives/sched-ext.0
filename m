Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D392138F95B
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677365; cv=none; b=YR19PqwmqXInWFOUXv2+WzVvJqvOAJfCBLONtHoxAVXwqMJGlnp1V5xh6idgqfEiLEu/v0w6nslGxsV5IwF6/g3OynkYmFyhPGepmjneeMuLLdWqBV0H+pr/t3Z3quUuzgvhV2F+aF/mHFEnuxCz/4ULXYLNO9D5ehlH5P6hSrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677365; c=relaxed/simple;
	bh=xMwabH//NwcbTeIoqfCrcHFsdd6wj7Sve3qIn83lzow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5R+1voUHfL1CsFn9KToQQyaPhjAOwLvFqFrbIop8/GdDVmT+/djnJXDYMHfD/RP5OCcZwyl0llxJIALRjOgcBXbf+xljInvwOjLPFxPOrCtxvaalsEImZGTDTdcJwnF8hetsAh4b+8VoBAQyOCrEO5b8QtE7Q5mxbL173eDn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ydo+Nyp0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ydo+Nyp0"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35fb7c1a455so1113235a91.3
        for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776677363; x=1777282163; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JoXhSClD3HdSCEdhrhWq0ZEz2ItIYvt2/wpBSI8los=;
        b=Ydo+Nyp0nHoxoexsABsW5OyVKoe7M4ggZMHXE5+/YL24OAjtcZshmwROnIsHLHowM+
         1mng6k5ly7YWPl63NUgqeKR3RY8gfKIpA0nRSnhkSZ+twYATH9gsBTDXeVtV7G9Q9bd1
         1UyWj1nLPbmRnKj6Tu/dD+NtpwHizvU9Acq+aC966Zm+U66RAi4muF54qWBVDMsbE7oF
         8D7pd/SMdjezCzgVUrDy0Q9YsE1uXShwN77INoBuJHaOZZr0YVdRZSwgA9eJVaEhZoDz
         RDg8e5Ya/wqvb9TwW70iJDlNXhkAkmneqtSETfATPUnG53VcVrD9BBR6e0wiuVPZeQHL
         FHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776677363; x=1777282163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5JoXhSClD3HdSCEdhrhWq0ZEz2ItIYvt2/wpBSI8los=;
        b=bXGkYmYUQxvN9CuyTqSN69fUy7/QVqBVw5vTS/bJ+qYAxDOmRBe1jtGhUkGxGvx5Hl
         XZiVKge/f0rdYfJO9CLvl8uLyHrt5VQyadOpWyq2EKPfe3YZJIBDCuFsotOpVXCbffXn
         BnFfgZeCho8gxDn1kKy1JSJwTrQxwega4/lZljuQ+MXy17nIbrI7snlMgWNZbOEt3YMK
         hDl2pvUun/9dX3ZZJ31GOekAgTgZusLT9T/KXPZJ7otZAdPDqO02ETiCCIVNn/53kNmO
         Gv4khWK7dY3CUVE2G1U5Lvj7vhehCiKhaO5dDZlDfWgkaWcXHnfITOm2AHT5BFcbmoOS
         M9ZA==
X-Gm-Message-State: AOJu0YwSCiaZehtIeb/C/n0EGIKlVBVZa8PY3dkv4LnHBE51BZrmJ6sw
	K8fdfHwxikR8y3t+e328cXWK/G6p+dQcqaVhVEIS5CZkvInowWgODEHoD01DnQ==
X-Gm-Gg: AeBDietp8Qq7sgLvGDPA8G0om85o5+vQ8VMUp706/BgD2GKjoV8DhUZnKSwnsdf0wOU
	x8IUsUl7jZrGtuw1XH6rZz/8uNR4EPGKbXmJdlERQO1oc9Ywd5HzvxGJtHv15rGi+nqUuioyhZX
	5uLcyVDLXKGv/dWVIQ4j5tCMlDSfBimH1ExGu+/k7IOdYpttMngthTMjnDTkC0AMrfyYbrYFria
	seLaH6JuEZWxi/0V1t/L35/YYQakrIAUMAKq7cl8IihelMid+6y8uPmCZfu3lLOwKzsLLTJKyoc
	cZHxk/OOCbvT93M1/rEYkVr43qRrx9+MmUuhE7K2pZqCJt9nskyNB2rPMPh3TZFetVv/x+4eVKt
	rd6MCw421rd4U1OIH0Jj1fnl8X8gxxFGmj76as79cI0E/d+fs/Rg0r41fGKgdwfDhPMEuqUaO7k
	upVJoX1ZWFMUxrk+oavZmnjAe7qp4U34zXWjl1nJy4mQR89bRndMRUx7lYVfiY/w==
X-Received: by 2002:a17:903:3805:b0:2b2:4dd2:dcf5 with SMTP id d9443c01a7336-2b5f9f527famr125905395ad.20.1776677362813;
        Mon, 20 Apr 2026 02:29:22 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:21f5:5215:464d:5ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0dafcsm101273545ad.52.2026.04.20.02.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:29:22 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 1/2] sched_ext: Deny SCX kfuncs to non-SCX struct_ops programs
Date: Mon, 20 Apr 2026 17:28:47 +0800
Message-ID: <20260420092913.440989-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260420092913.440989-1-yphbchou0911@gmail.com>
References: <20260420092913.440989-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_kfunc_context_filter() currently allows non-SCX struct_ops programs
(e.g. tcp_congestion_ops) to call SCX unlocked kfuncs. This is wrong
for two reasons:

- It is semantically incorrect: a TCP congestion control program has no
  business calling SCX kfuncs such as scx_bpf_kick_cpu().

- With CONFIG_EXT_SUB_SCHED=y, kfuncs like scx_bpf_kick_cpu() call
  scx_prog_sched(aux), which invokes bpf_prog_get_assoc_struct_ops(aux)
  and casts the result to struct sched_ext_ops * before reading ops->priv.
  For a non-SCX struct_ops program the returned pointer is the kdata of
  that struct_ops type, which is far smaller than sched_ext_ops, making
  the read an out-of-bounds access (confirmed with KASAN).

Extend the filter to cover scx_kfunc_set_any and scx_kfunc_set_idle as
well, and deny all SCX kfuncs for any struct_ops program that is not the
SCX struct_ops. This addresses both issues: the semantic contract is
enforced at the verifier level, and the runtime out-of-bounds access
becomes unreachable.

Fixes: d1d3c1c6ae36 ("sched_ext: Add verifier-time kfunc context filter")
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c      | 32 ++++++++++++++++++--------------
 kernel/sched/ext_idle.c |  1 +
 kernel/sched/ext_idle.h |  1 +
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b34f1e5df1c5..0a53a0dd64bf 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9625,6 +9625,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_any)
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_any,
+	.filter			= scx_kfunc_context_filter,
 };
 
 /*
@@ -9672,13 +9673,12 @@ static const u32 scx_kf_allow_flags[] = {
 };
 
 /*
- * Verifier-time filter for context-sensitive SCX kfuncs. Registered via the
- * .filter field on each per-group btf_kfunc_id_set. The BPF core invokes this
- * for every kfunc call in the registered hook (BPF_PROG_TYPE_STRUCT_OPS or
+ * Verifier-time filter for SCX kfuncs. Registered via the .filter field on
+ * each per-group btf_kfunc_id_set. The BPF core invokes this for every kfunc
+ * call in the registered hook (BPF_PROG_TYPE_STRUCT_OPS or
  * BPF_PROG_TYPE_SYSCALL), regardless of which set originally introduced the
- * kfunc - so the filter must short-circuit on kfuncs it doesn't govern (e.g.
- * scx_kfunc_ids_any) by falling through to "allow" when none of the
- * context-sensitive sets contain the kfunc.
+ * kfunc - so the filter must short-circuit on kfuncs it doesn't govern by
+ * falling through to "allow" when none of the SCX sets contain the kfunc.
  */
 int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
@@ -9687,18 +9687,21 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	bool in_enqueue = btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id);
 	bool in_dispatch = btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id);
 	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
+	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
+	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
 	u32 moff, flags;
 
-	/* Not a context-sensitive kfunc (e.g. from scx_kfunc_ids_any) - allow. */
-	if (!(in_unlocked || in_select_cpu || in_enqueue || in_dispatch || in_cpu_release))
+	/* Not an SCX kfunc - allow. */
+	if (!(in_unlocked || in_select_cpu || in_enqueue || in_dispatch ||
+	      in_cpu_release || in_idle || in_any))
 		return 0;
 
 	/* SYSCALL progs (e.g. BPF test_run()) may call unlocked and select_cpu kfuncs. */
 	if (prog->type == BPF_PROG_TYPE_SYSCALL)
-		return (in_unlocked || in_select_cpu) ? 0 : -EACCES;
+		return (in_unlocked || in_select_cpu || in_idle || in_any) ? 0 : -EACCES;
 
 	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
-		return -EACCES;
+		return (in_any || in_idle) ? 0 : -EACCES;
 
 	/*
 	 * add_subprog_and_kfunc() collects all kfunc calls, including dead code
@@ -9711,14 +9714,15 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 		return 0;
 
 	/*
-	 * Non-SCX struct_ops: only unlocked kfuncs are safe. The other
-	 * context-sensitive kfuncs assume the rq lock is held by the SCX
-	 * dispatch path, which doesn't apply to other struct_ops users.
+	 * Non-SCX struct_ops: SCX kfuncs are not permitted.
 	 */
 	if (prog->aux->st_ops != &bpf_sched_ext_ops)
-		return in_unlocked ? 0 : -EACCES;
+		return -EACCES;
 
 	/* SCX struct_ops: check the per-op allow list. */
+	if (in_any || in_idle)
+		return 0;
+
 	moff = prog->aux->attach_st_ops_member_off;
 	flags = scx_kf_allow_flags[SCX_MOFF_IDX(moff)];
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 443d12a3df67..c43d62d90e40 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1467,6 +1467,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_idle)
 static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_idle,
+	.filter			= scx_kfunc_context_filter,
 };
 
 /*
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index dc35f850481e..8d169d3bbdf9 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -12,6 +12,7 @@
 
 struct sched_ext_ops;
 
+extern struct btf_id_set8 scx_kfunc_ids_idle;
 extern struct btf_id_set8 scx_kfunc_ids_select_cpu;
 
 void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
-- 
2.48.1

