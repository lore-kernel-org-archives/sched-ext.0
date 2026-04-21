Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E436C0CA;
	Tue, 21 Apr 2026 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755996; cv=none; b=bRKD8q+ZatMnhtzjtD6Ku31L85xLRIIpLVtEj+QHxwR7E8H4QnUTfXox8gww4E9QhIr0JUHzNci3nRrwx+2q8hjP3dPVDhPN7Sg2F8X7ocQehovq5T50LMiWvcoNFDKSBBbj4nP1UyLgcueUs4TgLW91ahZ542mMbIb9K483xqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755996; c=relaxed/simple;
	bh=fzto8K+dlBSirB0NTcZslQkmcbsBYI2BQDDnA4pgz4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4LUmeUTU6TJyEHAO1i7IbrlvgEa6tS6CyP0s3nYI8yc7/bPyNs0njNe9f5FFKSY8sLZ4tmut+UA7XrBd/kxjNBx16b/Jr/Jq8INqAGIZJUrZT1jcuxKxPff248KJ0EatHsGaBDpDc6QZH3y7dvPeZwiuQxXh4dchI0fSrT5oLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBg+ukPe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBg+ukPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C72DC2BCB5;
	Tue, 21 Apr 2026 07:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755995;
	bh=fzto8K+dlBSirB0NTcZslQkmcbsBYI2BQDDnA4pgz4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBg+ukPePvlIqaDhB2OS0PCcr8UuqozSP0QJlYgQDBIZBpV1gtSSV4XD5Vm+19rno
	 yWIuzT0pHfLSEbmfMX/9iVE9xgH1buj7zW4C1rFf+jaSmAvwXViASwPC5rp29jdL7F
	 BB7/S5xvxKHd3cQSbM9gE2R5A/WwjiBY85ZTKm3O6jTXYbrJ4OC3Liflf8E6YAsjm1
	 lmTqFqRrvEgwBwF7cwcZkiyNCTuOIEJzzIT9ao7oyIdh07fw5lqzaq9rXRCsOVN8R7
	 h9NNcOG++uyo8EuBiB7nHB5rbLVWJYr+JEBhM9X2lgjK3fYm2+00Sh32EKYpPxiHUU
	 o6H1ViLbrQEHA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/16] tools/sched_ext: Add struct_size() helpers to common.bpf.h
Date: Mon, 20 Apr 2026 21:19:37 -1000
Message-ID: <20260421071945.3110084-9-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421071945.3110084-1-tj@kernel.org>
References: <20260421071945.3110084-1-tj@kernel.org>
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

