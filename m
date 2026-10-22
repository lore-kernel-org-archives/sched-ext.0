Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705122;
	b=Ux/w7U/e/J3l+J0bUZ73m1IjsUAolQ0l4b4kb2luh6hIV6nK1B3LYNXWVse2JMnbVBQl
	 sq9/HyygPQuNrUF5JtwYge4K5DbMa/A5d/k0L/jM0/9X/apVR6vXdZOtlKBUBYk9Sf+OO
	 qqF96HKuMvRxJBAzWU5x6Cq71bSHm/jV/VDEa+M9kF1mYM95cLTgjlGvA+Qo8hA5DaQE0
	 ZSQYCdmOiGcP6U7dOplqHZEnNAk+vZy5v8wZoAiYJNOfFiW0Ubh17VxLI3j3Rxa+0582a
	 pKlNmF/UcZo70hYba0eOEAqiFFvhf1oTc2DRb+OmdB/jkMWj9nObwabDx1JEmCJwpTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705122;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B47NRnnUZ7eSTS6cdrCNTsuvUnjumFm4UCpKV/5PjLI=;
	b=suR/Q5J+e8ZqjVuywmNWG8oL3abRMADAIqtfRjhPYjl6LgYba175pSsDcR6gSIuOwbKA
	 ix2qJhwLYYr/sWMEfVP6jbrfU5l8m3CtnC3F/Fh/rC4NX6ST+JPrqN56MgPmyMG50Otyk
	 5ehnqx0SFqPt1fW7ox+dwhmjz6O25RYD3T6FSs2iZoS85szkMa3TTbc7Qm1hCs+7He32a
	 WwHEsN/7unGjv37SW1sFEeSZzkxEoT6d/URoNHvNPiztClH/EemBRZbOL+eoBl3h5cXNU
	 yZ7KrHGYuPmp1x+O0jmj/GkCBAQLg5BibWwfVSNSMNn/KfMebYMVczpf9FS0qAwJ6Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMTElcQi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2016606A31A;
	Thu, 22 Oct 2026 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMTElcQi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBA01F031E4;
	Thu, 22 Oct 2026 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705121;
	bh=B47NRnnUZ7eSTS6cdrCNTsuvUnjumFm4UCpKV/5PjLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aMTElcQifHWyydRTNiy/D7EJOMajWtHDTCMbZuL4TS+V00a5owjaAy6Vq9nIBfxTN
	 R+eH39CqWMT17bXPzsBPRA0Mni2FWJzSDvVt2/TRljk8Y2jOXD8vHepPl3h040hTCB
	 QMy3sdGC5f5xvkulCZDPy/Y+RlgIuM6rZPtdKaqNcKi9ZYxQDHS/3M/Jcrvx7Fpt7d
	 naZaQJOYwqd/mgd4BGiNaDeK0Fsj/6cHN6RKAF6ry+RUcXrdAV/zN+k7V5R+iWCp93
	 lHeSQRnljjxtn+HT7yK/3rzSMtpOwwzSAMfGRRmUccc8eYnlebLImVIJdzTVfaaLgS
	 I7nbhWFeXhkoQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/14] sched_ext: Move refill_task_slice_dfl() below apply_slice_vtime()
Date: Thu, 22 Oct 2026 11:38:26 -1000
Message-ID: <20261022213836.2259069-5-tj@kernel.org>
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

Move refill_task_slice_dfl() below apply_slice_vtime(), with the other slice
writers, to prepare for the kernel-slice handling the following patches add
to them. No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index bb36264e626f..065ecdf3e3bf 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1538,6 +1538,16 @@ static void apply_slice_vtime(struct task_struct *p, u64 slice, u64 vtime, u64 e
 		p->scx.dsq_vtime = vtime;
 }
 
+static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
+{
+	/*
+	 * A default refill is not an explicit request, so it must not drop a
+	 * pending out-of-band one, which is applied when @p next runs.
+	 */
+	set_task_slice_keep_oob(p, READ_ONCE(sch->slice_dfl));
+	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
+}
+
 static void update_curr_scx(struct rq *rq)
 {
 	struct task_struct *donor;
@@ -1631,16 +1641,6 @@ static void dsq_dec_nr(struct scx_dispatch_q *dsq, struct task_struct *p)
 	}
 }
 
-static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
-{
-	/*
-	 * A default refill is not an explicit request, so it must not drop a
-	 * pending out-of-band one, which is applied when @p next runs.
-	 */
-	set_task_slice_keep_oob(p, READ_ONCE(sch->slice_dfl));
-	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
-}
-
 /*
  * Return true if @p is moving due to an internal SCX migration, false
  * otherwise.
-- 
2.56.0

