Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978422;
	b=2Ly/BvTIDF9qN7vQtCnyJZNHGgBVcauRinVoaG2cWR73iA6+XHl+o3bSo30o2kbR93EO
	 GFypE+eVRwXfyEYTWEhqU1cLJhKLwQWk0UHSbwq+Lum5LTz4hg35/pfspNKUzccXBviWT
	 qliiuMhmQVTvwFTIYzn+Nh0ZHCR9yX1Q+g7G5F71MNka/dynkmbo7rLapyl86HQ1bJ3Oo
	 sC03VxSSDs+1OIrBW0RbaVA/sN+XziDTPs3BwgWhXV/NEDjXPm8eV7VTiUEQHZ4MzLVgd
	 w1EjSuJopGJGnfxex+zi4K58gzJdOV1s0YAOXuL778Sisf7Rqou9gM7mxYwY7aGV/2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WkE6gJnDRs+XLmAou5XPy/YO7fax7WUEGWY0OkDdt7Y=;
	b=4h6CClmQU+8UCSPcr3hiRglU0mBtEJT/Lu7afQWSlrNN7DQ183qgm8PURXZakuxaO3Yd
	 Tbz9KIZQ9GlwNB0y0c7tyFcF9TtQvs26n8Pgw+pdGMK/Q0jXd4C4I0OdWKbVCZ2/W/d/2
	 NCyM4mdgpkiAdvuXBh9eyYE72A7O9aiVz/EDGz8/qDmK7/uM5DcGcB8E/IJm2O8xppoOX
	 xlW6Cz/QDDdPnk8BmRsy7oW583TeolEsFDjzfEUEYtZMvurDYXY7XKe5sk3a3yE+HPCB0
	 DlzEKxZp2Ogdo/rLNH6vJ+Gp+6+rf5Xw5a8MmpcRBb7lFJjZXe3vebklDVZuesScSRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="IaZtV/GR";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D03606D828
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D03606D828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IaZtV/GR
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e3b22e971so423748f8f.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978420; x=1794583220; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkE6gJnDRs+XLmAou5XPy/YO7fax7WUEGWY0OkDdt7Y=;
        b=IaZtV/GRAvofKMcTK7+gh2O1hL96snF3xaQoUymv7d47bPNy46WRaULd4QK6u3nluU
         gvaUmFyiKAKVJj2mJdZlhuPlaGu3Smk0DM5yqPVCdS8zNXjVbNRRDcouvoj97bFzj1ZH
         +7urqEWateiOY/8WWJLW9ufzfZt7swDZNAFBMGD+fiFFgziQ2fq+GaIpd8xYmkFVrPzW
         9m5SCB64ZEGIEqsnJJoMwGtrfAHqVVZVGa9p2HZI2hB0ATXx+cm2tuMojbfF66yGYKXu
         PFadhuqw/Pu41IPYZZU5fTG+C0Dt/lWd+ltIZ04zRHGQaVUEoTuLyysGYbxrKNW+3+V4
         3rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978420; x=1794583220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WkE6gJnDRs+XLmAou5XPy/YO7fax7WUEGWY0OkDdt7Y=;
        b=UdVkXf3otzv5/Hys1fo8LyMTHmf628q+4zQwEinIQ64b2zllJEanX6JB+MGuA4kyAQ
         FsfUQix7uG91xrcCfrr3IoHEjdkug1LFuEqJd7iToo7Cp9lwc+8ThlsNOMp7QPmOKBBk
         aC+mR7PkishXdD16BCtJ6dAvP4NiDsxt5ZUKiO6pHCnQDVVE41oSBwLEc3la8wYO66kL
         t8qoaADc2+oBpPjt0IbCYzVFxZaDka3lSk+jX8jjCkMAoAStktbhdbgCIImDVy8WU85B
         h6rlmwb6XSDQZwwHrrXpo8Lr/ZjGroa38nnpWA/+lP57yqVRLbF+S6woRfbbV6XHnakn
         xopg==
X-Forwarded-Encrypted: i=1; AL+hErHfo15ihsAzJgp5KbzgnXiwQuH6jPtd0ZBH8O8doMe5VXR9YbxxXuuenom1sSxQshNq7XnP0HaXsvA=@lists.linux.dev
X-Gm-Message-State: APuU4Z/QPvrE47SV13ykpYsGdnmZ6yDhlQ3NOIfxEUNIV4RW4ktwx0Pj
	Gzm5MJtmF7gOoWOkm8Twrini8cD6ipzkrKgGUpVx3n0IWq+weVCDU7z147uTHM90tO0=
X-Gm-Gg: AYBFou3MIFOTVfvrQBzZvJJYG3tt0Rm8n3Y221iVgSpfqFv8zou8e8H7gsKn/nIeFOZ
	kgx2IT6wosL42r1eCxG++rhBTKm05yYsYjsQ41h2oRz6gKzr8MtOa8Jo6MkhyygUtUMBHaVTbKu
	xF28kKvdNFoccVDBBiVugLZIG9+oQ6oqKHhPuuXBQnUs5S0kDthgC4Luf4RDIvtCaN2uMgZUYg4
	kvPZ3C7zLz+esSh0HAIOpqs/+bvMKlkDeqO7lkL1kSQyNrBk8edN8l0PlT8ZjEFF9x+rFXoUMHT
	RiJRVEO4UmpRE6VRBuWctMvyx7+0gyI32RMWbRgy8CvJtpwFm2qu5O0wN4s3hFENsTYQDTYp8qv
	aginXtyGwYd95y+Uak+wBA9v59ZJ1n+v+exsxIZD5XN9XlwYEPoe3jw7DmlVUB2hy2CguQ3rzio
	/B+n8Jb7PGOYxTGOny/t4ujBZ91gSwszkxHfvmfw+NlA3hxnIWiFGPNNXkXcMzhF2Cs7tixyh+k
	sYdh9zusqK5wwgO7e9Lo03ex+12BPczQlCIZX77aDAvVmFHVY6ng5sN9ZpFsFoQ3obJMP2m+b7o
	ZQQ6U15cqcTkvChlC5qowLQ4cKU73Rmc
X-Received: by 2002:a5d:5f86:0:b0:491:fd47:5df3 with SMTP id ffacd0b85a97d-49272a3aef0mr6257082f8f.7.1793978419738;
        Fri, 06 Nov 2026 07:20:19 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:18 -0800 (PST)
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
Subject: [PATCH 16/20 v3] energy model: Add a get previous state function
Date: Fri,  6 Nov 2026 16:19:43 +0100
Message-ID: <20261106151947.3991524-17-vincent.guittot@linaro.org>
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

