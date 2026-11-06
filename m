Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978412;
	b=kq1U892oM70ONNGQrdoz+L9jvC8GDuR7ZA5g+SV12nUnLb41QqJYI2WwP3d5dbw21bx/
	 bp6VBr23Eu4v8GXD01hMUT+Wb8hq4r4KnLPNpt2ez2HDi7UVXUMaJlsvp6s78UlveZao/
	 rk8RKj/w3dEMWHcx37Jn13ESASSET6wZ95SeENfJTZQf+xvrBu3UdrnaU4Fi9AVzVb/mx
	 TKxeV69Nfply18z9LTHpQeWfao0d7W3biXpHPos8ZGOkK4NKicowl88JjJW8gHg2E9VsQ
	 bqd2ied5k49SjMYhuF00YdVP/cOxwz/Kw0qvpy6z02LwiKYB6cvpJKmEXIFLmz+WBSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gkJwtkA4b9iHfeNLX2Rr658084iNaApVrGzPIHFhBr8=;
	b=4M6/u8/GTS1pI4x+HTaVF+2pwGu20maVhIr/EMvTWTbk7fOQBJ3TXoCtXK0DpuCP0sI0
	 RTxQzZdc+7zqfzINinlIDEFd8CDiArR4uD1SFx9fxzgxqcoWU9RcetijC5O/NU8lJroLH
	 4lukthU9aQWwVcElJzoiwqYP24xap5ZNG+DYy+LVJX0rirJOfe5XN/5WNdN/PqwO9lwdP
	 fOOBmgfrWgFa7o+bAEzAi3rF1ihviM8B4/kxCW5sSPnjfAGmrAoClNLc3RGaLSaGq3TFm
	 lwT4sLw0Ry+7uuIlBGwHWn4W7RXLAtKRdQ3y70cawqumOaZX3sDd9/comVFN82PbtDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mx1z4rEc;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D4606EEBD
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C8D4606EEBD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mx1z4rEc
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so421122f8f.3
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978411; x=1794583211; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gkJwtkA4b9iHfeNLX2Rr658084iNaApVrGzPIHFhBr8=;
        b=mx1z4rEcSJnqhx3hA+1TAYUB92Am7l6xNmEeWwAPXP5Dn26JfW+lLT46E1S9WSrL55
         RD9GB6QvgYwQ+gmmL5b+es+PKPbtunEPJ2Ih5//0Fh9CA4/BCj7hTmaqojhIuah1rTJa
         L8xAedju5SqB/T/dj1aI67y17dkA/kKqd5kUSSw3ORd7bdsDT24U7mcjF2h99QQyR62l
         ni2lfzvXcF5xygCoVJNRqt3kTd8a5SCSlzvB/l9SjCc60q9RfHeg5lApYO/RShUTkD/t
         JXe/iYuOj2yUNlEkd34DVDuNgI5iu3P/OEO7QL8kuN0628Tt8pnJtJePEspSKVJaCFHM
         xMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978411; x=1794583211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gkJwtkA4b9iHfeNLX2Rr658084iNaApVrGzPIHFhBr8=;
        b=iVNAtanSnPMTUPgdcU6VU9Y3mm54sBp/hCA2ODhHQfEFaWQ+P0NW1xAnU/AZjf59ct
         D6Mf7ySKAtW6/UOtqcGFEQqNToU01cPArj9PPb/54F4XaZ+tEUh2OTLVSMJqpIAXRHIK
         cGLmNdA/Wd+oAHLvDWYBJpb4FsCeD3mExLWPM2EGs49AhjW93vGMB+IRCuL0W6UMh5bJ
         KLoXcmkvc9mChqEPXHu9k4vboW2aDZUHhTXgxcavFKEwQtX0XqdJu1+saqcVVB5Hq/QY
         nw7glh9aRUeVMWs33KXu4T0q4RiyMaNEuM1dw83Q3JSCHJ112+FvJayRX8Q5IMxf8PFT
         xA1A==
X-Forwarded-Encrypted: i=1; AL+hErETE4uh6ueI20OFRxKHq88SzCo4btgvpKTH+pBDlVVBTsg0u0SU5GKH83ZmGjmqNNfmiP3NcsxXt2Q=@lists.linux.dev
X-Gm-Message-State: APuU4Z/BseplJ3eDcAy+xeKybryhCWPgozZ3MsMhhDjB/QXcWB6E2jr5
	xxwK7VblSimTGe0HLfzcav9Yf2sHhB3Q4kT8ln3cXsauiwG9mMZkoFdO4VGwHLRwLYg=
X-Gm-Gg: AYBFou2LpU/K1LEpUqCHWVq9XDFoVxKDhXRt4TQmOIj54oHb+All3gtWDc3D/CdaybM
	aiHr1H5ekLTOgNMzv3PYYdLQomj7kQDa3vUZ4UAnKn71MfEQVhNd1fYPzVZ3/vZWyDTLVdwWfAl
	uxCdG6aSSPIhlAj7KTMigojcqTZY/LnNGoYxJ+E+9kRZ8PM0SkBeATgQlwIghpMesYHX0ujAvz+
	5gvfD4CkhVdE+1TNPbtczZ4wdQv4GPBSY/2+gURQr57auHGgXvS1y8wpqu/r9PeBzAkUAHfFmoq
	zLxK8H742/clnc8dJe0Zv1D8irePqxoggSKedV4aLEnDpoREh1LnYLbc7pw6cyxs28iCyZ19V0f
	1VljQZAmDZz1eZcB16qdSzuTG7qBS8UJCMbdHLc0S4feLT5h2a1GfebFMIf1WYeyBReuwhckwGP
	RoIev2LCe38Gtg9KMTLWdEcCjCmjT/3Td+6yBpSp1N+DZIWCruxpmhNjCNNColQO4WViUNKrJdq
	Nrv/u2+barxoadFfBbg18xtXy5KZ+k0i5ZfY6He5Ic0R2MKTCbEUs82Vpu2UWed/h9mlELCTIn/
	3i3jXgzhNXQ2+Ay61qNxc8xxj1UxaDbF50trbochHS+kYM4=
X-Received: by 2002:a5d:5f48:0:b0:492:f6b7:f488 with SMTP id ffacd0b85a97d-492f6b7f755mr4873277f8f.7.1793978410645;
        Fri, 06 Nov 2026 07:20:10 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:10 -0800 (PST)
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
Subject: [PATCH 11/20 v3] sched/fair: Add force push task mechanism for fair
Date: Fri,  6 Nov 2026 16:19:38 +0100
Message-ID: <20261106151947.3991524-12-vincent.guittot@linaro.org>
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

When the task is alone on the CPU, it's never put back in the enqueued
list; In this special case, we use the tick to run the check used to push
runnable task on a better CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 75 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3bcb663ebcde..f2a0d2c2bb63 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10233,6 +10233,75 @@ static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev,
 		__fair_add_pushable_task(rq, prev);
 }
 
+static int active_load_balance_cpu_stop(void *data);
+
+/*
+ * See if the alone task running on the CPU should migrate on a better than
+ * the local one.
+ */
+static inline bool tick_push_task(struct task_struct *p, struct rq *rq, struct rq_flags *rf)
+	__releases(__rq_lockp(rq))
+	__acquires(__rq_lockp(rq))
+{
+	int new_cpu, cpu = cpu_of(rq);
+
+	if (!sched_push_task_enabled())
+		return false;
+
+	if (!rf)
+		return false;
+
+	if (WARN_ON(!p))
+		return false;
+
+	if (WARN_ON(!task_current_donor(rq, p)))
+		return false;
+
+	if (is_migration_disabled(p))
+		return false;
+
+	/* If there are several task, wait for being put back */
+	if (rq->nr_running > 1)
+		return false;
+
+	if (!fair_check_pushable_task(rq, p, NULL))
+		return false;
+
+	if (!raw_spin_trylock(&p->pi_lock))
+		return false;
+
+	new_cpu = select_task_rq_fair(p, cpu, 0);
+
+	raw_spin_unlock(&p->pi_lock);
+
+	if (new_cpu == cpu)
+		return false;
+
+	/*
+	 * ->active_balance synchronizes accesses to
+	 * ->active_balance_work.  Once set, it's cleared
+	 * only after active load balance is finished.
+	 */
+	if (!rq->active_balance) {
+		rq->active_balance = 1;
+		rq->push_cpu = new_cpu;
+	} else {
+		return false;
+	}
+
+	preempt_disable();
+	rq_unpin_lock(rq, rf);
+	raw_spin_rq_unlock(rq);
+	stop_one_cpu_nowait(cpu,
+			    active_load_balance_cpu_stop, rq,
+			    &rq->active_balance_work);
+	preempt_enable();
+	raw_spin_rq_lock(rq);
+	rq_repin_lock(rq, rf);
+
+	return true;
+}
+
 /*
  * select_task_rq_fair: Select a target runqueue for the task.
  * There are 2 ways to select the target runqueue:
@@ -15713,8 +15782,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, struct rq_fl
 
 	task_tick_cache(rq, curr);
 
-	update_misfit_status(curr, rq);
-	check_update_overutilized_status(task_rq(curr));
+	if (!tick_push_task(curr, rq, rf)) {
+		update_misfit_status(curr, rq);
+		check_update_overutilized_status(task_rq(curr));
+	}
 
 	task_tick_core(rq, curr);
 }
-- 
2.53.0

