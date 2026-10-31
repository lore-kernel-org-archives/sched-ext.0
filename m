Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466343;
	b=sYKH/9kuld6cBlI5NcbQbhBqT4FMaMh2XE9BaiPGLNN7zXnTJg1lJlhlPCzOu3d81PEH
	 Pe193BGLwZ36S2hHuEm6/BeE1aPB8FTJn0wfJ+/c/fEl+0K0mjZeYBcr0y/1Y0JwKoemY
	 gMlyNu1P02gJhjO+2NV7wso+fZh0lH6YuCKvxKtUVJSyLz8Gc+8JZqj2zPbAMLHNbGJEG
	 7ZFPhSkx6SRq3ZVD7WDBmawpdX/a2o0AoqB7NmVvcu41u7dIKGnfRTiMiRM6Bi47AU3iQ
	 CowkY/7wtXn4RS6McdFXBlzO6vozchnGaYsi9y/RLje1w30U8+D+J7ncW0dXMvUXBSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466343;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=h6UJ80vrUNJtXEwuidpPgmVfUQXwtuv0pXyrUAIxhcM=;
	b=2k66zgLCr0wTlnFQITjEoV82WdYX44MKVNAE3Em9BLYj38ZMnSkU1BZUGWRIjhUVMbKV
	 0YFlqahNt27lUPFWxsWVfIyXiU/adfAf4DyD3bGbCIVlyLOyprpVB7CwmkoslcluVl1vR
	 sB+3f7rs5+u+rZ8VZafcLU87PoprWN1T7YmB4kvTBX8Nq66XcGPYOIG+wA6g9Cmny5cTr
	 iyZXmHC2cD+L3FtND8DeiVPRCoChpxAfhVdtqUaUC+LKXEP69+ZT9vLPTteATjHEjJrQw
	 eZiqQlgU9EuALN6m2c8th/E/oROZMOIAQD4EuJKkiD6/uc2QoGi86qvNcHhXuOJBTkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nu69+osu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E1606A31A;
	Sat, 31 Oct 2026 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nu69+osu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1901F000C1;
	Sat, 31 Oct 2026 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466342;
	bh=h6UJ80vrUNJtXEwuidpPgmVfUQXwtuv0pXyrUAIxhcM=;
	h=From:To:Cc:Subject:Date;
	b=Nu69+osuS1paJ8Aplhhmfrwmd59mcYejXnTg97H64Wsr/qZb8a1WkLkfstBtvod7m
	 hckAizQQbjTUWKPEGu3twGvEmAGIcXii8d2zOBurKGCuYsEh+epDC+APNEVMK7I5Pd
	 l4gWjX76gFnPmze+2nsO4sW6udWlN5U5vCGVNaYMtT/2M57SRTxfIFRdBLoqwBRGJ+
	 LroDVeNUsNVXtfQ34S5JhAv97OqluQndUQP/rGtRq7UZqOUQ4gdf3h6/ykr83Ewq8I
	 bx4CGGwrVrU3+opCuKgPv/l8xo4YjhMtKpg91oRZ4CJolnvC5Rd9cTaLStLePUFr7j
	 glmUtSE1IagMQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.4-fixes] sched_ext: Fix ops.enqueue/dispatch() calls before ops.cpu_online()
Date: Sat, 31 Oct 2026 07:05:39 -1000
Message-ID: <20261031170541.710939-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patchset fixes ops.enqueue/dispatch() calls for a cpu before the root's
ops.cpu_online(). Both ops are gated on SCX_RQ_ONLINE, which follows the
core's rq online state, and on a runtime cpu up the sched domain rebuild in
sched_cpu_activate() puts the rq online before scx_rq_activate() calls
ops.cpu_online().

0002 tracks the flag in handle_hotplug() instead, set right after
ops.cpu_online() and cleared when the cpu goes down. 0001 is preparation.

Based on sched_ext/for-7.4-fixes (0aba89317f38).

This patchset contains the following 2 patches.

 0001 sched_ext: Factor out drain_offline_rq()
 0002 sched_ext: Fix ops.enqueue/dispatch() calls before ops.cpu_online()

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git cpu-online-order

diffstat follows. Thanks.

 kernel/sched/ext/ext.c     | 93 ++++++++++++++++++++++++++--------------------
 kernel/sched/ext/inlines.h |  2 +-
 kernel/sched/ext/sub.c     |  9 +++--
 kernel/sched/sched.h       | 17 +++++----
 4 files changed, 68 insertions(+), 53 deletions(-)

--
tejun
