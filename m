Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC8337BB0
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774489753; cv=none; b=Kvvnofn/iqIMss/hzLgpvvxM+gP3t09x8/NSes0eh9WyMfX4glm/UUzUjHK2nfx9Aze4pSqUCV4epXgL+UOOCi6x+2px6gz6tumw2Ume2fZCBtvj2DP5JkroMSGeZzqGsMslQ6J7f7WSC+htAlEIbdpsvqm4GUHapr6k6w/MWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774489753; c=relaxed/simple;
	bh=4zsMZCmk/XgJtLg8+o9hrqV5dHNF6Ozlih6mfwrKStc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJkMR7Wfd5dTrQLeqBHTJ9p3RpCAMRfTUKE+GEVLm8dkBkq6br69acHgfDhkjyz5mtR+YqTzX63ZFMVJjHd1jzd5h0KSWDBhMrRePtyApFDQfUAXac+NJQbyqr/g+C5nWSrMVR84VnGJU1/0urufw+T+gOAn1AMd2qPvPxKXYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkNqCU5j; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkNqCU5j"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c742d4df00cso653418a12.1
        for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 18:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774489752; x=1775094552; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W0hg/UnZZd+sQlacJtEHcAZO6kRoSsZRPFU6nCBKQS0=;
        b=YkNqCU5jXu/9H3/3Mf9lJjBwI9eJwArgIt/24IIV+M3v1vwS+0azXRq2HS9uKTmSuu
         o6WWriPwT+/b4W9eoKHxYrzxauLrUiLajHwMfMYn8R+b39SqNCZHqnZOn//CXOK27MJA
         +QpVNbi8UREnb5/qZLwfcllNUkjrQ+vaUF2dvzKpu1sEYc6hqk1MQy2dOC3juJV+09Zd
         R0xTX1YGKI9UJdMH2BQaTlvLVMwk4RBsNyB0kf9GiBV7k1v+aiTL7ZV3NFeGpHcv7uXC
         P26ufpiolvCMxVvpMcmqUlk9qHU3H/gktQnVKPmydFdJsqF+0fTFLRM4+Z5Z+jT/z3mb
         SjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774489752; x=1775094552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0hg/UnZZd+sQlacJtEHcAZO6kRoSsZRPFU6nCBKQS0=;
        b=De+792VDSW4Yqk/qzx+L2aI7pOWDUU3CyBn3wp9iHx1yP3dkHWOmfm9KN9RwXBzP1K
         tVNBi8XHMRobUAI6VkLPuxxmyHFn+BPTnQ6zzGum38432Krzp528HbwOB5zYghVvTiDS
         +gQxUrVMPytj5Z5AKPJ+3nyi1miiQ8ZwL03V2OcNb2UafTBoXX/tWh9C/xfWWS52Fidy
         aFrNg+9N9/GbCvkE4tb3qrl24a3pu0T8u89dhAntMTC7RKxdlVDGA5u1QNK9/UJ7JTp3
         j26KKvRaMJ+GTpilNCB3A1ywudoD36Aux53bMR3jl0MAeslPIIV2z0K+ghZGWcub1Imn
         IkUQ==
X-Gm-Message-State: AOJu0YyMT1NxuiyB/nnCm6IP1nw6XVG0UPcWdaXVnrtKA8be5ZziEvWR
	88vNalzFlsHUVjMGEA5iXTITGAI0+JiB3gpIhakOvNlvQdqz38d17G244Yoyrw==
X-Gm-Gg: ATEYQzzRZWHRZwjEHhfmKaVRRxhJ1dcOqNSLVU7duEJ/z+83aI+KsYM2N6T7vs69JIM
	5XmxnEQoHSxAUweqJdgsTayV+w/EhOepIZ9cY0RM6fbHpe+oNMtoBsoKkkTARp+NgZtvtdupocj
	Bpmro3oG+E8RG5e1on3ij3+XccLN25eyp9Ua2TX0XHFD4yHSNF/l1ojOsSXAB9gCw63HqVL/snk
	2HoI/q9NR17NUcvSrDCphYw61I7LzT26HZWW41hQTZ/sy+5jnUgW9jhLJf/Fjg/gVeojfFuXNq0
	GbGwzCEafupnrMOLljNtu7QCwkOYHagZgb//z+No6NO0jOY+rbV1hbcaZWYbXJOmEtYGm/OYYpv
	p36gSRowEupHRDX9dxzEZlUWfNBpBieBHQbaQ156G1FwsQE78UgrVRpMw06O6oi3aGBTDhVtnDs
	DqGJ4+UGiziU0ePFREYBqX7JhPh25Zajbz/YbufqJBSw8I/DTfDDo++ge6PnhRIA==
X-Received: by 2002:a05:6a20:6a1a:b0:398:7daf:6d7e with SMTP id adf61e73a8af0-39c4ae075d6mr5907744637.17.1774489751713;
        Wed, 25 Mar 2026 18:49:11 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:ac9c:4df3:99d:84b8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673956b15sm689626a12.22.2026.03.25.18.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 18:49:11 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext: Fix missing SCX_EV_SUB_BYPASS_DISPATCH aggregation in scx_read_events()
Date: Thu, 26 Mar 2026 09:48:27 +0800
Message-ID: <20260326014900.616897-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

025b1bd41965 introduced SCX_EV_SUB_BYPASS_DISPATCH to track scheduling
of bypassed descendant tasks, and correctly increments it per-CPU and
displays it in sysfs and dump output. However, scx_read_events() which
aggregates per-CPU counters into a summary was not updated to include
this event, causing it to always read as zero in sysfs, in debug dumps,
and via the scx_bpf_events() kfunc.

Add the missing scx_agg_event() call for SCX_EV_SUB_BYPASS_DISPATCH.

Fixes: 025b1bd41965 ("sched_ext: Implement hierarchical bypass mode")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 551bfb99157d..57c33127fe61 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9408,6 +9408,7 @@ static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *event
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DISPATCH);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_ACTIVATE);
 		scx_agg_event(events, e_cpu, SCX_EV_INSERT_NOT_OWNED);
+		scx_agg_event(events, e_cpu, SCX_EV_SUB_BYPASS_DISPATCH);
 	}
 }
 
-- 
2.48.1

