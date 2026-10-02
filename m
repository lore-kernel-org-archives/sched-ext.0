Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323FA4C77D9
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955930; cv=none; b=tf1pxUyHAcBznJKAzMOCwVE8wJUvW63xolfeFbOmD/xSnFhBF/9M0FHrTvDdxr0j4Rn/ubsFMw4FjjGS2SRfcELyL538r7Zgty+0gnKY6zRyO1swQj9VFHT2M/9S8BX/z11R5+by7EzYovJKJY5BxAzqjiQghBvmN5tygo/fTUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955930; c=relaxed/simple;
	bh=qgQ6mPEUSsweS0ySFC93r8P4Eludf9RVMAvxsJJRRs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ir69Zq4rD2NxZeSPtGOC+Ez5gd/Qng6Dwqy2NEOAY9esIi3aAl6KDnhoLVONyzU7s3HRPcLNFMQ8lJHmMcJcmDVOOUWC+cIfCzL+l0/FbrPmlQay98I4PoFvO7PQ14ZQwhQiHh74wH0LUIW2Ko6gtJKH/Y8a5juJVk3Z5+9q3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UYLmHkrg; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UYLmHkrg"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a163f2555aso350275e9.0
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955923; x=1791560723; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxDjVmpry+V5sESUwysJzs9Q3KJpqmz8KRnIcWV2Dos=;
        b=UYLmHkrg7U6lAJrmRgs7ZCB/daxfdt+6hN5wykKmRwvABCtf61rvabMi18DaO4GrKP
         6kty624Fh0zKvzJTUaYNU6MMy5AxgDxSeiu85RHgD52G1b4+a5O94F9lSA5lJpZXtAEv
         Slzwqie7f+23M4l4dgf4BR6VcQTY8+y6nhAeBcSfykBuEQs4EEsAaXoVUK+Z01gwmFFg
         4rkhTHe0BW4iB2RjlFzU2fjVDkGHMCG3/Uifuks7IZF16xT3Re4j2H7k8032iGsL71FQ
         qmZcYb9MEpOOLylgJ6Qu2cqrugDe682EnuclzKD9VnUgk8z462DbGwqJN2MGlOkK9GHA
         xuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955923; x=1791560723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pxDjVmpry+V5sESUwysJzs9Q3KJpqmz8KRnIcWV2Dos=;
        b=WOMzJvHU0mudaoy6UqWiCfMWniQNY9LiBPlXs0p94ic4aSkEaFJGnJGh2f4OHVjnv7
         j5lj0KsjvejMCYAwmF+uhf9GUXMNcNrYz8UwJftaWdi55YdgUJ1hM2AntH3VOl+UX/M1
         WXOiglamO0HDUx77LSnl14eFGyJZKvzV8vDiWntx4TxNlOu2x+RUJ3YhA5L2ST1/XX1z
         Tab1FDb4ztBnWhmvXKo97+bsT3h8+m8XlkpPGo+b+6eqafDGrw2O9iR3B/RSD51ooLq1
         N3kWjy2xWRQgRStXLTDVBPJd+lwVOSpVRGTyV0zgrOQ5hEVcxI2X8L0X8kq+x9X6d5E1
         lnig==
X-Forwarded-Encrypted: i=1; AKwUvBxYLy5DdKicwAHhzZiBP8AkzWTeBMyG0pE2g4XX8qWxXIAbqsHCZ3HUs4ziQ5izjZef456cvWNaIGg=@lists.linux.dev
X-Gm-Message-State: AFuF++m0W5h97o2Kpa0kKUcuk6mxkbq7o2ge8fCr7KrRc72NzDshWS7/
	k/MN226ZHGBOShOO3NYKAL+/0ukIeqt0hOr1lg94zCWizUKp4NjtfZ2YKIeJYkEmi40=
X-Gm-Gg: AYBFou1z3V825ut51HV9djK9Rw7XmXGsV+2kHNU24z0YS+mnvD0FVIC4aTSPA4cFB82
	BZaiAeE4vzf5/DgtHulhoojFglXSTov6TisHfhzZCkbnhs/SaGuOFgeOj0xCB16HIInOFoZHZFE
	zRlQR834r6urLtyQWIZ7htPDjNbcl8ZdTCNQJwrfF+SSCLUjCpmWMZRHt+532xGrDDgBSTQUL+J
	OsWmBsvYwu997oN5PXKe16iLM5od5enfOOpJRaMV2M8Agrn2hdVOhxTBiu6LoqVGFxPTro+yUOc
	nAE73u74bHHkF0kNs6TUq1XI6Nv4fF55FJf2SHa9WsMJCn6aOiCtUirOQUD7fCwrpr5yXHZ88MZ
	n1LrPNby2Rzj45JhRG9e2aiYWCaa8bmrT/5M+XVOp9HoYm22bld3JgEV/+qJ6zY20fTrKWpPVIZ
	I7UynCWGG8I3vqnMebesW8gMgxz8VxyDJ+0NkJsYLe1QqfX5ZdAWK+7qI7VFbFRy+9wXRHWfiCs
	euSiLTJFrFm1YTJ
X-Received: by 2002:a05:600c:5308:b0:4a0:168f:d962 with SMTP id 5b1f17b1804b1-4a02751affdmr54746315e9.3.1790955923338;
        Fri, 02 Oct 2026 08:45:23 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:22 -0700 (PDT)
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
Subject: [PATCH 14/18 v2] sched/fair: Enable push task for preempt short
Date: Fri,  2 Oct 2026 17:44:11 +0200
Message-ID: <20261002154415.2270586-15-vincent.guittot@linaro.org>
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

Enable push mecanism for the preempt short feature which is the
1st feature using it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0248227d983a..6b1058268e6d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -3475,6 +3475,9 @@ static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new
 	sched_energy_set(has_eas);
 #endif
 
+	if (sched_feat(PREEMPT_SHORT))
+		static_branch_inc_cpuslocked(&sched_push_task);
+
 	/* Remember the new sched domains: */
 	if (doms_cur != &fallback_doms)
 		free_sched_domains(doms_cur, ndoms_cur);
-- 
2.53.0

