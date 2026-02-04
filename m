Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AA3BB57;
	Wed,  4 Feb 2026 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244362; cv=none; b=IoLcBTegPW9yI1Fgr6xUt2WUfYLfm7YJWRV3STvk54W1P6OyjYtOl3Ygzlr91629PO20Kh7iuNnLCOJ3WY+5zS8stNPhF6yx5y4+Yk5IDmJOSw/1w1O910wdo5SwkD3j4M93CsVdtBJu9P54B36fl8HarBjN5Mg5hImpNozEw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244362; c=relaxed/simple;
	bh=7j/t1KHfrd7ogDja6DlFcKyM21ozIktyxx96BUt15Eg=;
	h=Date:Message-ID:From:To:Cc:Subject; b=d9UMcdwhwfvn2u5Kun84J9/BsH/MRBaCGAGfxcNM/+TLmc4IwfRggvzhJ2AJs/P/xdbEBzbLP9DYHedkJVCBVRGV/DhIeOTgxxBLsRIcolHKow4CYIIaci4w6NzwgorNU++WBWioaoCfCDGkqj/Cc5B+04qsifksEO1u9jsSYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb3AB9ky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb3AB9ky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECAFC16AAE;
	Wed,  4 Feb 2026 22:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770244362;
	bh=7j/t1KHfrd7ogDja6DlFcKyM21ozIktyxx96BUt15Eg=;
	h=Date:From:To:Cc:Subject:From;
	b=Eb3AB9ky38eJTJSPy4ms06kSR11x8DI1GJ15/zhOjP7WA8tmEZFX3e9nODgg/b517
	 8CdkxqrLbGQ/7Ivez19rV+71Ab0Lp1+hRAvifXqkNcw0lb8TuYLU9Mh1fuVQBneZ6D
	 CZnyfS9WsKHeHvgfCRRRCENvLB9N6pH1Pq/08/TpZGTe0BOSFqobfhaTzzxGj06QFF
	 4t4Fz6BxZTgD2zCisfRZwUXK7GdyoB7Aik5hlw5ApLCPTdOuZhazpDmTkYVUZnxPjQ
	 IOfH7ZDIXcsVAz54EfPd3LZlm+5nJn2K9LZOtIs8Dl2Ti3Lo/nNJHxEpkrvHfHvjZa
	 WfvJnipJ9ENlg==
Date: Wed, 04 Feb 2026 12:32:41 -1000
Message-ID: <403d62bc430249eb2904652103e4efa0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fix for v6.19-rc8
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi, Linus.

This is a critical regression fix for a change introduced in this cycle.

The cgroup exit ordering fix (7900aa699c34) which moved sched_ext_free()
to finish_task_switch() created a race window where sched_class operations
could be invoked on dead tasks after sched_ext_dead() already ran, leading
to invalid SCX task state transitions and NULL pointer dereferences.

Thanks.

The following changes since commit c9894e6f0160414b57e895332c580cf5c8da6780:

  tools/sched_ext: update scx_show_state.py for scx_aborting change (2025-12-28 06:11:26 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.19-rc8-fixes

for you to fetch changes up to 0eca95cba2b7bf7b7b4f2fa90734a85fcaa72782:

  sched_ext: Short-circuit sched_class operations on dead tasks (2026-02-04 12:22:11 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.19-rc8

- Fix race where sched_class operations (sched_setscheduler() and friends)
  could be invoked on dead tasks after sched_ext_dead() already ran, causing
  invalid SCX task state transitions and NULL pointer dereferences. This was
  a regression from the cgroup exit ordering fix which moved
  sched_ext_free() to finish_task_switch().

----------------------------------------------------------------
Tejun Heo (1):
      sched_ext: Short-circuit sched_class operations on dead tasks

 kernel/sched/ext.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

--
tejun
