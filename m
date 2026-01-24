Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C0E55C
	for <sched-ext@lists.linux.dev>; Sat, 24 Jan 2026 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769246454; cv=none; b=PJckxJbg+Wcdebk1u6t9O5ZiFIdW5ONDCbkHiPaGwA99wzILmivQj2j9qcXU0eyREP1Sz1iAdiOddvf4+9Y9kknedxv3nmZ1Okrt16JLD2tjsplddXEjm6cot637Heu46Mounf2d4RsH5n8jPZrNV1YWyWMZzvVSqgyJr+jSD1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769246454; c=relaxed/simple;
	bh=4jCaWuby+q75eLXUzGE2JYwbV9Xd6JSl9WJZJjzBjTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VNmns5FsgWuu9TU02gvd0XZy0CyoWJ7wgVUd0YGa7Qb9gA+7yqbc/9YIO6vVqPv0XxD73vRu9Qls6h09Zr/yUG4GnpcirwHhkpNRWU+8e46ct+kFxxu/Z266VGh0BoZObLB8pmvNWIkc67iPdNaUwpArhDOZUtOE9e4a2qlLmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3912E1476;
	Sat, 24 Jan 2026 01:20:44 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.81.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EB0C3F73F;
	Sat, 24 Jan 2026 01:20:49 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org,
	tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	sched-ext@lists.linux.dev,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/2] SCX kick fixes from 6.19
Date: Sat, 24 Jan 2026 09:20:41 +0000
Message-Id: <20260124092043.349976-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

See https://lore.kernel.org/lkml/20251022205629.845930-1-tj@kernel.org/
These apply to linux-6.18.y
The issue also affects 6.12 but that reuires a different backport.

Tejun Heo (2):
  sched_ext: Don't kick CPUs running higher classes
  sched_ext: Fix SCX_KICK_WAIT to work reliably

 kernel/sched/ext.c          | 57 ++++++++++++++++++++++---------------
 kernel/sched/ext_internal.h |  6 ++--
 2 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.34.1

