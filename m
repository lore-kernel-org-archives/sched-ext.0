Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CF18B0A;
	Sun, 16 Aug 2026 00:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838729; cv=none; b=hpNWrHnJsODZ+pqqAEnNvQozXDppWjQ0nrEVKitzdtJ6GvqfLwLpzAu1DjZJRVpDH6LV7n+khIKlkEtGID6DPx7OHKY51FzkL90Er+/liWHRK03VbMfp1b7nTjtQyTfNef8uIGFQwZOrYyHGJSeQY030L05lVwOv+Zn+zA3zTug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838729; c=relaxed/simple;
	bh=GiTCM222P1V8Ttxv9GKUfEzpJ0W5C3Fi8CJqCJgCVns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9R+v7ive93V6NhI4uZIeZSV1IoRai9vzOFl15QC1SOHV9PDXfnlO/jRCzluFjhNp+NToMyvQjwgRgyuWgmCGI98/jtsLRQg8s54DoKbplD6oDfFjrvMqw1muqFQrbuOiJ3z7qvr/DM3DT+zP1NRFlWJIuaabfT95CkSi0xB5zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=em8PEcUN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="em8PEcUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A101F000E9;
	Sun, 16 Aug 2026 00:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786838728;
	bh=SW5I3TXyZ4l8QTnzbEKCDllYsgU8EFDSUiBqEaf5X1I=;
	h=From:To:Cc:Subject:Date;
	b=em8PEcUNCyvL+CxerAYLN+f1WGqANg/jYkwqSqBG2idF1PJGmYLLIeUaoIG1sa6vn
	 D9o8sH4GaVkivNlNB2SIVmE80gI5Du1koAbY26/KsTmQpiCv4psD2o1kZrm2DjNBWK
	 8JTTff8ERvQzPcQFhsXud3UDF86UY4AxiHUTp5C2fISvQxh8f+ECeU0wmCBC1ECGCn
	 Yt1YPNkBH7xYF4j2jxm9R4hpiRCRv3i/QwQxngNh1QcIMcr4vIWONiHDgaDSeAK5p7
	 XxQ7hR2oRgC+YUQIwSX259JK6aX6mxI97roFjhSHObLR0lPEwHiEJCNxNAd8kwBDTr
	 CMg+axh8Ny7pg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.3] sched_ext: Update core-sched task ordering for scheduler hierarchies
Date: Sat, 15 Aug 2026 14:05:23 -1000
Message-ID: <20260816000527.988170-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Core-sched task ordering predates sub-schedulers. scx_prio_less() consults
ops.core_sched_before() only when both tasks belong to the same scheduler,
and the timestamp fallback maintains its own stamp, p->scx.core_sched_at,
under two different stamping rules. This patchset updates core-sched task
ordering for scheduler hierarchies:

- Fix ops.core_sched_before() being invoked with inverted polarity.

- Replace core_sched_at with p->scx.runnable_at which the stall watchdog
  already maintains, so that the fallback follows one wait-tracking rule.
  A running task orders after every waiting task.

- Order a pair of tasks spanning two schedulers by the nearest common
  ancestor which implements ops.core_sched_before().

- Drop a dead core-sched related test in the dequeue path.

This patchset contains the following four patches:

 0001-sched_ext-Fix-inverted-ops.core_sched_before-invocat.patch
 0002-sched_ext-Use-runnable_at-for-the-default-core-sched.patch
 0003-sched_ext-Make-core-sched-task-ordering-hierarchy-aw.patch
 0004-sched_ext-Drop-the-dead-SCX_DEQ_CORE_SCHED_EXEC-test.patch

and is on top of sched_ext/for-7.3 (3167bd3e0c22). The patches are also
available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git core-sched-hier

diffstat follows. Thanks.

 include/linux/sched/ext.h      |   3 -
 kernel/sched/ext/ext.c         | 147 +++++++++++++++++------------------------
 kernel/sched/ext/internal.h    |   5 ++
 tools/sched_ext/scx_qmap.bpf.c |  23 +++++--
 4 files changed, 81 insertions(+), 97 deletions(-)

--
tejun
