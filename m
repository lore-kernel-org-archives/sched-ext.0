Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795221289;
	b=QajmmtvidZ3fgs9e2pgttaDcWYCHXai+O+TGO7XJHuaUQgS6NRiSRMpsaWnY8/73mapi
	 7fq4PE1ojq/BOjaLCzcXnA0XvB5PHKS1FFrTOwscKEs9Jej7ObyoyBKDFnkT8+NDcWj3c
	 UDCJ5CkSqA9uiQm6UGjFjlEIP6o81FpMnBisHzR/7XM3+8fXiOv1l3L5fu4SzwVOCq70D
	 FBaeZODG6q0U2sWhQI/mOBP+cQ7jqrMYurpXrwLUaoMFJ+HLbwTkVQHjXezZ/TVugflVX
	 bteKxQQYMxHsPxt4b6PSyPriikVQEJ2mlJ3bpnqoeOcUoC9YrIJRXxkHEa/wRPNClhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795221289;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=16uHI/wiILJAgxZZpw+Ll3nL/DkkAuBU3LPRe4/AFK0=;
	b=oRauOBbPO22M5vplOFsvPIfU/LLt4Nmsx8VVAIMrhnW/3GKn3JHXZVhLcMFYgc4ccALj
	 K5qflKJ8Uk3gOlN3dqSeBcLrAZo+jKNmDRH+gx3UZLCfMJf9ADLGfqqN4ksUirUcA8vyz
	 nqIHdPAtklaHUVxXnGD1Ba1pxkMtZTHZJQuu+0PKioPD9E82awfPyPPh4cKPGJWXinqBS
	 PatjV40V3aRqs8KEI+C48wxvrTqVGl5sCA0imgBQfsTHeIfo1w+x2kqhyWv0Abg/n4S0V
	 HaDi/FyFTntMfXSv401GKQNpqI7tWgOb+bnSGxvINqYj09TRvioDEzgvmmK7A2xEKSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fl3MurGo;
	arc=none smtp.remote-ip=95.215.58.179
Received: from mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275E606A699
	for <sched-ext@lists.linux.dev>; Sat, 21 Nov 2026 00:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3275E606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fl3MurGo
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=chSHStAxYYQbOaPVRpfqdX9lguVoKe6kfnjSXgmTuSc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795221282; v=1; x=1795826082;
 b=fl3MurGoH7lHrmHdOMDOKMsubUBXWP+pz9sD0PKTGgoj4GrzFKNVVFldsMyhMu8hj+JVnaRK
 hIvgNK0lHHiyudGrfkgLEAyplOJSfGv6zpPm2vvuPvelj/qtQ8Z57yEs0JFr5ft99nogRcX/3zt
 NEhbOerSu6RBh9C5vNL9bzj8=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id f63e0e71d92a25d7;
	Sat, 21 Nov 2026 00:34:42 +0000
X-Mizu-Trace-ID: f63e0e71d92a25d7
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
Subject: [PATCH bpf-next v2 5/6] resolve_btfids: Reject ambiguous kfunc variants
Date: Fri, 20 Nov 2026 17:34:02 -0700
Message-ID: <20261121003403.2928928-6-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121003403.2928928-1-ihor.solodrai@linux.dev>
References: <20261121003403.2928928-1-ihor.solodrai@linux.dev>
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
2.56.1

