Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A246401A08
	for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542514; cv=none; b=QRAAqkyGOoxBCtD7iTfq4ua34z/TMQT/rscya4HPjIhsa/qpyg1TGCiX4ylpP/onMoVruMAOzkexE59S8hDsBJrKL20JrmqL5w6oXyD02nX+atF4BaXenZVvojAkS8kH5ZK9fandeQhmKkzy1qKMVtBtOPSuXT6LIhwZIzsaJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542514; c=relaxed/simple;
	bh=cnT/dXoImjANFOCwNRpprXJfZFQ3nptHbg3AZA9MzFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UyzKDSeUGztp7XxNBHlX+0R5bhJV3VkVpt9rTGjywLeCzaYyzMMXsotkFKnbt4xovssXzhNn120im34q367o1c/mq8PNjSBNnvwnIksK4g9OVFAg2XM8NbMWrsYqvnrckdu2MAQsHbzX5hwk1eW8jq1MHbW3REac79yfDv1Qcl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5ec3b888b19d11f19a56ed5b684f684d-20260916
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:9ef3f362-5ecf-419d-b9f5-057c5b199fce,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:91bc9b17bf5ce1bb5cb37b154efa11b0,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	5|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5ec3b888b19d11f19a56ed5b684f684d-20260916
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 511063246; Wed, 16 Sep 2026 15:08:08 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] sched_ext: Don't run ops.dequeue() with a DSQ lock held
Date: Wed, 16 Sep 2026 15:07:51 +0800
Message-Id: <20260916070753.3343113-1-fangqiurong@kylinos.cn>
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
- selftest: set ops.timeout_ms to the suite-standard 1000U
- Add Cc: stable # v7.1+ (Tejun Heo)

v1 -> v2:
- Drop the claim that ops.dequeue() may run after the task has
  re-entered custody: SCX_OPSS_DISPATCHING is held across the callback
  on the global/bypass path and @p's rq lock is held across the
  callback on the user-DSQ-to-local paths (Andrea Righi)
- Add a selftest whose ops.dequeue() iterates the source user DSQ
  (Andrea Righi)

Patch 1 carries Andrea's Acked-by from the v1 review.
Link: https://lore.kernel.org/all/20260915130334.714388-1-fangqiurong@kylinos.cn/

fangqiurong (2):
  sched_ext: Don't run ops.dequeue() with a DSQ lock held
  selftests/sched_ext: Test that ops.dequeue() can iterate the consumed
    DSQ

 kernel/sched/ext/ext.c                        | 41 ++++-----
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../selftests/sched_ext/dequeue_iter.bpf.c    | 73 +++++++++++++++
 .../selftests/sched_ext/dequeue_iter.c        | 90 +++++++++++++++++++
 4 files changed, 185 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_iter.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_iter.c

-- 
2.43.0

