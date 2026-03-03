Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F022848BB;
	Tue,  3 Mar 2026 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522653; cv=none; b=slDSgNyFEi5r3jzYc3ocusP0ONQj+4sCgbI4UxK9lt9AybWaFWSS+nzVt47BQvATIvtqKsTU7YF6RLlY0xyp/n+bwel9I3Qc/YuZXMWXmYEzKjATbhxdzp1WbddLMQosqxWnZ6OwfWTtz5aqJtFDN6qtWPuqWEDx48v6AOLv72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522653; c=relaxed/simple;
	bh=VGYfChW+hftxyiHbvyTWUAIFNt4cxQtpYaguIbM90pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceHqkL4F6BlMiK2pSASZZZA+7awL5x7f5qs+L2AoJj9aA6GNLk/82C6fBBE9N5RZgQ8SwjWN6etzQzn0/xAgaKqUAE7eHksxVng+MjcZOGmolagXvbe49ohSOQ40drr1KbCD45qdKuQi9fVhvdZoCtsAQrc5mMPXk7VqxdiSIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=fQxj334s; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="fQxj334s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jN
	sX6y3/noWI4atTR0sE6jHvaCyPAhxU+KSQMt55M44=; b=fQxj334sUBe23Xt4Iy
	mSpCe8IOhpDdpfEc3gN0r2sr42IudD+J1E1fSej/a5DYmJY0S7q5kbjR+jP9x6+n
	ycYh1U6jF2RBp+bPyar7jl+Xdz/hnif88Q8XqPyfkqRMmZcsWEIq09tjTZxrGEpY
	6Kber2liaTLwhDzq5BqK6lbfc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDnT3h6jKZpVDeAAw--.53445S3;
	Tue, 03 Mar 2026 15:23:39 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	shuah@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	zhaomengmeng@kylinos.cn
Subject: [PATCH 1/3] tools/sched_ext: Add -fms-extensions to bpf build flags
Date: Tue,  3 Mar 2026 15:23:15 +0800
Message-ID: <20260303072317.76035-2-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303072317.76035-1-zhaomzhao@126.com>
References: <20260303072317.76035-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgDnT3h6jKZpVDeAAw--.53445S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr18Kr1DGw1fuw4DKrykKrg_yoW8Xr17pa
	9I9rW8GF47tFy8Gws7JFW3trWY9ws2gw40qryqqwn0yF97t3ZFq3s7tF43Ar17tw4kCry7
	ua4xKasxWw12v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UE4E_UUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqxtFvGmmjHtQHwAA3+

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Similar to commit 835a50753579 ("selftests/bpf: Add -fms-extensions to
bpf build flags") and commit 639f58a0f480 ("bpftool: Fix build warnings
due to MS extensions")

The kernel is now built with -fms-extensions, therefore
generated vmlinux.h contains types like:
struct aes_key {
        struct aes_enckey;
        union aes_invkey_arch inv_k;
};

struct ns_common {
	...
        union {
                struct ns_tree;
                struct callback_head ns_rcu;
        };
};

Which raise warning like below when building scx scheduler:

tools/sched_ext/build/include/vmlinux.h:50533:3: warning:
declaration does not declare anything [-Wmissing-declarations]
 50533 |                 struct ns_tree;
       |                 ^
Fix it by using -fms-extensions and -Wno-microsoft-anon-tag flags
to build bpf programs that #include "vmlinux.h"

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 tools/sched_ext/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index 47ad7444677e..21554f089692 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -122,6 +122,8 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 	     -I../../include							\
 	     $(call get_sys_includes,$(CLANG))					\
 	     -Wall -Wno-compare-distinct-pointer-types				\
+	     -Wno-microsoft-anon-tag						\
+	     -fms-extensions							\
 	     -O2 -mcpu=v3
 
 # sort removes libbpf duplicates when not cross-building
-- 
2.43.0

