Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD3308F3B
	for <sched-ext@lists.linux.dev>; Wed,  2 Sep 2026 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319384; cv=none; b=dnLs4Uon16Zd2XboYojEnGeplNK85VbWDB3oCYcfCFg49B/1XYTw++e0LqXkonRVRfT5iICwCX2/UD72cndLOzHeQRLweOtXj0dT26VnhAr3JDWQuwANYjatfivM9fsOQRBNtDJQtWVpk3Ladu95qF49OFJwc+w0Bh2ppdpV+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319384; c=relaxed/simple;
	bh=1OQRHH3FcJxCxUg//doq4CF1XgcdY/X5iX+sNOWlXoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UAVgSOsQl8qqBkWO260CPTOt4u4wuDNjKCweb6b/zaUAtr9SnHv6hZKsFfyEQznf5/uMmAt8RtBmh12StAos+PieCtQXNqLl7azI69w6QA4MMI+1Qv/5LGIay0iw4yNDXdnAcK/UT3hDRG4QCNG3G03l0t85syd5VMX5S2To/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 93ab2af2a67d11f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:63e4de43-1700-4cb7-a66c-bbc38bcd26e9,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:2,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:27
X-CID-META: VersionHash:7db8b62,CLOUDID:8652aba4ece6550707548d3256d91286,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 93ab2af2a67d11f19a56ed5b684f684d-20260902
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1965554226; Wed, 02 Sep 2026 11:22:50 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: tj@kernel.org
Cc: arighi@nvidia.com,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext: Delete sub-scheduler kobjects before releasing scx_enable_mutex
Date: Wed,  2 Sep 2026 11:22:33 +0800
Message-Id: <20260902032233.135959-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <apcuA5kzwRCu_P-V@slm.duckdns.org>
References: <apcuA5kzwRCu_P-V@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Tejun,

On Tue, Sep 01, 2026 at 09:56:51AM -1000, Tejun Heo wrote:
> Why is this a problem? The subsched hasn't been fully unloaded yet so if you
> try to attach a new one, it's going to fail.

When the mutex is released, the cgroup has already been given back to the
parent and the exiting scheduler unlinked - its sysfs name is the only
thing left, and only kobject_add() can see it:

  exiting sched (disable workfn)        new sched (enable workfn)
  -----------------------------        ---------------------------
  mutex_lock(&scx_enable_mutex)
    set_cgroup_sched(cgrp, parent)
    scx_unlink_sched(sch)
  mutex_unlock(&scx_enable_mutex)
                                       mutex_lock(&scx_enable_mutex)
                                       find_parent_sched()         ok
                                       create/validate/link sch    ok
                                       scx_sched_sysfs_add()
                                         kobject_add("sub-%llu")  -EEXIST
                                       err_disable: tear down the
                                       otherwise healthy sched
  ops.sub_detach()/exit()      ~100ms
  synchronize_rcu()
  kobject_del("sub-%llu")      too late

The new scheduler passes every check and dies only at sysfs_add(); the
error surfaces via its own ops.exit() while the attach syscall returns 0,
and there is nothing userspace could wait on. This is the case the root
path's comment covers by deleting before unlocking.

Reproduced with a slow (~100ms) ops.exit() and a second struct_ops
instance attaching to the same cgroup in a loop: 40/40 iterations hit
-EEXIST without the patch, 0/40 with it. Happy to turn the reproducer
into a selftest as a follow-up if wanted.

Andrea is right that the concurrent enable must be a different struct_ops
instance (same instance is rejected by the ops->priv check; sequential
unregister+register is serialized by bpf_scx_unreg() flushing the disable
work). Will state that in v2's changelog.

Thanks.
