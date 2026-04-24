Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D33E6DEB;
	Fri, 24 Apr 2026 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051652; cv=none; b=iEAMf4iWtJVQNjSV2g8KHmQB137lMxN/L1rz8QF8zuU4hgn5kUgegbcpVxdV4xheGgExVFsXj+Cm5sDmPPfjx7geq3NTfeKc+NIZb3tWsROhBWiouDeyJIbquBpRZRP9vMhvTO2OF1MfVej2HAR+WE6FJs1jyc/FhrlgM9p9cOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051652; c=relaxed/simple;
	bh=b96ZUNjRdqyGOSPNnQOCdG8J6qxbVkao39ZJAl0rfTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPyEyBUjOdRoyTRcup6KVNYPyDruzvCUWw8QChYarzEfF9Vb999k0+7lgCCBs9sJ34kIbme7yqdPNB+UKOwIb3jSYF+eX4qff0EYjB1dQX7hlqn95F4Y18luu5pMvCNV1QtzdXjfDoIIajnbFTDLTHIyfezUJe+vUZ3wCPfmpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoCVQ3A9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoCVQ3A9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AFBC19425;
	Fri, 24 Apr 2026 17:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051652;
	bh=b96ZUNjRdqyGOSPNnQOCdG8J6qxbVkao39ZJAl0rfTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IoCVQ3A9qRjTk5VshvhqFhBIS9e/+/6GjdMfOPq2/t2DqMrofFwOqw57wqEiUppSM
	 E6E71MsWnQHDuqqlBXA2ugHh1cdKJZH9jddPl6ooNwbLDviMo6ooHtbLGwLhO9HJp0
	 xNGjjy7dV1ZqjFWK9vTmaTGLpRn6JfSzaPmQNnNPWrA+fzx7vIap7Hvx5mVG/F7L+e
	 cTGTyRA5Q0AXyAcjGgnbJmMW8o/QT/+2jmYaYj4bFHNmTM9hrbYtuNHWO4ygy5D1KT
	 h5lh/nBc0yMnVKPErifO4AIWENCXOL5q3pxkGQW34rFilI2KzVJRKjZGhzrz2M7nOc
	 tlM15lcNI8CBQ==
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
Date: Fri, 24 Apr 2026 07:27:13 -1000
Message-ID: <20260424172721.3458520-10-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424172721.3458520-1-tj@kernel.org>
References: <20260424172721.3458520-1-tj@kernel.org>
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

