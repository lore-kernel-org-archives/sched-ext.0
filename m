Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4978F3A;
	Thu,  4 Jun 2026 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538435; cv=none; b=TKxN2ozB8mL8pTZl4Uj5R2QXHOGFooZGqBNtOW1FvbSgeE1klABiGAbzjifWSFMvqZzUn46erzIT1I+b95l0KipS+mAJaJ3RY+Ed0x3LF2+Ox+mPzpJAzNhzll7EcA/foHF9QzLvfTr83oREHuKsHFLIi7RpvmqUi6Ai1r3n3mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538435; c=relaxed/simple;
	bh=9ZWzQkBI/hPUXSOW78n6TeXqm64eWAUcyBgNVea/mb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IRC5FU6epgZrasGDqNHtoEZA8+HlHmZyABsaHoXjEJJZArxUhoQdRnk2lwhgcmbZ7ubPgjwKe3MWVtVExXU+5jU1ZFl83XgfyGAtCjSE2mAZCf05qNX6SNMb/wbvNBfNuCl1ADeXeEJ47FR5+nLk4zByoxZ8IXMs3VvOIM2OfeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVGEjkhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVGEjkhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2D51F00893;
	Thu,  4 Jun 2026 02:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538433;
	bh=R6x21Mp7MWgcZPkv9wttwqxDHmQyL3Eat89+h+I9gMU=;
	h=From:To:Cc:Subject:Date;
	b=DVGEjkhrnzKubtLceF09//pEugi1cz2fIUiBeInF3RESwpnfirIGqYWZvtlTGLkIS
	 +NkIMSHPOog8VjdjWUqi9hjXZrkurGmYfb0Ew8mS1NwB8Htv4TbWivf/CcpimPO3sk
	 hML4dF4MUCL5G68MIntwwyxv1Zko8GZBH8l09CTE6eSBlx3lidVM+J2orUY/PFbCxc
	 Ew7iEPjBPPkNq2rVn800nC/vIxkIRE45GO8swgTN3pBuXh8ysC5kvh2T66SJPsH844
	 Z+Sm1NnT2/6SIBnZ0Rgl0ku1BcjEFHkyoF1jLR9sotqdKq2ozmpQOsAC+/IksjZthh
	 v/ND+VljTB9/w==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.2] sched_ext: cid/cmask interface prep
Date: Wed,  3 Jun 2026 16:00:28 -1000
Message-ID: <20260604020032.3536466-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v2:
- New patch 2 reorders the BPF-side cmask helpers (cid.bpf.h) and their
  callers to (cid, mask) so the kernel and BPF interfaces match.
- Bound scx_cmask_for_each_cid() to the active range so a stale word past
  it can't yield a phantom cid (sashiko AI).
- scx_bpf_kick_cid() returns scx_cid_to_cpu()'s errno instead of -EINVAL
  (Andrea).

v1: https://lore.kernel.org/r/20260603172153.3081861-1-tj@kernel.org

Preparatory changes to the cid/cmask interface that landed in for-7.2 this
cycle - a single-cid helper-argument reorder on the kernel and BPF sides,
two new helpers, and a kfunc return-type change. Posting ahead of the merge
window, in particular the scx_bpf_kick_cid() return-type change in patch 4 -
it changes a kfunc's signature and is cleaner to settle before 7.2 ships.

- Patch 1 reorders the single-cid cmask helpers to (cid, mask), matching the
  kernel's index-first bit and cpumask predicates.
- Patch 2 reorders the BPF-side counterparts in cid.bpf.h the same way.
- Patch 3 adds scx_cmask_test() and scx_cmask_for_each_cid().
- Patch 4 switches scx_bpf_kick_cid() from void to s32 so future cap
  enforcement can surface failures. The cid interface has no external users
  yet, so the ABI change is safe now.

These are extracted from the in-development sub-scheduler series. Nothing
here depends on the rest of that work.

Base
----

sched_ext/for-7.2 (dad836524259)

 kernel/sched/ext.c                       | 13 ++++---
 kernel/sched/ext_cid.c                   |  2 +-
 kernel/sched/ext_cid.h                   | 53 +++++++++++++++++++++++++---
 tools/sched_ext/include/scx/cid.bpf.h    | 60 ++++++++++++++++----------------
 tools/sched_ext/include/scx/common.bpf.h |  2 +-
 tools/sched_ext/scx_qmap.bpf.c           | 12 +++----
 6 files changed, 94 insertions(+), 48 deletions(-)

Thanks.

--
tejun
