Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.186
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943337;
	b=GI+sz8w0Ih3oZ0NQNzyLAIpOZgikMtsnlLDGv5uu8EUXikX/Ai5zkkoSCseJ+Cxjr3iQ
	 PXAp82Ap6KgpGHg9CQBSSjIaufpUvtbtKcSYv2cHXd+r2EfBSuK+LVl8bAQFnNn7X5Sp7
	 dCOXq/DsEu2wdQQTD+khE7kv5uJD90Fwf/4jlFv916dAi/fkY6kMFlKiH9K2gG6RRZ7Cd
	 UHlFjdag3fTbD33nUO1bGcV2SDufXX6Y48Z0m6y842UWKhHyw1FBrBqx+9WecxWeXszKX
	 k5R80HQcrFW5RFQ8fzXT/g/PvrADxixqbZiX1nZZywxD5W5Zpu9D+NMBuBidGsBhCjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943337;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P20KLm1KaAoRirf0+sIxhB53NJdW1nHuVs2F2zAtf30=;
	b=RiwxIIPdz1N1OusSZO9u3fdfiGMx0syTPokp0loEzzcNSivDHge//ldGu8iQwwoDRyqg
	 dNSg8lNEElGCf7Q7ES7rVCPYc8LPdBryzmlCqGC1HKiscctVuy9YvJnDNlNOOP5S2OnnZ
	 d+ZmW1luGF8P6ZGSArfAH5UPQ2/3ghxkBweq/ICJQfjWZXdRMZdv1cHVlITmbV+M584Yo
	 /d8CwBGBUkutI2e64AA6W9i6M+/rYCcPgVXUGIfCcySfy1iFnblFEZXoI4UpjYZXyr3eP
	 /HRRUX4mdr0oAERFbq9cQu1DFUK+ThIWT0eafA3KUfe7gv4HEW5IPLxLILkuS4JbRZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oNSSj1KO;
	arc=none smtp.remote-ip=95.215.58.186
Received: from mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1660A2609
	for <sched-ext@lists.linux.dev>; Tue, 17 Nov 2026 19:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D1660A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oNSSj1KO
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=OA4+dCE46Da+A4UU0PXz2FR0qLAbovLtsrkB8nmKYUk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794943335; v=1; x=1795548135;
 b=oNSSj1KOWmT8uVyki+Px3KIzSVITbU8R6cGRYXoXR2j2h32vaaJxhJothKemNDp5X/tth+S/
 mNRW9xIg7NQUh2n4lyW+4W8nKdtpvyGCzw8IXtEuFdIAFhjF2b2EYh3NcjPeHCSj/N//Qwi+4Np
 w7pkyNBUUGba13RLjZtw+8zQ=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id b415f571b790c17b;
	Tue, 17 Nov 2026 19:22:15 +0000
X-Mizu-Trace-ID: b415f571b790c17b
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
Subject: [PATCH bpf-next v1 3/4] resolve_btfids: Reject kfunc families that libbpf can't disambiguate
Date: Tue, 17 Nov 2026 12:21:52 -0700
Message-ID: <20261117192153.3384031-4-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
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

Kfuncs sharing an essential name, foo and foo___<flavor>, form a family.
When resolving a kfunc foo, libbpf binds the kernel's foo if the
prototypes are compatible, and otherwise the only family member whose
prototype passes bpf_core_types_are_compat() against the declaration.
That is only safe if no declaration can be compatible with two members
at once.

bpf_core_types_are_compat() compares prototypes kind by kind, so it
acts as an equivalence and a pairwise check is enough. Run it on every
pair of family members after dedup, using libbpf's own function, and
fail the build if any pair is compatible. A foo___<flavor> with the
same deduplicated FUNC_PROTO as foo is an alias and is allowed: libbpf
binds foo first, so the alias is never picked in its place. There is
only one foo: btf_check_kfunc_name() refuses to register a module kfunc
named like a function in vmlinux or in another module. Dedup compares
parameter names too, so an alias has to copy the signature verbatim.

Recognize family members by their bpf_kfunc decl tags rather than by
the BTF ID sets. The tags are what libbpf filters candidates on, and for
a module they also cover the vmlinux kfuncs in base BTF, so module
kfuncs get checked against vmlinux kfuncs of the same family.

The bpf_kfunc_flavor family in bpf_testmod passes: ___v1 differs in
arity and ___v2 is an alias.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/btf_colors.c |  11 +++
 tools/bpf/resolve_btfids/btf_colors.h |   3 +
 tools/bpf/resolve_btfids/main.c       | 134 ++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)

diff --git a/tools/bpf/resolve_btfids/btf_colors.c b/tools/bpf/resolve_btfids/btf_colors.c
index 5d307d70e7f2..91c10106319e 100644
--- a/tools/bpf/resolve_btfids/btf_colors.c
+++ b/tools/bpf/resolve_btfids/btf_colors.c
@@ -13,6 +13,17 @@ void btf_sha256(const void *data, size_t len,
 	libbpf_sha256(data, len, out);
 }
 
+size_t btf_essential_name_len(const char *name)
+{
+	return bpf_core_essential_name_len(name);
+}
+
+int btf_types_are_compat(const struct btf *btf1, __u32 id1,
+			 const struct btf *btf2, __u32 id2)
+{
+	return bpf_core_types_are_compat(btf1, id1, btf2, id2);
+}
+
 /*
  * Marks `root_id` and local types reachable from it with `color`.
  * `colors` is indexed by source ID; worklist has room for every local type.
diff --git a/tools/bpf/resolve_btfids/btf_colors.h b/tools/bpf/resolve_btfids/btf_colors.h
index 56a85a242d6b..3d48194e73b6 100644
--- a/tools/bpf/resolve_btfids/btf_colors.h
+++ b/tools/bpf/resolve_btfids/btf_colors.h
@@ -15,6 +15,9 @@ enum btf_color {
 
 void btf_sha256(const void *data, size_t len,
 		__u8 out[BTF_SHA256_DIGEST_LENGTH]);
+size_t btf_essential_name_len(const char *name);
+int btf_types_are_compat(const struct btf *btf1, __u32 id1,
+			 const struct btf *btf2, __u32 id2);
 void btf_mark_reachable(struct btf *btf, __u32 root, enum btf_color color,
 			__u8 *colors, __u32 *worklist);
 
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 0ac895222a14..68a5519cf8b6 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -1917,6 +1917,136 @@ static int sort_btf_by_name(struct btf *btf)
 	return err;
 }
 
+static const char *func_name(const struct btf *btf, u32 id)
+{
+	return btf__name_by_offset(btf, btf__type_by_id(btf, id)->name_off);
+}
+
+static int cmp_essential_names(const void *a, const void *b, void *priv)
+{
+	const char *na = func_name(priv, *(u32 *)a);
+	const char *nb = func_name(priv, *(u32 *)b);
+	size_t la = btf_essential_name_len(na);
+	size_t lb = btf_essential_name_len(nb);
+	int r = strncmp(na, nb, min(la, lb));
+
+	if (r != 0)
+		return r;
+	if (la == lb)
+		return 0;
+	return la < lb ? -1 : 1;
+}
+
+/*
+ * Returns 1 if libbpf can't tell kfuncs a and b of one family apart, 0 if it
+ * can, or a negative error.
+ */
+static int kfuncs_are_ambiguous(const struct btf *btf, u32 a, u32 b, u32 unsuffixed_proto)
+{
+	const char *na = func_name(btf, a), *nb = func_name(btf, b);
+	u32 pa = btf__type_by_id(btf, a)->type;
+	u32 pb = btf__type_by_id(btf, b)->type;
+	int ret;
+
+	if (pa == pb && pa == unsuffixed_proto) {
+		pr_debug("kfuncs %s and %s: alias\n", na, nb);
+		return 0;
+	}
+	ret = btf_types_are_compat(btf, pa, btf, pb);
+	if (ret < 0) {
+		pr_err("ERROR: resolve_btfids: failed to compare kfuncs %s and %s: %d\n",
+		       na, nb, ret);
+		return ret;
+	}
+	if (ret == 0)
+		pr_debug("kfuncs %s and %s: distinct\n", na, nb);
+	return ret;
+}
+
+static int check_kfunc_family(const struct btf *btf, const u32 *ids, u32 cnt, u32 start_id)
+{
+	size_t len = btf_essential_name_len(func_name(btf, ids[0]));
+	u32 unsuffixed_proto = 0;
+	int err, bad = 0;
+
+	for (u32 i = 0; i < cnt; i++) {
+		const char *name = func_name(btf, ids[i]);
+
+		if (name[len] == '\0')
+			unsuffixed_proto = btf__type_by_id(btf, ids[i])->type;
+	}
+
+	for (u32 i = 0; i < cnt; i++) {
+		for (u32 j = i + 1; j < cnt; j++) {
+			/* base BTF pairs were checked when building vmlinux */
+			if (ids[i] < start_id && ids[j] < start_id)
+				continue;
+			err = kfuncs_are_ambiguous(btf, ids[i], ids[j], unsuffixed_proto);
+			if (err < 0)
+				return err;
+			if (err == 0)
+				continue;
+			pr_err("ERROR: resolve_btfids: kfuncs %s and %s have compatible prototypes, libbpf cannot tell them apart\n",
+			       func_name(btf, ids[i]), func_name(btf, ids[j]));
+			bad++;
+		}
+	}
+
+	return bad ? -EINVAL : 0;
+}
+
+/*
+ * Fail if libbpf can't tell apart two kfuncs sharing an essential name, i.e.
+ * if bpf_core_types_are_compat() finds their prototypes compatible. An alias
+ * of the unsuffixed kfunc, which has its type id after dedup, is allowed:
+ * libbpf binds the unsuffixed kfunc first.
+ *
+ * Kfuncs are recognized by their bpf_kfunc decl tags: these are what libbpf
+ * looks at, and for a module they also cover the vmlinux kfuncs in base BTF.
+ */
+static int check_kfunc_families(struct btf *btf)
+{
+	const struct btf *base = btf__base_btf(btf);
+	u32 start_id = base ? btf__type_cnt(base) : 1;
+	u32 type_cnt = btf__type_cnt(btf);
+	u32 *ids = NULL, nr_ids = 0, cap = 0;
+	int ret, err = 0;
+
+	for (u32 id = 1; id < type_cnt; id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+		const char *tag_name;
+
+		if (!btf_is_decl_tag(t))
+			continue;
+		if (btf_decl_tag(t)->component_idx != -1)
+			continue;
+		tag_name = btf__name_by_offset(btf, t->name_off);
+		if (strcmp(tag_name, DECL_TAG_KFUNC) != 0)
+			continue;
+		err = ensure_mem(&ids, &cap, nr_ids + 1);
+		if (err)
+			goto out;
+		ids[nr_ids++] = t->type;
+	}
+
+	qsort_r(ids, nr_ids, sizeof(*ids), cmp_essential_names, btf);
+
+	for (u32 i = 0, j; i < nr_ids; i = j) {
+		for (j = i + 1; j < nr_ids; j++) {
+			if (cmp_essential_names(&ids[i], &ids[j], btf) != 0)
+				break;
+		}
+		if (j - i < 2)
+			continue;
+		ret = check_kfunc_family(btf, ids + i, j - i, start_id);
+		if (ret)
+			err = ret;
+	}
+out:
+	free(ids);
+	return err;
+}
+
 static int finalize_btf(struct object *obj)
 {
 	struct btf *base_btf = obj->base_btf, *btf = obj->btf;
@@ -1928,6 +2058,10 @@ static int finalize_btf(struct object *obj)
 		return err;
 	}
 
+	err = check_kfunc_families(obj->btf);
+	if (err)
+		return err;
+
 	if (obj->base_btf && obj->distill_base) {
 		err = btf__distill_base(obj->btf, &base_btf, &btf);
 		if (err) {
-- 
2.56.1

