Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078C175A62;
	Sun, 11 Oct 2026 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791754831; cv=none; b=cf/K+zrGhuhPU+F0q+WM+VuoyNXAtrbBMXUBkgIJ02+fP1ssiyHL+Dtz1C4f4FiLQ4qyGmdJ3bP4Wq4Op4yRMA7sNPdWjTVPndprU2rlcko00GPOVcDJ6AbzGilpOonPbZ/1gEeRYFPWvkBseBNEC0cqPUOzuqDIY0AJDeISVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791754831; c=relaxed/simple;
	bh=jmWPoLYOqIQbL8hkgHJqTFHPfboDRYOCkxBDvw/1Zn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJGfHCuUgD9304FDGDxj+RUDHQA/gt/MgLJRB9JmCF2/JMXGyAoaLMxusOOWkjjjVp53vOiWDUQLqtMUq2wCGudbmo9m0XE+ooz9G+1kyNdwhadhc7P267zz8PPs7CtGwX5zF396R3KIcGTUxHWxa8Y7X5a5IPrWIgy0IqmrSvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay1lShEt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay1lShEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12021F0089B;
	Sun, 11 Oct 2026 21:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791754830;
	bh=jmWPoLYOqIQbL8hkgHJqTFHPfboDRYOCkxBDvw/1Zn4=;
	h=From:To:Cc:Subject:Date;
	b=ay1lShEt5PX0jfaSO0QWEeE9CdXaY9eVLIQcV4j/1ErxNWnt+G31KIzJ8g5EYTypY
	 5vBE8Gg4EikZtMC3ahqwbrSXi6xDrTi+nFnPWT+ejPDT/xWt7ImIVk/sm1/YEcEvby
	 /aggEKLeD+4sOmwrIrdQcCa5cduh0kLaW63+ftTzbkPQSWgOJ87ilA7VnLhWASd8qt
	 h4vkgCTsWtduo2ys07yl5wxKbYNTfZuhgvsmIUbPOZEdszxCv499Droe4MrtfgWiyY
	 lDK0hutfAvKlalc2cI6K5T7/sglhaz3nG/4LoDFL5CoBJ99WV78Lynpjb5QXUV0rFD
	 wEoh3Wa/6ZpzQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix bypass propagation and the bypass dispatch claim for overlapping bypasses
Date: Sun, 11 Oct 2026 11:40:26 -1000
Message-ID: <20261011214028.743546-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

scx_bypass() propagates a bypass to the descendants, and claims bypass
dispatch on the host, only when the scheduler's own depth crosses zero. A
sub-scheduler's own bypass that overlaps an ancestor's then misses both: its
descendants drop out of bypass early, and its claim is leaked or never
taken. A PM suspend over a sub-scheduler's enable trips the WARN_ON_ONCE()
in enable_bypass_dsp() on the next bypass, and one over a disable leaves its
tasks on the parent's bypass DSQs with nobody consuming them.

Patch 1 propagates every depth change so that a descendant's depth is the
sum of its own and its ancestors' bypasses. Patch 2 claims and releases
bypass dispatch for the propagated descendants too.

Verified with a debug patch holding a sub-scheduler's enable bypass open
across PM suspend cycles: every suspend landed inside it, the unfixed kernel
trips the WARN on the following disable and the fixed one does not, with the
sub-scheduler's tasks running after each resume. The claim protocol across
the PM notifier, sub-scheduler enable and disable and root disable was
model-checked with TLC, including the sequences fixed here.

Based on sched_ext/for-7.3-fixes (069403dff337).

This patchset contains the following 2 patches.

 0001 sched_ext: Propagate every bypass depth change to the descendants
 0002 sched_ext: Fix the bypass dispatch claim for schedulers bypassed by an ancestor

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git bypass-claim-fixes

diffstat follows. Thanks.

 kernel/sched/ext/ext.c | 54 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 21 deletions(-)

--
tejun
