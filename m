Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D2842B75A;
	Fri, 15 May 2026 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836732; cv=none; b=o/Zwn/G5pmb6Ds+yrOBfsp+wU0jajbHQtYQF1PGlnxpa47Agf0flg0+GSbOxFgFXkMfi55FfniLxSkafFmJPaZn8eBkBPTD0A96vOnfRdWYwWcmUsj6fm5TEmTMXtzwgj9pqk5KFpO4zCSYvxR9vtx8GPLt0EJ4XY8ZiKBy99Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836732; c=relaxed/simple;
	bh=hHO4IftE0oexX//BUwjfSkYBfFwT4KK0MKQPEEnj/H0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=lgDf+98pnWKR4jxV4kHIXwqwLBTr8ic/uIZxpFczP+jECgg5KKfhukcHEuDpL9n4VBzb6P6Md7ohS62pohMb5+B8jIGzYdyrSqUEfbZRbfwm6Aov/IcX1Z/rw4hzfrQGTlLd2pIEPRy8y6OULr7epwy++xLGU985HRuNKRuYQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2H+ZZSF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2H+ZZSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AD8C2BCB0;
	Fri, 15 May 2026 09:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778836732;
	bh=hHO4IftE0oexX//BUwjfSkYBfFwT4KK0MKQPEEnj/H0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=K2H+ZZSFh6TP0tVSBLw6sFimguFsDUOrtl+QzYp6XPaoSVhTGmUsu8FWpeQztfSRH
	 6oNFjjBFOMCv1ab49aiLN3MbKCkmWAOMahsWTk8GgKyjmbqCfY4HrEUQTaUFSGySrO
	 +CmAqgJ+azGPqkzsLIWj1Rh/CWz2QYS7XAozgiow=
Subject: Patch "sched_ext: Skip tasks with stale task_rq in bypass_lb_cpu()" has been added to the 7.0-stable tree
To: arighi@nvidia.com,changwoo@igalia.com,clm@meta.com,gregkh@linuxfoundation.org,pschneider1968@googlemail.com,sched-ext@lists.linux.dev,tj@kernel.org,void@manifault.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 11:18:21 +0200
In-Reply-To: <20260513130111.689740-1-arighi@nvidia.com>
Message-ID: <2026051520-oak-marlin-d109@gregkh>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    sched_ext: Skip tasks with stale task_rq in bypass_lb_cpu()

to the 7.0-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     sched_ext-skip-tasks-with-stale-task_rq-in-bypass_lb_cpu.patch
and it can be found in the queue-7.0 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From arighi@nvidia.com Wed May 13 15:01:26 2026
From: Andrea Righi <arighi@nvidia.com>
Date: Wed, 13 May 2026 15:01:11 +0200
Subject: sched_ext: Skip tasks with stale task_rq in bypass_lb_cpu()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Chris Mason <clm@meta.com>, Peter Schneider <pschneider1968@googlemail.com>, sched-ext@lists.linux.dev, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20260513130111.689740-1-arighi@nvidia.com>

From: Tejun Heo <tj@kernel.org>

commit da2d81b4118a74e65d2335e221a38d665902a98c upstream.

bypass_lb_cpu() transfers tasks between per-CPU bypass DSQs without
migrating them - task_cpu() only updates when the donee later consumes the
task via move_remote_task_to_local_dsq(). If the LB timer fires again before
consumption and the new DSQ becomes a donor, @p is still on the previous CPU
and task_rq(@p) != donor_rq. @p can't be moved without its own rq locked.

Skip such tasks.

Fixes: 95d1df610cdc ("sched_ext: Implement load balancer for bypass mode")
Cc: stable@vger.kernel.org # v6.19+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
[ arighi: replace donor_rq with rq, not present in v7.0.y ]
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4010,6 +4010,15 @@ resume:
 		if (cpumask_empty(donee_mask))
 			break;
 
+		/*
+		 * If an earlier pass placed @p on @donor_dsq from a different
+		 * CPU and the donee hasn't consumed it yet, @p is still on the
+		 * previous CPU and task_rq(@p) != @rq. @p can't be moved
+		 * without its rq locked. Skip.
+		 */
+		if (task_rq(p) != rq)
+			continue;
+
 		donee = cpumask_any_and_distribute(donee_mask, p->cpus_ptr);
 		if (donee >= nr_cpu_ids)
 			continue;


Patches currently in stable-queue which might be from arighi@nvidia.com are

queue-7.0/sched_ext-use-hk_type_domain_boot-to-detect-isolcpus-domain-isolation.patch
queue-7.0/sched_ext-skip-tasks-with-stale-task_rq-in-bypass_lb_cpu.patch
