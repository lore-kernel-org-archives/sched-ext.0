Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD13C5550;
	Sun, 17 May 2026 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039798; cv=none; b=VXF6VqeXHuJBJwNulzJ+kElMPYCGwkEee/UdoJ5bisAbHgie1IEvvq1/hF9BosR8kSpZY5+i8+Fp4cFg5oc2izl5wELukUt75+n1jubkwmAoCHaH8qhrOVf+j4n8WzV2GfJz1bLmH0xBTY8yPMdmC3cAmR7ZmYGH6K4BT2CS87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039798; c=relaxed/simple;
	bh=oMcabqa7ckLbeIffII0TWoaBZoS4wfj87DW84kw4YIw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=jXvcK0FmMZTc8cDGDh2A3I5hmV7mbEB59hxxgZL+YIxAFMmpERHuOwUZeBTvHwZ48Ss4l2uOiU/20dr1qaCnFcDh5CMXXRpah9uASI4RsI4SrQjFMjdZN9MDOx1KwIstTCXiXpuy9xiTigE8tkZoAXjAnmArDTlQ2xtNV5Y1BG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlAY72hH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlAY72hH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA03DC2BCB0;
	Sun, 17 May 2026 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779039797;
	bh=oMcabqa7ckLbeIffII0TWoaBZoS4wfj87DW84kw4YIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dlAY72hH90b5J086OK22AzzLvlt4nktR58Oh7omEaLFRscsL08PfPSeG84zdTtCjS
	 jF6AEZPbAI+v/PLz0/TFxFAOl3CvTcwTdmr0cTCxYVvxkQS1tnc6T6CtAnVaE3BWkD
	 tF8HFTO8SGBe+iBLNiNeZP8PPEvrDN+uO8axgdvM6v5oKmUliXNmR0Y3zBn3FJI0y3
	 wJLmcZDwQr6Qr8BndW603Q+3B6MH2TrJ2JY8QflQKlR5EOsn4MN/OBI4rO5+u9IKBa
	 GRJM1DCkyJfMdmiDp+i55hvGQn4jWWuxx0Djw2oR+iujmbed2H0SHgFhvWnrhPKzxZ
	 hqpsMDdStn6mA==
Date: Sun, 17 May 2026 07:43:16 -1000
Message-ID: <362a365eb559003ed21c6dac12d92c5d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Fix deadlock between scx_root_disable() and concurrent forks
In-Reply-To: <39ab37b4e79c6e5361a907c06ab27e72@kernel.org>
References: <39ab37b4e79c6e5361a907c06ab27e72@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_root_disable() enters SCX_DISABLING before it grabs scx_enable_mutex to
clear __scx_switched_all and scx_switching_all. task_should_scx() short-circuits on DISABLING,
so forks in that window land on fair while next_active_class() still skips
fair - the new tasks stall.

This can deadlock the disable path itself: scx_alloc_and_add_sched() runs
under scx_enable_mutex and creates a helper kthread; if that new kthread is
one of the stalled fair tasks, the mutex holder waits forever and
scx_root_disable() can never make progress. Only sub-sched support exposes
this, since sub-sched enables are the only path where
scx_alloc_and_add_sched() can race the root's disable.

Move the DISABLING check after @scx_switching_all. @scx_switching_all
serves as a proxy for __scx_switched_all, so while it's set, forks keep
going to scx. Once cleared, DISABLING applies normally.

v2: Reword in-source comment and description. (Andrea)

Fixes: 337ec00b1d9c ("sched_ext: Implement cgroup sub-sched enabling and disabling")
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5092,10 +5092,30 @@ static const struct kset_uevent_ops scx_
  */
 bool task_should_scx(int policy)
 {
-	if (!scx_enabled() || unlikely(scx_enable_state() == SCX_DISABLING))
+	/* if disabled, nothing should be on it */
+	if (!scx_enabled())
 		return false;
+
+	/* scx is taking over all SCHED_OTHER and SCHED_EXT tasks */
 	if (READ_ONCE(scx_switching_all))
 		return true;
+
+	/*
+	 * scx is tearing down - keep new SCHED_EXT tasks out.
+	 *
+	 * Must come after scx_switching_all test, which serves as a proxy
+	 * for __scx_switched_all. While __scx_switched_all is set, we must
+	 * return true via the branch above: a fork routed to fair would
+	 * stall because next_active_class() skips fair.
+	 *
+	 * This can develop into a deadlock - scx holds scx_enable_mutex across
+	 * kthread_create() in scx_alloc_and_add_sched(); if the new kthread is
+	 * the stalled task, the disable path can never grab the mutex to clear
+	 * scx_switching_all.
+	 */
+	if (unlikely(scx_enable_state() == SCX_DISABLING))
+		return false;
+
 	return policy == SCHED_EXT;
 }

