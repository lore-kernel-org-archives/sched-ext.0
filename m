Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978393;
	b=rJAiP5nuocjLeGXZ0De/YdzSBvr1LTOUIlSU0x3+0V5DJqdKYrIiiy2Oc2bXe9aiPoav
	 wD/h55BoZtb705UPmaPNxjfAGfpHpUncLM+etsOfKT8ajbDDApuNsRTI0vNE9u2d6vI5N
	 i+LX0gnBFkrECc/2mWg8HpTO95xvM9278T8ajZqCPF/Xe46SC+/vwPYF9mcU27zEmE9fm
	 lbIKEx1zJ3GRNf36B/TmR1s7UjvgeUam/FXxanJy+j0SYMb+GimJXgOYEh761s2q0oJaR
	 k1763Cxexrc66Xnd+ooI8+N79jR6UodRMyUXEv36Hs8oO8C5MmExpV6DEFDSfXdDyVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3gBLDmfOFqzDBEdd0Idmiin6AHrC4gxbENwGxw/e9rM=;
	b=fRvuqm+VgMrOHZ7weOicY8lQJnjBTf7c0kEY2uSXO1nphwo/j6ro48Jkd7KkBOpWb6wP
	 sr9Uq6ArS1omPcji/ecxint+sl9GMNt+eI8gAzS/jOpCJRIiViudTYpyJm4UguhLlZ3SR
	 2W+xgzbivmRw9+Y1lcsQob9gQqWV0E/jbihfJr0zESxbLcmEC02lrJA4z4iL1N4MhrTj/
	 s/j7SGd+kffxKyL/W3UXz1I2TRRGjgi0/7NO9pK0/JiPfWptKbQEdbZ6OYajjIVLnqyx0
	 28s03IPUDBSRgGQgtfT5yZFXIFwwzjhTwonGxOf7jvWx00yCNs174fvCRxwuv4JyIwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tqSWZEzq;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E6F606A32E
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3E6F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tqSWZEzq
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-49134c8509fso678391f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978391; x=1794583191; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3gBLDmfOFqzDBEdd0Idmiin6AHrC4gxbENwGxw/e9rM=;
        b=tqSWZEzqLCaetV0UCEJ/oTI9TQ9JBX1W6iZk9qzp4Lpv/A1izraeHYHq7Kx8G8MMzj
         AeSB1r19mc0S0SplyNMSGfismK221MYVn7onoTaZVxEor6dhY3RWbmqsDPIgJVWRG2nx
         C+Ya2EThrWvgijBBe2ZH0Il3KP1fSehgznCNUK1W/RFMhV8lHj/8GAt/sRuv3KMr5u75
         8e/EWHKN+gs5P+7FMmtnOfeYQGNz9WfHAtAz7GG+JiS9q4csVP91C5Jxh8bKezmlv+zi
         ELkUNNgLtUPk1fdAWMk3y/rh8BkENNZH/UbFQLt6giqq91g/XyqFob0zwjjHdgrYz01X
         uogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978391; x=1794583191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3gBLDmfOFqzDBEdd0Idmiin6AHrC4gxbENwGxw/e9rM=;
        b=1uTigfGt5YQqJfny423tjFgJt53oUFffuOqhMx/fQJHpYJ3QW3j6ncC4d7WnWzAyQH
         G5WNobh8TGLj6NtmktS7jIL893AmcQGT6CmHLlvozSZ1deSAi4JNKQu1U+Q98tAohWxA
         LDY3VeLIjQb2CMWEbqw6foH27J28HsGoG84cQl9xW9N05Me40xVwIwexqBBzNMvqPCH1
         m0KmSidY82t6xwgcw1vF6sTObIuBwzhDUdjtP0uMgM1rIhnXFXvbzWPE5zU+Z6dntCbr
         vtpcBa785wgYlRVEqw4poSTlXNQxFUFLSTKFpGBw7iD+UKLLQau0FhF+XiuzQkpaMHrK
         xHRQ==
X-Forwarded-Encrypted: i=1; AL+hErEWM8z+qUm0vcZTRIlmhkm2rplhhh8oAggJRkazm/Z+O5vTiv1HHJpze1OW1jWycCXYibSBf0aYl7I=@lists.linux.dev
X-Gm-Message-State: APuU4Z8PVwrGr5Cp+sY+dDA+Cgf5NZDkrDH+cay6lgJfivdAQBr2HpTO
	Ki82Aj8Q9tz4GJuPaTZiHdhwHXC8O0i+w8cycVnY6FrWo639odEnNqC/r98NcpxctFI=
X-Gm-Gg: AYBFou19zzX5VPoJkiLldPLyIFiDYioBk45hegv+QDXI5rIA64E8IqE0/a03i20EXdV
	2PElm7vWUmWh87t/Ub2fnFQB/3mftFAGnHp+msAvBwGawhELLR+EvI2djSE6TWjyn0CiWJVgwb1
	+I53d0hsVldyKQWf79Do0aYDcwk01SNwRRmtBeXSTeWQyOB3rAgYCYnFXawaRQdFN6U/LlkEgWi
	Q1nWaTAvQ/52TjEE8ATtj3KFONg1t6gn8cB/2a+jj8L4s9iRsGwDdNcOXDnh8ZTR+IktdYdeGoM
	EttJR8IVEP+C+c5T407Khgsn1TbXNXuuv4qUco1L6WFxPnlj/vSQelIDSVCpsp4FI3eCkZ4LBFo
	O1iKOAYRJxDK9Rqc1bv/JaxmvJ9oNUEQpPRf7ZwfbU4JMNdy6cPRqtLlT1b4EPO8ozsyBeS1v29
	6t34sKZse/zSlJhU1wzaqBARKBv6tCB0yMm9cB/zVuYZdfznff4fhVdKxkP2e43dfHL77FWMyWP
	7vFrGWVAYu9Gr/yUeKnIHqWP10sA0Q+GqYbj03IzsHOuGzDBKdfokyMZGhsfl9SHtTuY9IVvb2o
	FXaoEjEfYYSGwAy9iU0OdlU67/poOTGYp7uurfleIaJFXac=
X-Received: by 2002:a05:6000:1861:b0:493:803e:800f with SMTP id ffacd0b85a97d-493803e802cmr2233344f8f.29.1793978390924;
        Fri, 06 Nov 2026 07:19:50 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:19:50 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: qyousef@layalina.io,
	christian.loehle@arm.com,
	pierre.gondois@arm.com,
	sshegde@linux.ibm.com,
	kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 00/18 v3] Improving latency of short slice tasks
Date: Fri,  6 Nov 2026 16:19:27 +0100
Message-ID: <20261106151947.3991524-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is another round of scheduling latency improvements which fix
some remaining corner cases and start to fix somes cases when multi
short slice tasks are running simultaneously on the system.

This patchset gathers 5 different parts:
- Patch 1-4 implement decay of positive lag
- Patch 5-6 take into account slice when selecting CPU
- Patch 7-12 add push callback for fair
- Patch 13-15 use push for migrating short slice task that failed
  to run at enqueue
- Patch 16-19 modify feec to take into account slice when selecting CPU
- Patch 20 handles case where several tasks select the same idle CPU

I run my usual set of scheduling latency tests on dragonboard rb5
- cyclictest with a 3777us period and a 8ms slice alone
- cyclictest with a 3777us period and a 8ms slice. 2xNR_CPUS rt-app
  tasks that run (8177us) and sleep (17777us) with a 16ms slice.
- cyclictest with a 3777us period and a 8ms slice. Hackbench with
  1 group using thread and pipe and a 16ms slice.

NB: periods and run duration have been chosen to minimize alignment
with tick or other periodic activities.

Each test is 130 seconds long

scheduling latency (us) for cyclictest
                   tip/sched/core| this patchset
slice                 8ms        |  8ms         
99th Percentile               91 |    92 (- 1 %)
99.9th Percentile            128 |   161 (-26 %)
Maximum                      273 |   223 (+18 %)

scheduling latency (us) for cyclictest and rt-app
                   tip/sched/core| this patchset
slice                 8ms / 16ms |  8ms  / 16 ms
99th Percentile               65 |    68 (- 5 %)
99.9th Percentile            986 |   913 (+ 7 %)
Maximum                     6229 |  5715 (+ 8 %)

scheduling latency (us) for cyclictest and hackbench
                   tip/sched/core| this patchset
slice                 8ms / 16ms |  8ms  / 16 ms
99th Percentile               74 |    90 (-22 %)
99.9th Percentile	     643 |   997 (-55 %)
Maximum			   13501 |  4454 (+67 %)

The 99.9th percentile are a bit worse mainly because of the decay/reset of
positive lag. Eternal positive lag was beneficial for cyclictest which
doesn't do anything while running and slowly decrease its large positive
lag. Now its positive lag elapses while sleeping and cyclictest is
enqueued with a null lag most of the time. On the other side this reduces
cases where long sleeping task with large positive lag can preempt or
prevent short task to run first.

For testing cases w/ multi short slice tasks, I run a new rt-app test that
wakes up simultaneously 4 short slice tasks while 16 normal tasks are
also enqueued. All tasks wants to run 1ms every 7777ms. The 4 short tasks
have an uclamp min of 512 to target the high and mid cores on my system
(1 task per core)
(SIS_UTIL is not disabled unlike for v2)

tip/sched/core
			Task-O		Task-1		Task-2		Task-3		
Average              |	1051		  52		1051		1093
Median (P50)         |	1091		  53		1091		1092
90th Percentile      |	2133		  53		2132		2133
99th Percentile      |	2400		  53		2398		2394
99.9th Percentile    |	2519		 120		2518		2408
Maximum              |	2523		1327		3097		2415

+ The patchset
			Task-O		Task-1		Task-2		Task-3		
Average              |	61		61		60		61
Median (P50)         |	60		60		60		60
90th Percentile      |	62		62		62		62
99th Percentile      |	62		62		62		62
99.9th Percentile    |	1839		2012		63		2175
Maximum              |	2175		2066		2176		2689

On tip/sched/core, the 4 tasks tends to wake up on the same CPU whereas
this patchset pushes the tasks which aren't picked on another CPU.

Beside the results above I noticed significants performance improvements
for hackbench with pipe which were not expected.
"sched/eevdf: Decay positive lag of sleeping entities" is the patch that
provides most of the performance improvements

The test were run with the default 2.8ms slice to check for some
performance regressions

hackbench             tip/sched/core   this patchset
 1 group process pipe 0,862(+/-3.9%)   0,839(+/-1.3%) (+ 3%)
 4 group process pipe 0,725(+/-1.5%)   0,593(+/-1.3%) (+18%)
 8 group process pipe 0,640(+/-4.2%)   0,546(+/-2.2%) (+15%)
16 group process pipe 0,620(+/-3.9%)   0,528(+/-0.8%) (+15%)
 1 group thread  pipe 0,917(+/-2.8%)   0,907(+/-2.2%) (+ 1%)
 4 group thread  pipe 0,838(+/-4.5%)   0,697(+/-3.6%) (+17%)
 8 group thread  pipe 0,774(+/-1.5%)   0,583(+/-2.5%) (+25%)
16 group thread  pipe 0,628(+/-2.9%)   0,548(+/-2.1%) (+13%)

Those tests have been run with perf scheduler (Using schedutil and EAS
provides similar results)

Changes since v2:
- Remove min_slice comparison during wake_affine which didn't provide
  benefit at the end
- Added reset lag when migrating
- Fixing stacking on idle cpu case
- Tried to cover all the comments I received in v2 and more while running
more test and reviewing the changes

Changes since v1:
- Change decay_entity_lag to take into account cfs load but not
  migrated task yet.
- Reset lag if the CPU entered idle while task was sleeping.
- Move lockless min_slice in struct rq and use usigned long
  which is enough for slice which stays in range [100us:100ms]
- Merge min_slice rq selection in select_idle_capacity() and
  select_idle_cpu()
- Add push callback mecanism for cfs
- Push short slice tasks that are not selected at wakeup
- Update feec() to take into accoun slice when selecting a CPU

Vincent Guittot (20):
  sched/eevdf: Decay positive lag of sleeping entities
  sched/eevdf: Reset lag at wakeup when prev CPU has been idle
  sched/eevdf: Reset lag at wakeup when migrating and prev has been idle
  sched/eevdf: Reset lag when waking up on idle cpu
  sched/eevdf: Add per cpu cached min_slice
  sched/eevdf: Add min slice check when selecting CPU
  sched/fair: Prepare select_task_rq_fair() to be called for new cases
  sched/fair: Add push task mechanism for fair
  sched/fair: Optimize push task mechanism for fair
  sched/core: Add rq flag to tick parameters
  sched/fair: Add force push task mechanism for fair
  sched/fair: Support not wakeup case in select_idle_sibling
  sched/eevdf: Try to push short slice task on a better CPU
  sched/eevdf: Push short slice task that are not picked
  sched/fair: Enable push task for preempt short
  energy model: Add a get previous state function
  sched/fair: Rework feec() to use cost instead of spare capacity
  energy model: Remove unused em_cpu_energy()
  sched/fair: Take into account slice in EAS
  sched/fair: Fix tasks stacking on same idle CPU

 include/linux/energy_model.h |  109 +--
 include/linux/sched.h        |    1 +
 kernel/sched/core.c          |    8 +-
 kernel/sched/deadline.c      |    2 +-
 kernel/sched/ext/ext.c       |    2 +-
 kernel/sched/fair.c          | 1244 ++++++++++++++++++++++++----------
 kernel/sched/idle.c          |    2 +-
 kernel/sched/rt.c            |    2 +-
 kernel/sched/sched.h         |    8 +-
 kernel/sched/stop_task.c     |    2 +-
 kernel/sched/topology.c      |    3 +
 11 files changed, 938 insertions(+), 445 deletions(-)

-- 
2.53.0

