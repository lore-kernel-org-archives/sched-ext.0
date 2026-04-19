Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5115746F;
	Sun, 19 Apr 2026 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614680; cv=none; b=hWqnVtWqziPRk5OM2Kv2JOdYYN2ElRBbniJg0TLpi4Aep17R6z4u7tXqVuME/fGT72fXKxS4upQ/9ZvP9g5wmxHqj1HmzMrOWBYn2arOP4QCtZ3J/mYO5ClMq658MbsK3ymzBl60Pgpl4pne4aRhQzKAYvR5/aYgt+kXsjTf/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614680; c=relaxed/simple;
	bh=rXB26XJY32PxczzTk4m8oATwG9lQdNPWIZad/b92lzY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=BIfd+/GtTTsAk85K21xgp2u6W4acKSffrGxXULqs4AUnIp/GJLWEnR3bCtTPH5nP3n8fx+a8fdbies6gWNMuFL6ixafPLwU0AFuBOjUFbzRXgs9nbKbyqqncX8hocwWHqy9q5x+UF1gaTx5nRZ6q0MVgNzSj2uGsiT/QdYG832c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8ZWI8al; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8ZWI8al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF76C2BCAF;
	Sun, 19 Apr 2026 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776614680;
	bh=rXB26XJY32PxczzTk4m8oATwG9lQdNPWIZad/b92lzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q8ZWI8al5ypgs+Z0Y27QxLyP7q/6DHbmpt6P/ArF3TRs79g+x2+1LSL2AsEMPNA6i
	 bFeQjpRiCdb0YrjoIwyQkseoIeCYYwgrQWoKGrUZreXRkdgJzUHp3056MSuk1sZsF1
	 DJH/PVQ+YfG5srxWMu33gpWELg8ejPvOQkxP4OqO5pqcA4K6Kn9zDyiEC1kKqPceFJ
	 ycpOk84nzllColByzYRAyNaHux/kbX++2rlCZBnTJcqeK7VPcbcmbfx/3rXy/oy6p5
	 uiDGga+Jvp+VUk/bZgYGDxxzgF1ennjNTzK5CRhhMmmtshn1oQodXNGgPJHcBtKRgd
	 XLFZGy718tl7A==
Date: Sun, 19 Apr 2026 06:04:39 -1000
Message-ID: <8f403734b8b8f9da6b71dc1804960f9c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Documentation: update
 scx_qmap description for BPF arena
In-Reply-To: <20260418120058.1555036-1-yphbchou0911@gmail.com>
References: <20260418120058.1555036-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Thanks for catching this, but the proposed phrasing is a bit misleading.
BPF_MAP_TYPE_ARENA isn't a queue-map replacement for BPF_MAP_TYPE_QUEUE
- the arena is just memory; the queueing now happens through intrusive
doubly-linked lists in arena with per-queue bpf_res_spin_lock.

How about matching the file-level description in scx_qmap.bpf.c?

For Documentation/scheduler/sched-ext.rst:

  * ``scx_qmap[.bpf].c``: A multi-level FIFO scheduler supporting five
    levels of priority implemented with arena-backed doubly-linked lists.

For tools/sched_ext/README.md:

  Another simple, yet slightly more complex scheduler that provides an
  example of a basic weighted FIFO queuing policy. It also provides
  examples of some common useful BPF features, such as arena-backed
  doubly-linked lists threaded through per-task context and
  `bpf_res_spin_lock` for per-queue synchronization. It also illustrates
  how core-sched support could be implemented.

Thanks.

-- 
tejun
