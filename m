Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA07390229
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492118; cv=none; b=bJ2B0pdXW2J8gwkwi9uTxKRSb1C4Ha4UetOurJY8kXfMbND1f+FqAKm2KMFaxpFf9e9SAt8jbaKwDyngyiZE6rFEGRyPenLuQfxGWDgOTiJenkwG1jTSU6Y5zqNsVhi8o/ISbD8bqQT/IEuoU2zhWnyz+xfvjBhGuAD2WyYZSOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492118; c=relaxed/simple;
	bh=XYsQVi8LZ7up/Vsh/sEein5NaUwK8JywpM4rSfY2bDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXvVUlIl1MzBcUXr89ozk/rMfFAEGSDsqiBK611LhEWYoNJEPtU4/OqKycXOH3oEwpQRplJFazvioXvMiU30ipE1xMSpsj9hhg+QAuBN+2226uIf8wvXzrpI5tzgAinQeybgPqYxvWw/Fy+3mvHmmUkoEVlrpDcEaCeeBU8cmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+NrmUN6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+NrmUN6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a9296b3926so2682875ad.1
        for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 19:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774492117; x=1775096917; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLWvjE/N6MuE6bPF9mB0bB6TwGLKGdda0eAW278f7KU=;
        b=O+NrmUN6khL5qWTKPnzCLy/KDuDpqfCFlJQGCay8M7NplzYI/uOsz2ZqNQjJutGjoi
         opDG55C0M11TMg2j+DnxINjBOybWE/euIXroW+T+LtH/SOoBVM2hywE52hLPhgE/UXjN
         qGy7ejg5tzJ9qLRZzPuuWdBkjCrvKplZJ2Kf+SGE1q9xgoXUVBdnf1Uci/w5SXjHM1wh
         CUykFPV/0RnC89x5s+1Ja7PHEXEFBUYil00FeQ+VArbA3ExM3VqnE96TUv15KjxztPJT
         4b2x9Men/gGNVxPFrtpIhvoeBCsilWDiik6beY22XUFbeGTPHoE5c1Cy0vEfyETXzxIC
         c2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492117; x=1775096917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nLWvjE/N6MuE6bPF9mB0bB6TwGLKGdda0eAW278f7KU=;
        b=f87TkasDuVygPHlrqt0twbg9PsaQcCWwhCeJVro7MN+82oswJHcU31phBGDCvnlTB3
         CAdz4qNYW7cS2KYi1Ttk/UMsa+xMnDAXz3FVTyeKgxJ7tsGELt8l44Corc9f3Vf1WezR
         0IfcOeAHTZuHFsaOupiERDQrPp7UqsiypVe36k0IySF89/7Lh8Bcjn3/1JqmwZVB57wi
         6lueY8q3e9Bp6sAHGuDapbGm1VBPSn1PwUIjCy8BeYLFu/vaGNxrEm5Mu/MzsAHnzm6O
         HYfrOH5dyozA0Mn5vTQvdsKDEbcdRKZuBqbLMEF90ZzJeZRK6l33BvfdvugGwVy2o2VD
         cNBg==
X-Gm-Message-State: AOJu0Yxxa/JaiSuja9HlQwWZVjkAtXB5nog8y2uejltjRTBmmEGbbYeo
	z4mb5YZmxuZ2L0Rxz/G/AvoLjf6z3t3HC8Vy7AVrE7tr47rK+Om3A8U6RdzGJw==
X-Gm-Gg: ATEYQzz+I4g16meioQlqc0XghsS/DayNjfCb32VkympxcDC6KuyCJr5ZJSccDASOWRE
	bfatAshzQHdw63DARWouI/24LPb+qr9mHfv+LGVpw1lebN1shUwm4MZhSHlaxCkALGC9o0AoAsV
	yeMaVzrCOOsbNqVJdoWLAgWCXdOsw7zgdbeaYCt/pjrUq27yk9htpxoK2ytYvGCJIzBToKEsz3z
	wjjkOzz9T086BSl+xlkCZOvx6Z3jh8MULBMwXAUSkSMmzw4UyOHNyrSZJ4Lg9lMj1jeaRi1tDyV
	JboRotxcebX53TzFBnFexH0RyWDdlQ8mKgwItPzZFWnxj8mHOGkCW46ykaSDVBsJHlplB1z8axj
	2I7U61FVQsKHhiqGW7hbjgYH4W5tGMJmGm6zK0BZM9frtodICUiNULWRLJb0XBQN+wnG3/enIja
	1ET57yRMfujZLL+8NagszpqTYkDGD6DqHlT6ipmfSvb+S0RgyxjpmYCg2se1fxi1L+nvbV5EAm+
	FRtyiUDFywOPA==
X-Received: by 2002:a17:902:ebc2:b0:2aa:d5e5:b136 with SMTP id d9443c01a7336-2b0b0af3befmr70874635ad.38.1774492116948;
        Wed, 25 Mar 2026 19:28:36 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76f184sm12969355ad.9.2026.03.25.19.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:28:36 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH 2/3] selftests/sched_ext: Fix dsq_reenq test reliability
Date: Thu, 26 Mar 2026 10:28:26 +0800
Message-ID: <20260326022827.3826287-2-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326022827.3826287-1-suzhidao@xiaomi.com>
References: <20260326022827.3826287-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dsq_reenq test was using NUM_WORKERS=4 on a 4-CPU system, so
each worker ran on its own CPU. Workers sleep 500us and yield,
getting dispatched from USER_DSQ almost immediately. By the time
the BPF timer's deferred scx_bpf_dsq_reenq() fires, USER_DSQ is
empty and no reenqueue event is observed (nr_reenq_kfunc stays 0).

Fix by increasing NUM_WORKERS to 16 (>4 CPUs). With more runnable
tasks than CPUs, USER_DSQ always has a backlog when the timer fires,
so scx_bpf_dsq_reenq() reliably finds tasks to reenqueue.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 tools/testing/selftests/sched_ext/dsq_reenq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/dsq_reenq.c b/tools/testing/selftests/sched_ext/dsq_reenq.c
index b0d99f9c9a9a..fe18c6af3877 100644
--- a/tools/testing/selftests/sched_ext/dsq_reenq.c
+++ b/tools/testing/selftests/sched_ext/dsq_reenq.c
@@ -15,7 +15,12 @@
 #include "dsq_reenq.bpf.skel.h"
 #include "scx_test.h"
 
-#define NUM_WORKERS	4
+/*
+ * Use more workers than CPUs so USER_DSQ is always backlogged.
+ * With tasks queued faster than dispatch can consume them, the
+ * periodic timer will always find tasks to reenqueue.
+ */
+#define NUM_WORKERS	16
 #define TEST_DURATION_SEC 3
 
 static volatile bool stop_workers;
-- 
2.43.0

