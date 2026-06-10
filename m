Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300AE3D8918
	for <sched-ext@lists.linux.dev>; Wed, 10 Jun 2026 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105258; cv=none; b=Fcyg/Q/8qGt5UNqluZlBe8sIEiHkyLFzl9qhngs8DFuX00Lj4HEeau1foFvqjFS1UupT4c0HVz7KDZ8AsZdm072q/4sQ/cM8frGRXSdoYc0SKKPKDEaknmeochy1FNMFtVm3sMkMfJlzlsKM//kPcMt7lNk/cY+u59VK6jf7Huw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105258; c=relaxed/simple;
	bh=6Bg0X6mwTP2+ImN1J2i6ndUpUub1QcdoDe2lQpBKbjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pT1lhAxDd8m72E6SyXSu1OssTwpFBZo7U79uO7XInnIj2PjeJE8cS5TBCDxvF2MrNtwfQ0Ub7RNDnQ5N9euv+ifRGXjGMAxtklYUBDmIYv3WY1db+6TfMiHQTITpBg8gtVzUqYsUTY+1Ajq+LrAhVHlFgD9csRRFKplPQGt5u+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8ZmW3Ae; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8ZmW3Ae"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso4812474a91.0
        for <sched-ext@lists.linux.dev>; Wed, 10 Jun 2026 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105256; x=1781710056; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p1UmrkVoqnDgoi2g7SQ5UlHE2AMC3tgS3t1nYgbC9co=;
        b=q8ZmW3Ae55tL74sORAQZhkjeySaLuFKSeO50MDDCGZPApKNK6sm76TU0f0dQsHEhQu
         wwtRxOL04MWFagy58mXVOb3xSd8yBCWJVRc+xg5OKVHlIxFDUWvboMNk7AW2H7myvAgl
         0k9v80DCstp0SmRetY+Ae+Scbc6jIou12G7RhN7YI/qVmGtwTTSNwFZwiFwYuHKZLALH
         p71+0cTYI62fzOEG80TnoJowBG7wS7CkAmyi5tj2gAwgzw+h5660AuLoMA+DCgf0HdEi
         rFQne4zbPOwFJ4T8+4Lr9Uh1o+Cwes9mr6v4+mVSp9oWCAwK5T5gb2+TrcU7k8h410J+
         iUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105256; x=1781710056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1UmrkVoqnDgoi2g7SQ5UlHE2AMC3tgS3t1nYgbC9co=;
        b=gTJeXCDO3tttwdcUZejg0A7SPQzeLuDYq1w4KAkCFb/UmpPRr9iEpmW8artH5byGbk
         IujGrDvahk8iPe+Mfcah89bSoEfMUnbZjcR/n2J8ZGX4eDpWXVEp8McBExItShZr+hnn
         uXNMIzNjbEc6p2uHsAndqq3NHkQYUNsXEE2uclsjOtEZEF6s3JFRsMau9cHr04AaL/KU
         3B/8ZHwOO8FW9f5osLeAiVNnx10ht4jF7dMueJod7XKWhCTbYQuF9ZoreLpkUhx/rDzq
         ukVaAJENccXPV7On0Bk3a75cocyifVlHoXs/8gO8ZY7cOyXbelDs9vUOAQZMNfhPdnTs
         fUOQ==
X-Gm-Message-State: AOJu0Yyf3VlQdikWBlmpk4QMKYbeVOZ1usY+5hmOSTupS8uUG7qUWX5L
	lXpkzpCAIys5Sba4h20ZnmRXe7lyfFrFreX9oGb6r7QYWoAyoJN18jPMRKOPrg==
X-Gm-Gg: Acq92OFYGiKfNbADUPsl5R9/seXlTOiEHJlqnnyomtckbIeT49oFpK6ZZ7rKkUun5nK
	A0jSIwtQqTxUmFxiKmZ3nflXMhIItKI3PSwfgI4pv5hNoPB2g44freot+UsSZkdP3Jf67CWILxP
	syXZYflyvr5Fjj7cLH0kV4VkPC71X928qU+mEd1fDbWdzmS7T/XHnZ0i/W9sjan1fErE1/CpUn4
	1WSzRJj4O4+rtC2iTjd8uaH95NjZ9pTgQlyxuOVhE8KlBSBgCuGt1pA+tnUieaqkQfTiUSzkDaE
	vWYDNS7oJpV+/FBPiwzWr6t5VK9ZbDJpwdQjBAEWeNet5e5KPCLx0S3lqWU6BmE7neS41reWdH+
	VbZ7z2UBVoePV4PmKpbfdIXPWQs80SFT+eV8RREMfiKNX4Cpq6EU7cUrm0HXEHEuM8kMqBeHhgU
	7y6ol8l/VHm8sYjODjJ+S8nPiEbjlz/GYXbzv9O72mwxoz/XelUegAcItOZ/7aJ4Rs9oPN59imp
	Z+RaqeshutQAyKuWMKZkQ26MDg=
X-Received: by 2002:a17:90b:48ce:b0:367:b819:2214 with SMTP id 98e67ed59e1d1-370f076d7e4mr31059928a91.13.1781105256103;
        Wed, 10 Jun 2026 08:27:36 -0700 (PDT)
Received: from cchengyang.tail151456.ts.net (36-226-225-196.dynamic-ip.hinet.net. [36.226.225.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e573sm253335795ad.47.2026.06.10.08.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:27:35 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	chengyang.chou@mediatek.com,
	yphbchou0911 <yphbchou0911@gmail.com>
Subject: [PATCH v7 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Wed, 10 Jun 2026 23:26:54 +0800
Message-ID: <20260610152717.15905-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yphbchou0911 <yphbchou0911@gmail.com>

Follow-up of Tejun's suggestion [1], discussed in v2 and the subsequent
review thread [2].

Patch 1 fixes exit_cpu accuracy for the hard lockup and softlockup
paths. For the RCU stall path, -1 is used as a placeholder until
patch 2 threads the cpumask.

Patch 2 upgrades panic_on_rcu_stall() and scx_rcu_cpu_stall() to
accept a cpumask of stalled CPUs, stored in scx_sched and piped
directly to scx_dump_state().

Based on sched_ext/for-next (180c5cefd174).

Changes in v7:
- Read smp_processor_id() once into a local variable (Andrea Righi).
- Link to v6:
  https://lore.kernel.org/all/20260531152646.1206799-1-yphbchou0911@gmail.com/

Changes in v6:
- Drop stalled_mask parameter from synchronize_rcu_expedited_stall()
  (Paul McKenney).
- Link to v5:
  https://lore.kernel.org/r/20260521161636.1893894-1-yphbchou0911@gmail.com/

Changes in v5:
- Replace dynamic cpumask allocation in both RCU stall paths with static
  rcu_stall_cpumask and rcu_exp_stall_cpumask (Paul McKenney).
- Link to v4:
  https://lore.kernel.org/r/20260519171745.1551340-1-yphbchou0911@gmail.com/

Changes in v4:
- Store stall mask in scx_sched rather than scx_exit_info (Tejun Heo).
- Use __GFP_NOWARN for cpumask allocations in both RCU stall paths.
- Link to v3:
  https://lore.kernel.org/r/20260518131311.1170786-1-yphbchou0911@gmail.com/

Changes in v3:
- Drop patch 1 of v2 ("Normalize exit dump header to 'on CPU N'"),
  already applied to sched_ext/for-7.2.
- Replace single stalled_cpu int with const struct cpumask * in
  panic_on_rcu_stall() and scx_rcu_cpu_stall() (Paul McKenney, Tejun Heo).
- Thread cpumask through the expedited stall path (Tejun Heo).
- Falls back to cpu_none_mask on allocation failure.
- Link to v2:
  https://lore.kernel.org/r/20260504161543.674488-1-yphbchou0911@gmail.com/

Changes in v2:
- Use raw_smp_processor_id() in synchronize_rcu_expedited_wait() to
  avoid CONFIG_DEBUG_PREEMPT splat.
- Link to v1:
  https://lore.kernel.org/r/20260501131521.161852-1-yphbchou0911@gmail.com/

[1]: https://lore.kernel.org/r/e7cbfc99b52b4b7059267bb81498179f@kernel.org/
[2]: https://lore.kernel.org/r/af0Gn47y1Lj2BAqd@slm.duckdns.org/

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Fix exit_cpu accuracy for lockup paths
  sched_ext, rcu: Upgrade RCU stall paths to report cpumask of stalled
    CPUs

 include/linux/sched/ext.h   |  4 +-
 kernel/rcu/tree.c           |  3 ++
 kernel/rcu/tree_exp.h       |  5 ++-
 kernel/rcu/tree_stall.h     | 13 ++++--
 kernel/sched/ext.c          | 86 +++++++++++++++++++++++++++++++------
 kernel/sched/ext_internal.h |  3 +-
 6 files changed, 91 insertions(+), 23 deletions(-)

-- 
2.43.0

