Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705129;
	b=NHqp3WuSCNtQnqegJsOfQm0XHqwYYe2QJiTiFHo3SREnalRzdjin0DxZZ/ZKCWaMlzMu
	 QtTzV8E5GjPHJMCv0mopcaNIZ9MiMVyO0Zh1U/IT2/HpXcVd+1f57aaMlQXba/OvNWOLa
	 r3umzGdgrmMddabGEBkbdb3whMxlbrtoGO9FEa0CpgidiLG05LNRvvUt31Q+nQ5PIY8kW
	 V1Mu82WKaIdgg1WhW7XrWO8bhjmN9N6JRjw+pOcyoDIQI2bgPxTjuO0drXevfEkKFlP2r
	 dX03I4qzRtFLsUKwGZ+Jscvw3tVCcJqJorJZrtB/LrvU80Eh4oVsK5haCly7AykyAkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705129;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8RlYWm+VZqgIajB3CyQFAuhTTxZ+n3zAdAuC4/IomS0=;
	b=qbO1EJrKtLWrpehjeyX9oyUQFiMONKKOtbVxyMS16bA92UdNr/WIhYQiacw8yrn1R5EO
	 52TnqxyDKwldKKC6FJ9AgDducjHr/UnRecA3mXlmnPiv2NYJYD11nVOCyUy65VjtRhApY
	 PUJ6+H5IeqRtQJUJuY+7DgTsXbMw1KQ09W8cUr6xMYoolGntLYFXrpYw80es+DiTPYiIf
	 hw8S+b26TMv890TBx6Cby+YfwtQQFh6DMX5HL2ALeXEBr510GEFk0+dIkbKxezBQPbZi5
	 X7REsNOWoPiaiU/SOspvLqpmlUty998nP0v3vDAN3kg1IKRW8jdXB14lOUR8dhDivDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvZs4A1s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85AA606A31A;
	Thu, 22 Oct 2026 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvZs4A1s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C921F01825;
	Thu, 22 Oct 2026 21:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705128;
	bh=8RlYWm+VZqgIajB3CyQFAuhTTxZ+n3zAdAuC4/IomS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jvZs4A1sMEwHaaRbRvg/3AKi9hu46zdgSSK2CsiblEz30EA91fNmMSzV14pkS8VaR
	 67qqjEYekOa9aOssUS3PQAHv7pbz0hmjLVJHcC/ym548wmiSRxUj+DUsFO8nu4OTXA
	 OEu7co4g5aJB349mzKqOBoR7UphgRTnz/0gNI69lN+K65a/9bq4LnhEU7FfhYyvRW1
	 bA+l7DDHMBfx4M1JcNQ3/+MzX5ycqrPqFcHMRgzct5ngLHgdiiwOT2OHnVzHpU+dJZ
	 r/qdw4w8Zkd+R/CRomy+JNle4H3agQEwSvTrCCtBrVdzYJvih+Wadfo/t2Ey35Jrv1
	 ABa3Vgf7Dq/Vg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/14] sched_ext: Fix the bypass load balancer stranding tasks on cpus where the host lacks SCX_CAP_BASE
Date: Thu, 22 Oct 2026 11:38:33 -1000
Message-ID: <20261022213836.2259069-12-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022213836.2259069-1-tj@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org>
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
index 348c63901b51..5a0c7ddf48e3 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6614,7 +6614,9 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 		u32 nr = READ_ONCE(scx_bypass_dsq(sch, cpu)->nr);
 
 		nr_tasks += nr;
-		nr_cpus++;
+		/* only a cpu whose dispatch consumes its DSQ is capacity */
+		if (!scx_missing_caps(sch, cpu, SCX_CAP_BASE))
+			nr_cpus++;
 
 		before_min = min(nr, before_min);
 		before_max = max(nr, before_max);
@@ -6633,7 +6635,9 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 
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

