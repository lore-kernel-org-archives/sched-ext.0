Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141693CCFC0;
	Mon, 29 Jun 2026 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762170; cv=none; b=bPQWj6McnxGWDYHF/lzcCMgN7/LKa7K3IkHcco3/CHQI9sQiwDQxc050hT+FeuVGq5egVsw1R7w8wVmNOSgu0J22i4M3QoznkywK72Jl711Ujbm/TLb6cC7LsOQaew92YY5o8BBsPtNvD6BlTiLxp/wBc6V79htU1zZEFvk0aA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762170; c=relaxed/simple;
	bh=LQIKk7phdIBjMXRuR80qDBt5XmoGhz7RszKrLqZjIi0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Me3OHYxq+5EM/ONcMjpT66EbNJFaUWZdtBVyRJaClZQP1tZ2b7rtGxw11FX+wRHd9p7QOTf0TinOy9se9RdrDmcGu/Y8Y2TMqVLKnhCiLHFgcrX+c82eTR+U7RmJndbrKl7mHBgMJiMS3AOjJWl6zVrnXQUqFcNukgXJZR+rEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdQ+3WGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdQ+3WGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F461F000E9;
	Mon, 29 Jun 2026 19:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782762166;
	bh=tfAJPuPeLTDtGKt8ka9Tk+AFcYEvEGc401sswWfgiAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PdQ+3WGgaHXWlPywKDO8cVEjXdYCBFv1s43IxLWZgS+pBOoqc0hC2+QchthoUvHyy
	 +Ozzk4R+sRzrrKQKuuVEumKr+HLbeovZ/4pQGrTs4l0arqnqYkc6nVR+YQq21QX2IS
	 h5AXig2wOyobN5cVo4h8fvCrpLe1Np10TcXDBiCZN2nackrxzQXcCPctf4/ItE4FMi
	 0gTLbLimi4kzvg/6EttgeNfGce1d8Wz18/1AW0v4aljO11qn16hvo+pMg2+uYqlSs/
	 mEfwwBhg4MXUwLSrB4jCLP6Xanly41TRHaltwjc91Cl09aYWkHt60aOJNqqPTi3eZ5
	 Cdmv4fsTDiETA==
Date: Mon, 29 Jun 2026 09:42:45 -1000
Message-ID: <90443ebc5ac832365031c7d569206fcf@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Don't warn on core-sched forced idle in put_prev_task_scx()
In-Reply-To: <DJI17L7ZP0BT.3VW1FVZMRGWOM@google.com>
References: <20260624235531.2979880-1-tj@kernel.org>
 <DJI17L7ZP0BT.3VW1FVZMRGWOM@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Kuba.

On Thu, Jun 25, 2026 at 09:45:30AM +0000, Kuba Piecuch wrote:
> Nit: balance_one() doesn't happen in balance() anymore, it happens in pick.
> So IMO it should read "... skips pick_task_scx() for the CPU, ...".

Right, fixed in v2.

> Is there a more precise check that we could do to determine if this switch is
> due to core-sched forcing the CPU idle? I was thinking about
> rq->core->core_forceidle_count, but IIUC that's the core-wide number of CPUs
> forced idle, so it's not a reliable signal about any particular CPU.

I couldn't find anything with better granularity either, so v2 keeps the
sched_core_enabled() gate.

> I wasn't able to quickly convince myself that an IMMED task will be reenqueued
> in the case where a CPU running an SCX task has an IMMED task enqueued in its
> local DSQ by a remote CPU, and the CPU is forced idle while the IMMED task
> is on the local DSQ.
> Looks like we might need a call to schedule_reenq_local() somewhere in here
> (in a separate patch, of course). WDYT?

Makes sense, and not too surprising. For now maybe we just note it in the
comment.

Thanks.

-- 
tejun
