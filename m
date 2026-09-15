Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05DD46C4AF;
	Tue, 15 Sep 2026 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460847; cv=none; b=JeuLmUR72E+7ECHGI/VYnfEcdcuflADZqB3HFmESA8b430zSry+w8WHbCQZSSvu56LegpjNFtddpqLleHXokewGT4PiAtE8Or0L6vbqWVfm5PNE8Hpc57srL3PTBNilvKricGqnZkntU7waHR8gNd6LVc7/l87VNgqS2s+l1cq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460847; c=relaxed/simple;
	bh=6lVG5RXRTNiFt5ZiZlTDQaLWPlcvcX9I6MMMXviIp6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HuDVrPBb1Vw+7WSrt4dPYJSvpi8T/nxYaV6K7Ku3wggYqTFWr0ZhxoFL9dqcgKaawJTT4ImtU/2/IYUZRlSgzgsC090N6bpAAkq0/QMLRwKpAQBltvg8V4doDZ+Jy6CgXuYbQwA3WrTvBxR1G1HGBjTC1RAQniOqO+wLpajdHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJR30kMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJR30kMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E331F00898;
	Tue, 15 Sep 2026 08:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789460846;
	bh=p602bYYAkDW1My1vQzlviFBo0UbaGvakw4smPX6EMb8=;
	h=From:To:Cc:Subject:Date;
	b=NJR30kMFNbkYgLLbnXwc06kxa9NEJ5KfhX0n17gZ4uabVV+n9YA2A10YmOdJMmrj8
	 p+Ge1ut3HlOXlXHAv25IJLQt16EiOtMm9HTuPnMT7Z8Qx1J6bJPu73mz9MXWycvEUG
	 jH9W0UfRsvm5p001gD1cZ9VkV7AHGh3c8DzHEXx6U6NxvPZZJGhD8ICJa5XYWyi0nt
	 uzishH2ilu9YLX92JlTlEdhPJJ32yja31nea6x5Oee5XKQA+vWRMSgXJItOiClemTN
	 ZViRvWYlhSyQWuRirall6gKh+N2ZhHdtj+s7YaI56CrEYpfFpg8YrLOIrcumipM7By
	 M3cxsFmjyDzMQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.3-fixes] sched_ext: Idle claim recovery and online cid mask
Date: Mon, 14 Sep 2026 22:27:23 -1000
Message-ID: <20260915082725.3881071-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v2: - Dropped the idle-to-idle notification patch. Restoring an unused idle
      claim from ops.dispatch() is the established pattern (Andrea Righi).
      Replaced with a patch fixing scx_qmap to do that and documenting the
      pattern in ops.update_idle().
    - Reworded the online cmask getter kerneldoc (Andrea Righi).

v1: https://lore.kernel.org/r/20260914234259.3585373-1-tj@kernel.org

Two issues surfaced while converting a scheduler that maintains its own idle
and online tracking.

An idle CPU can be claimed and kicked without receiving a task. When it
picks idle again there is no idle transition, so ops.update_idle() stays
silent and a scheduler tracking idle CPUs itself loses the CPU until an
unrelated task runs there. scx_qmap has this hole. The first patch restores
the claim from ops.dispatch(), where a kick guarantees a call, and documents
the pattern in ops.update_idle().

A cid-form scheduler that installs its own mapping has no way to learn which
cids are online: the online count identifies the set only under the default
mapping and the CPU-form cpumask is unusable from cid programs. The second
patch adds scx_bpf_online_cmask(), a kernel-maintained cmask in the
scheduler's arena that follows the SCX hotplug notifications.

Verified by building the kernel and tools/sched_ext and running scx_qmap
under CPU and fork load in a VM. The online cmask patch only changed
kerneldoc since v1, where a local selftest offlined and onlined a CPU in a
VM and checked the mask and the callbacks at each step.

Based on sched_ext/for-7.3-fixes (c7a1c6e8004a).

This patchset contains the following 2 patches.

 0001 sched_ext: scx_qmap: Restore unused idle claims from ops.dispatch()
 0002 sched_ext: Maintain an online cid mask in the scheduler arena

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git cid-online-cmask-v2

diffstat follows. Thanks.

 kernel/sched/ext/ext.c                   | 75 +++++++++++++++++++++++++++++---
 kernel/sched/ext/internal.h              |  9 +++-
 kernel/sched/ext/sub.c                   | 10 +++--
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/scx_qmap.bpf.c           | 14 ++++--
 5 files changed, 94 insertions(+), 15 deletions(-)

--
tejun
