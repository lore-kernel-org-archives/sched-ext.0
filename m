Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322134BE42C
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955930; cv=none; b=U00j8pUeOYviQctMDRQiI9RN8FhRAQRGUNsTN12x3FCogRxnPEV6aSzlwQtnZn9mXX97UEfZtoX4a5k7lr0vcP5wMBM6E/0P+Gmyy1D1yrpa+nAruIq49QU/mZ+x6VMVm9Mk3f1CwE/jwrxQaAxzgnr0IF0OjHjqahpsRC75Am0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955930; c=relaxed/simple;
	bh=CeTHB4ypLnb5H3d23FrgyQcrpY2y8roNeeEMV+cxjyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/mJj6IYDZsi1D+/Be8L/15gA83AEMcL/ZVp5WQQwEMvyH+gpVKD/DUafol3FV8N+ZGpFlHGFAIC4Mfs2Heppc9CL4pg7PyH7D+YKydBAm3EvkpItHYkOyZsGuwWz1sP2YwtPTw6PdtXpcVRZUAlgYQQseid64oiGhdD/0nn7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zct4z6XA; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zct4z6XA"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3920so262255e9.1
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955922; x=1791560722; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZjs7e//iaMUq0DbBBAkyBGkWfGjYDHq+81y/lPHXV0=;
        b=Zct4z6XAhM9AVyR9AFwOieECxBLULJdH7wNQMSjpFPCH1N99je+TwocbhKo9po+8rm
         vcEMlxZGuNcVTblYoNcRNfl8Xdx5CcAK4SNMvQSlgQUucu7PWcoWlSa5gf96DM70IXKK
         pwCOR9ZGOdtu1yoJSraLR9u+Uzzw7zI6Wxu8TWicBIk1e+9N65pS24HUAPfGXTok+ING
         hQJWwG5S8kW6lGWLIfAwxfUCeNzrK17dnn3PLQtCc0sV93ITd/rIdaOk9T6l75rba3XQ
         ej6yzOr6ydIWTIeVZ2TqeXNf+CQxZDuIpoYOXFNt98K+4O2K/P+/HA/xWbnwXgqMY89E
         +/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955922; x=1791560722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZjs7e//iaMUq0DbBBAkyBGkWfGjYDHq+81y/lPHXV0=;
        b=jv3xqO+tE9XxClGECUb7gqVuFMb2B9tMjB7dtC/pNUziS4z1SG/8OTqOORE/VfZ75H
         kMHo56RsJhkMGVKeXtFCU+YAImE6Ib8iyDchTGIk7TUVjZwAytrPQQPCe+k4Z/0RT+Y5
         e0QuTjapGtIt4hnBl4i4iZH4qMKf0E99IS/yaadqEgRr0AqBAaU6X6FciPfkdChy5ZXz
         Efil7S+UIFPk43s74x2IOrb9HMRxtozPtIjsBahSvnmcGdSz3UG50/ToqKMC3iDxp0mP
         SW8zoCPPAmgIHydGtActbdMvJuVUxoroEBGP7aiOWk+O5t1Ax5OWgJkssdVG25gFTLW4
         sgLA==
X-Forwarded-Encrypted: i=1; AKwUvByY0ZyAqmco2fV+YMjq5BLdW08TEn3rFH90m3IxwmOIXia6iFGb2xCLaye0a4fv2QX0PKtmhDTpx8k=@lists.linux.dev
X-Gm-Message-State: AFuF++lgBZvWZmhg06xygaVps8zeFgdxGRT15/ARVKCb6YTV26LZdrh8
	REYD2o3zPzyhsyco30uiskSNH9LR7T46I4CzuoFLKAN1S4/voJsDTj2g25fofxp5hv8=
X-Gm-Gg: AYBFou383HFZaErIWCoprT12MHJ5Sbp98hqCwj/tEly1HtgmK9tzK2EJs3i5OU4RoZX
	80/xueg0vwREdFGseVkP91EzPWHC++KzUGSUYYctmR6BXPJMYg5K1X1DML2MfP7HmHbBwexJUr/
	ci0bl+AaVUeaNI/ojROoCF1ijhQehp5VLuNjJbdtIqwHVZ9FGxxZclSMUWIlGqiE5fD2L3aUgMH
	bJ63dQndZgZAxvJ00lrZOtp7MbTnmuoYzpOjFXJXQDFTFiQlheHd+4WF08k4EDBCRi+vWm8XiPy
	R3XBl4xxysXYHoFnLTSwgkSmub4TzmynWBK1XNK2MCE1PR1+vljkFuZ6nmDhVzQIc+rhoc7AMpp
	qJ98n5oR8OIudt4v9/Liv2cnGW5B8VeK+yNgUhxJgy+AzcXPtKVLLAtQ09eymPYLnfA1uXR5TXG
	M9Apg9z72d8ji32r8wqcKxmZWcZ/2amQWOcQU/n7tMYEmO3me70fvy9TeQMkOKTSWptagcRtpRG
	cYjaaqoqx6N0O1k
X-Received: by 2002:a05:600c:230b:b0:4a0:2533:c8b7 with SMTP id 5b1f17b1804b1-4a0276c6176mr42183355e9.35.1790955921951;
        Fri, 02 Oct 2026 08:45:21 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:20 -0700 (PDT)
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
Subject: [PATCH 13/18 v2] sched/eevdf: Push short slice task that are not picked
Date: Fri,  2 Oct 2026 17:44:10 +0200
Message-ID: <20261002154415.2270586-14-vincent.guittot@linaro.org>
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

Even when set as next buddy, a number of event can prevent short slice
task to not be picked. Add the task in the pushable list in case it is not
picked so it get a chance to be pushed on a better CPU.

This can typically happen when several short slice tasks are pushed on the
same CPU at wake up.

If the task is picked, it will be removed from the pushable list before we
queue the callback.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 186f10173eed..cccdc40b8a24 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9981,6 +9981,12 @@ static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev, stru
 		__fair_add_pushable_task(rq, prev);
 }
 
+static void fair_add_pushable_short(struct rq *rq, struct task_struct *p)
+{
+	if (sched_push_task_enabled() && __check_pushable_fair_task(rq, p))
+		__fair_add_pushable_task(rq, p);
+}
+
 static int active_load_balance_cpu_stop(void *data);
 
 /*
@@ -10419,8 +10425,10 @@ static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_f
 preempt:
 	cancel_protect_slice(se);
 
-	if (preempt_action == PREEMPT_WAKEUP_SHORT)
+	if (preempt_action == PREEMPT_WAKEUP_SHORT) {
 		set_short_buddy(cfs_rq, pse);
+		fair_add_pushable_short(rq, p);
+	}
 
 	resched_curr_lazy(rq);
 }
-- 
2.53.0

