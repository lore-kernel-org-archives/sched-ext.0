Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A273B3BFA;
	Wed, 24 Jun 2026 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340644; cv=none; b=m9Z+ndKw5Bxd2tgB+M+jmay+gsoULRBbF4R62a93daLgW4PmfOxrCT42pSyc2M3/aV+g33zDneX6HhaZ6YLqguMfbGZHflH7tko8Bf84Tzw5oH/LSi6MODSOlbP0xVr07qS61eeop/RJfv2RTEOwCRFks4l84CrrqGgROmKqgPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340644; c=relaxed/simple;
	bh=JQARnBGNXGToOEKmKfoc2YLDeowBttaCfPamU7HXxVU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=stJTRoox4uLl24KfKtlZ+nIr7feBmBL6t7Mbd4lqa2fV5o830ttTyVD5f7qtadHDLBKl3/nvoizRCZDdEk1wOeYguuHaowfIm6MJOF3gbD7+eFPyRQi0fSKPcRJIPi2g4lILJX83X0gVhjV1A6Bqy8C+EM5m4d7Ow1e8C1hKdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrVy2iSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrVy2iSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103951F000E9;
	Wed, 24 Jun 2026 22:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782340643;
	bh=+KIXj+YKoUGzD+MmL54as8PGDGXbL5wfYO3fWVSzqQI=;
	h=Date:From:To:Cc:Subject;
	b=TrVy2iSZPY+TYKOwjS4S3dvIodl5tLoyAyY0D+m50BS7kIHo1qzcaErhzux6nP1iV
	 NgDbCoclBaAGjHfSZK6qo4tU8TF3nV8ZeLhMjnjyrpBYbKo7XTRXCr6tYagn+IP7Dy
	 eMGK/Eb/BWwX6Bo9pAy2wS5vdRcFotT/nMhckibmRm7zcdjaQPdTxK7t7gGlb3mNJp
	 rGSBkow2a2G2I6MOj4Ud+DJEVJTG/vUXaZFdSgvlXkJi3yvtWz49oFuQBtLXGcJnuc
	 fabreub9YJEkR66vPd3Jd5S6+eqCosGk7inRJ/oeTWvcbLsOIg+2aDPCDAnlU+rW1q
	 9UI7/8xfR1dDw==
Date: Wed, 24 Jun 2026 12:37:22 -1000
Message-ID: <b5ba1ed0bcc9d72988f6606d39753c8f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.2-fixes] sched_ext: Annotate ksyncs with
 __rcu in alloc/free_kick_syncs()
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_kick_syncs is a per-CPU __rcu pointer, so per_cpu_ptr() returns struct
scx_kick_syncs __rcu **. alloc_kick_syncs() and free_kick_syncs() stored it
in a plain struct scx_kick_syncs **ksyncs, which sparse flags as an __rcu
address-space mismatch. Annotate ksyncs to match. Its accesses already go
through rcu_*_pointer().

Fixes: 987e00035c0e ("sched_ext: Rename pnt_seq to kick_sync")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606122315.pbnDHP0n-lkp@intel.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e353204b4ca2..9c9cb9d08bca 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5730,7 +5730,7 @@ static void free_kick_syncs(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		struct scx_kick_syncs **ksyncs = per_cpu_ptr(&scx_kick_syncs, cpu);
+		struct scx_kick_syncs __rcu **ksyncs = per_cpu_ptr(&scx_kick_syncs, cpu);
 		struct scx_kick_syncs *to_free;
 
 		to_free = rcu_replace_pointer(*ksyncs, NULL, true);
@@ -6720,7 +6720,7 @@ static int alloc_kick_syncs(void)
 	 * can exceed percpu allocator limits on large machines.
 	 */
 	for_each_possible_cpu(cpu) {
-		struct scx_kick_syncs **ksyncs = per_cpu_ptr(&scx_kick_syncs, cpu);
+		struct scx_kick_syncs __rcu **ksyncs = per_cpu_ptr(&scx_kick_syncs, cpu);
 		struct scx_kick_syncs *new_ksyncs;
 
 		WARN_ON_ONCE(rcu_access_pointer(*ksyncs));
