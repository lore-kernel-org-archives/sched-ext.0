Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B330F94B;
	Sun, 27 Sep 2026 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790498947; cv=none; b=CgAsB1pBpZAvHV1qj77XcYyg678C2DSZdCeJKp6h0OTxCOdWwirkUUkSNM2uON+IouLb4KH1Gr19tLT+VY1sw1hOIc8H4GJHXGqlo2HBi8OH6cq7dq3ndD69ZcFOyyYIHQqibigZCF38AlRhb7vFMLG0xUhYzEq0TNYPP0x4SJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790498947; c=relaxed/simple;
	bh=oaQ6Dm3cM5geiLXc2xM2M+Pq+CivqI1GBpn/aUYB0Zc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=dIZXuG+AJHJkVLK/BlWpgbUdkHvYd7zrom7gEwiwn5M4u/UrNkXBrpI6do8rk5PPBg+3z+5P4ibtZiPtJ9kDT9BLraG+f+l0Aqctuv4zqN78gypUyTZyiSZPFly22lN9hD7gbg6lYwaPGjimJN1MUiuCBjzYoB1T5suGK8h0eT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URhiHOkf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URhiHOkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D2D1F000FF;
	Sun, 27 Sep 2026 08:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790498945;
	bh=kNzMUi6ayZG+PW1KoorkExaa2Fa2AbWlpFKvUiqt3QI=;
	h=Date:From:To:Cc:Subject;
	b=URhiHOkfL292RZnPVnp8chJgRj87Rc0iAOlQv03gIV6HEbnpCDCWFDiD1c14bRWRs
	 rE7CSx4IewXSSCFsCwUdXjhamSngZi5jzPaDOKS68x1xzubB/6dGdarL1/2rbzqV2U
	 5clhbOJnwK/3eFSaViWjRvfC1KaZxOQaNlFZ9jsWMUdbiIx+2u7mylgNLo720XttJD
	 Qucxi2bfYV0fbd1ruFesyOWYod1N4i6OWQ6C9WYeKyoj1BedYDwQII2Zfn9d2IS2NI
	 9XhtoVbbEbGLDetJFJFtUZT9NOykYs/5K9VyE0NTsqcKK24LW2bNlaSRDJU1i/imoL
	 zKEKAir6SKGaQ==
Date: Sat, 26 Sep 2026 22:49:04 -1000
Message-ID: <b633964a6f8f06d64bee4227394d6218@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Another fix for v7.3-rc4
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The following changes since commit 4409a85735cdca5c4c400c0dad1feee091872eee:

  sched_ext: Count SCX_EV_SUB_BYPASS_DISPATCH in the dispatch fallback (2026-09-23 08:16:10 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc4-fixes-2

for you to fetch changes up to 94480606a677deb68d5622cf0ded88626514b3f2:

  sched_ext: Add a size argument to scx_bpf_cid_topo() so struct scx_cid_topo can grow (2026-09-26 10:09:12 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.3-rc4

- The CPU topology helper for BPF schedulers took no buffer size, so its
  structure couldn't grow without breaking schedulers built against the
  older layout. Add a size argument.

----------------------------------------------------------------
Tejun Heo (1):
      sched_ext: Add a size argument to scx_bpf_cid_topo() so struct scx_cid_topo can grow

 kernel/sched/ext/cid.c                   | 26 ++++++++++++++++----------
 kernel/sched/ext/types.h                 |  4 ++++
 tools/sched_ext/include/scx/common.bpf.h |  2 +-
 3 files changed, 21 insertions(+), 11 deletions(-)

-- 
tejun
