Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793407645;
	b=Bdgo965zdNXyJCb7XjjKL/tRngZUCZg1jFrR0K/A4c/PH3d3kRXVbaDbZfQCa291aSgg
	 r+VKolfDXvVhpotUA5i/Cz1ie+pf9a8/KC7rpIc7KL+eCzCVkl1Yd8KpGEOQQV/COSSrB
	 1g7YPBFRruZplktDOtCyEDFe55u/b0rb7o5xE7Okh7D5WH4AosMKv2uvO4EJbrbJHMDPT
	 6M8sBpzR6Bfgu6MYqwiqeB5S2FT0Fdu3nnE/zzJxZSnTtg7KgoHCLLdjKNkMKIYZnGHyC
	 YCi8o6bUgn/m9mgKoPTFEegHoW9w1a24Y/rdfCa0F6TshbWMgSL6Flwz7MGBzrsNG4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793407645;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gICekddm+mAtn+ovZE3h1rRofC0U8eOQNuHmng1tQgk=;
	b=NHyF3G/3IM4UhxIvQgABHIrn0o1UrbdaIY2DoB8ZQyQKe1w+gRVuwuogPWbNzSQ+9Qok
	 7QpElFoccHNlwOxL/Po8lJaMhW3sHikKJiUH5N53dieV/I+SqEr/esroIs+2Bx5KpYgIo
	 v/uI2NPOSBXvPatwWod3OLHVAGEiA15ZuMOD6Yizu2jeX6HTAQFbmGBaoxPrKSMwL1X2Q
	 zHBQ0/Tjfawdy/eLKrTsxj5YuWpIlHhDT9LKJ+lknLgybzXO6gqsHS+a7KsSrQaCHt/Kb
	 5ifWjf/o3mPKz65aLmFXMupMat3F4Z6TM4f3kSbPnRMgSzPinv9iEln6aDPDuDF42AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbHkAiSS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA1606A31A;
	Sat, 31 Oct 2026 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbHkAiSS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3351F000C1;
	Sat, 31 Oct 2026 00:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793407644;
	bh=gICekddm+mAtn+ovZE3h1rRofC0U8eOQNuHmng1tQgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HbHkAiSSwMzvNBXoYFivoCfMEWS0OqcwdsYj3mTbqghgp7vwwIybQSTG5YfoReW3K
	 w+FcP02Y2K335A8q58tNkj/i8qft/eQ8PGcDwApJ23xOldMxd1vdjzeqqJzR878f6W
	 cQI6qwubl2KjTHsOwV7XGzWICnPOMrjHpVIosUDCjnGgFzQ/OmBNkoLPuI2LhI4/uU
	 7n6sFQbFYNKOtLn5hLoNQ7hxaPVuApck7jhn4ooisjKtk86Q4JQnQlePUku/DSG1QL
	 Q9XuRhw98XpYPbSOKkS5Rg4/ulYscecaWNi4lI7qHu9+Pi/QE8rxtvJK+nybxEcTN2
	 8T4l48YXvonaw==
Date: Fri, 30 Oct 2026 14:47:23 -1000
Message-ID: <1a24bcdde0bb6e4a8c839351002e841d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Luca Abeni <luca.abeni@santannapisa.it>, Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: sched/deadline: total_bw leak when a task leaves SCHED_DEADLINE while not queued
In-Reply-To: <auRh42kZI1xLIWNr@jlelli-thinkpadt14gen4.remote.csb>
References: <2b5fb3f22bca6aa383be8f4781923392@kernel.org> <auRh42kZI1xLIWNr@jlelli-thinkpadt14gen4.remote.csb>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Juri.

On Fri, Oct 30, 2026 at 10:22:43AM +0100, Juri Lelli wrote:
> Does the below help?

Yes, it fixes the leak. On abf8c33470f7 with the patch, the reproducer leaks
0 in all three cases, and 60s of random policy churn ends with total_bw back
at its starting value. Two problems though.

sched_setattr(SCHED_OTHER) with SCHED_FLAG_KEEP_PARAMS on a sleeping
DEADLINE task leaves it DEADLINE, but each call releases its bandwidth, and
its exit releases it again. total_bw relative to before the task became
DEADLINE, with a 2ms/10ms task (0.2 CPU = 209715):

  after the DEADLINE set        +209715
  after the 1st KEEP_PARAMS call      0
  after the 2nd                 -209715
  after the 3rd                 -419430
  after the task exits          -629145

After that, sched_setattr(SCHED_DEADLINE) for a new 2ms/10ms task fails with
-EBUSY while a 3ms/10ms one is admitted, and offlining a CPU fails with
-EBUSY.

Switching a sleeping DEADLINE task to SCHED_OTHER after its CPU was offlined
crashes in the __dl_sub() the patch adds, dividing by
dl_bw_cpus(task_cpu(p)), which is 0 for that root domain:

  Oops: divide error: 0000 [#1] SMP NOPTI
  RIP: 0010:switched_from_dl+0x13a/0x3e0

Unpatched mainline only leaks in this case.

Thanks.

--
tejun
