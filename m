Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7E23EAA1;
	Mon, 27 Oct 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583890; cv=none; b=XkTG/1w0otC6VWoJbFYyqi36MDVkhrRfwW3wvxEgVYlTYL3XeqlDHPHMLWzcqSJ0MJlqZnK7s82aBa57410rkvjk22lKGIQsgAYKWj7zQeduJlC6OjB4rXB6wqEmlNh7tNv5sBr52cbagctSzwo/KXkKCnX4mBofaW86+YRePSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583890; c=relaxed/simple;
	bh=RDmvO9UFbT/B6ZnxOAcif5m6qwax2YE/VP1el5dfD2s=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Se462GQhD8c8OhRpT0SXMFRXZFh421gDFnXl+uEMluayh+J/8GScbnrXj16PzTylrnKXjxvPxcZBiAjWf7CbLjoajm0cx/BSoIrfqhx0v+IHs+DtyMyr7stUYDk/XgewIaE36O/IE7EMNXPR0Pmdm3IezOnI8f3TwqgCV68OaKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHcBwXRl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHcBwXRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B457EC116B1;
	Mon, 27 Oct 2025 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761583889;
	bh=RDmvO9UFbT/B6ZnxOAcif5m6qwax2YE/VP1el5dfD2s=;
	h=Date:From:To:Cc:Subject:From;
	b=LHcBwXRlsqB147SUjBMBJ3NDFAUmkpoke1OLpDYwvBTYN9aU2rZWJphsiHxxpuNBl
	 teRo3FsapkRVW2TbnkH1MsMLUX1ML6SoBoHAX8mSIfbDh16RAw99Q3Mh4royUGsMEO
	 sPdvHXyFPLlf3ZHx0mwLglCuUjODxMmJ9/Fs36TuPxDStXX8cAs5Ck+Wj2fXH+3nTx
	 MoZfwqGPnzHH28rc0I7lRnhUKBrV2nrwDa3JYKB1Hc+6w1XWFRfpNTTvsk5ij2/0bV
	 yNIDx77b2kLwY4MrRygsKCOp7/RZK1ktpjmWvJLuS1NLOKNHicjZE+veYroHcnSBtd
	 1DziWintaegHw==
Date: Mon, 27 Oct 2025 06:51:28 -1000
Message-ID: <36450bebbc782be498d762fcbcd99451@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Subject: [GIT PULL] sched_ext: Fixes for v6.18-rc3
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi Linus,

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.18-rc3-fixes

for you to fetch changes up to a3c4a0a42e61aad1056a3d33fd603c1ae66d4288:

  sched_ext: fix flag check for deferred callbacks (2025-10-16 08:34:00 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.18-rc3

- Fix scx_kick_pseqs corruption when multiple schedulers are loaded
  concurrently

- Allocate scx_kick_cpus_pnt_seqs lazily using kvzalloc() to handle systems
  with large CPU counts

- Defer queue_balance_callback() until after ops.dispatch to fix callback
  ordering issues

- Sync error_irq_work before freeing scx_sched to prevent use-after-free

- Mark scx_bpf_dsq_move_set_[slice|vtime]() with KF_RCU for proper RCU
  protection

- Fix flag check for deferred callbacks

----------------------------------------------------------------
Andrea Righi (1):
      sched_ext: Fix scx_kick_pseqs corruption on concurrent scheduler loads

Emil Tsalapatis (2):
      sched_ext: defer queue_balance_callback() until after ops.dispatch
      sched_ext: fix flag check for deferred callbacks

Tejun Heo (3):
      sched_ext: Mark scx_bpf_dsq_move_set_[slice|vtime]() with KF_RCU
      sched_ext: Sync error_irq_work before freeing scx_sched
      sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using kvzalloc()

 kernel/sched/ext.c   | 126 +++++++++++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |   1 +
 2 files changed, 112 insertions(+), 15 deletions(-)

Thanks.

--
tejun
