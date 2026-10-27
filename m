Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060276;
	b=Fb5KNtQ1GG1RNfKkLhwiR4o0I22MN/QfYb6B1cYKFn4Ju66I3J2yIpa4AyLaxF9WfT2e
	 ucfYt97bXK6opfowERJIEet0Num+dTYdFJrd6BawgKHf1J7Pv58RQSBi98GlAxh/h8N91
	 aFn/DuEIcN4gphm75l4aTUcp7M0X3OVZmnP6mAdHANvzlNKzaQwnRxRSSkY0MLEmNvGN6
	 /P3RCI+V/gwyu2JFCLZ4jYeop/hcDNXHB0aifgEt+8i++uzBB5aTEdqivfQ3v4tZtepBF
	 +bHJ+YWntwTrcC6XzkZkc63NGm06Um4o9pNVIks3PU+rVMtcdx0317Ssmq4o2lsUapQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060276;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rL5qff+iauqhfIitN02rXu6a83RfQHnTQh1InVQA2c0=;
	b=EU+LDNvbEtxMZz3ve9K6nq6EJT+eLokYFHTS4w7UID3LAqTKs+vPhkhF/jrQFBzMSoWK
	 iLWiCy9y6C6mxko6rW/HTS5Uy+d9VDjLDGjWHob4tWC1JlZpLW5VDvt40eRlgSV6R/bU+
	 iQd4SJEwzEwiaJALj4t1gXIdTRLVWzP0TR405/SWkc/cJ+UC9Fklr0ShfIlofGCIlWJZd
	 7A8uMMfdPhdkjGSAteQYNRGY1YS/6GOQEwtlXA7JIvEBCFbgHM4I75SMBK2aroSd5mSsd
	 ai04qhuvzHj9O6nAu+/xyBJKAInCnOqEf55z5ZzE9qyaBddOcF2ZvJ+Go4+Ia4DOZBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AJm/VR7v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8406606A33A;
	Tue, 27 Oct 2026 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJm/VR7v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC3D1F01825;
	Tue, 27 Oct 2026 00:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060275;
	bh=rL5qff+iauqhfIitN02rXu6a83RfQHnTQh1InVQA2c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AJm/VR7vy2c7sx5AVFxEBs6guDJguKJM5m46xVRE/emXfIobaxpPx7KWh7ZZBP49C
	 AmEZlhZ5TCEpzAsH5SBChioMx4LaH1DQj7zQ/R3xHacplj4KDyhTljhkZEp774YNxF
	 s82nG4aRE2iKnOp/sd0EQG9Ksz3ymLzQTqFI4eWkTApY7iEEob31YXVUSUGFyRlji0
	 TXanrJALjJn+M6QdV+0G/3fr2Pxk9aP4IjVpZ9wgIBU2Ez5Az8F5Cocr2iptSOfSfu
	 0KqDOwArhLv5lLzpWuYji7BMvAL7VdCN4DjSsqivlN6dYICFm315q7TTEkaUDDt7Id
	 JyoKxgu+6iCrA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/18] sched_ext: Move refill_task_slice_dfl() below apply_slice_vtime()
Date: Mon, 26 Oct 2026 14:17:36 -1000
Message-ID: <20261027001749.1821379-6-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027001749.1821379-1-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move refill_task_slice_dfl() below apply_slice_vtime(), with the other slice
writers, to prepare for the kernel-slice handling the following patches add
to them. No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5d872a155800..42a349aa2987 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1569,6 +1569,16 @@ static void apply_slice_vtime(struct task_struct *p, u64 slice, u64 vtime, u64 e
 		p->scx.dsq_vtime = vtime;
 }
 
+static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
+{
+	/*
+	 * A default refill is not an explicit request, so it must not drop a
+	 * pending out-of-band one, which is applied when @p next runs.
+	 */
+	set_task_slice_keep_oob(p, READ_ONCE(sch->slice_dfl));
+	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
+}
+
 static void update_curr_scx(struct rq *rq)
 {
 	struct task_struct *donor;
@@ -1662,16 +1672,6 @@ static void dsq_dec_nr(struct scx_dispatch_q *dsq, struct task_struct *p)
 	}
 }
 
-static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
-{
-	/*
-	 * A default refill is not an explicit request, so it must not drop a
-	 * pending out-of-band one, which is applied when @p next runs.
-	 */
-	set_task_slice_keep_oob(p, READ_ONCE(sch->slice_dfl));
-	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
-}
-
 /*
  * Return true if @p is moving due to an internal SCX migration, false
  * otherwise.
-- 
2.56.0

