Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E266137F754
	for <sched-ext@lists.linux.dev>; Thu, 29 Jan 2026 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678755; cv=none; b=RubbKjhkBfNA5Ewwg0YhCtjGA3XMMP/fr8VDQQf2nFxYHJL/9qTMXFoUHuGHdK5U3f/kRKQinNYqb392sfeCCWWyVAusGFo9zDdkGPuy6g494WKVcf+1oX1qIJZVljyv9GXY6XSuI9q9zH3jOWaJrZZ8mRJAa+DKxtPXjLlGx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678755; c=relaxed/simple;
	bh=juhwcs64IHANHUUHqUh4B8ZIL7sNHsuVp86/J3Ce36Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I0oyyhhutBWdTwMCNTrL2PWQl2SK7NTvdJy5i+a0Ln+YqZ7/sSAFce/YJFplKJJlqhyg2M1iET01bNvGodCO4mmI8mLSiyt8P3voVpnPXs1UederKwo3sNkJmTuuoY5DtSSKPHGZ1fyX5oyZdNf866KVMco1BcWib3O6hUuekYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4B451516;
	Thu, 29 Jan 2026 01:25:46 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.33.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F343C3F73F;
	Thu, 29 Jan 2026 01:25:51 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org,
	tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	sched-ext@lists.linux.dev,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCHv2 0/2] SCX kick fixes from 6.19
Date: Thu, 29 Jan 2026 09:25:44 +0000
Message-Id: <20260129092546.49128-1-christian.loehle@arm.com>
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

v2:
- Add the sign-off, no other changes

Tejun Heo (2):
  sched_ext: Don't kick CPUs running higher classes
  sched_ext: Fix SCX_KICK_WAIT to work reliably

 kernel/sched/ext.c          | 57 ++++++++++++++++++++++---------------
 kernel/sched/ext_internal.h |  6 ++--
 2 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.34.1

