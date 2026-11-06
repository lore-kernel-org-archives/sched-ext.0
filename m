Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978398;
	b=j3+T3Jo+t+n27uV+OHpnGzjmUil0EO5T5zBobOy0hzJJh7a3A6ayG7SK+0Wa+Oll9vGh
	 uFmlt60weKF1ONygVlOS0v0NLIr5Y8zijhFVhUP6LfGbPfU4cKdFFmDa1AC6cE12j0u6v
	 BJhuHnfNYfvG1xvlH3xrB1Ec3hKIwBKHT4wJ6+Ii1SWRuRW9zIJF/aRR+xgfEZ5vCf6o1
	 OVAe7w9Q127VIWCovUAQ9ps/WRWvdK4c58hX3ot1nPv6+mFDav6BK0mMyn+e0djJPb/R1
	 CgGqeo8rFI0BLlvcHzpWiYsMMIZR9TWCdjVzV4y3seiHYtQift4pOIYS60EEl0ri8aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lQD/JukA7YFLaFe55TCX0scvCEQxeNBxiWugJcrZ3hk=;
	b=qQK/PB+F1qdmuClUp+1da8R8zYyL62BkaGY72dIeyjxjDLKOkqwYH1IYFe983qA4nY4A
	 gmn/g911iw9d///A4WzF/Yohzdt8VdngsbX1UeRy28b0D1YmG+x9M574jGX8k/0vrBsb6
	 liF8TiNcgngtGRL+JYylU4tZo1MMhSlE+2kVq7Eqto5ckvfo7gQ+9BifjxaLrn6h2cHht
	 r7nf1CB6QRkQ0WIcpRWQlTJ3zvcBjWmzX9XY6twuZja+h8Zx/7SFtA4GENnAAt+0DixJv
	 3YmHfAv3bz20+kNfudmnjHVh0MszlpPGQvlYVNH0X7GBCnwNmSBOvZCfKdB6F+6+dGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pqcn0rFV;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A660606A330
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A660606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pqcn0rFV
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a214af2076so5318555e9.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978396; x=1794583196; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQD/JukA7YFLaFe55TCX0scvCEQxeNBxiWugJcrZ3hk=;
        b=pqcn0rFVq/weeJ5pKMVmv+/ZilK+OSrs7PeUKDTc8+gAi3+p5S1WYPQtbD8WusIJbx
         uAy77nfbmoL+VYLAHsxkgHrXD12UbnHhKWPAtUDKlt1USobd0/gw8EPtgosMZONVijBB
         4Iy6Q3iXmq/YthobVuCRnMwvG9QwzttwjI+9zxP7bvdjeB1a0QXiizs8d3vRntFmollM
         uAd1iB+088OCkPj5wh8ng+XWLTtMIexuvh6UX27ieGQ/3l8TAYb2+cY/F/1pvQEgJDOw
         YiO9F+0FiSGbce4mQKAUyEt4VooRXdZUIYSyVGslYtgYVljmoL487XvgqJHEGEzoGRig
         rV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978396; x=1794583196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQD/JukA7YFLaFe55TCX0scvCEQxeNBxiWugJcrZ3hk=;
        b=F0IccMZZxq3g1zK4w5LjaXBLU/7nCEB5LRYaThG3iAWsDSEUdJi7OtjmK1jeR5RJPH
         mUxx1fxGKSeZBpkUAdgBPo96z1OX+rByFtdAzzAgxm8Hm3UWJCFmopRB6YrnnZvGWNZy
         +1ZZlv771vMspe65HF9tjtDlcsHUS6YeKreK4tO/nEavyJ/HfUQcFblsPiJKQIYlo8vX
         A9gGENAfzMinShw4AxWHjPij2U/lCNjAQ6Qx2hmmU5PyPy37VdUlkZnm6+OCjWCnM+xz
         xdWqiAnMTPvCydBi5n5m+LiwaeeYKXIyKQCqUAUi8pgXgsk1TU50QvdG9uRxlfp9urWB
         WS7g==
X-Forwarded-Encrypted: i=1; AKwUvBzuJMyETYcrqdCl5VughOqyS1HGZ+/r+x8N92OcmiH5ChUvx/YZvBdGNzGTGLddlXUT+bEYdenl+sY=@lists.linux.dev
X-Gm-Message-State: APuU4Z/s5Nl95JPPWXCfAqTCCYLiGTf4BH2y3cRWwGGxtZTa9nSPLMA1
	BU4lzy5q+VD/9Bn/htRo9Y18uTJQTUdF585LH3+zaeW4pemQQ3FJpiMCQaQt9AxxLD0=
X-Gm-Gg: AYBFou2yK1SsQMl40IHFpaFbaKiUyp//0pp3PivVcZI8p8c6uv8YYGgHxYcjUpsyUid
	CKbph4jaiGKqfm0dGI3sgfAuf8Jmf3A25lgdjjG4+YjX175Peoyt2HlSXRx6MgrFdACmcv0XlTK
	VB5Cl1Tny6T6T1x3pz4V+nFHtpvJvFujKiNQ310WKKt0FDxvbBUq7DM6kZKMRZMlSKXVJBDMy68
	HExsvh9UkwpuaKwNmdKgfP9Chg9po5OgXRN0JdToYOwUXPjHVSiiJ16mm3GqR+FYFIS5S2mDG1r
	2vH2e8pU6qWRuKMriyXRwmdhcUnggpSa3KmizytpsfXDnWPTqq6zgLy53UZc0pOkTfRJlV3hQj4
	28KgCv6Yco5C/sEx1aZY+LtHQPLUVKPKDy5WvieqKCqMfsjfUOSss4zvwM7mmZyDn8/ViKYSqPR
	ZtwtmsGhrl+E6JINIXbgSZpyzWs+95rgMUSHaCD88/UwXzbqqIRtmF/Eu555ni6RjOlPJuzFhl1
	htBsoA3fGmrW5Uy0eeqYgNWrbE8H/BdHV753JihgOk8T+1eBtbomDr31Zm9L9lDCAcHSyLD3rVf
	/hnvp/RsNuegiCz7cZ51JAKTcs0f2k39rS3KGbuui9+LlkA=
X-Received: by 2002:a05:600c:6384:b0:4a2:167a:c939 with SMTP id 5b1f17b1804b1-4b6de9739f5mr48102355e9.21.1793978395940;
        Fri, 06 Nov 2026 07:19:55 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:19:55 -0800 (PST)
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
Subject: [PATCH 03/20 v3] sched/eevdf: Reset lag at wakeup when migrating and prev has been idle
Date: Fri,  6 Nov 2026 16:19:30 +0100
Message-ID: <20261106151947.3991524-4-vincent.guittot@linaro.org>
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

When prev CPU entered idle while a task was sleeping, we assume that the
latter received enough running time and the lag can be cleared similarly to
what happens for a negative lag.
While migrating the waking task to a new cpu, Check if prev CPU entered
idle in the meantime.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 79f53811274e..945de0215abb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -932,6 +932,27 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
 static unsigned long task_h_load(struct task_struct *p);
 
+static __always_inline
+void entity_clear_lag(struct task_struct *p)
+{
+	struct sched_entity *se;
+	struct cfs_rq *cfs_rq;
+
+	if (READ_ONCE(p->__state) != TASK_WAKING)
+		return;
+
+	se = &p->se;
+	/* Negative lag implies delayed dequeue */
+	if (se->vlag <= 0)
+		return;
+
+	cfs_rq = &task_rq(p)->cfs;
+
+	/* CPU has been idle in between so the lag has been removed */
+	if (se->vlag_seq != READ_ONCE(cfs_rq->idle_seq))
+		se->vlag = 0;
+}
+
 static __always_inline
 void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
 {
@@ -10049,6 +10070,12 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	struct sched_entity *se = &p->se;
 
 	if (!task_on_rq_migrating(p)) {
+		/*
+		 * Clear the positive lag of a waking task before migrating to
+		 * the new cpu.
+		 */
+		entity_clear_lag(p);
+
 		remove_entity_load_avg(se);
 
 		/*
-- 
2.53.0

