Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733098;
	b=FkT331kBIQSXJDUAGwZeRjvcFnHC9NYJYrqNNIJZM1xMrL9AnQFS78VK4LTez07S6MGk
	 v6jpOn4xD9b01CqhuDWUw09LHWBMeXoeT6F4bSx0vM8BVWrZRxVvhBuCIRUFG017Yec02
	 drQWU01wbPU1NLq4QyrMdFxlyQw6KbmJU1xpW50AXngg2jAL+hTLZ3cCotOb/SsLEtCfg
	 8WdKB3Ud3jLP83iq+aZu3YbWfPt1b6W38ho4VcnoaHMRBFNnFX7AHX2oZOCOLJRfeGl99
	 3Ao54lDJ1R8GqdLz7qeazvv0QF0brRqM+xfzXiHQRVrZq91f+lF0MFSy97UenDpXgfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733098;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B47NRnnUZ7eSTS6cdrCNTsuvUnjumFm4UCpKV/5PjLI=;
	b=w01Yk0BuyR1FIyrMGldziUtNrGj+M2FOgZ0v88LwHxfogEbkeQ4gOt02kF2LmR4JNopk
	 YvYWrFp103iSykdZlrIhdlkWmqAkt8JOWBptHvyHwDfspZAV/jFSRZu/XO3MFjxCJoy8W
	 7auYFuKe7IVh97c3LWGi4q1x/RxitkZHP2W7hDe7F+lCjh92q9b28UlY8ZTWSG+JB4Vmt
	 HUfBWiMTytxLA2+B52gtWhb1ZXnBiNPmkHM8wr5RtsW9D4PhacNolsEwtajBEsrYQrGkw
	 il1RH18vIL6mbkEMHTuWqPAq2XGT72UHnG57lMM10nIyKsUV8wwyd1hgAyAvfowVO6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4fx4c2y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0DF606A330;
	Fri, 23 Oct 2026 05:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4fx4c2y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EB91F031E5;
	Fri, 23 Oct 2026 05:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792733097;
	bh=B47NRnnUZ7eSTS6cdrCNTsuvUnjumFm4UCpKV/5PjLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D4fx4c2yvJucp3/ZSL/1Lr3FIYZoyHSCGsZpM76oKSHKL29Bo3M/OnrceFa0rE7WI
	 SCeNa5jwlzqSWu3+b6gPk+Ealdjvmo7a2QBLBJnQGMvz7HITt6TPM8XlNg8eOM/fRn
	 M+ejb8Jl2gBSNL6paJYJ0vEGvYPGScKVaqPKwYrReCgpPQ79k2J0Nclungz9IfWyBR
	 vXHYUpBaYvzl4o0FW1UDsljPc2UEp0UqRsdCBBBi6gsQAvKOtFai2DxG1AzeutT557
	 gC+xGTy2S+J8YLFCCYQidmMHuvYZ4CORp/obABfRKrU8mj+QxGWmffst7L7aU6+0eC
	 6mMU0cOw7vqSQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/15] sched_ext: Move refill_task_slice_dfl() below apply_slice_vtime()
Date: Thu, 22 Oct 2026 19:24:41 -1000
Message-ID: <20261023052452.2889061-5-tj@kernel.org>
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

