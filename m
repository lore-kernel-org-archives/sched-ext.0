Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017637DAC2;
	Fri,  7 Aug 2026 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136544; cv=none; b=gC+8NQuZPIGsxHluHs22MkKhYVoOtLQ/NAynQGnaDd4Shk4DFESntDofrZ0mV14VBcTZI+206DIMDtsDkzYa8rFOcisr42GHElqAtHBwC940Ex7xCZTrNE5LXI9C0JSqEzxKfW8KLVoBMBEap0pQaHpZKueGi+8CrR67G2Ob0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136544; c=relaxed/simple;
	bh=T0vYDodMThkSWZL1vSofZVUWtXP1YmxfOnY6IjkaQvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HzUnopUO7Fqr6U0GJtt0UfzzehNagnszKEYkbOK5qIqBzsaBeV8ow9Iidqo3Tx4r272eFJKtdncmOwR+ZllPOkN4OVfV7HIOEDxuM0SgaG9KhatFzr9eV0QIMiTJB8IZw1c1ylWEXs+lV+wbpb9g3r1nkK3n+uIvIIEpzhGbRY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHAahZaA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHAahZaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FB41F000E9;
	Fri,  7 Aug 2026 21:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786136542;
	bh=2LwQlWWffhdkaRbn6Tk/e/3e0fOAY9QNWVpR9N/j3iw=;
	h=From:To:Cc:Subject:Date;
	b=HHAahZaAAP5rphsLlhdqE9wowOkumiLAsWsH9jk5zGv1BXgOmI68u/vVCcpuO6q9c
	 vUnocPiwe4p/73mPhszWyOXmvlDFo6qfRQ4b071Ln9fSCdbH4mVwzIgLDiUArAZAlp
	 n42l4gSUHntgfp1LSmT7Mu4kUG/0Yiz5YUjO0dqERB3wKNql9sHGVO1s2NWUhGRWl3
	 NaJoWeAVCo5G9pF5D9XySITe0kjuyoCDokIlGk1d+nkTdvmUzESh6ragPra+Kq66XT
	 IgXD4jrmcXATKkG5jhdj3eKLPz4eZr1ttTUGjsnRgOOQVhYaIujck624QifFdO3ywq
	 +k5OmWAiY+K+Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Peter Zijlstra <peterz@infradead.org>,
	ElXreno <elxreno@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.2-fixes] sched_ext: Fix core scheduling
Date: Fri,  7 Aug 2026 11:02:15 -1000
Message-ID: <20260807210221.232543-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

sched_ext's core scheduling support has been broken since 4c95380701f5
("sched/ext: Fold balance_scx() into pick_task_scx()") made dispatch run
from inside ->pick_task(). Dispatching can release the rq lock, which lets
core-wide selections on the same core interleave and corrupt each other's
state - crashing on a cleared rq->core_pick or leaving a dequeued task
running, which wedges the machine:

  https://github.com/sched-ext/scx/issues/3715

The main fix (0006) makes the core-sched pick return RETRY_TASK whenever
its dispatch released the rq lock, so that a selection only ever commits
picks made under a continuously held lock. The preceding patches update
the core-sched pick to handle lock-dropping picks (0001-0002) and fix
adjacent breakages from the same fold that core scheduling support needs
(0003-0005).

 0001-sched-core-Handle-pick_task-releasing-the-rq-lock.patch
 0002-sched-core-Make-core-sched-flips-wait-for-in-flight-.patch
 0003-sched_ext-Replace-SCX_RQ_BAL_KEEP-with-a-dispatch-ve.patch
 0004-sched_ext-Fix-this_rq-assumptions-in-dispatch-kfuncs.patch
 0005-sched_ext-Count-rq-lock-releases-in-rq-scx.lock_drop.patch
 0006-sched_ext-Fix-rq-core_pick-corruption-under-core-sch.patch

Based on sched_ext/for-7.2-fixes (d4a00d61a5c2). The patchset is also
available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git coresched-fixes

diffstat follows.

 kernel/sched/core.c    |  49 ++++++--
 kernel/sched/ext/ext.c | 302 +++++++++++++++++++++++++++++++++++--------------
 kernel/sched/sched.h   |   5 +-
 3 files changed, 265 insertions(+), 91 deletions(-)

-- 
tejun
