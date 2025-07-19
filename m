Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6862642AA4;
	Sat, 19 Jul 2025 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752944577; cv=none; b=lCwT267xFNiAxL7dZ1vBcSKVVjUNRdQPHEIMb7YY0HZ9cW36s2Pkgrf42nc+57HY0U1ZSM2opsccVnwVbQ6jbnWWeUdNd8R8uAG86J9V0waJ7iD1sLufafegXkIOKLQa7MMIn6NIKFGEEVZCoMft27UcgUsgCfDJ4pFu8EvDag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752944577; c=relaxed/simple;
	bh=NxrKEo6TW3QpFyL4ZwiWJ9cTkhlJqK8L2nDZg37x57s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uNVVfnKEuir5+if4Gl47iTcUGqvTFnNQXnXa2ElAbnS3nPuz01Q7pHZp7jBgSSDgLaIi6lOBhOYnKOy1Y2xr/aUAHolhGugOJrzWfdirag0d4IABuG3x1dNumkNqoUUbY/Qt0KOYsUWSJuWROwpK5tM/0udjYapx5R3lw77Fb+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lznGnp/o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lznGnp/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C101EC4CEE3;
	Sat, 19 Jul 2025 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752944576;
	bh=NxrKEo6TW3QpFyL4ZwiWJ9cTkhlJqK8L2nDZg37x57s=;
	h=Date:From:To:Cc:Subject:From;
	b=lznGnp/oNO50dbJTV7ja5VKnkzMdO6dlcG1ddglomgpBlcOVIlQ90VLkXhztg33Sy
	 hvqZzzDehNrsBili0eMzIP0Yq36NrkJA1XNWoVrQ32wAcyGl+scToFy/deznpqWIiO
	 3xPxOm0kBdNe/rZLjHaTkxnwhbachdl30zGJPvwyCaEklA26I2TVMFnzijdXD7Axhm
	 vsb5FX56rH7tFzCgcPWgq4DD+Sz2oNAbvIvTTsNb6EcJkzyeIobvdUQJWGFZdYV3x0
	 OErqqp5lwuaq3Sjg0ULQKgNBDLtOSB2gByhiPRA0SSn52LsiBS/V1fxZJTAwR0cqSc
	 G7nReJa/brMfA==
Date: Sat, 19 Jul 2025 07:02:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [GIT PULL] sched_ext: Fixes for v6.16-rc6
Message-ID: <aHvPvsnPScZVpVAM@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 33796b91871ad4010c8188372dd1faf97cf0f1c0:

  sched_ext, sched/core: Don't call scx_group_set_weight() prematurely from sched_create_group() (2025-06-17 08:19:55 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.16-rc6-fixes

for you to fetch changes up to 06efc9fe0b8deeb83b47fd7c5451fe1a60c8a761:

  sched_ext: idle: Handle migration-disabled tasks in idle selection (2025-07-17 08:19:38 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.16-rc6

- Fix handling of migration disabled tasks in default idle selection.

- update_locked_rq() called __this_cpu_write() spuriously with NULL when @rq
  was not locked. As the writes were spurious, it didn't break anything
  directly. However, the function could be called in a preemptible leading
  to a context warning in __this_cpu_write(). Skip the spurious NULL writes.

- Selftest fix on UP.

----------------------------------------------------------------
Andrea Righi (2):
      selftests/sched_ext: Fix exit selftest hang on UP
      sched_ext: idle: Handle migration-disabled tasks in idle selection

Breno Leitao (1):
      sched/ext: Prevent update_locked_rq() calls with NULL rq

 kernel/sched/ext.c                       | 12 ++++++++----
 kernel/sched/ext_idle.c                  |  2 +-
 tools/testing/selftests/sched_ext/exit.c |  8 ++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
tejun
