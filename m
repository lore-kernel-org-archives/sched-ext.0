Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9E33C1BD
	for <sched-ext@lists.linux.dev>; Tue, 28 Apr 2026 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395797; cv=none; b=hAuFaT06Q0nHRKT//fccHENLcR3EL0j4KlVttxhoyXf+iOjclCWxnjmzjC61abY/7ySzdWb1aef2dCqqIwVSU5J+c6VPQrp3DS+b1PirNQft/q0vI1+gCVYbzNz8A71WRe8Xz+w5Yl3SxnkP8jbhjqxoBkC+the0+Q/pIK2r6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395797; c=relaxed/simple;
	bh=bwI+L0f1o7zGqWmi7DwHx7VCxIawWkkZdpMOK+FmquA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=IBamICJKp3YG11fmP38SWmVSRcWUUScE9nhAjbgOzMZ5id9DeDN1fkYjXYWgnOU518EM7pyNwxPdzizwsFwH0OA0sino14wD1MkhNnhDZqNZx4rt/lIMi+qZOJoSA/gcl+38LvOBZcV1PPQKjnraZ74QfDMR2Q1l2UcMr5edfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWusyE7S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWusyE7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD98C2BCAF;
	Tue, 28 Apr 2026 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777395797;
	bh=bwI+L0f1o7zGqWmi7DwHx7VCxIawWkkZdpMOK+FmquA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dWusyE7SM2eFrqp0F/Zh1jkYjq/ng/rdFMmJEAjX7xUKSGaB/VBiC7gAKQKO6TBmS
	 JDba5ji/bGxki6H6Bteor2q+BjttYtlcc+QfvMYFHVa32T0brMebtyFl86MTpndUb6
	 1bRQ/Mt58RMRx4f5fnjPW3ZgBBj4Jy3Jf5iyvA29NHDDiIrWK2Q55faHqtvrPioDFa
	 YLJ25hT+/i+/P9ynTmYk9rFQi0tEjkr0uT9vfGfnFxY1IzRJ3XxBG8aQUDZbjqIhtE
	 04LOY3mzhWQRfjGuBeg2N66rG61s6fk7x24Dvv3cCgx5xSISiOPe3UuuU4Rx0Lfh5O
	 8hFIei00hf+Lg==
Date: Tue, 28 Apr 2026 07:03:15 -1000
Message-ID: <73693734b68600dd348b6b84d2195abf@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
        sched-ext@lists.linux.dev,
        David Vernet <void@manifault.com>,
        Andrea Righi <arighi@nvidia.com>,
        Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Fix scx_flush_disable_work() UAF race
In-Reply-To: <20260428045529.1670916-1-yphbchou0911@gmail.com>
References: <20260428045529.1670916-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Cheng-Yang.

How about folding the early-return into the loop?

  do {
          irq_work_sync(&sch->disable_irq_work);
          kthread_flush_work(&sch->disable_work);
          kind = atomic_read(&sch->exit_kind);
  } while (kind != SCX_EXIT_NONE && kind != SCX_EXIT_DONE);

Thanks.
--
tejun
