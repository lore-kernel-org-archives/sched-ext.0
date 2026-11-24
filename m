Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560525;
	b=vKT/AXlZJpgMLld9f+wGlTkYi/2POiD9Oic93BAJgzT94B57juLuFZuxeoy1N97UxibE
	 LmvdKngEBY+3kD1dQdUIChkdojR4dr7aakJD37dG7h84gprBsW0ME4VV6IWhsACvyI5nl
	 CayGkHHWn+S7Hv25VZ8p7d+kjEboMrUnB+mrzQloaxLdDI7DofKsWOlCSwl3bUHmqP56+
	 XMUPnD4hjPyGQRFh3xxWE17wqWc1r53yxr6EpkPi3gaLVNIbI7uQBOEyY+nk+8p8cwXLF
	 XNeGxAMLHdMk5mGNko/U+GEwkvQU6EsSpwGjKfkfb20Mh/riMeWgkRgcPjsbHT5ADzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560525;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6wjOzGU8wFSb9+4j9IB20HEtOP5PcwiSTLoefqj+xPI=;
	b=UGCSDVi3eJY1oa4XKZER6uGziBRKjt0VNGL94CeXMGWktX83Y5FysT2ce1Ch14cIBS8w
	 4ZV/YPBM3on0FLzOwydUKVJaa9Cz+oIOc6Wzu/xHxUuLP03hvumN/CT8B0c86G3PlMKWz
	 DblWWmm90X7Row437ykSEX9aDbIp5VvxwMI9CRFgn0yjMYbzuqlmVWC6fx3t/np6tb07Z
	 oZ+OglbvOZqZ+cg16cpp7lqxBVRHfmZmO3XY0oGH4HvuX6FNvre/TSOg/tGC+OUGBSzcc
	 wzc/DbGzh8vLklwZe1kX10NffrUBbAtoPHw+H7j7lO+tHpGI2/dTYiqacCqPZ+xiE2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="EqC01J0/";
	arc=none smtp.remote-ip=91.218.175.191
Received: from mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B80606A329
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 22:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93B80606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EqC01J0/
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=BFyhtG+w37cAmuVAdcKU6EMG/hj7GNHCLQPRWjUEC8I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795560522; v=1; x=1796165322;
 b=EqC01J0/RoEYjdEXCBT6mzhATyZVS+ipoJEP7fq/AGdK2T72XHOVtgTa4sONqYZSD2utFRjg
 iOxB9goQCCJ3bNhHOKFN37O6QrC5wqYWJgJp/msmgYHaPhLbObBxVKneT4rlVjP37NoijfINB92
 m6AG8RFh7WGk7sQXAlvY3uGw=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 376c3601e76205b5;
	Tue, 24 Nov 2026 22:48:42 +0000
X-Mizu-Trace-ID: 376c3601e76205b5
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Song Liu <song@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v3 5/6] resolve_btfids: Reject ambiguous kfunc variants
Date: Tue, 24 Nov 2026 15:48:10 -0700
Message-ID: <20261124224811.16134-6-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124224811.16134-1-ihor.solodrai@linux.dev>
References: <20261124224811.16134-1-ihor.solodrai@linux.dev>
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

libbpf fails to load a program if a kfunc declaration matches more
than one kfunc variant. For example, libbpf doesn't distinguish
integer widths, so a declaration of either of these matches both:

  int bpf_foo(u32 flags);
  int bpf_foo___v1(u64 flags);

Check the kfuncs registered in vmlinux or a module at build time, so
that such a pair fails the build instead. Group them by essential name
and compare prototypes with libbpf's matcher. Skip unregistered
functions, which libbpf also considers, so that code unrelated to
kfuncs can't fail the build. Variants split across modules or vmlinux
are also caught only by libbpf.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/bpf/resolve_btfids/main.c | 69 +++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 0e193c3c73aa..e21ac6843873 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -94,6 +94,7 @@
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #include <bpf/libbpf_tools.h>
+#include <bpf/relo_core.h>
 #include "btf_colors.h"
 #include "fmodret.h"
 #include <subcmd/parse-options.h>
@@ -1918,6 +1919,70 @@ static int sort_btf_by_name(struct btf *btf)
 	return err;
 }
 
+struct kfunc_variant {
+	const char *name;
+	size_t essent_len;
+	u32 id;
+};
+
+static int cmp_kfunc_variants(const void *lhs, const void *rhs)
+{
+	const struct kfunc_variant *a = lhs, *b = rhs;
+	int ret = strncmp(a->name, b->name, min(a->essent_len, b->essent_len));
+
+	return ret ?: (a->essent_len > b->essent_len) - (a->essent_len < b->essent_len);
+}
+
+/* libbpf rejects a declaration that matches more than one kfunc variant */
+static int check_kfunc_variants(const struct btf *btf)
+{
+	const struct btf *base = btf__base_btf(btf);
+	struct kfunc_variant *kfuncs = NULL;
+	u32 cnt = 0, cap = 0;
+	int err = 0;
+
+	for (u32 id = base ? btf__type_cnt(base) : 1; id < btf__type_cnt(btf); id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+		const char *name;
+
+		if (!btf_is_decl_tag(t) || btf_decl_tag(t)->component_idx != -1)
+			continue;
+		if (strcmp(btf__name_by_offset(btf, t->name_off), DECL_TAG_KFUNC) != 0)
+			continue;
+
+		err = ensure_mem(&kfuncs, &cap, cnt + 1);
+		if (err)
+			goto out;
+		name = btf__name_by_offset(btf, btf__type_by_id(btf, t->type)->name_off);
+		kfuncs[cnt++] = (struct kfunc_variant){
+			.name = name,
+			.essent_len = bpf_core_essential_name_len(name),
+			.id = t->type,
+		};
+	}
+	qsort(kfuncs, cnt, sizeof(*kfuncs), cmp_kfunc_variants);
+
+	for (u32 i = 0; i < cnt; i++) {
+		const struct btf_type *a = btf__type_by_id(btf, kfuncs[i].id);
+
+		for (u32 j = i + 1; j < cnt; j++) {
+			const struct btf_type *b;
+
+			if (cmp_kfunc_variants(&kfuncs[i], &kfuncs[j]) != 0)
+				break;
+			b = btf__type_by_id(btf, kfuncs[j].id);
+			if (btf_kfunc_proto_match(btf, a->type, btf, b->type) <= 0)
+				continue;
+			pr_err("ERROR: resolve_btfids: kfuncs %s and %s have matching prototypes\n",
+			       kfuncs[i].name, kfuncs[j].name);
+			err = -EINVAL;
+		}
+	}
+out:
+	free(kfuncs);
+	return err;
+}
+
 static int finalize_btf(struct object *obj)
 {
 	struct btf *base_btf = obj->base_btf, *btf = obj->btf;
@@ -1929,6 +1994,10 @@ static int finalize_btf(struct object *obj)
 		return err;
 	}
 
+	err = check_kfunc_variants(obj->btf);
+	if (err)
+		return err;
+
 	if (obj->base_btf && obj->distill_base) {
 		err = btf__distill_base(obj->btf, &base_btf, &btf);
 		if (err) {
-- 
2.56.0

