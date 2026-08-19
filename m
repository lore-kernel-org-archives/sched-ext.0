Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517530F94B
	for <sched-ext@lists.linux.dev>; Wed, 19 Aug 2026 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787109181; cv=none; b=dOszwi6kVevnqcdmOEbJva2LlzE9pjN2xySHIxia1tN83NlCGBXQYfxBBuwsD3nFjHVKQoOZBUFr2j29lmnh/5tpN11baZDtFdfUo70p/MDsc9nA2JepDbjuFJoU6oOINOPkTIiOLOL8uU2Cvq/JeoJUZhVcntTvj9JEj2u0aOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787109181; c=relaxed/simple;
	bh=mQQTeNIszEC/jA90cC2fZToSU9Vu1q60FyhkIfkbwQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CK2CQdoR+6ga/kEYBclcfqsr9vUIQrbWzMX1tuB8Q6K5+OAFTjxveUsitwsZgidsihJh9T9UpOYJgGbZ/TrQLUv4bBWS70xr9ydlnkcYje0hC96zvm+Dsj9KrU4zka9Xhefy5Vxdl6Thff4A3V9oJcvX+N1CKSqZ95OVSe8Mijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: db6a19d29b7b11f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a144740e-825d-4f23-9d14-8ea28734577e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:ebd017b97e418f31044e99bcd80511f1,BulkI
	D:nil,BulkQuantity:0,SF:102|123|136|850|865|898,TC:nil,Content:0|15|50,EDM
	:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: db6a19d29b7b11f19a56ed5b684f684d-20260819
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1511758202; Wed, 19 Aug 2026 11:12:48 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH 0/2] sched_ext: documentation fixes
Date: Wed, 19 Aug 2026 11:12:42 +0800
Message-Id: <20260819031244.178638-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

Two documentation fixes found by cross-checking the documents against
the current kernel code:

  1. cgroup-v2.rst: cpu.max, cpu.max.burst and cpu.idle still claim to
     affect only the fair-class scheduler, but writes to these files
     also notify BPF schedulers through the cgroup_set_bandwidth and
     cgroup_set_idle callbacks. Mirror the existing cpu.weight wording.

  2. sched-ext.rst: the ops.exit() example reads ei->type, a field
     struct scx_exit_info has never had. Use ei->kind so the example
     compiles as written.

Liang Luo (2):
  Docs/admin-guide/cgroup-v2: document BPF scheduler callbacks for
    cpu.max and cpu.idle
  sched_ext: Fix nonexistent field in sched-ext.rst example

 Documentation/admin-guide/cgroup-v2.rst | 12 +++++++++---
 Documentation/scheduler/sched-ext.rst   |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.43.0

