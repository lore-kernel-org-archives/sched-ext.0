Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389003A6EE2
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557823; cv=none; b=P40Yxe+z6PSzGKh4rzmzzuRkuXin9HsccUHHc6rbwqhoPt8m0pTHjyDYGv2N68DwRZlL6ctezn+iGDdgPEv4u+iqP+rMOsq/XBF6PfjKG4V7Dg+G8VZG32XdK+dHZRFM3oP9rJ3+XbuMQnlnR9+MNj6eSxdWM3FrGTP8nZ+yp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557823; c=relaxed/simple;
	bh=egOiypsJwjF8/djFU7mQxlppV2Rai+dGuGmpTuFy1W8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRRGoBBV6lvpDJUr2q8AF5T/CkKo1EqS5cla3PY03UhkzVkAUqBMetRUm/D3dMtuizhJV9Atd/OtnA/N00zL7Cr/Y2dwPbewkdD8gK0bPjrKxsLo/VCldN0SoULMhO+/5wRwtx9abkTezo30UnjWH6UdEpKn8huES6EhUHL677M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcuEktid; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcuEktid"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b056b7f783so6467405ad.1
        for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774557821; x=1775162621; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ig5sdFszUgYcFHRRqi6hTRlPGGoN0upuWT6iWptjeag=;
        b=hcuEktidyqkugGeS7q+qybjtDTaoMDd1qNKFUQ/HmSR19+gN7dTa6xGRJh+r0894/V
         SgpN3HoCQVAmA2yRBWB5vkX1XlxdnLEnyXl48KgMExa7qssSjmpMNQjNM8PDvI7S+Tox
         cxhYfttixF2cHMhkPyp1mUOAHjoM/lCA51xflQymJg1I53fZL5sc1arAH8VWv5VnaC/G
         YG2tbZ+ysdrb6aYZ5QKn1RImNUIG/uBzgvfr2Giccv43PxMlDrOScgI6Fax5EPgh/bNO
         aB0tKmdSIi1Fp1GuWyb9hZ5VuKvQwWMzx0IxKq+zSBpJ+qbPvijKOYSCHc8dwYsMlWbk
         a5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557821; x=1775162621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig5sdFszUgYcFHRRqi6hTRlPGGoN0upuWT6iWptjeag=;
        b=P7FCCIbwZZPhlVwVTTrq54FsWKxQbCjOk0rPlCsQhD5R67cXUog4LPKZJHJsyEnAQ8
         eWb5032ym3O35IcrBdjSG38Rl52vPx4kbHNipOUx7S3pf2F7In1liEro+cRwiFaCCp1y
         ZMja3W0QMrjaX0WezDf0OS6Ayyeb+TkS3PfkGkEoTYeUUK0pDE1xUW4ACY65bYARxaKe
         c65e/y1BHHFjQnZgyWPqBqEVahFEr3p+eCunW6dltXK9I7snz+zE+ft239luAuYaXX/N
         hTbXII6t9M4wLQsOgSIsK1xVLIMv7r/wpj7MkHrr6IOWjh4DM36u1KeVDrdhw/AESFqZ
         8QfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmMY2fzmvjvPj387oL8NTI21igQwrE9z0M8o6eV5eE3uMe/+E7B4yJu2gcjHkwmHXC6UUWIbGQy9A=@lists.linux.dev
X-Gm-Message-State: AOJu0YwFt0kCFoRGydzv57VWwztBSkYmTpqW6tsMFru550v0kITnrdIK
	WUV48zUpR+T92h8tkQyjBoGI7lF+TK/C+qgCa3UQSZgdRm+nHoDwPK9y
X-Gm-Gg: ATEYQzznTOi8cbPuAW/SN46YEuncTcDJrFDFevtKt9T1BRzB8QExGpYXPzJA9v7E01P
	k1axikB+mmlsMN8Mgty5v0jhepbWHq4ODFy0ZpXFswWDZG7yxNvhxK00OFceuNqdlTr9rjYKkQ5
	q0qaRxMgxnCei1dyiHC2Axz6D9Z7iA4Sb3CQzfkW56hutLXdq1WQGu6E1dYn4NNfI986T3iaetE
	TxOpt7OMzJr2bl/wxDjmpGFCSiu7/+9CK/SluDM3bYnQ7rQVh1Dy6puL6xvMLc3CAN6fWuK7rld
	L7THJeGv4HEydsDEH9KgWJjNb1XwLmuf65i1N5HcKLllNxKigo6erTNLkTQ/DSMxartCow090KW
	bAYn3BYUrG3GCnSsOw9NNg8IINC9JU+ztiZ1BcyYrAEXhy789sQylWq+x/XR4syNWGYbVy+49a9
	k2wbZ9yYVwfx5GPeVbIQpVgURAz4AtbLAvX1WNK0evA2ra3SLskki/4xf9Mup52vvKEwjh2fKbS
	xc=
X-Received: by 2002:a17:902:d4cb:b0:2b0:6ba2:3d78 with SMTP id d9443c01a7336-2b0c48136a4mr28286055ad.3.1774557821400;
        Thu, 26 Mar 2026 13:43:41 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc90d2cdsm46885085ad.75.2026.03.26.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:43:41 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	sched-ext@lists.linux.dev,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] libbpf: resolve versioned kfuncs by exact name before essential-name lookup
Date: Fri, 27 Mar 2026 04:43:35 +0800
Message-ID: <20260326204335.3756885-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some kfuncs use KF_IMPLICIT_ARGS and export both a base name (where
the verifier strips the implicit aux parameter from the prototype) and
a versioned name with additional user-visible parameters (e.g.
scx_bpf_dsq_move_to_local vs scx_bpf_dsq_move_to_local___v2).

When a BPF program declares a weak __ksym with a flavor suffix such as
func___v2, libbpf strips the suffix to obtain the essential name and
looks up the base entry first.  For KF_IMPLICIT_ARGS kfuncs the base
entry has fewer parameters (aux was stripped); the prototype
compatibility check against the versioned declaration (which has the
extra user parameter) then fails, and libbpf leaves the weak symbol
unresolved even though a perfectly-matching versioned kernel entry exists.

Fix by trying an exact-name lookup first when the symbol has an
essential name (i.e. it has a flavor suffix).  If the exact name is
found in kernel BTF and its prototype is compatible, use it directly.
Only fall through to the essential-name lookup when the exact name is
absent or incompatible.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 tools/lib/bpf/libbpf.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..80e495aebe68 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8630,6 +8630,40 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 
 	local_func_proto_id = ext->ksym.type_id;
 
+	/*
+	 * For kfuncs with a flavor suffix (e.g. "func___v2"), first try the
+	 * exact name.  If the exact name exists in kernel BTF and its
+	 * prototype is compatible, use it directly.  This is necessary for
+	 * KF_IMPLICIT_ARGS kfuncs that export both a base name (with the
+	 * implicit aux parameter stripped) and a versioned name with extra
+	 * parameters: the essential-name lookup would find the base entry
+	 * (fewer params) and fail the compat check, leaving the weak symbol
+	 * unresolved even though the versioned kernel entry is a perfect
+	 * match.
+	 */
+	if (ext->essent_name) {
+		struct module_btf *exact_mod_btf = NULL;
+		struct btf *exact_btf = NULL;
+		int exact_id;
+
+		exact_id = find_ksym_btf_id(obj, ext->name, BTF_KIND_FUNC,
+					    &exact_btf, &exact_mod_btf);
+		if (exact_id >= 0) {
+			kern_func = btf__type_by_id(exact_btf, exact_id);
+			kfunc_proto_id = kern_func->type;
+			ret = bpf_core_types_are_compat(obj->btf,
+							local_func_proto_id,
+							exact_btf,
+							kfunc_proto_id);
+			if (ret > 0) {
+				kern_btf = exact_btf;
+				mod_btf = exact_mod_btf;
+				kfunc_id = exact_id;
+				goto found;
+			}
+		}
+	}
+
 	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
 				    &mod_btf);
 	if (kfunc_id < 0) {
@@ -8655,6 +8689,7 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 		return -EINVAL;
 	}
 
+found:
 	/* set index for module BTF fd in fd_array, if unset */
 	if (mod_btf && !mod_btf->fd_array_idx) {
 		/* insn->off is s16 */
-- 
2.43.0

