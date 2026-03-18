Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB74363C77
	for <sched-ext@lists.linux.dev>; Wed, 18 Mar 2026 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773813764; cv=none; b=EoEpgs49aU1+eYiBzVNz3nc9vrJhk/IirIn6BzIQ5l6tuPGEwB6d5r762sUh9Vo2ei4MIbxtNDBxncxOKJzqtykeuHecOL4zZAI8xLdKih3CmU07bfhmmJiOYFDhYmLCC6Uwm4XPEh5YEjWVt74pc0VL16xi5gm1JB9UHZAGoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773813764; c=relaxed/simple;
	bh=oUlk2n2Samf+iUJU+Vashp2Zl+eq2zZZX0pmSpCwDTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=if80QmqD3LWYbTf9yV+IcpMnhrfjzBX+NyaaKeMHLEll586nxECwmNp5s9KE527IuUyOLZAcsTMeiBEzj7aNEdvg+xijmiNDBfFoP/kxksXKGwSnR48c3yN6R+vJvtW/dNWBvVsDudnajrec10Y0qrkjqDuv4NLSuBAPyWans8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apyB3KhA; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apyB3KhA"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so3506675a91.0
        for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 23:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773813762; x=1774418562; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJkIVtuxuti/XXH+Al9drVlkAla5vyfHEBgWFGTXaE4=;
        b=apyB3KhANFxroZx2c+K1yuUbw7Xxqk6kfW5DUeUI3WBmiGv7WmmXKNdaTwcSyNW3P1
         9rLxJPld6Fk1c5N72eqL/0tooo9Mybrz4RJO/El/ho3lgALtBOJMpFiYXInWnDZ11zf+
         w7YBtcQJF4N0F/dyzFD/1Wn9xFxNSbvAUcRsblut40JU57PEgCnaHuUBtWLyK8dsG1y6
         Rkapp0afbK4+xYrL+Kucxxg3Sv3897mGdatcjAK17z9bB/KgQn7k/sU28jBrh+k2/g2I
         rlVodWanE9qA9XG93LArsY3h64N+yrwj56elYYYqfL65DuSJQp2DCTWGR+X+tZy6ZkUv
         1ENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773813762; x=1774418562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJkIVtuxuti/XXH+Al9drVlkAla5vyfHEBgWFGTXaE4=;
        b=oYQUq2fX5zhweH4WwwunHWnb/xvIunBsfkDUNlIfgX0w1PtIt10CKBTIzPhp+HhHY9
         NvLYYc2tIw+I9ym6e2N/YgwzjMhIPWr/8iJnL3QZvNewj9XRKSBdq+iRJIAc0834sCTr
         vXn/RXgdZi7Iq6lXnzADfLN7hByS1a7ucG5BvxVtFBIFk0vPSdk/ionrXXmcuySS2pE8
         sfZ8n8Kyiabv6EdU3GwOX9F6dRVDjWyJDPL3zSv67JE4Q5P3nzIf+//1EVwaggu7rFVY
         15By7z0ws3rE5FCnThJvm+rdDciMo/Ft7uKbZfuoRx894UHYj0qgCC5IKHi9bQtsUeS0
         I7MA==
X-Gm-Message-State: AOJu0YydPXvDthiw5EFxBIpuL4+4eqI5MJGoPxRLsnQhFBw1evqqDSVr
	kelfqtSyPwM52fsuCTFhJ8nZBFOAEl0EoNR0/c5fN7KcQliRLcqbXPwC
X-Gm-Gg: ATEYQzzs3rmmaQDaWKXqFycD3dOnzQSgy6bCT04ux0uA7xqKwoX28zXMAIM7bqo2VMA
	ezWopQDEZMwFdMMPxKxfUIcJJAWNTat0mswzdrRSfs3pVzkqWlKd7aRF0JeECswIaRbUKf2qr8L
	hAH3fw8U3FgPf581aSXj/d+4Es2hr9N6StLH9HDSDaj9EDNiQ5YxfOJ0BCdlUwHyjYg/IUtYTfI
	pUOoIJ3O6B+gdf9W4bkwy2Yf3HJTLBy9ZPCmjlbbd+b0GCEh6kQlUsVqtJycmKxRP+2DU7gjfE4
	XxYHxGVaRLD1+AR4fXTN1CNO0Y0Mhk/JTrI+eCvLxg3mg328mda1CH/cai2R/X3ciptWDBeR6dA
	Zul9zvQptPZOB0qElaEIilc61Xysj+ryRgiOkNlG/K6nDLcyPpuyrbY3fwFO5hgEuS5BOJ808Gc
	zNh6ZGducI8UeTCyiZ+KY75oIjZVnadW1VwDj81g0Nnbc0xWGA7xg=
X-Received: by 2002:a17:90b:5350:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-35bb9f56531mr1863267a91.23.1773813762214;
        Tue, 17 Mar 2026 23:02:42 -0700 (PDT)
Received: from SH-PF5NDYD6.Hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bbbedd0desm924453a91.4.2026.03.17.23.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:02:41 -0700 (PDT)
From: Ke Zhao <ke.zhao.kernel@gmail.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ke.zhao.kernel@gmail.com
Subject: [PATCH] tools/sched_ext: Update stale scx_ops_error comment in fcg_cgroup_move
Date: Wed, 18 Mar 2026 14:02:24 +0800
Message-ID: <20260318060224.47393-1-ke.zhao.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function scx_ops_error() was renamed to scx_error(), but the
comment here is left pointing to the old name.
Update to be consistent with current API.

Signed-off-by: Ke Zhao <ke.zhao.kernel@gmail.com>
---
 tools/sched_ext/scx_flatcg.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 0e785cff0f24..c4019ac6314b 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -919,7 +919,7 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 	struct fcg_cgrp_ctx *from_cgc, *to_cgc;
 	s64 delta;
 
-	/* find_cgrp_ctx() triggers scx_ops_error() on lookup failures */
+	/* find_cgrp_ctx() triggers scx_error() on lookup failures */
 	if (!(from_cgc = find_cgrp_ctx(from)) || !(to_cgc = find_cgrp_ctx(to)))
 		return;
 
-- 
2.43.0

