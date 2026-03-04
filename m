Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD6397687;
	Wed,  4 Mar 2026 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661693; cv=none; b=qHEwq8RXHjONUtUvESlcKOz1zbfmv1b6n4Tf/c+SiUHvoi9UaiZmIi5JQyuMZoOq7nhkDovkr2DjZ+jzBP+AFLtP7a53dtPUsHoTf9YuStbgIsAgkLxF2GkX+dWxru02LzRQ370Fd1IpjjBbpQ6QVOCXUf9PXOMmLNcF+Zhjbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661693; c=relaxed/simple;
	bh=cFBmVFAdd0knpzoZVS5cUtoKJYp1xCMZPqOsRuoBv7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XThEtsrKPrxCfC2VHlI6BGcsycWCst58o7DOk62fO5zktiD5woF78EOf1ztV2UAlBl65SHvXCvYBCgvZ3pZGsiHlXPhZcu276blw+oAfIMkeUdPdQhslN6VLymtg3f4qRQ+MCm8GbQXHIpRjx38ut+xe3IEiVkFhfLPcRlwO040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNoT9RmO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNoT9RmO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1F9C19425;
	Wed,  4 Mar 2026 22:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661693;
	bh=cFBmVFAdd0knpzoZVS5cUtoKJYp1xCMZPqOsRuoBv7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNoT9RmO+a7qFtBme4/ks83NA6UE8uqNAD4YCQUV82gRIPhAIvQnxfw3Q2IQfFO9O
	 n3zy4U8pyZ+ciUTwn9vKLuLnK7zO8pPmszYJW4bnLGl1HqR+K0fVJnyQ2jun8R9Ssr
	 3CdNfF+79IZd9CSvyRl/i7kdMcjRiLmls/X8gVjYKkrqu14PJJ+2TfbkkpAJAJiYdY
	 IPanq3NoksZ0ZJ+CL4r5S7IrHruUCG6hZDpoXTV80u+P6+eiZMaEszTh8Ax0D8+c11
	 U8CCHE1CqpPWPDZx0OAPmwxgvFCZ/kjwb2EtrLTA2+Lez0hIiiuwq64q+QhOeRCPEp
	 asSuaGPl4jXxQ==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/34] sched_ext: scx_dsq_move() should validate the task belongs to the right scheduler
Date: Wed,  4 Mar 2026 12:00:57 -1000
Message-ID: <20260304220119.4095551-13-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_move[_vtime]() calls scx_dsq_move() to move task from a DSQ to
another. However, @p doesn't necessarily have to come form the containing
iteration and can thus be a task which belongs to another scx_sched. Verify
that @p is on the same scx_sched as the DSQ being iterated.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b2b1b05f1cd6..349f94864e51 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6718,8 +6718,8 @@ static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
 static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 			 struct task_struct *p, u64 dsq_id, u64 enq_flags)
 {
-	struct scx_sched *sch = scx_root;
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
+	struct scx_sched *sch = src_dsq->sched;
 	struct rq *this_rq, *src_rq, *locked_rq;
 	bool dispatched = false;
 	bool in_balance;
@@ -6736,6 +6736,11 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (unlikely(READ_ONCE(scx_aborting)))
 		return false;
 
+	if (unlikely(!scx_task_on_sched(sch, p))) {
+		scx_error(sch, "scx_bpf_dsq_move[_vtime]() on %s[%d] but the task belongs to a different scheduler",
+			  p->comm, p->pid);
+	}
+
 	/*
 	 * Can be called from either ops.dispatch() locking this_rq() or any
 	 * context where no rq lock is held. If latter, lock @p's task_rq which
-- 
2.53.0

