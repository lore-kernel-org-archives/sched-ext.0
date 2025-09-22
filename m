Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4634E19309C;
	Mon, 22 Sep 2025 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504773; cv=none; b=ctlOiGmNBPyhQ7r3EC15siKDQ84T10V7U7WnFzppqzFAHUShM8dEqkp1ILm3ud+doiWQTfaGkeeqQwoKMt4trVjkqmf4lm4cUikhUXXlg1bN2v4I93H7hyr7eKnP/ja8xWswujZBHP34AaqMiFqe4hW1f0FpZupn2YR5wk2SPdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504773; c=relaxed/simple;
	bh=+aVfihu6YNzjff5HXcBiauQcIyue2N+htiTwTi60o/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGSAqDjHeTQN2dUvI8GTB8gF8peab1pzxsmsYsddCMwQfa/hLzuP5NHhVQCj20A9q3RdfxKsm0LsuZUHFGIPswjMmb0mxt2qkz2qLOEp4ttd52kajMU417WpirWivEdGMhWy+aquCx+zw5SZ65AsHeGt8WZzA0w29xY90lmPXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1yYAJXQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1yYAJXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20C8C4CEE7;
	Mon, 22 Sep 2025 01:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758504773;
	bh=+aVfihu6YNzjff5HXcBiauQcIyue2N+htiTwTi60o/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1yYAJXQaWYePPmXEEZ6fdjyQjYcjYHCEKyD64vUCdy7vqnVIRcpw7cy0ebz/otnm
	 daAfe8l8mWH/mSq+iMVCUR7WbjFPJyVD9v/p2mCl+7nEZovBTszCOmLq00DKbxy/fn
	 k/attZmkzGsYF9/L98i3LEVZYPKOHgMN/xtSDySlYeY8fOnIURWXB/yZKKehBnW6h5
	 cOisPr7Rx8F8QSYFKp4pQr4McXg4osBDHRpJOyKQDbzgEAURgpsgdZxGtt8Ged1/zG
	 0ZS/SzSIkPrspNmRxm5QQimSQ7SaOJ8JgynnQpN+b40bs1BrfbUZblVLNpEeblKAnS
	 q0x0RYwayZF3A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/7] sched_ext: Make qmap dump operation non-destructive
Date: Sun, 21 Sep 2025 15:32:45 -1000
Message-ID: <20250922013246.275031-6-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922013246.275031-1-tj@kernel.org>
References: <20250922013246.275031-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qmap dump operation was destructively consuming queue entries while
displaying them. As dump can be triggered anytime, this can easily lead to
stalls. Add a temporary dump_store queue and modify the dump logic to pop
entries, display them, and then restore them back to the original queue.
This allows dump operations to be performed without affecting the
scheduler's queue state.

Note that if racing against new enqueues during dump, ordering can get
mixed up, but this is acceptable for debugging purposes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 69d877501cb7..cd50a94326e3 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -56,7 +56,8 @@ struct qmap {
   queue1 SEC(".maps"),
   queue2 SEC(".maps"),
   queue3 SEC(".maps"),
-  queue4 SEC(".maps");
+  queue4 SEC(".maps"),
+  dump_store SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
@@ -578,11 +579,26 @@ void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx *dctx)
 			return;
 
 		scx_bpf_dump("QMAP FIFO[%d]:", i);
+
+		/*
+		 * Dump can be invoked anytime and there is no way to iterate in
+		 * a non-destructive way. Pop and store in dump_store and then
+		 * restore afterwards. If racing against new enqueues, ordering
+		 * can get mixed up.
+		 */
 		bpf_repeat(4096) {
 			if (bpf_map_pop_elem(fifo, &pid))
 				break;
+			bpf_map_push_elem(&dump_store, &pid, 0);
 			scx_bpf_dump(" %d", pid);
 		}
+
+		bpf_repeat(4096) {
+			if (bpf_map_pop_elem(&dump_store, &pid))
+				break;
+			bpf_map_push_elem(fifo, &pid, 0);
+		}
+
 		scx_bpf_dump("\n");
 	}
 }
-- 
2.51.0

