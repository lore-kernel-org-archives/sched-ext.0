Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDCE3C3BF4
	for <sched-ext@lists.linux.dev>; Fri, 22 May 2026 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470060; cv=none; b=ifCibZHd0KDzQqBlqsURKpwSaZvGQQWuqZKLp44uzn4pqj9gzwwjeqIa3exbnffT2hsmdPZFaS9ERCjgy0j/Itn7rHDj0L/ZzW/77VlAxN39tiKYgq2U8TolMA0djfsU2XSnUWNGJmnuXv9sfNeMKBGSXT0shq5eL7hwvoXxN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470060; c=relaxed/simple;
	bh=jsFfgwjHx6ho7n1MiC6G9Et0M4GCrRb0oyxpwWIXQVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8ja6R8Z7yiKtA935GWJF9cm4T2L5B8VoRjde0OvlWc+owxVK4ERWiPYMV69WQPZfrdTWQNmXBr3gVZ+T0TEYTmun7LN5XRV7a/P27iJqygR1FG2IJYcEtITw+jfb9MFF7zCbxI2sB4jQrKwTGRKmJiuwVFbPsMMHS9FEtOJxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt3xFQw9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt3xFQw9"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8354461da74so3504791b3a.1
        for <sched-ext@lists.linux.dev>; Fri, 22 May 2026 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779470058; x=1780074858; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr792HLOZR4OYkYbs8nGUJGsgnkp3D2YqlQXiDohp+E=;
        b=Wt3xFQw9ErhluwcJj/Olk3SHg7OJ/Eh4LeUPPejocFOUubAddVIusyVtObbz2fdWOD
         IHV2e/aVpnVt0EMXr4neUdjVvE57509zkIUrI4q/3ujQk0Jyt3opk1vxn5WtbV/oJlbi
         DgA4+Sb23tuqQxg5Eod0gf/io0n8fugPC8id8wYxqefcrO8HaUzf0oAvMPEa183WRYng
         kFc82APpdag3WJI5WwfjG5ORdqwFm5B2HwZ3jVUtqjytXEZXlJ0s8Kr4SFeJyKKWYGae
         lF5A7Df5d/yoRlFClJ5DBXjbyUabWiGNyG0uJImtOjqBzlCpEWThUBhG3YzcGN3Cb7Oi
         Ou+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470058; x=1780074858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nr792HLOZR4OYkYbs8nGUJGsgnkp3D2YqlQXiDohp+E=;
        b=O0yhbRYvtPbnBcuAabS+c4boDyP1WU+0GLOa+8L58FE5//fB3ZfxGcpElBmAJdIoi6
         +XTkGcXXXaFoHWJ/OmkgVwFWkHbx5RST1wMKCwT73lZTR50maQOa2HqxvqrSNMsMiVGM
         0eHiFiF4vVvu/6OlweZ49cNAEDytaLECOEOgyoq5Xc+mjxiE+YchOQbKHPmicii8mIXS
         OcBAyoBFFBonfG/ILIsKaBHlO8XthnqLSJU5z/YzgNsQj4zsRDsBuTrveY/H3sA1D2Od
         C3kkDw670kMaD+M1kO315i5oN5VVup4ou8WaHGv9RUvYnS5MPXdOIus21yO3w0h/3WC4
         6X6Q==
X-Gm-Message-State: AOJu0YyzjudgoiS6mJBeutg4rlwUN38Hp75v/fj3UWHf+TLPzK4PZn1B
	qcKuWE6KZCD+FtmUFCvAkrBtc5Z4bGMVZQ4cZUdNu6Ro130xRetg1X96m0Ae/w==
X-Gm-Gg: Acq92OFLKP2afaomEV8+rUYMw6J4YhQ7+lnfJx+ni5M3/o2LEvEuVWxgIsJ8EZcxbV9
	tjnzt1X8MTOArozJkyz3Jm9Nn4t6taJ+8LxKwxjtQ1ZkcDhs0GKdbYRWDwvkBC8KcTOJ+qGMpX7
	/ty6lTDLDEIooh/RUaVUVJvz9aiIK1Xt3PJlNNQr5FOuUVZ/nrQMxMb6VEynfwHSXnBXssVrwkS
	ynofop3KHlvRkaxO53YNhz1Bhk+1/UVf4zxHqRI6mVvX0HZA6ySY1UdI4uBFICAx1v+gWB1R4lD
	JjgoYF+RjGIC91ETnjPyMwyFtZ5aaVv3uB/C6rf+2w8VhqHgQeOTZw8a2GmJjWHm+sqB6443Btw
	H90Hr4e4A18zg7GioUt3aUTg5DVVEogpYxINmWK/PaSY70N9yuWfiLakK6yoO4JbzRi8oOZWbwE
	WrxXk2lHy6H6VQMqh0zGgiZLwA9BjCxao6n+8yc6nMRnPBrum26b1n3c/NvLIz
X-Received: by 2002:a05:6a00:1888:b0:838:20b7:40ed with SMTP id d2e1a72fcca58-8415f6141a7mr4914076b3a.42.1779470058276;
        Fri, 22 May 2026 10:14:18 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d6b:1176:68e:1fdb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164afe338sm2517549b3a.18.2026.05.22.10.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 10:14:17 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 1/2] tools/sched_ext: always define bpf_addr_space_cast
Date: Sat, 23 May 2026 01:13:18 +0800
Message-ID: <20260522171406.2171819-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260522171406.2171819-1-yphbchou0911@gmail.com>
References: <20260522171406.2171819-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With __BPF_FEATURE_ADDR_SPACE_CAST set, bpf_addr_space_cast() was
defined only in the #else branch, making it unavailable to BPF
programs compiled with modern LLVM.

The macro emits an addr_space_cast instruction as raw bytes, which
the BPF verifier uses to assign PTR_TO_ARENA to a register. This is
needed when LLVM's liveness analysis kills the PTR_TO_ARENA alias
before a store, which can occur even with modern LLVM.

Move bpf_addr_space_cast() before the #if block so it is always
available. cast_kern() and cast_user() remain no-ops under modern
LLVM. The macro is now accessible for explicit workaround use.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 .../include/scx/bpf_arena_common.bpf.h        | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
index 2043d66940ea..03bbc29ed94b 100644
--- a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
+++ b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
@@ -14,15 +14,6 @@
  */
 #endif
 
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
-#ifndef __arena
-#define __arena __attribute__((address_space(1)))
-#endif
-#define __arena_global __attribute__((address_space(1)))
-#define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
-#define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
-#else
-
 /* emit instruction:
  * rX = rX .off = BPF_ADDR_SPACE_CAST .imm32 = (dst_as << 16) | src_as
  *
@@ -33,6 +24,10 @@
  * tools/testing/selftests/bpf includes tests that use these macros to implement
  * linked lists and hashtables backed by arena memory. In sched_ext, we use
  * cast_kern() and cast_user() for compatibility with older LLVM toolchains.
+ *
+ * With __BPF_FEATURE_ADDR_SPACE_CAST, LLVM's liveness analysis may kill the
+ * PTR_TO_ARENA register alias before a store. Call bpf_addr_space_cast()
+ * explicitly at such sites to re-establish PTR_TO_ARENA.
  */
 #ifndef bpf_addr_space_cast
 #define bpf_addr_space_cast(var, dst_as, src_as)\
@@ -74,6 +69,14 @@
 		     , [as]"i"((dst_as << 16) | src_as));
 #endif
 
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
+#ifndef __arena
+#define __arena __attribute__((address_space(1)))
+#endif
+#define __arena_global __attribute__((address_space(1)))
+#define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
+#define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
+#else
 #define __arena
 #define __arena_global SEC(".addr_space.1")
 #define cast_kern(ptr) bpf_addr_space_cast(ptr, 0, 1)
-- 
2.48.1

