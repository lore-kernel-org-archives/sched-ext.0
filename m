Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35964484883;
	Thu,  8 Oct 2026 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451953; cv=none; b=DSYhNZlzDv+fOEA+BcKssi2eUddYFnRYKW+0lLczWnY2wYacmg7rX9c0VhjTPdkup7yPU+7afOwMynJJP8jm6qI5C0yzPucXNakPevvV08ToqdCpMWW8np/3wq8DuyYuS3sQJ/mRhriuvos9T/ogw49dSh6Zt8ymZInByAozibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451953; c=relaxed/simple;
	bh=p8LjtC70Lt6xtWUXRote3XXL3lhLfgfvpQRi+E2lazM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pKNyVTd5PXbupxf/uxkSfxZnNTadBCxdIwkY1ahDCjgJ9XyDJsyPIiVxA2NAxg6r+papCWH62M+MBQHTw2RZ/GcuE2htokq9Pv2O2ij/rXwCtvMj4FnqhRvpaQXWMJ0Iw5UwDDr8Arosg4/OyhGhPaBPUK9Ad2wcE3P2zrbDnP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH9mpQuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH9mpQuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A741F000FF;
	Thu,  8 Oct 2026 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791451949;
	bh=m2dJ95RPTPKjS3DaSCNzCWojqL4oqW5iTSP5QHUo+iM=;
	h=From:To:Cc:Subject:Date;
	b=gH9mpQuLv7gvnf9qUNhprXuZ8fg/liCEB6Khbr7S+Z0V3Cfzt+UtDHjG1tAcwPiJA
	 +80Cb14oynyOBTjgT9hO4SUAtQDPUCPGg7b7Lt/Xn0QIcwul3T/otQY1nBRpZywpXq
	 f76MHuE/mQZHts76xpZKpV/aJ0Q1u1vR7RNgGUdbUnUgAmVV/XgS8C3XE0B6I0d/9t
	 PhE0Rezy6N+AwRcQ4CczMogJ7PP7aiec2+CeCZGrHNpctr/URMKYuEOY75ffCtftNa
	 wY8XsXh4x+8KCUN40lEKuyeNigR0Q4mMjWQ8deHF9xmNPmfZrqyzqE8bilVqqe1QvO
	 KgftF21n3YI6w==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.4] sched_ext: Add ops.sub_child_ecaps_updated()
Date: Wed,  7 Oct 2026 23:32:26 -1000
Message-ID: <20261008093228.2015427-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v2: - A sub's disable no longer reports. The report ran the op outside the
      dispatch path, which meant setting up that path's context for the op's
      kfuncs and gating the nested sub dispatch at runtime, and keeping the
      report clear of the PM bypass took a lock that could stall a suspend.
      The parent knows what it delegated, so ops.sub_detach() is where it
      restores it, and its kerneldoc now says so (#1).
    - scx_qmap resets a detaching child's cids from ops.sub_detach() (#2).

v1: https://lore.kernel.org/r/20261008000352.1689057-1-tj@kernel.org

A grant or revoke only records the target caps. They take effect on a cid at
its next dispatch, and nothing tells the parent when. Without that the
parent cannot act on a revoke, such as resetting the cpuperf target a child
left on the cid.

Patch 1 adds ops.sub_child_ecaps_updated(), delivered to the direct parent
right after the child's own ops.sub_ecaps_updated(), with the child's cgroup
id and the same before and after caps. A sub's disable reports nothing; the
parent restores what it delegated from ops.sub_detach(). Patch 2 makes
scx_qmap reset a child's cpuperf target once its PERF revoke takes effect,
and from sub_detach() for a detaching child.

Based on sched_ext/for-7.4 (3d7c2f550eef).

This patchset contains the following 2 patches.

 0001 sched_ext: Add ops.sub_child_ecaps_updated() to report a child's effective cap changes
 0002 sched_ext: scx_qmap: Reset a child's cpuperf targets once its PERF revoke takes effect

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git sub-child-ecaps-v2

diffstat follows. Thanks.

 kernel/sched/ext/ext.c         |  4 +++
 kernel/sched/ext/internal.h    | 30 ++++++++++++++++++---
 kernel/sched/ext/sub.c         | 59 +++++++++++++++++++++++++++++-------------
 tools/sched_ext/scx_qmap.bpf.c | 33 +++++++++++++++++++++--
 tools/sched_ext/scx_qmap.c     |  7 +++--
 tools/sched_ext/scx_qmap.h     |  1 +
 6 files changed, 109 insertions(+), 25 deletions(-)

--
tejun
