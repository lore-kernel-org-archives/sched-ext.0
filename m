Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5354B0491;
	Sat, 15 Aug 2026 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786755934; cv=none; b=W8ipQE+6Tku1CG+Ro3Dqnnu5mQ7S3Z+jUQ8hq//8E58HhDT6ccXWnIQrUT8LMumQl7mqOk10UjVE0g5w6+UYBFliQ7iYo7zm8pesmABYXQt8RivnQvPoUI7uXAnDuL/hLEkzjGTQWjKMNHK9/6pkBJ5nqawNUaAqEO/tYgHBbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786755934; c=relaxed/simple;
	bh=qRpAwc7LQGqT27S7YwlagiSws8YWy4vFAzi4cKd0IB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GrKVnQncyq7urZRrmnuuWmZ43xt2NTBqzE6ZFAbZ/RGaeGGKVMrSuZL7DsFYP9l4Pt56MqosM0zPhQnvT0ltA/sFQj6fpXTM7UHIQnto+KxorLvMHC+kqBQuepSlRS09xasLnWoiEPZaq+GYSzuqImeDFPzuGQJTtYOavYPMWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdIjrRE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdIjrRE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3C81F000E9;
	Sat, 15 Aug 2026 01:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786755933;
	bh=YrISv13l+D0snYUo6wRs6uyOQQkPxz0bbpwBlRyI220=;
	h=From:To:Cc:Subject:Date;
	b=TdIjrRE7JBMZhCTu3G14GpcfRh9RoA9PUT7oYO3V7On4NUm5kPUyFSPJRz5OQ+td/
	 snxMA0M3tvZvEyrzSs+RSGvBhDFzSeNVTHCpO1mJsRAbXk0KRK+ar6NKjC7b9/5cRz
	 3Zfnb59FijlPOKi9xlNInn449H3AxzT1ye2LzTCJXTbVdCM9Wj+65T/EyYDYrjH1uQ
	 xPAhI5S2wQZF3ioZYWJ3Wfz/dESnkIExwPgqaxgHe/Lml3hymWvsZPgf5FEkS/g+GP
	 yj0+ER2OmZotsJRoI9vcwldmwHNCFuwLLyYv+ObF8WCvFKuVEkP5OOwlCgGJZ3/2kg
	 Eolaims15CxbQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.3] sched_ext: Dispatch path follow-ups
Date: Fri, 14 Aug 2026 15:05:29 -1000
Message-ID: <20260815010532.3663253-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Follow-ups to the recent dispatch path rework[1]. 0001 fixes kick_sync waits
running on foreign CPUs now that dispatch can drop the rq lock with the wait
callback queued. 0002 and 0003 clean up after the dispatch verdict
conversion, dropping the keep_prev fixup it obsoleted and renaming the
remaining balance-era names to dispatch terms.

[1] https://lore.kernel.org/r/20260807210221.232543-1-tj@kernel.org

Based on sched_ext/for-7.3 (e72979d3264a).

This patchset contains the following 3 patches.

 0001 sched_ext: Keep kick_sync waiting on the rq's own CPU
 0002 sched_ext: Drop the stale keep_prev fixup in dispatch_pick()
 0003 sched_ext: Rename balance-era identifiers to dispatch terms

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git coresched-followups

diffstat follows. Thanks.

 kernel/sched/ext/ext.c                          | 83 +++++++++++++------------
 kernel/sched/ext/inlines.h                      |  2 +-
 kernel/sched/ext/sub.c                          |  8 +--
 kernel/sched/sched.h                            |  2 +-
 tools/sched_ext/include/scx/enum_defs.autogen.h |  1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |  3 +
 tools/sched_ext/include/scx/enums.autogen.h     |  1 +
 7 files changed, 54 insertions(+), 46 deletions(-)

--
tejun
