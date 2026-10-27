Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060285;
	b=yiILajmVAqQyFgVIxPhMb5VIKHA1oe7bvAH5T149MGI26F13KiMJ361HOR6ql/jdTowz
	 ex6+fUQH9zWnCwSUtphSlZu/TBHyxG6TkbEZI8EjQ++ALmMgZP2E5ceY7RncXhuSPa7be
	 ENFNtJBpZlhaeNFpCV6Xgdi61EQu6wh73y8FaX8usV5Lpa3UNteBcRCl9mJh2Odcr7WwO
	 zRwWMYO18CvLIlId+jeD4fW7YUWcwgWePv7HtJulTquGx52+utmAgT1ncooc51+PZjTgA
	 Iarj7KunDBcfNtcLb6xJFMrH9G8Vyv2j1M4trOv0aMMsxAJWKyp4AEdIhlIBt9Zb/hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+pk3juObRaqIE357gO1AOG/A5wEbiCgigFWXtIPC40w=;
	b=LHivF9PtwYj6CnNMxqYzPDxDY+KkanII3q9DkfDtVv+7WyVKAKjPABK3rdlQe38EXnoV
	 g8lUtfYraa1bvP6YHhi2+XBR5b4OxZx/zKAa/xBvKD7VhXLrfIb7Nuho3FNKae7CJgKdl
	 9Acte7KTTqFaavqtMEkBJskE12aa+HoACGFBsp2TZIMz9VhGfByANEJLh+UYsiMlr7FVc
	 1T9CjxxTYtFSp/LC2rAo3HjFyOKU8wfQxhElkZ53aow0ePayTpo9OIANBEjHdVgmAjSTZ
	 jKEziqD/0kB2xFlMlLgMbXJ9G9kdRYo5KuUhTh7l1xREQ+HOCuHTM8ksok4NZ2q67Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jUNQ/gb7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A7606A336;
	Tue, 27 Oct 2026 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUNQ/gb7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64A91F01825;
	Tue, 27 Oct 2026 00:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060284;
	bh=+pk3juObRaqIE357gO1AOG/A5wEbiCgigFWXtIPC40w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jUNQ/gb7Vi3SGcpL6zSL+/Yx3oUeOVysHj2MUTjF/HuvCddHraI1//49Im3/YyZjR
	 EOCsOAUl7nRxKpg8OI0EsCdoEP09R9wmkNbU5uU7PAmJzlNYrXy1A4Ezz7t3m1zf51
	 diNCil7b+7Rj+e3CsZeYY4A3kawg76H3cfKziuWN9FScj+dLB6ubQRMHuLxCZ2CFP9
	 dvU3ztGT2L0dcC2S9gzeZAEpLu7kv9k2gDkLQ8zo8gXrMLnrFpSouUGB7CZnMZzbhR
	 RPiM3Vr86y8xSwhbWVTvO8xwjiLNI8V27Hw0jnCmAKsZxESRZFIe3j/OL/JjjjYiGW
	 8fQsJYxA9TnfQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/18] sched_ext: Fix the bypass load balancer stranding tasks on cpus where the host lacks SCX_CAP_BASE
Date: Mon, 26 Oct 2026 14:17:45 -1000
Message-ID: <20261027001749.1821379-15-tj@kernel.org>
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
index a75d3c3bfad9..ff79d9af0389 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6741,7 +6741,9 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 		u32 nr = READ_ONCE(scx_bypass_dsq(sch, cpu)->nr);
 
 		nr_tasks += nr;
-		nr_cpus++;
+		/* only a cpu whose dispatch consumes its DSQ is capacity */
+		if (!scx_missing_caps(sch, cpu, SCX_CAP_BASE))
+			nr_cpus++;
 
 		before_min = min(nr, before_min);
 		before_max = max(nr, before_max);
@@ -6760,7 +6762,9 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 
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

