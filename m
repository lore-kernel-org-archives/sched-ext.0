Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD239BFEF;
	Tue, 21 Apr 2026 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756004; cv=none; b=rKmqEtfJmPutj0iXIU7suCRpUrZnK8XMUvYO24NUsZzNrD8dbS1yRbonO8XkS5AF2Ml+TXFkb3r59/Lg2K25d1P+4LPIEVMrNz4EFZNMDWCifo9gPBv6f+zplJQ/1l/VZxj+bWlkhAhUyLb694yi0jY4TRVgkdWJf+I1KMS9Lb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756004; c=relaxed/simple;
	bh=jZRm3Cj09WsrCzX4nS6CVQ/ODB/6p6DG9lFgxyKBrKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1UObZ8/IV7icGoO1bLktXXsTRyPDLFejRYc3fJGh3PfFXSYxM5TW+0oL4yl0XMRTuvgUdqcH/d8Jpvsj1fAV2wRftr2QjT6qzzUakWpKS1GcB24OpLaVJhB98yR0Y0H6k2eSqc4dFgA5I18+yYyWcnrNhB6QvbQkYcilHHFR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJPH74At; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJPH74At"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EB0C2BCB0;
	Tue, 21 Apr 2026 07:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776756004;
	bh=jZRm3Cj09WsrCzX4nS6CVQ/ODB/6p6DG9lFgxyKBrKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJPH74AttsTy0LsnVH3M4vP/zRzA8aMhFKogxK1dHYFaUWJJLGK+VcX95a6/F8GWY
	 D+0dpVB6AjOvAoiIoERmBgEOp42M75iAcwJVPKmnxgl/Z/+rgP0TfdgCWzrWDQnqxY
	 cQ3CDLC9wEIp+ZVK4/fMbthFG3g4X7f4Uu7McMKlrZ/QNrOMe40cihMCtgM6aW/Grp
	 oKZVDGx55TydSXhfUxShzPs2phH3rxl6lcvMaYU4wjEMSXZD/GfzcCGwJ5k3Lk2aoG
	 WV+O3l31RU2uyrOL2DWz7igl4JmlIC1e2zUI00qslGwJ3rZbpMB+bAeJoslWgPwNWf
	 QqnEMourY2OhQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 16/16] sched_ext: Require cid-form struct_ops for sub-sched support
Date: Mon, 20 Apr 2026 21:19:45 -1000
Message-ID: <20260421071945.3110084-17-tj@kernel.org>
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
---
 kernel/sched/ext.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 02bdd393bbe4..71d6a2b39e64 100644
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

