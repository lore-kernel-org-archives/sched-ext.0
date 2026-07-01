Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4C2417D1;
	Wed,  1 Jul 2026 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938080; cv=none; b=hs3vGABBKM2b/7CBwsdM8g0778AgqmDKZJNRwgA6rHlvywhNGuoJiG+RwsOj4tCjulNmBM5hk2oTQwj6XkNXw4nUl5db7NnrO3mgqUJrJx6HuXGrwCm4HEvIkfc6diojRtYNMGqiz8VU514FrlvO10gSHuiDDme62XpSkdAIhKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938080; c=relaxed/simple;
	bh=n59bZG9KzJIHkkZGMN0e2OyYt1b6MZii7QkHl9gBNkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJnKZHKyvcNe8JkxIEfiBqWvXhI8lBj9fuN+ieiKzGbCB+eHQfmEO0GCzVMIivcICukQbpj5ZShl3HYPGyrbrL4AbdpfPzfzDtczBRrUfbJra3vIklw0jyp7PBS5mq9FBzJT834jCT2eaNl8s4U6DTOJh4ssH3mtW3XflOf/89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTpzTgdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTpzTgdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F751F00A3A;
	Wed,  1 Jul 2026 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782938079;
	bh=RHF8p6+KryizdUhrZg11wUtV3JasmUxtN7Qv2llJ/9Q=;
	h=From:To:Cc:Subject:Date;
	b=JTpzTgdul2A550dx5YM61w85KS47EpK9uK0zE6PVI2rCLO2nVw7UV61DPjr91a2wU
	 EtYGoBia7ZzxxFrkeMHcuGKq2gP7/2xgAMQTKa6uBGd7bpwKbK2ENANdyF4CvnIS8V
	 40OWj1lHY3nVWkhyxOXtnnXNd1XiljPWfWeVWq5gIbD/YC0GENgSdOJtUsQyDSCKhm
	 Mq66JqW/QXoog2484ZB7BL54OkO5FLS+Cu1HzAbwJk4wxuJ2oPJqlS62DcLd46lYmo
	 Vrb46RZBPIPeiwCqjTJFbpVacQMq3iD5ocNlV7sH7no+W9Tx/NyVXBpcVXwEIPnQqa
	 bDIRCrdq4gsQw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v3 sched_ext/for-7.3] sched_ext: Split sub-scheduler implementation into sub.c
Date: Wed,  1 Jul 2026 10:34:34 -1000
Message-ID: <20260701203438.2837392-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v3: Patch 2 also exposes scx_rq_online(), scx_flush_dispatch_buf() and
    scx_kick_cpu() which scx_dispatch_sched() in sub.h calls, so that patch
    4 builds on its own (sashiko AI). Added Andrea's Reviewed-by. Patches
    1, 3 and 4 are otherwise unchanged.

v2: https://lore.kernel.org/all/20260701181046.2490390-1-tj@kernel.org
v1: https://lore.kernel.org/all/20260701031429.1892218-1-tj@kernel.org

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
 kernel/sched/ext/ext.c      | 1122 ++++-------------------------------
 kernel/sched/ext/internal.h |  167 +++++-
 kernel/sched/ext/sub.c      |  668 +++++++++++++++++++++
 kernel/sched/ext/sub.h      |  161 +++++
 5 files changed, 1106 insertions(+), 1014 deletions(-)

Thanks.

--
tejun
