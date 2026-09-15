Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ACC3B95E3
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477440; cv=none; b=af4nF04uB/1bSty0Iy1EIhZRfQXARLbmWaPKnq0CTRtq7z6aYzN3mZzYKUp3JWHz2Ufby3vYAbNTvSK9dWfzVuf8oPLBdChEpPVxBMtG88ocqIJlobhySqZex5Is2zAni2FsXKG1AhfMsPNUsVXuGsrnNggfYg4rLJDzqoKcJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477440; c=relaxed/simple;
	bh=8q403thV6hkWi3KpWvXhA233kaAGaZ+tL6hOnLD9vnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZicvMLRWi4btCzkkLTkES1wrXglHHQRD/U2knsZ3PUmPXE15XFWiMLMRo/MhSWM+onVhEKziF8oPz05r4vNfQ409Sjkp6NsT0YpV+WbFRTzbjcPRozqsjxm5yXlP4vv8EqSASH1upsolpq4M3BxKEQTq/BzWdFcwKTBATPslL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e55a511ab10511f19a56ed5b684f684d-20260915
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a58dbb67-8fbf-4394-9e68-2a11892f8c04,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:64829f9ef26402b03f4b26920514f7b0,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e55a511ab10511f19a56ed5b684f684d-20260915
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 828003999; Tue, 15 Sep 2026 21:03:50 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] sched_ext: Don't run ops.dequeue() with a DSQ lock held
Date: Tue, 15 Sep 2026 21:03:32 +0800
Message-Id: <20260915130334.714388-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aqkQ1MtqtqnS0wUs@gpd4>
References: <aqkQ1MtqtqnS0wUs@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

The consume, move and terminal insert paths invoke ops.dequeue() with a
DSQ lock held, self-deadlocking any BPF scheduler which locks the same
DSQ from ops.dequeue(). Move the invocations after the DSQ unlock.

v1 -> v2:
- Drop the claim that ops.dequeue() may run after the task has
  re-entered custody: SCX_OPSS_DISPATCHING is held across the callback
  on the global/bypass path and @p's rq lock is held across the
  callback on the user-DSQ-to-local paths (Andrea Righi)
- Add a selftest whose ops.dequeue() iterates the source user DSQ
  (Andrea Righi)

Patch 1 carries Andrea's Acked-by from the v1 review.
Link: https://lore.kernel.org/all/aqkQ1MtqtqnS0wUs@gpd4/

fangqiurong (2):
  sched_ext: Don't run ops.dequeue() with a DSQ lock held
  selftests/sched_ext: Test that ops.dequeue() can iterate the consumed
    DSQ

 Documentation/scheduler/sched-ext.rst         |  4 +-
 kernel/sched/ext/ext.c                        | 67 ++++++++++---
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../selftests/sched_ext/dequeue_iter.bpf.c    | 65 +++++++++++++
 .../selftests/sched_ext/dequeue_iter.c        | 94 +++++++++++++++++++
 5 files changed, 216 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_iter.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_iter.c

-- 
2.43.0

