Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5514E191F98;
	Sat,  7 Mar 2026 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843299; cv=none; b=NuceJ59NGJtRA4w7cj7WfeNkjUN5Od+WqXzTr28uxSHEwCqMJ14XrW04mJRfX58Kr8ieBvOFidq44bF0PU3Gz/mhrpA/7xaY8ZKDZgfMJ674Wb2E6YNB5GkgEj74esayvxDVdKsM8JhadOoo6eE2ztctJqmLafvPh1byhA3xJqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843299; c=relaxed/simple;
	bh=62J/+zN5REtrjq/LC1pIqtJ8l/XjaLyxLvF7fwry5jU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYQNIm1iqi4h2i2mr7O5DAXTEgOnkd2glBaZJaU9LVoYdedojReRiEk+mXhTjkw01HYH6nLR80wLUh7/bkh1bK8r0x6MmSD0UU7TY18nLe61yK+ulVl5v8++95AAfMEb7VIuOcIx5Nb4rnhxpOFQThxygpgSN/apKphb87oAkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjSdZEaX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjSdZEaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA090C4CEF7;
	Sat,  7 Mar 2026 00:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772843299;
	bh=62J/+zN5REtrjq/LC1pIqtJ8l/XjaLyxLvF7fwry5jU=;
	h=From:To:Cc:Subject:Date:From;
	b=kjSdZEaXeYwuVvbcx02bKdYFcPUcA3lJU1l7CZJuQIljsL3FosmvlAlLjHS/n8CTi
	 FMD0OwKT4GnFfottFglrtkR/rlKAlnDgyz+fcH5OyIlulEkzGZ5rTsvx8OK9ovgS1+
	 QB00Uw0fFfz2aL/j9VlwCRb0t0Hq27egGTm0zdtOGFSFhlL2UArDaCuFazh4/jDFcF
	 sFo2Rjwtu1pkI0GrihNUT6jEHGGuqTpcCshSp/vkHQ82uQsaMM0xcT5xY0QZkb5VDF
	 9dOMfZoHeWBcGT2Zgi7hBFaub7y/IBTCLE6OXLqMzkE/XljHQG0yo66SdZ6vyGDxqf
	 yZH5HW6aKDuFQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.1] sched_ext: Implement SCX_ENQ_IMMED
Date: Fri,  6 Mar 2026 14:28:14 -1000
Message-ID: <20260307002817.1298341-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

SCX_ENQ_IMMED makes enqueue to local DSQs succeed only if the task can
start running immediately - the current task is done and no other tasks are
waiting. If the condition isn't met, the task is re-enqueued through
ops.enqueue(). This gives the BPF scheduler tighter control over when tasks
actually land on a CPU.

- Patch 1 disallows setting slice to zero via scx_bpf_task_set_slice() as
  zero slice is used by ENQ_IMMED to detect whether the current task is
  done.

- Patch 2 implements SCX_ENQ_IMMED with reenqueue support and loop
  detection.

- Patch 3 adds SCX_OPS_ALWAYS_ENQ_IMMED ops flag to automatically apply
  IMMED to all local DSQ enqueues.

This patchset depends on:

- "sched_ext: Overhaul DSQ reenqueue infrastructure"
  http://lkml.kernel.org/r/20260306190623.1076074-1-tj@kernel.org

Based on sched_ext/for-7.1 (4f8b122848db) + scx-reenq (a41719e6ae12).

 0001-sched_ext-Disallow-setting-slice-to-zero-via-scx_bpf.patch
 0002-sched_ext-Implement-SCX_ENQ_IMMED.patch
 0003-sched_ext-Add-SCX_OPS_ALWAYS_ENQ_IMMED-ops-flag.patch

Git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-enq-immed

 include/linux/sched/ext.h            |   3 +
 kernel/sched/ext.c                   | 208 +++++++++++++++++++++++++++++++----
 kernel/sched/ext_internal.h          |  43 ++++++++
 kernel/sched/sched.h                 |   2 +
 tools/sched_ext/include/scx/compat.h |   1 +
 tools/sched_ext/scx_qmap.bpf.c       |   7 +-
 tools/sched_ext/scx_qmap.c           |   9 +-
 7 files changed, 250 insertions(+), 23 deletions(-)

--
tejun
