Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312C9443
	for <sched-ext@lists.linux.dev>; Thu, 30 Apr 2026 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538758; cv=none; b=ENBKHWR4pqUh81loeCsS8ncqJniLcr2Al85dIArHqNsrODFWd1NoK8ct+iSX++cfjQ5MFmm482oFdOwAEbgwzH/4yivAZW8YwGq5t+e52YkgcYUd6VKO1iYJpwRxzu5rjaJoWWw6g2yUL76AVE93dR4rEneL71c9zPHc3Y1YCHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538758; c=relaxed/simple;
	bh=XG1JpCj1PVjtKlFUM+aogmb5LHzlS6tTL7popB9zMdk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=n5Owi2yqDeBeqjLZEGh03fRnVkgV8w6s9AygBZ9uWpwXD273xGGpy+XnXw2H3dMATqelprnXs9yjGwmMNpSit0Tkx7+cSawiDK+kDElIY49Pe02GI7DogrUoPJWlWG8qoIScDXV6yiU/UAyoZjhL7l/SlyR4GjqHW2k3MJSGihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OHzHfqPV; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OHzHfqPV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777538754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=LZPC9sO3rCTy4EKRx4TxyKwcU3j58hdJZ1FAznjk8mY=;
	b=OHzHfqPVp7JqOOjX0qnsFEIzfaEx8yICDnmTObfni4ZRwmAnkh4HFs3aFMFK17jQHPnWMp
	ngapj84poBBu6q5IasBHjTrWKK5MltZwheOqWywSr3+pB5DqWkvansgSUu82EsHppgI5tE
	jepv+hvfxhIKbYlT2GiWmyQLHL5ISIk=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] sched_ext: Remove redundant rcu_read_lock/unlock() in sysrq_handle_sched_ext_reset()
Date: Thu, 30 Apr 2026 16:45:43 +0800
Message-Id: <20260430084543.25137-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The sysrq_handle_sched_ext_reset() callback has already been
executed in the rcu read critical section within __handle_sysrq(),
this commit therefore remove redundant rcu_read_lock/unlock() in
the sysrq_handle_sched_ext_reset().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 45a2668284bc..0f3e9d088151 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7953,13 +7953,11 @@ static void sysrq_handle_sched_ext_reset(u8 key)
 {
 	struct scx_sched *sch;
 
-	rcu_read_lock();
 	sch = rcu_dereference(scx_root);
 	if (likely(sch))
 		scx_disable(sch, SCX_EXIT_SYSRQ);
 	else
 		pr_info("sched_ext: BPF schedulers not loaded\n");
-	rcu_read_unlock();
 }
 
 static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
-- 
2.17.1

