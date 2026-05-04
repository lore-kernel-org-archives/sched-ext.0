Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE3288C2D;
	Mon,  4 May 2026 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926663; cv=none; b=rXf5/7WC7b6dqxu+QsI+X3DBxDAAGGO5GGJA7Zbz7o/cxRgr+8IZ+Ddp+m9RtFy4DIeliPDpVlgGaqwS+lsg1slrjz/I9L9BzjI9DA/oOlKBFIcY+CXj7FpixZ+m1Uez+UgFU8JzHx/XZJoqtdl0DceXjmkErLaLl9GZmKi3wi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926663; c=relaxed/simple;
	bh=Q7MGwfSG8eZ8MJ2M0sT9NQJnHs/lXSIGB4cBT2RN010=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=P65bjwbS84FD7xPLTDVLgUDVF8HxxaEhql6S28XnmESKB+gvIPoUKd67uR3ohwFQyjt/5mbDSDzAPEnw60IsT54+K+IfjbpNNcTp7ePdIWgKCUiD/sVUeeYlggN1xbntNyIsjM7OqT3aUcBvi9CNzcF65HW5gmdIpvT7qdjOzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNJFPqJX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNJFPqJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40810C2BCB9;
	Mon,  4 May 2026 20:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777926663;
	bh=Q7MGwfSG8eZ8MJ2M0sT9NQJnHs/lXSIGB4cBT2RN010=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nNJFPqJXh3YlsjsuudhTJpBDNMYke8wYFN06gXZWmmG9gF1PSBPSXMBGVcCtvpEB3
	 44A1KCYCmrIYiHBoGCfv2mtHSPdLDwRwkJVqFu9LKAjrCWWeXmUKB5sGfquXsXLD9M
	 wM526r7u6RSjjqpVnu1LglFr0WleuvBKsjk6TwLzyep9v0u54rAPPDOyaao9uY/SRc
	 yNW3NmnNb4RMD7NoFmjo8y6BMSyP09wcj0FQA17XIIdnNMH1Gf87KWdfOsvGHyZN1K
	 KFFTdctNhs3hs+xedDIzWwdptDESNr3c8bNZobE4861NgeA3+GfvXQ6U2aZ2BCREI0
	 p79DX9EzHRsOg==
Date: Mon, 04 May 2026 10:31:02 -1000
Message-ID: <27e7066a2bee63a475f30a6d596f4997@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhidao su <suzhidao@xiaomi.com>
Cc: zhidao su <soolaugust@gmail.com>,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix sched_ext_dead() race with scx_root_enable_workfn()
In-Reply-To: <20260429133155.3825247-1-suzhidao@xiaomi.com>
References: <20260429133155.3825247-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The race seems real, thanks for catching it, but I'm not sure the
reader-side fix is the right shape. The new branch in sched_ext_dead()
resets state to NONE without a matching ops.exit_task(cancelled=true),
leaking what ops.init_task() set up; and the list_empty() gate sits
before scx_set_task_sched(), so a sched_ext_dead() that races after
sch is installed but before state goes READY would still flip state
to NONE under us.

Worth exploring on the writer side instead: reorder so p->scx.sched
is installed before state transitions off NONE. That restores the
"state != NONE -> p->scx.sched != NULL" invariant and the existing
sched_ext_dead() handles the rest. I haven't fully traced this
through - there may still be a residual window between INIT and the
workfn's READY write - but it seems like a more promising direction.

Thanks.

--
tejun
