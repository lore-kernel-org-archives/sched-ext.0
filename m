Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D54EE87C
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955930; cv=none; b=qREMvn6xU5uELz8jtabi29xpDoOIj2s9PlszZiAP6QDRjmy/2n9nA0GBmbYBXeiqrU1iVWRtcrQ7Yg5NMwh9zKFIzBoHqrC8GPLSpLkfAz1LmeaAbvqBKdN4zXKK7lpqDixtt186eQ3fIEZoXuc8a4CN2/hHdy5mFgNVSkUAIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955930; c=relaxed/simple;
	bh=1lvJcxD9+zZwv6HbWjirpJuv17LA3EvKwbPn3OvpJ8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdZCrra9NEzmGx4E5totmirY6sDbYw9Dg1u6J2dchJ4N7pvJN7eewTR6u/gbr4EX5RbeS8QzgBdy7LmKdBNA9dF8EjHarLoc1livEVbQke+zhRFVZPQh6FCx1SkcmD+p0U5TVfbJ2N31UNRZNSMd+cXZI61meGkA2XjYDfa1cgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pTERlZJ2; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pTERlZJ2"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a006bb267eso303475e9.0
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955919; x=1791560719; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ya9RfmxJPM2JLLUcoTWuhNhFBf+WLZtJ0RXJ7Ml9FIQ=;
        b=pTERlZJ2G1rHTduFAlSvr9Kth7gZu+9SvFW6NaPGKr8Hg8npVLSbhlK4zTevhQKNDt
         YYwWqTirKqarqO9cTFkU6zczQ1XD5n9OhY70I56+TAroh94hek8Sx+cM3B+LuyiW68o4
         sU7uxVRFX03ux1JpIBm9rEUMI2eAhEBU322hvlmcN9ACE/spt1b2aq12jf7xT03fEAKe
         ZasPMijndo2wU0cYgKh97vYNNaGEVV0rDhI8RWPeqFwN2np2HE4c5EgcFDK1RwmCNyF2
         xOP26SkwI3p1adgQJQiOUKj3OLrWE0znt47fZErnIr1rgSTUAr6P1D9/O+EohcL30szj
         Fkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955919; x=1791560719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ya9RfmxJPM2JLLUcoTWuhNhFBf+WLZtJ0RXJ7Ml9FIQ=;
        b=e7GmgHHPFHZVw4rLUrtTb/1e6HZszOqThzKDTAHZ0YKycnYnIBcPAd3y9fRAswQP0V
         n5KliliSdW3jKtyRe3FjAl45Nh5uC71HKYSlk74fq485oSf8XOA3Mk+V123F+ygO/3Ws
         iVjlkguh4OR0qxnyuivvpZBh/1Zt9fJPP8HR32xfYigneiEtYBkaPo4CDBI3yCYScF+p
         c7ahfwB1wWyJe1fAnraAY/jw5NlG/zo4PwOvMvx3nk+RDCx0zqF3KQ+O89wK0kF60z2C
         Bysib1Q71mE1irSJU051+naGJp8hxc+hPwgBYCxhgclbTxXsBnFcyJybHhuzHulgtq04
         VtxQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/MU+rTls53kBD4hYpFVtSCj9WD0VLcwS9VqeZLmOuWFOGrjZk3A6L/bja40+9kN2aXeOUIhCz3Zw=@lists.linux.dev
X-Gm-Message-State: AFuF++njgDTKZAIdQa3tIC0kH3XjWcqXzt1bR0Tajh14Cv+mDILHzB48
	DEeWwVeroSxy1gWbZ2HdLt4hMO47zB5lY37QgEXx6izTIcWItvJjuzZfnMUx64D/CAo=
X-Gm-Gg: AYBFou2N41ywOfNAZJfYKGOAkQzHdU2dxtsJ9vbTj3kIRZIHnAuiyiIDcyF8PKkV821
	SJXvky3p3tfQka8e8WAXpFjr+QvP6+1S5GprWfnsxtSfPSIlLBXnGqkvAXtckaT8Ls5AUeUQfQf
	gndvMnOXCSZiAxFP06XUPZJD+tTmQ8pS+Szrd9cT5eJuUx9djBB44ZM1rju7HIesaCTZMyEd8nL
	UDQPtTHWz3ZmoUbgx2xIkyeCdFsGnjpyMSqWEBNsobLwY0WYIxVoGBrG7sa3BrrHcLfAAikzy8V
	iSgfIgv+cU6RXZ/z+MNuT91fEPDmpF2cbFF6poCKfacS5MhmrxpVCt7EHE0FTrcs4si62RH2ZwX
	qFWBYYDhjm0xsM4xRtm+jXdflJ24S6xywTkgV+bRQfcZhDJG4aA5bMSdb75g/t0r5zOE9uJvE8k
	WLloH0bx+H0sX2Zi5isWw4FcTOHxkBIb+Bz9+a7G40ZYEm/fwgzkARBCx7uZUEA57akGwJMxdum
	uKn75zPa9MGXOjl
X-Received: by 2002:a05:600c:c08a:b0:4a0:208e:2393 with SMTP id 5b1f17b1804b1-4a0276d9c16mr48912255e9.24.1790955919350;
        Fri, 02 Oct 2026 08:45:19 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:18 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: qyousef@layalina.io,
	christian.loehle@arm.com,
	pierre.gondois@arm.com,
	sshegde@linux.ibm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 11/18 v2] sched/fair: Support not wakeup case in select_idle_sibling
Date: Fri,  2 Oct 2026 17:44:08 +0200
Message-ID: <20261002154415.2270586-12-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-1-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With push callback mecanism, select_task_rq_fair can be called for a task
that is already enqueued. Task into account this case when choosing idle
CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6ed3e5bb7fd6..38eb80dbd1a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7974,10 +7974,13 @@ static int choose_sched_idle_rq(struct rq *rq, struct task_struct *p)
 	return sched_idle_rq(rq) && !task_has_idle_policy(p);
 }
 
+static int idle_cpu_without(int cpu, struct task_struct *p);
+
 static int choose_idle_cpu(int cpu, struct task_struct *p)
 {
 	return available_idle_cpu(cpu) ||
-	       choose_sched_idle_rq(cpu_rq(cpu), p);
+	       choose_sched_idle_rq(cpu_rq(cpu), p) ||
+	       idle_cpu_without(cpu, p);
 }
 
 static void
-- 
2.53.0

