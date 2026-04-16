Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF7930EF84;
	Thu, 16 Apr 2026 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360031; cv=none; b=cGv1v2mL6YnteLTLj9cYCw+g8qMfe2ZMPepaoFvj7oBgCAr77aoB05lw8mjcBICw/J1YR0wekEIf/j70gHE5kiY3ndMGIPLOSZBx9BOzSIPH8tas8HcEabpqT8qoS3YRvQqy77xKoNvzAlAKT8gHWWwdncppxyBYL2ZQOUNfWp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360031; c=relaxed/simple;
	bh=TJh3RNhP21M09MUVa0oR66BmtpXlK+I4Wz7ddB60CuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Giy3AFJ+9sqwEtsn/2F9K5/O56g22mSsQnXUMyZO85R/1asTYOWxRZQAib/vt3JIiBGgNOHva1RY2ZdVXlbMfycA8ZxIdWL4mZAfs0HQOrL/OXGkT0SpBaLM2unJ6o5hWfNY/0PYR3m6DuhXpauMdg62KSkOhuLgK8VzCT+HtBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPNGHVLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPNGHVLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B5CC2BCB5;
	Thu, 16 Apr 2026 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360031;
	bh=TJh3RNhP21M09MUVa0oR66BmtpXlK+I4Wz7ddB60CuA=;
	h=From:To:Cc:Subject:Date:From;
	b=jPNGHVLdM6afXQAF+HBY+1w2Mauq2p1BTf4WF7GP44/xYyeHUserjknJy0onoX2ro
	 YzwUDdtC+P7DX04/8bkplpODV7BUafnR3ZtG30Rr/IMZA6oTDWmAXtJA+SA4r7JbH8
	 mz2E1dprdJEPYaADr8G7V91ciYRPOQ1lOYE4JJOP2ZD/jH4uqmJQ+4d/Fw70KN+L+X
	 3rR0avS2Tfh2jWZGEex8MXITnFsTRNiQWvdsWdD6lrGo63KTsxCWKNstSmEmEcYkTp
	 Jxte+EuQYtltFrRUq1cR57YI9niTTozmuLkmuMARCc0IFdYtxW3Hi7veRFtvlRYa5v
	 /Hh8ibAc096SA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 sched_ext/for-7.2] sched_ext: scx_qmap: Convert to BPF arena
Date: Thu, 16 Apr 2026 07:20:25 -1000
Message-ID: <20260416172030.1417417-1-tj@kernel.org>
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

v2:
- Drop "mutable" from comments (#2).
- Add task_ctx_t typedef for struct task_ctx __arena (#3, Emil).
- Remove duplicate QMAP_TOUCH_ARENA() in qmap_dump_task (#4, Andrea).
- Update file-level description for arena-backed lists (#4, Andrea).

v1: https://lore.kernel.org/r/20260416081626.1285617-1-tj@kernel.org

Based on linus/master (1d51b370a0f8).

 tools/sched_ext/include/scx/common.bpf.h |   4 +
 tools/sched_ext/scx_qmap.bpf.c           | 572 +++++++++++++++++++------------
 tools/sched_ext/scx_qmap.c               |  54 +--
 tools/sched_ext/scx_qmap.h               |  73 ++++
 4 files changed, 465 insertions(+), 238 deletions(-)

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git qmap-arena-v2

--
tejun
