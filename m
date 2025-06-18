Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF6156C6F;
	Wed, 18 Jun 2025 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277722; cv=none; b=K1tmiE8iiYhR+j1E+ApiqTHAAxJ3phYVhd0xDBo5BPBCZcXNGZLl33UeMZKA6P4fcOzpXoeuWJt0oT3GKP0jYODfiPw+Pn0At68ec1K5oaU93/wLx5u5Km6p8T4i1kevT3AdXpt1WDzew2ZfSWPtNgYwllzsILT4XwfohAYaf2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277722; c=relaxed/simple;
	bh=sNt9429eGPeOWndMcJFi2UGRKkLdSlf+4k/V6ObPk2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MffeEVLCgwJBFZdLVrwSbqtB4qjhXcWZ55Jpx7uI4Bc3Wb1RCjqYpkuYrkN/iTZeNmWuUmfBPoTK45FLJcBhz0JjyXLp3aVotndYutfARf8SqDEGo2wiGOHz7pYyOXCC1GZgX0JgCiBH/el9rPzmxOWPMDDVmcioI3fTPnBSRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ8X+MzO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ8X+MzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0213BC4CEE7;
	Wed, 18 Jun 2025 20:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750277722;
	bh=sNt9429eGPeOWndMcJFi2UGRKkLdSlf+4k/V6ObPk2I=;
	h=Date:From:To:Cc:Subject:From;
	b=FZ8X+MzOwOsK47sBsw38cw7DSX99G1u0Ah3KSmsMGtIMxNJ+d6tb6OP3W5zTzQ3CD
	 ir4Xoy1RXNEJsrFt10KpLROG18LHZHQDSFovqkRX6UvyXvieWo9q7mFViy3utaYcEJ
	 CH1cEqgLDCnkNauw3BLQjY9bu25hPjes/CPtA6YZBqlh1njKdlSlnDOS1kgGdnVhJM
	 TjHuE9A0lIKsmJdSvstBD07KgIecn4qvqBySWo8C9eVJlKMbfoHRaD43Ojrti7JGr8
	 RkvZvYbwqohFRmD/IT2I6ZWAZCa8ihgYrMhsBZoHQBGKWzisJqZVt7aOkdlBwZsT84
	 O9fC4VU1FhmSQ==
Date: Wed, 18 Jun 2025 10:15:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: [GIT PULL] sched_ext: Fixes for v6.16-rc2
Message-ID: <aFMeWOF5bCp2D3s9@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 488ef3560196ee10fc1c5547e1574a87068c3494:

  KEYS: Invert FINAL_PUT bit (2025-06-11 11:57:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.16-rc2-fixes

for you to fetch changes up to 33796b91871ad4010c8188372dd1faf97cf0f1c0:

  sched_ext, sched/core: Don't call scx_group_set_weight() prematurely from sched_create_group() (2025-06-17 08:19:55 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.16-rc2

- Fix a couple bugs in cgroup cpu.weight support.

- Add the new sched-ext@lists.linux.dev to MAINTAINERS.

----------------------------------------------------------------
Tejun Heo (3):
      sched_ext: Update mailing list entry in MAINTAINERS
      sched_ext: Make scx_group_set_weight() always update tg->scx.weight
      sched_ext, sched/core: Don't call scx_group_set_weight() prematurely from sched_create_group()

 MAINTAINERS         |  2 +-
 kernel/sched/core.c |  4 ++--
 kernel/sched/ext.c  | 17 +++++++++++------
 kernel/sched/ext.h  |  2 ++
 4 files changed, 16 insertions(+), 9 deletions(-)

-- 
tejun
