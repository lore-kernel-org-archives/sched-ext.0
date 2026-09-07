Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1353FF1D0
	for <sched-ext@lists.linux.dev>; Mon,  7 Sep 2026 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763798; cv=none; b=Z/TXWR4STYurfY1HEbZnxN26oU8wyQbao7GbkI0M6YYuiwFH/caKUV+2bXDGiMtgQo5xiHEMJe+y4DeshldYT4QAdq42pIw/FKDrNiL6bz5SXdV6JRv+9i3CWUb4fL6goAykS2NcqnGGdTsXP9MXc6fNCVEK5hRG6WLc6byK8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763798; c=relaxed/simple;
	bh=wP/VmfgG8uegsHyz+t5uqy0UJrm9m3L+wrFlNnRkDRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtzIf5DnqYoDtDXplWCyHvy0tyT15W0Ed0NJJoOAsl+/rvkZy9zDiubvmxGdkza/hYGj56OMSQtbs9RP22nl9dDKuYKtub9y32UnPIucj83sHGxsYgWRqW2qcMnZ1hNwRmjyrlSINJO95rCMFoy1uCdSj+prsnBGTwaCdIS507o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOYaa2w0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOYaa2w0"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-382ef647e20so3197491a91.1
        for <sched-ext@lists.linux.dev>; Sun, 06 Sep 2026 23:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763796; x=1789368596; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JvX58P+MDa4sWTy74Vbi1oLHS8rHG4kgimKkPCwJ7mg=;
        b=nOYaa2w0ODjfeOkZSxoNI665wnYoy0lu/13acHJaXMfa10cQnA6bXHbwD+Iyk44kH8
         a4vy8+K8jHFBiB/V0i+qrl/yO6Ccfn5MjKgOQyc595CjRb9S3Fd5+jhzx6KL3akHN8+C
         UWCycW0qlQKNGinG2jqRGjm1N0yYqEQKuMFoz0t4rCaqkTuxAFZCj7nDOQ33nwZ0ssFM
         1fwZZgQLw3brsUBI4cCQtL8XIjjb7RUVPMdf0UrNtanwtwP1iM4yxKqzD29cNTN8b0dV
         pvbcufzxQgZhIuIyfJG1Cv7fV7ijWdVbsiWU41o/VeXaxMqNC5O1vUvoeL2Utv+sFy2t
         4Yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763796; x=1789368596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JvX58P+MDa4sWTy74Vbi1oLHS8rHG4kgimKkPCwJ7mg=;
        b=JH+HntfVRZRjS7GG2A18aAOXIkkfWiz2Q/i4O0g6WTnOI/VDNmXHKagtiAMZILv36l
         3hFVDe99ioV4bbNRqVhS2//k3czuxTor8j9hBWSGcGKxf+cvdlqhYdEoaQRV68o0EMQ6
         rwS8fCZ18I4O2wdYh758w79UxSN8IG05Sl5gl+UssPLs22SOJCMx6j2tPTl6iA2OQGHX
         mKR6eBabh2Q4SUVzb8TTzW/eccbn9wdSGZKuozl9ZOo+ucY4yYYny/+gkyE0m/Xf2kOO
         +wPRgrQJVx8Vf+4elPkFiTFRRX1eIcJbSTxKoOX4DNkeZNKM5oedmaU5KrAs6Kv2SyCW
         sFSA==
X-Gm-Message-State: AFuF++mIt6x68C8uB0KOclnAzuTu/1Ubifgx/wBi65DpT36HC0L7gwtp
	8VC4+pylcDIz/VqKB2JeAFUFeOkdUF75lrgWT802qeS28x6vLDrRjLX0
X-Gm-Gg: AYBFou3FnJ2aujt3ji0qExgUi0yL6HddNKTgDgl27nFONH6rF9oB1boDr8yqPwvd2w1
	FsPvdR7hSO4RMdb59mRItI0MFn1Rx5Jg1CrHwQunu/ryZgeC0NQm9gy+FD3qi76vTvLPqt9hIny
	F4GUUROr4fIJNAYRUpgIL92da1JHlhCSkB65p4D5McUQaNv7V90w5XxLkzneQTitp8R6Cltdtyc
	3iobJkCtJMWsAIHAkM56lUtRiSPaULtgJ4vlADMgy0RKWlJqOAo9cE4KL4cpg9hNzsxol+2FBWc
	rggTHhZnYguK0hyLuHVQD1X0cENLmJ+79/38Lsf5E8lbAOuq8B6CCVRQP0NU65L43oJBxisijq8
	a0r5bwgCQsmyf/dg6WJN7Sw2uaqQBDK1+rqTyoUVxv0S03JFH5uEKkAMZdmrPfWVjfIDYcrVxOh
	UQL+8jdDmovXZfshIQBfVxSZ+lyQ54UoQlV1gZ7RqG2CSKq+mCOYk8yE1FT+qCXblvHDda3nzbq
	jYIZwG4IMnAbtMk8n9JpafQ
X-Received: by 2002:a17:90a:e7d2:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-39b260d296cmr29785514a91.3.1788763796366;
        Sun, 06 Sep 2026 23:49:56 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338778fb926sm465210eec.31.2026.09.06.23.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:49:56 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/2] sched: fix typo "upto" in comments
Date: Mon,  7 Sep 2026 12:19:42 +0530
Message-ID: <20260907064943.25304-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064943.25304-1-hemanth.selam@gmail.com>
References: <20260907064943.25304-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "upto" to "up to", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 kernel/sched/ext/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 713aa26b2828..721f0b3c5c07 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5840,7 +5840,7 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 
 	/*
 	 * We don't want CPUs to have more than $nr_donor_target tasks and
-	 * balancing to fill donee CPUs upto $nr_target. Once targets are
+	 * balancing to fill donee CPUs up to $nr_target. Once targets are
 	 * calculated, find the donee CPUs.
 	 */
 	nr_target = DIV_ROUND_UP(nr_tasks, nr_cpus);
@@ -8816,7 +8816,7 @@ __bpf_kfunc_start_defs();
  * task is inserted.
  *
  * When called from ops.dispatch(), there are no restrictions on @p or @dsq_id
- * and this function can be called upto ops.dispatch_max_batch times to insert
+ * and this function can be called up to ops.dispatch_max_batch times to insert
  * multiple tasks. scx_bpf_dispatch_nr_slots() returns the number of the
  * remaining slots. scx_bpf_dsq_move_to_local() flushes the batch and resets the
  * counter.
-- 
2.48.1

