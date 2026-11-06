Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978429;
	b=FCpGqloFEQZgARTXmVWouietBc2QSGSCVqUEzOmLS2VvL+uHCWo+ynoOaHl77HVbUaC9
	 Ljpa5jhGM5LfQy+nhp73gWFGTGHXLLyesF2qZBPDlgWzd7XBF55tJysPdLpxMxqF83g7C
	 Oj2W4eugsHBEzbFpIXNH8WJTuVb0Qgk7inyoHl2y8Nxy1t32fTNelVfnD6ZzZXak/EMJ1
	 bDuj9hkAd8joytvWH2I70egMnFp0Tnc94DztmrDba/AIXPZWoR15HiGBaKZCpKTYkQc2g
	 X/MPDru3MjxSlAal5OQaIY5RyOKl9BlHhlMdNDd0Ob3Y7H2CZ+m9dwhihIxdPnow5+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ST6MD8nmbeHSATr23Q5RjwDAfq9V48NFRR4Gq9s30TE=;
	b=H4HD2Ljy3wT1R171omgiu2rr04yG/pLFG0XgncaIJ27SuUr1R4NbGdZBn8ITMAqpGMyy
	 lXzR4zSYBhOwbkc9ErGOOzGciQIWLSnlPgZIWajqwG5nmwDuZ66HcT44l6X0UtrrvQSly
	 M++7n9o18ObMLl1nwiWRhuOXhdljNqBryAIClGwVip6qmuV/t06jYiAnymSGs22/T7opE
	 IMr+6MwgIHDVdrPgYcB+AaU2F858J+/IRlb/aOSIEGvlGyN4JPT7ixkH38jHR1SnI0xc6
	 Z06OpPxm8GQK/FXVk/LEhD7Zz0fiT7paUvce8Xcn3pxHk4WRQ3sO6yvS9KmxWA+iRQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g3SSXtRo;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB860A261B
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04AB860A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g3SSXtRo
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so6507925e9.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978427; x=1794583227; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ST6MD8nmbeHSATr23Q5RjwDAfq9V48NFRR4Gq9s30TE=;
        b=g3SSXtRo+0J68qGFgndA03VhUHJI4a4OYgCAgAKTp6/ni7jUEoKWTOgNRZOudyKWqo
         PdNe1AvIyB2uEiDhlqOWcMpKypv/e5+RvittSjOugWvT7V8bclE6x40ic65uoF09jDjJ
         C6JDPISwt70NQT2mQde1WuRdpV3YVQF6zFMOpRXm+gOdVU38S0SV+0h/rczSaax6wFS/
         d2EDY3eol4Be7fi+cw8fcDiB36TIHYpinopsL60d1QaWeNOtk6NkUCsvuthYwRMzhq7Y
         VHwheeLdfMuTjm0PS9NTWRnsFP00czBgUcoD1QqOuU+3yJ/4//jirj4ajihUWn//X/D4
         qxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978427; x=1794583227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ST6MD8nmbeHSATr23Q5RjwDAfq9V48NFRR4Gq9s30TE=;
        b=CVQtsh6YaWPi4OZcI7CDZQQhaqMr9DJpSTIH63zw71jTzHP9PTSeNcRfewFjoM8zK4
         c0UWIjWphj/IIbh2KAxVlqtMQlvg/tzTR8tpLSXAAPH5mjB754wCEd4nn6q5dyUgPzKH
         vHUnCpNIdXKI9CVLC0Xf22HU8zi18Lz4r0ZF/7dAkewNW/KISzqvCHNjHWxnKhOuz422
         w/uy4bb9DpEQc/Zpm6/3gKhskCNWgeEwnaLNh8e7dlQpERdZdIuTxFgkS1BMh+Q/hwe1
         JhL3e2ET42Naqjc3czAnVTYZ8DSdD42XPhxgjEi50a4cLyNj2eqXCJQloUJdpWB8aPCi
         UwyA==
X-Forwarded-Encrypted: i=1; AKwUvByboD7q1A3+sSZ3tN4T/YuDpOOw8OxL3dXaOp5T4rfKBZJm7/KARTEHXwTiWsz5Ik88tK70oh64Szc=@lists.linux.dev
X-Gm-Message-State: APuU4Z+qcO/logQKRbJWN2No91gKQtWBkj0LTqvvo1AMMalD/+Pjlhvk
	tDanKLPEYQMEAeznipIKVo4V2XuMI2LkW/pQISSg4m1e3YrUlpNE4m/Y5ITXnhVsDWM=
X-Gm-Gg: AYBFou0kvq89ErwN1c7XHLW3hhRH0QXLkrhR/cCBxaKPULnJKMC6P+ZSI9HiFrJJmSO
	lc7SajQXUy9P9Jg4CQCct+JowFiltonNz2JstLNGgm4ADe7KZvI09sSKjb+CAHgQtH9rB0RXzlG
	z7Vrzhs2Nfuouu8/94M2T0RO8ykm+2jgs5jtF41KJEn6+vcrN+GprJ9JhwLopwhBWBhL/iPCs0y
	gFZ/dcJkRpjqeGN4x7PlNuyjee8lbXdOqIkt3ACCZ3z1BZczIunChT9QmUnJR2Ja5h1lRwD3dK2
	DoecME0dlwjDCTZn02xZGHHxu97rSHcXudHIWl6N5NUKzLIb3KGHHZn7A0/F2E7bbUq58pJwg0H
	dr/zdYKWOEcHxxGqkGVY2Pheb2pvXMnnJDQ9KwWacH3y64gf+DIn0hSAyzPMrFKeiA1jFSDShOy
	Ftm6Zjhy4EXwZ4iktL+27cFFjncifaviLGz/NuoetA9j0Z89wD/K3O3saeLD9VISyJbU8oFnYCT
	ydIU+p4QTLjgk0PrHNk0sCCOlwZ4vdL2CLD8QvywbJF/Xv+6EhoHp2YuGxA4Kf9m+k+i0JZqzdn
	pdMf8dHot2ap4+7ENBPD+pLs2LWOL8x4FBM93ZMvgrJOQlg=
X-Received: by 2002:a05:600c:3111:b0:4b1:2026:6b41 with SMTP id 5b1f17b1804b1-4b6dff87640mr49109825e9.30.1793978427419;
        Fri, 06 Nov 2026 07:20:27 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:25 -0800 (PST)
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
	kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 20/20 v3] sched/fair: Fix tasks stacking on same idle CPU
Date: Fri,  6 Nov 2026 16:19:47 +0100
Message-ID: <20261106151947.3991524-21-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106151947.3991524-1-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tasks wake up simultaneously, they can easily stack on the same idle
CPU but only one will run immediately. For others, a different CPU might
finally be a better choice. Take advantage of the push callback to try to
find another CPU for those tasks which lost the fight and haven't been
picked.

Call also sched_class->wakeup_preempt for the higher class so fair can be
prepared of handling several tasks stacked on the CPU. Other class returns
immadiately.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c |  1 +
 kernel/sched/fair.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a1a3aa45ecf6..ef4cbcca2437 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2311,6 +2311,7 @@ void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_class->wakeup_preempt(rq, p, flags);
 		resched_curr(rq);
 		rq->next_class = p->sched_class;
+		rq->next_class->wakeup_preempt(rq, p, flags);
 	}
 
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da9c4416f1b5..262626455497 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10649,10 +10649,22 @@ static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_f
 	/*
 	 * XXX Getting preempted by higher class, try and find idle CPU?
 	 */
-	if (p->sched_class != &fair_sched_class ||
-	    donor->sched_class != &fair_sched_class)
+	if (p->sched_class != &fair_sched_class)
 		return;
 
+	if (donor->sched_class != &fair_sched_class) {
+		/*
+		 * When rq is idle, several tasks can select this rq at wakeup
+		 * without knowing others did the same. Give another chance to
+		 * select another rq if not picked.
+		 */
+		if (sched_class_above(&fair_sched_class, donor->sched_class) &&
+		    entity_eligible(cfs_rq, pse))
+			fair_add_pushable_short(rq, p);
+
+		return;
+	}
+
 	if (unlikely(se == pse))
 		return;
 
-- 
2.53.0

