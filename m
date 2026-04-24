Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D28A21D590;
	Fri, 24 Apr 2026 01:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994360; cv=none; b=Xtp+Re1KmwnKj1uy6n64dXZTtuFIYUAX7Im6KyZAuceXUT/QkaunwG0SHdpK+N7ScBEKwo4cqzMyKjnlodA2eE+TPZNdNzFCMpea2/AMzY5q34G6ntETKEA3/UmJZ+GjjrNEXLt+DOfN2mknETPS082ylxXf6Ip/4ZtQ+JicprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994360; c=relaxed/simple;
	bh=NT0pWWy9LMulIKyzleAxHn2MhorwF5wms19T5V6reBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ai8TXKWruf5ygtWz17m00MTdNpDSZd9MVjTmr/9D+gOAEbMl3udQMirV3bzNiY9VJ0xRCLevT/j0nj5fkqMy7IhPuKuJx6oG9Aosy9Rx/McUGBNJG+53oAq2SiI8KTsPKuyztXcQb066+isGIXlt9IZlNLda4ynKpFOJW8GCYHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doc9JXzz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doc9JXzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4EBC2BCB3;
	Fri, 24 Apr 2026 01:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776994359;
	bh=NT0pWWy9LMulIKyzleAxHn2MhorwF5wms19T5V6reBM=;
	h=From:To:Cc:Subject:Date:From;
	b=doc9JXzzWAqqmxdO+1xFZsGGeRV3aNDizOlpt7XbCkTpPDEqie4XxY1QKTdMcciUU
	 wsRHGQz/s4Iqrua6fwRfqx10Jo+R37DMxMLvOCy0tIBidZ66YtPXoL8OJB+pitQuBx
	 o7W9HDf9b2b+FM7YIZLZGgvmhzmai0zxoiVUIvJfZFutqd6QPLvJtF7No6rC1XKEDd
	 k8FUIqW7Koth26nHbAPH1C0xF/BRZx40ja4jpjqrIMYAUcFHhK0hPMY4ir6SCPPSha
	 Qt3DBBKgNq51RyXB1ncLk9SJ+dQ15/D+oQc2SSjPcTxRnzZ8Q0Kluz5GE0Pigs+/ga
	 EAk6DAbNl2Jsw==
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
Subject: [PATCH 17/17] sched_ext: Require cid-form struct_ops for sub-sched support
Date: Thu, 23 Apr 2026 15:32:20 -1000
Message-ID: <20260424013220.2923402-18-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sub-scheduler support is tied to the cid-form struct_ops: sub_attach /
sub_detach will communicate allocation via cmask, and the hierarchy assumes
all participants share a single topological cid space. A cpu-form root that
accepts sub-scheds would need cpu <-> cid translation on every cross-sched
interaction, defeating the purpose.

Enforce this at validate_ops():
- A sub-scheduler (scx_parent(sch) non-NULL) must be cid-form.
- A root that exposes sub_attach / sub_detach must be cid-form.

scx_qmap, which is currently the only scheduler demoing sub-sched support,
was converted to cid-form in the preceding patch, so this doesn't cause
breakage.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 37f37f31b025..6beb190aba46 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6753,6 +6753,23 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 	if (!sch->is_cid_type && (ops->cpu_acquire || ops->cpu_release))
 		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
 
+	/*
+	 * Sub-scheduler support is tied to the cid-form struct_ops. A sub-sched
+	 * attaches through a cid-form-only interface (sub_attach/sub_detach),
+	 * and a root that accepts sub-scheds must expose cid-form state to
+	 * them. Reject cpu-form schedulers on either side.
+	 */
+	if (!sch->is_cid_type) {
+		if (scx_parent(sch)) {
+			scx_error(sch, "sub-sched requires cid-form struct_ops");
+			return -EINVAL;
+		}
+		if (ops->sub_attach || ops->sub_detach) {
+			scx_error(sch, "sub_attach/sub_detach requires cid-form struct_ops");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.53.0

