Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B25379C3E;
	Mon, 22 Jun 2026 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163943; cv=none; b=CayWR09BdUT1Sk93ooUzuCQg+AYlV8NoEavwEfmmP1oKtIYGAXWqBuy0lFdaOY1300Jgxyh1LLauW4FTlkzP+TnU7HUohZAKIW9a5pphwGryWvzKhFoZFaRjI7ZuYrOroiKZWJJ0G1teLSCrpAEVnOT+qW+EIvcsxoC0vfbfhq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163943; c=relaxed/simple;
	bh=J1XRGO+7cp7yV50KdrJu/9u4koZBNh5blTtABbKStKU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Fl6raTSGkQC13OAnoiHtAYpGpAI7Kyl4fy7/4/7T2wiOcK4zsJGHMJHBqZ0lxKrGBngeoYLP5H2w/z6XoZDrQTaM2s8FOzQfkf/CeJxu+knMMSeBgM0sAdiGcS27sfqOjJYKXpoQt7cuRN4R7KAShqVXQDw92KGKVdgHwRT/wuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojjqglVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojjqglVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A66E1F000E9;
	Mon, 22 Jun 2026 21:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782163941;
	bh=TwLukDsRlzzQRAJ6CVHQOAsn8h/Kn1SjBKuBucKndwc=;
	h=Date:From:To:Cc:Subject;
	b=ojjqglVlSP3JBdA7VXOviEHl/nDy6WO5Lt8zT8neGOP6l3WkA9T68FUK1egOCG72V
	 EC4dOyGz+D51cRwKu0XG9QfMOxiY9w3XX2d/FpghCYHq4kUHKpbI+6sNE5PrI0JDVn
	 jzuvPCloQNHSN4qZb/j9kpOOvz7cSQFdxtpitYTstKkM7eZvw3qkEH+EKeT4y/PS/A
	 O1njEdoWJ1Vwy7LyH3ouDyKSZQcAgQl8yOYnGL9vqAbHMylysg5AnfVHM7mpsRGePY
	 LrTPmpBlKzJV7PM1qEXDFCzB5g35jk4ElOP/B8QhewxZpraKeLGOMHAIqv6d34v7wK
	 xIirULEViqYEg==
Date: Mon, 22 Jun 2026 11:32:20 -1000
Message-ID: <e10b2679e4d0882e6d690c55c3efaa74@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Source tree reorganization for v7.2
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Linus.

This is a follow-up to the v7.2 sched_ext pull, pure source tree
reorganization with no functional change. I'm sending it during the merge
window rather than a later cycle to reduce friction in routing fixes.

The following changes since commit ef0c9f75a19532d7675384708fc8621e10850104:

  lib: Add stale 'raid6' directory to .gitignore file (2026-06-21 14:09:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.2-1

for you to fetch changes up to 4437ad129cf5b37c00a5bc9fa5989d1da4d64d07:

  sched_ext: Move shared helpers from ext.c into internal.h and cid.h (2026-06-22 10:41:34 -1000)

----------------------------------------------------------------
sched_ext: Source tree reorganization for v7.2

Follow-up to the v7.2 sched_ext pull. Pure source reorganization with no
functional change: the kernel/sched/ext* files move into a new
kernel/sched/ext/ subdirectory, and the headers and sources are made
self-contained so editor tooling can parse each file on its own.

----------------------------------------------------------------
Tejun Heo (3):
      sched_ext: Move sources under kernel/sched/ext/
      sched_ext: Make kernel/sched/ext/ sources self-contained for clangd
      sched_ext: Move shared helpers from ext.c into internal.h and cid.h

 Documentation/scheduler/sched-ext.rst           |   8 +-
 MAINTAINERS                                     |   2 +-
 kernel/sched/build_policy.c                     |  18 +--
 kernel/sched/{ext_arena.c => ext/arena.c}       |   4 +
 kernel/sched/{ext_arena.h => ext/arena.h}       |   2 +
 kernel/sched/{ext_cid.c => ext/cid.c}           |   5 +-
 kernel/sched/{ext_cid.h => ext/cid.h}           |  25 +++-
 kernel/sched/{ => ext}/ext.c                    | 158 +++---------------------
 kernel/sched/{ => ext}/ext.h                    |   0
 kernel/sched/{ext_idle.c => ext/idle.c}         |   3 +
 kernel/sched/{ext_idle.h => ext/idle.h}         |   4 +
 kernel/sched/{ext_internal.h => ext/internal.h} | 129 +++++++++++++++++++
 kernel/sched/{ext_types.h => ext/types.h}       |   6 +
 kernel/sched/sched.h                            |   2 +-
 tools/sched_ext/include/scx/cid.bpf.h           |   6 +-
 15 files changed, 209 insertions(+), 163 deletions(-)
 rename kernel/sched/{ext_arena.c => ext/arena.c} (98%)
 rename kernel/sched/{ext_arena.h => ext/arena.h} (95%)
 rename kernel/sched/{ext_cid.c => ext/cid.c} (99%)
 rename kernel/sched/{ext_cid.h => ext/cid.h} (92%)
 rename kernel/sched/{ => ext}/ext.c (98%)
 rename kernel/sched/{ => ext}/ext.h (100%)
 rename kernel/sched/{ext_idle.c => ext/idle.c} (99%)
 rename kernel/sched/{ext_idle.h => ext/idle.h} (93%)
 rename kernel/sched/{ext_internal.h => ext/internal.h} (93%)
 rename kernel/sched/{ext_types.h => ext/types.h} (97%)

--
tejun
