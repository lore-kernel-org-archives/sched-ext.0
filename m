Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068D3C10AE;
	Mon, 14 Sep 2026 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429383; cv=none; b=tDdbiPi4UgZfJw0/44PEaJVdajuJedMMRCMJc3hYbqXPjvDl9flcLMTkXNCAbDNlvmINZFKXOns36ij0U1TJua0+KogHIelVYIGwVjTZqbTNS4XFvka5c/tuXNUxA1wKrTLvatULE0Hz62c9byITZfyHccyI5Zta98rua00aYJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429383; c=relaxed/simple;
	bh=G9XXuADMt2Zjd/Tx5UUcXFhxJUMrIAmv21nIOeau/3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WoiPzMJKIT4crFQsEgKbZ4/rNgtRRvBPwCwgDwiXpWnzK8LOTzgeJmJM5HL+/aXYyLG6x13WryqZQIMjhPoP0F0LYIZD1Gk20/kWSGb2ekuP8ygTuMded6Ye5YhTa5UeQjy6UxU7o+c34H6SyS+XDeEBE7DYviR62zwZJ7mmkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBmlijgp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBmlijgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4921F000FF;
	Mon, 14 Sep 2026 23:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429380;
	bh=qEBVrt8JU1VDFmShvvmCdkC1KCX9KCBd+pFUSdR5nTk=;
	h=From:To:Cc:Subject:Date;
	b=DBmlijgpP9n83jR++EMGZ3Ti1MtbkwB1zPJQh94D4bZiH/GPrpUg3I/FcCFwKbwTe
	 v8IsefW6QJPmOl4dzSawUDkMKCMzhfaMaImIlT04PIaB2qLtfHwOBiY2GT2FAv9Zys
	 hreDhoWD8LKEaOXxpTFQ9mDsWzCn9qJYxW00N1Du8pX96b+dz2P5v6+s9uvsBYa2mX
	 tjoL7zVzj+WqlF+tM8whA7q2DWsBiuH1n3cqziA6IFXNogcNuNnYgSQz3VN9WDRr+v
	 6FtSHkhxLq9hdqAIPl581X5P8H807Tt8q+DQW2z4UrlgW+L2ty/rVyrJfZWD+LU1UN
	 0gNNTHfV2uMHA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Idle repick notifications and online cid mask
Date: Mon, 14 Sep 2026 13:42:57 -1000
Message-ID: <20260914234259.3585373-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Two holes in the cid interface surfaced while converting a scheduler that
maintains its own idle and online tracking.

An idle CPU can be reserved and kicked without receiving a task. When it
picks idle again, the builtin idle masks recover the reservation but
ops.update_idle() is not called, so a scheduler tracking idle CPUs itself
can lose the CPU until another real transition. The first patch notifies on
idle-to-idle picks, automatically for cid-form schedulers and opt-in for
CPU-form ones.

A cid-form scheduler that installs its own mapping has no way to learn which
cids are online: the online count identifies the set only under the default
mapping and the CPU-form cpumask is unusable from cid programs. The second
patch adds scx_bpf_online_cmask(), a kernel-maintained cmask in the
scheduler's arena that follows the SCX hotplug notifications.

Verified by building and loading a cid-form scheduler that consumes both, by
local selftests covering the idle notification with and without the flag for
CPU-form and cid-form schedulers, and by a local selftest that offlines and
onlines a CPU in a VM and checks the mask and the callbacks at each step.

Based on sched_ext/for-7.3-fixes (c7a1c6e8004a).

This patchset contains the following 2 patches.

 0001 sched_ext: Fix idle state tracking across idle repicks
 0002 sched_ext: Maintain an online cid mask in the scheduler arena

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git cid-online-cmask

diffstat follows. Thanks.

 kernel/sched/ext/ext.c                          | 77 ++++++++++++++++++++++---
 kernel/sched/ext/idle.c                         | 60 ++++++++++---------
 kernel/sched/ext/internal.h                     | 24 +++++++-
 kernel/sched/ext/sub.c                          | 10 ++--
 tools/sched_ext/include/scx/common.bpf.h        |  1 +
 tools/sched_ext/include/scx/compat.h            |  2 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |  1 +
 tools/sched_ext/include/scx/enums_abi.autogen.h |  3 +-
 8 files changed, 137 insertions(+), 41 deletions(-)

--
tejun
