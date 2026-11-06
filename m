Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978399;
	b=EiOEXnQ258RvOsTEO+B5XPnrEW1pc3Cq0y0x3J/OxN4TUR2ak1XM0sJ3qz9xVZNnjdA9
	 d96ky9w1ji7EBpamTGMjLR25XNCpcz/ZfQOjTrM2/2qDwpOFTfa9QOeazkXPJwhQ2l0XT
	 W72q1woxjdplCSJH/WODaJGbeGxQqSUFh/UbDfe6BfK+93mgUaoGHzBtNTv9r224lUA46
	 T9XkgYBeKfQaNVcNdC4EsEM6hw1fUp/AgRqk/5/h+mqB+CWdB3oN36rOxKSO0Y/LQ1gcT
	 8ox/JM16nJTSCHxy62BOOLpO6iBASpCkJZI7MH9raPEbTyhZpO8l3rMVcMczUbLwXYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iQOQ14MU4M2V3E3LBaEma6rT5obzfuyFx7uEPZEbprw=;
	b=DC1Eye9C0E4lyZztpEHOYRbjiwTiCgSCCO7zVHXwxcSp5vMeAcUNMt8PI1BI+MGh4OpQ
	 vACINVYKnhkUpeertswT7OZbooAQIlEaq/GYJH4VvVXwg4kLu6WOC5x4WkScjdNJp6/En
	 gbQyrVWCXjOIrI5nqkKuSw5TrPsXLvCEE5RekaITm2pa3sbgFYug2dGxDdEOp6oWveeFl
	 6LIHke1pJLhWME/UNVR51Gm7qDugc1dFIb+hM2wmN7vYUWdE9rqghlRrAySi1OZ6aHXkT
	 5O3ZU7OjbOq0GM8hJr2TVG6cTAdZyonVePbU32OKmBCeGtLOc4TBfvv8JN0QBGwYOJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yTTFQuJv;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2492606D81A
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2492606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yTTFQuJv
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so5934605e9.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978397; x=1794583197; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iQOQ14MU4M2V3E3LBaEma6rT5obzfuyFx7uEPZEbprw=;
        b=yTTFQuJvFtI5uYkxjwJd4QSOcx51YseHEES0oFGqqAK4KsCZSBfVSDY08a5eLMtQ6x
         Td32k1JMisxb4g/srMWHztIYwyxXfgKJ6NhUlewpA9KNOH7vnDKdCAELCJ9YLof6VGtw
         QKk0NIu/KXqym03Pa+IZC6YMsOs7R5v13fzDRmojmxVowetQP13wpSNpxqUxlvx/xOLq
         rsVcQkMqpIq049olkI3NjwenguFYkQ3xyJPVIoWYhvXVYQt0vG9KWw7JoNF0Y8ZFjIOo
         iTWXfeHZ/W9UU7Sh5WiU3mchWqGGHluE26vSfNKVUcUF6VIEqfj5s+q6mWte+0EYPnvx
         yHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978397; x=1794583197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iQOQ14MU4M2V3E3LBaEma6rT5obzfuyFx7uEPZEbprw=;
        b=TJNVFbDz4kebeTYTxGjvy3K0wP2JR61Q7zP0C398StiP2cZORxDwUHuxuygBPl3JTa
         zBFMcbd7S065mEAgckH+kR9DTto9H5Lr9M/fC0pN/0AJ3RwFZfFQAEzH4P0lNdG5XIxT
         smTNbTqCuJ8kGqBeRvrJW11i3uzrOBx0DMmOO6W2PR5v1zzUZzLnuTIeguPm1bifHdhL
         hmxDxdXdxDlX007QgFW2m+xu0wrn8pv4fJF9IPi/gxqGJG3c7FMIowQJEWVMaUWnQuFT
         JukzBGqJMjwn5UATurJl5gi9J3zu+cRFtU+i1oitbpqDf1z4xUDfYo7NntQInecS4XyX
         YlEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgNk7fFf+9EtEy7a8k41/w3LWEEzwsLHUFzHBIAXuzcDUQ/5MF5h1nV935U0je/g8LoGBfqUYnY5A=@lists.linux.dev
X-Gm-Message-State: APuU4Z8zhMz/edK1ZdZFaa92pqDuBjGvnJ0eNT581exGp2nlU2zG3KhG
	uFUAqSUJVKKo25Ndz9gou+G1PJ8UkXLHr0ciu0Gby9YnpRDddp65w/WNwjFSOa6b9sE=
X-Gm-Gg: AYBFou0Fr0JJr3YkDZRBcFbTwFgR/mNZOyr8bO0WfS2xfQcCwk/7wq0g0iwp5RB86tR
	TZ2Kk+PGrH02sUvvTLSPmD77ktIJ+lCPnF8HzHMqwjGSm7PFc44fN/oB0MQCWfOQLbItY5LT/DT
	nYgunsLRVjpsvx+bNAi0hVhdC7qpxk6coJqFR6L0DcAmtOKf1eq1WQOmTrUySJKvayIKTiHTgrD
	A4lCtlt7dK2f6a7mCZ+9LnsE+CoZroU5scxAJlYQWaQmX3D8TD2N2pyfh/x2fDxUq1xtTeexZ4a
	eMH9FSXLpsR8No8OmRK3936637N8VYYDJsAL6FvvGy/Wpoq3nanIxVpH9AaKR7mMdG51WqTHXqJ
	24WIZIzxyp1At5o/rje56Kzc6bGYWP3i00yKx1AXTWl5QnJxG6WNP4d3YZneaj339hsYmFxxcMZ
	6T4gnMePKuhzJgrdD0NIaMvVjx9P/ytneK1HicjFcZN3PzSwttHIzn8Njy9nbGKVVCvjpMxJst7
	ranPG4Bkkqks6ETPYZgZTjkEOqFah/Dnj4tCGiHpl5eVtcpvw+xxWkjEE45kvmn/fdKj2NbaGKI
	/s5ETx6juWFWGkXNoTHILuGtm1feCbKPdIRlmNIwWnYkiSs=
X-Received: by 2002:a05:600c:3d05:b0:4a2:883:4adb with SMTP id 5b1f17b1804b1-4b6dfba86fbmr52101995e9.22.1793978396996;
        Fri, 06 Nov 2026 07:19:56 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:19:56 -0800 (PST)
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
Subject: [PATCH 04/20 v3] sched/eevdf: Reset lag when waking up on idle cpu
Date: Fri,  6 Nov 2026 16:19:31 +0100
Message-ID: <20261106151947.3991524-5-vincent.guittot@linaro.org>
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

When several tasks wake up simultaneously on an idle CPU but their prev
CPUs were not idle, their final vlag will depend on the enqueue ordering
as the first one will lose its lag but not the next ones.

Reset the lag during the enqueue if no fair task has already been picked
and set as the running task.

As a typical example:
- CPU0 is idle
- TA with vlag 0ms and TB with vlag 5ms wake up on CPU0 simultaneously.

Depending which task grabs the lock 1st, the behavior will be different:
 - If TA is enqueued 1st, TB will be enqueued with a positive lag and will
be picked 1st.
 - If TB is enqueued 1st, it will lose its positive vlag and both TA and
TB will have 0 vlag when eevdf picks next task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 945de0215abb..6ce4162a7703 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -967,6 +967,14 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
 	if (vlag <= 0)
 		return;
 
+	rq = rq_of(cfs_rq);
+
+	/* You can't claim any lag when waking on idle CPU */
+	if (rq->curr == rq->idle) {
+		se->vlag = 0;
+		return;
+	}
+
 	/* No fast access to prev rq task clock */
 	if (flags & ENQUEUE_MIGRATED)
 		return;
@@ -977,8 +985,6 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
 		return;
 	}
 
-	rq = rq_of(cfs_rq);
-
 	/* Compute sleep time */
 	delta_exec = rq_clock_task(rq) - se->exec_start;
 	if (unlikely(delta_exec <= 0))
-- 
2.53.0

