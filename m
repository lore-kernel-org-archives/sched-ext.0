Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778175;
	b=ZtaEbCU0+DesyZbs8aPfK1eMm6W08/v5cdn8PchRNeHnAlzgxvISFk6g+Yk7YBS5XwyN
	 r9poBygSPCnYR/tF77HEZ4w1TUihbtR7x84WB0cFRElrLw7/5+iyEKt4cQ5Qbf0Ej81Gx
	 bOBdQHkKf67TmoYBq80ZzZKYJLDXOkzNCHYnNSspYAdt1vAy72qozSi2suCwsB25AcOeK
	 B4c4PRLsoilVKL1oDF03lP1blHD/7Ql+VBCi93RaR2RgQa4Ag8tNad39abc0rrLzh5y8b
	 qIWbd4Nz2Oad/WyX8ggYVe5HwnD9+8oquXqnQtAIsP8dz6ku37UCVIOhI/rXeDwpe+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778175;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5SebbWsFTPB6BGneiLq2cGTjMs8+5KTLeKU3LnOoUsg=;
	b=BvnHgT2DWfA3MH4q12B5KnYu7JiIWKrHlZt9XqmQ1XIT4GZxV6hg2oiXxiKicyJ2rVTQ
	 7OpWtiikXMyDqV0AcbMln7Wy8b53KV5veBlYMWuD1Iy+JcLpCFXL5WbUYvLoMSp+ACBXS
	 XD6QONiAuX2bGfUWfGGWlW7xVcAmprVgopKaLKdii2eyJfMXkcgt+nL7s4u16aQnqyGJm
	 isqtGgVpYgjIqpT8li3SyIgCNSRDenLQzkrQanB3eo+vw6y5FauhBTFl+Jk9f5sqK6d87
	 3HWuDrNoKfvxZCmRLPfNQ5Z72ZBZLihHANlKeX6D0kdDcrlRrHJ6q3RndS3Y5kdrUsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFdqVimm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36FB606A33D;
	Fri, 23 Oct 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFdqVimm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731DB1F031E1;
	Fri, 23 Oct 2026 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778174;
	bh=5SebbWsFTPB6BGneiLq2cGTjMs8+5KTLeKU3LnOoUsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kFdqVimm3iZ2tzsPBfNVBnEcE89iXgVYJCduCTrWNE/uqXGxcoVxvBL3ApAk7lJip
	 V98scLaWfc5xeIxdstRWwF69hY4R6K9VjqHw2j7nzx6Ot/Ry6o7ZxvUWULDuBCNEIS
	 fR6RqRpIgQzNQ4kztGk9AOEGermLGaeCz9jkpQIU54oOLPy6XKqDYhhTvyO3BeCoVS
	 NHiuEjLr/9m8MO94ZgWTXlpvTC5FlhmQvQlhxMgtYufIZq4VkwJjWozyWOjV2n8zt2
	 XLsiSlwmhwI4RVB6r6O98Lbd4Re5inQhEjzhq9rO5Mi21drAGLPpoL4vVsGaECpGaw
	 /gu/8lbO7MXeQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/17] sched_ext: Move refill_task_slice_dfl() below apply_slice_vtime()
Date: Fri, 23 Oct 2026 07:55:56 -1000
Message-ID: <20261023175608.4120910-6-tj@kernel.org>
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

Move refill_task_slice_dfl() below apply_slice_vtime(), with the other slice
writers, to prepare for the kernel-slice handling the following patches add
to them. No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 2e172d8d4572..70bc76ed4aa0 100644
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

