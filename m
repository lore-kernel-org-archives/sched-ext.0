Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978416;
	b=aMGDkQzq1Px1JHYW+ns8QGUsZG2pvkWoJ0GkRU/Jk53z4TNBemK1SfSfdIWJwvzvhtNj
	 1p/rCKfsDXY1hFgE2km067OF8nu9n13kL9FIRq/rimyh9/HVS+a2MvE+T19JX1Rowkk/m
	 NSX4iRQGnsCWGcTLcCE4MPWDNmqF3uRvUDAI4b1kw1Dte+G8RYxZWrgVqa2Cxm2gOkcJe
	 MIQqEv6NfheMf2bD5r9zHcyiU+zgARh8/QLNG8ue4B8+1pA2qeoB94qEM54yMcQIqmeAN
	 pN3Js3jwLPOF1HYdND6EYwu7MmgM6Bbfzut1O0jJsHpozIP+qlbaqv8kooeD2fpFm5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X7cjgrh5Yg6Kt2t9tmwbzYSsxzemzPkOn8ZYOdbmvek=;
	b=3TBdoMgbiPZ0AQU5DZmax3BgCkfB5NNqHCao0cRJ9AFKupSmfXxWNH6OiEUJ5LnHdBxD
	 /eXEJj0zHuwuCSjrbRK/LlLdbvPDgHjXKTQdcI+qe9s7SeWjzkjnmTrjYLv/mPTVD2jWS
	 BHvpnXVGcORUFdVlXAsP2ncPABmtYwMGBUHzGsX5GAs5+mToBMe7+J3XzLNzWafeqAOw+
	 Dq2BnirDDDxoBVqPTEeOOf2BBOVux/fDV2ZUDZWRadNBKLFJwySOqTz6Vqj9bHJY5TEQM
	 O1Cg3XxFGi3yfgKAzFaaUY/W8a0wE59BNyhiPt9SM5oPTLxclaAHawBwajoGghqHHSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hDo0KFRq;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E6606D83D
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 675E6606D83D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hDo0KFRq
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-492f563d1c6so238989f8f.3
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978414; x=1794583214; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7cjgrh5Yg6Kt2t9tmwbzYSsxzemzPkOn8ZYOdbmvek=;
        b=hDo0KFRqXSW2H1MG44jmZg4SqIuFH71irMsLLSXSAvC1ghRSwGQx74eopK6IwXIlj8
         OJ412w/1JbccjExQ7MNmEeA8lnT4m+uGUz1DDrAk0pU3uyVaOameVwyR4ZSPVRuJ08PF
         Rzrk2Y6qbctL2fXkrG6/OM8/qgN5+rxtVuOjiJbnF1YVR3Wll9PlmjdhaYKmOw5IOip7
         IpOLm+JdcqtnhSku9+yvnJf4WbKfBE24rNtRgeSqLZwXD6hcTuS6OtH6N6IHTia4+SYT
         71diwIaz6IYsa16w7rPNWR1rF+x4uwfMyUYmLona8XRvle6/FSa9cgsKL85nTr/7pLPK
         4fCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978414; x=1794583214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7cjgrh5Yg6Kt2t9tmwbzYSsxzemzPkOn8ZYOdbmvek=;
        b=FSt0++vk2lmgMuK8a0/Zxrz/oaX6XCz34/IFyxuWWsdt/R7T+Fc7MPqHBifzACFSNW
         oCJ/KgAC1yGr34ZywFV7yS/kiIh+GqFOVEEv7Kt41IYS4KMyZ4yzDMgKn3ForQIcEThV
         7JcQBDoEssaULKGYH2E75nSQ2/kcs6naf0OKaoSUhSCJquXvl8VOiHhXH4Vgfgf+0bQL
         JNkbOyBUzus4J7nbjgS8GUJd/9kvmF1uCi60h+4nFo78+8NS5SYH2MwgwNG8RXo0Drtn
         CdF5A4Gr6ln3v7QIWnvQ3pgD0LUUTe015oU7DuZP8bJO8SCZ1YrHxUgM1AInqx84XFFc
         rY6g==
X-Forwarded-Encrypted: i=1; AL+hErEiNDLUbQ27bG+/ULcA53knZJOuVC1pQDet7tubPWkI6OyO//xr/ojxD2LYZLJ0j4UhcModcDLynkE=@lists.linux.dev
X-Gm-Message-State: APuU4Z9mosA11zdeixAqsyD+p2geDZYvekpXC5SorQlWRbQS1N59SLdw
	aDnA+56O7NI9SVegNG25pIOTdb+cg3moTjmqJr9ovVdwsZFzVREC8spJ0Wt9aVhFMQk=
X-Gm-Gg: AYBFou19F1o4n5ekCwD9nKA4cbSkEqGYkOBvfseZzW56b7pYi2gTGPHZUSIXoM6HbYF
	lMATtK0Azw1uPSHi2nxS7xs3IC557auQDA4oZ+QlxQfL22zQYA8uWD9B1ba6csWnPZADqlWzkZj
	QiS237akyX+mIF+9K+RkZfAQY2VpZNase7oIAgzUdfybLqN+qAUuvqpTkLckXLF7ZuH82pYJv+C
	j0qQy5NfWRCdvdugrjNjTvNs9PKMpdgngFhzMyKoLu1dL25ejFSrA2m5eYL8heaece00VedcANH
	XHPeJ91s/cWZ2cY8q+nfl8rAUFsPoCZaHEu789mc8T9x6OH2m9iwPtS7kHw/nomcYlqfN47/Jpw
	WHeHJfr/Ppit8Qq5sEiqz40YytQGXDwuIJmtmeZ36KBjVQm0FfiZHQTSji4q9ulDfKxXB0siHXT
	tk/3duNMTWN2pa5VD+/QU04oMARVjayNhJVPKrfbwoM/XaEuVN9wOmvjpJnS+O/ytirSbTD5dPR
	r2MFN7T2CdUqmkn2yaecTYJWHJMdr6VO+wg63bu3w4f054sVfF7Q5kZ85aHzB4OEiVGeWaDMBJA
	VlygNPoJsl/bktS3B2ys/OiethDAjSxNm1AfX0UP7J0AAeo=
X-Received: by 2002:a05:6000:22c1:b0:491:ef0a:1f5d with SMTP id ffacd0b85a97d-4927678d572mr6661924f8f.39.1793978413847;
        Fri, 06 Nov 2026 07:20:13 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:12 -0800 (PST)
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
Subject: [PATCH 13/20] sched/eevdf: Try to push short slice task on a better CPU
Date: Fri,  6 Nov 2026 16:19:40 +0100
Message-ID: <20261106151947.3991524-14-vincent.guittot@linaro.org>
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

When a task is put back in the runnable list, we check if we should try to
push it on a better CPU, i.e. when fair is preempted by a higher class or
the task is preempted by another fair task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 980eda9c935a..3923587b66e0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10112,6 +10112,23 @@ static bool __check_pushable_fair_task(struct rq *rq, struct task_struct *p)
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
@@ -10120,6 +10137,12 @@ static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struc
 	if (next == p)
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

