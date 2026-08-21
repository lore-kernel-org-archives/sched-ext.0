Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED647A0DD;
	Fri, 21 Aug 2026 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308559; cv=none; b=ImN4Yc0ugzK9zsf4wwWKakzIhjW2x/I6r7qTx7G8WjPRIkiPJhERPqVtLQrsg1iKuwlRXO44x36w7IqQn++jQITEfz4vCPkO9CgTjSXt/0vDcuPc7ntLKuS6Cjv7kzqX8AheWUpKmd0ZWss2OZrkLNXJeWqWbVoS85S8WEjyyOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308559; c=relaxed/simple;
	bh=FGjOAEedGbzkZx3uPJmlVvEc+LGP3vqZATJXRkTXrWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZhXgpCGf1PD3dMwFl8oQ2p9M3wA4/ddELlEFRSaPHscntHPaNuYaHLnA33StcXuL7DF7Kg1D86IeUTzk/Fos4BSVmlBGRIUpFvBEwthxRKxtqXNEU3eiI4zdBBW4M30PVg10DxSyo3C/QU1v8TRXuqvjUfyTW1JqNr/FvDH+lxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=donvntE0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="donvntE0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=zYEQWWEWu9vmO6LXcUJMgpQn907JHynCzhQHzrjF5VQ=; b=
	donvntE0H5+VFNPTiCV7MmE14Dbw/5+ywhNFgKkoj7rGetP1aJbj0EbulLrC5vQz2/7YfMpB4AEEF
	PqfX2BWTMR+nq40v0wgbPfkQslPjDlHctnJ4zTCjwpfQbYUnFRDsyjIXnf3NUMSP6kNknlHmyghcA
	ORv5ZI/WnXQb5mIZUvomkpGtvsZ/yhFXeJeyDt+3AcxvqcFHoJaYz2HMIrRn8qcSKdQcQUDL2fniv
	yRj2fzKZdIwPeKLvlGMkTimCT1iBwj+C733xLm2C/HvcMO0ew4kTlXy5tKUFBBQygt5Efeb8wUByo
	Tb54EgsChcxzHCaAPep06NpSCGV7FvHwew==;
Received: from [175.211.71.73] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wxMau-0070dF-7Z; Fri, 21 Aug 2026 12:35:29 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] sched_ext: serialize concurrent cpu.max writers in scx_group_set_bandwidth()
Date: Fri, 21 Aug 2026 19:35:19 +0900
Message-ID: <20260821103519.535987-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Concurrent writes to a cgroup's cpu.max are not serialized by the cgroup or
kernfs layer -- cgroup_file_write() calls cft->write without cgroup_mutex, and
kernfs only serializes per open file -- so two writers to the same cgroup
through separate open files can reach tg_set_bandwidth() concurrently.

tg_set_cfs_bandwidth() serializes the CFS side under cfs_constraints_mutex,
but scx_group_set_bandwidth() runs afterwards with only
percpu_down_read(&scx_cgroup_ops_rwsem) held, a read lock, so it does not
serialize concurrent writers.

The ops.cgroup_set_bandwidth() callback and the cached tg->scx.bw_* stores can
then interleave between writers:

  CPU1 (writer A)                 CPU2 (writer B)
  scx_group_set_bandwidth()
    SCX_CALL_OP(...)  /* A */
                                  scx_group_set_bandwidth()
                                    SCX_CALL_OP(...)  /* B */
                                    tg->scx.bw_* = B
    tg->scx.bw_* = A

The scheduler's cgroup_set_bandwidth() op is invoked out of order and the cached
state is left inconsistent with the last writer; the 64-bit bw_* stores can also
tear on 32-bit.

Serialize the SCX-side update with a new scx_cgroup_set_bw_mutex held across the
callback and the stores, so each writer applies its update atomically and in one
order -- the SCX counterpart to cfs_constraints_mutex on the CFS side.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/sched-ext/20260817172131.BCDA51F000E9@smtp.kernel.org/
Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext/ext.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b646711a45fe..a2fc581d9636 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4677,6 +4677,13 @@ bool scx_can_stop_tick(struct rq *rq)
 
 DEFINE_STATIC_PERCPU_RWSEM(scx_cgroup_ops_rwsem);
 
+/*
+ * Serialize concurrent cpu.max writers to the same cgroup so the
+ * ops.cgroup_set_bandwidth() callback and the cached tg->scx.bw_* values update
+ * atomically in one order -- the SCX-side counterpart to cfs_constraints_mutex.
+ */
+static DEFINE_MUTEX(scx_cgroup_set_bw_mutex);
+
 void scx_tg_init(struct task_group *tg)
 {
 	tg->scx.weight = CGROUP_WEIGHT_DFL;
@@ -4945,6 +4952,7 @@ void scx_group_set_bandwidth(struct task_group *tg,
 	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	mutex_lock(&scx_cgroup_set_bw_mutex);
 	sch = scx_tg_knob_sched(tg);
 
 	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_bandwidth) &&
@@ -4958,6 +4966,7 @@ void scx_group_set_bandwidth(struct task_group *tg,
 	tg->scx.bw_quota_us = quota_us;
 	tg->scx.bw_burst_us = burst_us;
 
+	mutex_unlock(&scx_cgroup_set_bw_mutex);
 	percpu_up_read(&scx_cgroup_ops_rwsem);
 }
 #endif	/* CONFIG_EXT_GROUP_SCHED */
-- 
2.55.0

