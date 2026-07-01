Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C742364950;
	Wed,  1 Jul 2026 03:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875672; cv=none; b=HfI22phrjysi6eE3y/Y6k+r3N8VmoaMITFP6GLsu43hXzxAk2E4YeZyn7qoTK9duEM6tx2vwCg+CmHVGEXzdwIfHgODV4vNpJ0DP1yQponzljHWGahaWAG9l8mzjGNXC6X1ZF2GDJ0fFOpBhQkzsTKykbojBOnWIA0TzPYtHfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875672; c=relaxed/simple;
	bh=GARVOkdV0aoZty1CgehiquT5La9QUPmQn0snnvTwnVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bQGuZIrN5bOXyCPsh79kEBkYGNjdLIhQ94pUjAnSIO4y3yihsZUrf9FiUT5D3rwQr3dfs/g3O2ZR7Vu/x4s9g6Zt24mPXT1bUmP1tuAxQNaGdFkpCDkvjc3ZUm8aRBZqFJtzLtvKm69FNNUjf6yRwqDqZrKybwubdPoLtGSJOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6fbCNe9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6fbCNe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31AE1F000E9;
	Wed,  1 Jul 2026 03:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782875671;
	bh=TEUrATOxd2LMf9/f1mAu7vtlshDKXYwjamjBIdDYnIY=;
	h=From:To:Cc:Subject:Date;
	b=U6fbCNe9AK7pykdT4kka26HV2QDG7qKZA86B3b1QYtjBpzjgDMTJZ9r8mOuIwb/nj
	 pvdOAyf+hliy3mmm/nilgNnxRQrmAu6er4aYsjYh3ozfaqFaWNHHF3uOd7p1TURxjX
	 dqi9VB4gfzV+ENyGO/LhESTOYB8v+HwKSY90ownFwCd+cCZR7O1/j/K5K/8/IbJMaC
	 majFcxkylsX8XfT9juwbcRW7rGAFRJ2LfqXBAS7y7igudevFNLwk9pOecrbexLcKuH
	 QWqyNEcXHYsBMj2iCuSFeaamgjR/PJWtzRLskrXywiuN5+VuWWfUhT0oKjeUXoRE5B
	 zMGcrw344PXAA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.3] sched_ext: Split sub-scheduler implementation into sub.c
Date: Tue, 30 Jun 2026 17:14:25 -1000
Message-ID: <20260701031429.1892218-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The sub-scheduler implementation has grown and will keep growing. Move it
out of ext.c into a new kernel/sched/ext/sub.c. The first three patches are
mechanical prep (prefix file-local helpers, expose shared internals, inline
a few trivial helpers) so the move itself stays pure code motion. No
functional change.

Based on sched_ext/for-7.3 (5df6a4506d06) with sched_ext/for-7.2-fixes
(b7d9c359e5cf) assumed merged.

Tejun Heo (4):
  sched_ext: Prefix file-local ext.c helpers exposed by the sub.c split
  sched_ext: Expose the ext.c internals used by the sub.c split
  sched_ext: Inline small ext.c helpers shared across the sub.c split
  sched_ext: Split sub-scheduler implementation into sub.c

 kernel/sched/build_policy.c |    2 +
 kernel/sched/ext/ext.c      | 1002 +++++--------------------------------------
 kernel/sched/ext/internal.h |  136 +++++-
 kernel/sched/ext/sub.c      |  668 +++++++++++++++++++++++++++++
 kernel/sched/ext/sub.h      |   51 +++
 5 files changed, 973 insertions(+), 886 deletions(-)

Thanks.

--
tejun
