Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778184;
	b=roARSrlmE9G11gzQt4kOHjLM5MpKY8+gSr0q9Fzrj9maMSJ2+AgIBnTDKqAMWuz66NcK
	 9fUPncXgjgR0Q4IAJbQyT4j5mp6xalJxSGdFoTVGHqW5wQvV6dwlMm2KK7j0RyFNr1D6a
	 HgiqipZp21gXua75HqEHwdTY4EambYQ0LH1IByR7zokpWTDi4auXCODpTPYZCIWhDsgj0
	 fK6i5Gj8wGFE7tu9aYCOQP6/93Rt6mbPkWAlYKoWM+JwZ+QNcR+aNtfXjnqghjGBZkAJn
	 3ueJmEjqeV8kOAbfxSe+gxegkac6hi0VVHNvvWD5n+8Prvqgoo6rzBaNYmm6zRd5Qkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778184;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=s5VsULS8Pd0YsHAB7quZqaT5K7vnTNHJw7IUASkn7to=;
	b=WhNhhJed4HpDJ2Oc/BpqeNgdEDb324JzqnOt12JuTXaXto50OTEE05dD5X2qlbyME58J
	 7U+3Tk/B8JUkEAUNm1ltv+PIbQTNcPNlZl2CuoGnk2z5NOCKPu0HJk9zdG7yL1Nh6OTmM
	 39ABDo7lmyHLm7aHOlB+leN1j9rZnDc2AJ0zxKYHLuqy2Kqm6CngIaV/6596cLc4vUAdN
	 YNS9LyD8pahnf0VfYWLDsxpczwzAZvDviQaErmnCgAGhTGDwC5swlGFcOYs8ub5sfBuzI
	 NW9x3lLG9n0dFdJ6Uab7k799tniKb0WRRuU0gmmK/X//lDpghBwmHcfCwI6TYqMKLWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfAWYcDq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267560A5BD7;
	Fri, 23 Oct 2026 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfAWYcDq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AE01F031ED;
	Fri, 23 Oct 2026 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778184;
	bh=s5VsULS8Pd0YsHAB7quZqaT5K7vnTNHJw7IUASkn7to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KfAWYcDq3CpEoxyu0fNCDlBz5dEGPHoh5Y7RzZfNfNeYDHyOSSaMA+a+E5GJ81MdS
	 I6cFjpzcHQuqCCslfMchUHlgI2xCOpdFw02N4of2O8IR9zJg8WEJU6hPp09uIGddvL
	 jNVLvixbQF5vac7ofqsSGM2BYxqOwiCE7bsZdJl6TAdeDp+Y63onB7eWINtHS8l5Zm
	 hPyRegnQQ1BiS8Jk65pzAc6xcm2r543RzC1twlxqJ2/b771UaGasSmVGwsWz2sNqnH
	 7sVbkIJcdGRBuWXsoJiH3wM49LuM5AF7ib/QDrT0pJtjSS8mPRycdxnz6EwIBMzwRP
	 7oJlsO/VuXE6g==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/17] sched_ext: Fix the bypass load balancer stranding tasks on cpus where the host lacks SCX_CAP_BASE
Date: Fri, 23 Oct 2026 07:56:05 -1000
Message-ID: <20261023175608.4120910-15-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023175608.4120910-1-tj@kernel.org>
References: <20261023175608.4120910-1-tj@kernel.org>
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

The bypass load balancer spreads a host's bypassed tasks over the cpus of a
node by moving them between its per-cpu bypass DSQs. It counts every cpu of
the node as capacity and takes any cpu below the target as a donee. A cpu's
dispatch only descends into schedulers holding SCX_CAP_BASE on it, so a
bypass DSQ on a cpu where the host lacks BASE is never consumed. A task
moved there sits until the host regains the cap or the bypass window ends.

Count only cpus where the host holds BASE as capacity and pick donees from
them. The target rises to spread the node's tasks over the cpus that can run
them, and a capless cpu receives nothing. A capless cpu with tasks is still
an ordinary donor, offloaded down to the donor target when its queue grows
past the threshold; draining it is left to the following patches.

Fixes: 147d1885f390 ("sched_ext: Add the SCX_CAP_ENQ_IMMED cap")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 54150fdc3bbd..8d87dca8bb62 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6652,7 +6652,9 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 		u32 nr = READ_ONCE(scx_bypass_dsq(sch, cpu)->nr);
 
 		nr_tasks += nr;
-		nr_cpus++;
+		/* only a cpu whose dispatch consumes its DSQ is capacity */
+		if (!scx_missing_caps(sch, cpu, SCX_CAP_BASE))
+			nr_cpus++;
 
 		before_min = min(nr, before_min);
 		before_max = max(nr, before_max);
@@ -6671,7 +6673,9 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 
 	cpumask_clear(donee_mask);
 	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
-		if (READ_ONCE(scx_bypass_dsq(sch, cpu)->nr) < nr_target)
+		/* a donee's DSQ is consumed only if @sch holds %SCX_CAP_BASE */
+		if (READ_ONCE(scx_bypass_dsq(sch, cpu)->nr) < nr_target &&
+		    !scx_missing_caps(sch, cpu, SCX_CAP_BASE))
 			cpumask_set_cpu(cpu, donee_mask);
 	}
 
-- 
2.56.0

