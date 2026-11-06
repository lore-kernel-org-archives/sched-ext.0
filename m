Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978426;
	b=LmsuJB5coXyL47CO85OBnItUOd6GwrsmkmIvR+51znoUE7VX9NEV0T9MNuBGlWuIng9r
	 zivSYBXoTCrTnFgA4o38Enb8AS1IrfbHWduXGfpPRWTjywyyjPIdoIcxACfl27TrQxPNt
	 MVz6YON6QaLGCMlMFWB27N90xyqi9305m4D+JZ72xaE8jlVXbNoO9RzFUPBS3M+AFKFtG
	 1wB5SUj110vWbm0mTlMv1B/KJ966R6lNZFj0+ID/2sjLFVh7G4rNYOxprmOn3IRhJW0M+
	 WUvXJ35c2xQ/AQ6v2sP7QxAuQ3YOV4ltt4cXpUwdHgwrg5hnadipcfVAQOUkqX54MGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fjXC0m7vB3Xiy5SvbhOFI4wpy3VxvAkCMaqlqhn8FJg=;
	b=hlKmVFGg/uvtJeG6rd7uF5YK+JX4a4LYqkibHE3LO2GuS7rPPs/WgzYWvOIA+P6VaBL0
	 wCZlvuc+A1/cfaY+ExYfV1jDPuo6XxucYTH/C4JCioLgBrXd+2IsHcNGVdG/GhacTNtPa
	 wFZ7K6QOYZIe8PDQHi3WeLAmsBdt985J5HeTfRG0Uy6AEJ63Jyz6FmXKb18XhUHBiwXf7
	 4xG9DdtFdDowTfic2lXUEQG/Z9+25GutzuhawACXc6ZqnYRP3gj2KT3PNRyORIeQEGy8b
	 ULKd76fjCpL/J7Z6UjttQ2JAPbFVxb8VK2PpME2LVO692o7f1fh5V+yBCuJwtKmjHcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oY2FMiUO;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68060A2606
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B68060A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oY2FMiUO
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a208d93758so7849335e9.3
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978425; x=1794583225; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fjXC0m7vB3Xiy5SvbhOFI4wpy3VxvAkCMaqlqhn8FJg=;
        b=oY2FMiUOeATW8jm3Hg03ABGjlocI/edBpFsBG280NG38LFWpiNwICoYCM77MXCv9BS
         C00SpHEi1Wa5v0C19kBLjqNRsZ936aWHgOnEzuco8iaRZM1HvQwq+gK/WXkRckLllnts
         00hjZdQiexjwWXr35zSxFqfZXIL79uIHbTv8g4VrXUj5+WN0kaCtRG4Ae67BxQwC1Jkh
         KHh1kzRyd2jN2WHTGSrF8XC9XzqyCG4dv2niHUfuHRHWgzfzAwDY3H2Ce8PXLonq/ruk
         y+rxdTmBM6XuWShHVn1JHZWVWQW2EC/gTohxDKR46nQX9VT++EdgBux/Vda6ALfMs9AF
         V8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978425; x=1794583225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fjXC0m7vB3Xiy5SvbhOFI4wpy3VxvAkCMaqlqhn8FJg=;
        b=arcNakNaQHYfZM9SzsV1qs6N2W6MapzXG2yWovKWtAvbKGNS6o5QhSeTDnrkc0q9Zi
         X1zh9elauJtzKPMp9suHn6rhErgPamzCoXaxma0hm9hu2iJ4wDuuIKQ+O0fcpJGF42vB
         noxie4XaSITfG8lhviW+Nz/g1LFmqyxby6b1lczhDeg/pAcnEwfJOOVwTVN07okl59Iy
         jZ8e/3WRDM2q45b38Lu0O6KxX37/zqCIXlccJ8ydoMgxeLXIiOGsJ3qbTAkvZeE5wWp8
         a6WdjpqUq0KRHTuHkxojcgF5tu5GpRpYeGm9f86AzrCJ8JesoEXE35jUubeSXA4qy2Kp
         5ZOA==
X-Forwarded-Encrypted: i=1; AL+hErFMxvjj7UevfPedeFmsMumokh4iPfbGSwQcrFRGzP8me1/7wPPJv3g4xizmyOgUmFdDqGgcJJ+zdzw=@lists.linux.dev
X-Gm-Message-State: APuU4Z/Lge9xH4wx+J1z41fwrw84m72ft4mlFzfUpK4BawQzv2Bc83aZ
	m2tnsD3PhnjSY6ifkfuo9+iJeoTfcyqRb0P0NlBmPd23mquNHESl2vitYM6B1YosUJ0=
X-Gm-Gg: AYBFou25wl9p94O6XOuj7oyUkK8n0isKrl3S8zOo1LVDgy5ATWq/0yxTXFy6V5T8tR1
	G0SzcYivhuo3T46WieJ1wJAbZ5YQmaiyi2t8+mhd1HPuEd0LgLRLgjpMbPUqKarJIKyJRXoRFcX
	L5lYeEsOCSBP4bYhsrhHhAywjHgKUKNqnUvHX5b5gbnkOOA6oXj97zIIFBUp4gST6AQBLkwVoi6
	9JfPp/V/kC/hB/bsWzo/G89vl1j5/aHUowfC6zO9n0UopTDMvVIChmVxpgTpKluJOrstdFh6UaG
	zMnx1N2yuCB1OVLr6bmWKif0mXr/vTgjrMlaQjB/gpv2UAO2O3AzK+BPEHZVBbopH6d7+s0om+x
	fywGAXeBpmMoI1hV+gNpEspDRfrwQ8GZFU1Wyr+yYT9bFiD/thpU1V5k5iTqag/mD2ZWIim65QS
	k/R2rxgEGi1iyMnRStCe+cacjk15QDM6GGBiFqHroO70MdIDe3MsxPDWb1AT6CBJ1Gw054rBZB/
	LOGnu9y/QDyH81bvIa5IX/ImTRniz6eqzfZJNRoAvHXeBPs1t5DtVT566dDEDTYbjnqaupN+f4A
	9JiKri42pf2dunoGS61MkrsTvfphKS0OVtxM2oJoEHv4VK0=
X-Received: by 2002:a05:6000:22c1:b0:48d:eec6:308b with SMTP id ffacd0b85a97d-492765a4011mr6585904f8f.21.1793978424778;
        Fri, 06 Nov 2026 07:20:24 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:24 -0800 (PST)
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
Subject: [PATCH 19/20 v3] sched/fair: Take into account slice in EAS
Date: Fri,  6 Nov 2026 16:19:46 +0100
Message-ID: <20261106151947.3991524-20-vincent.guittot@linaro.org>
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

When the cost is the same, take into account the slice of a task to try to
select a CPU where is will run first.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ea117c3d0dd7..da9c4416f1b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9885,13 +9885,22 @@ static bool update_best_cpu(struct energy_cpu_stat *target,
 			    int prev, struct sched_domain *sd,
 			    struct task_struct *p)
 {
+	unsigned long task_slice = p->se.slice;
 	bool target_idle = choose_idle_cpu(target->cpu, p);
 	bool min_idle = choose_idle_cpu(min->cpu, p);
+	bool target_first, min_first;
 
 	/*  Select the one which is idle */
 	if (target_idle != min_idle)
 		return target_idle;
 
+	target_first = task_slice < get_rq_min_slice(cpu_rq(target->cpu));
+	min_first = task_slice < get_rq_min_slice(cpu_rq(min->cpu));
+
+	/*  Select the one where you can run first */
+	if (target_first != min_first)
+		return target_first;
+
 	/* Favor previous CPU */
 	if (target->cpu == prev)
 		return true;
@@ -10055,7 +10064,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 */
 			if (target_perf < min_stat.min_perf)
 				find_pd_cost(pd->em_pd, target_perf, &target_stat);
-			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
+			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd, p))
 				continue;
 
 			/* Save the new most efficient CPU of the PD */
-- 
2.53.0

