Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0074E2868B0;
	Sun,  8 Mar 2026 02:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772937921; cv=none; b=mO68upOLVVY5LcejVLjl/M6JcJvDb9ZQnlGyHagE6Vz625N9ZL+6+9iB3+qPwbkwx7vGzFpmvHwvrZJoIphec8MdB6mQvYK8KGw4nW3MRHyECCPrus8Rr9VlP5i9igRasKzHFDSjjdsjF5T3WEMiteaNrYWgapkGglYdU1ac7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772937921; c=relaxed/simple;
	bh=aYVxrHzId0at85SZtcNcCmk1EVgsx57J4L3rErBHErU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6a/trnD/ifGm/1v9p+QWiVc3qTE1qaVLxhy9r+qzrLJNxprE7K8cZ7ETrHTDLEU8eEs6nFCZfN1v0u6lmAaYu8S2vivClFCmTCdd1loHGaUL2Fxjx2xHj/w0Rd37pgbFudVgp+dzaK/vYARarMNqyGYdm/CR4VhOQLEMMFBiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAEkZ9vH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAEkZ9vH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79669C19422;
	Sun,  8 Mar 2026 02:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772937920;
	bh=aYVxrHzId0at85SZtcNcCmk1EVgsx57J4L3rErBHErU=;
	h=From:To:Cc:Subject:Date:From;
	b=FAEkZ9vHy+tH2pQzxsB08tUYhMH5aaKXDxm5+suOsMuX8wpfBKHS/AnMxFzalJgds
	 4Yenn32isSz62RiVILnqipKFimqaBx6yzbScGNsDSuI45hefVRytvPQrLOQCa0edUM
	 SOiU+TvgBzmx/5WshonCRVmaqYBTwFe3K2rdoFMrtcQsdvMVglkgH4KF/8cxRMPEps
	 uucPsNZxSSTHcUiWw9JTHzhMlCgTIB4g8buj6nzqzcqIba8xpaDg9SRU+jFT8rhpkG
	 OOfdP/IShwdS+wpdZx6keI0RNFKLmg5UwI+luWpOR0tzpej3wTuTdB9BqdyKKOq1Nn
	 kW4r7ElOSO0zA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.1] tools/sched_ext/include: Sync include files with scx repo
Date: Sat,  7 Mar 2026 16:45:13 -1000
Message-ID: <20260308024519.1980564-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Sync tools/sched_ext/include/ with the scx repo. This brings in helpers,
compat wrappers, and generated files that have accumulated in the scx repo
since the last sync.

Based on sched_ext/for-7.1 (28c4ef2b2e57).

 0001 tools/sched_ext/include: Remove dead sdt_task_defs.h guard from common.h
 0002 tools/sched_ext/include: Sync bpf_arena_common.bpf.h with scx repo
 0003 tools/sched_ext/include: Add missing helpers to common.bpf.h
 0004 tools/sched_ext/include: Add __COMPAT_HAS_scx_bpf_select_cpu_and macro
 0005 tools/sched_ext/include: Add libbpf version guard for assoc_struct_ops
 0006 tools/sched_ext/include: Regenerate enum_defs.autogen.h

Git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-include-sync

 tools/sched_ext/include/scx/bpf_arena_common.bpf.h |   8 +-
 tools/sched_ext/include/scx/common.bpf.h           | 277 +++++++++++++++++++++
 tools/sched_ext/include/scx/common.h               |   4 -
 tools/sched_ext/include/scx/compat.bpf.h           |   8 +
 tools/sched_ext/include/scx/compat.h               |  35 ++-
 tools/sched_ext/include/scx/enum_defs.autogen.h    |  49 +++-
 6 files changed, 357 insertions(+), 24 deletions(-)

--
tejun
