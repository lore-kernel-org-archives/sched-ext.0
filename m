Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A924EE84D
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955937; cv=none; b=PqGmsB94udowKYcWoca5UxW3S3tFX5pEjxcc89QdmIXnxjtMEdrn240OzEFI/4cWb+PII1O+SDdyt7+hQfjAfdvDNv/iPC7vHDUAnmiM26KmxRpPAOlScueT/ZumYJ1YPC8ujuhjEQZOEa9nzgbgT8v9gfF4xwLusWfbuZAuo9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955937; c=relaxed/simple;
	bh=ggoTRpIipo8tqYS4OC5rdC9P6GonVqjlFQkkxo9kZmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyxnXDH3JTi0tE1ua9CnLrDXigjXpyk3ecZaHXBGuit0xdnAsEYvAbQW9ZH+aRh/aqdNBVOd7AHsC6Qs0tfdZ54ABXRCInFf16CKTBIP/oNVhdqWuX2HjU9sobgHIoIB5gkICwtpTG1ioQf2hN3guJ/MqXtVLNI1GB/YnzPo03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZgpnwYgR; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgpnwYgR"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so165145e9.2
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955930; x=1791560730; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+9o8MqrHYpJJITgMWl7mhC4JEDEuTdaJ3vXHPZaTZo=;
        b=ZgpnwYgRHacBt7VAwKDc8GZNnI1NCxbhYJQht1dzhd0NLOl1Fbg0sp+XY/My7P1blv
         XgCHT9PqyjwTaO+DbDmsKpYCHvUD9jCxXBoOJNdC3xlKZvfxVMDXd8NbRr2migQ9G7WM
         7D1UsaBMVYm8ussIG/idtwmigr9stV+TKb1F/cy74pPSfYpnjcEwv2Qf/QEBRmQb92zs
         9gyQ1bL1+wRoSZUxZqiwGbXmxcslyBbY+0gxK46SqIAnjOONuyVX06iu+x5DSYVX2eh0
         9F3k3zNRGngd3s4ntzONAzmeia9817ckA2Fq264rTUknfBLWOb+H3m22JTGd4dldJ7Hm
         7Qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955930; x=1791560730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+9o8MqrHYpJJITgMWl7mhC4JEDEuTdaJ3vXHPZaTZo=;
        b=MeYLkNgx2DjAvyObTGWsL9EFVcU2yl4MF1DoBOqmgZqJqqD54m/sCTBUvRhdXbpkHs
         a4lnHLk0imkR3Ye8b0Ky6cj/o+qiObuG8dBNFxBegnXkQkaR7Q5N3t9MWgEko//PrEU2
         Rmes4u0BB1uBPupnGUilvAlH7QnZwiODi5jCHdLvQMytvjBN+v7nALN0nyT1pXC9jmUM
         IrQcNJRrk1tXjRx17ELvWMoyClkAdqh1YWOcHwkZ+tYXyZbYa8JnFA4WJbIzVSkIVOkg
         kBAU3c3xs6oWlbaKLaFRgX+HI8yVpz3cCwQ+YT79o+x1/fU6TWkwR+xbIpDP+Wa+9uge
         x/Ow==
X-Forwarded-Encrypted: i=1; AKwUvBwvVj335nfV9+DnJTgdp3j9w3x8Rgx1kD5/cDVRH9b2X1tZbFjEJkZGf6kpJbWP0EgJ7bef56n5ziA=@lists.linux.dev
X-Gm-Message-State: AFuF++nTgaOk/N+/DRGvfzekIms/vAtDZzfhOBhTd0VbINB3TJLQSMSB
	OF+gvGJmDGcFRHlcKZDeXNwuf+gAw3RjEGz4XmGLQCEj90iEnYqzD0TzTs4Y5nCt9qM=
X-Gm-Gg: AYBFou2gTDCwoRxkB7dIDzimphzQiHM/5PfC69t/I1zeHtjjy8Q7+Q6YtFwDYXe5D05
	EWmXlNyq8rHaYxGtY7NvAs9V8eGOUPM7UflYScRRohc1RT3TnfFzxJHls3RoiJrcY11wAUcGRR7
	A8Cp3sp5fP/HHNx7lJf7zSSvPsbTbLbi9Jhjx6VuLuiLCmy5ATDodYYLKzIEl9JqjilA/Zk0Ceh
	K/yzPLgXTmR+Jg5gaNYCl1EDOKUY+c5Z6nsugDpDYZb1Mak9bYpfyjh40FgZMW/Fz+QSpdDtfoG
	v1O9OOko2jx8ChBAVq8sCixujCN2+hlUO3+7OLuf/8IRCaydPXg5/Ca0V5ivHggqhQxT+l7W6FS
	++I2juPAxe+BYFwgae7Nrc9agdiA4CL7KeC6MP46NjF8IRigf7YJomJWk4GY2p7v964z60ZeTKW
	qwVJM/Lx8Ce7GKJ18mvawusMuzJO6z0ucLPXPJ/k9XS+qNC9qnO97LgUW+ImJmp6+3KHs+HE41V
	TDwDWknk+9rR/F1
X-Received: by 2002:a05:600c:46ca:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-4a0274f96a8mr58318145e9.1.1790955930554;
        Fri, 02 Oct 2026 08:45:30 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:29 -0700 (PDT)
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
Subject: [PATCH 18/18 v2] sched/fair: Take into account slice in EAS
Date: Fri,  2 Oct 2026 17:44:15 +0200
Message-ID: <20261002154415.2270586-19-vincent.guittot@linaro.org>
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

When the cost is the same, take into account the slice of a task to try to
select a CPU where is will run first.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 94554f165f42..d60bb6db4ce9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9598,8 +9598,17 @@ static int check_cpu_with_task(struct task_struct *p, int cpu)
  */
 static bool update_best_cpu(struct energy_cpu_stat *target,
 			    struct energy_cpu_stat *min,
-			    int prev, struct sched_domain *sd)
+			    int prev, struct sched_domain *sd,
+			    struct task_struct *p)
 {
+	unsigned long task_slice = p->se.slice;
+
+	/*  Select the one where you can run first */
+	if (task_slice < get_rq_min_slice(cpu_rq(target->cpu)) &&
+	    task_slice >= get_rq_min_slice(cpu_rq(min->cpu)))
+		return true;
+
+	/* Favor previous CPU */
 	if (target->cpu == prev)
 		return true;
 	if (min->cpu == prev)
@@ -9762,7 +9771,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 */
 			if (target_perf < min_stat.min_perf)
 				find_pd_cost(pd->em_pd, target_perf, &target_stat);
-			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
+			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd, p))
 				continue;
 
 			/* Save the new most efficient CPU of the PD */
-- 
2.53.0

