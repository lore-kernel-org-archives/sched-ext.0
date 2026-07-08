Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6923E334;
	Wed,  8 Jul 2026 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545872; cv=none; b=KBiv/xZGaVIZoOT07pIEbzvUH9yE+YPPTdB13bgQfF5WB2yMF5+BKEA5Z/TUxAeicJmAqpgt5O79eUECxy/DyHHabQWHqGid/dRZ17liBCn/PBH6kPoyFCzRcB72D5YCV0z81IOiL8KMQ4mirRbC/iPYiBJ/Ux5qc6YOlFvQK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545872; c=relaxed/simple;
	bh=EtlFd+v+lm9iR43926ZeVIk/OTfxZt/nvvg3c6hpvYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dqbxl8QpLx3BtEJxbPTjFkkC0+zPxr59xx7qUh16s17QwAwE4EywMJoZ8NMm2nPobhCz4cKGYVB8ji9GNRDnp5u23IMefvF8wzKIBqkQmfYYUzSfb6aplm7qB8B4i98DEeaWzEYanaVBlHpCax7uKu1gS+zHSJ38VqcuVRFliyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTGmuONE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTGmuONE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5112F1F00A3A;
	Wed,  8 Jul 2026 21:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545871;
	bh=lkmNpyg/k2l7E3gRK2U3hvu1Xt/k24MRLYyLi4qQrWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DTGmuONElNzRillyrs0QnzJ9YXr8iXtjLhm19YXlhO34Y2JCgDh7xm+HqFmIjnkPD
	 YrzJTolcwlL6Jq9DNsy+xAT0rDRIMO9XQ5xWMrZWMioGkj2WxlsVTWa9HDFSk6+X8T
	 VdKha2Goi9SHS3UKBiTZOGfxVzE5ZuNPOK5RaT9YU9n0KNUghr9M+EczDlhdX2ke1D
	 bLODQ6ZdSs5ENCXmDrcdmQrniyO1uPQO8oTSMPlWMUA2S1Rckz2j3beWs8+MkNfYq0
	 /tSu0FOepkc508tqiTIWleTJeGdWgsuD8MVf6d/DOD4ua80rL5pbHbZ8fOcJ41k6OH
	 EPrdogPZSaong==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 01/40] sched_ext: Record an error on errno-only sub-enable failure
Date: Wed,  8 Jul 2026 11:23:50 -1000
Message-ID: <20260708212429.3405787-2-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_sub_enable_workfn() has several failure paths that only return an errno
(e.g. -ENOMEM from an allocation) and jump to err_disable without calling
scx_error(). scx_flush_disable_work() runs the disable, and thus ops.exit(),
only when an error has been recorded, so an errno-only failure leaves the
half-initialized sub-scheduler linked.

Record an error at the err_disable sink so every errno-only failure runs the
disable path.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/sub.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 050420427273..ce76ae141e0a 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -570,6 +570,12 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	percpu_up_write(&scx_fork_rwsem);
 err_disable:
 	mutex_unlock(&scx_enable_mutex);
+	/*
+	 * Some enable failures only return an errno (e.g. -ENOMEM from an
+	 * allocation) without calling scx_error(). Record it so
+	 * scx_flush_disable_work() runs the disable and ops.exit() fires.
+	 */
+	scx_error(sch, "scx_sub_enable() failed (%d)", ret);
 	scx_flush_disable_work(sch);
 	cmd->ret = 0;
 }
-- 
2.54.0

