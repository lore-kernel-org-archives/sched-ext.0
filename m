Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CBC37B03A
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655381; cv=none; b=fwXYZZlZjNna9PghbUFzEi5MYog2mhMJQqKUfJne4a0MbLGuV3d9Ih3VNlmIbo0Nn4Hbngm7Ul5Eq0OCrYs8f8avX/HrhzugOzP1guTy1MyWrCY7/vMm6pfF1Md6UY3/xCGs/rfIQSU5hsQ1fBmmYN2pnO1ZzpgSGYB6jepkxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655381; c=relaxed/simple;
	bh=wQpB/ndcDnmBwMVwVKKGlUpTa9SMQk/BOgkhwNUr5tc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gHEjA7YmGGWBwxF/HbskiBKUTHN/aPQDh9cLDgVW3rHllfX15UrTjI9/Y0o3bu5O0sO5P7ORMCqr6d2NTniNVToXCUAbZ/Mw24MHBz9WE0IeiLal20iolzFsHbRmYpkhxT/lBiR/OsM7eHaW6RBWVlXa3EL8dZK9OjopcMrdCio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71A141477;
	Mon, 16 Mar 2026 03:02:52 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.28.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A1763F73B;
	Mon, 16 Mar 2026 03:02:55 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	shuah@kernel.org,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/2] sched_ext: Fix SCX_KICK_WAIT cycle deadlock
Date: Mon, 16 Mar 2026 10:02:47 +0000
Message-Id: <20260316100249.1651641-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When using SCX_KICK_WAIT I noticed that it lacks any deadlock
prevention and will deadlock with no chance of sched_ext even ejecting
the BPF scheduler.
The BPF scheduler cannot impose any reasonablesynchronisation itself,
except for a strict partition of which CPUs are allowed to SCX_KICK_WAIT
which other CPUs.
Since SCX_KICK_WAIT seems to be used quite rarely, just synchronize
all SCX_KICK_WAIT globally and don't try to be clever about cycle
detection.
Also add a testcase that reproduces the issue.

Christian Loehle (2):
  sched_ext: Prevent SCX_KICK_WAIT deadlock by serialization
  sched_ext/selftests: Add SCX_KICK_WAIT cycle tests

 kernel/sched/ext.c                            |  45 +++-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/wait_kick_cycle.bpf.c |  70 ++++++
 .../selftests/sched_ext/wait_kick_cycle.c     | 223 ++++++++++++++++++
 4 files changed, 337 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/wait_kick_cycle.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/wait_kick_cycle.c

-- 
2.34.1

