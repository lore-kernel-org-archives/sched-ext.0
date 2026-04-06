Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF918B0A
	for <sched-ext@lists.linux.dev>; Mon,  6 Apr 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490588; cv=none; b=WHAHZ483VIJ9DaTFNdKLEoYUuYco44Cz1EZ5rgpEoMVaEzky4gAcnVHqgAndLdbCco3V6qm0jAUkJlcoE4BMisAvQ8ZZqYKdxGeloZg+RQHXXA7cSHOJSpYzybSy5MinTMl5/gLzrJIt5sFa7z/OcLQ/zUJqJ0UssrG74Lu9U60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490588; c=relaxed/simple;
	bh=pG0oFIwimXcdXgYuTv9T7FKV9Rw9s/4++Sug2IBP/t8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bd03Z7H+xejO5UbKB9ZRIgAFWy0s8rT0E1zrg3THtYwuDKlO2uOKIY5Ty7jyA0pu8EfOybeaGb9KtvTXG2QaapxEh+HyH0Q1SD5O7f1KgGZhMePfUzpFjWGA+iwqstyCrzeSS+F4cQr0LBPWmsZKh3AdLmxmR6TNXyfVHVszH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPmZjXJi; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPmZjXJi"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so3836312a91.2
        for <sched-ext@lists.linux.dev>; Mon, 06 Apr 2026 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775490586; x=1776095386; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sHQmUKRospAwmgoQcSmUofi0JlVasGancc6jWGDOhYs=;
        b=YPmZjXJiwv0L6cHz5XIFMlWJk5u2jMXslgelGIbkBOYYbj/PGKnzL0XH7+xPUgAeTX
         S/XnLdeQxp3bl5egvKQyPW/g0BK/hff4ZF9+CIOM5cVmIp7VrPEML0ci1Z11U66XdBi9
         XmvjVG5x3UWNjBmHnVp5lkgkTbMh/l4TjjuIY/zwP1tj5RpSihqmeclIElVdzyv4oDXK
         SaudpKv5dY17SbfpZpZLW0qpERkbVFaDOv2RSW5ed4ahVC5gzb7S0g4HVDUcUdC9/gYH
         9ZMJ1C3Wndi/ZHQI1iPKCD+eJxS2ghU3syvM+mnKzXtutuWLM1MKkfJo+O0dB517h+Sn
         2Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775490586; x=1776095386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHQmUKRospAwmgoQcSmUofi0JlVasGancc6jWGDOhYs=;
        b=P6cXeGbLrJ0NZDsAaQe6QLCSvMvyXeFrvFmBDNUBOHSNCkG3kaMAcWx44RBSZiNvVj
         aWZ1h+6B9rlQPAC0fY5hyoWle/XQVwMDWiehtN6tahxw9ix1P0bWYHHst0Kxy9KzFot5
         n/P2py92kPnlBW7o0h3sYYRXE0ilQt2q3X/VYEw8w86vbuK3eDEF3uP8WoMYNGroJCMq
         0Uqsam02Be0RjvL+7XAzJUiwiUowtmW0dzvBs52ZWbKUFnYDJDBMws/kd6P5rT23YijX
         bxrOYSa49I+AcdiyW7fH4O0xc/ooccZyQQanhO3K+Wr9ZKyTTMsYwVnTuE8VVt2d2x26
         JKQA==
X-Gm-Message-State: AOJu0YxnmOU7yjcLXHQJ5giiEg3SBS89EtED3g5I9EffdFczFI8eK8p5
	oGtXJ7DVxMn9QSwerVp08+aHCXunhRFI3btxhA0A83awfErpJfxQwTFTn4VS4g==
X-Gm-Gg: AeBDieuJDIQDsWCn9RdV3n+/XS3bjrKhti0IHQP5BxQKQm+ljSeYVBG0fAo4VvwovBx
	N2dzTybxj7PLY4uhMCJrhJ8MK9RHJGW1ofDAFUpX+OSlrUmZ+PlSyHNOSYGpf/N4eMsdEOc2ScQ
	3C7nlvUdw5A4SC8GlQRC/FFos9r+ugHTNTFYiY2SzYZ3Wbc51NVKW4zv7/FuvClO0BdheCb4pLb
	3u+F1KOugxSXPgM00qem5tjM1mIA0Njl7LtIT8E1pC0WY//XEWJO7riTZlraphs1h+gb1mV7L9W
	0c++6eHVdlClZ/qfRQR+7kc/trNRp/AqWrH0LdrAQvvFylEE0lb7Rbm4r3ss4sXWzV7oqrPtBkz
	brxa7YQVyGFvFYn2GckPyf83kdkngyNWXF7lQ87FFV69NcRAdyjz9fQuxDpwYZ9TG5v5ybLPcm0
	qYU+Ov0qH3Jwl+P8Wa6H52itfRW5UdSD21skNrmu1e70eU/g+MFVqV
X-Received: by 2002:a17:90b:3bd0:b0:35d:8fd8:d893 with SMTP id 98e67ed59e1d1-35de67eb212mr13274833a91.7.1775490585763;
        Mon, 06 Apr 2026 08:49:45 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:6100:c268:4a0b:d6d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm14186609a91.6.2026.04.06.08.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 08:49:45 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [RFC PATCHSET v4 sched_ext/for-7.1 0/2] sched_ext: Make kfunc filters support struct_ops context to reduce runtime overhead
Date: Mon,  6 Apr 2026 23:48:30 +0800
Message-ID: <20260406154834.1920962-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

First of all, thanks to Juntong for letting me continue his work!
Since he is out of bandwidth to work on, and Andrea pointed out that this
is a feature that may benefit the sched_ext community (thanks Andrea as well).

In this patchset I add myself as the author, while keeping Juntong as
Co-developed-by/Signed-off-by to honor his work.

Please let me know if this is not appropriate!

---

This patchset makes kfunc filters support the use of struct_ops context
information to enforce SCX kfunc restrictions at BPF load time instead
of at runtime.

With the improved kfunc filters, SCX no longer needs the mask-based
runtime kfunc call restriction, so this patch series removes it.

Test plan:
 - All sched_ext selftests passed.
 - Tested all demo schedulers (except scx_flatcg) and multiple upstream
   SCX schedulers (scx_beerland, scx_bpfland, scx_cosmos, scx_flash, scx_lavd)
   under stress (stress-ng --cpu 0 --timeout 10s) with no crashes.

[RFC]
I noticed some selftests are still missing, but I am not sure what kind
of tests to implement here. Any suggestions would be appreciated.

Thanks,
Cheng-Yang

---

[Cheng-Yang Chou]
Changes in v4:
 - Rebase on tj/for-7.1 branch
 - Remove TRACING access to select_cpu kfuncs. They call task_rq_lock()
   internally and are unsafe from arbitrary tracing contexts
 - Update scx_bpf_task_cgroup() comment to reflect that the restriction
   no longer guarantees rq is locked, only that @p is one of the tasks
   being operated on
 - Add prog->aux->st_ops check in the context filter to avoid incorrect
   kfunc restrictions in non-SCX struct_ops where member offsets carry a
   different meaning
 - Fix ops.enqueue() to also allow select_cpu kfuncs (SCX_OPS_KF_SELECT_CPU),
   so it can call kfuncs such as scx_bpf_select_cpu_dfl()
 - Allow select_cpu kfuncs from BPF_PROG_TYPE_SYSCALL progs in the filter
 - Update scx_kf_allowed_if_unlocked() to use scx_locked_rq() and
   kf_tasks[0] now that kf_mask is removed
 - Drop selftests update patch: ops.enqueue() now allows select_cpu kfuncs,
   so the expected-failure logic is no longer valid
 - Use SCX_KFUNCS_* macros to deduplicate kfunc IDs across per-group sets
   and the aggregated set (Tejun Heo)
 - Fix [SCX_OP_IDX(dump)] to use SCX_OPS_KF_UNLOCKED instead of
   SCX_OPS_KF_DISPATCH, since ops.dump() is a sleepable callback (Tejun Heo)
 - Fix SCX_OPS_KF_UNLOCKED enum value to 1 << 0 (Tejun Heo)
 - Fix non-SCX struct_ops filter to deny rq-locked kfuncs and only allow
   unlocked kfuncs (Tejun Heo)
 - Fix missed SCX_KF_REST in scx_prio_less() (Andrea Righi)
 - Merge "Declare context-sensitive kfunc groups" and "Add
   scx_kfunc_ids_ops_context_sensitive" into a single commit (Tejun Heo)
 - Link to v3:
   https://lore.kernel.org/r/AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com/

[Juntong Deng]
Changes in v3:
 - Change scx_kfunc_ids_ops_context to the more descriptive
   scx_kfunc_ids_ops_context_sensitive
 - Change the target to sched_ext/for-6.15
 - Remove RFC tag
 - Link to v2:
   https://lore.kernel.org/r/AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com/

[Juntong Deng]
Changes in v2:
 - Use completely new design in filtering
 - Link to v1:
   https://lore.kernel.org/r/AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com/

---

Cheng-Yang Chou (2):
  sched_ext: Add verifier-time kfunc context filter
  sched_ext: Remove runtime kfunc mask enforcement

 include/linux/sched/ext.h   |  27 ---
 kernel/sched/ext.c          | 430 +++++++++++++++++-------------------
 kernel/sched/ext_idle.c     |  20 +-
 kernel/sched/ext_internal.h |  71 +++++-
 4 files changed, 288 insertions(+), 260 deletions(-)

-- 
2.48.1

