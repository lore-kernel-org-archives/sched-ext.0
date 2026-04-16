Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D32701CB
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776322048; cv=none; b=MgHYUdnKduDWWJuz1HVGadYFuMQVjSodmDXDYO5MmhyddinLjBRltuFx51D4072uqXAaU9JO0odYVO7FMIThYkgaJsOoE2fmc4O0nAecwA2JxnytNxPSwVZAXAgFgpsmxQSuFtBUpKBGiYuAbcp5OnFw4x2OpOj5rH+Kg3WZTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776322048; c=relaxed/simple;
	bh=T2bk+cbksw5pTyrH/m7bhIA/Az3Qgqu2+PTVON56GZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OayMDqo+Q2RmCQUNbk+IMpslnj4+akWiaAgOMjbmcxp9dvPxEC5GtdqtuUKCagKKHplX/REVidv8QF9L++kKCoJ5Htep02AL+00owIONbdozVKi75wkkeIUGy5G7Dy6quvtmBJJWMefbrctHIKi03AOhT3TWO+unsdTmpp/rAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJnVGUW9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJnVGUW9"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-827270d50d4so6725991b3a.3
        for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 23:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776322047; x=1776926847; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHJWcadZu0oLyHlYGenIryGOmPMMnmgXxdpbwZ8eji8=;
        b=MJnVGUW9DTwOqCN5S+uLnFE9DFSnHiM49j45z//31nyjC8VuSM2LKrlashbu+JqPVZ
         tmBRgj17cZVDDbUbFVQzQUTTzhpq2LYsuR9Cc6uUG7mIYBUgwF1D7azBR0vD1TPCBO20
         eRgefbDvrxPniV3Vtq/NpwA/xuaNFkbxFja/3+/ptVlrOKIvvkWd1ARackowHqNg9TJ+
         4BaDaDplsxXH4BBQ6CPpaUYdlbFc/jwcBN53ziIU0kXowcGfpQuOWcHBCV7oRhtmRX2Y
         /vhHYLc0OnuuOCVb/R7zmw3LYVIsTsoDKElThQyq7hR4HL9MYofWxlDE/fPsYukIpEWO
         G6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776322047; x=1776926847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHJWcadZu0oLyHlYGenIryGOmPMMnmgXxdpbwZ8eji8=;
        b=U/+gtMxUYlpCvH1vqz/LxTanrG+Vbxs0HQ9QJFC8q3M+CBhZKC9nZ8/piFHUhPc5iw
         BJv4X/nU2nUEU4QSPmPIoBuVXc3s+5JypTaE5YTq7rYPoVHkI7abJ4hqHZwufB4cRGOx
         r3GsN20z3umViiI0dD3nWb1RDsCyPGaoBNBByTumrUzusYIJLyFwpD6+rDzqGUVRIE47
         84ctr1EGCL/c5mFuQowWp4GSpO0yJ50KT5I3oBx2WmEAt26JJELoFHJOuVJ2Eb1sBFLX
         KRwwd0N/tXbh/m5/USeTRS5W/Araaksw9ZllpsaYN6XKB8+fA39RR9dYlHlLMXaGPIAi
         LOZQ==
X-Gm-Message-State: AOJu0YzQgo7pTyzz04cIiTnCse2DeaRA20spLH2+Snv9/cYJzzFDa02e
	v8Q+9UDHV0lPVhT6AKVIRCqSYhSYFshApo0rfeNYHhWLufemNUXHIxDt4HJSPVYU
X-Gm-Gg: AeBDiete+VdOa1Rb7IQGo4/mwMbEnAnbAg+wV7LhHg5gb4JVSInatGmgygRF8ZVUrEJ
	JWq1/DLhh6MieDevcYs4MRffWOhuSzF5oIy7IMpW0jmkRzc1aqfaJdvRDXwXSzXB89Ji06l67yo
	pOeNxCEYIcjIRvPvwO9Qcpg3CGugFswjLlcbN8q8vEvVgcrBfEJe/v41dVETPH7ylmJBWFFwSWe
	8c8MCIzxLLM/3fTzgrNiTwD6ItRNT8ab2ol/kjTUkx3vb3SknSA8BhkW5mmBo3o5BNiGWC9zIT5
	yvSR/ncc4YWhsHYfqD6HNNnWw/P3bpij/G2YudtVq6XuolQzyI4HOXEg9e3AX7Rgvne+naD5FJc
	HTYZGE+rIwOhCThYMyzPqCtZjiEeA2on9isp2csWrYnmZHNOYu0bumIiYFgWyrJG6IdzVksDQNm
	kxrRBeeZHx1GDPYX9gqM0lYu3YvoGZ3CY02CNlP/0n1ify7GbX89kD0QThljMp
X-Received: by 2002:a05:6a00:6c89:b0:82a:805a:7cc with SMTP id d2e1a72fcca58-82f0c269212mr26026757b3a.4.1776322046690;
        Wed, 15 Apr 2026 23:47:26 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:49:cbd5:ab58:206c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6d922a38sm3212392b3a.7.2026.04.15.23.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 23:47:26 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 1/2] sched_ext: Deny SCX kfuncs to non-SCX struct_ops programs
Date: Thu, 16 Apr 2026 14:46:40 +0800
Message-ID: <20260416064715.1008437-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260416064715.1008437-1-yphbchou0911@gmail.com>
References: <20260416064715.1008437-1-yphbchou0911@gmail.com>
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

Extend the filter to cover scx_kfunc_set_any as well, and deny all
context-sensitive kfuncs for any struct_ops program that is not the SCX
struct_ops. This addresses both issues: the semantic contract is enforced
at the verifier level, and the runtime out-of-bounds access becomes
unreachable.

Fixes: d1d3c1c6ae36 ("sched_ext: Add verifier-time kfunc context filter")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 012ca8bd70fb..768abc6cf7ad 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9479,6 +9479,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_any)
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_any,
+	.filter			= scx_kfunc_context_filter,
 };
 
 /*
@@ -9530,9 +9531,9 @@ static const u32 scx_kf_allow_flags[] = {
  * .filter field on each per-group btf_kfunc_id_set. The BPF core invokes this
  * for every kfunc call in the registered hook (BPF_PROG_TYPE_STRUCT_OPS or
  * BPF_PROG_TYPE_SYSCALL), regardless of which set originally introduced the
- * kfunc - so the filter must short-circuit on kfuncs it doesn't govern (e.g.
- * scx_kfunc_ids_any) by falling through to "allow" when none of the
- * context-sensitive sets contain the kfunc.
+ * kfunc - so the filter must short-circuit on kfuncs it doesn't govern by
+ * falling through to "allow" when none of the context-sensitive sets contain
+ * the kfunc.
  */
 int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
@@ -9541,18 +9542,19 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	bool in_enqueue = btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id);
 	bool in_dispatch = btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id);
 	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
+	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
 	u32 moff, flags;
 
-	/* Not a context-sensitive kfunc (e.g. from scx_kfunc_ids_any) - allow. */
-	if (!(in_unlocked || in_select_cpu || in_enqueue || in_dispatch || in_cpu_release))
+	/* Not a context-sensitive kfunc - allow. */
+	if (!(in_unlocked || in_select_cpu || in_enqueue || in_dispatch || in_cpu_release || in_any))
 		return 0;
 
 	/* SYSCALL progs (e.g. BPF test_run()) may call unlocked and select_cpu kfuncs. */
 	if (prog->type == BPF_PROG_TYPE_SYSCALL)
-		return (in_unlocked || in_select_cpu) ? 0 : -EACCES;
+		return (in_unlocked || in_select_cpu || in_any) ? 0 : -EACCES;
 
 	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
-		return -EACCES;
+		return in_any ? 0 : -EACCES;
 
 	/*
 	 * add_subprog_and_kfunc() collects all kfunc calls, including dead code
@@ -9565,14 +9567,15 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 		return 0;
 
 	/*
-	 * Non-SCX struct_ops: only unlocked kfuncs are safe. The other
-	 * context-sensitive kfuncs assume the rq lock is held by the SCX
-	 * dispatch path, which doesn't apply to other struct_ops users.
+	 * Non-SCX struct_ops: context-sensitive kfuncs are not permitted.
 	 */
 	if (prog->aux->st_ops != &bpf_sched_ext_ops)
-		return in_unlocked ? 0 : -EACCES;
+		return -EACCES;
 
 	/* SCX struct_ops: check the per-op allow list. */
+	if (in_any)
+		return 0;
+
 	moff = prog->aux->attach_st_ops_member_off;
 	flags = scx_kf_allow_flags[SCX_MOFF_IDX(moff)];
 
-- 
2.48.1

