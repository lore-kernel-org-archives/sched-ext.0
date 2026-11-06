Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978426;
	b=KFDYNhUtNnyQFPRzDvnS69DGissmH8HI0Abrxu/yw5ZXn5sbPAJT09+ES/i1dCLyMKCV
	 vcZTPcj7pg2hiNk7VSlJJM7lL+iE90/9Ji29V/xsmqRnc2RI0JXvLmt64hzllqnn1d4yF
	 i0sasP7ZAHD/CpepWP1XgFQ8gM4hV/SoFpPRlPxecvVsppdx4jcGHckaIYAPyNZU8jvDz
	 DgFokAqCp4krKLeSpFgHfyY2RMtRZ0y0SmPAUHkyrgtTWkN6RL3T8YVAOsaQuxZSTpDtu
	 4Fc0dcltgR4DQrBvKm1+INK8S6RKXeyOu+Eq3e/82X84uXavuaPs522VBGDDDRETBvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1AczkvEVMwyiADmz9Aen/RP9scTy6HPzxTwLuS0NkCE=;
	b=BmR3eYN/Iis/ZxrkNuQaWY0bifnaRtznkloDhZGa889Wpw7qKkbQFS7yauUx9auCIL8a
	 Hk3oXjqnNaytEz5xu18Gl85GPzP5ZL2vdlugsKBMe5Mi+s9eeccWfv1I8H0YV1q8yQJmU
	 B0tKh1kwmvgJxYeFg5NMjMIcui4E5Ad15feiJeUNFSbM7lVEQtNduPu+F0Ld6+N9X59dF
	 B3WU8B3KXMgFJjuX0x8Ayy0US99C7L1PCc69glRoZ8H7SvJTeFT6DIDkCGREudWPnqNz1
	 2OeEQV7JM0zCSts95z04GDwK9YQ/XcDgJAK+Rtur+NIpcINqFN60BnnuZPmYlyCJJvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ljjSP44y;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346D6083634
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E346D6083634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ljjSP44y
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso6432605e9.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978423; x=1794583223; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1AczkvEVMwyiADmz9Aen/RP9scTy6HPzxTwLuS0NkCE=;
        b=ljjSP44yd4ZmyZ+JsXhILBGCjfM28D9x8loRBLa6tlOFsRIiTKy7Yr3Pf78zrXN3MF
         4QAAx0fS5b2yiZnGFy1da8wPkw5CQqHDs0RiQhSeYq3orXW9tUaqPqh9kbMDNvg45390
         Pipz27g6SAoUzaEVkwZ5Pjeepb4lMkpyK9s+QErPI6akVPL4FEa/tjsLa8xZxqSK8tBa
         +Pz+sMcfOeFNgWiOAhU7kC0xfPy/qH7lh2SKrgj7nuoZ1vK1RRXbIqB9O+7C+ntrkXQ7
         ruFthPc2UN9ntmT7A7AASONhW2gQJi41bV6pJzqhTxdj04TvsQ8HGw1gzFY47Ie77riZ
         3HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978423; x=1794583223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1AczkvEVMwyiADmz9Aen/RP9scTy6HPzxTwLuS0NkCE=;
        b=e//kVtMVCCb3n1msgVLQoVp93qzYw5T2soDJX1IYP4YTszE5xKx3E03ueUrL9gTyV0
         I2w3wPT16bqvtDIaZSRurcllFeZkozVnBuxyoaoKpAXFpbePgBlg6LpRDoVnEfkb/m3E
         zeErN2PEb+TVxnOZHEpFczq8jUEx9Vjw52d0egyYvbiNAjcozpFv9IctANoDHehp3BZO
         Am/1br0En68JRP1PSRHd6IT/RkT1z3fKw5HBqKkY/2xa7MeP9Pipp9b+TibHrtoDgiWj
         9Ena+nYqM6F9lh41RU8Z4ECA0Nnvx33oQEfWNGqH4ee7kfip/L5uecFatCp0w6te+e0L
         mXvw==
X-Forwarded-Encrypted: i=1; AKwUvBzJ7I/FVciUEkx9rALXxXGeGYMDt7kHynHk/zjUIkR1KB+iFnM9oo3GV1mZlW15pt+gn1AQAtTttDc=@lists.linux.dev
X-Gm-Message-State: APuU4Z8XqJ0kXua40wjehfPG+PxhkOSMubVkmp9nH92AVs+rtVfuN5Gi
	1Cmu64xZ68Odh4sNOnBcNsfpl4+/T+seDpShtY0gUA1M6P9JS369+pux1h+4IRjBycw=
X-Gm-Gg: AYBFou3V3sIIrwRFeOGjDkeq9uBh1uCyJpBt6w50cEdHsVxSxbfp+rDh/2eFViV48+U
	qq8I9nv2ypEa+0NMM4fWPHSqLk7e8xoat99IcEzkUGjQFpw2GO5PsHKKHsI0tscpZ3Wdw5+Xf8f
	qCD72oiaeqQhMtjKn6cnpDfTmLk2GV4+usaqZgonTb8u9QC3HOx2W6a244VLsy8TGr9lI/f65/u
	cgrFERJasCOxR/d0omVIblghYs5GwP3EAjNNHS6TA4I0qvcjn6ijYeXW1wR3PZ5g2Dm4OCGvfBL
	zhIQ3sjg0Oc60id/NJcMj2EpsqxrIRJEygdXp9VbLYhw0qhXt2pNzRnvyjsEZzPWOUx4ghJcMgv
	ckwiNE+aF/oluaA1BEOx+lLHiWSl9KdnR+tbWP+FXvpg8ff31wBiIOT946eB1UmHXFBIyzZa+LJ
	sHGwcsXONfjgQTJofuAQm+5v3TeWAEE/0E5ZBs1oxjsV1GvDwTheNET/QsP6Z+2k6dYXnMH6H2C
	pYwKobhBFUSQluF1+07WaHIlE8nCzs7hC1pWirGwQ0M0bPua2YQixjrOFm3Bnomu5TFZeqbrQXW
	/zQYOdT6jhokdWWnVDoCH8aeQPLB20McJearMktg4qjeB8Tkdmg50QH+CYmqBVc97uxj
X-Received: by 2002:a05:600c:c491:b0:4a4:de70:2ad4 with SMTP id 5b1f17b1804b1-4b6dff83dc4mr53929695e9.22.1793978423274;
        Fri, 06 Nov 2026 07:20:23 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:22 -0800 (PST)
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
Subject: [PATCH 18/20 v3] energy model: Remove unused em_cpu_energy()
Date: Fri,  6 Nov 2026 16:19:45 +0100
Message-ID: <20261106151947.3991524-19-vincent.guittot@linaro.org>
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

