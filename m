Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186E3C3439;
	Wed, 15 Jul 2026 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159496; cv=none; b=eAHTWgtKouoQxvkA5KQWLH7RaIe5Y7Wx5vp0XnNT54V86hXZc3FQ8Uo39o5daAj9wI5TRHJg/mRIv08RT98RRaTnPEx81zjQoJewjrrEIS/wimlld6/GrCwSvuAkZnYyQM23YSmwR6/E3uT4oQgiKnQSMhFLClnzIxCQQlm5qoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159496; c=relaxed/simple;
	bh=fl6mQ+JfnEBn5S4YLXZoNhv/udFB2ZQ9F45lyYPqzk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ewnjfXpKZbex0jKdjeBxgOYJbp2Fyb4sIkRzM5fXAabsvl/yYz0MF0ahj9ybRvYEuejOeeTDqDAwZbo3wf5Fy3SoAiOjjbdr2kjr/C7UJl1jcIn6kfoEVVFxzL4Da5t6267mOEO5sX5tukmNnztFHmSGwZg28I3bifzJaUw70vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEj5QVXk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEj5QVXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867B01F000E9;
	Wed, 15 Jul 2026 23:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159494;
	bh=MofuVK3NiwXs9ZtgKGTm/vRSug843qwtqUJYZVWfpfo=;
	h=From:To:Cc:Subject:Date;
	b=NEj5QVXk0SrlfpF9MNr1KTPI/GfZFio0+UHsfV7kklkGsBL2Q4plzFJTmYdEUs52I
	 uZHU/aWkE50yS/eZ76fM4XduwpKRWNTspmY+PDtGiSEd9Nf/0C4r+rt5qaPlOy9gGA
	 5wlYZTfdcDznvFRS89jf+8FDKaBK44ypcyQUL7rgTub1QyqurcyEAV5WbTAF7IANmV
	 adzlDNSsnI4UXd2IKTXMmG9O1RHkPIBrRCKcGK6OBOpFBiheU+VbD68W/g0GFQ55E/
	 YR/6RrSX1LHej3/9qODiwkoSCsbajwkPvBD7eftV5O8QOUEBtfjx+PjLlOTykVr2Aw
	 zKlX/BNobTEeA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Sub-scheduler follow-ups
Date: Wed, 15 Jul 2026 13:51:29 -1000
Message-ID: <20260715235133.810434-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v2: - Host scx_dispatch_sched() in a new inlines.h rather than at the end of
      internal.h, which formed a circular include with cid.h (sashiko AI),
      and drop sub.h's now-unused cid.h include.

v1: https://lore.kernel.org/r/20260714230917.84158-1-tj@kernel.org

Follow-ups to the sub-scheduler capability series, addressing two things
Andrea raised while reviewing v5[1]: sched teardown drained queued ecaps
syncs with an msleep() poll loop, and with CONFIG_EXT_SUB_SCHED=y hot paths
keep paying for sub-sched bookkeeping even when no sub-scheduler exists.

Patch 0001 replaces the teardown poll loop with direct removal from the
llist. Patches 0002-0003 are prep and 0004 adds the scx_has_subs static key
and gates the sub-sched portions of hot paths on it.

[1] https://lore.kernel.org/r/20260709225041.1695495-1-tj@kernel.org

Based on sched_ext/for-7.3 (35f9cbbacb67).

This patchset contains the following 4 patches.

 0001 sched_ext: Remove queued ecaps syncs directly on sched teardown
 0002 sched_ext: Move scx_dispatch_sched() to a new inlines.h
 0003 sched_ext: Gate sub_dispatch_prev with CONFIG_EXT_SUB_SCHED
 0004 sched_ext: Add the scx_has_subs static key and gate sub-sched hot paths

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-followups-v2

diffstat follows. Thanks.

 kernel/sched/build_policy.c |   1 +
 kernel/sched/ext/ext.c      |   7 ++-
 kernel/sched/ext/idle.c     |  10 ++++
 kernel/sched/ext/inlines.h  | 128 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext/internal.h |  19 ++++++-
 kernel/sched/ext/sub.c      |  89 ++++++++++++++++++++----------
 kernel/sched/ext/sub.h      | 125 ++++++------------------------------------
 kernel/sched/sched.h        |   3 +-
 8 files changed, 240 insertions(+), 142 deletions(-)

--
tejun
