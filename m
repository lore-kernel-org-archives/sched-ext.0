Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471F24CEEA;
	Mon, 17 Nov 2025 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393559; cv=none; b=n053JVWd4S6Ht3fYyow6JhP8TCo1gHycmG6d3TQcghcuuMdvzUKqCgdzPWA1rLRMNmA8vCtrHTwhkh+hciepqwiqapl2D4I6pKrCGavtzeDX7H1K+66Vw0CEQmAdqPTSPfCKzoSDTG8qVt8DR86+XqqkUBTMAJkube+Y0aNyImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393559; c=relaxed/simple;
	bh=8CwJwSDywImkBHpahgkxgs+ErUtTxJVJ6jzCnd52Er4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=pvdiOZL5/Z/Jr2mGcZJJy5kkjNo2avBBh+ai+nQhPHmkmX5wKoLtzU2d2R4CG2b9/4+clp30mT0/f/P4AqZHyyrnjqEEozJW0jAfeEb+i/4/Z5vrEMRg9X/Ze0o9Xk3J/wvp4hVPstp/ughIKDpxmEYrYBujs/Jrca5urTsYd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV/gCvGU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV/gCvGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA302C116B1;
	Mon, 17 Nov 2025 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763393558;
	bh=8CwJwSDywImkBHpahgkxgs+ErUtTxJVJ6jzCnd52Er4=;
	h=Date:From:To:Cc:Subject:From;
	b=CV/gCvGUrC8uDR8ZLZOfCIBho1Tbl7ghaqpWlkW+gylfWVtUt3HgXvgNi/w8679b2
	 maIhkG615QE4CEh71LDcGpUW4oPm+RvR5tYNdbSonaXmMHkBwSFWmufDAvFmBXVSNf
	 /4o/UM04LKEV5ep9Uag4ryqrKrqrf/fMOtDfdyGEmXfbU7FX++ni3YEgihKS6NVRMl
	 pIR6bnuSteTUU6aeb1YjxLRWYShbTLgkfcMZACJNUo3YFORDntRDw9hT/X0gV8Os6l
	 Z1fjcsymb4+Xk9zKihgTQmi1m2r3GAL3niYUVwzycevKYELQO7vaZvUZ9pVTAOiCks
	 tHv0fDC3ixfhA==
Date: Mon, 17 Nov 2025 05:32:37 -1000
Message-ID: <82773efeb786fdc3c392d9fbeedf336c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Subject: [GIT PULL] sched_ext fixes for v6.18-rc6
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi Linus,

The following changes since commit a3c4a0a42e61aad1056a3d33fd603c1ae66d4288:

  sched_ext: fix flag check for deferred callbacks (2025-10-16 08:34:00 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.18-rc6-fixes

for you to fetch changes up to 36c6f3c03d104faf1aa90922f2310549c175420f:

  sched_ext: Use IRQ_WORK_INIT_HARD() to initialize rq->scx.kick_cpus_irq_work (2025-11-17 05:07:22 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.18-rc6

Five fixes addressing PREEMPT_RT compatibility and locking issues. Three
commits fix potential deadlocks and sleeps in atomic contexts on RT kernels by
converting locks to raw spinlocks and ensuring IRQ work runs in hard-irq
context. The remaining two fix unsafe locking in the debug dump path and a
variable dereference typo.

----------------------------------------------------------------
Andrea Righi (1):
      sched_ext: Fix use of uninitialized variable in scx_bpf_cpuperf_set()

Emil Tsalapatis (1):
      sched/ext: convert scx_tasks_lock to raw spinlock

Zqiang (3):
      sched_ext: Fix unsafe locking in the scx_dump_state()
      sched_ext: Fix possible deadlock in the deferred_irq_workfn()
      sched_ext: Use IRQ_WORK_INIT_HARD() to initialize rq->scx.kick_cpus_irq_work

 kernel/sched/ext.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)
