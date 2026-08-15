Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F72C11E6;
	Sat, 15 Aug 2026 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786773069; cv=none; b=rn2S/pWINjjkUyRZWhdYwCrZZk6k/jlnP+aKvKccGp/aWvCuIfbyeuBkkm00w4hjGG+/rGaGYwNJcUAem1SQ70Rf0jWsWzC8eMaWfbApNpeorIycUfAV6n2J3u/ZV1Ry0Io05MZ1DLC2aGSrfRRH/MK7rriECgyFnaqkLO8pybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786773069; c=relaxed/simple;
	bh=NQTb4TL0iGaoP27g0jOHNBugLDLr1ahZbYISNcKjFac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hMG36W7c3uicMZl/FCfhpzSbAxv3GA7IEVmtsQtAQg79O2zqizuTaNhjtTrMUr0bKAQZRTF0UwMywtoCWa+K6RUu0VKxemRixJjMyjpuCQSAc5hDegVML1LZLbbyvW73qUmwtsNwqXP+maSuSzL3jgJ5+fU5S5EV+5BGKplRe8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA3zkICl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA3zkICl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C50E1F000E9;
	Sat, 15 Aug 2026 05:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786773068;
	bh=xbJSltdQ4+zy9WwoYNxjNF1w+eofBJ5AmB+IP5hecWE=;
	h=From:To:Cc:Subject:Date;
	b=EA3zkIClUGjD18fyb6RBoQZOTeduaoQIIX7tU79buDlIQhGYoliCGOImCKar0SBPe
	 /rp4oliI0c3vqDMQqNvGF6Ec1cNVxCg6wfBk+7PqAM9En6jQ/6LBA54hjg0VzakaRM
	 9NyxfJvVqe0B6CC33FdytlQVBvIgHC1kkLrNYsi3IZD4n4KcsxIfXZJ9NChmP2qBkw
	 +siCxMS2W1OniXwBAs9o5TDDcVBAijE3i0w7aMl8ig99vcSzQs5X29pqYe592xFris
	 ynGAzt+Kc1HbU3zOkE83RYDTKNo07ADk2UZf/khPLL+6TdaIOVzOvYK8JZEzz7n6lS
	 6g5ysHrpnlPqA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCHSET sched_ext/for-7.3] sched_ext: Misc fixes
Date: Fri, 14 Aug 2026 19:51:05 -1000
Message-ID: <20260815055107.115671-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Two unrelated small fixes.

 0001-sched_ext-Drop-unlocked-scx_rq_clock_invalidate-from.patch
 0002-sched_ext-Make-scx_bpf_events-read-the-calling-sched.patch

0001 drops the rq clock invalidation in the root disable path which was
performed without holding the rq lock and is redundant anyway. 0002 makes
scx_bpf_events() read the event counters of the scheduler associated with
the calling program instead of always reading the root scheduler's.

diffstat follows.

 kernel/sched/ext/ext.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

The patches are also applied to sched_ext/for-7.3.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git for-7.3

Thanks.

-- 
tejun
