Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D471C3CCFDE;
	Mon, 20 Jul 2026 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535967; cv=none; b=IEwWzJKKRNM/xVj26knkvN5MABmg9gPonltUwtpsmYAuRwKEDNXLYZS6aQYC7TgyN/+e7i3aNZYKNOpkJ8A+Iek+Qw64XwAjy4WTW23lUjtaSZ0+gOfBOJDay0FIUGLGpTuIq2ApCmstoqcVvT2ZQFaexeukMdnRcxAq28aEIJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535967; c=relaxed/simple;
	bh=aY35KR/EhdepAOr/J5zdQTUsGvH9YuojLeRqDFpXyIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQBhd8SvR151e+ssbFUirrNn8xTthPYEs8NeucLxjY6ZG/g2Iv8jt0PNh8oQODtHBQXDe/0j0iwhvlh+/GOMYECZo2gjMHxrwDmfHO6z3x7c+8aKh+y1AlyDTrxrO20wiGJrKEdMyXrpwtqu0gi4XhmlPJTduVqWvz9LBiJ8uKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu2yuxcX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu2yuxcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FEE1F000E9;
	Mon, 20 Jul 2026 08:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784535966;
	bh=9n5bds31+k4gl+d3k7Dt+gFIFbcKkf0LeSZzY1vQQek=;
	h=From:To:Cc:Subject:Date;
	b=Qu2yuxcXiJ9OzUzHIXWhZv1AzR+3Bu+AErV2Ahlr7RQ9PfQJ3fRLzEsgjCbovL8Uz
	 YUZ39o7cFCScHnMYxI2yD+VfecVdjsK31tZ/9hOFzAQLD+0+44gVAdq1pX5Ex5B4qH
	 XhHDn4BxXzPKC9nwmYhKmI9re5xS5jhsK0y4wNXECJqBoef2dXiuTtX+ocNrwbl8YN
	 hEsmmfeOXKwVS6iXOIDOi5pf0+vO7YN3o/dlrI/c9ubJHO+cb2Am28IpiE0UXfzls9
	 tu8AMHnGyvs3QKdMvXVXyY6m/RtLrRyfBqoKDwBrkccETgBoc/xgw6EDASp/J3BbDU
	 jQO3KOiryGQ8g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.3] sched_ext: Sub-scheduler and cid fixes
Date: Sun, 19 Jul 2026 22:26:02 -1000
Message-ID: <20260720082605.1451945-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

A few fixes for the sub-scheduler and cid-form code on for-7.3.

- 0001 attributes a runnable stall to the scheduler that owns the DSQ the
  task is stuck on rather than the task's owner, so a bypassing sub's task
  parked on an ancestor's bypass DSQ blames the ancestor, not the sub.

- 0002 skips the default CPU selection while bypassing. The pick is discarded
  by the bypass enqueue anyway, and it consults idle masks a scheduler doing
  its own idle tracking leaves frozen.

- 0003 guards the cid kfuncs against the cid tables not being allocated yet,
  which a program can hit while racing the first scheduler enable.

Based on sched_ext/for-7.3 (b20dfde5ec54).

Tejun Heo (3):
  sched_ext: Blame the DSQ's owning scheduler for a runnable stall
  sched_ext: Skip the default CPU selection while bypassing
  sched_ext: Guard the cid kfuncs against unallocated cid tables

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-fixes

 kernel/sched/ext/cid.c |  5 +++--
 kernel/sched/ext/cid.h | 23 +++++++++++++++--------
 kernel/sched/ext/ext.c | 26 ++++++++++++++++++++++++--
 3 files changed, 42 insertions(+), 12 deletions(-)

--
tejun
