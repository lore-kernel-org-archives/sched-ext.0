Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FDF3314C4;
	Tue,  2 Jun 2026 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440461; cv=none; b=WSUdB3zz/EeiCLLMHCHBZ7lGDlAK8sA43LAR5DASMt/F1PAChsu5XrH7Kvv+qZheqhUgLqls3nc+sdlhWQfqTubW2JPbW6pCACAsz+Hpjv5JWsbwkADkM89X+fL00eLfC65sho4GAL/598q7S/bCLSzcibzQIuah/kdyQ9Ay4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440461; c=relaxed/simple;
	bh=dPP6hvIJtR54p3YqjKbR7+5+9El5PQanJsjJyKiWE/U=;
	h=Date:Message-ID:From:To:Cc:Subject; b=MNJn85mnHd/jno6Et0mSBAT13vpCeSIpPaMq+IOhz58f3KBnsf2JCe1lHwhDnWM46yFJ+tHij421TzV2ef4R2fXehbioQRC4NiFutUq8eQ5H15t9f4KRhF5llDMSMpYC4K1/dZ4qVR2KVvcvXreo494louijqwmREA+7RcYVLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+GBpP+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+GBpP+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B340E1F00893;
	Tue,  2 Jun 2026 22:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780440459;
	bh=zGQgmwtTMaw1tQ0egksnLeJoKbiodOct1cTG7ESAgmw=;
	h=Date:From:To:Cc:Subject;
	b=Q+GBpP+IzhYX/65IgkbLc4aPyqBRNPmnf+Ula6EQwZKcWmOcfT5VjrKPrWxk8W4/c
	 f20O6MvVNioNApVXX6qaOwH60hAlarZSE3z2KW4Y1SzScBRgS7yMkoyo4E/cUznJTH
	 tYEpXhYBT9wJ8DSVUoHM25pu4b2ppe5gFmNVUpTxFZz3+RatR4A9DO1mk/iBxtrokH
	 fo7koBzs0JpwDwm98cHTsk0HkpH/Dj9B3YSos8P/968g6e0umnDggyv7ivt+2W7uff
	 M0LQXtk+/CKz9m9CunsFeUYXLW2ymUBjamr59ddVmcgtblMdSvytQIs/XnEG0L9IVe
	 Y3/30ngPkjpTw==
Date: Tue, 02 Jun 2026 12:47:38 -1000
Message-ID: <eaed7efc3d9465b3986fd1ce89d7257a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.1-rc6
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Two low-risk fixes, both contained within sched_ext.

The following changes since commit 0c1a9dce208b4dc265925898e5da98934f7f9266:

  sched_ext: Fix spurious WARN on stale ops_state in ops_dequeue() (2026-05-21 06:27:44 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc6-fixes

for you to fetch changes up to 02e545c4297a26dbbc41df81b831e7f605bcd306:

  sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task() (2026-06-02 11:27:50 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.1-rc6

Two low-risk fixes:

- Drop a spurious warning that can fire during cgroup migration while a
  sched_ext scheduler is loaded.

- Fix a drgn-based debug script that broke after scheduler state moved into
  a per-scheduler struct.

----------------------------------------------------------------
Tejun Heo (1):
      sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task()

Zicheng Qu (1):
      tools/sched_ext: Fix scx_show_state per-scheduler state reads

 kernel/sched/ext.c                | 10 ++++++----
 tools/sched_ext/scx_show_state.py | 19 +++++++++++++------
 2 files changed, 19 insertions(+), 10 deletions(-)

--
tejun
