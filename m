Received: from mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1B4DE70C
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553296; cv=none; b=RoG3NLz2eBzTFuW8ICYX1nTKgjL9x68I3Vhwq7aFodzNTo1cjpyhENiCz7E4/OH1sfxpyIvXJNy1EbAzX1IgeLcW/JHTl7b1utNycgniKG4bDKG9chq61vw2pHXMhM0DCSsqVeioxIHPgcr1iS1apwJvG50ofjJdTiei6Ib2dmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553296; c=relaxed/simple;
	bh=GO49ydbQY3uofxGlzBbu7nJC5F9utLoBO8WwpaZWBO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAITVrbET1W3wZkryF9LtWoLlEkkZXcrINZ+nWt2EaUwDmnp/7QQzmJOcxbX/ALd1pWfMHdft/sw9IyJNdDTarl2xG+sWGbsNdgw6Lv/j6DO6T8mJ+IYE+r+9fNesNXiYA0Svw36zaixtSW1Mp96XYDOWh3b6aHUsr39KkyV9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HKkzJ0b0; arc=none smtp.client-ip=91.218.175.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HKkzJ0b0"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=GO49ydbQY3uofxGlzBbu7nJC5F9utLoBO8WwpaZWBO0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791553291; v=1; x=1792158091;
 b=HKkzJ0b0105XvLLDnppilmcjYFn/+8dawKqfnh6VSbAU0wm16xF0OnRf1mglAnq6/EbAMLZ6
 xpayNqyz5a+hPB0SJ2Xwnkm8e2W+fM3b0LvUNmf0SBSi0BSe+cCs9GjgoMMXOyngbuODPDe/ntj
 SuRaZ3aX9zBIip1MAYGVx4AE=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id b50d5d2e115701bb;
	Fri, 09 Oct 2026 13:41:31 +0000
X-Mizu-Trace-ID: b50d5d2e115701bb
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 2/5] sched_ext: Add SCX_ECODE_RSN_CGROUP_OFFLINE to user_exit_info.h
Date: Fri,  9 Oct 2026 21:41:01 +0800
Message-ID: <20261009134104.296891-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134104.296891-1-cui.tao@linux.dev>
References: <20261009134104.296891-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The kernel-side scx_exit_code enum gained SCX_ECODE_RSN_CGROUP_OFFLINE
when cgroup lifetime notification support was added, but the tools-side
user_exit_info.h was not updated. Userspace cannot decode exit codes
carrying this reason.

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

