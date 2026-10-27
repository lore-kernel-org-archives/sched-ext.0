Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060289;
	b=r8IQlVPHBrRfKpHjaG1iS6BA3SAu9WfcFIx0t2VmAYS4kMSXVgrAP6ne1ScKKtb+8ftz
	 fHUGhJM5GQzn9aLqNN3Cs9ljuMm8o6oz/n/aNEB7XCktAxX/H7IIAQ+5PCwXeyaQy6PHn
	 0oCYvk9m2TnFU6OlRSShzm7uF1YcZOacwfwmf99qPsmAdPjfmm9xkkDrfi3maroHGuHzi
	 XQ5hB3MVnuMUZhPFwyELBJ3JdBTYiSaEPjeYFf9YtNQosSmdbkbmRJSjwHRCO1PQKU7S/
	 PyIFMOzT+IIQJWMFLVcdyC+pjSDL0jbIXpjSsaIXO4FFH9ULNinrnsH8azja2utQB0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060289;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O7IKJ8DdLW/sDRtD7i7Hvp9phGN2BSdl7rmeVOpgZJs=;
	b=VLJ+OflE606i0yDGP7JfmwjYpIi2peWg2TA9ZAAV+ahLJEegtj9muv1l06To55Q6VNSL
	 v00hp5oR8Bzi/Oce24kVH4awmH9fbW7/Ixz9vYdFI/RoV05SclGQuo3B+j0E8uvb1axAr
	 y9O6baL5zC4xcLPv1q00TB4H72ulzHcinHFbpTL9CMolNq8jos2FatYCU8iKlhLCgWCk9
	 HGsgTDeIVwfd9SHUB94WePe05YSaNDaoQ/J3ZiNemORVJL5DuAtuD4dsiO468X8Pbxmsk
	 FQ/wYFcUdRl2r2PJh4HMaRhhNHSi/MthP4BeFh5y3bj5Bjny221H9kPRh9fBwTq1RTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTXSjUgl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625F60A263C;
	Tue, 27 Oct 2026 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTXSjUgl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF24A1F031E9;
	Tue, 27 Oct 2026 00:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060289;
	bh=O7IKJ8DdLW/sDRtD7i7Hvp9phGN2BSdl7rmeVOpgZJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LTXSjUgl1YRp/bg+IoBMMQN7IQef3/Ak28iJTd2BDpQJIJb/cTi5P6Wvhp+oETMgT
	 T1LwEg70dazsURB/SEyTwwdnA/PbLu6xrzDAajQDKdU2B9xHV6xvtLnqJHS21aM/LT
	 t2JQJs9S7JaqS7PxTcePecTAg5dBo2iKF2hPR346aZMoqLaeuKgBRJgT3+q/4Os2HU
	 rKFoM4LrOPFvb6W0NnKQZkD1bkKcOagVbu/NUOf3BaCLbMIaMrTJdOGN0ag0+Sfm/k
	 kwyA1/XoRo2kkfd4eclp9dzhxHNV8nqUamO7GiqV3kiA6lJEDdToghDdlW0LkQi9Ig
	 uI+4mrw29HvNA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 18/18] sched_ext: Fix a lone IMMED task waiting behind a kept prev
Date: Mon, 26 Oct 2026 14:17:49 -1000
Message-ID: <20261027001749.1821379-19-tj@kernel.org>
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

While dispatch is in progress, rq_is_open() returns true and dsq_inc_nr()
schedules no reenqueue for an IMMED task inserted on an empty local DSQ. The
check at the end of dispatch_one() schedules the reenqueue only when more
than one task is queued, so a dispatch that keeps prev leaves a lone IMMED
task behind:

 1. a parent's ops.dispatch() sub-dispatches into a child, which consumes a
    task with SCX_ENQ_IMMED onto the empty local DSQ
 2. the parent extends prev's slice and dispatch keeps prev
 3. the local DSQ holds one task, so no reenqueue is scheduled

The IMMED task waits on the local DSQ behind prev.

Schedule the reenqueue when dispatch keeps prev and an IMMED task is queued,
as even a lone IMMED task can't run right away behind prev.

v2: The description and dispatch_one()'s comment are reworded.

Fixes: 98d709cba319 ("sched_ext: Implement SCX_ENQ_IMMED")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index c7a5eba4b468..b7a78be01b42 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3500,8 +3500,12 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	 *
 	 * - A non-IMMED HEAD task can get queued in front of an IMMED task
 	 *   between the IMMED queueing and the subsequent scheduling event.
+	 *
+	 * - When dispatch keeps @prev, even a lone IMMED task queued during the
+	 *   dispatch can't run right away.
 	 */
-	if (unlikely(rq->scx.local_dsq.nr > 1 && rq->scx.nr_immed))
+	if (unlikely((rq->scx.local_dsq.nr > 1 || verdict == SCX_DSP_PREV) &&
+		     rq->scx.nr_immed))
 		scx_schedule_reenq_local(rq, 0);
 
 	rq->scx.flags &= ~SCX_RQ_IN_DISPATCH;
-- 
2.56.0

