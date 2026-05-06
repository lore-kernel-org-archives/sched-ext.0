Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575E4B8DE9;
	Wed,  6 May 2026 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090569; cv=none; b=mGdaPOyyAo8+Bp+T+fsKe6uratr/6b0f85uo/Na1ZVzwAAC7FOoSlJ0zXs1wOItMP2NfcDPUWMUqp/Avs9tCafCvoRwqxE1v4sq+AttvJBXyX/9IiOYlk4Zr5OOkdKbIcjLUzohGZzwcf0HrSFpQSXZslAGLzdZz0gvw3uRtEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090569; c=relaxed/simple;
	bh=jZV4W3uPzFIdZXXaqE5/jEoT2XbeyVYF84/hrw58EnI=;
	h=Date:Message-ID:From:To:Cc:Subject; b=eF4UgCSn6GTywLKxbBOdfmlew9APockVkR5EaYA34t0Rs4mwQvIbjSJNITyosimME1pV4KaspSOdeJePkTaEj+IWNIEZq2c6bfJ2m7lJRFKsdU1YmqoI3HWRvBj0ziDlC6uZfPuqW1Wd8d6DAewa34/Cp7Z9dxccJDxc3fA10mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlsxJGCy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlsxJGCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69081C2BCB8;
	Wed,  6 May 2026 18:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778090567;
	bh=jZV4W3uPzFIdZXXaqE5/jEoT2XbeyVYF84/hrw58EnI=;
	h=Date:From:To:Cc:Subject:From;
	b=WlsxJGCyLcxESuBwF/erD1P9t79aIzhK3W68O2EgsyS2CiDe4cD/uNedjoJSnAu/5
	 9RTwJtyqsXlQNGN2l1/YyXpSq+XOYpkkUpcJ7qFPHUdUgd9o5RRd895hKmi1evy5Dc
	 BYymJvijxSIpse0mXQoteTNe/nW3FvmiZh1/qQ/tKrLDVRI3SRxi9Ig9GPcG6DF1Ss
	 8tNt8xx1CIGRGi/XMNXpb507mfhkXcVhXBObT0S2/0iH8GpbB9vEsVVa6/Pyz1CGLG
	 1qocGLgfQ37lRLKFi8rWF/MmlqFxPkJqoKJGgTPmHDuZ7os7vqnMJi9JnxmLrMwQnC
	 RH1OTNdEXJEBQ==
Date: Wed, 06 May 2026 08:02:46 -1000
Message-ID: <c14dc57cf2227c29e315122d11902a1a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH sched_ext/for-7.1-fixes]
 sched_ext: Move scx_error() out of scx_link_sched()'s lock region
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_link_sched() holds scx_sched_lock. The scx_error() calls inside take the
same lock through scx_claim_exit() and deadlock. Move them out of the guard.

Fixes: 6b4576b09714 ("sched_ext: Reject sub-sched attachment to a disabled parent")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5661,10 +5661,12 @@ static void refresh_watchdog(void)
 
 static s32 scx_link_sched(struct scx_sched *sch)
 {
+	const char *err_msg;
+	s32 ret = 0;
+
 	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
 		struct scx_sched *parent = scx_parent(sch);
-		s32 ret;
 
 		if (parent) {
 			/*
@@ -5674,15 +5676,16 @@ static s32 scx_link_sched(struct scx_sch
 			 * parent can shoot us down.
 			 */
 			if (atomic_read(&parent->exit_kind) != SCX_EXIT_NONE) {
-				scx_error(sch, "parent disabled");
-				return -ENOENT;
+				err_msg = "parent disabled";
+				ret = -ENOENT;
+				break;
 			}
 
 			ret = rhashtable_lookup_insert_fast(&scx_sched_hash,
 					&sch->hash_node, scx_sched_hash_params);
 			if (ret) {
-				scx_error(sch, "failed to insert into scx_sched_hash (%d)", ret);
-				return ret;
+				err_msg = "failed to insert into scx_sched_hash";
+				break;
 			}
 
 			list_add_tail(&sch->sibling, &parent->children);
@@ -5692,6 +5695,15 @@ static s32 scx_link_sched(struct scx_sch
 		list_add_tail_rcu(&sch->all, &scx_sched_all);
 	}
 
+	/*
+	 * scx_error() takes scx_sched_lock via scx_claim_exit(), so it must run after
+	 * the guard above is released.
+	 */
+	if (ret) {
+		scx_error(sch, "%s (%d)", err_msg, ret);
+		return ret;
+	}
+
 	refresh_watchdog();
 	return 0;
 }
