Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095633E717C;
	Fri, 24 Apr 2026 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051661; cv=none; b=FKrVdPskIixqT3Oc4zW92MyiA7Z2C+3EXuFVgkZZ9cZcUUQTh4nPB4zLiW9gl9X4s0o2VK1bNe4ARUayAtQsZQLEbnlM7yZRzF7a6lCz8XNT+u5DbRigocUvjB2oUqsRFAEvDZ4RYx55Tdf/IbiLw4Q7wAuyySVZs9+X3TJfKXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051661; c=relaxed/simple;
	bh=NT0pWWy9LMulIKyzleAxHn2MhorwF5wms19T5V6reBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHwS9b1SAVEw+DkKukKvctDOfCxxA2EGNOMKmFA+srFIzzgn0ZUW9o04cgsLOqYp8g8FXuynfxUWHfqbOV7j6mNiDctHzaNgyzHRRtA8HCHbGyEBgjMfAhCyQpC6y305nhpXOsBkUbOcM95+BMtcWBtLY6aPTn/Bmkps0sq/W24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2H7vYnU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2H7vYnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3957C2BCB2;
	Fri, 24 Apr 2026 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051660;
	bh=NT0pWWy9LMulIKyzleAxHn2MhorwF5wms19T5V6reBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2H7vYnUQAl/ckF6OcXfqKGRaMuYJ4PGqxiPOFuaxSWkRalh+HnfqvWAGb7l9U7F9
	 NlNpWEVRLXvMzm9vxz6GyZDPNbH88kctF1hrbA1goLPIV5RZ8nxMj1ESUGHO1rCdvD
	 QGOk3kCS85r0DHJoDuc5p24QmJmnRBaULjHs1Mgfw1IzWEbJf34FFsRvkX71bTTYXv
	 +3Nvl5g6EKk6jBDxE/CwrN9CExBxuD+mtqCnZuF7hbNacWUX2rmT00tBe/9q2U4Hk6
	 PdaiKTnpWKTd86wsut0/MwW4hLO1pBv35Y9mdhpZWqfFIaO13yD7lZWT1EdTv0C37v
	 mq1N0gtHFCCOQ==
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
Date: Fri, 24 Apr 2026 07:27:21 -1000
Message-ID: <20260424172721.3458520-18-tj@kernel.org>
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

