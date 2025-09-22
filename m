Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A212CD8B;
	Mon, 22 Sep 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504772; cv=none; b=roR1N9htBD/iqOFQQB+55pw1BBLnjXneeV2O4btn7pndT5s+Zf4qnwGkV16Eb8eHm7QKO99Ut0HJ0W2hGbGzogD8+nC1QJBjV0VU6C8k1xa1PjkJpYzR0kYC9dt7YSVDfmAgKA8nkBkUlfU1IxmEX6Qv0bP7nS54R41vN+nBC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504772; c=relaxed/simple;
	bh=7nU5v03BftWPqTaAzZYbuDLW9wu1WkEYWzembEyvQ24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdIl0SVxC+k+wehz+I4r6SpNyhN3L0LzOL8ZlATOT0baXaz56lzagsAO/S3oLQJCACUw2GWjWhffMHOCzTNMZNJRiGq10Jkm93c2XBKiR1V4r+qxw4wpi7v5nXTPOShrr4QEUmdQ/JinxxhXI1buWF2v/RWsE1gAmoinRBjcfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7g89Fet; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7g89Fet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D33C4CEE7;
	Mon, 22 Sep 2025 01:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758504772;
	bh=7nU5v03BftWPqTaAzZYbuDLW9wu1WkEYWzembEyvQ24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7g89FetMVslgvJgUhlDn5STxH1tJ260ClzJIz0Zn+Q2DHK9cSxXxJOnfCRTmbkba
	 6VbXn0zpu1Ue+OR7gdG4nH9b7pJ4QUKcQegx3EqdNa9eaghzriaWI+8oWgLhNElDTK
	 NX/AC8b0/6hhf417vIdEqnZKXmXQ+Hz080vYy0g1qlhdeaLixrzLyRW165XGD9Rfrl
	 LbDIeWornewJfHGLcNFQEz7b1SjQwbi91a1FHAjb0XDb/KeDt1mMt0yP4y1J8mzeoP
	 VXvROslJueAQ9sLNtrBmHWQ765N9Xjun8G/BMOakDRpuL4/TmPSOmSEBjsLDf/oXRG
	 YzL+0guKzj9Kg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/7] sched_ext: Add SCX_EFLAG_INITIALIZED to indicate successful ops.init()
Date: Sun, 21 Sep 2025 15:32:44 -1000
Message-ID: <20250922013246.275031-5-tj@kernel.org>
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

ops.exit() may be called even if the loading failed before ops.init()
finishes successfully. This is because ops.exit() allows rich exit info
communication. Add SCX_EFLAG_INITIALIZED flag to scx_exit_info.flags to
indicate whether ops.init() finished successfully.

This enables BPF schedulers to distinguish between exit scenarios and
handle cleanup appropriately based on initialization state.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          |  1 +
 kernel/sched/ext_internal.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5801ac676d59..d131e98156ac 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4554,6 +4554,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			scx_error(sch, "ops.init() failed (%d)", ret);
 			goto err_disable;
 		}
+		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
 	}
 
 	for (i = SCX_OPI_CPU_HOTPLUG_BEGIN; i < SCX_OPI_CPU_HOTPLUG_END; i++)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 1a80d01b1f0c..b3617abed510 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -62,6 +62,16 @@ enum scx_exit_code {
 	SCX_ECODE_ACT_RESTART	= 1LLU << 48,
 };
 
+enum scx_exit_flags {
+	/*
+	 * ops.exit() may be called even if the loading failed before ops.init()
+	 * finishes successfully. This is because ops.exit() allows rich exit
+	 * info communication. The following flag indicates whether ops.init()
+	 * finished successfully.
+	 */
+	SCX_EFLAG_INITIALIZED,
+};
+
 /*
  * scx_exit_info is passed to ops.exit() to describe why the BPF scheduler is
  * being disabled.
@@ -73,6 +83,9 @@ struct scx_exit_info {
 	/* exit code if gracefully exiting */
 	s64			exit_code;
 
+	/* %SCX_EFLAG_* */
+	u64			flags;
+
 	/* textual representation of the above */
 	const char		*reason;
 
-- 
2.51.0

