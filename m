Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03174514766;
	Wed, 16 Sep 2026 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596061; cv=none; b=TIl5g2a13wOc3IcEirGnEUN6F13q59lSSDC7PZQXpp2SstQ0iLidCbqw0IEziWrKYA3Ax0GGclao1G2A3FosqmWt8YqSoKPZ9VzMRSqoORnmekwloOHWg3qc1REiTuKNEqdQ/zj8Hd7igcVr78oAzT8J/P4iZ2ywIMSGYDovhuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596061; c=relaxed/simple;
	bh=gl1wPUFRKBmMC+6aiLaKMw4KOvv/LA+lecwlEAljxCM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Iy+hsvWUNcZZyjQw4XRi9Q2NrlKvAe1ciK3deAIz9tAPFCb0WL8cqFoelZz5cJFM1FenNPS1JTs4VA/lmJJt1peCUQXibGTOwI+VomqOSD8vj2mTA5aMFBr/rfvdl+RNIgSUjyY2VrxMUs5ou77OU3OpAjvcwONPH6q40lpdgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egKe0Mgu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egKe0Mgu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B034A1F000FF;
	Wed, 16 Sep 2026 22:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789596049;
	bh=mUsjiXM8sKB6lLAxc59Pp1p39vtMlcEughWfWrT/3g8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=egKe0MguorJM42nl6FYXXXzfr+iqEEDBnSURW+pWVyeLxqBkl++P1y8RTfeZ2u7cQ
	 RHV9K3m8wZNJ9nou8rD1gZex2tyb98CRDHP+ITnBEgg0xPHzCog6aqCL/dsj/ahz9F
	 tKZK7iNp/8GV498eO7mdMJqZfQTAiRRiN78NiNdpw2YuLItO1WM5HFR9RSouw6EO+Z
	 JGAoTX5c0wyiuKYW5Z9K7NMoavfOcODdgRErCk95GVB6ZgZCMBcWCO7iXcyzYUrew2
	 WvVWozGsgaV+za7H2zU6170xRlLDpMLjzpy01EJYCo4Nb2I2FflHfTol3JeTcrijEt
	 /dohdjYoHdj+Q==
Date: Wed, 16 Sep 2026 12:00:49 -1000
Message-ID: <313d3ed89d24c8415a11ea864ebdc84d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Unlink pending local
 reenqueues before freeing scheduler
In-Reply-To: <20260916145807.3250167-1-arighi@nvidia.com>
References: <20260916145807.3250167-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Wed, Sep 16, 2026 at 04:58:07PM +0200, Andrea Righi wrote:
> A scheduler teardown enters bypass before the RCU grace period, which
> prevents new requests. However, this does not guarantee that an
> already-linked request has been consumed. An RCU grace period waits for
> active readers and it does not flush a pending rq deferred request.

Every link is followed by a scheduled run_deferred(), so a request that is
still linked when the scheduler is freed means that schedule was lost. The
WARN is doing its job there. Unlinking would hide the next one.

The lost schedule comes from move_remote_task_to_local_dsq(). It stashes the
mover's enq_flags for the destination enqueue and, since 57ccf5ccdc56
("sched_ext: Fix enqueue_task_scx() truncation of upper enqueue flags"),
those flags decide SCX_RQ_IN_WAKEUP. An IMMED insert into a busy remote CPU
requests a local reenqueue while the flag is set, schedule_deferred_locked()
leaves it to task_woken_scx(), and nothing calls that after activate_task().
Fix posted here:

  https://lore.kernel.org/all/20260916215713.2701551-1-tj@kernel.org/

Thanks.

-- 
tejun
