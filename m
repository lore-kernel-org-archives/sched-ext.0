Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0992FDC47;
	Wed, 17 Sep 2025 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137980; cv=none; b=c1jUTx3TvDhHtxb3Z+oU+p2cKFcIZKK2LAXNudkTT9Kcl8ykb3dU9yYSP8bKy7n7z6rG7WJ4Ze3efk6AtNvbpenNfFIZGG338ozDYalMCsfBn9wo6E7ta2j7e9zCNux11Kde32N4U+QZPQ5Cusofl+R5YuJ8j3goSZEPyqyS6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137980; c=relaxed/simple;
	bh=XKJc0iJ6G34io+mqORnTbfDe1EKZ10NumDtGE/ichik=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oWoWh+8I7+KrxQcKORKCjlzBpRLz1oFQ6NVo3vBCZUD3kNVT+5KpSmwtaIZ8EYNv52nCsQkWKqZsh/YAyLxp8x2K8iJFmrBG78Sm50qfF2fbbhPSqTwJkxYYZOPnXvAj4JFoUIkukeqWry1T+IlHGGeQh6dd4gYPOoRLw39gtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDQXG9VL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDQXG9VL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0670EC4CEE7;
	Wed, 17 Sep 2025 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758137980;
	bh=XKJc0iJ6G34io+mqORnTbfDe1EKZ10NumDtGE/ichik=;
	h=Date:From:To:Cc:Subject:From;
	b=jDQXG9VLLOGp/I1MD8pujmnZSHi/u7bTle4k+KnVjfzsi/Pdu6iyLgfXGbVZozsO/
	 J45YqR97+9Ix5qp6BvFGoQokPz8S14aTFotW4mT+N2KIfYGqn/bfPumfUEqBsg/3CB
	 trZ/rfO8Ursym3cO/C3ISZKkenuLkKte3imuuADljW4VOhyjf6j/3Gab+Rs7TbcR1P
	 KcXm0aFMIpnoxjFFXpwwyNEeP1BSrbo9edFlh81anFkipVoAwTzop1v7dNDPpb5/nH
	 5MentBax7mC5KEqnaB1/sX+AmLJWFtJ2Kwi8P50u/z4u2G1hGW2d5T1vBP6IqD1LOu
	 o78XAsIFt7S1g==
Date: Wed, 17 Sep 2025 09:39:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: [GIT PULL] sched_ext: Fixes for v6.17-rc6
Message-ID: <aMsOe0f9m4YN4Mes@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e69980bd16f264581c3f606bae987e54f0ba8c4a:

  selftests/sched_ext: Remove duplicate sched.h header (2025-08-11 08:24:08 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.17-rc6-fixes

for you to fetch changes up to a1eab4d813f7b6e606ed21381b8cfda5c59a87e5:

  sched_ext, sched/core: Fix build failure when !FAIR_GROUP_SCHED && EXT_GROUP_SCHED (2025-09-16 23:07:27 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.17-rc6

This contains 2 sched_ext fixes.

- Fix build failure when !FAIR_GROUP_SCHED && EXT_GROUP_SCHED.

- Revert "sched_ext: Skip per-CPU tasks in scx_bpf_reenqueue_local()" which
  was causing issues with per-CPU task scheduling and reenqueuing behavior.

----------------------------------------------------------------
Andrea Righi (1):
      Revert "sched_ext: Skip per-CPU tasks in scx_bpf_reenqueue_local()"

Tejun Heo (1):
      sched_ext, sched/core: Fix build failure when !FAIR_GROUP_SCHED && EXT_GROUP_SCHED

 kernel/sched/core.c | 2 +-
 kernel/sched/ext.c  | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
tejun
