Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951DE249E5;
	Sat, 25 Oct 2025 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351530; cv=none; b=SOMgrCg9zTPcTTZnb89zTaNSNDF4WU0X/0FmSCNP+t+ksuYQBXhASt4Fj2NrhJwBOYp+RUDzZ7zElLVYubUMg2yZD/xYajrodThyu7toQRfZjJmVQRAVC7GGL3dD3aD7gCM9Xm3AccDEHZAUmJ1WF1SG6z/uNY5ocVkVKs7t3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351530; c=relaxed/simple;
	bh=4LoeEK93z34qo0fvO0ipwbW22sKQ3x2BCR9eXK9HY1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCiKNC50Y3zy0mqxphihhUL/qrbH7Xk4rpchj/NOEJxONjPwjgTpSwUyw8cJHXBZuhw4KyESM71Sr4kcHeGmINqlTL26Ip70TGBane9lconlPFi9gad67Tza53h0dIhV2eAzzxFZqf8IWb9xD2up0tM6lD6HZbmVBRDTIhWep4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPf7Zo7U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPf7Zo7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B233C4CEF1;
	Sat, 25 Oct 2025 00:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761351530;
	bh=4LoeEK93z34qo0fvO0ipwbW22sKQ3x2BCR9eXK9HY1g=;
	h=From:To:Cc:Subject:Date:From;
	b=RPf7Zo7UKoJ4G0eKwNWgovePLWusO/+wHe2hnKY2NFHaNyfOJF1VNaW5UMJALpsZ5
	 lLlDtf6ldP3hQxw6iAovKyueUB8vhCAupdmQGDqy0AeL7bIgyWISSp/8omWZKSQkv8
	 3cXUSGCwZseCIz+eoTWhoJI3olFo0lCHYY7WH8mkuMTRHEMKIEwMNMt2y7043omAPa
	 vU0k9Euqbc27WT8IFa2bBzt/fyxu3whCaHdOy3J2d09gcsOYr9DYmuUmBS/E8HCKdn
	 4d61XOavgAdtgh1idruGVjIovARATi2b5zgFmCEumuckMId68eoKIzr8MCgI/2oeLr
	 6VzfUmxVAtccg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: [PATCHSET sched_ext/for-6.19] sched_ext: Deprecate ops.cpu_acquire/release()
Date: Fri, 24 Oct 2025 14:18:46 -1000
Message-ID: <20251025001849.1915635-1-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ops.cpu_acquire/release() callbacks are broken. They miss events under
multiple conditions and can't be fixed without adding global sched core hooks
that sched maintainers don't want. They also aren't necessary as BPF schedulers
can use generic BPF mechanisms like tracepoints to achieve the same goals.

The main use case for cpu_release() was calling scx_bpf_reenqueue_local() when
a CPU gets preempted by a higher priority scheduling class. This patchset makes
scx_bpf_reenqueue_local() callable from any context by adding deferred
execution support, which completely eliminates the need for cpu_acquire/release()
callbacks.

This patchset contains the following three patches:

  0001-sched_ext-Split-schedule_deferred-into-locked-and-un.patch
  0002-sched_ext-Factor-out-reenq_local-from-scx_bpf_reenqu.patch
  0003-sched_ext-Allow-scx_bpf_reenqueue_local-to-be-called.patch

Based on sched_ext/for-6.19 (dcb938c45328).

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-reenq-anywhere

 kernel/sched/ext.c                       | 114 +++++++++++++++++++++++--------
 kernel/sched/sched.h                     |   1 +
 tools/sched_ext/include/scx/common.bpf.h |   1 -
 tools/sched_ext/include/scx/compat.bpf.h |  23 +++++++
 tools/sched_ext/scx_qmap.bpf.c           |  38 ++++++++---
 5 files changed, 136 insertions(+), 41 deletions(-)

--
tejun
