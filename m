Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984B39A06D
	for <sched-ext@lists.linux.dev>; Sun, 13 Sep 2026 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789304907; cv=none; b=Oz35rnoqepDYNPeQQOflrZnYKWPXf4WoL+01nGAENH9c8bTdVJMWl7D+Np7tmR5jUyemvUts4eP1BQboZuv3/h8/HbADp336GajPBXzwuhSEv4XC3wDk9PIcPK3B9Ygje7DQRgP9gulMdHNPXagSd56saqgpGWBy1uCylv/mCrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789304907; c=relaxed/simple;
	bh=25VHASD5cjOlWczoHO+wvaD9h9veY1XdGejCGPyH0T0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=AHcAoLNkL82X9TUfU75Z55y77pRBc0ykypW96feCt9wqaFIdAI54dblCoTRDW2ATmZf9PLVh3Z+jR77Z05JTlk0ZliZFjRqpfuS6QiKH6Enb9/2QlJVLzN7+u39z3LU2LgUHKbGeeDQTHvuBjg4SmXRaL/vdNjpEXX06bzLr/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TTIz/Ff2; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TTIz/Ff2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:Message-ID:From:To:Subject; bh=iq+j5Y36IPqCTqi
	wN5sH389DCis42pzhKcSl9IbT1M0=; b=TTIz/Ff2YUJBDunsFxd6/0vVHqMfhwp
	QV3VLs+CEmJfTlxEToqG1rqJx2g+Jmoq1h4xiXuER4zPSRdEg6v86zSHXu91G5nN
	qWU+xoL57EuQuJ+xScH0LuDuh6vLhdavsZfPFyAk/2gHcsk0EBsQ2I54xdE12wWD
	kJLTrZBEBLEo=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3N7gMoKZqT7TlAQ--.26916S2;
	Sun, 13 Sep 2026 21:07:25 +0800 (CST)
Date: Sun, 13 Sep 2026 22:07:24 +0900
Message-ID: <36503a3fb742ca20fa218ec190a50932.sh_def@163.com>
From: Hui Su <sh_def@163.com>
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: arighi@nvidia.com,
	bsegall@google.com,
	connoro@google.com,
	dietmar.eggemann@arm.com,
	jstultz@google.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	soolaugust@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH v5 1/4] sched: Dispatch task ticks for donor and execution classes
In-Reply-To: <20260913120814.1273086-1-kayracizmeci@gmail.com>
References: <20260913064722.1534766-2-sh_def@163.com>
	<20260913120814.1273086-1-kayracizmeci@gmail.com>
X-CM-TRANSID:_____wD3N7gMoKZqT7TlAQ--.26916S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF43GFykWr1UCF1Uur1xXwb_yoW8Zr4rpF
	ZYgF4rJw4kJFWFkr12y3Z0ga45Ca1fGFyDGrs8Gr48Zr98Xr109ryIqa40kFW3Grn8K3W2
	vr4qvas3Ja4jyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UAwIgUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwg1vzmqmoA1jvQAA3R
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi Kayra,

> Wouldn't it be better to merge this patch and it's use case together?
>
> The commit message is confusing too "Scheduler ticks therefore need to
> reach both the class which owns the scheduling context and the class which
> owns the execution context." But the patch doesn't do this on it's own.

You are right that patch 1 alone does not enable useful execution-context
work in the FAIR callback: the callback is still donor-gated there, so a FAIR
callback reached only as the execution class returns without doing FAIR
scheduling work.

That is intentional. I split the series so that patch 1 is a
behavior-preserving conversion of the sched_class::task_tick() interface and
the common dispatcher:

  - patch 1: generic donor/execution callback dispatch
  - patch 2: move NUMA tick work to the execution context
  - patch 3: move cache tick work to the execution context

Keeping patch 1 donor-gated makes the API and dispatcher change independently
reviewable, while patches 2 and 3 introduce the execution-context users.

I agree that the patch 1 commit message is confusing because its opening
paragraph can read as if patch 1 itself already enables useful
execution-context tick work. I will reword it to make the preparatory nature
explicit, for example:

  This patch adds the common donor/execution task_tick() dispatcher and
  updates the callback interface. Class-specific tick work remains
  donor-owned here; subsequent patches use the new dispatch path for
  execution-context NUMA and cache work.

I would prefer to keep patch 1 separate from patch 2 for now. It keeps the
sched_class::task_tick() interface conversion and cross-class dispatcher
separate from the NUMA semantic fix, and keeps the NUMA and cache fixes as
separate changes with their own Fixes: tags. If there is a preference for
introducing the dispatcher together with its first execution-context user,
I can fold patch 2 into patch 1.

Thanks,
Hui

