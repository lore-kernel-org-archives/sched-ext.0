Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C634D90D;
	Thu,  7 May 2026 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191357; cv=none; b=OU4HNoGew4Ua7n0CL49tMN98KfyXmwPUftiVh5aVOU2wDSMPGs/4i5JiqAtWL7HMu/oRsZtGDic16fykC0WpXSdJeZSaQGSLkFrzJ/14okdMleFziF5ACCcmjbHDXc98DpyBZE6KK8G7cX+iRd8YXJMkwY89pAmJhIjTec1xL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191357; c=relaxed/simple;
	bh=1uAy3urIuHx8PVwOULS3x/fKKuptIWToQJJv7w1dCoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SC/qpMqqAiKolHrA7MphZqBds8TmHTTkBD+edsK06eX+PqIisy97OJx+7XDyb3BWilpgps/GX7eOSkZbf3vCf+3Do9NCT7nvMaQP5C/lYn17Co4fKIVZa3Ejk0TC2lACKIZLBa0OC5a1sl2itd/tpsZbeafZcsAC7y/4rn44dz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxjVPe4k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxjVPe4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B41FC2BCB2;
	Thu,  7 May 2026 22:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778191356;
	bh=1uAy3urIuHx8PVwOULS3x/fKKuptIWToQJJv7w1dCoo=;
	h=From:To:Cc:Subject:Date:From;
	b=sxjVPe4kIXEs4uU+Yxjcr8Zrm8GIqAWZPtDgMnFp1QZ6JiO3k0cfccVcl5E/AQnlv
	 +c1iKSI/k2org2n/81Z/aq4BNV93RWX+BY+HBSDNYFAAGFXtTh8DWJPIjLCb1/4A2Z
	 ACgsIoEUUKApNl4EGkMaG3QHtUM8teApxUhN0Aiob+Yx7HhN+0SnZsw6SHETm7bzcr
	 //DVn7l3v8x+JdHFokij6LPeSGV4AUOwEU7VTsWJOeZ9vW4h6QlY3IJ/5LSKLzp/2E
	 JKE9G9TPH1oHUOViT67A4Ojm5HTwazW5W1/KqIr/KNg5vx4UVdp64TdPtGM1nM6BMF
	 7kJGlz+u6nFbQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	oe-kbuild-all@lists.linux.dev
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Drop unused scx_find_sub_sched() stub
Date: Thu,  7 May 2026 12:02:35 -1000
Message-ID: <20260507220235.3312282-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

scx_find_sub_sched()'s only caller, scx_bpf_sub_dispatch(), is gated on
CONFIG_EXT_SUB_SCHED. When CONFIG_EXT_SUB_SCHED=n the caller compiles out
and the stub becomes dead code, tripping -Wunused-function on randconfigs.
Drop the stub.

Fixes: 25037af712eb ("sched_ext: Add rhashtable lookup for sub-schedulers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202605080556.42PXw8U9-lkp@intel.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7d367c140a36..48b4834c7027 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -297,7 +297,6 @@ static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
 #else	/* CONFIG_EXT_SUB_SCHED */
 static struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
 static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
-static struct scx_sched *scx_find_sub_sched(u64 cgroup_id) { return NULL; }
 static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch) {}
 #endif	/* CONFIG_EXT_SUB_SCHED */

