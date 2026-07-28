Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189813A8746
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222230; cv=none; b=ONi8wuNOXtyofQuu7k9zIbxvE+YjsTABIy1YpXM20lNebjkTgNZQkwIO8uVZ7CVXEuEnC0PvuCrKsobVnNWYeVFm2LYt2IdJjFbjHshChO4uWlLP2NAgOHMUs4F7pPafY/bywy8TVw3NpKsEdgaupzbJFOvWTCWg6voj9DcFxqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222230; c=relaxed/simple;
	bh=rGSLuoDS4fOWrRKncenBOVYRF0363p1nNd/yFQxOdBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYiyCnFVTPIL4FEmfAE1yXjUBk2tPLSX9c43c6nzDlFqXYsrshajb89PHyHi4q9CkmhHmIhtNhGudYwMhJrXvbZxtrl+ngfY6PQdB1+p5uD6AmZ9mCB75HbYn1+xrd9r7l7vfrhimX9TUUeI4JKGCXIhQOR+Bi6rC7s6NtD8TOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 756d5ec68a5211f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f0181b3b-d5ec-436a-9492-509dfc33ec2b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:24643f741f5a2896be89ea29474c2b66,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|123|136|850|865|898,TC:n
	il,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 756d5ec68a5211f1aa26b74ffac11d73-20260728
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1731402860; Tue, 28 Jul 2026 15:03:38 +0800
From: luoliang@kylinos.cn
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext: Set errno on ENABLING -> ENABLED transition failure
Date: Tue, 28 Jul 2026 15:03:36 +0800
Message-Id: <20260728070336.4175761-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260728062807.17E041F000E9@smtp.kernel.org>
References: <20260728062807.17E041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 28, 2026 at 06:28:06AM +0000, sashiko-bot@kernel.org wrote:
> Unlike scx_root_enable_workfn(), the err_disable label in
> scx_sub_enable_workfn() lacks a catch-all scx_error() call. If an error
> path jumps there without already invoking scx_error(), it appears to
> result in a silent failure.

The catch-all scx_error() at the err_disable sink in
scx_sub_enable_workfn() already exists in mainline. It was added by
commit db4e9defd2e8 ("sched_ext: Record an error on errno-only
sub-enable failure"):

    err_disable:
        mutex_unlock(&scx_enable_mutex);
        /*
         * Some enable failures only return an errno (e.g. -ENOMEM from an
         * allocation) without calling scx_error(). Record it so
         * scx_flush_disable_work() runs the disable and ops.exit() fires.
         */
        scx_error(sch, "scx_sub_enable() failed (%d)", ret);
        scx_flush_disable_work(sch);
        cmd->ret = 0;

So the silent failure described in the review no longer exists.
