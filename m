Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362434F3924
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955934; cv=none; b=jGDxRxy/l6/bX26besD8T0d8PyWcgVNAPdKSuqATbYUfcRsT/ZCxaWtLUHqFHqGtznZTfWrmI34TECdCA4fDZulTDSmgfAqzZ2g097RXdkafF+pQvkYUnUHW0eJUS/wLNkVK7kKhZ0B+oOibrSzxgNyUgGzgA365u7bN/HnfGuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955934; c=relaxed/simple;
	bh=Lkq2thXBra+9jyaZNWFz8y5q88bfRFP5x4L8/XdL6qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ME6sqluSCm1pLXETIIBiIz+vyeLBLsq2smwJW/CUd4Q/E4yHLEk/LdwWJFkaqQDHcdRVunvZ0VjQkJazRVXT5nPRZwIBAWdjaejv4RcGDOqdQsQF0wogzwvVsJdvrZL3T546DQ2cvpiWUej4cSFa2Bva8MQ/KZDfn3bC7tOVY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FtflUlXJ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtflUlXJ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so183255e9.3
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955929; x=1791560729; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1AczkvEVMwyiADmz9Aen/RP9scTy6HPzxTwLuS0NkCE=;
        b=FtflUlXJ8CzFPNcTjYQYfr6tVD7SJnMz1CvCP4pvj096b0F7HiZM3Yd77T6cGFsp4y
         DAy1ek1QlXpOEHLHYWJ4+VZCbFXPK/HaaEsHEuQFA8Xhh3UEbvCNISymt9ijr0mTo5rV
         wCJI33E2xjuzOVn5p04yDxWtZ7zBQ1BtPH0bHHIpxLwcS3C9frxtFI8ZqLLYZ2B6zZ5U
         xmlE1FUuBygwARSaUPD6f2SKokziBMzp2w7jUfcInvBE2onTWZU7FyCiJGM+KGO7x68N
         pJEPqxLIQ7irMJpdccWA8HviIy4rxDx0nA8gzINNX3qYFQyGHEvxOHO3bHOTh1itHBhY
         4ISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955929; x=1791560729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1AczkvEVMwyiADmz9Aen/RP9scTy6HPzxTwLuS0NkCE=;
        b=nfqk7Rl/hzZ94r13MJYopmo8n/Vs9SoLNVsWY1+pniboxd7oEHRw/Tb0X5dXzWPjHZ
         vPyBItp9LY1DKrt6UjnB4UZVzL2l9NdwGzLOnYprIhjmpGL5H9am5/d8SDK1VIroYHZr
         9zZ9r4uvwZO5H1tz3Ib8JFhxGRvLyMkI5KAdLvGrZIaHiNPInB3Km9kLCKJAdL7PitmI
         0VmX+CuklGdwVKUtmP3E6RDfLrX3S/ctSioJYKCkCEPAPKoZ+8XpcxPR5+NJCDMWFFoB
         pkXPJQy6sD60wt+5HOHNP4o+6lD/6MS8jC8E/4qb8oQhc+WWbxCUVtOCoY+F6GmDs0Fj
         +6aA==
X-Forwarded-Encrypted: i=1; AKwUvByEkr+40KDHv0agrU58l8TQJIgTxW0QkpihRvcTyehpW7Coj1/I5KCKbB31Asw4JDztV5EBMRcujBY=@lists.linux.dev
X-Gm-Message-State: AFuF++lkk7LrTN5GTlXL3WxoucEVbx04mq+Go0KN81TNfwCnPDogdql2
	o+njT8N0JXIYfHQA7pfsuyfxyNLVMy+yUcfAMq4DK5OuPqWauUTF0TbBNvaCqypVQws=
X-Gm-Gg: AYBFou0t3Lep7RWZNCMuHxxZWjDoaCp2i/6TxQDDmtvVWpEuD3UYPyfxi/yjGPlXPJq
	KCwUatX8rnlEP8kS9FKRp+S8RnWvRkNgUL0taM7mFuuPQZUoLRtHw2QnXcylqesLvTQ72H3xiD3
	8b/J24pO2HiDxolF19yuVxZ1Tms2J45qZkXL898yoj80PEeCbaIpf1qh1LYn7j/RUpsvvXDBzKI
	8YzoW42+cmHmQp/aYO5m1CdtqaVCsf+DhNO18S9ZJMSqpxXlL9nzDZYWJR1KvVJp9rLmx7+4SE2
	jiRApPZq8v4A9nH1aTCEhOIqldaoMtYFnfcDRz22V4MXiX+cgwyQwJztVTl8Mi9AHDe5BoDlaAI
	h+54Xd0oMnfB95zAKSsv+R1JJ6SBt5yCyQEzgwWh+Crj9aiMUCSTC+0otM2RmN2sCAEPQwp/Qsz
	Mg95Qp7HXFCV54rUghmR6LUh/XzkZspY6Rbgas5RP7FMUrLny+hDaX/MkxSCmDLm7ECgdZu6GDF
	Zp+xWan27j0jesk
X-Received: by 2002:a05:600c:19c8:b0:4a0:2540:b46 with SMTP id 5b1f17b1804b1-4a027559795mr67180475e9.12.1790955929334;
        Fri, 02 Oct 2026 08:45:29 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:28 -0700 (PDT)
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
Subject: [PATCH 17/18 v2] energy model: Remove unused em_cpu_energy()
Date: Fri,  2 Oct 2026 17:44:14 +0200
Message-ID: <20261002154415.2270586-18-vincent.guittot@linaro.org>
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

Remove the unused function em_cpu_energy()

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h | 97 ------------------------------------
 1 file changed, 97 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 89cf109cbca6..c4f9558b58d1 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -244,97 +244,6 @@ em_pd_get_previous_state(struct em_perf_state *table,
 	return -1;
 }
 
-/**
- * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
- *		performance domain
- * @pd		: performance domain for which energy has to be estimated
- * @max_util	: highest utilization among CPUs of the domain
- * @sum_util	: sum of the utilization of all CPUs in the domain
- * @allowed_cpu_cap	: maximum allowed CPU capacity for the @pd, which
- *			  might reflect reduced frequency (due to thermal)
- *
- * This function must be used only for CPU devices. There is no validation,
- * i.e. if the EM is a CPU type and has cpumask allocated. It is called from
- * the scheduler code quite frequently and that is why there is not checks.
- *
- * Return: the sum of the energy consumed by the CPUs of the domain assuming
- * a capacity state satisfying the max utilization of the domain.
- */
-static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
-				unsigned long max_util, unsigned long sum_util,
-				unsigned long allowed_cpu_cap)
-{
-	struct em_perf_table *em_table;
-	struct em_perf_state *ps;
-	int i;
-
-	lockdep_assert(rcu_read_lock_any_held());
-
-	if (!sum_util)
-		return 0;
-
-	/*
-	 * In order to predict the performance state, map the utilization of
-	 * the most utilized CPU of the performance domain to a requested
-	 * performance, like schedutil. Take also into account that the real
-	 * performance might be set lower (due to thermal capping). Thus, clamp
-	 * max utilization to the allowed CPU capacity before calculating
-	 * effective performance.
-	 */
-	max_util = min(max_util, allowed_cpu_cap);
-
-	/*
-	 * Find the lowest performance state of the Energy Model above the
-	 * requested performance.
-	 */
-	em_table = rcu_dereference_all(pd->em_table);
-	i = em_pd_get_efficient_state(em_table->state, pd, max_util);
-	ps = &em_table->state[i];
-
-	/*
-	 * The performance (capacity) of a CPU in the domain at the performance
-	 * state (ps) can be computed as:
-	 *
-	 *                     ps->freq * scale_cpu
-	 *   ps->performance = --------------------                  (1)
-	 *                         cpu_max_freq
-	 *
-	 * So, ignoring the costs of idle states (which are not available in
-	 * the EM), the energy consumed by this CPU at that performance state
-	 * is estimated as:
-	 *
-	 *             ps->power * cpu_util
-	 *   cpu_nrg = --------------------                          (2)
-	 *               ps->performance
-	 *
-	 * since 'cpu_util / ps->performance' represents its percentage of busy
-	 * time.
-	 *
-	 *   NOTE: Although the result of this computation actually is in
-	 *         units of power, it can be manipulated as an energy value
-	 *         over a scheduling period, since it is assumed to be
-	 *         constant during that interval.
-	 *
-	 * By injecting (1) in (2), 'cpu_nrg' can be re-expressed as a product
-	 * of two terms:
-	 *
-	 *             ps->power * cpu_max_freq
-	 *   cpu_nrg = ------------------------ * cpu_util           (3)
-	 *               ps->freq * scale_cpu
-	 *
-	 * The first term is static, and is stored in the em_perf_state struct
-	 * as 'ps->cost'.
-	 *
-	 * Since all CPUs of the domain have the same micro-architecture, they
-	 * share the same 'ps->cost', and the same CPU capacity. Hence, the
-	 * total energy of the domain (which is the simple sum of the energy of
-	 * all of its CPUs) can be factorized as:
-	 *
-	 *   pd_nrg = ps->cost * \Sum cpu_util                       (4)
-	 */
-	return ps->cost * sum_util;
-}
-
 /**
  * em_pd_nr_perf_states() - Get the number of performance states of a perf.
  *				domain
@@ -407,12 +316,6 @@ em_pd_get_previous_state(struct em_perf_state *table,
 {
 	return -1;
 }
-static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
-			unsigned long max_util, unsigned long sum_util,
-			unsigned long allowed_cpu_cap)
-{
-	return 0;
-}
 static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 {
 	return 0;
-- 
2.53.0

