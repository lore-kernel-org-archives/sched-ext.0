Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792786002;
	b=rd5iOIcIZUkBCz/78GhNLw7MNAJwDbVsdzttYWLvYlsYw/TZ58ys5amRffuxyj1W5hRu
	 5qIbG6i7Gj16YR2Dgg9OgFj3u7ElPu5Mh5s7o2xKeRzoOQchsUW68ehfrudFi8Cie+gBM
	 /WidfGGmFfbS6zcMbUHp8gkyG72jzMSlcGJ/H1Y+A+HLJuK+ktHMD5/LtoLhSQATwAwj/
	 9f6TdxU8IGn/vnzEOL9pPuDbzANMD398orLvO0tmZADc46AOCdPO3fifhknES4pWiEmow
	 hwHhdSjOFaYCJJcXRHOBfXOtVC2Dx4njFbzdpKjUShwuBx3MNCTFYjsZyqz7V1tddaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786002;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KzE594nfMjUKdeigS5Mayjg/DC2n6awxLJ38E+chQkc=;
	b=aL8u76yft7h05y9zGC41UAS449LndlV8e7nQ2pw6H46chsfQgk0GuVGtayDoeva9St0L
	 hUQitBNd62nh/AuNRgSDJ/eSkhpVQMV8CveivKLMQj6jaqOxaM3dOzpriEj976/sOmOPk
	 vBIuSKQwBwCzN303fODjCebSeZj49dd6jFhbn5mMoBsk7kh9tQ+RXI7sIcdziAHnLF0g2
	 0XzNF62TOPlxYq5EYm56ckrA8KQVERaKAYgph8JTQ/f+Z4eCQ7MRM5UTBbe/jpTe6hatx
	 Iy0j1TLjbAniDT8zAN7qjitwsHZk6ivEJg9fyaArupTUPshjCDpsJ2xuaP705Ri/KMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCAkNbWU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67829606A320;
	Fri, 23 Oct 2026 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCAkNbWU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14441F01825;
	Fri, 23 Oct 2026 20:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792786002;
	bh=KzE594nfMjUKdeigS5Mayjg/DC2n6awxLJ38E+chQkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QCAkNbWUi12QorlqPqGItCql2jpoeewOUGIXdyBukbsV3KtP/8MuAWS6dvBs0ivwD
	 iYB+btv5HGuW+CFzLRpdJgv8081HH2F8aN5WlS8uGRdCRd+/wDf+d0qxlRig8DU1VT
	 HWR8tAURfmSUkqr724rXfx/tzn3ukNWbSAc6SH43qwbvCw3m0mzW0/YpS81kn8SL4d
	 MY+vBGGMxFnhglypK3j+dyOs5lKAyRR+dM7ufTerI94SncJQ/1eHM8I5yE3TxRrLjY
	 PnS3nGjC70ziStr7hYzCD1IEDjjpnCTtqrDq1uLZtR5VXLh/n/dDCykanEpQLsqoUd
	 KBvrSWzNaoR3g==
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
Subject: [PATCH 19/17] sched_ext: Fix the stall watchdog blaming a bypassing owner for a stuck task
Date: Fri, 23 Oct 2026 10:06:40 -1000
Message-ID: <20261023200640.272834-2-tj@kernel.org>
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

check_rq_for_timeouts() blames a stall on the scheduler whose DSQ the task
sits on, and on the task's owner when the DSQ has none. A bypassed task can
sit on the rescue DSQ or the local DSQ, and the blame then lands on its
owner. The owner is bypassing and places nothing. The host, the nearest
ancestor that is not bypassing, runs the bypassed tasks.

That matters when the owner is already exiting, during its own disable for
one. __scx_exit() on it is a no-op, the watchdog still ends its pass, and
nothing is ejected. If the host is not running the bypassed tasks, the
owner's disable, which waits on them, may never finish.

Blame the host for a stuck task whose owner is bypassing. Ejecting the host
re-hosts the bypassed subtree one level up. A task whose owner is not
bypassing keeps the blame on the owner, and with every ancestor bypassing,
scx_exec_sched() gives the root. A task on the host's bypass DSQ already led
to the host through dsq->sched.

The rescue overload accounting keeps charging the owner. Overload going
unanswered while the owner exits is acceptable.

Fixes: 2c91169377f4 ("sched_ext: Blame the DSQ's owning scheduler for a runnable stall")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 8241cf374ef9..ae5e8861ca0a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4376,9 +4376,16 @@ static bool check_rq_for_timeouts(struct rq *rq)
 			 * ancestor's bypass DSQ while the owner is bypassing.
 			 * Blame the drainer. The local DSQ is consumed by the
 			 * cpu itself and keeps blame on the owner.
+			 *
+			 * A bypassing owner places nothing, and its tasks run
+			 * through the host even from the rescue DSQ or the
+			 * local DSQ. Blame the host. Blaming an owner that is
+			 * already exiting would eject nothing.
 			 */
 			if (dsq && dsq->sched && dsq->id != SCX_DSQ_LOCAL)
 				sch = dsq->sched;
+			else if (scx_bypassing(sch, cpu_of(rq)))
+				sch = scx_exec_sched(sch, cpu_of(rq));
 
 			__scx_exit(sch, SCX_EXIT_ERROR_STALL, 0, cpu_of(rq),
 				   "%s[%d] failed to run for %u.%03us",
-- 
2.56.0

