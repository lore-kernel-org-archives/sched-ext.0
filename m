Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD85390224
	for <sched-ext@lists.linux.dev>; Thu, 17 Sep 2026 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789631588; cv=none; b=SUNbRaPLbcsJt9XMI8TrKYLHEYNpATAjikzX14xx6CbhJ/0oE/RTffW8WbW2Xz52WPX0PMGIk5VbITEko8zpjsE9pe0+W5CyvH2LsPotsbl6N2H8yXTDFT1zO/KvThVWWmI615R+2VYrfK/D7CS3S8Tvl+EqC3MqbRufPx5yU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789631588; c=relaxed/simple;
	bh=iKsVo0ZubUN1LonjXifQ7VLw5AT3xBEJIcyNJ45ZduM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P+S+2M7AQhLhT+eQGGNqI3N9IwMkUVUQlnTFU47vr12KNgbY+qDs13ihhLqsSwI7nvqbugLFCy5NyKaUxTy40jIKIKKcAY6wo+O9WeodE95s+r9ibJs0dVAyvCwtgpcegal8eQlS65oKxAXdD6Jwa30oidyjlFswxYHON605NAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c90b3c1eb26c11f19a56ed5b684f684d-20260917
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:04faa1c7-cb26-4199-bc90-6348d88167af,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:716258d18b5d99c66735db4288bb3f07,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	5|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c90b3c1eb26c11f19a56ed5b684f684d-20260917
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 670414630; Thu, 17 Sep 2026 15:52:52 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] sched_ext: Don't run ops.dequeue() with a DSQ lock held
Date: Thu, 17 Sep 2026 15:52:40 +0800
Message-Id: <20260917075242.2813147-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

The consume and move paths invoke ops.dequeue() with the source user
DSQ's lock held, self-deadlocking any BPF scheduler which locks the
same DSQ from ops.dequeue(). Move the invocations after the DSQ unlock.

v3 -> v4:
- Reword the terminal-branch comment: the callback runs after
  @dsq->lock is dropped, not "unlocked" - the rq lock is held on every
  path (Tejun Heo)
- Drop the unused @src_dsq parameter of scx_move_local_task_to_local_dsq()
  (Tejun Heo)
- Fix the dangling "there" in the commit message (Tejun Heo)
- selftest: reword the header comment and poll from run() directly
  instead of from a worker thread (Tejun Heo)

v2 -> v3:
- Restrict the deadlock description to the two user DSQ paths; keep
  the global/bypass move for the shared DSQ lockdep class (Tejun Heo)
- Drop the ordering sentence and the doc change until the DISPATCHING
  reenq hole is fixed (Tejun Heo)
- Open-code the ops.dequeue() invocations and drop call_task_dequeue()
  (Tejun Heo)
- Drop the __scx_move_local_task_to_local_dsq() split; unlock @src_dsq
  right after unlinking (Tejun Heo)
- selftest: add ops.select_cpu(), record UEI and check SCX_EXIT_UNREG,
  fix the watchdog wording (Tejun Heo)
- Set ops.timeout_ms to the suite-standard 1000U
- Add Cc: stable # v7.1+ (Tejun Heo)

v1 -> v2:
- Drop the claim that ops.dequeue() may run after the task has
  re-entered custody: SCX_OPSS_DISPATCHING is held across the callback
  on the global/bypass path and @p's rq lock is held across the
  callback on the user-DSQ-to-local paths (Andrea Righi)
- Add a selftest whose ops.dequeue() iterates the source user DSQ
  (Andrea Righi)

Patch 1 carries Andrea's Acked-by from the v1 review.
Link: https://lore.kernel.org/all/20260916070753.3343113-1-fangqiurong@kylinos.cn/

fangqiurong (2):
  sched_ext: Don't run ops.dequeue() with a DSQ lock held
  selftests/sched_ext: Test that ops.dequeue() can iterate the consumed
    DSQ

 kernel/sched/ext/ext.c                        | 44 ++++++------
 kernel/sched/ext/internal.h                   |  3 +-
 kernel/sched/ext/sub.c                        | 10 +--
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../selftests/sched_ext/dequeue_iter.bpf.c    | 73 +++++++++++++++
 .../selftests/sched_ext/dequeue_iter.c        | 79 +++++++++++++++
 6 files changed, 181 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_iter.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_iter.c

--
2.43.0

