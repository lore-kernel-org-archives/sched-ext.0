Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA2477E31;
	Fri, 14 Aug 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729918; cv=none; b=qMIppmQCe+Un+Spc//JkDuuExo71+czn3ZuHYrdCpRiD+0aEABmzoIjXwl5BQO+w86hRFypNHumsJywpKW3hNGfo6zIcefxVWVYpmOaiX0jrVQHXNlMvjqaoM7FE3hLd4SdXx9ODt9B9fEmSczFeEa8tFT3V9VapAnPBknlPYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729918; c=relaxed/simple;
	bh=Jd0ZoJXhYHTGPPmduiZ4OOU95m3x5mMoxNe/Uy9p8h8=;
	h=Message-ID:From:To:Cc:Subject:Date; b=FyjjvgPu6524e/eXhls6o06IA7/wyULV0NaKBLPBlDv7I5YZhpL8sfxGww0opuuID1PY4X5ro98fC6YP5ZribN3+Dd59hFxKMbb0/akqQT+etJNOVU5a35WGCG75CLZnbbvLkvoIAhYTR0aCOOdV9uh0IhqwYsua7dUByoTPFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOWKBvI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOWKBvI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C8E1F000E9;
	Fri, 14 Aug 2026 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729916;
	bh=4HrB8yZ7zOHtxZ0nizgshdALX5+FucNEVtcGoXnFp4o=;
	h=From:To:Cc:Subject:Date;
	b=MOWKBvI/sVIMP4ODqz9JYD7a5t7zkWRZw4EBBWh6KW8/R5Dse0D/otXiEGQnmaLFj
	 5HBherbu2dkv55pZwgEmiNYQsi85VURF5u8WZTtyfautfTl0fIydo+ePoIIlGWhPLc
	 bkfkyQYVxTxXjSlX7fNk2+Ju3ytrTkom/WzCua4sba8yBaySPCMr6h2cpHSdOqeRal
	 sHWP67haWeZdRD9x1EGqhA8IdIKazJLv8oRhXwugZjjJ7bJvo0lTs45kkiGp8q1UH7
	 n2+eGyMU1CnGQKqoLCDKwkO2+8dUsi2wlIKt/sLSwKoZkmtc6Z7KL7JKhir/rEVeIq
	 wbQlTFM4TvyYg==
Message-ID: <874500f5212b5d192092950ea8d284b8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: David Carlier <devnexen@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.3] sched_ext: Set up ops.sub_ecaps_updated()
 dispatch context on the executing CPU
Date: Fri, 14 Aug 2026 07:46:46 -1000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_process_sync_ecaps() sets up the dispatch context for
ops.sub_ecaps_updated() in the target cpu's pcpu context recovered from the
llist node. However, the context is per executing cpu: the dispatch kfuncs
resolve it with this_cpu_ptr() and the dispatch buffer lives in it. What the
dispatches target is determined by the rq recorded in the context, not by
which cpu's context it is. Under core scheduling the pick runs balance_one()
for sibling rqs, so a sync processed for a sibling invokes the op with the
executing cpu's context not set up and its dispatch kfuncs misoperate on a
NULL or stale rq.

Set up the executing cpu's dsp_ctx instead, matching scx_dispatch_sched().
The recorded rq keeps the dispatches targeting the synced cpu.

Fixes: b81a6c018cde ("sched_ext: Add sub_ecaps_updated() effective-cap change notifier")
Reported-by: David Carlier <devnexen@gmail.com>
Link: https://lore.kernel.org/all/20260813045931.8691-1-devnexen@gmail.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/sub.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1017,11 +1017,15 @@ void scx_process_sync_ecaps(struct rq *r
 		 * invocation is equivalent to the dispatch path and may drop
 		 * and re-acquire the rq lock temporarily while the rest of
 		 * @batch is held privately, see scx_discard_ecaps_to_sync().
+		 * The dispatch kfuncs resolve their context on the executing
+		 * cpu, which under core scheduling can differ from @rq's cpu,
+		 * so the context is set up there. The rq recorded in it keeps
+		 * the dispatches targeting @rq.
 		 */
 		if (ecaps != pcpu->reported_ecaps &&
 		    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) &&
 		    !scx_bypassing(pcpu->sch, cpu)) {
-			struct scx_dsp_ctx *dspc = &pcpu->dsp_ctx;
+			struct scx_dsp_ctx *dspc = &this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;
 
 			dspc->rq = rq;
 			/* stash @prev so nested dispatches can access it */

-- 
2.55.0
