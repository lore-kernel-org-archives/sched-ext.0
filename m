Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AFA33A9FC;
	Tue, 21 Jul 2026 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784673080; cv=none; b=KT8wnyjaldMTd/bVDRy7YZ19w2gVn94b6xUO6Ep9yV/FT7djZ5NoqTDn2ldl5sNqu9BJRcYwOq+OBabwdQBeffAkf1avWGmBLEvJr9xQcB5F/wOmkb3owDjCZ3edVY6OM0lvK7RM3StXg5TR/KsM3+7t7b49cPxVmHRI1RdhqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784673080; c=relaxed/simple;
	bh=CqGue2TtCZ9wVQTq3cu4D2/chXjCJ/Fryin3xYwUyrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdG7Z6qdz08B0BswotNGhlkXjrKPBUeyBoSxoG68/JTBuPpcvvPoZ9OBOCBME3uS7oIIWw34p+HleaiMrJ0yOWkgflFxDQv2kmGMgjsOU+dfGmE7/asV/mAgUxwIf6xcV4Uh0Ub653hWjMJFpwonwNlCVXWiwqReeYnbnGo+9Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeNIpa0F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeNIpa0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5524D1F00A3A;
	Tue, 21 Jul 2026 22:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784673079;
	bh=Jh4IQlq0skUkq7za+aEAw2wyyYshVFxXQZLjTLUktq8=;
	h=From:To:Cc:Subject:Date;
	b=IeNIpa0FnvzM3iI70wijtl6PXrJ4LXLB9TJx1D/yVbl1C/ZC4A19IiFz272umAhiJ
	 aWgSIE50hPRQJU+nWs4Ie6vW4N9Q5JKb6fdffFYUhmPZ3DxccAFlPlXZ4Dq34JX2N0
	 jyYVn/6XFkoDqErJV+ZdDLsr7coIl1TvBj2oHenkzLgL9c3WYcP0dwzeiPhym3P+JR
	 zOlptcLul0bQaqfJbfI8qpChCUI22fYeRAfmh882zS6Bb+/x9J8pfLazIylSkFI6I5
	 BodK9vSKLMFZxqzTgRKQbstFxL2qsOQ79JDRkYpd7qq1TLL5uQ8neYQbFAnQU1Ik3u
	 ClWAb6y4Y/Tzw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Sub-scheduler and cid fixes
Date: Tue, 21 Jul 2026 12:31:14 -1000
Message-ID: <20260721223118.2268529-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v2: v1's 0003 only added NULL checks and, as Andrea and sashiko-bot pointed
    out, left the cid tables readable while being filled and rewritten in
    place. The new 0004 replaces it: each root enable builds a fresh table
    set privately and publishes it with RCU once the layout is final. 0003
    is a new trivial dead code removal. 0001-0002 are unchanged.

v1: https://lore.kernel.org/r/20260720082605.1451945-1-tj@kernel.org

A few fixes for the sub-scheduler and cid-form code on for-7.3.

- 0001 attributes a runnable stall to the scheduler that owns the DSQ the
  task is stuck on rather than the task's owner, so a bypassing sub's task
  parked on an ancestor's bypass DSQ blames the ancestor, not the sub.

- 0002 skips the default CPU selection while bypassing. The pick is discarded
  by the bypass enqueue anyway, and it consults idle masks a scheduler doing
  its own idle tracking leaves frozen.

- 0003 drops the unused scx_cpumask_to_cmask().

- 0004 ties the cid tables' lifetimes to the root sched: built privately on
  enable, published with RCU once final, unpublished and RCU-freed on
  disable.

Based on sched_ext/for-7.3 (b20dfde5ec54).

Tejun Heo (4):
  sched_ext: Blame the DSQ's owning scheduler for a runnable stall
  sched_ext: Skip the default CPU selection while bypassing
  sched_ext: Drop unused scx_cpumask_to_cmask()
  sched_ext: Build the cid tables privately and publish them with RCU

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-fixes-v2

 kernel/sched/ext/cid.c      | 279 ++++++++++++++++++++++++++------------------
 kernel/sched/ext/cid.h      |  58 +++++----
 kernel/sched/ext/ext.c      |  80 ++++++++++---
 kernel/sched/ext/internal.h |   5 +-
 kernel/sched/ext/sub.c      |  42 +++++--
 5 files changed, 298 insertions(+), 166 deletions(-)

--
tejun
