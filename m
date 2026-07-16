Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8501A6823;
	Thu, 16 Jul 2026 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237461; cv=none; b=QMAqT0GnOW0sVr1AkLhwc4kQORb1CkJqeRQOMJ8SzS6kk+myC7t4gZcxfqWJ63RtxZRFFp1xBpkfxQx8HdDzE2qaE/89PNoWaONIuxqb9pFeLG1aUHVgcRWxy5TgZ5JBtcplhzWwAo+sFON/2fY0vvWcwQG3CCXRLlhB4N4mlhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237461; c=relaxed/simple;
	bh=Q10CB2lrT+QSoBsCk3EWPIR3C0E9tFuUbqMzZR9uzao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZNvhi8fx1H/Qr5JKikvsbPKQ4jTmLJ/TCwdZ2UPyvy3x7wHumcQjqAu3EDqy1Fq/H5yojtdoAtSnj5EkYA/7K/VPnE1Y9qlnPcBVx4qEsNm/+RTpbEHoiKr7obk4KvgqRH302OO2AEw9YGiqDZZoAig0yhYWpqhrQj6RNv2yiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vji/KxL/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vji/KxL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853F71F000E9;
	Thu, 16 Jul 2026 21:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784237459;
	bh=OwuKkXw9EMVDqAF39LAXq/jBdboCxnRC7lUhHn74Yq8=;
	h=From:To:Cc:Subject:Date;
	b=Vji/KxL/fATTJTUWr0+DmGEDJ9tP/FWg1JixP2mD0+eUghqyiIPD1p2ZoNJIr58dC
	 /bE0k4nNxOjgWf4YjvJqFHl59hl+ZGffSdMr1TDsLAYLXTvbgPDH20mB35UkuQ3bEB
	 jWOSRVLHVBAdR2/Jo0y3MjUaJ6lKLEs+Hh4PQgNzIlqwXS6Sv0M02gzRS+6+6uJ8jh
	 Y0aInbD5aR8dgoiG4M231D5vGVkYpdJOuTWbomv2r/FWHNSuYv9wWXxtp87Aznk5Y4
	 qAdkOBbNnZammgC2fahlI9l0bW/tt6VjfyTyl6Yj0OmqAddBg8m/qhiB8tF01eesBV
	 6sI+RE+WWV3lQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.2-fixes] sched_ext: Assorted sub-scheduler and cgroup fixes
Date: Thu, 16 Jul 2026 11:30:54 -1000
Message-ID: <20260716213058.1739522-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains three sub-scheduler fixes and a cgroup lock
ordering deadlock fix.

 0001-sched_ext-Reject-setting-disallow-from-init_task-out.patch
 0002-sched_ext-Take-cgroup_lock-first-in-scx_cgroup_lock.patch
 0003-sched_ext-Skip-sub-disable-teardown-for-never-linked.patch
 0004-sched_ext-Don-t-enable-non-ext-tasks-in-the-sub-sche.patch

- 0001 makes ops.init_task() setting p->scx.disallow outside the enable
  path fail the scheduler. The sub-scheduler disable path could reach the
  load-path-only policy revert and silently rewrite a live task's policy.

- 0002 fixes a three-way deadlock among scx_cgroup_lock(), cgroup teardown
  draining the cpu controller's files, and a concurrent cpu.weight write.
  Present in released kernels since v6.18 and marked for stable.

- 0003 fixes a use-after-free when a sub-scheduler whose enable failed
  before linking is torn down concurrently with root disable.

- 0004 gates task enabling on the ext class in the sub-scheduler task
  loops. A non-ext task under an SCX_OPS_SWITCH_PARTIAL root could be
  marked ENABLED while staying on its own class, corrupting the task state
  machine.

This is against sched_ext/for-7.2-fixes (0e2f4ab68a89) and also available
in the following git branch:

 https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-cgroup-fixes

diffstat follows.

 include/linux/sched/ext.h | 10 +++++-----
 kernel/sched/ext/ext.c    | 47 ++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 14 deletions(-)

--
tejun
