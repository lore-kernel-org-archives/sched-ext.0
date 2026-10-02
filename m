Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A24EC64E
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955911; cv=none; b=Wrfff1YRKmLwhKoD9y/yGqVFFzdIupMaBiS/SfX5s2cvUHhF9LzGAXo1gbSu/zts1IWRdC9st1STy8wJjdT5J32pTItWltRDBkw8ILWetnytFjyM6HwwHNNHzulvrIGGZCmmztrEtZQ+iquL0gEGo8dzsHUzwq/VKAxQPRwLgFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955911; c=relaxed/simple;
	bh=Z3OZRU9tUVQEa8ii3OJE37iSt72mrOcOAJir4arnI9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQwSyOzylXNeDYW59YuoBcefcIrD9R9qtcd4bHAx4CaqL4Vlifz6qFFZIGN0Ewip5k1AsO2e59iBsgYLpVkImXJCC2e04Ld4qDHozaITXR/nJRX2qseGGBRqGf2sdPNjSX4KAn0TUoy2VukhPK7JnahRXFs3o/XuCOdzPgx4f8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rEPmyGOG; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEPmyGOG"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a024e16179so161905e9.2
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955907; x=1791560707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+I4t9viO/Urz7W8GjoAm6BBP/QuCZzvUO0dNV1Sy8FM=;
        b=rEPmyGOGvg8uc3/MyUbMlc/A8XH+ozJAUVJ2g9xVkwvALtMBhapihJ6oB/Ikn5pBaH
         Zi3XlZHsEphxyInLC7CttBW98p4BasdtL/jEg0a7TDt8x7rJ+PRvfWxWUfJB1Vp/OW5E
         TgCYSa5mtNmRbYbXLGBnqKpijQCq6wQse1NI3+oylSHRGZoLvjm6JoUL8a09RpXbU8Mk
         xr1cFlc1Tk+3WHaWMPK7rJ7YWmG8ZNFlyggNpZxWDxL64/9K6vT1WZcMy52TKOvzAAsD
         s0T6UMlwisagIZMKm9IX0dox0GEab5q3h4UEnvY6qpSXi9kdA23NcUDweYisj9/GwJ5P
         wbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955907; x=1791560707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+I4t9viO/Urz7W8GjoAm6BBP/QuCZzvUO0dNV1Sy8FM=;
        b=YWEd4TqBrDQE5RhxDZJaUaeKSuaPYD2kJai+OdhACq6GecacE2+thlMZsLsjzbMDA7
         vQ7iJiRNcKPDSMHPbo8LpxpjzOzv7vbH4eEHgTD36/GEWa2k5eu8xJqjcU+v4gPqBkhV
         ITkpA936mSutuH/gVHWiJ7TIq3HR/QZlHnRaR7w+xPdV+fM3H7LvF8NCrC5JdswgpON1
         2Q2662furXnzqvza3RQnb5txR6bHm2MsBmL9Oc+1hKK4XD+b6131ZKeXAWbDAZz8VcrZ
         H0oP0RYcKJYWnF0IyukBQyb03u83BXk8ZaxixGOKhwqT2V7oa6p5yAHDj64q/K+yIN0o
         7Rbg==
X-Forwarded-Encrypted: i=1; AKwUvBwzqJoSv0SmICL65H5tTlTo9c3B1TDs57rSRq4U9Y+MPhgHWPqMmvnL13HOSy0yHoaHIIA1E9J5Wds=@lists.linux.dev
X-Gm-Message-State: AFuF++nazuN8lX/R0uHgzaLvYbwfpKqgeDx5os3rIiRTzvcXnPVGTTiX
	SYW9AICNaWraUVwDDyuiTOJDVIPvps740lB/CpyMa8XpSsnS7//E6qL3tcUCOvz5hoY=
X-Gm-Gg: AYBFou3PscX9LHCasP5kU4EYnz0Io/5o02XhR7ry6Sxb6uppBkaLEyk24+J4cjrgnjA
	hmg5gpj5MHMw+29EGSSXX//X3x+W+VP1awS3Dd+gaFN98yNnD296PI9/b2Aayc+3PYcDokVx0sY
	9ERm6ce3CPdVEhiDcf85HZoJ9CnvUeHIZ9BTM8MuVl9lADTlGE0pU4mWYAN20Vfei3sCEyVBUT9
	hUYSLXdCmCr3J1ozlBkQM3CzRQ8299EqHgV42UmzCxeujRJolsde4GHROphdGtKEDlXEd7mT64t
	3juPr5ay5Ye0SA9eKLrK+opkP7lktFd7BJtG67tzqkaRLg922XXTmw501EKPXt25ciwOXCoUP5f
	yu9zlMkHEGedmf4D7I3h0zW0YtcMnqeupTT/mD9bpjnilb05V8lINN6rjwukKzkGB6aPGFfEref
	ymduZn8SSNIwdnfTQS2Vw/N1wp6sDLYWWbd5FFgcVhqzpaavz1D935ByB5wBF8VgJCjEQxepP4I
	agOeHkDjrASJe5w
X-Received: by 2002:a05:600c:c16e:b0:49f:ffdc:939d with SMTP id 5b1f17b1804b1-4a02755fd8bmr52292735e9.9.1790955907438;
        Fri, 02 Oct 2026 08:45:07 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:06 -0700 (PDT)
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
Subject: [PATCH 04/18 v2] sched/eevdf: Compare min slice during wake_affine
Date: Fri,  2 Oct 2026 17:44:01 +0200
Message-ID: <20261002154415.2270586-5-vincent.guittot@linaro.org>
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

Add a new level in wake affine where we check on which CPU the task
would most probably run 1st between this and prev CPUs.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ad72b8536d6c..eeac0aaba3cd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8422,6 +8422,9 @@ static int wake_wide(struct task_struct *p)
  * wake_affine_idle() - only considers 'now', it check if the waking CPU is
  *			cache-affine and is (or	will be) idle.
  *
+ * wake_affine_slice() - only considers 'now', it check if the waking CPU can
+ *			 be preempted becaus using longerslice.
+ *
  * wake_affine_weight() - considers the weight to reflect the average
  *			  scheduling latency of the CPUs. This seems to work
  *			  for the overloaded case.
@@ -8457,6 +8460,20 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	return nr_cpumask_bits;
 }
 
+static int
+wake_affine_slice(struct task_struct *p, int this_cpu, int prev_cpu)
+{
+	struct sched_entity *se = &p->se;
+
+	if (se->slice < get_rq_min_slice(cpu_rq(prev_cpu)))
+		return prev_cpu;
+
+	if (se->slice < get_rq_min_slice(cpu_rq(this_cpu)))
+		return this_cpu;
+
+	return nr_cpumask_bits;
+}
+
 static int
 wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		   int this_cpu, int prev_cpu, int sync)
@@ -8508,6 +8525,9 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (sched_feat(WA_IDLE))
 		target = wake_affine_idle(this_cpu, prev_cpu, sync);
 
+	if (sched_feat(PREEMPT_SHORT) && target == nr_cpumask_bits)
+		target = wake_affine_slice(p, this_cpu, prev_cpu);
+
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
-- 
2.53.0

