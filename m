Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F654372B50
	for <sched-ext@lists.linux.dev>; Mon,  1 Jun 2026 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329281; cv=none; b=ovNVeHR+mdAxuJGCsWevEUstULRYFuBvLytkzc+O2c2M6cpOukTyV8x7ngu3uCB+BgYXYmRxeyfdi4ukx1w/ol1yQ1nIn3OW78RCqFFO6PDUKssFimhOnBdfwoc3IYwuo6FALjkJZ6eRiM4lW41zqjz7bZlOu8+Yamn4fRhvzTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329281; c=relaxed/simple;
	bh=hlZBZqz5tyEq9CrBEiiBmpw3/OemZtzihyvwNijEMzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Abzuvs4WInU0+MhKZgNxe46CgB0W+4BRE5khhg0iYGTyUEg3r9iKnEdSsyKhmxqWOYOPcPn6vmhaASErOEcAlFD+rXVH8vAMIyV/nLgSTkm0EnCMDUN89P10xu/qsBYDTRbGA5PTtphn/4CW0SJIuiYjAS9MDeQhv/xt+cvma/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOmD3/I8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOmD3/I8"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36bcbd7821fso1419646a91.2
        for <sched-ext@lists.linux.dev>; Mon, 01 Jun 2026 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780329279; x=1780934079; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3UQqP1dEr1GoIfNwRf46B+2umMBSWEa9MFAzB8tetA=;
        b=ZOmD3/I8FDftg7N5RZvzAkeiHbUVJWgUrXXuyt+bfTrsve3BJ7jED7mO7Jldn9WyYp
         RdZHWqtQQNCTUcwZq/ZAPHe0Ab070G61Us9hNJ1VCovb/EtBaNESvtIaKhKtnr+lcIt3
         FWxSQd2Ud5lfOJL3xFlaOX7SkHv7yzyCQiVAU1oXHEH49T17q/wg/Cy/2wHg2qwHUcNZ
         GJJx1QRRmQkD2bk0z1dOV0YRaWgM33XujRL3dCiN+CB2xTXsirH/Epqe68zadWg/VZao
         Daxr1tDfKUniq38HG8jqCCx/qZrgg983g0K2KH4rpnGqS3zsf5zxl93/GH7G99bkm/ck
         O4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780329279; x=1780934079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3UQqP1dEr1GoIfNwRf46B+2umMBSWEa9MFAzB8tetA=;
        b=PmjWsZNEdhTtttpsq5rjm5SZ8wy4YSTPIqjb5eHonTh2AuwJI5oC4wDJ8Jmazg72cd
         KyuEwkZ8BEANKUHPDffG3jKrWELqfO8i0+vngIktK0DaChcX8SlWqSTrTRBl8pCoHdDk
         YmRStidDf/N+J3vzvU1CRsJjoK/Bx+NiIz8dSFZyvzBPmmwHQHATUfB81Os3umWdARSx
         Ry8EXtB5u8/jZ5gh8VtovHn6Pw4FgFM7t5VN6Zpwhq2fhvTg9YYg5T77jXzlhr4QPbIe
         aaadsNBsEAlxU73sClZv2TBgh0uGO1o5wOIny/fDluey9zRgbUvZjMb84deUeC3BYV5p
         g38w==
X-Gm-Message-State: AOJu0YxWxQkw9TiQioRVUFckIWN8/cLoK4YDKrwcFOcMrrFTLXzcyUB1
	KZ3gsTdRrCAwsGV8ONgBz0b+bYxwH+BsPBRi9KHX1cEC8X9UD12+OtuQEBu62g==
X-Gm-Gg: Acq92OF+HpgnPxMvMg5MSYWg0wIGW5u4jp9slTrkp1gtkZfJQ0lI/84HylTMewSSByP
	kriltDMNZlNw2NdqYs2YHFjbn4xzQsJUeAS36Rg1/y+DWG6I+z3rL+zHxeZksCET2XYMILOwZkP
	2XhPnktQNyix1ci5w8mZ0juUvlQRDz/YFxE/SSs3teIultbOaNv6L78RuXt2DKp7KjdKGfkHue3
	SWfT2o35l3ZTwTF/gVXgY4gP+hVQ/oaG8/RhhEPU/yMtBBkX62jA8/R3UPOE1RiHcTVKtC8wTN9
	3o4u1puk6X9O+U369wlnQNOcywDtgaoCTcpvymnkKAI0G/Qc2hlAgw0rS1o2AuRjaarfmsm1AaI
	voOARD9pbCIteXCe2ruWji95Ii3Sgq6bSRK2SfQ0HN9Z9JaJoiqh6H85Ug3s8lENH3loaf5CCJO
	24lID8TspL1q0nFFchoVFjciYEYcxkbxjOlF20JqLHQ8jr9Bjt0o+W9Jy1y3I1xA==
X-Received: by 2002:a17:90b:3141:b0:366:1bab:c3d6 with SMTP id 98e67ed59e1d1-36c4ff6456emr12266929a91.10.1780329279209;
        Mon, 01 Jun 2026 08:54:39 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:197b:3172:a431:c73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd90415besm99131a91.0.2026.06.01.08.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:54:38 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.2] selftests/sched_ext: Fix dsq_move_to_local check
Date: Mon,  1 Jun 2026 23:53:48 +0800
Message-ID: <20260601155426.1460441-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scan_dsq_pool() checked == 0 against scx_bpf_dsq_move_to_local(),
which returns true on success. This inverted success and failure,
causing peek_dsq_dispatch() to double-dispatch on success and skip
the real_dsq fallback on failure.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/peek_dsq.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
index 7f23fb17b1e0..9e802b52b29e 100644
--- a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
@@ -95,7 +95,7 @@ static int scan_dsq_pool(void)
 			record_peek_result(task->pid);
 
 			/* Try to move this task to local */
-			if (!moved && scx_bpf_dsq_move_to_local(dsq_id, 0) == 0) {
+			if (!moved && scx_bpf_dsq_move_to_local(dsq_id, 0)) {
 				moved = 1;
 				break;
 			}
-- 
2.48.1

