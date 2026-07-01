Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BF4B8DEA;
	Wed,  1 Jul 2026 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929448; cv=none; b=HWCWZO7/ytlHlW7P+umD/M053TcQps5Kr2dYQE78wMw1yANHPJzecFkkj0eU82R+FRV87dCEjM24xJgWEM9UguSpMJHGRbz3Jhz1VGo8oBjRHB4eSSb+A7yXHdMqwW8VaVwyhPPV52mLoRPhl43iTY/ftof/sT9J5nBWj6q8cN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929448; c=relaxed/simple;
	bh=Wsoyp5h4CO3mbieDy3RHcGx9imRL/y+MtvKmef4PwVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+s8bcosb8XMHDwdw2073lZznV2N4tME6cb+ZvVlIJVKE3p7olHTW1+ZiZmKxfF5Oi4Hp9zQlECHFMkLfL5JiL4IdYqf8EvDLlhyhIrYcI30WcRV94hE6+79lCUO/WtekI4vORWGb4ixAglzZfpXxe3UXtuGxlrqkMaBK7Yed34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcJOmcAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcJOmcAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796A61F000E9;
	Wed,  1 Jul 2026 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782929447;
	bh=7dECSQMbFt7MNhIyXcL2gIr90q2uOx23ADilDHvYSlg=;
	h=From:To:Cc:Subject:Date;
	b=KcJOmcAN4TEeFiA3ynOD0EiPih1ic+FV8+Wy4wsG/hpJIJRH8aFKjmuoOJti2+3tq
	 wVN5dXrnh67RkhAI6W6bxIkhaUjZ9awiyllGHLjKzelgzMpQdntP0s8xhiljTLvyOc
	 VNzJjfloBv0EOYYbqt32SoduYvt7alPSjWEmzYfGNk7IkJWAP5aBEbRFir2Q9IX93r
	 ZC2BDn3Y6glowQc0RciTBtc/JVYs0ddl1/StSy1FTEHSZX5FDoE2hPUmGY+TeZnmy/
	 hZa28yFLsYv8rky3CzaJw2x62T9nMYQxAlWT9ttCWDLRGsaW3lOSONwZ/rTkYGTVFC
	 zApPL1ZyFRX9Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Split sub-scheduler implementation into sub.c
Date: Wed,  1 Jul 2026 08:10:42 -1000
Message-ID: <20260701181046.2490390-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v2: Fold the scx_dispatch_sched() sub.h promotion into the split (patch 4) so
    it is self-contained. v1 left it to a later patch, so the posted split had
    sub.c call an ext.c file-local static (Andrea). __always_inline kept.
    Patches 1-3 unchanged.

v1: https://lore.kernel.org/all/20260701031429.1892218-1-tj@kernel.org

The sub-scheduler implementation has grown and will keep growing. Move it
out of ext.c into a new kernel/sched/ext/sub.c. The first three patches are
mechanical prep (prefix file-local helpers, expose shared internals, inline
a few trivial helpers) so the move itself stays pure code motion. No
functional change.

Based on sched_ext/for-7.3 (5df6a4506d06) with sched_ext/for-7.2-fixes
(b7d9c359e5cf) assumed merged.

Tejun Heo (4):
  sched_ext: Prefix file-local ext.c helpers exposed by the sub.c split
  sched_ext: Expose the ext.c internals used by the sub.c split
  sched_ext: Inline small ext.c helpers shared across the sub.c split
  sched_ext: Split sub-scheduler implementation into sub.c

 kernel/sched/build_policy.c |    2 +
 kernel/sched/ext/ext.c      | 1117 +++++--------------------------------------
 kernel/sched/ext/internal.h |  164 ++++++-
 kernel/sched/ext/sub.c      |  668 ++++++++++++++++++++++++++
 kernel/sched/ext/sub.h      |  161 +++++++
 5 files changed, 1101 insertions(+), 1011 deletions(-)

Thanks.

--
tejun
