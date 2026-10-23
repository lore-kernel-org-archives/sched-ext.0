Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733107;
	b=gwt15mzGEfinx0fu2eknhO4HjwLUUwEyFgcy5A4bNs85LbN0TRpQkT4RrM6pFxKF02CK
	 oW3qd9N1UPUiKkElXEF+BGiuZEeVWb/MjpQ4h37R1+Mt5FdiLeyYgFR6W1+wC3Nfo1Cbl
	 btySOWeaA6lMbGqLR1Efvnalsdn0fic9hhcWnAM3kEn4d0/Gt7VUv8Cqm5pSvyPjdFAzG
	 HV50Vcb8SE41R5njiQsfDSpZXta9K4orrk0DnjGeMQU1dsj9XvFvBYHIYXGJ6EuCG5o/4
	 jFMPJzxsgvH6GhjXvN+BcctG5q25UvWxiYl2WnbwtJ9ZvhC+3ff9ojduOG4/V+pjV2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733107;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lXJohiPER6DemBMUvrBmP00ekVnTRKDzSwnwMPHQm7g=;
	b=YujlRZ/dR/wkQTZoLPXhYtY8eqcLiANecqnFy/207Zavpj0krCenRmq8x1xeNzfMEEKe
	 Fzyl/HKK1+WTCU3j1Glo/EPKgHkhaUo05DxDhmagylpe/yqURkpWvAML8rneNUfiTlWXa
	 doV7J1f0Lv9z3dyOZ89PwqJfPxrOAVo8NdC/W/zw2+zdsD0Iifu5t84Qr7ftrtZtqe54k
	 8oiErBDVlk4wDJQgyQxNXPREhrvczA2Mff6WzwZAGaLXCUd6CtOqqJI5GwIiw5KJWAKq2
	 dPz37+MPTM2QuhRnblE9aQ7wDmbUUyZN+Tq1nSdzrlonTRmmH6zG63bdF53SIolioJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DlGJ//EQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905A606A32D;
	Fri, 23 Oct 2026 05:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlGJ//EQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B53D1F031E3;
	Fri, 23 Oct 2026 05:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792733106;
	bh=lXJohiPER6DemBMUvrBmP00ekVnTRKDzSwnwMPHQm7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DlGJ//EQoYykpalgpwlUqS+NP3HxLwuJgut6pPUwgnT8pmMqplqtI2lHN7k2lpmi7
	 pQeIsQTht4lvO1iQ+jCO9MEMJiFtVhSNbJBFzCMzuhelae/FH3JbQEfTFaKNM7DqKD
	 xQGQVExG0gvDPfwe0BC9CxidMr+r7u00Tr/9xW61u6H2XtQjsTARA8M8QaFMkONMsQ
	 bxwfhvqC/y9orHUNTr2Hk0hKU26/Q8z2ZsFOnIiTApCeO+WpkZO7jKGflIzIaq7zIA
	 WUxw9Xu6SjOGi57brWSZdZdwAFwfoH4tmTz9esvD5OIz0iio1D0xF5xS1mS2bVF6VM
	 raBV2r3gnbUwA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/15] sched_ext: Fix the bypass load balancer stranding tasks on cpus where the host lacks SCX_CAP_BASE
Date: Thu, 22 Oct 2026 19:24:49 -1000
Message-ID: <20261023052452.2889061-13-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023052452.2889061-1-tj@kernel.org>
References: <20261023052452.2889061-1-tj@kernel.org>
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
index 9ce023b2f2ba..f4f2f1b5b98d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6637,7 +6637,9 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 		u32 nr = READ_ONCE(scx_bypass_dsq(sch, cpu)->nr);
 
 		nr_tasks += nr;
-		nr_cpus++;
+		/* only a cpu whose dispatch consumes its DSQ is capacity */
+		if (!scx_missing_caps(sch, cpu, SCX_CAP_BASE))
+			nr_cpus++;
 
 		before_min = min(nr, before_min);
 		before_max = max(nr, before_max);
@@ -6656,7 +6658,9 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 
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

