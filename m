Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8BA2BEFEB;
	Sat, 25 Jul 2026 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784940624; cv=none; b=m4iD5n9sVJhG5ccF6tVw0nDs2V8mEBAsD0HyW+ieyh3i8HSlFjDY2a6vom/2AlwDeF1Y0PRHzNzZJgnCM5xZMBUyMvZq8FereUQ+fRptM6K4kNn/4M9Hp1AWtn2iGFB6MgAeOCtxbLzj35IIkyqudDKCbQw9pUAIGT9YlmPB6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784940624; c=relaxed/simple;
	bh=U2YaFMMABy+NgO0Ne31k2KgBEx7woo2aToivNws208o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xw9MUOIiPLKq+nOdYez9oUQ26tzfXP80hjq7kHh6Vz/n2OGmo4tERILPk1be2zys3wVPnpbMxjMdoOuRqS9P6gocjhibex6TbMcbo6aOgmsMvYBHAAfvsTdVIBcPL3zIAoafpcwZV/BMhqGdPI3z9idrubmAEnUu5dLTJzpBcCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkSjI4TS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkSjI4TS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34871F00A3A;
	Sat, 25 Jul 2026 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784940623;
	bh=V8QdcNYMKnGDOJkuOriwtS3IYUCaZznC2QPPFiXjK04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KkSjI4TSRH4o+bbbURpr8JF6W39G/7ggtwoBY/vR6prggxZjG3U+X6CNzZOaLFJ3x
	 YaHMMTF0eed2JUm76Bh6RkNGhfPXUwxnzPbLdMHX0ucWTj7KRmbcGEVGPRs6mTXK0B
	 pFxIZx+qbFp29VLj9/j/DOmBaR6+TnAQ+D6pFraRR9SdzX1mxXwoMSi2zBlb3xofYK
	 miX9/b0cur+SjE+IGPX93AX7nyTNsBeS5EcszdO2Y9ZpyZss65cU7lbJTrMMCJL17W
	 R3oKJtbVxfWg4a1UmTEx8X79iPH5Q3qagP1w6HnaA2TgBvrTDHHl1QJ2mAMxHvjGUI
	 H9w4A9J7WmQzw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] sched_ext: Report NMI kicks with scx_error()
Date: Fri, 24 Jul 2026 14:50:17 -1000
Message-ID: <20260725005019.1297049-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725005019.1297049-1-tj@kernel.org>
References: <20260725005019.1297049-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-cpu kick lists are protected by IRQ masking which doesn't stop NMIs,
so scx_bpf_kick_cpu() from NMI silently drops the kick after a one-time
warning. A dropped kick can leave a CPU idle when the scheduler believes it
was woken, which is a correctness problem for the scheduler even if the
kernel is fine. Now that scx_error() works from NMI, abort the scheduler
instead so that the bug is surfaced deterministically. The warned_nmi_kick
tracking is no longer needed.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 6 +-----
 kernel/sched/ext/internal.h | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 29ca5f5ec30b..4338dc6a3f3a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9208,11 +9208,7 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	 * not mask NMIs, so kicking from NMI could corrupt it and is unsupported.
 	 */
 	if (unlikely(in_nmi())) {
-		if (!sch->warned_nmi_kick) {
-			sch->warned_nmi_kick = true;
-			pr_warn("sched_ext: %s: scx_bpf_kick_cpu() from NMI ignored\n",
-				sch->ops.name);
-		}
+		scx_error(sch, "scx_bpf_kick_cpu() called from NMI");
 		return;
 	}
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index a0659f74b065..b141f0104b44 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1546,7 +1546,6 @@ struct scx_sched {
 	 */
 	bool			warned_zero_slice:1;
 	bool			warned_unassoc_progs:1;
-	bool			warned_nmi_kick:1;
 
 	struct list_head	all;
 
-- 
2.55.0

