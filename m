Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A6201113;
	Fri, 22 May 2026 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468509; cv=none; b=OGhJE/7VP84/xOC3fwFFfRQntmjIuYpKNt+u/Py3DOS//+Nl0q8qathkEyOoPUeUjRRhl0ETdKntKl/Q7fTEqLRVTtJ2r84REJ6Xoa03RTr0Qo2sqWiXmcQoMy+B6jqYLlXvC9pqRDjWfFqDzKNovnHNzYQdpbu1f1Gg0bgttn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468509; c=relaxed/simple;
	bh=czxg0ugFF7DTguf09eqff80Te586ny0ZQz7Nm4RkZ4w=;
	h=Date:Message-ID:From:To:Cc:Subject; b=h0CC9zL4loT2CZZZf4IRz89vRdCMta861rd6Foa5K5f/ydPk7baNHsJPTnpUtexajQAIVB6i+vdtvbMWi5VhYhoqRjmYyFxieC/JdWLQ4EMSugjI9TGWqEVTbIRewFyaHIekup75d2z2NdJ100WonrDWVr7gSy3XMgTn4Hqa6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BS3XDERS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BS3XDERS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C1F1F000E9;
	Fri, 22 May 2026 16:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468507;
	bh=CFPvO4D3qKUE6wDv8ibHh6ldJ5erCwqXVOR+CuJ1xow=;
	h=Date:From:To:Cc:Subject;
	b=BS3XDERSt1AfFGs2pRLXCTAHG7J51thAS8Ue4wvh/fZhDe2HlXneCME2vrJc/ipF6
	 c6e5i8C0jRIP4EGcDWwKMnK2cVG4A++Al4Li623+a7d3sYEVsFnCTA1lscfJopUrO4
	 KNdfQT6TmLN4FxodmtCT2/zeVHZFlNQ0eUUAbtLINxuAFdArmw+Pt5DphlHDIk9fxP
	 Z1+FTpocZ1/1tILxF9zD58R45Opl9oPWqe2Rk6z1b87eiTxJqQKrIVIzqKvddcxHwv
	 7nB4vmGOTgclsI6TwBKuqGWt2Qduh5rbaUDf/w6Dxmb7M58DBeh3FA4Dk5lb8a/U7T
	 /TolTZGcBh1dg==
Date: Fri, 22 May 2026 06:48:26 -1000
Message-ID: <154badc0cdc979593d4321a2cdb9ef61@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.1-rc4
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Linus.

The following changes since commit 6ae315d37924435516d697ea7dde0b799a5928e0:

  sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation (2026-05-13 10:02:57 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc4-fixes

for you to fetch changes up to 0c1a9dce208b4dc265925898e5da98934f7f9266:

  sched_ext: Fix spurious WARN on stale ops_state in ops_dequeue() (2026-05-21 06:27:44 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.1-rc4

- Spurious WARN in ops_dequeue() racing with concurrent dispatch.

- Self-deadlock between scheduler disable and a concurrent sub-sched
  enable.

----------------------------------------------------------------
Samuele Mariotti (1):
      sched_ext: Fix spurious WARN on stale ops_state in ops_dequeue()

Tejun Heo (1):
      sched_ext: Fix deadlock between scx_root_disable() and concurrent forks

 kernel/sched/ext.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

Thanks.

--
tejun
