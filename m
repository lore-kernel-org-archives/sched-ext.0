Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053481FFC59
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776302825; cv=none; b=tb/j/dysTnLJEO2gSufWSL/TKiZzf5SBZMh06WStGv4M0FSOFj3JZYBaqXWpqc3qTpXD3rqwiXQzuHfzMRHI8CCoWqc7FZWkYEIdpj6rkXnFHfppz24R2+xbWQbTnbme7Ctw1SjRuCYJsLcN9DEIgEgrq42+gu1W0oPgD/v6ZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776302825; c=relaxed/simple;
	bh=twuqFePOdLJCqs4Dww+Nh833c/rdSZMR79UDQhDBXjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCQd6pjjlFcEF6h33NAfM3VBVs3H4HqcDTWwynO+WTMn/8ue5su3ebv1I4owZPjXRafKLV6qTK3RtDKF0AX4NipG5+nzExB+HWJWCZ8mhcrTb6sdyMSImZ0VWIu5JJ/E68R7oxUbwvuNcQZHBl30PxQE0Y9K22Fuk8ea/0KYGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Va8ncJI8; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Va8ncJI8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FG
	7wxpghODdWOL/Jx59tqefNLB283u26RMIuDDw7osU=; b=Va8ncJI8hdQszQLv/S
	JJeY0ga5+vQ9McduPyJpyAZOQ8ulNVuhvDVh9yW2OQoyfLivh/2+bgXBYgQJPG/b
	is4cASGOQ68DsFsYYwUW8CNf1wTo3pLi8yw3GjgVqs6xn7Hop7vWpHfudZczfMIZ
	vSzv6Gnm7o/Y9wvZcqzY35NYQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3P6_POuBpPsBlDw--.10078S3;
	Thu, 16 Apr 2026 09:26:40 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: yphbchou0911@gmail.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH v2 1/2] tools/sched_ext: Add missing -c option in scx_qmap help
Date: Thu, 16 Apr 2026 09:26:28 +0800
Message-ID: <20260416012629.48414-2-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416012629.48414-1-zhaomzhao@126.com>
References: <20260416012629.48414-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgD3P6_POuBpPsBlDw--.10078S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4DGryxAry8GrykWrWruFg_yoW8XFW8pF
	4kXrW8CryvqF1fJr1kZa48X345uws3WrWSgFZ7u34qvwn3tr1Iq3W7GFsaqrn8JryIyay8
	Zr9a9w17tF15CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jriSdUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlhBVzGngOtB+nwAA3d

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

The sub-scheduler api has been added to scx_qmap, but the new -c option is
missing in help, which is hard to understand and use. Add it in help.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_qmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index e7c89a2bc3d8..d75e77464307 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -21,7 +21,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-P] [-M] [-H] [-d PID] [-D LEN] [-S] [-p] [-I] [-F COUNT] [-v]\n"
+"       [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-F COUNT] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
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

