Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C2425CF4;
	Wed, 29 Apr 2026 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486911; cv=none; b=KLd+fgn1RYQy+H9wuovlypS/JYs+QBPdzNtHtc4L7ptTEmsa2x61BEwRMzZKrp5mGW4X0llE4UFLVWrl+PAhuCy3Gd+twR+tiBRRu2Q2ykB/vH7mzewHEU+Z3RQ4BMkDOTWymOwc7NorfWRRez7hH+Q9YU+iX0SdYDNLjFhahzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486911; c=relaxed/simple;
	bh=plsafDwkAkd/K9h64CJzG0BINlyrQf7Vk/mfQVI/aMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBDf3lPUEB87uu/W+Ql6Gx/pKcn4VdYyA0zzWei2yJFP7OL153sLJ7XSc+9xVtXGmBtgJtPTerU2+qQSCJFQXj2ujFGtgPb0oNIzj9grIaOrz8hCx5jSSgBgIUhCvhC/dp2x/5s8FedMirEHODprtkOlCs+ZPiqDFvrE9W4v/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHERJy/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHERJy/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24105C19425;
	Wed, 29 Apr 2026 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486911;
	bh=plsafDwkAkd/K9h64CJzG0BINlyrQf7Vk/mfQVI/aMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHERJy/7ad1z94INv4/oRMCVulCpxwFl35qolkfcIylxaW5i1009au3S6jLTk4goI
	 0OO2G/wrSPudixLtLNnGtMGrfhdVjcOIZ8lNZyw4RFQICR/aPkvswXOecDOvp5a2cP
	 XDJ6kfi707NzIZBZlh9PE6q9XxgL33AkTGUKLq1XWzHzItZ1/+EHuCAEic7nfYZnVe
	 1Kt1n6PABKCjfAndX3Jj0wQAY1D00pWWG8x6sRuOIVu3vBbYK6cXMsk1i5DQv9U/pf
	 Mw2+G0Ey55ETSnl7lGimEH/QvdFh8tc+aW23cI7T7UsjNCohAdRk+H9/YCmRH3ffNS
	 6zcaj4XFt5axA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 17/17] sched_ext: Require cid-form struct_ops for sub-sched support
Date: Wed, 29 Apr 2026 08:21:31 -1000
Message-ID: <20260429182131.1780125-18-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429182131.1780125-1-tj@kernel.org>
References: <20260429182131.1780125-1-tj@kernel.org>
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
Reviewed-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 65a00c979691..f3a585e32db3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6869,6 +6869,23 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
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
2.54.0

