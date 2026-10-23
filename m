Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792713814;
	b=L5cz+CBYGtXloRJY0TXGXXln6srbQZg1S6FoG3ChCyjG2AHaWNeFauluWWygjFdOt/dc
	 mzSdP4axVQR+X6zcG9LCb2glpHp0T/efpwJh46LbkUeb9EsdDc4XkVfHSwjDH33fTjHxY
	 xul1i1cmqVmX5rDV7QW0lZZGMie1bazB8y/2VvvlPEVbkxUVTADq1g9guOEzTjRizrF6i
	 cA1NXzxgt8vWgXRxcSMSozPXa4gnXKuZmMGLZfUnukTZ5Cj5vFQSRtKEQ8rgbWMTTiO06
	 LiMsuRTXhNM6ApS4TMh3QayEluqyuCZYXr7Twnj91jHpQwKjImfcLj57hxlhlFe2nqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792713814;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=J7REHjKN4xxpRijalKL70zgjfl3Kdf8r5hcnizdaRCQ=;
	b=I0tO4wScc19fSis/Z9SsyfBfdd9jXOMFiXNPb/y3FyMNmZ1mpg+NjhZGi8GBDco7wwAI
	 MVn71Yxt30qL9WV1ySJb1xFGhF+a7NzNZVzW9QtGuIZmdNTe38HE3yDi1CyWUfdt5+CyB
	 mwbFLlWSP5sR6z2Kd2XT78JSU8n0uqas9srxl0JuUGByXhg6nGE4E6Mw/yypeofZoYjDj
	 nsMb41EZs/oB03CZW5MJTmBmIMOGL7o0GqyTnT+nfjRwbAJsWFO9mWzIgA5OLu2ZyuSN5
	 sgmPdI1WnS/4NAoQXQsWVs9ODKEJyBOZqdPIGA7fA6L7XBCz2xGaRUKFORjnvKZ/DkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfnDCyuy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83F606A319;
	Fri, 23 Oct 2026 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfnDCyuy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA4B1F01825;
	Fri, 23 Oct 2026 00:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792713814;
	bh=J7REHjKN4xxpRijalKL70zgjfl3Kdf8r5hcnizdaRCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QfnDCyuy456Qt4VwBeBXDvOhynEj2hBYrbGZV2quU/3b5IGovJhrfRoQ7qYvLv7tl
	 FV5iOLEKMx5IoHIqFbIOAr0IrjsYl0c+rnkUmMJr1Pown4SIHCZ/BB61cclrjo6pq+
	 AykG2uLg3VjVDnb10KpLJT7vnJk2JHsVqWa7xQPgGKtiTdM01+cand9Jr2MEL4eV8R
	 XFEVw13Rc4twGIlEkpFFbuT9ZbUg7/60c0cMQsBXbMpWFD30QCGpazSdARhDMF7IqT
	 6Qf5AR0M6KUn6XJVAH+/GutIpt6Zc0zXFhB/lFlmeaSAAgsxEzG5+NNe0LcnYCmsa7
	 frCR5h9TJaEfg==
Date: Thu, 22 Oct 2026 14:03:33 -1000
Message-ID: <e89a3bde1785fd3609635c463e382318@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 10/14] sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE
In-Reply-To: <sashiko-outbox-182098@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org> <20261022213836.2259069-11-tj@kernel.org> <sashiko-outbox-182098@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello,

On Thu, Oct 22, 2026 at 10:09:43PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Should the initial slice check in dispatch_one() also allow a task with
> scx_task_has_kernel_slice(prev) to keep running while its scheduler is
> bypassing, matching put_prev_task_scx()?

Yes, it should keep the rescuee. The next version adds a patch ahead of
this one. It expires a bypassing prev's slice in dispatch_one() before
the keep test and drops the bypass test from the keep test. A kernel
slice survives the expiry, so a bypassed rescuee keeps the CPU. The
post-dispatch test in scx_dispatch_sched() also can no longer keep a
prev that dispatch_one() declined.

Thanks.

--
tejun
