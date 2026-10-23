Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792786001;
	b=P4QOaNGH0/fHQPatv1FCP+jZVEdOrb2RWkddQjtkEtt72cnMjSRIOsHx0mf62d2KEH+I
	 +S/o+U3QpXiPfZHvffu2oeiVR/5n29HW2EKI4REVM4VC23Y7f/YbdBHK33Xv5y3yxW5SO
	 tWw2UDJOkPtcn4PDqDOvPbyMQwBtary5g891wGEbYCRJ1vNiO3ZyKW2NGJBPFRmej2hUs
	 hJYVfoFdsYt2uylLndhes+yfNB2JhdBw2Z0Q4ssM9jfGIyljqsx+X5CrQZEgQjE7GPvnb
	 89r2nOwpMHPYms5zMaHwetrhL0nwF2RlwbsYYL69XggFPQxZo+aiKKfkJsjxz+v2jNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786001;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JfHAwnpgWVWiUOZzQpJe7RI0KYVwO1R7KV/LtNs7c4M=;
	b=sEmxySrXm5URtDAiIRTtnyA0elor/MMKg0lmtCbdEdDL/vdSxmMc3Rkq0o9ivhKGykRP
	 CJ1Hai/o07OFO3V8UZSrX+5Gjxrr8j0LQbrw6Fcq5jn66/zuSD5at7/ry0izxjc2auZUB
	 yA5DQ9oGMbOUn+mhiVKznHxhf7on6R2oZMshmextYEM1haJfvgW5CWuF/vnzC5Ul1FQne
	 +IwOvx4hwiowHXpbPy++N11tfLK+lKLOCWkeQS7MTQHshiydvqi+v5BYP3yoU/r/61XVs
	 Nu/3M47SOA/m3i6UifEAgeIpIm0nBuF9NLbq7HwGlTgl22OjCn/mH9zyEYDXodQPXuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMJhGTh5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6C606A31B;
	Fri, 23 Oct 2026 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMJhGTh5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4771F01825;
	Fri, 23 Oct 2026 20:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792786000;
	bh=JfHAwnpgWVWiUOZzQpJe7RI0KYVwO1R7KV/LtNs7c4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LMJhGTh5YgA4ABT99IIuEqqm3njpjAQhdHT2ZhD+Yzkat00V4HVVGccUV05k+6D1D
	 1zEONlKsGNrTLuj0St+gIhoRsvn4o61Six4/tgZaxgXHk7T5f4fv9AsbIYad7kLrfo
	 rRAviz6E8l856tfOX35e51ZeJI46EiGZLwtQq5qngbcYEiNl5qKnDWZWR4TT07jVGN
	 4/Es+bM4VYi4BoyqhfXGMiemxDiilezQeFN1fl87yT7odLMdzdsvkYXUKpIZC5vQt5
	 aFGPbfvlJP6W8sr58hLT1VAW0B8aJf8LnZfwCacsin5zf9Z8rbo7hALI37938sF3ms
	 JTMzJ1hu9Wg8w==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 18/17] sched_ext: Fix use-after-free of a NONE rescuee leaving sched_ext
Date: Fri, 23 Oct 2026 10:06:39 -1000
Message-ID: <20261023200640.272834-1-tj@kernel.org>
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

An earlier patch, "sched_ext: Fix bypassed tasks stalling when the host
lacks SCX_CAP_BASE", sends a bypassed task to rescue when its host lacks
BASE on the cpu. That reaches a task scx_fail_parent() punted to its
bypassing parent at NONE, so such a task can be a rescuee.

switched_from_scx() returned early for a NONE task and skipped the slice end
scx_disable_task() does for the other states. A NONE rescuee leaving
sched_ext while running, through a setscheduler or a priority boost with
slice left, left rq->scx.rescue.curr pointing at it, a use-after-free once
the task exits.

End the slice for a NONE task there, which ends the rescue with it.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index a274210007fa..8241cf374ef9 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4960,16 +4960,15 @@ static void switched_from_scx(struct rq *rq, struct task_struct *p)
 		return;
 
 	/*
-	 * %NONE means SCX is no longer tracking @p at the task level (e.g.
-	 * scx_fail_parent() handed @p back to the parent at NONE pending the
-	 * parent's own teardown). There is nothing to disable; calling
-	 * scx_disable_task() would WARN on the non-%ENABLED state and trigger a
-	 * NONE -> READY validation failure.
+	 * A %NONE task, one scx_fail_parent() punted to its bypassing parent,
+	 * has nothing to disable and scx_disable_task() would WARN on it. It
+	 * can still be a rescuee under the parent, so end its slice here as
+	 * scx_disable_task() does for the other states.
 	 */
 	if (scx_get_task_state(p) == SCX_TASK_NONE)
-		return;
-
-	scx_disable_task(scx_task_sched(p), p);
+		scx_task_slice_ended(rq, p);
+	else
+		scx_disable_task(scx_task_sched(p), p);
 }
 
 static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
-- 
2.56.0

