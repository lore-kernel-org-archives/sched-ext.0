Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A983931F989;
	Tue, 28 Apr 2026 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408556; cv=none; b=hI5Dqd/3MBZ6iIeISf0SnffJE4OCREk33u2ptCWDH9+U1iRJVk7qH0lyu4BWSc5+JtI1/CtjRzuo0tzPS2WfOY0wdV0Eo+g1gAiz/ILtD+IihNM+Pz7DsILk0CjU859UaEM5dcHFIPokGRIWeIvobUJ+B7znUfANfpgrmn86WdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408556; c=relaxed/simple;
	bh=AQngPuZF6lq8G9fCGomGHL+AWI1T6dVXUsOnqMkMhEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHpTWOBAYsH6WlTU5EMla2Djdb45OC1IIo6SOfFpasP14KRT0pCH4FrpbmrDFIc2QY0oOLpu08Q0OS2gjG/6U3TVBvptAb6hB6RD6MR/zPLaoxc5lw2mcna9QU4S9fSU/ocK7OWEzMndwvCmHsU/HEK9Alovq8QPmou8dOw57tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFRqoipZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFRqoipZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB36C2BCB3;
	Tue, 28 Apr 2026 20:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408556;
	bh=AQngPuZF6lq8G9fCGomGHL+AWI1T6dVXUsOnqMkMhEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFRqoipZ/EB+YgCSOi8/4R4q0p4Rl9fO1rbxD0Mcc79k99NlpsRfsCceQrZvru5+f
	 MDgJhwXE9QF2MJe0VX6jfHJ4uhnefroLczSe5XneMjcQbkMRsTU88/6Sj/uAbdQZC1
	 7tWXmr1CdFZ8EjXZVF3RPTCe+KzpttLMTWdMRCb5jWLQ0lOQ/doeQf6UTtLPHbOR2N
	 yfMAJpUqxaEzOcroCcdUBq2WNo/987S8UaP7J5FXc3pKVbtU7IIpAIdKSVPHaJLx0D
	 P+Yl3oukx2CdOx3flaUWLEqKhhuo9B52Xe/gZCsiN90EOXOj034hGQI5j///PgrgF3
	 VVHY2VSC8ylpQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 09/17] tools/sched_ext: Add struct_size() helpers to common.bpf.h
Date: Tue, 28 Apr 2026 10:35:37 -1000
Message-ID: <20260428203545.181052-10-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428203545.181052-1-tj@kernel.org>
References: <20260428203545.181052-1-tj@kernel.org>
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

v3: Use offsetof() instead of sizeof() in struct_size() to match kernel
    semantics (no inflation from trailing struct padding). (Sashiko)

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 18f823d424cc..087ae4f79c60 100644
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
+	(offsetof(typeof(*(p)), member) + flex_array_size(p, member, count))
+
+#define struct_size_t(type, member, count)	\
+	struct_size((type *)NULL, member, count)
+
 #include "compat.bpf.h"
 #include "enums.bpf.h"
 
-- 
2.54.0

