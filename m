Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15994192B66;
	Mon, 22 Sep 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559796; cv=none; b=Bc73Z+56ZQWqwtFTSSiMD8XTy1SLuCaHhY/gL1qanBIR7ugb5aehF04cOT0ARoO+iPoRgkA/OTx9WhjG38fs+XJSfL+SfxIxUuUTD/1sVSDEnD3Oi0AZxEUyWkOHnQ7VQeepNv8/Jc+xL4ue+/Jeri9szXaLJtHXmm1yB+NG+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559796; c=relaxed/simple;
	bh=M7MktnQrthEKslUvnhBlxODlj2uRrxXhtbIGEz90OfI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MgMWF2EKUk3+rAj0d+P0jMCitG9XGu9dBQSINthMV5NViN9ajXJN1wfftUg5pwhQ4X4Mlo2tOfeMcxHGhJ0HtxrlnnT/qsys4c/3COtm8aa/Wf241uWkFQlkOhY/j84amcYSU11b1F/PlYeEDstQ6zQzcNaWgEu2DHr0++mNRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOnjzeMn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOnjzeMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EEAC4CEF0;
	Mon, 22 Sep 2025 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758559795;
	bh=M7MktnQrthEKslUvnhBlxODlj2uRrxXhtbIGEz90OfI=;
	h=Date:From:To:Cc:Subject:From;
	b=lOnjzeMnVIy9QyQtjz8hVdKZmitTRn1JJgxmksWcYJwOTdnOSZGCTR9Me0aYKFJfl
	 FDByrMa1VltgGuNHqTb8MhqyYp45pFoV1PbUFW+c8cw+NSp0iOMrLcNZvJ/C7SjnNB
	 8nOJ60WrM0cDkLnsSoEWAka0lcJQtEsmg5pkCHH2SDV4PIbkRNwGh9L++MOhpj65Mi
	 9A83bnEdDmoIVuulwuinZsEisJdhU7OBP0b+66wCvYp04Sl1TQ3u9yeqKQRMFif6oO
	 fEoFK9VrQ7sK8xJsVS095CFVpc7aA2092rSyUSrC7A2ikQKijNGj6Jl6iKUyZ/ixOV
	 8N7KDg3+a0o2w==
Date: Mon, 22 Sep 2025 06:49:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: [GIT PULL] sched_ext: Fixes for v6.17-rc7
Message-ID: <aNF-Mqjnu_phEgvP@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a1eab4d813f7b6e606ed21381b8cfda5c59a87e5:

  sched_ext, sched/core: Fix build failure when !FAIR_GROUP_SCHED && EXT_GROUP_SCHED (2025-09-16 23:07:27 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.17-rc7-fixes

for you to fetch changes up to 55ed11b181c43d81ce03b50209e4e7c4a14ba099:

  sched_ext: idle: Handle migration-disabled tasks in BPF code (2025-09-22 06:24:44 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.17-rc7

This contains a fix for sched_ext idle CPU selection that likely fixes
a substantial performance regression.

The scx_bpf_select_cpu_dfl/and() kfuncs were incorrectly detecting all
tasks as migration-disabled when called outside ops.select_cpu(), causing
them to always return -EBUSY instead of finding idle CPUs. The fix properly
distinguishes between genuinely migration-disabled tasks vs. the current
task whose migration is temporarily disabled by BPF execution.

----------------------------------------------------------------
Andrea Righi (1):
      sched_ext: idle: Handle migration-disabled tasks in BPF code

 kernel/sched/ext_idle.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

-- 
tejun
