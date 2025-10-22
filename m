Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5451302159;
	Wed, 22 Oct 2025 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166591; cv=none; b=HoAwiETc4If6xmU2laHs4RUyFMcLGIGUXxE7Phx6UVr49A149PG97FE022HvMHc4z0nUe7dW+6FE/F9HDFqK4OsR+iHfmag1TiFjyUrTFcPONmWxfPcjYN3rxGYdX/603T/TAinU8A2+qbYNgjpIbQzVKLUh2/wWKE5nEGUHa2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166591; c=relaxed/simple;
	bh=LVwrH1mnEaEbxEuzHPADrm9yL17jQ8VcP0hQuGKArnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWxS/APqENT44K1fCYzFsyZHKYf7qyB8T7OOuBKqKIP1ohONP9u1T8xaCG9ErvdoK+ObJJhTvUxk0s2VJjKUAnCfsGmi7FI8Ldeof6FMA/WVxqEuKDNvynaBNOPIY4soe2JJPa/DiCCQqmidGpCSFEcRK51g86F23VRg16cdWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1TMKBKw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1TMKBKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D604C4CEE7;
	Wed, 22 Oct 2025 20:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761166591;
	bh=LVwrH1mnEaEbxEuzHPADrm9yL17jQ8VcP0hQuGKArnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1TMKBKwRN6VYDqLdF2zjvjeERyxFwYLklK1QzfQvF2N876qMUvp4szQS/t6Du7rh
	 iV5IyTz4xv8u+gXMhgrpjIOS0LEtIpHtE9k72NRs3rE9MsLlw5GbUii0YKT3cr07da
	 p7/1OOPlrY7AfBcaeQsNe6yEvsrlie4lwdFXPiDvg9Z1lomR4qHYXfDRmpIBh3BuKz
	 T75n4P7avQDUBV6qRc/JI7A4gWEImB5LyyOg5NYZVPJcSHz/3TrhjJCXUMT4/xVqqj
	 MaOzkvirFFerUxwZAIUsTwmHuZznPxhDqPEX+28NcyL/Vo1MUrprDIn/0SrYxqM17v
	 mwUJAzxGniLlw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	peterz@infradead.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH RESEND v2 1/3] sched_ext: Don't kick CPUs running higher classes
Date: Wed, 22 Oct 2025 10:56:27 -1000
Message-ID: <20251022205629.845930-2-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251022205629.845930-1-tj@kernel.org>
References: <20251022205629.845930-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a sched_ext scheduler tries to kick a CPU, the CPU may be running a
higher class task. sched_ext has no control over such CPUs. A sched_ext
scheduler couldn't have expected to get access to the CPU after kicking it
anyway. Skip kicking when the target CPU is running a higher class.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index dc86ce0be32a..7db43a14a6fc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5122,18 +5122,23 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *pseqs)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct scx_rq *this_scx = &this_rq->scx;
+	const struct sched_class *cur_class;
 	bool should_wait = false;
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
+	cur_class = rq->curr->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
-	 * forward progress. Allow kicking self regardless of online state.
+	 * forward progress. Allow kicking self regardless of online state. If
+	 * @cpu is running a higher class task, we have no control over @cpu.
+	 * Skip kicking.
 	 */
-	if (cpu_online(cpu) || cpu == cpu_of(this_rq)) {
+	if ((cpu_online(cpu) || cpu == cpu_of(this_rq)) &&
+	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
-			if (rq->curr->sched_class == &ext_sched_class)
+			if (cur_class == &ext_sched_class)
 				rq->curr->scx.slice = 0;
 			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
 		}
-- 
2.47.1

