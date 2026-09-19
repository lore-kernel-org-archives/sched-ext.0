Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B72D73BC;
	Sat, 19 Sep 2026 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777721; cv=none; b=BGKoqKoCrSWdgd4ys3EZX9+q9bmYSqM1wRytN4Ibl8C68rDVgjlipGnE8Z7cv6rIXGE7QCjYVrFDWwO/beC5r83VkN2JmZHipnViSe7sluj9IDTDdQeUZ1MEA/MFHkzVBAmfpr2h7WnkmrgOi5+OlYkKmKfhPsEfgHwTWMbNIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777721; c=relaxed/simple;
	bh=NPhS6b/3OFnsU4hW52/5sI5NbHoH+zIu0EoUS+gFwDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2pUuhyS2CcJhEzmIDtSJI8DqYcdYjDiclBN2P5xyVccgIfm81g1iRabJBDt0kbhKH0AtnG2VotdtIqovX/UagRM0DVH2/OqhcsoTjWetIKP0H1sPPKbuj7JDTeoq8Fg198X8Fiawrr4Vz/k9i9EBkQUz4pxg+MHXmsYiKqVj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ9JPzQ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ9JPzQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E8E1F000FF;
	Sat, 19 Sep 2026 00:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777719;
	bh=PDPp9ZP5Uvi72gaCYPTxVQwcY01IJEbDkyiPNTzzEjU=;
	h=From:To:Cc:Subject:Date;
	b=PQ9JPzQ+Vl0GPm9AbrqX4jr9Rfukshm/VDoElkzU3WSaHBw6xb8Gfku94N8pQiakm
	 QTFFH9uKGDmLJNwP3jYbNm1G7Rud7MZC1Wrb1AzG07RdZNuALnaBbLQYB4XjsmY29R
	 25mPkm1S5n4FynB8U7b8Gu3k/vXDKYlKONPLEKjc9//8pHjovP3siz84Mt9WJPSQyT
	 SbRSlO1HBbykgYCaps7UoHJ6h9BtAC7TS0B5vOgmoMR8Dftq9fYlo03xmUk6QT2oI+
	 FvQqfV0r3Q32hy0S2eWfQDUq2YMYUdxqNj6t8+LRYq/3DDIhoulnaY+fPSzFueZAUU
	 a2y0nvbyeCx/Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v3 sched_ext/for-7.3-fixes] sched_ext: Pass the initial cmask to cid-form ops.enable()
Date: Fri, 18 Sep 2026 14:28:36 -1000
Message-ID: <20260919002838.1960071-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v3: - The initial set_cmask() is delivered before set_weight() so that the
      mask is in place when weight-dependent state is derived (Andrea Righi).
    - Added a selftest checking the cmask enable() receives, the set_cmask()
      that follows it and their ordering (Andrea Righi).

v2: https://lore.kernel.org/r/2f0eb5c762d55edba5365f1006dbb395@kernel.org
v1: https://lore.kernel.org/r/c8343c2e457508a6cd3fcab66b0823b6@kernel.org

A cid-form scheduler has no p->cpus_ptr equivalent to read. A task's cid
mask is only visible through ops.set_cmask(), which doesn't fire when a task
enters a scheduler through fork, sub-sched enable or re-home, so schedulers
seed the mask from p->cpus_ptr in ops.init_task(), and that seed goes stale
when affinity changes between init_task() and enable().

The first patch passes the initial cmask to cid-form ops.enable() through a
new args struct and has set_cmask() repeat it right after, so a scheduler can
track affinity in set_cmask() alone. The second adds a selftest for it.

Verified by building the kernel, tools/sched_ext and the selftests. The new
selftest passes on a 16-CPU VM, standalone three times and inside the full
sched_ext suite. scx_qmap ran under fork churn with a throwaway enable()
check comparing the delivered mask against p->cpus_ptr on about 55k enables
with no mismatch.

Based on sched_ext/for-7.3-fixes (9ec7ba20c97d).

This patchset contains the following 2 patches.

 0001 sched_ext: Pass the initial cmask to cid-form ops.enable()
 0002 selftests/sched_ext: Check the cmask cid-form ops.enable() receives

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git cid-enable-args-v3

diffstat follows. Thanks.

 kernel/sched/ext/ext.c                               |  92 ++++++++++++++-------
 kernel/sched/ext/internal.h                          |  56 +++++++++++--
 tools/sched_ext/scx_qmap.bpf.c                       |   3 -
 tools/testing/selftests/sched_ext/Makefile           |   1 +
 tools/testing/selftests/sched_ext/enable_cmask.bpf.c | 213 +++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/sched_ext/enable_cmask.c     | 138 ++++++++++++++++++++++++++++++++
 6 files changed, 462 insertions(+), 41 deletions(-)

--
tejun
