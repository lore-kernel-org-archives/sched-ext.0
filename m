Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E8352C28;
	Thu, 16 Apr 2026 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327387; cv=none; b=AKh9OIQVSxnChEfA9XxhbsE9JIfhbIlZ0j+C8LY9yVLBV33qXitvcu4DuNeZaYqBaeSVqzs7RNNnf8laaSHll/d/GZbWathqX6glSkj3gfH92kXH4jyEh0QnDiTCIaN8Ioe+W0BRt6QH2eslbhyAM+5oMUI+hqOB+zUrfSHHlik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327387; c=relaxed/simple;
	bh=Q/sP8reP+huGz/Yy+Y3xCsAAcmiZbmiFqlHRoOJ8tcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+p745n2rZN6kXiZ4rG8xJgM+5shjeas0S0KBh1WoRQBswkMe4viAKZcXMpq8Rh8kVjiQXLHBtjX+UgKmNVa6BHNh7NfuekWbEhY8b2oMTaXj0d3XIg5UY0wni/itam5uqH7Be+LNYB/0KmcG3nxbAQ5C3BPiKrMm0htm9JtRbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLVjbfbD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLVjbfbD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E149C2BCAF;
	Thu, 16 Apr 2026 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776327387;
	bh=Q/sP8reP+huGz/Yy+Y3xCsAAcmiZbmiFqlHRoOJ8tcU=;
	h=From:To:Cc:Subject:Date:From;
	b=ZLVjbfbDX9PgRsUr+ns3sUcyJw+7calGQ7SD9VOX03ykFvdDli7tg8zBZ0Jie/7kL
	 SplEXDKchLF8VmYHo9ySX/Hp7RgzcI+l4t72aw24IM89J284jgRaJ97AbkKimUFFtt
	 0iaPvYItpVLzzLLNFSZOeen3t/j8fkOHxtD5fETAFz3IpXav6habjFGdw9S4N57jKP
	 JvIl/ht/kHH3xLrLvHI/1BzhTArUNpB1k+9RgSm+YDpjHynmm2eeY1jd3xycnVYSv4
	 JKgudbuvsppNJbWgC7wZ8+vD2CIoJe5xhSaea0z1piyf+JlsArkYlanUPmuqDTmWDh
	 qeL5J7WEF2dPw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.2] sched_ext: scx_qmap: Convert to BPF arena
Date: Wed, 15 Apr 2026 22:16:22 -1000
Message-ID: <20260416081626.1285617-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Arena simplifies verification and allows more natural programming. This
patchset converts scx_qmap to use BPF arena for all mutable state, as
preparation for further sub-sched work.

 0001 Rename tctx to taskc for consistency.
 0002 Move globals and cpu_ctx into arena.
 0003 Move task_ctx into an arena slab with bpf_res_spin_lock.
 0004 Replace FIFO queue maps with arena-backed doubly-linked lists.

Based on linus/master (1d51b370a0f8).

 tools/sched_ext/include/scx/common.bpf.h |   4 +
 tools/sched_ext/scx_qmap.bpf.c           | 561 ++++++++++++++---------
 tools/sched_ext/scx_qmap.c               |  54 +--
 tools/sched_ext/scx_qmap.h               |  73 +++
 4 files changed, 459 insertions(+), 233 deletions(-)

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git qmap-arena

--
tejun
