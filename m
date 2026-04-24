Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6324341ADD;
	Fri, 24 Apr 2026 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064885; cv=none; b=eY4D2bsgiqvNmOusU+iKjfkvmHhyl8hF57a+xWSXSS5zbhkHbdkqj1BTqqzFSFP5cTQsQ6SSSugDQS75Nefb7vV2AaDvh4usOyUhZtcQy9k8d7st/tTTkL6G/iO6dVoALxqUcx0dlC81GLXLYSKX5apEr9CZBLQ1rv23TTMR2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064885; c=relaxed/simple;
	bh=/1KW8mmoj/pIvNZ+vMXwzIjF/eak/+rNjojVwBO80rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FENDBXIlU4PxdYK0FC+2qpg6kuZW9LnN31E2wX1ix2aOhiClTa4hrr8bLA5xkHZeUgcpyG7FvQetFtZj3xk7cTvyvI1AnUDdqWp5apT9sTDRcNJ0sv6Rpd3W7iu7df2BaRVTl7diwOPeX7ZwDOlaCx7VmnAnYoqcltMqfb5n3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmpztgA0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmpztgA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9E8C19425;
	Fri, 24 Apr 2026 21:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777064884;
	bh=/1KW8mmoj/pIvNZ+vMXwzIjF/eak/+rNjojVwBO80rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmpztgA0S0yxlSw1BStrordXD/u8DwQQFUlWQ5M2oPrEheJvNQVr2utqW43WC4a09
	 Ghst/Ah3yDRasyFbus9eZlaQ7aKvIcLB9h6nq93vArNcJ81PLoaPkNvjAGghly3m8V
	 JEa+E4GpK3RaZl/Tp3Y1/ccxABoDOUg5qSVZNWGDE0V+IgKzzrPps/gd8BSkregg+5
	 qZifrproOrQ/2tsnyBwozBIV8RycQJrG7oAqMsSRXEwtURdMvLSiELiavmzG0Z/r3e
	 RjJ1osHbkY06NzoAnnKPORkwYFc3zrUpyvsaqZc9g/9di2hD98//TX32sakfWRYmMU
	 8V4x5ll6jKSlw==
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
Subject: [PATCH 15/13] sched_ext: Release cpus_read_lock on scx_link_sched() failure in root enable
Date: Fri, 24 Apr 2026 11:08:02 -1000
Message-ID: <20260424210802.3842919-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424210802.3842919-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
 <20260424210802.3842919-1-tj@kernel.org>
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

Fixes: 0128c850513a ("sched_ext: Exit early on hotplug events during attach")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 52b63266e647..d374a5a16bf9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6715,8 +6715,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
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

