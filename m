Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDEA28643A
	for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121937; cv=none; b=N0e7+17Qclqu4j000iK6YcMipqPlt+5/d4Cly5BdES5ntL6gAiQFShihWVXn01CLRKgZP8inpLTR2+mbLXI1K9NqLlbgfZWfEbBO+z8KgRri+mmVaHuWIRo1AaPiK3X8a6ylQe0+Myy3A97uhOi76nEh4b/hxQJkWzruhjzQsDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121937; c=relaxed/simple;
	bh=g+xuNNpmeuXJ/PEeDw0wcga3QA4cOcyYh6zKDcERByo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kD6YwX150GzYIWV4Aoz2vAXaqAyEMWWWV/alQYpyxO+JWuLYl/gg8TnMDmT25qC4HZPcWjAmhjp+Jgsp1qjw3F4/KJ0hCRhx/JMcx3m+5iK4/vJgsc+CDX0LzJV310ULEEoOQpdKEuPi93goJn4fhYqYAswG9Q7/2Li6WqZsFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAWrYqAL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAWrYqAL"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82985f42664so1989300b3a.0
        for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774121936; x=1774726736; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1f4+EJu9B3fRQLa14bMdkg9jwqnbe4vxaY7bPQ92Ejs=;
        b=kAWrYqALhxzqTzDNen9x3CQ73GlOrC7AaFSmW0cKlq5UkaQVxU3O4nqlnm9vGRVjER
         wBMm1GyEjF9rujxVdN95MWPZxtp9+MfZ1UnOZb2dcxsSqIGa15HZ1aQNs0GM5eVd27h+
         55Bldo1gDqDB9jwc4uUQ4EN2brUVmlCqK/ONBPn2kpd+OqqVZI45WuxrK/XJe2Me+Nzh
         3GCyCfRXcpxtOFYYUBET2AyaLiIIy02MHBrJlfibv/YRGnKKfjl1vsAFpsF3jAERw5/C
         4WGP+6f0tW85Mt6MSH7yn6O+EVqCH7pc6h+95uk+/svHo6q6eXZdLcqFyG6y9O2EFLEA
         Qhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774121936; x=1774726736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1f4+EJu9B3fRQLa14bMdkg9jwqnbe4vxaY7bPQ92Ejs=;
        b=S3Shx9X02WiyT+x5bGSC+rC0SZwgaLc1xCuXJNKzwE+LKPkbD5HaGDi6921/Cpqn1h
         aq6nArU6l1tXZaXyghN+H0m2NLBJ5F5tdVUwZDQjIKsn82LGaG3HF4yyc5hmtnqdNNVR
         RCL21I5BZEN8CXJR7Pga9xOjD4w6pKJYqhQbL0EbH8bZYcva38gKsfQB9UMD1Db38JRg
         KhZ51rMgkF+FYRPyVea+KJJFsELHZs9klYT01vfUr4UerfOfzuMx3ZCBYNsY0gn3HukE
         Eh6Wi8I1RG/MlRwZvTNfdD13tG3gA3TjCy8zfRaPSvkhC6fZmU8OejE/0W/V4cVV3F3i
         1hJw==
X-Forwarded-Encrypted: i=1; AJvYcCVP2Ts4qpGgDcodK0OPs+YALcVGjmkpEMgq3rhom7hlpai2iPHVVVcYIMrGUbIDzYHwl3mCKb/6DV8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwigYpKhRLDmE92EbrmKVAoJ1ld/vh6tD1NVb+0LlcC21pqpeNg
	KzKYHISbDoFfLUt2hQ2UvWV0eAI+FsULzteU518RP7vl00n+lfgY8UiJ
X-Gm-Gg: ATEYQzzQj2LI78PDrBSBX//3oNI2A91dgtQzQeMVtK4MipFspTd0N+uxwBD8tNFJWne
	2R6u8qC5Za9M7WHoR4pbZeyI1Rmtqs483zR2VIUpSSNzYLF7lZR5paZYSj3bQghbwDKg9BOpIis
	1HTvnrpoBpGw1tm3wAmi+Z5MmfFeTymbYSBBpGeJxVMT96uJ3d31y3eiIZZmCUwsDYSdgWEP2Rs
	bVtVDOvz/DaT5HfOG4uGt3WzBMDmIURViitcHQCAKmZ0bXFQP0f38z3/8ulyXzSSVX6UEG5nRAZ
	Ry1NPZzMjKPLpgn3lIzk28L5tPWbEc2+RDNAByUztRBvQ3geGusjyS+A6PnRFNiDMiG0nrFxn4O
	pF/SCGH1rhE0w+LguUZsLcJWu2n0wR7soB1bdsla13UFQM0mTYBUjc/gZGR4/RLi0kvMbPm2jFp
	MJrwSJDaTH+gqAiW2iY5rmnSpUJEx7kr0eYHTF4ryGqszZ/Fr6YScn
X-Received: by 2002:a05:6a00:38c4:b0:82c:2445:bd48 with SMTP id d2e1a72fcca58-82c2445c9f8mr2459665b3a.1.1774121935599;
        Sat, 21 Mar 2026 12:38:55 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:e49f:fa98:a4ba:8111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b04222f42sm6220375b3a.61.2026.03.21.12.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 12:38:55 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: yphbchou0911@gmail.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	chia7712@gmail.com,
	jserv@ccns.ncku.edu.tw,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	stable@vger.kernel.org
Subject: [PATCH v2] sched_ext: Fix inconsistent NUMA node lookup in scx_select_cpu_dfl()
Date: Sun, 22 Mar 2026 03:38:41 +0800
Message-ID: <20260321193841.905994-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260321105503.869337-1-yphbchou0911@gmail.com>
References: <20260321105503.869337-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the WAKE_SYNC path of scx_select_cpu_dfl(), waker_node was computed
with cpu_to_node(), while node (for prev_cpu) was computed with
scx_cpu_node_if_enabled(). When scx_builtin_idle_per_node is disabled,
idle_cpumask(waker_node) is called with a real node ID even though
per-node idle tracking is disabled, resulting in undefined behavior.

Fix by using scx_cpu_node_if_enabled() for waker_node as well, ensuring
both variables are computed consistently.

Fixes: 48849271e6611 ("sched_ext: idle: Per-node idle cpumasks")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
- Update commit message to drop the incorrect short-circuiting claim
  (Andrea Righi)
- Link to v1:
  https://lore.kernel.org/all/20260321105503.869337-1-yphbchou0911@gmail.com/

 kernel/sched/ext_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index c7e405262697..8436c7df0a56 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -543,7 +543,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		waker_node = cpu_to_node(cpu);
+		waker_node = scx_cpu_node_if_enabled(cpu);
 		if (!(current->flags & PF_EXITING) &&
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
-- 
2.48.1

