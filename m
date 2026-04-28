Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906437B019;
	Tue, 28 Apr 2026 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408565; cv=none; b=DK9fxdp53vcn8ROzx8HJMLgFfsyz8IU5VFt5/sFQWz+P2r6LdauMLnrrf8OZeNkDIVcgFtYcMom6tMuVw/kL+HV0f8SYqtlqxYQSgQ75Ys3VR6SURRECgDwNhx9+kUWkylbled8oNocN3qToIT9KBfL2XKEAiV03nORjNSGokfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408565; c=relaxed/simple;
	bh=eS2kLjjsSvUY+pfr/K9+wFs+sEm2q9ExCQ0dl+Tvrbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qc1pTsv6/WEP4b9ViXOagMjnD9qNSbSz///wlLG/N38Fj+oKzd7dBQDzgKPfghme/Zqp32mMG8L3st1AbZjNFbbFh4xHwC7dPRBXwImGeY/lhj9UBLGQbKQh8qji4+d7Z9Qdb6XglZ8lBIYgMv8MYNEuRX+oeo1O4BxK527vsO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cq8mcDri; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cq8mcDri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A43C2BCB8;
	Tue, 28 Apr 2026 20:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408564;
	bh=eS2kLjjsSvUY+pfr/K9+wFs+sEm2q9ExCQ0dl+Tvrbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cq8mcDridapJy2Wd0oWl1zC9ZUGG9McF93VsFCMpnTJG8riT3pEd0hStNndaQkjen
	 Ty+ho/BkD6iNlRwSDlEU9U2YEcZhiR2/4LrCflxJJdjxO+6a2fZyh5XnI42L/Ibrer
	 +vQef9DBuGCPI166hYAI5XJHKPJ2m3LPCWBp9hN0Jxeh8a9UIovyj3BC3qzNR5h9GH
	 hh/kn/fi1Pqtl5TH2H90osB0KU3C3plGz8DQjLOJnTdRoAyEfm1w/wDkiwXoCh8aUq
	 FVFZSakSDxvfOVloziPoV9T3yhnSZ4o90KcyjtgL7M1vl64wwhi4jQFxDvWFGbddcA
	 8LgykzGbdJKIA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 17/17] sched_ext: Require cid-form struct_ops for sub-sched support
Date: Tue, 28 Apr 2026 10:35:45 -1000
Message-ID: <20260428203545.181052-18-tj@kernel.org>
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
index d8f8fca5ded9..018c75b7ccf1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6847,6 +6847,23 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
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

