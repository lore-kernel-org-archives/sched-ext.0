Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913F92FBDFB;
	Wed, 22 Oct 2025 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166203; cv=none; b=ujQE4U3P0oVB6sQpIia3dPMpyp94NR098U9du/TguQwC5oQRP4fAHjljgpQpxPkb3G8AILYR4ZRnN82M6Zjl/DGorOFN+egF4XHfcR8h+5uzP1fwTV6+PWFIx+aURzoW4mfrQ+TA4IhvF9Ygj4Gio45PB5LoYNugNSvPTdP1cGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166203; c=relaxed/simple;
	bh=+ocb1AeN8Q9xIBuddW6IcBX4wP7fBSwoIGna7HpsBWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poVsB47IRTegGfyWTczT/iPvNCM6PRAoJ/cyA8EDvRbh0J2bOMEWNTqlQTwWb5BH4vHrhMSa/NwpC4sPdoGOD12UmS+1qQZUeao3ZZP9ApHDRKLOJsue821vDa7sOuLe29iQqWQJ9xa2RClo7ZpHPpjJpyZztlmbVjJOkGJgxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRJBDbsh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRJBDbsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC58AC4CEE7;
	Wed, 22 Oct 2025 20:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761166202;
	bh=+ocb1AeN8Q9xIBuddW6IcBX4wP7fBSwoIGna7HpsBWA=;
	h=From:To:Cc:Subject:Date:From;
	b=WRJBDbshmffFjw4BFqMgVL7JyjwsglQzmJlnXHCVpsBha72VwFgWyse5FJ3Co+o8O
	 rEA7OLPSRLRQazamO+I7Qw2mSu8L7VwwCmh/56e57pYJoyXE67nGyxqi/f79hE56Y5
	 dFmdt3gPaDtwIzv59BMtAVVaHTexnQb38QM+RTu4i+7hLi1huAcW1mtbFeqs4gu8R2
	 90JsxPSFl7Xj43jIgKfeDz1eDLjTCobQhAlWHX1BwT+a8W/UxnhUyiVR9kG8U+uSc8
	 4+OEHwFrRGbbeKeXIurhcwJ8RlFFUku70Aw9LTwHOuP9DmupawW7JPwT4Kpdeb0o+W
	 MZ/iJYaqbeWVw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCHSET v2 sched_ext/for-6.19] sched_ext: Fix SCX_KICK_WAIT reliability
Date: Wed, 22 Oct 2025 10:49:57 -1000
Message-ID: <20251022205000.843899-1-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCX_KICK_WAIT is used to synchronously wait for the target CPU to complete
a reschedule and can be used to implement operations like core scheduling.
However, recent scheduler refactorings broke its reliability. This series
fixes the issue and improves the code clarity.

v2: - In patch #2, also increment pnt_seq in pick_task_scx() to handle
      same-task re-selection (Andrea Righi).
    - In patch #2, use smp_cond_load_acquire() for the busy-wait loop for
      better architecture optimization (Peter Zijlstra).
    - Added patch #3 to rename pnt_seq to kick_sync for clarity.

v1: http://lkml.kernel.org/r/20251021210354.89570-1-tj@kernel.org

Based on sched_ext/for-6.19 (2dbbdeda77a6).

 1 sched_ext: Don't kick CPUs running higher classes
 2 sched_ext: Fix SCX_KICK_WAIT to work reliably
 3 sched_ext: Rename pnt_seq to kick_sync

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-fix-kick_wait

 kernel/sched/ext.c          | 129 ++++++++++++++++++++++++--------------------
 kernel/sched/ext_internal.h |   6 ++-
 kernel/sched/sched.h        |   2 +-
 3 files changed, 75 insertions(+), 62 deletions(-)

--
tejun
