Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8B2DC783;
	Mon, 29 Jun 2026 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762237; cv=none; b=MKaRlcXVtBgIsnlpF5rWtm1QDt2FY05PtRSyZUY74DPLiAPE+0jubY2Gql2YwkLqnjnIgssjI+1e9Fg9u7MX3emesYZJBfGxhH6flPbU2WE8lTMUzzF2LXO+iAsNEGHSyU3uextQEAdhVBfHD6T57CDl8yB8pA3XDYaY0HPv8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762237; c=relaxed/simple;
	bh=JMx56omWB4DAQQLOt8z16auoY5S/+NihuMlwkWPu3eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7rHSOLVBIdtTXMJJGbkiWoq8SXSFKoMdG6sF2PNEmLmbl4pjpH4ppu3/3aijjjt8kk7MUQtW+1fpbXaYH+I2jQtiRZSV4AR7H7eFLGwz8Mi76MMQI/e1dCuMnjJLkF5Kx9d7+5coDvmOJj4TnxHgEbc4tWX1w9ftAY2INGH09U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEWv+ene; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEWv+ene"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177CC1F000E9;
	Mon, 29 Jun 2026 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782762236;
	bh=ugt0aFUmzJBHBpeCJcOY7f6jT4Huo1i1jtwwPl4zwR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gEWv+enepEC0FkSJtBlIeh1avo0qp5C0OR3upScqXXh9e5lJaj5OaTEt9apAPkyEO
	 qXbvvrb0W+OZrq3/mjT56eCBZo7Sb7S/LIABgx5jd/b3KvKtCzdfGqyCZvVJDqaFWk
	 Tj8ZGnIsDcOm2Bpe4halXPD2/DZ9TK3PPcip859z87nkmVHnOnFSkCHL51GNKOTPPt
	 xL70XtzG++/FO2R6uUyZXq21/WbauTkhUlxrij7UHVJqplsbqWN7pIVCStk+WSJR/r
	 aE9WTkeFWUSOfwCJEOISkztFfcTZp4LrGcjIhuSrAPmXs95rJvPaXh/EpPYhunp7x2
	 sog+ANqV6aTGg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Kuba Piecuch <jpiecuch@google.com>
Subject: [PATCH v2] sched_ext: Don't warn on core-sched forced idle in put_prev_task_scx()
Date: Mon, 29 Jun 2026 09:43:55 -1000
Message-ID: <20260629194355.3143816-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624235531.2979880-1-tj@kernel.org>
References: <20260624235531.2979880-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

put_prev_task_scx() warns when a runnable task drops to a lower
sched_class without SCX_OPS_ENQ_LAST, assuming balance_one() would
otherwise keep it running.

Under core scheduling that assumption is wrong: a forced-idle SMT sibling
reschedules through the core_pick fast path in pick_next_task(), which skips
pick_task_scx() for the CPU, so balance_one() never runs and a runnable task
can drop to idle with ENQ_LAST unset. Skip the warning when core scheduling
is enabled.

v2: Reworded the description per Kuba Piecuch's review. No code change.

Fixes: 7c65ae81ea86 ("sched_ext: Don't call put_prev_task_scx() before picking the next task")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9c9cb9d08bca..503c4d2105ee 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3092,7 +3092,9 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * which should trigger an explicit follow-up scheduling event.
 		 */
 		if (next && sched_class_above(&ext_sched_class, next->sched_class)) {
-			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
+			/* core-sched can force cpu idle while @p is runnable */
+			if (!sched_core_enabled(rq))
+				WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
 			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
 		} else {
 			do_enqueue_task(rq, p, 0, -1);
