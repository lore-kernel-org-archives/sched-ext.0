Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4403431A30;
	Fri, 24 Jul 2026 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917287; cv=none; b=Waw/Ct+F1fPHzVcZFRgLbQu/hgKX9yTLXLRfA69hjjL5aIJEwGPrFBORXsTp7aU76hKTV1XcgKQ/GjeuWOsxUR1ua3kPhSC3XnaKAbeQ4WXLcgKgBX6qgFq/2Wg5qGBDr6weFErlyahHRXjaEuf5J56BD3INPFd2RWdSbiuk/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917287; c=relaxed/simple;
	bh=97LIeKWXsaBt/VFTCvvsImjqqOtZHhgcRM5QOyaibAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O85BN3FLY6gOI4uxX0Lv/ejsziF5/08sEN7w16friHDTCQQLxfX0BVXAsAd6v/IN+bbk/XtM7Orp0JQqgcvkCG8END1m1Zca1bBF4Ml5e1NnYTi7BoptKPB49vdYKYC6YKH1uWdZL0KIwvFzbmBkSiJLQRlH4Y5CnOS69vnoFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPJ1dAyF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPJ1dAyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9F11F000E9;
	Fri, 24 Jul 2026 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784917286;
	bh=5QwUGbP2GAkxPOEzKx9LoGqdib0Oep9WS3v9ChzdZ6k=;
	h=From:To:Cc:Subject:Date;
	b=jPJ1dAyFmYlPoSOIKu3VE+ceZdiCb2T0kZvRIBIpSkjwzNCf7t/zm71g5+B+Zrl4o
	 yoQgKxCcUXtj9WhZsZ+wpODppi5rl9sXT/hHoC9VRgHclUFYgwXCmukz6YdAA2dTMb
	 aBDGUpe6YP4Q9dM/l7fw6yJDnsrh7xOonCsrcVsTmX64x/xUeVCIDsocZLt/EW0bJU
	 OzR3ScNQ0DFYXwSZQ5uYmSeShSNztgwXGvS4OYnoaJ/QwqiURI2nSJzdVgTqUOQ/Bu
	 B6pQTxBvsoQt2ZYG0hZXJt7kVMjV9/wt73VUTK8oOBV9JXED+FYmF88uhaquOFRZ5R
	 CXyyfpUK+QhhA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.3] sched_ext: Follow-up fixes and missing cap enforcement
Date: Fri, 24 Jul 2026 08:21:20 -1000
Message-ID: <20260724182125.985061-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Follow-up fixes and enforcement holes plugged from the recent
sub-scheduler work. The first patch fixes the tools' restart loop
clobbering an exit that was requested while a restart was pending.

The rest tighten how cid-addressed operations from sub-schedulers are
handled when the caller lacks the necessary caps. Reenq to another
sched's local DSQs is now denied and counted, and a new event counts
the already-denied kicks. These checks are lockless - transient false
positives from cap rotation are harmless and false negatives can't
happen by visibility. cpuperf control moves behind a new SCX_CAP_PERF
which only the root holds by default, and scx_bpf_cidperf_set() reports
the result synchronously through a new versioned interface as its check
is authoritative under the target's rq lock.

 0001-tools-sched_ext-Don-t-restart-over-a-pending-exit-re.patch
 0002-sched_ext-Gate-local-DSQ-reenq-on-baseline-cid-acces.patch
 0003-sched_ext-Count-kicks-denied-for-lacking-baseline-ci.patch
 0004-sched_ext-Factor-out-scx_cpuperf_set.patch
 0005-sched_ext-Gate-scx_bpf_cidperf_set-behind-a-new-SCX_.patch

Based on sched_ext/for-7.3 (c509d8107026).

The patches are also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-cap-gates

diffstat follows. Thanks.

 kernel/sched/ext/ext.c                   | 152 ++++++++++++++++++++++---------
 kernel/sched/ext/internal.h              |  31 ++++++-
 tools/sched_ext/include/scx/common.bpf.h |   2 +-
 tools/sched_ext/include/scx/compat.bpf.h |  18 ++++
 tools/sched_ext/scx_central.c            |   2 +-
 tools/sched_ext/scx_cpu0.c               |   2 +-
 tools/sched_ext/scx_flatcg.c             |   2 +-
 tools/sched_ext/scx_pair.c               |   2 +-
 tools/sched_ext/scx_qmap.bpf.c           |  17 ++--
 tools/sched_ext/scx_qmap.c               |   2 +-
 tools/sched_ext/scx_sdt.c                |   2 +-
 tools/sched_ext/scx_simple.c             |   2 +-
 tools/sched_ext/scx_userland.c           |  11 ++-
 13 files changed, 181 insertions(+), 64 deletions(-)

--
tejun
