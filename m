Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43D51DDC37
	for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246903; cv=none; b=J9UTfSKhOpbm5kFjRk3ODnoSLDGkBSLIqzrOUMu8xVBIjJc1SX0qP9PEwV7lZhsjvcsvm6vdUVg563ABcNkCQH4tiQJZ5Oog7NpL1SfC3oAXjI1jqgsXyVkWxOK0eGC2dLC3k0WiA0GEwjrWiQ1Rg2Y1sPSzjkADdLXlSWcUz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246903; c=relaxed/simple;
	bh=iMmAkvpN9OOzN0idyzapvtGL7hYfIPUpeo5kobL980s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doL04gqXEOjd+50rVKToeMxhGY6mttzmh9fndtahQRCJ5/zXoI9LJcFdBYX2/lwHFHzhEe2mBnHtUtGSxCo28UkgV232VSgMxcB4yQKuTyqhnPH0beRIeoeF3Has1oAtwzZqWnhOdWtxSJ2RC9mWsCJdU09L9/ceV4uGeZMEYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nOeWa2iX; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nOeWa2iX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rj
	DvPX2U/i9yWovLUxlYNnul2+BaP/yCu4qYEAdj52o=; b=nOeWa2iXNchYcoiCuR
	4pAQ2eHoVLgqlP3GWYZr/uG5h8Q9z2VnLPdRbrKClu4KkFCjCDM6oBDSGt3qOGm7
	BA1cTnnazdSIjsdIlXC/nDZFZYtdtMRsLPifSDzIWMBf6boiL/MOxO4BdxrO3l7d
	x5NsE9I7fCJSPpNodYCzctxkw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3n3ROYN9pPIBzBg--.58134S3;
	Wed, 15 Apr 2026 17:54:23 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH 1/2] tools/sched_ext: Add missing -c option in scx_qmap help
Date: Wed, 15 Apr 2026 17:54:17 +0800
Message-ID: <20260415095418.307555-2-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415095418.307555-1-zhaomzhao@126.com>
References: <20260415095418.307555-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n3ROYN9pPIBzBg--.58134S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFykAr17CF48uF43JrWkZwb_yoWDWFg_Ca
	15Gr1xZFZ8ZrZ8Jw4a9r4YqrWfKFWkWFZ5GF42ga43Ja1UJFn8tF4UCF98JryUXwsFvF13
	urZaqF1UAr1q9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8niSPUUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlg999GnfYE97cwAA3B

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

The sub-scheduler api has been added to scx_qmap, but the new -c option is
missing in help, which is hard to understand and use. Add it in help.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 tools/sched_ext/scx_qmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index e7c89a2bc3d8..b5fce6dcee14 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -32,6 +32,7 @@ const char help_fmt[] =
 "  -P            Print out DSQ content and event counters to trace_pipe every second\n"
 "  -M            Print out debug messages to trace_pipe\n"
 "  -H            Boost nice -20 tasks in SHARED_DSQ, use with -b\n"
+"  -c CG_PATH    Cgroup path to attach as sub-scheduler, must run parent scheduler first\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
 "  -S            Suppress qmap-specific debug dump\n"
-- 
2.43.0

