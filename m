Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA661367;
	Tue,  7 Oct 2025 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800937; cv=none; b=SIjwRlyzO1MrDPGokK+lbDwVEeLTjPwvmW65oSoRls0NwfG34OHX/4sf2wFtte0W2dagX0KCqwoqxT+gBOK1uga7SaNiASsvpjwTjy8kEqyimj8yMPfbeyvUC7Hn1UY/D8y7jdNLJ53NoAjd3xNCFId9PeUmAWoJpxafdic/lGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800937; c=relaxed/simple;
	bh=ileuy0IaoeO61GW7aMtdBSEnYkwa7h2G1NJwl2NTd28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AP+glDeNGyM2X6gJcoMJ3daGH5mU88PA5OEFRQ96z5RNimCCCXUfX2w1bmUfiiGqXD6OcWTy/orxPDij3QDdziyOyKe3noDw8LEFgxe34kyB+0OANz3OkadxNUNHCzeuWh21PveOE6S4kW5fPbqInP7FBmUoGwF+Ui+uyShWT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKqv6xA8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKqv6xA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A800C4CEF5;
	Tue,  7 Oct 2025 01:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759800937;
	bh=ileuy0IaoeO61GW7aMtdBSEnYkwa7h2G1NJwl2NTd28=;
	h=Date:From:To:Cc:Subject:From;
	b=aKqv6xA89wr+e14VoDgAn0ENOfpf1pGJlmlS0KFK61prwxDJ9DUo/cbBaugHut/ld
	 7+2HijUlkGvFOdXyG3GRcoUGgscSOxZS/yKO289BWxAVkOhgDTr9gBGBvuYPvGjXho
	 43z2dWNaFaNZH0SCV/Jx5oJAL883newTFhShPv0b6foa+fcV0ZisioOf2ftIZ6JMCJ
	 as4xtJbZzbFquQJQUK9kjfwDyIlDC/i5KHgHZd+1HY0TZcpSXpds4xJTApiCCgq5Mu
	 ltAWW8HPshpc8OkCIomcsRV7nEbgf8ghVTR6PRMBlrfwa5f/IFXbkn3tb3lP/tYADg
	 6RYC+5mwR92Rw==
Date: Mon, 6 Oct 2025 15:35:36 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.18-fixes] sched_ext: Mark
 scx_bpf_dsq_move_set_[slice|vtime]() with KF_RCU
Message-ID: <aORuaIXJftQDMBIA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

scx_bpf_dsq_move_set_slice() and scx_bpf_dsq_move_set_vtime() take a DSQ
iterator argument which has to be valid. Mark them with KF_RCU.

Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5688,8 +5688,8 @@ BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
@@ -5820,8 +5820,8 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
 BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_unlocked)

