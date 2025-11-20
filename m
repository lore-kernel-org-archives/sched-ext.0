Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68328C00C;
	Thu, 20 Nov 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665294; cv=none; b=cjCDRlR7e1pvuH8wzydYsTlGlegVqHVpG4gsKyFamYK8TzW/+tivwN5L+ir9+7n6fEgJbd+/69EVEE8S20JRxMl9FreQzisdAXheAOlcH0uVizvPq3saUO4F18Ynodtm/pBot50rjDEQngcT9I1l9+nYK4Pt3Vh27/g8yVa/BQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665294; c=relaxed/simple;
	bh=cheSiGlPBRxdUCkOYdzh5ZwcjAluG+PfAjpdaOWi0Ys=;
	h=Date:Message-ID:From:To:Cc:Subject; b=FWPGfYN5QYFwE5szye9l8fvvyISzcK/w9SP2kB0She2fHCoa1OEBaV0EAw3WEIYiF7gCmyJtY26sr4vuk7mryZaAANHgpypWU5y6l0k+cFp2uOYNHaQFrZmaMxBr+dj+9jK+F/XVslB2ioXEwlNkq+ZomarZd2WjxLj00s+4S6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oERGa0ff; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oERGa0ff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DD6C4CEF1;
	Thu, 20 Nov 2025 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763665293;
	bh=cheSiGlPBRxdUCkOYdzh5ZwcjAluG+PfAjpdaOWi0Ys=;
	h=Date:From:To:Cc:Subject:From;
	b=oERGa0ffG8wEt9MKd/JUPWO6uGbVQ0LhC4gtZMCB3lxgjzGpjtiis2biKVD5wUJ9C
	 ntroORHM24KEY/Kr2jBqFch9GtUMk9o4IXRDdEE5Uq9MDtvSWcDPm5kRyhVtvA9Q5f
	 hZDF+FSFD73j3PXFz9y/yd8omiE94nfPVvZKfnoxCrd597d/8mx1hWQ7Ja3d3kHtFB
	 Xu1ak+bcX+52jqGsKGAlR1/sFft27TYsXGytQb4j+aBUGxCrvX2FIayQ6d6aQi2jkQ
	 mg/BgSBlUkWxVzWbFDyHnl2DfiWi4DVkMm/mxg0bjNMAy+wYeBOadMKXSZBF8qD27Y
	 VZiUqolLUMaLA==
Date: Thu, 20 Nov 2025 09:01:32 -1000
Message-ID: <6f7a101d95d9bc9ff02662c35f45911c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Another fix for v6.18-rc6
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi Linus,

The following changes since commit 36c6f3c03d104faf1aa90922f2310549c175420f:

  sched_ext: Use IRQ_WORK_INIT_HARD() to initialize rq->scx.kick_cpus_irq_work (2025-11-17 05:07:22 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.18-rc6-fixes-2

for you to fetch changes up to 7b6216baae751369195fa3c83d434d23bcda406a:

  sched_ext: Fix scx_enable() crash on helper kthread creation failure (2025-11-20 08:45:43 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.18-rc6

One low risk and obvious fix:

- scx_enable() was dereferencing error pointer on helper kthread creation
  failure. Fixed.

----------------------------------------------------------------
Saket Kumar Bhaskar (1):
      sched_ext: Fix scx_enable() crash on helper kthread creation failure

 kernel/sched/ext.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Thanks.

--
tejun
