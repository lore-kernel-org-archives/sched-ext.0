Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD94B7162;
	Sat,  5 Sep 2026 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788624614; cv=none; b=B0DljkqEdOVsD5BZC5LEnN37Qr61/Ypv9pUUBD9CqIww+N/sr+I48QrAuc2zR7CtxpQ7HlD9tZFSrewSHrpEkBTXO7WkZKWFyFB6tk24VOSQ2ip9hK4fQxf/EsFETGqH05l2o8qA4wkR8MnNljnWlZMnxhhi4dtAcIWzj4AiAPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788624614; c=relaxed/simple;
	bh=GdAmVa7iE3KuZq0pnaElyxTH7QjB87W+q+Kezd277Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV6vDWTq8v0xNUw5nIYN/pujjT7rhthNx8ZXqHtIo5kjFKruDoRFcdlwkGblLGCBaPujgIfLgUDR0r1wyqY8Hpg1PeWyyQHwQ05CHDNQ7I3MBICQXjv87pUF/UCHSqiT1p/i6J29qs9TLsYrcQ1ZTptPA/ddnBGkLBERzcmRvq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlMMRr9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlMMRr9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13FA1F00A3F;
	Sat,  5 Sep 2026 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788624602;
	bh=a8kzCCf3LkqxothS93JW9562gM6FSJ7HR30H0CavaFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QlMMRr9DygkCsTl/8C6xL4sfrRWPM2YoG8HMSlAxjvwq6i2wFmVqoRil8nlSmBgnR
	 4ZLOW5SBXDFXYuM+HjtljchiR6D6ugaxq5LmWyyPjO9UdO1P12WiA/IhRkEzsNMT3O
	 xWi7G7rbh+G7XkFgqOQnuRtGi0y7GVB18OXW9jVtI1X+4pPlIqojjhpWNHvzcf19EY
	 Kl5amb98sJmWevy1HN4t+pkpdEvLll4lVJKsc4bXuc52MOO85rW1ieBXuIH2pFsrxK
	 MW5aZBJXfCIRcSpnITZSYEbw5EywkJekO8cCz85AFSOuJxfHenayYiHWVNjBbvKgyC
	 Wj3iS9nfCe10Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3-fixes 3/4] sched_ext: scx_qmap: Do not add IMMED to rescue inserts
Date: Sat,  5 Sep 2026 06:09:57 -1000
Message-ID: <20260905160958.1565156-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905160958.1565156-1-tj@kernel.org>
References: <20260905160958.1565156-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qmap's stranded fallback forces a task that can run on none of its self cids
onto its first allowed cid with SCX_ENQ_RESCUE, and adds SCX_ENQ_IMMED when
that cid is a time-share it holds. On such a cid the insert stops being a
rescue request:

1. A task is enqueued while none of its allowed cids is in self_cids. At
   attach self_cids is still empty.
2. qmap inserts it into cid 0's local DSQ with SCX_ENQ_RESCUE |
   SCX_ENQ_IMMED.
3. The kernel finds ENQ_IMMED held on cid 0, admits the insert and skips the
   rescue diversion.
4. cid 0's cpu is busy, so the IMMED task is bounced back to qmap with
   SCX_ENQ_REENQ.
5. qmap's enqueue sees the same inputs and repeats step 2. Nothing runs in
   between.
6. The reenqueue limit ejects qmap with SCX_EXIT_ERROR_REENQ.

The caps granted during the parent's ops.sub_attach() are delivered after
the sub already holds its tasks, while the per-cid effective caps that mark
the time-shares are delivered from the first dispatch after bypass lifts, so
every attach that receives a time-share on a task's first allowed cid starts
the loop. Drop IMMED from the rescue inserts so that step 3 diverts to the
rescue path.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 9f6e61d7ca07..e4e51303bd29 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -358,8 +358,8 @@ s32 BPF_STRUCT_OPS(qmap_select_cid, struct task_struct *p,
 }
 
 /*
- * A received time-shared cid is held ENQ_IMMED-only, so inserts must set
- * SCX_ENQ_IMMED.
+ * A received time-shared cid is held ENQ_IMMED-only, so inserts meant to run
+ * there must set SCX_ENQ_IMMED.
  */
 static u64 needs_immed(s32 cid)
 {
@@ -444,9 +444,11 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 * didn't grant them or we delegated them to children - would starve in
 	 * SHARED/FIFO since we only pull from those on self cids.
 	 *
-	 * Force it onto its first allowed cid's local DSQ. If we hold that cid
-	 * it runs. Otherwise the insert carries SCX_ENQ_RESCUE and the kernel
-	 * diverts the task to its rescue path.
+	 * Force it onto its first allowed cid's local DSQ with SCX_ENQ_RESCUE.
+	 * If we hold ENQ on that cid it runs. Otherwise the kernel diverts the
+	 * task to its rescue path. IMMED would turn the insert into a legal
+	 * placement on a time-shared cid and the kernel would bounce it back
+	 * here instead of rescuing it.
 	 */
 	if (!cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {
 		s32 c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
@@ -455,7 +457,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 			taskc->force_local = false;
 			__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
 			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | c, slice_ns,
-					   enq_flags | needs_immed(c) | SCX_ENQ_RESCUE);
+					   enq_flags | SCX_ENQ_RESCUE);
 			return;
 		}
 	}
@@ -618,7 +620,7 @@ static bool scan_shared_dsq(bool from_timer)
 			if (c >= 0 && c < scx_bpf_nr_cids()) {
 				__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
 				scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | c,
-						 needs_immed(c) | SCX_ENQ_RESCUE);
+						 SCX_ENQ_RESCUE);
 			}
 			continue;
 		}
@@ -659,7 +661,7 @@ static bool scan_shared_dsq(bool from_timer)
 			if (c >= 0 && c < nr_cids) {
 				__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
 				scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | c,
-						 needs_immed(c) | SCX_ENQ_RESCUE);
+						 SCX_ENQ_RESCUE);
 			}
 			continue;
 		}
-- 
2.55.0

