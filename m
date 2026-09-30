Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE7BA45;
	Wed, 30 Sep 2026 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726665; cv=none; b=UEOAN4DZim1Iw5d3/epQbflcob84yJXcoU7hKU/RkTxwf84FX5vqdbdbmkdyqR6UXpi1Hm469uMUdNi+MVdFN6AJADfhJjti8NXS0GKrPQnmM08Puk5Nr5p/El9/UOHtAwc3igxnOqqLVK7IIQ8BCHXqMuD/A+seP1fNQ65lztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726665; c=relaxed/simple;
	bh=i7SyyYdTC+BA/DUxLIxmcX+qF+FrVzXcj6VZKWRIEcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4Wg5irjml4DUZAiBFh6leTlL670ZS0QsHdMi7/9tM7rVqX1zBi75Ip0j+RalpT0U8g+pc01q9S124HqlcLdjptRWgs6W11C8fgCupQtKiKiE1fw6xoTsUcWCNKCYAXiZ6XnEr9tS7PCTLrY3Pwb0YwCVX7PBPxHyrcmIkNVuUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2sNYKbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2sNYKbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96B21F000FF;
	Wed, 30 Sep 2026 00:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726663;
	bh=WDCmjDGffxRzaaQLGm1drSoIh8/P2XDE6hbYGjqDK/U=;
	h=From:To:Cc:Subject:Date;
	b=F2sNYKbNwG9H4260H18RinW4RtOJHTP6WgWgVNEVQ3iBqk95VMtAAQNM479gUsXPt
	 uznXTttjQKEW/Y2ucyvmdCTmu8e3sY+c0G+LZebBrDYxUQeOUQ3Gn59YLfgbITMzF3
	 VeBl1cPPYeMFpbGkrOjdlB+c6Xg86OLCjsCoXV6XGmX5nr552e72q0yaBCayfwm1it
	 57X4hzo/4zzJirBcgpFZjxX0uee7p/Ohjg6dt/xCt6tgRJ45z7AX4CabgwMc6OOrj+
	 P4B4biM2kHjioQF7YQx1zgabXEUuKUJtC+HNKpzFQJjJbtDUHptW1qM8sbOwguGJG3
	 xlwh2gHgsQBRQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.4] sched_ext: Sync tools headers from the scx repo
Date: Tue, 29 Sep 2026 14:04:20 -1000
Message-ID: <20260930000422.3350352-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The shared BPF headers in tools/sched_ext/include and the scx repo's
scheds/include have drifted apart since the last sync: the kernel gained a
size argument on scx_bpf_cid_topo(), scx_bpf_cid_node(), the lazy preemption
and proxy-exec flags and SCX_OPS_OPEN_OPTS(), while scx grew the cmask
helpers the cid-form schedulers use and the compat wrappers for the kfuncs
whose prototypes changed. This patchset copies the merged result back in.
The scx side is https://github.com/sched-ext/scx/pull/3856.

Patch 1 syncs the four shared headers and adds the two files they now depend
on, const-defs.h and features.bpf.h, and converts scx_qmap's cmask calls to
the three-operand form. Patch 2 syncs the four autogen enum headers, whose
task state lookups had been under a removed enum type.

Verified by building the kernel, tools/sched_ext and the sched_ext selftests
against the patched headers, and by a per-file diff showing every shared
file identical to the scx tree.

Based on sched_ext/for-7.4 (c6fe97c34a1a).

This patchset contains the following 2 patches.

 0001 sched_ext: Sync common and compat headers from the scx repo
 0002 sched_ext: Sync tools autogen enum headers from the scx repo

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-tools-header-sync

diffstat follows. Thanks.

 tools/sched_ext/include/scx/cid.bpf.h           | 689 ++++++++++++++++++++----
 tools/sched_ext/include/scx/common.bpf.h        |  90 +++-
 tools/sched_ext/include/scx/compat.bpf.h        |  63 +++
 tools/sched_ext/include/scx/compat.h            |  15 +-
 tools/sched_ext/include/scx/const-defs.h        |  20 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |  15 +-
 tools/sched_ext/include/scx/enums.autogen.h     |  20 +-
 tools/sched_ext/include/scx/enums_abi.autogen.h |   6 +
 tools/sched_ext/include/scx/features.bpf.h      |  29 +
 tools/sched_ext/scx_qmap.bpf.c                  |  14 +-
 11 files changed, 837 insertions(+), 127 deletions(-)

--
tejun
