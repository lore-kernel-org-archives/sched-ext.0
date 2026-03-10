Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5FC272816;
	Tue, 10 Mar 2026 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773105416; cv=none; b=dg7Rnt/lHMiP/kykdd5geOhYENWamBwRYiW35HZG9wiRsXjWW0+u7g/e8RgzJxU8399jeBDHhAOH3T74dZhk49x7dLvEYWA+HUKbLTGxffluN/pNLHj/rkhB7JvDdI8NiORb6h+ipiZFRXPe0o74ek9XU2TKsBvYwDrfMO00SHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773105416; c=relaxed/simple;
	bh=Ugjp/jKuP8pOWyYoERql3flHwKy/vCgbKNCTPuMZuGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVSNSGheQiTglo932AO8zmVkOaLjuL7bmTLxYi/8rfik5OTB2qUinRHtzrcXRHGktkNIAVOGwOzy6cgvjt2LnPbWq80E2lmw6Ak9rvnueXMRsFFHaRJ4wb/o+u2gl72yyphln7Kua1xzJ99tLCvNszkY3Ft1rnrHLnbmplvB1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRHdeLjg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRHdeLjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101AAC4CEF7;
	Tue, 10 Mar 2026 01:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773105416;
	bh=Ugjp/jKuP8pOWyYoERql3flHwKy/vCgbKNCTPuMZuGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRHdeLjg3Ta1T9FjVkpX50lB5ufmWdqLRf4VHS300LpNZus4rMZ5DBY9K0Muh4GRr
	 hdjrLN4uRxf3MmhxayrJtIDx1AJNhNAtIuYAEcvXKIIeCNLv9lrfrKMJkHtXvFzBdp
	 hdoXYo5sDerniB1RM74Eqqjo6sZKaAj2rtoYzt79qLbHT1v3Sq71rx5ct9eXGyFloV
	 nuoYSlm3N3TDkOf5Kxs+c/9+4os2ywCGCKv5DQd7d5CoBBzvyBwwPzip9010YgVKY1
	 vBrczOQOpcYiq93C+kjrDhSj3VE5tg5ayUf8oGKNHTVXrf1rgihQZVRPtcinGOP0qE
	 DumEmAIKb6onw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/5] sched_ext: Fix sub_detach op check to test the parent's ops
Date: Mon,  9 Mar 2026 15:16:49 -1000
Message-ID: <20260310011653.2993712-2-tj@kernel.org>
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

sub_detach is the parent's op called to notify the parent that a child
is detaching. Test parent->ops.sub_detach instead of sch->ops.sub_detach.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 07476355bfd5..8bf4b51ad0e5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5438,7 +5438,7 @@ static void scx_sub_disable(struct scx_sched *sch)
 	 */
 	wake_up_all(&scx_unlink_waitq);
 
-	if (sch->ops.sub_detach && sch->sub_attached) {
+	if (parent->ops.sub_detach && sch->sub_attached) {
 		struct scx_sub_detach_args sub_detach_args = {
 			.ops = &sch->ops,
 			.cgroup_path = sch->cgrp_path,
-- 
2.53.0

