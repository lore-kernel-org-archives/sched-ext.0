Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F2C21B905
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776302826; cv=none; b=WlJsr0lZF55qAOjYut7TDksSpT1gBwZuNgU0gbC+ABEb37ImoiImUrmYkSNe+TkMzDBXshcKJa+o0SffFmKmKJ0O1cNSGtJnc4PzwpLN19TeATb2GfnT0g02m0Bq5pJwl14SLpqDIPy369O7C/5k4ftRjg19sDF+zyZo8b/KLYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776302826; c=relaxed/simple;
	bh=7wkOda3k/2g1VtJH35ebCMMz+SpWzj7atqmELaOUgWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pd9Knit77LmtBAYk6WfjrDoAghG9LNA6wh5hUzwu2m04tF7Pt4+vwU7dNRJB1hgh1Xh6/t2teD+t3/GUHXaVozfDiuly0hmi1e7CE45fdp3RbwjJ0bJLHhQcQubE5vawCae6dO0B+g9KrlwvObpfu7YGcrTpPoWrBMp1Vbhohxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=dV6QP2H4; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="dV6QP2H4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6u
	mo9uiMiI/490+WIKGFpuSF3l9fvNVPyaNvAZu7WJI=; b=dV6QP2H4j+Jg1ejjhX
	OZQJYaqdHLu9aXvVqh+3NUC+imNdpRfrwBlJ7osWB5lT4oLnf/rtFtJutK9GWnPx
	ImGDOAD4Nq4Va6QY1WTDujlR+Qj8XjBErtnZy3yjymY3xcFbvae+I7lY5KCYTfqr
	LOmoDIpyNcRJ77/KzOvrjOCZU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3P6_POuBpPsBlDw--.10078S2;
	Thu, 16 Apr 2026 09:26:39 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: yphbchou0911@gmail.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH v2 0/2] sched_ext: Cgroup sub-scheduler minor fixes
Date: Thu, 16 Apr 2026 09:26:27 +0800
Message-ID: <20260416012629.48414-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgD3P6_POuBpPsBlDw--.10078S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry7Kw1fWF4xAw17ZFy8uFg_yoWxurXEva
	yrCFyDJa4YvF9xJa4agr4DXrW8Ka1UXF95G3W2gFWUur9xAr1DKF4UAay5ZF1jqFW7WF1f
	J3ySvFWrJwn3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjDPEPUUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqxBVzGngOtB5cAAA3I

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

This patchset contains two fixes that I met when testing cgroup
sub-scheduler. Patch 1 add the -c option to scx_qmap help, which support
sub-scheduler but has no clue how to use it. Patch 2 add logs when sub-
scheduler is disabled, almost the same logic as root scheduler.

V2:
- Add [-c CG_PATH] to the usage synopsis(Cheng-Yang Chou)

Zhao Mengmeng (2):
  tools/sched_ext: Add missing -c option in scx_qmap help
  sched_ext: Print sub-scheduler disabled log and reason

 kernel/sched/ext.c         | 39 +++++++++++++++++++++++---------------
 tools/sched_ext/scx_qmap.c |  3 ++-
 2 files changed, 26 insertions(+), 16 deletions(-)

-- 
2.43.0

