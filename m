Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978437;
	b=k1UQf2fnffvwueClWlliU+y6sVLAgiwbcg3bPVkTidXSIrULk0B+FzrBL3HwBH9IsD8o
	 uCQ13T7j4W/PrapoS0nFAZygUeY0QBKOE+6VO0Nl2EFWPGXJxcv5HGYGUIk0ikEy4qGbV
	 UgcbaXsovt46lL4FixaZEWk3Pqg+Y4L9RWgnjURsAeUQBkV4YY+IBaN4MwVRCchWsRWNr
	 d8NZTkxWHfZoy0g7JGKMgINt9Ksprj64nQfeX4oFzcqLyroXFf9rRVktwETG2AuLcG6BD
	 qTubjYPTsRJa9XV2PoQ8A0VLx7UKdG/nokv9hfXZ0raQH30AV638eeUjNDCbXQ4OhBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=43QcRTZ2xbLW2eh4U1VgtQuQohzOHYlTBhBh08gkyrE=;
	b=yhv+f4oU6OQYaY9I1qCylJtdCyLo9kMeEblGSHvwY0xJewxjOjg61qEJKWanJ0q9Rvpx
	 k07uf1IWe0Gk0LTNbsD3rZ5407K4YgPLgC6R0vR0bcJ7Ea3FxYPrrtFrnb/N8tsT/EG6e
	 Wuhq6AaTOi6O7rtKOKegl/Cr1C5JOO1PM7kMkB+0RiN7Rvpm3UmFnvJacnCcx4W9a/z9u
	 1I3JG1334KCRcED4NUku60kjou4WPhXaqG7INrAUsIGwqucTXffhs68bOENmy+TZzbRc7
	 IdaH94+fsKz6LKz1hY1LSPsx1xkr5b508NCJfzURWNKK+88M03MN6WY9gqJqkAcjjoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JIohktWY;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FACD606A339
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FACD606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JIohktWY
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-49376eb635fso239844f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978416; x=1794583216; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43QcRTZ2xbLW2eh4U1VgtQuQohzOHYlTBhBh08gkyrE=;
        b=JIohktWYXDOSol+IDd85t2QV5kkc65gGfAbZ3cq9yOmDYNC2QcO3CkgET2W2ipqcJn
         YL5IQ0+/HYiCewugaimuFsSRel3dffeNBH/eF0kUPfbJFrTx0N0Zum9piCwINR3T4YD8
         Gx92LUhOxI59iS0QjJEP+/fBlf9PZTtyQaAHOFJgG5ixfDDytvYI90cllV1Zp6l1bnj3
         OBFWcKgtCNw29jOIo3WghhQKMka7S5RE4Pc+gbBXxTV+U0wLNmCd38pFSffHx7a5zuig
         0L5/HIw4WpSDL/7xPC4nOF9AtaVvcbzs/5j2+hjdh/P9GpsB+jFsmNAt1xSptjSAGdGm
         ROnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978416; x=1794583216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=43QcRTZ2xbLW2eh4U1VgtQuQohzOHYlTBhBh08gkyrE=;
        b=hb1bAuJ9gQnUcIW6vh3wuSfCMG+l8L2mqzqelKo9b1zV6js5BN0JDc5gutEFFzjZgw
         s2dJppDJsaVt5R4Ivp8LD5MVK2S/UsMO+BAOpuHeNEqurglpWaR9y0nnkv/tddUaMRPz
         r6XXk2az1Kh6s5vZE4k008ncpkGNYRlOblt3gILZZMp5j2YsJwniW/BiEpTaeqSwVDhD
         JLEa75Cscyqc76DS++Eb9H7D2Zr15ICI3hqIQO6hU7gWVwPnrK10LVC6Fxb7m9E4VMCc
         VCzmSj6bo3Re+PglsXIexT7hxbH5ahSieMtC4pq2pm/Y42Nj6BZWj+e+8Mq/HOCZLujH
         61iA==
X-Forwarded-Encrypted: i=1; AL+hErEnNTe+1ZF+gW+aYk6IP2mRFwPJlJ+vjk7UZUnATUtNUCvVGnlo1Zgnf3BxLpQwan/lvtHXI9jX8nE=@lists.linux.dev
X-Gm-Message-State: APuU4Z/pNyQ7PJcNxE0sZ39QA6h7LWGYHblexJcxuxv2PDxtCALM1vLm
	s+3opx5GwoOSEhSZxZvZ5utgqqCXP4EeStcTWSdRjuDyHSG0OqoTGZQkOtp37kslZP0=
X-Gm-Gg: AYBFou3lc5WjBBm8GbXRW85QkeL4XJCLbSqrBaXE2wNYxPYHfEHszUBz+QCKqNo++rB
	8yFE0MnHmwo1KnVLgqGg4Q6/F/N35iH7iNC2SrHKROyW7QAslIH+Ux7V7Y4zSCGAsrAOyZ1svJ2
	GpOvgdUccYTYOxCwQlrebSB3dPKdXW4d4aonyOf5rTbmwATKnsxW7sJnZRFtZu7egEOHpEGrCnm
	4Q9bNU9+VXCoieKJuWLNpSGSYVca8EVuyGk26bVy7SGQ0rLNMwdE9OCJrt1Lz7zJNJF9/IhE/WM
	6uX3InNc+egfY4D82sAH02is3S2EDlckejaMRbix3TjGYpp36XeLQbMOalpNis/25EYLKKDdBp4
	HS8mjXLVISJArVHj1ZG/5g5O5ulXEVbLxQCyrUd6LJIydbvBA/wyH3B+KozLvDVDDVQ7flRSwCC
	eOY66s/05CcjZPre0S+ot6WlcO3rGAjsAVqrnqJlJziH/ZDZo7XnCd2H164TynRFtxbHt/il3+B
	t+XH0nwvj91ZMhyiR+EZkM2M6YvuS5EBwtzULFDBRl52Byo1nRb+jQ6Axbb0LY9gk/sU4lDdQnj
	PZe/nRxSdkPUYiwzXP4Ccfb1hX18iz4c1na91fIkMSazE4I=
X-Received: by 2002:a05:6000:460c:b0:48e:c84:5be6 with SMTP id ffacd0b85a97d-49275fe4e54mr5481109f8f.14.1793978416458;
        Fri, 06 Nov 2026 07:20:16 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:14 -0800 (PST)
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
Subject: [PATCH 14/20 v3] sched/eevdf: Push short slice task that are not picked
Date: Fri,  6 Nov 2026 16:19:41 +0100
Message-ID: <20261106151947.3991524-15-vincent.guittot@linaro.org>
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

Even when set as next buddy, a number of event can prevent short slice
task to be picked. Add the task in the pushable list in case it is not
picked so it get a chance to be pushed on a better CPU.

This can typically happen when several short slice tasks are pushed on the
same CPU at wake up.

If the task is picked, it will be removed from the pushable list before we
queue the callback otherwise we will look for a better CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3923587b66e0..894bee51b99a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10273,6 +10273,12 @@ static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev,
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
@@ -10723,8 +10729,10 @@ static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_f
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

