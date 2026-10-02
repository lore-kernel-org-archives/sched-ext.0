Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3C4EDCB0
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955932; cv=none; b=t6gGKrSd3gsTQ6jtSdKHATyUF/fE9hggk/Q3Rj0Jevb4kjxjk0ORx7rjhgUOdK5bX/8+wibDz1U/2onBYrKCS8WkX78rrOI4w3a6xK0FiZx8pRJEaWzSnSdHypeEzKhZ4ZzbU9kf6Xrgwo0gOyI51GCRbpAjYc3h9540VOCowlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955932; c=relaxed/simple;
	bh=XJBmbAQssDpv3cWBcThWNbjc6nl3j+gt9Ko4eNiaO98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg9cL4gySxM9dXnp1L7vPR4h6zA4pusCmRfEQjOsFVTgvP/sZDzETMGnqs78X7KbezWbDyrooDi094jEG5maYdjg4Yd81HTSXCtVIBhw6+8BLO6ijDa0Ot/6iB8TYEgWGWm4h6v0kmDsl4lU01YtmXz8QNtl4tdwRXVnFFsH7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cu32fRS0; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cu32fRS0"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so429365e9.0
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955925; x=1791560725; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkE6gJnDRs+XLmAou5XPy/YO7fax7WUEGWY0OkDdt7Y=;
        b=Cu32fRS07DU12QzJ6NV2MVh3WnVo0x7mYHRpceCTp4ckjMaXvUYUv5F+JNuzBe37Wm
         rAemLbQmfbe+wm8GSjcX8iI0lM9esyVihDhHWBTIIsjH39h1XZSO6iQLRLCCfuoERJTx
         Rv5ghWCXyBtmI9EaAnlKBtA9KORRcFoQ/wZPzjaWeP/1YVOIlYUkpQb5MJ+n78BAtBA/
         CzXH5rXCz68uRJmKWH5rY+kAIYJRWbJFbFF6hct8TeFCjENVxzqPVsJlzxPnkPsixyZP
         ASK0eqPegaJ6J9SXFukPCxj2Ds4ZUG+fCEPdZ7E+RMFVlZJxYJ+zG4ZDRBwtchFoxKYl
         zapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955925; x=1791560725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WkE6gJnDRs+XLmAou5XPy/YO7fax7WUEGWY0OkDdt7Y=;
        b=W32bJc28b26VN8okzRk5dy9GwnjAL0nQdnhmlBG7dea/FO9mt925avYc8BO3bS+0sb
         oNCEGjhvkV2jo+riydg2RTrQf0zmT5AZvOl/klN9rEK11xPGN0ZMfxisrQtNBQ4Csvn+
         Gn/r8vAIR1DzOS7r6ZN5w0sl4apAdvG7lczm1/WVApFCrPMj6wIYmcHO3h80OT2umXn5
         Ovu0wrhMj33jmgubxat8YZ2QO87GvxPecT9mcBrISqKkKdsDxeCj5gUgsryzqSPGyZWW
         p8T0C7K0GqfFw9Fkw5nSVOEGqnJmisjexKxU/mCwyfc7qwXbQ9SAf7vL+8EZv2dXv0vV
         RwaA==
X-Forwarded-Encrypted: i=1; AKwUvBz8fQicyW4goZi4OntEMnh1s2hxsojDMuDCj87v16EHzOlX443uPlXLTF+pO7qJsg4yHdXO8iIqql0=@lists.linux.dev
X-Gm-Message-State: AFuF++lI1Y+5KJB0hP9kdn+a9JQjleN47UGDpnswDDG++P03CeZMJ590
	6DnVvA32lCmkervEwMH21FpZXGkYvO2lW4sGmiwGiCPM1O/j76VZXT4zQhjINel1QGI=
X-Gm-Gg: AYBFou1Lhi5oK5u5zyCMnc3HA7RGHQdtY8agXdHG+ewAEtbNdRmyjHy9WL+ah2eAsz7
	Kcy6iEkwDOD/mTJurc/tihIuqvptZOoxh5/NTqpLNcKrhCdAUT90yfjBNinaHuTdHiRLSOAb+k2
	ekP0NT2e+4S8dz23INDwimn3Vxo2+huV2E6dy/srzodT9XDIgj0VpbKidFgV5jIkIldp+owu0Me
	T6U0j7Fozsjx9hPXUmgbWK4X5gT2SG0bQ1UYK2mCevrc8M73GC97hidEkK/fJg10PgfdTYn0opq
	govBhcVUHyaDPmZTGWbiRvbi7KtdtAWjK2mYPiJBsaKZxFhIT66KishjuN76IEBwUbtO1dJrSfa
	Fag78N829fJpjlE9vVBJJ8R+q2OXcKWIQXCDidXoNZvB3/28L3IxjPEGS0x+99ys6Mzk2C+d6hv
	LyTyOuT9BG3UsKFUBzHc9Ixhp1b9uvJbqdT7uKbd5cz3A3xt5hQt8RYFPInd7bpjvNFqJp2VclA
	1pHfqyTmW8ZyscG
X-Received: by 2002:a05:600c:310b:b0:49f:bd3c:bc25 with SMTP id 5b1f17b1804b1-4a0276a224amr56824375e9.32.1790955924579;
        Fri, 02 Oct 2026 08:45:24 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:23 -0700 (PDT)
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
Subject: [PATCH 15/18 v2] energy model: Add a get previous state function
Date: Fri,  2 Oct 2026 17:44:12 +0200
Message-ID: <20261002154415.2270586-16-vincent.guittot@linaro.org>
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

Instead of parsing the entire EM table everytime, add a function to get the
previous state.

Will be used in the scheduler feec() function.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index c909a8ba22e8..89cf109cbca6 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -224,6 +224,26 @@ em_pd_get_efficient_state(struct em_perf_state *table,
 	return max_ps;
 }
 
+static inline int
+em_pd_get_previous_state(struct em_perf_state *table,
+			 struct em_perf_domain *pd, int idx)
+{
+	unsigned long pd_flags = pd->flags;
+	int min_ps = pd->min_perf_state;
+	struct em_perf_state *ps;
+	int i;
+
+	for (i = idx - 1; i >= min_ps; i--) {
+		ps = &table[i];
+		if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
+		    ps->flags & EM_PERF_STATE_INEFFICIENT)
+			continue;
+		return i;
+	}
+
+	return -1;
+}
+
 /**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
  *		performance domain
@@ -375,6 +395,18 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
 {
 	return NULL;
 }
+static inline int
+em_pd_get_efficient_state(struct em_perf_state *table,
+			  struct em_perf_domain *pd, unsigned long max_util)
+{
+	return 0;
+}
+static inline int
+em_pd_get_previous_state(struct em_perf_state *table,
+			 struct em_perf_domain *pd, int idx)
+{
+	return -1;
+}
 static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 			unsigned long max_util, unsigned long sum_util,
 			unsigned long allowed_cpu_cap)
-- 
2.53.0

