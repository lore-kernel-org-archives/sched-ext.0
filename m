Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610DD3C455F
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381252; cv=none; b=eTxAE+bGyslD8ktFRZS7VtiMObjRDpAMP0wPA8ayxxBMsTydwF0KORJQEK2YzzSzYhcf/IvtThTvLOU5QqLKbHbD49CdTMlxB3xMD+NHSSQXPnuyC7SyMGUmQd6PbEKOkrWmopZFhYXiqoMvR5/0Qt9PlBiUD2UJFJoMfbfUSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381252; c=relaxed/simple;
	bh=r3eWCiWbjxC0pL9xfN6jqJs9IeAtfW7VBPa1S2s5ICY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=QoWO6lqeygn0Wo0+d8bYHK3JHl4VE0ER3uNeReGaZd21IAjEvDy9z34Osy6J+nF0sidxNpXGlSyAhHZZS8S2KaE1NjyuIijabC4xCAmfbY89dzwuWsJjPvkO6MTDU13nttB0oQRg626m1apDXu14bLASTiqKlAxV7QtMqd/1LkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDDpMUPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDDpMUPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22A41F00A3A;
	Mon,  6 Jul 2026 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381251;
	bh=r3eWCiWbjxC0pL9xfN6jqJs9IeAtfW7VBPa1S2s5ICY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lDDpMUPYGYLZuKMsEcnMBNGUZ6/8prWRebc/YQ3uMnNlFDLK6MzMfIchBCW0J0PCw
	 77f6fovLbn/9Z+OuuDbu9rDigZf48iFRhgx5odXDZQS2aIWZnYmwcY0O1pIrLvYMci
	 H15hmuXCdDC9Ly4Kp4CSPMdRWLBOiC41ku0BtSmf8hJbWbmYRD5vpBafcJ5Vy05p9U
	 34/CkOvy8hOGyIk7SNBhbhnZDRWpAn/woOQdrB2v91EaSUmvGtTPGbXXa9SFQjnfQS
	 H3YkJakdAU0ksq/GqSRn7MAVbMzXAADSY0eaPbdPyFhxYb6i9jV6+qJE6fqCTwDODc
	 4HMpLjM9291OQ==
Date: Mon, 06 Jul 2026 13:40:50 -1000
Message-ID: <55ba6b39c7e92dac4fbb7b1ce503f829@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 27/36] sched_ext: Route task slice writes through set_task_slice()
In-Reply-To: <20260706020505.9B8FD1F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-28-tj@kernel.org> <20260706020505.9B8FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:05:03 +0000, sashiko-bot wrote:
> - [High] Routing the lazy fallback assignment through set_task_slice() in scx_bpf_dsq_insert___v2() and scx_dsq_insert_vtime() incorrectly drops pending out-of-band slice requests when preserving the current slice.

Confirmed, fixed for v3. The slice-preserve fallback (slice == 0) now goes
through a non-superseding helper so it no longer clears a pending out-of-band
request - the stash survives to be applied under the task's real rq lock.
