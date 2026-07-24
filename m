Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B85FC0A;
	Fri, 24 Jul 2026 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856557; cv=none; b=Ukl5suTkD5kHRzxU/fGymSqM0GbuEwNmYmIUcEjXnaGUCECT2hgM2wYncO/8hr0YkJ2GLxG18XKhAqSAr8T2pRWPes39qWJCFy3Sd1JKH3IJ9IIAbPU3T++ErpPuisfBQMupqsQNN8QnksQkO7e490kP9E3Q8CVjDuJxUAw5u2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856557; c=relaxed/simple;
	bh=QU2VjKGBaZgrmXbHi/IcuUZ3cL3QxHVoG+NLuSuV+sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oeS9e0UW4QWrQqTVzgzLsfB94vCOKpPZ4q4nvm9LYRonk08pz7ggsGZSwV35blTACuO7kcrAZ9s5XSu7JUuhLaFgkKmxCXiv6h4wjiO3fcFiL/q/NDqD5qFNdyj7ay0Kh0aBkl697ndlUBwbnXrn02/fbXCkH6amT3F/tBj7vBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROTG04li; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROTG04li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA261F000E9;
	Fri, 24 Jul 2026 01:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856555;
	bh=idt1F1uzF9bu0m/BxspDJtbKZKt5cbIB9VZuQMT/+bI=;
	h=From:To:Cc:Subject:Date;
	b=ROTG04liFsfPVoN6bC6x3mxxBF7vPU+v3ynwC1cgLMShpHVUlpDuoPiU45ZllQbaA
	 CuboqAoz6Aj7dCpT897ZtvsLEym5AXYBcG1Y1aIfSYKcQTigYHVVsvOXEqP5IucKPR
	 w+HkHnb+okY5hOTws33aZwo0gAF83dINOMTWkE+XoY3N6aSJSbVL3YltT5SpHf7osy
	 kX64JVh9P8nc1ZCwuJbxOknpq/DIUwbT48juBVrU6MfXPTtRqSa0w9jwPdx9sdCrWp
	 aGW7Pfb3uDAp65j/9b2C/T79se07gn8p+iJ6za3CVFDNcIdVbCbXLFMqbiQQ896wA8
	 DaYAMjoiSH0VA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.3] sched_ext: Sparse annotation cleanups
Date: Thu, 23 Jul 2026 15:29:11 -1000
Message-ID: <20260724012914.107823-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

A sparse sweep of kernel/sched/ext flagged the __rcu pointers that are
read with plain loads. The reads are all protected by their calling
contexts but didn't state how. Add accessors that encode the protection
and convert the readers:

- cgrp->scx_sched readers go through the new scx_cgroup_sched() which
  states the locks that stabilize the association (0001).

- The naked scx_root accesses are resolved through the sched at hand or
  through new accessors that state the protection. One transitional
  marker remains (0002).

- The dsq->first_task identity comparison uses rcu_access_pointer()
  (0003).

What remains in the sparse output on kernel/sched/ext is the BPF kfunc
declaration noise shared with the rest of the tree, the rq->curr and
rq->donor accesses shared with the core scheduler, and the deliberately
naked scx_root access in touch_core_sched_dispatch() to be resolved
separately.

Based on sched_ext/for-7.3 (94ca9591108a).

Tejun Heo (3):
  sched_ext: Add scx_cgroup_sched() for cgrp->scx_sched reads
  sched_ext: Resolve most remaining scx_root accesses
  sched_ext: Use rcu_access_pointer() for the first_task comparison

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sparse-cleanups

 kernel/sched/ext/ext.c      | 20 ++++++++++----------
 kernel/sched/ext/idle.c     | 15 +++++++--------
 kernel/sched/ext/internal.h | 27 +++++++++++++++++++++++++++
 kernel/sched/ext/sub.c      | 33 +++++++++++++++++++--------------
 kernel/sched/ext/sub.h      | 14 ++++++++++++++
 5 files changed, 77 insertions(+), 32 deletions(-)

--
tejun
