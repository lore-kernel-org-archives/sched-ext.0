Received: from mta1.migadu.com (out-231.mta1.migadu.com [95.215.58.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1F38398F
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983625; cv=none; b=F2NSsDDFEezbh8Hkfv3xIkeb7cq2QUyEJ6BSiMGvbEnCkdt3usDO4XxWztQ3XkQJbyzGDJtGdnty4hzWCVDmgSzRh2c1NwLbfkazlKKewASgYU1fmxLqi7YEshtK0tbPNS/iEofhg5o9hxJ3DIOCJB5oHmfDSN1WpUVkIWzn6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983625; c=relaxed/simple;
	bh=Rr2R6/F9bKNvd15PFp7+HtnF5wS03mM4ynW4JGy/vlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKoXgoq9nHI00d0xzm1LFs93ziINX77cjuQHqBnxjUgupWIUbIcukzpBZoy30z9FLtBh8Z+T8ijK0vwWybmE2KHNg59CSmS4RrgB5jCDxnBxPdfZqzbi1x+MhLUowkQw2H5QSzZ09rzY+iXdRONDAeGnczl6b9SWZcea6C6Dpoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xxGvZxBy; arc=none smtp.client-ip=95.215.58.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xxGvZxBy"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Rr2R6/F9bKNvd15PFp7+HtnF5wS03mM4ynW4JGy/vlU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791983622; v=1; x=1792588422;
 b=xxGvZxByzekmMomIQU/Ey1thkYJtnTbInt/KKJXL23ZdP9bmQdBKU/gtWRZT6pCn6nNBlUul
 gAnQoF5gQMicxQGwR9LGsrAklV3rF140QjNEovBk5W2VE6op4y5BTstYJcpQP3d67V8JKEeXqsp
 IZFes8VwW9w1o36REEoo62y4=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 9ccb304683642eff;
	Wed, 14 Oct 2026 13:13:42 +0000
X-Mizu-Trace-ID: 9ccb304683642eff
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Tao Cui <cuitao@kylinos.cn>,
	cui.tao@linux.dev
Subject: [PATCH v2 2/6] sched_ext: Add SCX_ECODE_RSN_CGROUP_OFFLINE to user_exit_info.h
Date: Wed, 14 Oct 2026 21:13:21 +0800
Message-ID: <20261014131325.793640-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014131325.793640-1-cui.tao@linux.dev>
References: <20261014131325.793640-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The kernel-side scx_exit_code enum gained SCX_ECODE_RSN_CGROUP_OFFLINE
in commit ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support"),
which exits a scheduler when its cgroup goes offline, but the
tools-side user_exit_info.h was not updated. Userspace cannot decode
exit codes carrying this reason.

Add the missing enum value.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/include/scx/user_exit_info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/sched_ext/include/scx/user_exit_info.h b/tools/sched_ext/include/scx/user_exit_info.h
index 56a02b549aef..cf27ac2447ef 100644
--- a/tools/sched_ext/include/scx/user_exit_info.h
+++ b/tools/sched_ext/include/scx/user_exit_info.h
@@ -52,6 +52,7 @@
 enum scx_exit_code {
 	/* Reasons */
 	SCX_ECODE_RSN_HOTPLUG		= 1LLU << 32,
+	SCX_ECODE_RSN_CGROUP_OFFLINE	= 2LLU << 32,
 
 	/* Actions */
 	SCX_ECODE_ACT_RESTART		= 1LLU << 48,
-- 
2.53.0

