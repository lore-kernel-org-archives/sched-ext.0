Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19D3CCFCC
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260634; cv=none; b=ByPJVg65105oeDs5JQUrDrZP+DH3Q68Cwhlb6WKDRpsKpgFqbv7tC1U+v3lmJqFEmh+oEKepJ94yMZLKkGf8XLoPIHd27s8Fo8fNQ6cUcrYJuOgxJZarmTBiJwgVmIMQJDJJNI7CZN45M4k0ILiqrLeFSsceokg5Q9LKbSeeB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260634; c=relaxed/simple;
	bh=5kklIoyEGyLNoSWopGBLlI5tlwXb/K1YS4DCbLsrkdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yt8j2b4qOAmMO08mIrE35nsF9U8zJEH/7o3eVrOmc/zeTnbYL42RATVHl2Ccton+Wdg7SakymRrLiPb+YJxgaib5y18l9wRtCUmIr2v6gWFhX80sDc6ZM+Jj2bGy/Np6OJCe/J7yvyh86IDlssbD4HTk/D60xjNzx+vGTHXLohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 688030cab82511f19a56ed5b684f684d-20260924
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5a686878-4dac-45fe-9138-bb5d5df37291,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:ee4837b54b691d3a67832b22bf0cdb46,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 688030cab82511f19a56ed5b684f684d-20260924
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 171834914; Thu, 24 Sep 2026 22:37:03 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wanwu Li <liwanwu@kylinos.cn>
Subject: [PATCH 1/3] tools/sched_ext: Increment nr_queued when a task is queued to user space
Date: Thu, 24 Sep 2026 22:36:57 +0800
Message-Id: <20260924143659.268595-2-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260924143659.268595-1-liwanwu@kylinos.cn>
References: <20260924143659.268595-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

userland_update_idle() decides whether a CPU going idle must wake the
user-space scheduler with "if (nr_queued || nr_scheduled)", where
nr_queued is documented -- both in its declaration and in the NOTE in
userland_update_idle() -- to be incremented by the BPF component when
a task is queued to user space.  But enqueue_task_in_user_space()
never increments it: a successful push only bumps the nr_user_enqueues
stats counter, so nr_queued stays 0 forever and the check silently
degrades to nr_scheduled alone.  Tasks sitting in the enqueued map,
not yet drained by the user-space scheduler, are invisible to a CPU
going idle.

Increment nr_queued when the push succeeds; the user-space side
already clears it once the map is drained, as documented.

Fixes: cc4448d0856d ("tools/sched_ext: add scx_userland scheduler")
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---
 tools/sched_ext/scx_userland.bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/sched_ext/scx_userland.bpf.c b/tools/sched_ext/scx_userland.bpf.c
index f29862b89386..648c6bd230eb 100644
--- a/tools/sched_ext/scx_userland.bpf.c
+++ b/tools/sched_ext/scx_userland.bpf.c
@@ -197,6 +197,7 @@ static void enqueue_task_in_user_space(struct task_struct *p, u64 enq_flags)
 		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 	} else {
 		__sync_fetch_and_add(&nr_user_enqueues, 1);
+		__sync_fetch_and_add(&nr_queued, 1);
 		set_usersched_needed();
 	}
 }
-- 
2.25.1

