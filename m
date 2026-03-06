Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A7353ED9;
	Fri,  6 Mar 2026 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823984; cv=none; b=tdUEAWohzJF4jOK59zg96/0MiW5slFmJv7btGDrGvkn64IoQR8PtEXm5aEzvWDhSSpF0Jk0luK24GyJgf0e96xmt4150hJQOOYHKBYWlA9aJeJMs/2XSigcW0BgsvrLEvv9rgMlyuSEObuWPmXCAnGfZ0qNT5Km50sfJQVjJZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823984; c=relaxed/simple;
	bh=8XldS5X3wNC40/5ODBNdAWGvc3NKPnpaz4Tt9so8PRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mdwi/eIO0nGmhHADdZzOfkv/Whi9u+NF8VlRFjH85IutqcPeOjz5p1EAF6I8PcB5fk7lYWL/jfz4Ydggzt+67SuqSJatwE8kDZ/ksIW5qXOPFJy4xhLApvdzUDkDKC7NhTUFHkcfw2MqVoiQYcEB01UAMxgAkpylS4X+JLPK71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqFEGt29; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqFEGt29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E269C4CEF7;
	Fri,  6 Mar 2026 19:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823984;
	bh=8XldS5X3wNC40/5ODBNdAWGvc3NKPnpaz4Tt9so8PRQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lqFEGt29+J40dtAEgrMSZCxnYUIM4k0uH/ZqsO5mQc2onoyCw59LdWLScmi5UdChT
	 et5Aq1wUSFIVPC6LLJxuPiZzYBjHV5RaWJq6pNPfEiwj8jp1XTPfM8h8hgQnR7+9Wa
	 2hSj42ZZBLbEKPmnKSuxy4RCO1lf5OVgCl9V6lI57XFpMtR3OKiSzr7zk83jpNXfDf
	 UIDFUfnp+MsxBtOmz05s1YvXOkuEtZLO6UKdYfX/3p+m9X+fsS67I7vUc7f9655w4W
	 k/EbQW8WItJsxt4kHamQ3arkMicA3toqeGpgpNtUL/B9iq2emGjH0CKmCFTp/XXrXR
	 fQNmAHStkCC/Q==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.1] sched_ext: Overhaul DSQ reenqueue infrastructure
Date: Fri,  6 Mar 2026 09:06:08 -1000
Message-ID: <20260306190623.1076074-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_reenqueue_local() currently only supports the current CPU's local
DSQ and must be called from ops.cpu_release(). This patchset overhauls the
reenqueue infrastructure to support flexible, remote, and user DSQ reenqueue
operations through the new scx_bpf_dsq_reenq() kfunc.

The patchset:

- Refactors per-node data structures and DSQ lookup helpers as preparation.

- Converts the deferred reenqueue mechanism from lockless llist to a
  spinlock-protected regular list to support more complex list operations.

- Introduces scx_bpf_dsq_reenq() which can target any local DSQ including
  remote CPUs via SCX_DSQ_LOCAL_ON | cpu, and user-defined DSQs.

- Adds per-CPU data to DSQs and cursor-based iteration helpers to support
  user DSQ reenqueue with proper multi-rq locking.

- Adds reenqueue flags plumbing and a lockless fast-path optimization.

- Simplifies task state handling and adds SCX_TASK_REENQ_REASON flags so BPF
  schedulers can distinguish why a task is being reenqueued.

scx_bpf_reenqueue_local() is reimplemented as a wrapper around
scx_bpf_dsq_reenq(SCX_DSQ_LOCAL, 0) and may be deprecated in the future.

Based on sched_ext/for-7.1 (4f8b122848db).

Tejun Heo (15):
  sched_ext: Relocate scx_bpf_task_cgroup() and its BTF_ID to the end of kfunc section
  sched_ext: Wrap global DSQs in per-node structure
  sched_ext: Factor out pnode allocation and deallocation into helpers
  sched_ext: Change find_global_dsq() to take CPU number instead of task
  sched_ext: Relocate reenq_local() and run_deferred()
  sched_ext: Convert deferred_reenq_locals from llist to regular list
  sched_ext: Wrap deferred_reenq_local_node into a struct
  sched_ext: Introduce scx_bpf_dsq_reenq() for remote local DSQ reenqueue
  sched_ext: Add reenq_flags plumbing to scx_bpf_dsq_reenq()
  sched_ext: Add per-CPU data to DSQs
  sched_ext: Factor out nldsq_cursor_next_task() and nldsq_cursor_lost_task()
  sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs
  sched_ext: Optimize schedule_dsq_reenq() with lockless fast path
  sched_ext: Simplify task state handling
  sched_ext: Add SCX_TASK_REENQ_REASON flags

Git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-reenq

 include/linux/sched/ext.h                |  58 +-
 kernel/sched/ext.c                       | 882 ++++++++++++++++++++++---------
 kernel/sched/ext_internal.h              |  32 +-
 kernel/sched/sched.h                     |   4 +-
 tools/sched_ext/include/scx/compat.bpf.h |  21 +
 tools/sched_ext/scx_qmap.bpf.c           |  68 ++-
 tools/sched_ext/scx_qmap.c               |   5 +-
 7 files changed, 777 insertions(+), 293 deletions(-)

--
tejun
