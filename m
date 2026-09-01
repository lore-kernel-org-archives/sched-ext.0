Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84142AFBB
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276138; cv=none; b=KaE2cV0Sdp6Sen/l92Co8g3MxIXoLHa2hyU0m+wchMEAbYGmhPOeULa/lduxcJx5gQoIdolMEChYaiP5qEQUotugMiv6PZRLeVd80weBqOfs+l/jEpqDbeuThhXPTeKAbpIuExXctl1N4Mhdn+tbA9It1P0hbiRHE/qHfQqYJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276138; c=relaxed/simple;
	bh=CEPYJZ3jIkVHwYF3w/9XcB3PxmepmTehIoEbGFpjCUs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t8JDbUrka8uckaEXo16zeoJJ24GVJX23RcJt6ivldlhBjhboS7akkVnaXIWVZR8GgUVys3qmBknGWyI1qtlO/Jf2rNHyYeSCRoY+i5xU4hdeFqcX30UBBoFCCnABLmRprQSjUULlXMrjkSwvH7M3WfZzYKkgnMJHH8M5vStkq9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TpmQFiH9; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TpmQFiH9"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49953abe51fso28308945e9.1
        for <sched-ext@lists.linux.dev>; Tue, 01 Sep 2026 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788276135; x=1788880935; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WB3gaqcty5uU3bUEOpuRwBi4dDMCMvK/Ic/DzXm2h4Y=;
        b=TpmQFiH9XC0O8WUH4p8hDUeenywSYF+vkvOdlgUvbKgdRpN22iHtGORcq0pgFNYNUd
         5EHhtiZi/qsuUYfFGxF+lc18PEuUI9siuDPNCjkdOnE/cpOSaqZo4MewGLYir5Z7Ll0U
         FqmS1QGOH2+qBR5HjY8HNSeaEqVC2OLJIvtt/NJHsfQY9UET7CxT9z5hWpIAuQO8Nl2E
         Jadr+s85+K43Xo4CCyBkqm3Pk8t6qbq9YYBxIBfhxGisBQqnDlPk9+/5e6PIfWVkBmRb
         VkHfvNtIBegAL4ZfftYkVem7FB6LY1USTsh56XSXQVei3224X1aKUKG66MyO5fnTk6/Y
         OoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276135; x=1788880935;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WB3gaqcty5uU3bUEOpuRwBi4dDMCMvK/Ic/DzXm2h4Y=;
        b=cYRcFOOCTItDfcJcaFtILyiKuDIBZ6vzCXTENtR/1pZv5HwVA3YCrFXb+Issg0gNCW
         cWRAB8LwljK9nFovCu3C6gI2c2SYe7NhTJL6/pRakCYK0jk38Fpeavbewe48Y5aZ1R9g
         dBGVm75FG9+wgPN1gDcD4AShWx+n72526jhGKiMSKqWjZKQnT95+20Tn/i3HcFknqbwG
         mslAIEL/9Kp+LlJnb5KN/1evM88q202cJMi1nqiPiQW8r+RHnv8c5ruWea+Pxvz/+3o2
         Y/NF/LJisTgYLy6LMKFwjkIGTdxWiij1Ng7yAMUPOd9e/gxZXezfg3mBp2fBSV4gSNsE
         BK/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrdSbjcoMf7cW1LIjAuJmYCGKKOMlkOQPC9X8vVJ+DH4FyYfNB8efW3kr/PqA0u3l6WYYk6ZbcE2Ac=@lists.linux.dev
X-Gm-Message-State: AFuF++kjldRD0jHB1m/0GobRLAGy0CwRPW7gmUrlumTi6c0zHHqXJhRJ
	WL0e06iey1Jp9VfgHady/Gl3G8om3H8ZSDwE0Tpcb6jj91fe8gIlTZfRjHldvo2nEOnILvh+jB6
	sYcWQUn0rkAScFK04vA==
X-Received: from wmlf1.prod.google.com ([2002:a7b:c8c1:0:b0:493:bd51:5095])
 (user=michalblk job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d1d:b0:499:ad2e:f7bc with SMTP id 5b1f17b1804b1-49b91c3ddbcmr440039425e9.10.1788276135254;
 Tue, 01 Sep 2026 08:22:15 -0700 (PDT)
Date: Tue,  1 Sep 2026 15:22:12 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260901152212.1691696-1-michalblk@google.com>
Subject: [PATCH] sched_ext: Use atomic cpumask_clear_cpu in scx_idle_test_and_clear_cpu()
From: Michal Blaszczyk <michalblk@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Michal Blaszczyk <michalblk@google.com>, Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In scx_idle_test_and_clear_cpu(), the shared idle_smts mask is modified
locklessly by concurrent CPUs. Currently, the code uses
__cpumask_clear_cpu() to clear a CPU from the mask. Because this is
a non-atomic read-modify-write operation, concurrent modifications to
different bits within the same memory word can lead to data races and
lost updates.

Fix this by replacing __cpumask_clear_cpu() with the atomic
cpumask_clear_cpu().

Fixes: 48849271e661 ("sched_ext: idle: Per-node idle cpumasks")
Signed-off-by: Michal Blaszczyk <michalblk@google.com>
---
 kernel/sched/ext/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index d2973fb3af6d..8985b48c83a5 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -104,7 +104,7 @@ static bool scx_idle_test_and_clear_cpu(int cpu)
 		if (cpumask_intersects(smt, idle_smts))
 			cpumask_andnot(idle_smts, idle_smts, smt);
 		else if (cpumask_test_cpu(cpu, idle_smts))
-			__cpumask_clear_cpu(cpu, idle_smts);
+			cpumask_clear_cpu(cpu, idle_smts);
 	}
 
 	return cpumask_test_and_clear_cpu(cpu, idle_cpus);
-- 
2.55.0.897.gb25b4bd76c-goog

