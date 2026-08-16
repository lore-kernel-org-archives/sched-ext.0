Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C0175A7B;
	Sun, 16 Aug 2026 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838733; cv=none; b=eW89cY7FmEu9ebBNY/ATam+l4Hpo0vtPtgMqJGngk1dTe8J3eG1lsyUZ8MH7RHTvCC5ZmfCzeiziXmq7gvuJ9Oa/0mhY5WuyMFDcFFLoK3teubxbcFkZxWnlcBez/ZUAI8FxVJlAM1/zNQw6uXrHK7ovlIvQjlPouNbQ5yQ5/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838733; c=relaxed/simple;
	bh=GVNlGzRp6f1xwQwwZXNOL7zRpuUxOWQ+/uIJXBS2lzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukKayR7d7LOjEoy5g32Wu25Ozep0rtWHquT6Xj4gP6tEWYnnezz+VJJqkOgbaKM+E6CITaehMgUi1YKEpXs33VT8TW+D8pdql2iCoI1l6rKBccitUp8Y0JM9FQiEQZHZ92W4Y3xH+Rk1MFSDMRxm138/u+2DW8F/AitZHEu9X1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/C7/SRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/C7/SRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86171F00A3D;
	Sun, 16 Aug 2026 00:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786838731;
	bh=kEBqbJ9PWkcKYOVJ0X5UKnvW541WoKJ9mvz3jZDHgxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b/C7/SRxnkmwpzN86xXOqnzRZgETywi9qEgN7FcgQxToLXglLLV3xN6s8RDOJslus
	 DElmQfEY7g2sY1FVA5biWh2TopeMjZ8gKdaxf10Viy6mPRxatGnEilDIlVX8cODD/P
	 zQH3OUvIO61LWtmWLl2rR13Ydr9HqD0RuFVX5ncDweSiBc53J4BEP8DfzMOPREggsQ
	 JmOto5WFzCSBJ20DdsQpBrA4lAZhhpQDhq5Iq3ixc5B4HhMn1+/Us9/C0M4VDVMqe8
	 ojRnVeuvJH8tQ5yg1/G2SrMtlRWgZO9h4FiZT2lDI7jNNd/MGlA0MgLTQ+/1VDgtLp
	 PW2uBipvubHzg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] sched_ext: Drop the dead SCX_DEQ_CORE_SCHED_EXEC test in dequeue_task_scx()
Date: Sat, 15 Aug 2026 14:05:27 -1000
Message-ID: <20260816000527.988170-5-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816000527.988170-1-tj@kernel.org>
References: <20260816000527.988170-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dequeue_task_scx() masks SCX_DEQ_CORE_SCHED_EXEC out of the
SCX_DEQ_SCHED_CHANGE decision, but the test can never fire: the incoming
flags are an int of generic DEQUEUE_* bits while the flag is bit 32, and the
core-sched execute path never goes through class dequeue anyway -
set_next_task_scx() calls ops_dequeue() with the flag directly. The test was
live when the SCX_DEQ_SCHED_CHANGE computation sat in ops_dequeue() and
became dead when 03f5304aad0f ("sched_ext: Pass full dequeue flags to
ops.quiescent()") moved the computation here. Drop it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f14e3fc69644..395d8f5aaaa8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2267,9 +2267,9 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 
 	/*
 	 * Set %SCX_DEQ_SCHED_CHANGE when the dequeue is due to a property
-	 * change (not sleep or core-sched pick).
+	 * change (not sleep).
 	 */
-	if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
+	if (!(deq_flags & DEQUEUE_SLEEP))
 		deq_flags |= SCX_DEQ_SCHED_CHANGE;
 
 	if (!(p->scx.flags & SCX_TASK_QUEUED)) {
-- 
2.55.0

