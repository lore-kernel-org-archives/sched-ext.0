Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442129;
	b=PqRMvgWmg4UonzcPVlZHtsP/1xz84GqtuyeQwRd+T/qFbtEVHNfnOSADO/4QRJ8201Jn
	 7qsBMA3FH6nw/r0go2+AaOFa0cljfHSVBWPIZ7ZH0emCstFj6NAYoARmp3Idx5nrUReDj
	 STthu/+UPGtgM0PKW4ElAz+P0R/TTaerEc07KWwV1CFcSDVmiIag0P/M5nPdh6FnJ/s6T
	 xI7Iu0P6e4wPXJoNUriIVxX8kTEksvdXLR8PZ43qHgIu3sPBEHG7mmp4p29kXkhweYL2z
	 eP+D8l21T7cCOHefEF3ISHTHjRCi+4Yh21jEbDy5FfdNByxwz7teCYFwnz8OyBK71MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=GiEDqbasxNBPTvJr6p1jL37OR8h8QGYfgXABsowoh2Y=;
	b=hi8uJbqPB8b8L1gMCsclTn4Ayy8XTSnPFGLGSDJe7imI1dhRbg3lPl/sN7fg8opxEEN1
	 5//QBnu8s7YMEFoW49yTjoS5NI1ia+oN8NZYNgh+eB7RvbVTlXLRPU6kv1ar894sjFcol
	 VC8i2KR9HpG9fOiBVVJl95Eu4D7rD7sN3iTlJBk3vG77G7K2iQ/lW3k1cnOlYc1zqBaeU
	 lrbT20KT1tCa8YAb4rnUH19IMoBx+FBW1LwaNTzRP1wuU90F/AjJIkpdVO92TNBOM3EKs
	 3Lqx2zdFJkbdBRCscn6n1s810THieiABYwZ+9U1FjyG6W1sBcfZVvNLkmAYtvmVIjqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m74TCxif;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953B606A330
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 13:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6953B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m74TCxif
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4b764ffc014so26517695e9.0
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 05:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795442128; x=1796046928; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GiEDqbasxNBPTvJr6p1jL37OR8h8QGYfgXABsowoh2Y=;
        b=m74TCxifXqlCIDKzcyGJUYHWtqh1JClwel8sRLhXcs8qCwqt9V6Bvume7390FnmP/7
         MpdCZNWFiGeY2VnoykngL1NHWXMxXF0y2hz3IZdvHn4iutpKMuD12EtXF7gD2qyIgJTP
         JhpbYQOrbVegrFwoRVlNuDqzgF/7vvZbNJCljrjvFGabSLInW4jPiEgerNML9j1gt3hi
         fSI3YAimu3iKtlo+ZUUZNvQ4aKdw11/XDd25gz68OYz9uacgXsMAicUV6G+niRMxVmYi
         71z3YOQ5Q6B2NF3PU6gO+ALBW+WBRxykyyosUf0/34rFGwjFDsXA7kzzsFgKH2owNLxb
         t6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442128; x=1796046928;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GiEDqbasxNBPTvJr6p1jL37OR8h8QGYfgXABsowoh2Y=;
        b=bjfbOuGEl1UB7CIla+RWrVQz6eiAm362CAFKz21jz8qDedzRBAbXNlZjFmuAxnTRU8
         z29DiSA/EBwvnOXLKBAG056piyX+kq6k7TeQJgZauKfxSGjXzSyWWR1FE0NbrahQU4qU
         pYc5R4MxyhnLY/lBvJI5iykdK12jkJO88JaKxDpNP4I6+6SCxTuLa3ZRMvJRCVofLogM
         sEmoR6zHwAisBmlkYwWTag78u22WBtXgqDwau8gPlz5gd+j12luEI59lIRSrzMkPGmd7
         I0wwNldfMFk9HiqXRaKNMOwkc9WeCQBTULQkDwmUXtRqtzgVHz9t/DZzNviV2aKBUNH1
         UQKQ==
X-Forwarded-Encrypted: i=1; AL+hErFYsAdLVN/1ukCv5KC1cncWpgRTVQC+suNqzcgt56G1HHB9VblMeWjWOsESqj9P6fSRlidOGzhLFcA=@lists.linux.dev
X-Gm-Message-State: APuU4Z82/2yXT+qCG6qnACUro5avlzNHlAMnjzqgtdmNBLAhaunk7Lbh
	tXKueRH9IOaDYQf2y4lsphgsdh39ztAljcs44xMzlwoWK6NucRIHKkHjoILFfWuge/QqsPk0lQO
	7G4Ak6orHPyL0cg==
X-Received: from wmgg20.prod.google.com ([2002:a05:600d:14:b0:4a2:e03:1f55])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a15:b0:4b6:267a:dd6e with SMTP id 5b1f17b1804b1-4bb88938a62mr239364585e9.28.1795442127735;
 Mon, 23 Nov 2026 05:55:27 -0800 (PST)
Date: Mon, 23 Nov 2026 13:55:24 +0000
In-Reply-To: <20261123135343.4131146-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123135343.4131146-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123135343.4131146-2-jpiecuch@google.com>
Subject: [PATCH 1/2] sched_ext: Don't allow unlocked kfuncs from ops.dump()
 and ops.init_cids()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scx_kf_allow_flags[] grants SCX_KF_ALLOW_UNLOCKED to ops.dump(). This
allows ops.dump() to call scx_bpf_dsq_move*(), scx_bpf_dsq_reenq_task(),
and scx_bpf_select_cpu_*(). When no rq is locked, these kfuncs acquire
rq, DSQ, and pi locks and may invoke nested SCX ops such as
ops.dequeue().

scx_dump_state() runs ops.dump() with IRQs disabled under scx_dump_lock.
Callers include the hardirq disable irq_work and SysRq-D. With
SCX_KF_ALLOW_UNLOCKED, a debug dump can migrate tasks and run nested
scheduler callbacks instead of only inspecting state. ops.dump_cpu() and
ops.dump_task() already deny these kfuncs. Remove SCX_KF_ALLOW_UNLOCKED
from ops.dump().

ops.init_cids() runs before the cid tables are published and before the
arena pool and pshards are set up. Its only job is to finalize the cid
layout. SCX_KF_ALLOW_UNLOCKED also gave it scx_bpf_create_dsq(),
scx_bpf_dsq_move*(), and scx_bpf_dsq_reenq_task(). Restrict
ops.init_cids() to SCX_KF_ALLOW_INIT_CIDS.

No in-tree scheduler calls these kfuncs from either op.

Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
Fixes: 874fdc0e86e4 ("sched_ext: Add ops.init_cids() to finalize the cid layout before init")
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e8c30a21e03e..6274ea04fc6f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -12293,7 +12293,6 @@ static const u32 scx_kf_allow_flags[] = {
 	[SCX_OP_IDX(dispatch)]		= SCX_KF_ALLOW_ENQUEUE | SCX_KF_ALLOW_DISPATCH,
 	[SCX_OP_IDX(cpu_release)]	= SCX_KF_ALLOW_CPU_RELEASE,
 	[SCX_OP_IDX(init_task)]		= SCX_KF_ALLOW_UNLOCKED,
-	[SCX_OP_IDX(dump)]		= SCX_KF_ALLOW_UNLOCKED,
 #ifdef CONFIG_EXT_GROUP_SCHED
 	[SCX_OP_IDX(cgroup_init)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(cgroup_exit)]	= SCX_KF_ALLOW_UNLOCKED,
@@ -12309,7 +12308,12 @@ static const u32 scx_kf_allow_flags[] = {
 	[SCX_OP_IDX(sub_child_ecaps_updated)] = SCX_KF_ALLOW_ENQUEUE | SCX_KF_ALLOW_DISPATCH,
 	[SCX_OP_IDX(cpu_online)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(cpu_offline)]	= SCX_KF_ALLOW_UNLOCKED,
-	[SCX_OP_IDX(init_cids)]		= SCX_KF_ALLOW_UNLOCKED | SCX_KF_ALLOW_INIT_CIDS,
+	/*
+	 * ops.init_cids() runs before the cid tables are published and before
+	 * the arena pool and pshards are allocated. Limit it to finalizing the
+	 * cid layout; everything else belongs in ops.init().
+	 */
+	[SCX_OP_IDX(init_cids)]		= SCX_KF_ALLOW_INIT_CIDS,
 	[SCX_OP_IDX(init)]		= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(exit)]		= SCX_KF_ALLOW_UNLOCKED,
 };
-- 
2.56.1.750.gf70dc682cf-goog

