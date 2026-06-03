Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC734779A5;
	Wed,  3 Jun 2026 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507316; cv=none; b=h7xoZ/APhEXUYGURxRmBbSVxXI/b98JX2koW5rZ+gLDdsILeubOkfNv/JTYZieGzfY9YhHW4BmS1m58ocXwVMV8IqhxG5sDaS+mIC+FlhLDHlk4O3O3xYe5j4U2opybMfMG7GXb3EF7nLMkalNK+vjgvHUDlYF/ZgcXan4oOnpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507316; c=relaxed/simple;
	bh=meKe4txTnicVHK5Gq/T3SWR3bNtlGIJf2k4FV4LwXXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUPXEr5frZwaSRlhgAt+GlO+RWixBjJZYWekhzftYZUriiEsdfoOb6qGMUXwsdp0pDKU5ZEenRhmJFY1U7vTGMOVD4WMtdusC04AgGNBk6CnOnR/3FW8TzHf2ourpZIuf1cABpn95W1iLUPkewwyl17sof1FLGx/n4iITA+q2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRBkadYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRBkadYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7061F00893;
	Wed,  3 Jun 2026 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780507314;
	bh=lLy/pEWW+awW2g4H+D4SzauN9QV9fPeiDw2EEQ3I9o0=;
	h=From:To:Cc:Subject:Date;
	b=XRBkadYgwsmzz6fcPvPwbDM8eEJWQcBnaea112LRJ35uNna0qBw0a91CeoVXhF5Bu
	 LI+LEc6jjwvO58yQJEoiopi/yB9RQZ3RzuEBy7XYegMGQi5UyIZsNg8agnqNgeEpHz
	 qq8Tlo6FCoHZn++tvtramMSXSu/amLlpsUVi4Rl9sn4DVtJ4PeRbv7QsMQbZGV5LBV
	 7T74jABfnDsQbMD6yiHaE1Cd6P0DHCGPQ88Ne+b+dzH3Ag5HlKal8UB4aTsdRHxIJ6
	 5d0dUPI8qRkm/WDiQrYxudie0+4W6vAshzNWRlJDe32RXH3QIe8f2l8Sf8IPmjFJCW
	 iUa8EqeJ4whLA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.2] sched_ext: cid/cmask interface prep
Date: Wed,  3 Jun 2026 07:21:50 -1000
Message-ID: <20260603172153.3081861-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Three preparatory changes to the cid/cmask interface that landed in for-7.2
this cycle - a helper-argument reorder, two new helpers, and a kfunc
return-type change. Posting ahead of the merge window, in particular the
scx_bpf_kick_cid() return-type change in patch 3 - it changes a kfunc's
signature and is cleaner to settle before 7.2 ships.

- Patch 1 reorders the single-cid cmask helpers to (cid, mask), matching the
  kernel's index-first bit and cpumask predicates.
- Patch 2 adds scx_cmask_test() and scx_cmask_for_each_cid().
- Patch 3 switches scx_bpf_kick_cid() from void to s32 so future cap
  enforcement can surface failures. The cid interface has no external users
  yet, so the ABI change is safe now.

These are extracted from the in-development sub-scheduler series. Nothing
here depends on the rest of that work.

Base
----

sched_ext/for-7.2 (dad836524259)

 kernel/sched/ext.c                       | 13 ++++++++-----
 kernel/sched/ext_cid.c                   |  2 +-
 kernel/sched/ext_cid.h                   | 41 ++++++++++++++++++++++++++++----
 tools/sched_ext/include/scx/common.bpf.h |  2 +-
 4 files changed, 46 insertions(+), 12 deletions(-)

Thanks.

--
tejun
