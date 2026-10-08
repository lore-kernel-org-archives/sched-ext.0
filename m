Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3453547049;
	Thu,  8 Oct 2026 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417834; cv=none; b=cO9333Stb6ATc3iCIV5Hgy4yrCLWF3fsDxxCR2sfq0PSjIo0vdXbNFBlFM/4+XFuS1S5xt16YrSMHkZ5T3rG16oIOPIA2t0WuxHisL/kn3qTzd1LxtcJx4JYJ171oVIfZEYdM6LRSGlmY0d6ujb4i39yZw6gYVwt88JVwtI0qYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417834; c=relaxed/simple;
	bh=hFGRL1S5MLJxN6d/v5RnTnPlxFPdB1thahXsYheNDBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WKZh2YtCyAJVbB05TQoeIhiAxzYgJDSo4CZF+E0PF7fFqL98b4iA6PN/6J9oxSiIcsmzmhCcMUzsfwvdiJQoxCWhb2zQxd5xnP4wHg5MrUD5Nubb6k2+iiF/gm71Q0Gt43gmCU1nHCusYXg1oe005ZfkgRXoAQD4iHSDhBeOrPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+A1FjNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+A1FjNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5577B1F000FF;
	Thu,  8 Oct 2026 00:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791417833;
	bh=WXXBeOOAQXZZIgr+b2JT/zWDhKlIvQQpgNaMw4aqEyA=;
	h=From:To:Cc:Subject:Date;
	b=F+A1FjNKGADtImed8iEJKgiQB8SNBfRCkfECulT2AxJ1+doQe0cDrajIZmaPpigi8
	 BStlIqZU0/sswNcNRcDcAiBgq7z14lHrIISmsTo6vtzOi5b42tywHeFzCKwz71yO9l
	 gZ932HIRM3iKm78wmFvGlpXArGxrmUCeNc+kqqLGWJgsKNwFHt7ZeBDRR/5XlHx0pt
	 pkZPlxR0/Gsqp5L0XgEb1qbKRRCvrj+LZAjBQbq1wAW1Z97haaJkRmBuxa1MSwcWmK
	 Dz0r5nhgO3ljgNFJ5Cf0X4HLohgh6gagqlGGN5E9X6udwDj03sWDQQEaYQFf25Vm9y
	 W0Yqu4YVDVwyg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.4] sched_ext: Add ops.sub_child_ecaps_updated()
Date: Wed,  7 Oct 2026 14:03:50 -1000
Message-ID: <20261008000352.1689057-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

A grant or revoke only records the target caps. They take effect on a cid at
its next dispatch, and nothing tells the parent when. Until then the parent
cannot act on a revoke, such as resetting the cpuperf target a child left on
the cid.

Patch 1 adds ops.sub_child_ecaps_updated(), delivered to the direct parent
right after the child's own ops.sub_ecaps_updated(), with the child's cgroup
id and the same before and after caps. A sub's disable reports the caps it
still held as revoked before the parent's ops.sub_detach(). Patch 2 makes
scx_qmap reset a child's cpuperf target once its PERF revoke takes effect.

Based on sched_ext/for-7.4 (3d7c2f550eef).

This patchset contains the following 2 patches.

 0001 sched_ext: Add ops.sub_child_ecaps_updated() to report a child's effective cap changes
 0002 sched_ext: scx_qmap: Reset a child's cpuperf targets once its PERF revoke takes effect

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git sub-child-ecaps

diffstat follows. Thanks.

 kernel/sched/ext/ext.c         |   4 ++
 kernel/sched/ext/internal.h    |  29 ++++++++-
 kernel/sched/ext/sub.c         | 130 ++++++++++++++++++++++++++++++++++-------
 tools/sched_ext/scx_qmap.bpf.c |  15 +++++
 tools/sched_ext/scx_qmap.c     |   7 ++-
 tools/sched_ext/scx_qmap.h     |   1 +
 6 files changed, 161 insertions(+), 25 deletions(-)

--
tejun
