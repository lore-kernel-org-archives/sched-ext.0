Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560508;
	b=OUo4Fx2m/M8w115tlS4uoprtGkaECsB9BWY5QzE/uMaVL54fXoqOPrzoJp6CkoQsOctq
	 ifTngIBECBwgVoLBXtPE0L3Y8QlfAAjW1XTYej2poAGhlby/PjIbHjIAzPul8lBvmALRq
	 ZZUyhqcd+2wPAMeJdy+UI+jrx0uvZkzntE9+igW2O68nE2xxf3vbul0jmikjiv58UUGXD
	 elJMTyPSUMEpkzIoIBmbR+grDU2jCfQb4AeUYmyU/wUjRSXG2qAPzZHM9ADAfGDetYObT
	 DV15wRh9i3faKn6nZ262xNsp1OSVMq5xAk8MOuxln00aH1UUlbdT/8o9rGKJc5GfODQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560508;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F7jWMMdIFqjVqKv+xCOiXr2uZGgG/WpfoM2zFX2xncU=;
	b=ZcOld/CryGlcLqMoIrUoD8ucNj5BiIbEcRUPNr1QFaPmp1OSdNAA1viyDillB/SuVP1f
	 fMWh1RAglelOA1e/7e8n7/kFgXTd0Vdd3fdpnoUtA67l3/1nKVwRhP34oBl6FdTMDNHVr
	 0WZiOFlMN7IqyZgubcjWHsA+vHdSVmJMlXLnQO0sSdjhQ4HWTb8mtbX0/sor0VVDU9L6D
	 2YgNrTqjyAbo0EA+/o4mU66loGEih4ZzNMt6970/Sb0OlzdJ9mFwPK1zpi/M/strbVKVS
	 tw06KmrG0TEyZyVNzUZefIHlNQokj/Z+NYp2uauXMzIBFGqKE9s5sLUt1/1js6RwKgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eoj2RoUW;
	arc=none smtp.remote-ip=95.215.58.47
Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB0606A326
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 22:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEEB0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eoj2RoUW
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=YYbBWFWIDkawZ2+cDvlI2yRTmkX5WPOSODkS2in79sg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795560504; v=1; x=1796165304;
 b=eoj2RoUWK8Fhu3UiZf4QW20yRZttesNqQi9/wv71rr459CjnnP+iZ5B6vlXtsBAeiLuF6LD2
 pl2Tacw4G7usLeuMAJTEgfk7j8spUlE/WD9db2U614mp63qto+7Gtm91a85Xtv55Env+tt6FrHT
 0J9Z9FySj2SGV+3cmc0W5FhM=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 2cfd0229251cf346;
	Tue, 24 Nov 2026 22:48:24 +0000
X-Mizu-Trace-ID: 2cfd0229251cf346
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
Subject: [PATCH bpf-next v3 1/6] libbpf: Separate interfaces shared with in-tree tools
Date: Tue, 24 Nov 2026 15:48:06 -0700
Message-ID: <20261124224811.16134-2-ihor.solodrai@linux.dev>
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

resolve_btfids and bpftool link libbpf statically and use some of its
internal helpers from libbpf_internal.h. That header also defines
logging macros and poisons kernel integer typedefs, so resolve_btfids
wraps the SHA-256 helper in a separate source file.

Move the declarations these tools use to libbpf_tools.h and include it
instead of libbpf_internal.h. The header is for in-tree tools and stays
uninstalled. No shared-library symbols change.

No functional change.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/Makefile            |   6 +-
 tools/bpf/bpftool/common.c            |   2 +-
 tools/bpf/bpftool/gen.c               |   3 +-
 tools/bpf/bpftool/prog.c              |   2 +-
 tools/bpf/bpftool/xlated_dumper.c     |   2 +-
 tools/bpf/resolve_btfids/btf_colors.c |  15 +--
 tools/bpf/resolve_btfids/btf_colors.h |   4 -
 tools/bpf/resolve_btfids/main.c       |   5 +-
 tools/lib/bpf/libbpf_internal.h       | 162 +----------------------
 tools/lib/bpf/libbpf_tools.h          | 184 ++++++++++++++++++++++++++
 10 files changed, 199 insertions(+), 186 deletions(-)
 create mode 100644 tools/lib/bpf/libbpf_tools.h

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 49dabf2eded0..ded4a9e79728 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -28,10 +28,10 @@ LIBBPF_BOOTSTRAP_INCLUDE := $(LIBBPF_BOOTSTRAP_DESTDIR)include
 LIBBPF_BOOTSTRAP_HDRS_DIR := $(LIBBPF_BOOTSTRAP_INCLUDE)/bpf
 LIBBPF_BOOTSTRAP := $(LIBBPF_BOOTSTRAP_OUTPUT)libbpf.a
 
-# We need to copy hashmap.h, nlattr.h, relo_core.h and libbpf_internal.h
+# We need to copy hashmap.h, nlattr.h, relo_core.h and libbpf_tools.h
 # which are not otherwise exported by libbpf, but still required by bpftool.
-LIBBPF_INTERNAL_HDRS := $(addprefix $(LIBBPF_HDRS_DIR)/,hashmap.h nlattr.h relo_core.h libbpf_internal.h)
-LIBBPF_BOOTSTRAP_INTERNAL_HDRS := $(addprefix $(LIBBPF_BOOTSTRAP_HDRS_DIR)/,hashmap.h relo_core.h libbpf_internal.h)
+LIBBPF_INTERNAL_HDRS := $(addprefix $(LIBBPF_HDRS_DIR)/,hashmap.h nlattr.h relo_core.h libbpf_tools.h)
+LIBBPF_BOOTSTRAP_INTERNAL_HDRS := $(addprefix $(LIBBPF_BOOTSTRAP_HDRS_DIR)/,hashmap.h relo_core.h libbpf_tools.h)
 
 $(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT) $(LIBBPF_HDRS_DIR) $(LIBBPF_BOOTSTRAP_HDRS_DIR):
 	$(QUIET_MKDIR)mkdir -p $@
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index ca5fa2f0bf9b..1f2099c17252 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -31,7 +31,7 @@
 #include <bpf/bpf.h>
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
-#include <bpf/libbpf_internal.h>
+#include <bpf/libbpf_tools.h>
 #include <bpf/btf.h>
 #include <zlib.h>
 
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ee680f7c2116..dc0adeacf9a8 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -15,7 +15,8 @@
 #include <unistd.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
-#include <bpf/libbpf_internal.h>
+#include <bpf/libbpf_tools.h>
+#include <bpf/relo_core.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 15efc6eebffb..a7b2ea9fbd80 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -29,7 +29,7 @@
 #include <bpf/btf.h>
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h>
-#include <bpf/libbpf_internal.h>
+#include <bpf/libbpf_tools.h>
 #include <bpf/skel_internal.h>
 
 #include "cfg.h"
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 5579173a61e3..fc83785c0ae3 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -10,7 +10,7 @@
 #include <string.h>
 #include <sys/types.h>
 #include <bpf/libbpf.h>
-#include <bpf/libbpf_internal.h>
+#include <bpf/libbpf_tools.h>
 
 #include "disasm.h"
 #include "json_writer.h"
diff --git a/tools/bpf/resolve_btfids/btf_colors.c b/tools/bpf/resolve_btfids/btf_colors.c
index 5d307d70e7f2..7374aa2f8963 100644
--- a/tools/bpf/resolve_btfids/btf_colors.c
+++ b/tools/bpf/resolve_btfids/btf_colors.c
@@ -1,18 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <bpf/libbpf_internal.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <bpf/libbpf_tools.h>
 #include "btf_colors.h"
 
-/*
- * Functions in this file mainly exist to refer to functions from libbpf_internal.h,
- * which can't be included in main.c because of the u32 poison and pr_warn macro conflicts.
- */
-
-void btf_sha256(const void *data, size_t len,
-		__u8 out[BTF_SHA256_DIGEST_LENGTH])
-{
-	libbpf_sha256(data, len, out);
-}
-
 /*
  * Marks `root_id` and local types reachable from it with `color`.
  * `colors` is indexed by source ID; worklist has room for every local type.
diff --git a/tools/bpf/resolve_btfids/btf_colors.h b/tools/bpf/resolve_btfids/btf_colors.h
index 56a85a242d6b..9cea757cb356 100644
--- a/tools/bpf/resolve_btfids/btf_colors.h
+++ b/tools/bpf/resolve_btfids/btf_colors.h
@@ -11,10 +11,6 @@ enum btf_color {
 	BTF_COLOR_SHARED = BTF_COLOR_MAIN | BTF_COLOR_LOC,
 };
 
-#define BTF_SHA256_DIGEST_LENGTH	32
-
-void btf_sha256(const void *data, size_t len,
-		__u8 out[BTF_SHA256_DIGEST_LENGTH]);
 void btf_mark_reachable(struct btf *btf, __u32 root, enum btf_color color,
 			__u8 *colors, __u32 *worklist);
 
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 0ac895222a14..0e193c3c73aa 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -93,12 +93,14 @@
 #include <linux/limits.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
+#include <bpf/libbpf_tools.h>
 #include "btf_colors.h"
 #include "fmodret.h"
 #include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
 #define BTF_LINK_MODULE_NAME_MAX	64
+#define BTF_SHA256_DIGEST_LENGTH	SHA256_DIGEST_LENGTH
 #define BTF_ID_PREFIX	"__BTF_ID__"
 
 #define BTF_STRUCT	"struct"
@@ -1205,8 +1207,7 @@ static int patch_btf_link(struct object *obj, const struct btf_link *link)
 	}
 	memset(data->d_buf, 0, data->d_size);
 	memcpy(data->d_buf, link->module, strlen(link->module) + 1);
-	btf_sha256(raw_btf_data, raw_btf_size,
-		   (u8 *)data->d_buf + module_name_len);
+	libbpf_sha256(raw_btf_data, raw_btf_size, (u8 *)data->d_buf + module_name_len);
 	size = (u8 *)data->d_buf + module_name_len + BTF_SHA256_DIGEST_LENGTH;
 	if (obj->efile.encoding == ELFDATA2LSB) {
 		size[0] = raw_btf_size;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index e90b5336bac0..8e6f15e2f1bf 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -18,6 +18,7 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <libelf.h>
+#include "libbpf_tools.h"
 #include "relo_core.h"
 
 /* Android's libc doesn't support AT_EACCESS in faccessat() implementation
@@ -94,12 +95,6 @@
 #define BTF_TYPE_TYPE_TAG_ENC(value, type) \
 	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TYPE_TAG, 0, 0), type)
 
-#ifndef likely
-#define likely(x) __builtin_expect(!!(x), 1)
-#endif
-#ifndef unlikely
-#define unlikely(x) __builtin_expect(!!(x), 0)
-#endif
 #ifndef min
 # define min(x, y) ((x) < (y) ? (x) : (y))
 #endif
@@ -184,10 +179,6 @@ const char *libbpf_errstr(int err);
 
 #define errstr(err) libbpf_errstr(err)
 
-#ifndef __has_builtin
-#define __has_builtin(x) 0
-#endif
-
 struct bpf_link {
 	int (*detach)(struct bpf_link *link);
 	void (*dealloc)(struct bpf_link *link);
@@ -196,30 +187,6 @@ struct bpf_link {
 	bool disconnected;
 };
 
-/*
- * Re-implement glibc's reallocarray() for libbpf internal-only use.
- * reallocarray(), unfortunately, is not available in all versions of glibc,
- * so requires extra feature detection and using reallocarray() stub from
- * <tools/libc_compat.h> and COMPAT_NEED_REALLOCARRAY. All this complicates
- * build of libbpf unnecessarily and is just a maintenance burden. Instead,
- * it's trivial to implement libbpf-specific internal version and use it
- * throughout libbpf.
- */
-static inline void *libbpf_reallocarray(void *ptr, size_t nmemb, size_t size)
-{
-	size_t total;
-
-#if __has_builtin(__builtin_mul_overflow)
-	if (unlikely(__builtin_mul_overflow(nmemb, size, &total)))
-		return NULL;
-#else
-	if (size == 0 || nmemb > ULONG_MAX / size)
-		return NULL;
-	total = nmemb * size;
-#endif
-	return realloc(ptr, total);
-}
-
 /* Copy up to sz - 1 bytes from zero-terminated src string and ensure that dst
  * is zero-terminated string no matter what (unless sz == 0, in which case
  * it's a no-op). It's conceptually close to FreeBSD's strlcpy(), but differs
@@ -245,9 +212,6 @@ struct btf;
 struct btf_type;
 
 struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
-const char *btf_kind_str(const struct btf_type *t);
-const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
-const struct btf_header *btf_header(const struct btf *btf);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
 int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map,
 		 __u32 **str_map);
@@ -431,7 +395,6 @@ int probe_memcg_account(int token_fd);
 int bump_rlimit_memlock(void);
 
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz);
-int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 			 const char *str_sec, size_t str_len,
 			 int token_fd);
@@ -448,92 +411,6 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 				const char **prefix, int *kind);
 
-struct btf_ext_info {
-	/*
-	 * info points to the individual info section (e.g. func_info and
-	 * line_info) from the .BTF.ext. It does not include the __u32 rec_size.
-	 */
-	void *info;
-	__u32 rec_size;
-	__u32 len;
-	/* optional (maintained internally by libbpf) mapping between .BTF.ext
-	 * section and corresponding ELF section. This is used to join
-	 * information like CO-RE relocation records with corresponding BPF
-	 * programs defined in ELF sections
-	 */
-	__u32 *sec_idxs;
-	int sec_cnt;
-};
-
-#define for_each_btf_ext_sec(seg, sec)					\
-	for (sec = (seg)->info;						\
-	     (void *)sec < (seg)->info + (seg)->len;			\
-	     sec = (void *)sec + sizeof(struct btf_ext_info_sec) +	\
-		   (seg)->rec_size * sec->num_info)
-
-#define for_each_btf_ext_rec(seg, sec, i, rec)				\
-	for (i = 0, rec = (void *)&(sec)->data;				\
-	     i < (sec)->num_info;					\
-	     i++, rec = (void *)rec + (seg)->rec_size)
-
-/*
- * The .BTF.ext ELF section layout defined as
- *   struct btf_ext_header
- *   func_info subsection
- *
- * The func_info subsection layout:
- *   record size for struct bpf_func_info in the func_info subsection
- *   struct btf_ext_info_sec for section #1
- *   a list of bpf_func_info records for section #1
- *     where struct bpf_func_info mimics one in include/uapi/linux/bpf.h
- *     but may not be identical
- *   struct btf_ext_info_sec for section #2
- *   a list of bpf_func_info records for section #2
- *   ......
- *
- * Note that the bpf_func_info record size in .BTF.ext may not
- * be the same as the one defined in include/uapi/linux/bpf.h.
- * The loader should ensure that record_size meets minimum
- * requirement and pass the record as is to the kernel. The
- * kernel will handle the func_info properly based on its contents.
- */
-struct btf_ext_header {
-	__u16	magic;
-	__u8	version;
-	__u8	flags;
-	__u32	hdr_len;
-
-	/* All offsets are in bytes relative to the end of this header */
-	__u32	func_info_off;
-	__u32	func_info_len;
-	__u32	line_info_off;
-	__u32	line_info_len;
-
-	/* optional part of .BTF.ext header */
-	__u32	core_relo_off;
-	__u32	core_relo_len;
-};
-
-struct btf_ext {
-	union {
-		struct btf_ext_header *hdr;
-		void *data;
-	};
-	void *data_swapped;
-	bool swapped_endian;
-	struct btf_ext_info func_info;
-	struct btf_ext_info line_info;
-	struct btf_ext_info core_relo_info;
-	__u32 data_size;
-};
-
-struct btf_ext_info_sec {
-	__u32	sec_name_off;
-	__u32	num_info;
-	/* Followed by num_info * record_size number of bytes */
-	__u8	data[];
-};
-
 /* The minimum bpf_func_info checked by the loader */
 struct bpf_func_info_min {
 	__u32   insn_off;
@@ -574,31 +451,6 @@ static inline void bpf_core_relo_bswap(struct bpf_core_relo *i)
 	i->kind = bswap_32(i->kind);
 }
 
-enum btf_field_iter_kind {
-	BTF_FIELD_ITER_IDS,
-	BTF_FIELD_ITER_STRS,
-};
-
-struct btf_field_desc {
-	/* once-per-type offsets */
-	int t_off_cnt, t_offs[2];
-	/* member struct size, or zero, if no members */
-	int m_sz;
-	/* repeated per-member offsets */
-	int m_off_cnt, m_offs[2];
-};
-
-struct btf_field_iter {
-	struct btf_field_desc desc;
-	void *p;
-	int m_idx;
-	int off_idx;
-	int vlen;
-};
-
-int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t, enum btf_field_iter_kind iter_kind);
-__u32 *btf_field_iter_next(struct btf_field_iter *it);
-
 typedef int (*type_id_visit_fn)(__u32 *type_id, void *ctx);
 typedef int (*str_off_visit_fn)(__u32 *str_off, void *ctx);
 int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn visit, void *ctx);
@@ -721,15 +573,6 @@ static inline int reuse_fd(int fixed_fd, int tmp_fd)
 	return err;
 }
 
-/* The following two functions are exposed to bpftool */
-int bpf_core_add_cands(struct bpf_core_cand *local_cand,
-		       size_t local_essent_len,
-		       const struct btf *targ_btf,
-		       const char *targ_btf_name,
-		       int targ_start_id,
-		       struct bpf_core_cand_list *cands);
-void bpf_core_free_cands(struct bpf_core_cand_list *cands);
-
 struct usdt_manager *usdt_manager_new(struct bpf_object *obj);
 void usdt_manager_free(struct usdt_manager *man);
 struct bpf_link * usdt_manager_attach_usdt(struct usdt_manager *man,
@@ -772,8 +615,5 @@ int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
 
 int probe_fd(int fd);
 
-#define SHA256_DIGEST_LENGTH 32
-
-void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH]);
 int probe_sys_bpf_ext(void);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
diff --git a/tools/lib/bpf/libbpf_tools.h b/tools/lib/bpf/libbpf_tools.h
new file mode 100644
index 000000000000..5c8d6d0d2fdd
--- /dev/null
+++ b/tools/lib/bpf/libbpf_tools.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __LIBBPF_TOOLS_H
+#define __LIBBPF_TOOLS_H
+
+#include <limits.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <linux/types.h>
+
+/* Internal interfaces for kernel tools that link libbpf statically. */
+
+#ifndef likely
+#define likely(x) __builtin_expect(!!(x), 1)
+#endif
+#ifndef unlikely
+#define unlikely(x) __builtin_expect(!!(x), 0)
+#endif
+
+#ifndef __has_builtin
+#define __has_builtin(x) 0
+#endif
+
+/*
+ * Re-implement glibc's reallocarray() for libbpf internal-only use.
+ * reallocarray(), unfortunately, is not available in all versions of glibc,
+ * so requires extra feature detection and using reallocarray() stub from
+ * <tools/libc_compat.h> and COMPAT_NEED_REALLOCARRAY. All this complicates
+ * build of libbpf unnecessarily and is just a maintenance burden. Instead,
+ * it's trivial to implement libbpf-specific internal version and use it
+ * throughout libbpf.
+ */
+static inline void *libbpf_reallocarray(void *ptr, size_t nmemb, size_t size)
+{
+	size_t total;
+
+#if __has_builtin(__builtin_mul_overflow)
+	if (unlikely(__builtin_mul_overflow(nmemb, size, &total)))
+		return NULL;
+#else
+	if (size == 0 || nmemb > ULONG_MAX / size)
+		return NULL;
+	total = nmemb * size;
+#endif
+	return realloc(ptr, total);
+}
+
+struct btf;
+struct btf_header;
+struct btf_type;
+struct bpf_core_cand;
+struct bpf_core_cand_list;
+
+const struct btf_header *btf_header(const struct btf *btf);
+const char *btf_kind_str(const struct btf_type *t);
+const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
+
+enum btf_field_iter_kind {
+	BTF_FIELD_ITER_IDS,
+	BTF_FIELD_ITER_STRS,
+};
+
+struct btf_field_desc {
+	/* once-per-type offsets */
+	int t_off_cnt, t_offs[2];
+	/* member struct size, or zero, if no members */
+	int m_sz;
+	/* repeated per-member offsets */
+	int m_off_cnt, m_offs[2];
+};
+
+struct btf_field_iter {
+	struct btf_field_desc desc;
+	void *p;
+	int m_idx;
+	int off_idx;
+	int vlen;
+};
+
+int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
+			enum btf_field_iter_kind iter_kind);
+__u32 *btf_field_iter_next(struct btf_field_iter *it);
+
+struct btf_ext_info {
+	/*
+	 * info points to the individual info section (e.g. func_info and
+	 * line_info) from the .BTF.ext. It does not include the __u32 rec_size.
+	 */
+	void *info;
+	__u32 rec_size;
+	__u32 len;
+	/* optional (maintained internally by libbpf) mapping between .BTF.ext
+	 * section and corresponding ELF section. This is used to join
+	 * information like CO-RE relocation records with corresponding BPF
+	 * programs defined in ELF sections
+	 */
+	__u32 *sec_idxs;
+	int sec_cnt;
+};
+
+#define for_each_btf_ext_sec(seg, sec)					\
+	for (sec = (seg)->info;						\
+	     (void *)sec < (seg)->info + (seg)->len;			\
+	     sec = (void *)sec + sizeof(struct btf_ext_info_sec) +	\
+		   (seg)->rec_size * sec->num_info)
+
+#define for_each_btf_ext_rec(seg, sec, i, rec)				\
+	for (i = 0, rec = (void *)&(sec)->data;				\
+	     i < (sec)->num_info;					\
+	     i++, rec = (void *)rec + (seg)->rec_size)
+
+/*
+ * The .BTF.ext ELF section layout defined as
+ *   struct btf_ext_header
+ *   func_info subsection
+ *
+ * The func_info subsection layout:
+ *   record size for struct bpf_func_info in the func_info subsection
+ *   struct btf_ext_info_sec for section #1
+ *   a list of bpf_func_info records for section #1
+ *     where struct bpf_func_info mimics one in include/uapi/linux/bpf.h
+ *     but may not be identical
+ *   struct btf_ext_info_sec for section #2
+ *   a list of bpf_func_info records for section #2
+ *   ......
+ *
+ * Note that the bpf_func_info record size in .BTF.ext may not
+ * be the same as the one defined in include/uapi/linux/bpf.h.
+ * The loader should ensure that record_size meets minimum
+ * requirement and pass the record as is to the kernel. The
+ * kernel will handle the func_info properly based on its contents.
+ */
+struct btf_ext_header {
+	__u16	magic;
+	__u8	version;
+	__u8	flags;
+	__u32	hdr_len;
+
+	/* All offsets are in bytes relative to the end of this header */
+	__u32	func_info_off;
+	__u32	func_info_len;
+	__u32	line_info_off;
+	__u32	line_info_len;
+
+	/* optional part of .BTF.ext header */
+	__u32	core_relo_off;
+	__u32	core_relo_len;
+};
+
+struct btf_ext {
+	union {
+		struct btf_ext_header *hdr;
+		void *data;
+	};
+	void *data_swapped;
+	bool swapped_endian;
+	struct btf_ext_info func_info;
+	struct btf_ext_info line_info;
+	struct btf_ext_info core_relo_info;
+	__u32 data_size;
+};
+
+struct btf_ext_info_sec {
+	__u32	sec_name_off;
+	__u32	num_info;
+	/* Followed by num_info * record_size number of bytes */
+	__u8	data[];
+};
+
+int bpf_core_add_cands(struct bpf_core_cand *local_cand,
+		       size_t local_essent_len,
+		       const struct btf *targ_btf,
+		       const char *targ_btf_name,
+		       int targ_start_id,
+		       struct bpf_core_cand_list *cands);
+void bpf_core_free_cands(struct bpf_core_cand_list *cands);
+
+int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);
+
+#define SHA256_DIGEST_LENGTH 32
+
+void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH]);
+
+#endif /* __LIBBPF_TOOLS_H */
-- 
2.56.0

