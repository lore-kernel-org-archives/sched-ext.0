Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978420;
	b=JZLmQ5P8+LRQUQ2WtdeuDWUDu2P+4+10jcV+YSok2bcO1VlDXUh6TSlTW4dhJ7DVZz4E
	 EcJ3wGSXyiLQpZ66Zgc9WWHXd7xe0LTkvUy+19MTleGRUK5uq4V6A3ji5CdgLmBBaU18x
	 pVLQrzTg4uvQCAL8PmdxQ6pdp2s6V2/IocG/ubjYPvC0usvX31FCijo0iohwDjQP/2EM2
	 iZfp6+8SWZ1Cbwk/Xo8gXGb1WLD9/6oDQ3LMY8YGrJMlSBIhDkklXhFwY3h8n0Ro5TB9S
	 kfGk0eAe7AW74zlf2iAuspiZf967ywxJP7n+U44jB4EKVp8A2QxLFAVrFYB2vXPvdEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tX9HEYRWehVYzSumdU6wnzHc9q5GXalqxT96ZBMgpCY=;
	b=m0+DeLHJ8XXBykquG1zMocBOvYYV6vNehBEKVKr3rckKxUvNKRrj3xDTpNz2clZfSQSZ
	 A9RISeL2gqiMi5yUseEcTKBaUrFfRRSqcD2dYTNkNj0vNryWU+BGvjHUFY15gSnV2qq9z
	 OC0dETobhT9J6es0Qz3TOMXlmxpCb2WnwSEeSxfjKUL4L3MebdbvQ494uK4VZ2zdcidwL
	 HaGT/WKVmXxvQ+ZdgeRvhXBX0AsAW+tm1/+KtPxSc6aJcKZuZ/GgR1FyAEk1haYlneg5U
	 Jo0Xp9thEoVS1DhSP5FCaIYhn+WSTwT6i857gcdumWFMuDNz8fw+b10YzFE38NgxFgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PkOiyr3u;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A07606EE93
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97A07606EE93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PkOiyr3u
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so830739f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978418; x=1794583218; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tX9HEYRWehVYzSumdU6wnzHc9q5GXalqxT96ZBMgpCY=;
        b=PkOiyr3uTe/PTM+LgmJw+JlPFYCvXrsl+RNcxdsQDoRGwaJLZvJdbRVUeBtcXMKdM/
         U9t6uxwFXtGbNN6RFSrAIlxniAlH5KUUtYogbKYgGoNlZplcJfpmnb6hY6XrmRwROku0
         E6+bhPqolf4AepDzWYjdsgpY9s/0mf3EUJ/4vwFZECTCBGiA+OzUn7CHgoky8G4VkV0z
         7BaZDslDUheyoflcTXlqCMRjOTGPcd5E0wAkm5gSHXP29LTOuBWX+11C0u+h1jCaOqto
         gntPL1qI17nFVdTjjHMsKD42Rk3BwP1U2Fq4qYhbVO+TTGqFsrYBYSOewQg/ViLd48Zw
         u3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978418; x=1794583218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tX9HEYRWehVYzSumdU6wnzHc9q5GXalqxT96ZBMgpCY=;
        b=CYm96rmuzc+oVSp/haRdHb8cr7KAcKW7c9s6XDFtEdkkHh4oX209UiYOCze/FXDHcx
         TBEivQHyboP17s0/jbjQLr4bLtvD6DMebXslK3wpqFvRtwX5wdbc7TmkYZxV5s0IINj1
         JfpbmCi/RF8LoivlGVcNs2uTnX9xYJS4gyuE1MNepu6CLAtuzHbevNu3LJZte6oHJaNq
         co+81ohq5pl4Sx1x/Guv9sNt/pPQDA4RMNWFESthNzt0Ya7uKPxIMKvW/54U5EBxZpjT
         FSsLHX7bxbGIuT3ZzUitwnM5uAfuie2Y+IDy7+oTsIAYttRNkmY1bDTaCQI91hebXRMq
         yavQ==
X-Forwarded-Encrypted: i=1; AL+hErHuRxkqa/e8vtRFF9hF5JCjMpRX2vIt2D6xYb4bSpltXRopcOoyY4TCj2+Uu1n65tSGR3ww3rEGoG8=@lists.linux.dev
X-Gm-Message-State: APuU4Z/XILU56KbhPHfqbX4SRJvpDfDKb32JSDtTcKdMlXKwcW2FHItO
	cLzxE8dn27x+CQbU0GIq2XqHqwFJoZUTufW5Mp+v0FDDbl9/JV+3of3dm1D0EK1ee/8=
X-Gm-Gg: AYBFou2VRhbq7TtRzAuKnp0+tiIXRe65K3XuQLFb0nyx5FfOxWG6JP8qcLcn0Rfuall
	UzujXc3kTT5vgGZnfOOeG8go/gA0+dZ7hDqwlvIMr9DKhCuD3wp6996sE5nmicUz2Eh045BaDnR
	yg0U4OYSbX8z4Fon597p/dBjCYq295lCHafHAodeajx9QHjir9hbAUebnW8+y6nL0lgMDPC2OON
	h3jZvbUARRQd5P8dbDzmYJzlDAnKxKzbA3Uvm1pNvTjUfZB8tdc2Ibz/Nw0iGWgh63G18KKEQ1M
	R8ctRLZQcziyFJKYHq/zMmhg+5JdBhhTxqOIh2WWCcCC32Nf//PfPYDkQltUPT4EONaPy3b+fBM
	9Bngpj+bpDzGwbtt7UMYiky2jaeOlnzttg7xZrmKR3KER1ztW/lCHU+WVnGvDtijdUdyZCvAPom
	XyjqhBUGQzw8u1iaCkj7x1d83VouyAmLHAGX9I4Qf+RKZ3wI5pqew4lGmIbggbxdt/XZ92eOGWZ
	TlMKty1jSB0kRA3Hm9E5ZGVZm79ZY//U0RKlkvXe4/xaJekIuuwlcRzCN46X6/lRqIublB+KOm0
	t4+4kl8h1z78/qfcZA1Gra6ek1RjELOBRSDkMsAaIMAqzlwg
X-Received: by 2002:a05:6000:2893:b0:48f:f26d:c5c with SMTP id ffacd0b85a97d-492761d00cdmr6320952f8f.9.1793978418032;
        Fri, 06 Nov 2026 07:20:18 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:17 -0800 (PST)
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
Subject: [PATCH 15/20 v3] sched/fair: Enable push task for preempt short
Date: Fri,  6 Nov 2026 16:19:42 +0100
Message-ID: <20261106151947.3991524-16-vincent.guittot@linaro.org>
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

Enable push mecanism for the preempt short feature which is the
1st feature using it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 919d0fb00bd9..5481f2472e17 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -3497,6 +3497,9 @@ static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new
 	sched_energy_set(has_eas);
 #endif
 
+	if (sched_feat(PREEMPT_SHORT) && !static_branch_likely(&sched_push_task))
+		static_branch_enable_cpuslocked(&sched_push_task);
+
 	/* Remember the new sched domains: */
 	if (doms_cur != &fallback_doms)
 		free_sched_domains(doms_cur, ndoms_cur);
-- 
2.53.0

