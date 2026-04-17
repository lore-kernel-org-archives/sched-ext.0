Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0F244694
	for <sched-ext@lists.linux.dev>; Fri, 17 Apr 2026 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776417529; cv=none; b=V3lh51+o67VgwfmOoIxom6zMa8SErAQuWv2DKLbLEQxnpkGHON+e2/bS0W3G9xU47ejoWC+Jj0GFM0BWaN9ESJfy/4QZUXCQyTW9BMljBotO15Eo61n7N4bk8eN5N2K+AQ2VzZ407JV3/PqzUSyepVRkBUTSN45/gRNQ7sHddoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776417529; c=relaxed/simple;
	bh=O/mebuCUkEA3/Nd3oABndkbrsYCXoTYPE60hWZMD9Jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZlicABqFr3jCrRAnqt4u1iJjFoHXaAP9T9QPylzc9++8hVzQ6uzKL4WjWJXk3mZMxDI9lFvhq+EIIly9CWJKGRHznR81T+dIqm1IPz8gxCQsEzMQKAkMeMDzib5+hoPZK0Ltg9srbfIFsiluVA5/jbMauEjAIr+mouVsSyKBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=J0tQ30KI; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="J0tQ30KI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=kNOCjAuKnRK9xQ88OZ2Vcbm4jyVbfNgNJCwQqDZGQO4=;
	b=J0tQ30KI6hq86n5UOKrZxMjkwZ1o3QaSm4abwJ7xNm+ojLCywZKvkjsTW9ZfQI
	Y/JirZ+dc2mM+uZTTk0tAFuiRNo0LYxkLGQ57RlFJXLk4grE9pxgpxrFigNiWL+c
	qxp1ehB4s0Wy5GAWEeURTByo+OQPMctGMvwbpkoMw7nEM=
Received: from [127.0.1.1] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3l+jY+uFpMSmcBg--.7149S3;
	Fri, 17 Apr 2026 17:18:17 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
Date: Fri, 17 Apr 2026 17:18:02 +0800
Subject: [PATCH v3 1/2] tools/sched_ext: Add missing -c option in scx_qmap
 help
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-sched_ext-0417-v3-1-e11b3aed57d3@kylinos.cn>
References: <20260417-sched_ext-0417-v3-0-e11b3aed57d3@kylinos.cn>
In-Reply-To: <20260417-sched_ext-0417-v3-0-e11b3aed57d3@kylinos.cn>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Zhao Mengmeng <zhaomengmeng@kylinos.cn>, 
 Cheng-Yang Chou <yphbchou0911@gmail.com>
X-Mailer: b4 0.15.2
X-CM-TRANSID:_____wD3l+jY+uFpMSmcBg--.7149S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4DGryxAryDCry7Wr4Durg_yoW8WrW8pF
	4kXr48CrnaqFy3Jr1kZa48X34rWws3WrWIqFZ7u34q93Z3tr1Iqw17GFsaqr4DJryIya48
	AF9agw17KF15C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jriSdUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqxnHP2nh+tky6AAA37

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

The sub-scheduler api has been added to scx_qmap, but the new -c option is
missing in help, which is hard to understand and use. Add it in help.

V2: add [-c CG_PATH] to the usage synopsis.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_qmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 4bdcc4bc5fbd..725c4880058d 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -23,7 +23,8 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-N COUNT] [-P] [-M] [-H] [-d PID] [-D LEN] [-S] [-p] [-I] [-F COUNT] [-v]\n"
+"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
+"       [-F COUNT] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
@@ -35,6 +36,7 @@ const char help_fmt[] =
 "  -P            Print out DSQ content and event counters to trace_pipe every second\n"
 "  -M            Print out debug messages to trace_pipe\n"
 "  -H            Boost nice -20 tasks in SHARED_DSQ, use with -b\n"
+"  -c CG_PATH    Cgroup path to attach as sub-scheduler, must run parent scheduler first\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
 "  -S            Suppress qmap-specific debug dump\n"

-- 
2.43.0

