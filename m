Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A642EC0AE;
	Fri, 24 Apr 2026 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994351; cv=none; b=tok1cj9boNV6RhGWisctZDiN4zmPTT4S42oFnPkngXPO/jG3HivxM5jci2CdpC98rPnH9XdBkr6phD3z90c8LqzwN1DRWMXRiwfG3tStnNG4hb4GSCbGJ0nHbLq9HqVe9lX8zAhwJP4zveetsiy2FgXSWCQQgsdxHsaTAsszwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994351; c=relaxed/simple;
	bh=b96ZUNjRdqyGOSPNnQOCdG8J6qxbVkao39ZJAl0rfTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNlkxieFLHGMc1FjkVx+8igfv0oIZoJuX5dKu4feSYKFdqEGyX94nmlzRaN5Jgamd+o8yjurCgU0/h5JQiTsO9oIenxnd1f0vPf8MIVu+rLedu4gGdl9dHMzWfuWgpN85bq008GZeLN0o8A1fa/HotlVjAdg0b6NfUKWT+Yp1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU0Uiz+v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU0Uiz+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE6FC2BCB4;
	Fri, 24 Apr 2026 01:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776994351;
	bh=b96ZUNjRdqyGOSPNnQOCdG8J6qxbVkao39ZJAl0rfTc=;
	h=From:To:Cc:Subject:Date:From;
	b=bU0Uiz+v0k/z2YKE6GyUMB7nkVUgROsN2kPv6h3wVLf7xxA/+JrOkMwLa6IQylZb+
	 CTLb9/y8EBNEeRU8bAj3XubmShoqtyOmlin7KH/dLdHPfgDCMNDKBlY/9z6ZuSXKRi
	 iz0UT2+OOqSkssdB9eFUL3tusMjiojG0lVBskNZrfk9NE6OesUSowin2wig/mIDQbY
	 ZjGGaYwSM/8ZXKix4BgIG+hIazfW6OZVuXSPMSjJ2sVFVUkHy4cHhz8ZRIsy4BVg2w
	 usfpqZwxjiZ/T/y5j7NDY8zlAr26XW5fiIyRIJ+v/SNnIJhNsVL7MSxMK4a6aUQkIh
	 dIpTMhVsmzNsA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomzhao@126.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/17] tools/sched_ext: Add struct_size() helpers to common.bpf.h
Date: Thu, 23 Apr 2026 15:32:12 -1000
Message-ID: <20260424013220.2923402-10-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add flex_array_size(), struct_size() and struct_size_t() to
scx/common.bpf.h so BPF schedulers can size flex-array-containing
structs the same way kernel code does. These are abbreviated forms of
the <linux/overflow.h> macros.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 18f823d424cc..4bf959a8cd08 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -1043,6 +1043,16 @@ static inline u64 scx_clock_irq(u32 cpu)
 	return irqt ? BPF_CORE_READ(irqt, total) : 0;
 }
 
+/* Abbreviated forms of <linux/overflow.h>'s struct_size() family. */
+#define flex_array_size(p, member, count)	\
+	((count) * sizeof(*(p)->member))
+
+#define struct_size(p, member, count)		\
+	(sizeof(*(p)) + flex_array_size(p, member, count))
+
+#define struct_size_t(type, member, count)	\
+	struct_size((type *)NULL, member, count)
+
 #include "compat.bpf.h"
 #include "enums.bpf.h"
 
-- 
2.53.0

