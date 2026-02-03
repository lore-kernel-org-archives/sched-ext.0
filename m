Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDEB31A04F;
	Tue,  3 Feb 2026 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136911; cv=none; b=BRJX6Z0R8vZTweKXy02+WWcc6fU7VpMimxSyFnAREVTnP1eW14LGRcuFgxyfo3BbPlDNfI0a7B8D4NfQ0EDwFlZNYS2HUJ8C36Nva3kfvuE8PtjHbh3DG6IRu5VgWCYe2T8Pm5e09g44SNGOjcyxboznvRPWfiyOv/e9fAVP4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136911; c=relaxed/simple;
	bh=650tpKhbrCYNqqDKiKmSdQC3vu5lDsBTOkL7eQrY950=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=CFQQSW8U3j40ea+TztSfnEp2GYadp7uqcr+v3lb6eqNzzAstCHnIumvKC3FVGpVu3j8oLO42avmBJ0QUJdr9L3qtHtZ6OuFqmzjH57UykGFuBbGjruywANky63prvEGkkgwVQxBS9I/OT6xIIAa3h8D9RZ9+lOyeJ7WcWHUWHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t/lwlHOo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t/lwlHOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B534C116D0;
	Tue,  3 Feb 2026 16:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770136911;
	bh=650tpKhbrCYNqqDKiKmSdQC3vu5lDsBTOkL7eQrY950=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=t/lwlHOoumFFgYKEnpBn/STqmG6HhqbLeCg7ME/GWrwHmaFxiUjK5yfQQLEBhliQE
	 /AkVJTCcDYrQdCgelJ/p+tGThGt2jyYPW6AxRBXoeIHm4X0dGVQEH585evVaeIB9GY
	 3piqFOuaEswlYDtDb0IMJgGw5lUCogS8PtKPEJyI=
Subject: Patch "sched_ext: Don't kick CPUs running higher classes" has been added to the 6.18-stable tree
To: arighi@nvidia.com,christian.loehle@arm.com,gregkh@linuxfoundation.org,sched-ext@lists.linux.dev,tj@kernel.org,void@manifault.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 17:41:49 +0100
In-Reply-To: <20260129092546.49128-2-christian.loehle@arm.com>
Message-ID: <2026020349-rebound-lyricist-de5e@gregkh>
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

    sched_ext: Don't kick CPUs running higher classes

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     sched_ext-don-t-kick-cpus-running-higher-classes.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-212753-greg=kroah.com@vger.kernel.org Thu Jan 29 10:26:03 2026
From: Christian Loehle <christian.loehle@arm.com>
Date: Thu, 29 Jan 2026 09:25:45 +0000
Subject: sched_ext: Don't kick CPUs running higher classes
To: stable@vger.kernel.org, tj@kernel.org
Cc: arighi@nvidia.com, void@manifault.com, sched-ext@lists.linux.dev, Christian Loehle <christian.loehle@arm.com>
Message-ID: <20260129092546.49128-2-christian.loehle@arm.com>

From: Tejun Heo <tj@kernel.org>

commit a9c1fbbd6dadbaa38c157a07d5d11005460b86b9 upstream.

When a sched_ext scheduler tries to kick a CPU, the CPU may be running a
higher class task. sched_ext has no control over such CPUs. A sched_ext
scheduler couldn't have expected to get access to the CPU after kicking it
anyway. Skip kicking when the target CPU is running a higher class.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5164,18 +5164,23 @@ static bool kick_one_cpu(s32 cpu, struct
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


Patches currently in stable-queue which might be from christian.loehle@arm.com are

queue-6.18/sched_ext-don-t-kick-cpus-running-higher-classes.patch
queue-6.18/sched_ext-fix-scx_kick_wait-to-work-reliably.patch
