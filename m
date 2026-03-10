Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F52DCBE3;
	Tue, 10 Mar 2026 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773105420; cv=none; b=QPjrAMgaRI4dU02PYIFkA6uKPAeFwKj9026if+pYweW2cIemFFsdzW6rg2VEFHz0Yh2/JmFs/RIGnnWL46ulSq5UTC64jpjzPVPMSba8WW+iByZgxVwk/PxE3YDleQ8rPMIM1vo7PMcP/5vVQhciwTJHXmWt0P9gajOxIYuQyD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773105420; c=relaxed/simple;
	bh=aeT4A20y+9c+XDl3eY5uD+nGLArdFk60N7IPNj+m8tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cebf9n7I73tCSTpLU2pzV1MgKuQoyEhKXVMrW+p9EyujDvV7fx7xrBURTZaQfKn2WZKsRBl/sZ0PNt3rRL/V/OqJeK8q7NJNqH7rMaoYH26vsPW6s704j5vZE3GuRZ1y9JJy1xl0enf0RB9weqpyzLwRjcjJdiwdDpY/2IIIFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iv+dBe3A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iv+dBe3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8B6C2BCAF;
	Tue, 10 Mar 2026 01:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773105420;
	bh=aeT4A20y+9c+XDl3eY5uD+nGLArdFk60N7IPNj+m8tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iv+dBe3ATCiNu8yDYZZ3GWEKTWwDoF2gqJq8oqk7e1E67JboCP6yPtGPTrSIiiTT+
	 unbb+prVI+7mzygZFoFyDapv1mD4eFHHOHRyMgrPRDJ5eSQUdBe/itM2YQ7XaOS4Ma
	 lLHANjMqBnTLiIfK7eV1iKe3dl9o8vFjdcc4aTqPVzh78YhILCP1OI7+41Y3VwW51B
	 GNfc21FkFuIs8UUyrt8tKNq3LJEr2M722ynaZJ40Fz+QqXCqTwvBEJQADHH+Xz6WlZ
	 6PMR6/+7Gr860aW9CkAoedBK8N1UhL9TDUBxP1R9TX3KlE3POuw92WBhgjFhDKSoUF
	 xcUjdYfG09AAw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/5] sched_ext: Reject sub-sched attachment to a disabled parent
Date: Mon,  9 Mar 2026 15:16:53 -1000
Message-ID: <20260310011653.2993712-6-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310011653.2993712-1-tj@kernel.org>
References: <20260310011653.2993712-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_claim_exit() propagates exits to descendants under scx_sched_lock.
A sub-sched being attached concurrently could be missed if it links
after the propagation. Check the parent's exit_kind in scx_link_sched()
under scx_sched_lock to interlock against scx_claim_exit() - either the
parent sees the child in its iteration or the child sees the parent's
non-NONE exit_kind and fails attachment.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 677c1c6c64bf..5d31e65e5596 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5247,6 +5247,17 @@ static s32 scx_link_sched(struct scx_sched *sch)
 		s32 ret;
 
 		if (parent) {
+			/*
+			 * scx_claim_exit() propagates exit_kind transition to
+			 * its sub-scheds while holding scx_sched_lock - either
+			 * we can see the parent's non-NONE exit_kind or the
+			 * parent can shoot us down.
+			 */
+			if (atomic_read(&parent->exit_kind) != SCX_EXIT_NONE) {
+				scx_error(sch, "parent disabled");
+				return -ENOENT;
+			}
+
 			ret = rhashtable_lookup_insert_fast(&scx_sched_hash,
 					&sch->hash_node, scx_sched_hash_params);
 			if (ret) {
@@ -5638,6 +5649,11 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 	 * serialized, running them in separate threads allows parallelizing
 	 * ops.exit(), which can take arbitrarily long prolonging bypass mode.
 	 *
+	 * To guarantee forward progress, this propagation must be in-line so
+	 * that ->aborting is synchronously asserted for all sub-scheds. The
+	 * propagation is also the interlocking point against sub-sched
+	 * attachment. See scx_link_sched().
+	 *
 	 * This doesn't cause recursions as propagation only takes place for
 	 * non-propagation exits.
 	 */
-- 
2.53.0

