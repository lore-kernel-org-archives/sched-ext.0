Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688AF3770B;
	Sat, 25 Apr 2026 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777076392; cv=none; b=cG9CoJS4Q0mZfpBp9zlW6PdsvdRw82D36nr2ovFKcW5f7ecI9YCHqQsmdeNXGZmX4SXc8yyPCzlXDXakSVXBZ1J6Xxjye4cMZcbx3iBm7Ar7o597E3y/3/n2jInkDHCELnYIezGr+a2GfndUzn/u88t6IRt/AwCSfPLK5zff62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777076392; c=relaxed/simple;
	bh=1rQl1kz57C+2Jj8ePDSsF36CcOKHMJC4UZU0bYpnFwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlsiTh0qvTojNrDnR/oNRoCDMshvzBktE230wyzwkw54mx27cp93AW7WZe06Hc3JDdmPe+EP2w4ruUai6bdkPoilYbnC+Glg7kFvqY/8vtG04LabGIPFnt/fv1PTRtw3YN2YC7UFSIl4CN7RzoUwUR8o5uwdOE0VtktCBun7a/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBgHypV0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBgHypV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E988BC19425;
	Sat, 25 Apr 2026 00:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777076392;
	bh=1rQl1kz57C+2Jj8ePDSsF36CcOKHMJC4UZU0bYpnFwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBgHypV0Wyi/Kya3CBJSOO4ywWjvSYKIQwxZFWT9V6cEUTgDrWvLI9eApjPBNWQf8
	 VvqJXqV5igKSRN9vjDnEeSfnN9XEsqRobkYZOPhJu2Vy334sAqwYwKjtqjMNyp56dZ
	 ebgN+gmDt+M16dTgv4yCQ80EUl9mOo9jntRIlWnqTQgIBiXKfLoML16yqZUCK8+zyw
	 4e69cpGKRaT6WsUpeT8T2nujThx8s8pZBiBZq4VixYt/YISbzz445lpyKtTtf6Ovuu
	 e7KAh7EgL19Txq99W0rnNn1kJqtEtf2i/U6rOKiRByp95exA3TRnhDqd1ngz+H8ics
	 g1Crd4HoBAAVQ==
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
Subject: [PATCH v2 15/13] sched_ext: Release cpus_read_lock on scx_link_sched() failure in root enable
Date: Fri, 24 Apr 2026 14:19:51 -1000
Message-ID: <20260425001951.3987485-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424210802.3842919-2-tj@kernel.org>
References: <20260424210802.3842919-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_root_enable_workfn() takes cpus_read_lock() before
scx_link_sched(sch), but the `if (ret) goto err_disable` on failure
skips the matching cpus_read_unlock() - all other err_disable gotos
along this path drop the lock first.

scx_link_sched() only returns non-zero on the sub-sched path
(parent != NULL), so the leak path is unreachable via the root
caller today. Still, the unwind is out of line with the surrounding
paths.

Drop cpus_read_lock() before goto err_disable.

v2: Correct Fixes: tag per Andrea Righi - the missing
cpus_read_unlock() became a (latent) bug when scx_link_sched() was
made fallible, not when err_disable was reorganized for hotplug.

Fixes: 25037af712eb ("sched_ext: Add rhashtable lookup for sub-schedulers")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f333fd0cb83f..9eda20e5fdb8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6736,8 +6736,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	rcu_assign_pointer(scx_root, sch);
 
 	ret = scx_link_sched(sch);
-	if (ret)
+	if (ret) {
+		cpus_read_unlock();
 		goto err_disable;
+	}
 
 	scx_idle_enable(ops);
 
-- 
2.53.0

