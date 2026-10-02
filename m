Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE331E830
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955930; cv=none; b=HjDK+oOB+m8sBajw2MQqdAIRRzhwnDmpSm4amoe+shuGkyEuod2SDHRp2BIEnoIQmbd5/gVjUwiT/FqU+Pyl9dMPGtrd5Uojm0/I1XcVfFovdyutGP/uyqxfLBIESCUVUj3Rn7cL1GQcCiNLveHo3HqsvDoVhSAYH00cn+b6nw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955930; c=relaxed/simple;
	bh=l/sMIazjd6/XZe5VjWiBFYnMVb+KTN/KyoP8XpNG3fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms3xalh/4L8+ZvzwKtiVWT51TbyfZTDZXt4UM/hVYJNxlS62G/xQEBWuee8ir/vDyBaQY+nNd9/N7wef2dZG2ckI/0stMSutTWhLiI++KhNchOHavNkTpbXYwUMqtDyJBrz1wG+VMANurZgGULVJpTkCfIZoNfH9cvydJa6dkSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NLKgH80J; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLKgH80J"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so182575e9.3
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955920; x=1791560720; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xi089Mm6/ZAPKnWvbv/ns1gYplgqzCAMNfNdfYd/S2Q=;
        b=NLKgH80JbkpLgcX2HjHMYhJ8hBpkdMxbonBJnnlMWgQmLCjtDXwNd7fSNnPV4c/3bv
         L7bDhqAoKxKxMCCTAuRZeC4ymNr8h8pxAHj57RTKsLq+YzyzC7RYxk6Yy++dpdDwtW+6
         hxLVu3dumM74Sxzro+5QbPOYDrG/Ds2D33yVZ7Vect/fTKlX4GfcV38548xXgLYp7Vs9
         w+OMOWVzOSqi9VdAJ/cKrh4UTSfFd/gqowkM2jtGiNO/HhzSn/WOAkTU1PU5sx968RIz
         9BD7qgLukMOASF81r9i6Jx2Fi2XTgg7rsvcG9y5lH+QNfoqgSKUdFQWXXPGvShL0JFnu
         KWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955920; x=1791560720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xi089Mm6/ZAPKnWvbv/ns1gYplgqzCAMNfNdfYd/S2Q=;
        b=qmzI8yv4Q1zE5XTUnflDJVhHoxul+5iA7CPKj1pmWMdyPQZpjcxiSqUWNgLNt6TbIS
         vVdKCs+HNZjOS+ztCz4hsmRQBPT3Zzi1JJZcmP16v/51atIJm8ex6l3TUnTDTj8TfCu9
         ReYhL2gbmY1CXYuX62o+2nBW6qWa8V5kfgTURpBdkdJuM9HpJqybVaQnDgRGT74bg6WH
         6uJ0Fc6TzOt7xyHKiN7JnnsDbXd+lNMPPt3zD6w3uXBjKbsGYLUbIUqTHV+Zzta/+g78
         Vgpwo2wuXM1qZkDNwAXMQe0mh0evn8Er1xKaNZrlfZUAQAg+50JQdJWgM17ygDgfsQcq
         dIbg==
X-Forwarded-Encrypted: i=1; AKwUvBwg3Fq7W1+0sdhfhiaQdJ/C76Ry0EqCN7vfSAoqKfg/Nzaksu9O6rPaREjZ5J5lju23KPzv5U5xDTA=@lists.linux.dev
X-Gm-Message-State: AFuF++lq9eI0IqUPvLqkM23tWE6osi/qhQr504CNY5I+DQNEo939pnD3
	IZmN0M2naAmtC/npWw3pC1q3wOaaoVHg/rXU2qodg0ImQNbWoYj3NEhfdtoPTStHGVo=
X-Gm-Gg: AYBFou38RKJe3GZ95Ikg6vBplE73BqfmGqNPg/axARY9b0DEd6YojLgwNM3d/TxJIfD
	rm6EOdY8awX+30hBMyuKe5quAmJLU/tX0eVQ0R7P4lYN8Hj5IULYNxyADsORypO8DHrpplj25zT
	RjdZQW1j6NLVA9iefPuUOwL80CIlNSBDo+3vcy5MOQUrJv0vr4BEaE1A1sB+Uob7hympwDpL6Rp
	xgcnp8XRKlQVFNs62k4IJwrYLcmFJ37SBFLtzuqjDe59+P6M5BNYCPOWsuY827+qwX2fc8tMqc/
	Wct5ha9cjd8vzjkkZrv7JwLiNcVpeL8Jehl7MJe9EisUlP+kZt2wRMe37jQB+l3N+6mZL5aNLDb
	q1Py0+bx6JgJO/u55JhUXKFCSLqfa/2inw9FmtWBbs1E17NohOqTTN4OtYzchiiidghhSdkOo5S
	6x2mudLWpUF9SLW3CAYGMLChQWGAjrfEU+z13n/imUFz5RPymf2N4nSTtNJ+eVJJjXyFhve5Fqf
	zd4prPej94uOJi0
X-Received: by 2002:a05:600c:8710:b0:49f:ce73:5e96 with SMTP id 5b1f17b1804b1-4a02759555dmr49483355e9.34.1790955920408;
        Fri, 02 Oct 2026 08:45:20 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:19 -0700 (PDT)
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
Subject: [PATCH 12/18 v2] sched/eevdf: Try to push short slice task on a better CPU
Date: Fri,  2 Oct 2026 17:44:09 +0200
Message-ID: <20261002154415.2270586-13-vincent.guittot@linaro.org>
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

When a task is put back in the runnable list, we check if we should try to
push on a better CPU, i.e. when fair is preempted by a higher class or the
task is preempted by another fair task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 38eb80dbd1a4..186f10173eed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9826,11 +9826,34 @@ static bool __check_pushable_fair_task(struct rq *rq, struct task_struct *p)
 	return true;
 }
 
+static bool check_pushable_short_task(struct rq *rq, struct task_struct *p)
+{
+	struct sched_entity *pse = &p->se;
+	struct cfs_rq *cfs_rq = &rq->cfs;
+
+	if (cfs_rq->h_nr_runnable <= 1)
+		return false;
+
+	if (!entity_eligible(cfs_rq, pse))
+		return false;
+
+	if (pse->slice < cfs_rq_max_slice(cfs_rq))
+		return true;
+
+	return false;
+}
+
 static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
 {
 	if (!__check_pushable_fair_task(rq, p))
 		return false;
 
+	if (next && next->sched_class != p->sched_class)
+		return true;
+
+	if (check_pushable_short_task(rq, p))
+		return true;
+
 	return false;
 }
 
-- 
2.53.0

