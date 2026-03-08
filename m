Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75953314D1D;
	Sun,  8 Mar 2026 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772937926; cv=none; b=kGgHFGnfJE8h7dBYOtD4GEqGIUmzhaJ7oMYLl5dAzGySftSazbx0vqR3InQnZ2F1/3smamWSeIwuvedS+zsSFsbpOm2lPuiXqXgGafdGfRcViinBXSgestpbp/RNDRV7W1LcEhND/2sr00dudkL1j+MoX2q8XIKy/pkMtCBRPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772937926; c=relaxed/simple;
	bh=KmwJIBoCZvuoHQtdJRYOnb91EIntX7vcGPdT9XK//O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWTvw4MgNR9341zqmAD/mE545DX5SZ70CoAQpitwGKFiRlpz8nufCm9WnI+PZRSXK63RmYfKyAjMGcf/3VrVcUDFTQmqqz9R1pP5yxrFXCFZG/DDjJ3XSBnJe9ZGRgwLA8PfDgG2oPxTOykzbtgmm9nX4u6ojfZO7YY6hYyX980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYTKw9i2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYTKw9i2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20BEC2BC87;
	Sun,  8 Mar 2026 02:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772937926;
	bh=KmwJIBoCZvuoHQtdJRYOnb91EIntX7vcGPdT9XK//O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYTKw9i2lFavu1mDhkVKb5ONdBCo/9fcnpKZvAsRJqs1Scd0Dsc7hXDPCr7jQpQXZ
	 DzzXGq+Ft0B4A49Ekk+jgAUCdjOh1aF8wk0ZRr/456we+MAZEnQqTLezF4z1vGpeRr
	 UGZM+sGjJKVVEzXsb7M31WmZqK8mYKIzQAtUC0hSloxSogS06pN2r/9PhirBn5eRIM
	 GzjsoD68RSh9y48p7uP9exGoAiLMFabPECU3q4TyRbIiJ4rF0kLSAKDs1aGMNhhbH+
	 3HGdjJhrf2AZ2Z4Psvs/np1gFolo7xJvhJU5yhLhpgLgI5bPDix0jMWWCkvln/ib0+
	 mAfSD5TPz+hZw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] tools/sched_ext/include: Add libbpf version guard for assoc_struct_ops
Date: Sat,  7 Mar 2026 16:45:18 -1000
Message-ID: <20260308024519.1980564-6-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308024519.1980564-1-tj@kernel.org>
References: <20260308024519.1980564-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the inline bpf_program__assoc_struct_ops() call in SCX_OPS_LOAD()
into a __scx_ops_assoc_prog() helper and wrap it with a libbpf >= 1.7
version guard. bpf_program__assoc_struct_ops() was added in libbpf 1.7;
the guard provides a no-op fallback for older versions. Add the
<bpf/libbpf.h> include needed by the helper, and fix "assumming" typo in
a nearby comment.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/compat.h | 35 +++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 9b6df13b187b..50297d4b9533 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -8,6 +8,7 @@
 #define __SCX_COMPAT_H
 
 #include <bpf/btf.h>
+#include <bpf/libbpf.h>
 #include <fcntl.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -182,6 +183,31 @@ static inline long scx_hotplug_seq(void)
 	__skel; 								\
 })
 
+/*
+ * Associate non-struct_ops BPF programs with the scheduler's struct_ops map so
+ * that scx_prog_sched() can determine which scheduler a BPF program belongs
+ * to. Requires libbpf >= 1.7.
+ */
+#if LIBBPF_MAJOR_VERSION > 1 ||							\
+	(LIBBPF_MAJOR_VERSION == 1 && LIBBPF_MINOR_VERSION >= 7)
+static inline void __scx_ops_assoc_prog(struct bpf_program *prog,
+					struct bpf_map *map,
+					const char *ops_name)
+{
+	s32 err = bpf_program__assoc_struct_ops(prog, map, NULL);
+	if (err)
+		fprintf(stderr,
+			"ERROR: Failed to associate %s with %s: %d\n",
+			bpf_program__name(prog), ops_name, err);
+}
+#else
+static inline void __scx_ops_assoc_prog(struct bpf_program *prog,
+					struct bpf_map *map,
+					const char *ops_name)
+{
+}
+#endif
+
 #define SCX_OPS_LOAD(__skel, __ops_name, __scx_name, __uei_name) ({		\
 	struct bpf_program *__prog;						\
 	UEI_SET_SIZE(__skel, __ops_name, __uei_name);				\
@@ -189,18 +215,15 @@ static inline long scx_hotplug_seq(void)
 	bpf_object__for_each_program(__prog, (__skel)->obj) {			\
 		if (bpf_program__type(__prog) == BPF_PROG_TYPE_STRUCT_OPS)	\
 			continue;						\
-		s32 err = bpf_program__assoc_struct_ops(__prog,			\
-					(__skel)->maps.__ops_name, NULL);	\
-		if (err)							\
-			fprintf(stderr, "ERROR: Failed to associate %s with %s: %d\n", \
-				bpf_program__name(__prog), #__ops_name, err);	\
+		__scx_ops_assoc_prog(__prog, (__skel)->maps.__ops_name,		\
+				     #__ops_name);				\
 	}									\
 })
 
 /*
  * New versions of bpftool now emit additional link placeholders for BPF maps,
  * and set up BPF skeleton in such a way that libbpf will auto-attach BPF maps
- * automatically, assumming libbpf is recent enough (v1.5+). Old libbpf will do
+ * automatically, assuming libbpf is recent enough (v1.5+). Old libbpf will do
  * nothing with those links and won't attempt to auto-attach maps.
  *
  * To maintain compatibility with older libbpf while avoiding trying to attach
-- 
2.53.0

