Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3E53B1B3;
	Sat, 25 Jul 2026 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784940621; cv=none; b=Y4wWgX84zMqTMb9fN1T0ETUYHY/QuRn+lteFOVwHbIgD3WTbv2VwKazLkkr4Fp/ZdEoTMCM+nRIktI+i0PF4OunxFqihUBuEEQPNQjuohi7mXjsTHLFR/n0nIH7nWQbOU0x0FtEE/te04valFHFx8H1K6eo1qRSVGV9QrcfRuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784940621; c=relaxed/simple;
	bh=ld87uaY+egWkfkkLHl1JkxgvXb2wzQut6qT6ardIvqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cnws28I+8B8K+FL9ILHhvNTYUwJ4bqDFZRbbdPNnh1SQgs0SQaPWfHVIOYGfvJadz454kUepcja6mNJ3XxXhDucTB51cCmU1fz4q6lD6fAPensyjlBk9rF/VOqpWxsSkiMLEpL0xvYNCe9umLpKeP+zi9Fm87tE3a5vaF1Z+Jmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwNn6hHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwNn6hHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85DF1F000E9;
	Sat, 25 Jul 2026 00:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784940620;
	bh=ory22lGDZNuw8HzktCt5NM3f3XCRnJ5+MxcF+Yt+55U=;
	h=From:To:Cc:Subject:Date;
	b=CwNn6hHWdgZlIsL8L3ZFBnxDD+Bh71hfmItLkE2CQEc5rcUN9Mm0GM2DiSJ0NrQdk
	 tTaLviWRaQxNCysM5eePrbazids5SPQoZ8Ipy3TWnGhXSdklY2ucNW3iPNvHi0mGaG
	 AfxaHyoeHgmvjybf+/WQIQtqvoinIbHfjhdLoVZG2+U5fr4LBZcohushpPWY+UIDXq
	 7M1WogcFTNJ9bS136nuQEytlLoESjPud0tvOJl4VZ7pldyJCqyJVr7vs6/fW0l73uV
	 yR3XXg1/42f4DuVZB9+wNrq0NjAOQj37aQftc1bU9IjldQjIBcRjN6ggfWtqN7wcwZ
	 RmPhvXMAzO0WQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.3] sched_ext: NMI-safe exit handling
Date: Fri, 24 Jul 2026 14:50:14 -1000
Message-ID: <20260725005019.1297049-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The exit paths weren't NMI-safe: exit claiming walked the sub-scheduler
hierarchy under scx_sched_lock and the bstr exit kfuncs formatted their
messages into a shared buffer under a raw spinlock. Kfuncs in the "any"
category are callable from tracing progs that can attach to functions
running in NMI, and many of them raise scx_error() on invalid inputs, so
an unlucky bad argument from such a prog could deadlock the machine. The
hardlockup handler had the same problem and deferred its abort to an
irq_work, which can't even run on the CPU that detected the lockup.

This series makes exit handling NMI-safe end to end:

 0001 makes exit claiming lock-free: ->aborting is asserted with a
      synchronous lockless sweep and the locked SCX_EXIT_PARENT
      propagation is deferred to an irq_work.

 0002 reverses the bstr exit sequence to claim-first so the message is
      formatted directly into the winner-owned exit_info buffer. With
      these two, scx_bpf_error() and scx_bpf_exit() are safe from any
      context including NMI.

 0003-0005 apply the newly-possible direct error reporting: NMI kicks
      abort the scheduler instead of being silently dropped, the
      hardlockup handler aborts directly from NMI making self-detected
      lockups recoverable, and scx_link_sched() reports failures inline.

 0001-sched_ext-Make-exit-claiming-lock-free.patch
 0002-sched_ext-Format-bstr-exit-messages-after-claiming-t.patch
 0003-sched_ext-Report-NMI-kicks-with-scx_error.patch
 0004-sched_ext-Abort-directly-from-the-hardlockup-handler.patch
 0005-sched_ext-Report-scx_link_sched-failures-inline.patch

Based on sched_ext/for-7.3 (3a21e34eb258).

The patches are also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-exit-nmi

diffstat follows. Thanks.

 kernel/sched/ext/ext.c      | 259 ++++++++++++++++++++++++--------------------
 kernel/sched/ext/internal.h |  10 +-
 kernel/sched/ext/sub.c      |  19 ++--
 3 files changed, 156 insertions(+), 132 deletions(-)

--
tejun
