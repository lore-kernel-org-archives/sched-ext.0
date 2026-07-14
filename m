Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7509423EB1;
	Tue, 14 Jul 2026 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070563; cv=none; b=RDIle8fmtN31F6B82mswan5CMJw0iLqA3yEomr3ldW+fT8mtZt9JE/xobEfOhNju6oJZlArd3coF1DXULSPVbp6oy+WOdwkT4ypQI39Ubj+UX+RMN0N1MGswlC1OwNbAEt4N7nwCizZ+COe+tjHCizmpKVEs/7o+UYBzdrC86pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070563; c=relaxed/simple;
	bh=eDl2u4mSnBMrfo9Ku6RUmPXpozn4hi4QVjnJhAjQRkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edGS3G/uxNgo49QOXnsl/HTl9pIgpMi0W6a51z85AjSYGLVqcm8+NYvDkK0Xdn60WupxHicRr6Cno6t/UeZyNcFP1njN4aP86p2tNRq0sILfG4Qe+VocO+9C6IJgLPKqkUisXSRx7MQtBfp3ZBVQAH6g1s59YrAll9k7C+QlG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+4wLL3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+4wLL3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4D91F00A3D;
	Tue, 14 Jul 2026 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784070558;
	bh=5XioZJ3Vvyz6YEC4Z7TmKQX8/ZnUM0B/BzFPOGnM4P8=;
	h=From:To:Cc:Subject:Date;
	b=a+4wLL3Grmy2OrJti7pMnq/XKv9wM834VPbKyZjQApz+HGtszzYEJji58GKsqPtn6
	 mIvsLdCzlgnY8KshjNNEFWLEaiVcbi3BT5ikNnVIwnnPur5cAUNR7LAySBm1hWxkhS
	 ZmyPydH8PnyBDtRuDqUSnq643ePEAfwumk9t+VrXzhgIE51JOlhSBB2/dXSaXPDoxJ
	 N4CG2l6PIeDf2MCFEzOebzNtwSYUjUcl79OcdfDLGxCWuVNkRGkCBT98BJ5XW/TPqM
	 CiSyUxfmebLO4FtbBYXNpppNqTylfW9YhvzQkp66fxBCq3GCcGHM9YH2ECeV1SPjZm
	 SsbfVm6+9kqtA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.3] sched_ext: Sub-scheduler follow-ups
Date: Tue, 14 Jul 2026 13:09:13 -1000
Message-ID: <20260714230917.84158-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Follow-ups to the sub-scheduler capability series, addressing two things
Andrea raised while reviewing v5[1]: sched teardown drained queued ecaps
syncs with an msleep() poll loop, and with CONFIG_EXT_SUB_SCHED=y hot paths
keep paying for sub-sched bookkeeping even when no sub-scheduler exists.

Patch 0001 replaces the teardown poll loop with direct removal from the
llist. Patches 0002-0003 are prep and 0004 adds the scx_has_subs static key
and gates the sub-sched portions of hot paths on it.

[1] https://lore.kernel.org/r/20260709225041.1695495-1-tj@kernel.org

Based on sched_ext/for-7.3 (35f9cbbacb67).

This patchset contains the following 4 patches.

 0001 sched_ext: Remove queued ecaps syncs directly on sched teardown
 0002 sched_ext: Move scx_dispatch_sched() from sub.h to internal.h
 0003 sched_ext: Gate sub_dispatch_prev with CONFIG_EXT_SUB_SCHED
 0004 sched_ext: Add the scx_has_subs static key and gate sub-sched hot paths

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-followups

diffstat follows. Thanks.

 kernel/sched/ext/ext.c      |   6 +-
 kernel/sched/ext/idle.c     |  10 ++++
 kernel/sched/ext/internal.h | 133 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/ext/sub.c      |  88 ++++++++++++++++++++---------
 kernel/sched/ext/sub.h      | 124 +++++------------------------------------
 kernel/sched/sched.h        |   3 +-
 6 files changed, 223 insertions(+), 141 deletions(-)

--
tejun
