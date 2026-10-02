Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930CB4A3D47
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955907; cv=none; b=t8JsOLPo395FXoWZhJOyxGtakO/TcioLcEcSsoFlfRe5+RUXYXNKlnnM+Kq3yibamYvqz8LfnJ1gBXmSYQLMvi9IG61BQbUuPQnZcpDfWq8wI2ateHd7wWN4An1W9BALhVW9gNu/bKu28yGiqIYnwo7GObx0v2J7VoOxXkJdMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955907; c=relaxed/simple;
	bh=roQ+I76t66dW76scgQw9pjiRnMWgOPVRdkYnL8NPzn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Acaw1pgYCnjCFx2a1A7IADcOtuhip0yMFRi8dP4yen8SETS1oBsZiFqzeDu626GqPpu6DIceOdQ3Mmvnw1+oKk2k8dtmOzVfLi8RMzn4Ztwt+HkaqXsNeFX3/Hq78qGZgXR4qsH86xwtuCVOvQlaB/qBFC9Rf/J1sfmDdebc4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oS45ffHF; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oS45ffHF"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a003bd18e5so304505e9.0
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955903; x=1791560703; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CXWbEWQup2CohoVAuId1Sjm2fSC3KwGve55jJ8FlKzs=;
        b=oS45ffHFW2AF892Yn45wSGsRBdjgqODbzEMbfUhNSrxI8EyQ1eWrXgNC+StTaBcmr+
         IvwIA6Idctng1AYW1F2vfrA3SFHnhXDDloadHLJevAEVJhsd2uyKMzQJYnA/yu1/MvEn
         l29tnzePD5gkuIHT4/r2FzvVu5dV61DinkBtEma3AyqBJKYm4ghOEyevwaEuzHa65goK
         zoV9VTp7UZ9PS9+H6QQXa7ipXGRlCy+CtrNWgkVVNpkqqksFcL76rEviPKHZl0vOEGdL
         ZviD3DAXj9KFcJ4M/psvTyswOaCzRLc6t+xDIowTMxSk16UByBm8qFYI58+ZMLiO1Ev5
         89pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955903; x=1791560703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CXWbEWQup2CohoVAuId1Sjm2fSC3KwGve55jJ8FlKzs=;
        b=P6jSTRsu60EqZTm2mPvRMKEctUFfaZ+Vcom536RzQUKXKupPcWvBAsX1ziFahlmKZf
         7vTCcEVrOnubWtuap4BpLNLicCfqJzurJuF71kXDmPKSYW/svFIZSAg3qaknDXCXnwjN
         pzbNC5YzFn8DrnRaM08UlXEpTfS/LhAC2vfnhOkOtaSPkZeuoesjduwLn7nqMpGb1hwi
         ZfEGCjw4lz5lSN/aziR5TXOdFmbqqen3bplzsooVJxLOAMl/yQKimdehCQZt9Qa7P5dO
         3HIVKb35i6bcgpvz1kn8cEwCQx+ZPK2ysjHb797HaGy6mdx0f93UcklQaEWqDcDZbAUh
         0Ojw==
X-Forwarded-Encrypted: i=1; AKwUvBxlkOmuvX1z/FGwL/I2K8fySGBcmYFnGrehr0l+yuzejPi8c7tWmZR6DzuqHWLYHA1XJ0QaLzexHWc=@lists.linux.dev
X-Gm-Message-State: AFuF++m9nB3MitEHr+LK3KvXBTVFOKzjmb6OLCR1Djz5HGQW+/9sp4U2
	Z9mUzk0CMNkK4UrYRJ3u+Dh5tsbwr6xrXPDzmWCG4MHGxc36PxXFaj1kSCVf/+jvRIo=
X-Gm-Gg: AYBFou2NstNZu9rtRzmoRM3g93s2vqH9hEI+Y0/iKEIoawHBrWIEtq5KXK16mf2KBgf
	Uv2RlnxcOgV86v+p66A5DydFj9h2p7QIeIzQraXLDTa+d+xlX+cuiVVU0POqh/dSGllE0NMtXVH
	Wa76YzH4RQGtVdfuJ1QB1661tI3slJvXeZPEw2GQraZZRyPsqPasBEixKX5n4Xwh2RjksYQ5uGh
	l1zvBxXFtHgTW7htXqsf1ax9itWrA/Vc6KGZrpacPoEde1guWQCYy3et35mnUNWF95DaJCy0FZv
	qkE750Z2m5COi3b2MOZ8UV9uhYdKzrENEzxsyK9ut5e7t0bjgwH8KUzlnBOnlaAQ3yqDON0ORdJ
	g8c1s9c4DSoy62tG6Wq1V0R4sdujZap2L4dpjxIMUFakjZMo70CsxtLLu7sfaZwQLwYcuW/a5pJ
	+vjUhEK8wxR7at9IWIbr1wu+96uy/eyBSvoLTGhDpntBlDXVxJGjsSdECjrt9pEzQAdDywqyxGG
	S1oAw3e6KJENebx
X-Received: by 2002:a05:600c:3510:b0:49f:f963:7093 with SMTP id 5b1f17b1804b1-4a02769b3afmr54792455e9.23.1790955902620;
        Fri, 02 Oct 2026 08:45:02 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:02 -0700 (PDT)
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
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 00/18 v2] Improving latency of short slice tasks
Date: Fri,  2 Oct 2026 17:43:57 +0200
Message-ID: <20261002154415.2270586-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is another round of scheduling latency improvements which fix
some remaining corner cases and start to fix somes cases when multi
short slice tasks are running simultaneously on the system.

The first 3 patches of v1 have been queued so instead I have also added
the push feature to this version. This additonal push mecanism uses part
of on an old patchset [1] that I sent months ago focusing on scheduling
latency this time but being generic enough to be used for other features

This patchset gathers 5 different parts:
- Patch 1-2 implement decay of positive lag
- Patch 3-5 take into account slice when selecting CPU
- Patch 7-11 add push callback for fair
- Patch 12-14 use push for trying to migrate short slice task that failed
  to run at enqueue
- Patch 15-18 modify feec to take into account slice when selecting CPU

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
99.9th Percentile            128 |   120 (+ 6 %)
Maximum                      906 |   293 (+68 %)

scheduling latency (us) for cyclictest and rt-app
                   tip/sched/core| this patchset
slice                 8ms / 16ms |  8ms  / 16 ms
99th Percentile               65 |    66 (- 2 %)
99.9th Percentile            841 |   960 (-14 %)
Maximum                     4153 |  5026 (-21 %)

scheduling latency (us) for cyclictest and hackbench
                   tip/sched/core| this patchset
slice                 8ms / 16ms |  8ms  / 16 ms
99th Percentile               74 |    71 (+ 4 %)
99.9th Percentile	     645 |   513 (+20 %)
Maximum                     8737 |  4043 (+54 %)

Results are similar as the related patches have already been queued

For testing cases w/ multi short slice tasks, I run a new rt-app test that
wakes up simultaneously 4 short slice tasks while 16 normal tasks are
also enqueued. All tasks wants to run 1ms every 7777ms. The 4 short tasks
have an uclamp min of 512 to target the high and mid cores on my system
(1 task per core)
SIS_UTIL has been disable for the test because it adds noise in the
results by limiting the number of loop.

tip/sched/core
			Task-O		Task-1		Task-2		Task-3		
Average              |	2002		55		361		1631
Median (P50)         |	2589		57		64		1379
90th Percentile      |	2703		57		1287		2512
99th Percentile      |	2723		59		1296		2526
99.9th Percentile    |	3714		63		1314		2547
Maximum              |	3717		72		1326		2554

+ The patchset
			Task-O		Task-1		Task-2		Task-3		
Average              |	61		60		62		58
Median (P50)         |	60		60		60		60
90th Percentile      |	62		62		62		61
99th Percentile      |	64		64		64		64
99.9th Percentile    |	1130		1096		1130		69
Maximum              |	1507		1097		1131		76

On tip/sched/core, the 4 tasks tends to wake up on the same CPU whereas
this patch pushes the tasks which aren't picked on another CPU.

Beside the results above I noticed significants performance improvements
for hackbench with pipe which were not expected.
"sched/eevdf: Decay positive lag of sleeping entities" is the patch that
provides most of the performance improvements

The test were run with the default 2.8ms slice to check for some
performance regressions

hackbench             tip/sched/core   this patchset
 1 group process pipe 0,863(+/-1.1%)   0,752(+/-2.6%) (+13%)
 4 group process pipe 0,717(+/-1.6%)   0,601(+/-2.8%) (+16%)
 8 group process pipe 0,652(+/-0.6%)   0,540(+/-2.3%) (+17%)
16 group process pipe 0,634(+/-2.4%)   0,529(+/-1.9%) (+17%)
 1 group thread  pipe 0,919(+/-3.5%)   0,780(+/-2.3%) (+15%)
 4 group thread  pipe 0,851(+/-4.4%)   0,630(+/-0.6%) (+26%)
 8 group thread  pipe 0,760(+/-2.3%)   0,553(+/-2.4%) (+27%)
16 group thread  pipe 0,640(+/-3.3%)   0,527(+/-2.1%) (+18%)

Those tests have been run with perf scheduler (Using schedutil and EAS
provides similar results)

The improvement is a bit lower than v1 as the decay is less pessimistic.

[1] https://lore.kernel.org/all/20251202181242.1536213-1-vincent.guittot@linaro.org/

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

Vincent Guittot (18):
  sched/eevdf: Decay positive lag of sleeping entities
  sched/eevdf: Reset lag when waking up on idle cpu
  sched/eevdf: Add per cpu cached min_slice
  sched/eevdf: Compare min slice during wake_affine
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

 include/linux/energy_model.h |  109 +---
 include/linux/sched.h        |    1 +
 kernel/sched/core.c          |    9 +-
 kernel/sched/deadline.c      |    2 +-
 kernel/sched/ext/ext.c       |    2 +-
 kernel/sched/fair.c          | 1025 ++++++++++++++++++++++++----------
 kernel/sched/idle.c          |    2 +-
 kernel/sched/rt.c            |    2 +-
 kernel/sched/sched.h         |    8 +-
 kernel/sched/stop_task.c     |    2 +-
 kernel/sched/topology.c      |    3 +
 11 files changed, 780 insertions(+), 385 deletions(-)

-- 
2.53.0

