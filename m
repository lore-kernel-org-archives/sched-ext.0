Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494EC3FB7E7;
	Fri, 24 Apr 2026 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063461; cv=none; b=Hj5kSJ2JVnG99f/gJIqQ+DwA0CHgYJAsQ9/X1WDb4yaqu+lZCqYy49fBIFKKXK2k7jZpLSpmt9cZDBO9lVoEMm4k6OnTsSoWSby/Vb9mdjoXp2BbYlt9lZuFZTyl1UygFh8oTNCMPobDjkoEFITOuTwBAndZk5pLIU2YR4Wc26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063461; c=relaxed/simple;
	bh=MUk7SxAIxorx41X55MRRaxHfG/iGnRgBqoWzuLum8L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CewoKzonrmRTWylVP5jiikw7bFC8zHmbpibHk1cE2iXxERE3GnmNux5OoD01TKUfB+vVYdPKy1zzHwtZ3oq/PNy2DZUd+X55j2m7KMZDrHUPDqzTFvsuHZwjCgyHucqJbvAxz5P6zMtNtR+gh2wVQ5F9O4MhOktEm5/j0OIo2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h58xNfs1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h58xNfs1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC2BC2BCB4;
	Fri, 24 Apr 2026 20:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063461;
	bh=MUk7SxAIxorx41X55MRRaxHfG/iGnRgBqoWzuLum8L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h58xNfs1MDwfv1a7tcfsLZ8kT7GEQCTfSxKjLl/fC+mOdkPynH2Tu753dm1dNZw13
	 Rq5dheTvQeNEmoQi3k0IdTy8wX1FJu2KB0YO7Rjn+t+zcpFsRzZO8u3op1/v39Cnk0
	 9Jn2nXpaR7wie8zwMcpSkNN1synMIv7OUm8jHswOlZum0mUti5eVLT6iAWlMRePxGh
	 Hf258dmXjwjFhZuuQUP/4DBr0galK/JYjFujhH7JuDi9hh0ub3K4PcA9vjnrpftJHk
	 CjmYJkt3I72G4XQFQIezSGWAlZlKZ0sp0WH/6G59iJcSU+3aYRuUyKrL/pjjVs+NDp
	 9WAnzDBPHz9tQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/13] sched_ext: Unregister sub_kset on scheduler disable
Date: Fri, 24 Apr 2026 10:44:06 -1000
Message-ID: <20260424204418.3809733-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ops.sub_attach is set, scx_alloc_and_add_sched() creates sub_kset as a
child of &sch->kobj, which pins the parent with its own reference. The
disable paths never call kset_unregister(), so the final kobject_put() in
bpf_scx_unreg() leaves a stale reference and scx_kobj_release() never runs,
leaking the whole struct scx_sched on every load/unload cycle.

Unregister sub_kset in scx_root_disable() and scx_sub_disable() before
kobject_del(&sch->kobj).

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a018034dd81c..0c435a4612dc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5700,6 +5700,8 @@ static void scx_sub_disable(struct scx_sched *sch)
 
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, exit, NULL, sch->exit_info);
+	if (sch->sub_kset)
+		kset_unregister(sch->sub_kset);
 	kobject_del(&sch->kobj);
 }
 #else	/* CONFIG_EXT_SUB_SCHED */
@@ -5831,6 +5833,10 @@ static void scx_root_disable(struct scx_sched *sch)
 	 * could observe an object of the same name still in the hierarchy when
 	 * the next scheduler is loaded.
 	 */
+#ifdef CONFIG_EXT_SUB_SCHED
+	if (sch->sub_kset)
+		kset_unregister(sch->sub_kset);
+#endif
 	kobject_del(&sch->kobj);
 
 	free_kick_syncs();
-- 
2.53.0

