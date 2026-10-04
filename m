Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D33FFFA7
	for <sched-ext@lists.linux.dev>; Sun,  4 Oct 2026 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791141505; cv=none; b=AcPCZ32M3xK9ma7WWd2+PJZHiExWQslmaAhfgzWcv49hO4+PU3bbFgQcbH+FuRclwvgiYsALvswx7qvHT3EgcHEAcVEmxj7xrWL5wvEZmE2JZ+0Hpuv/DaFNsFNc3ODIl3XV7UJDGb8LLooapOBXBFDMEDW3IYZ8Zi+ToYixDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791141505; c=relaxed/simple;
	bh=cxqvPvmP5LEKCuOrQcNT+FDABIRF0pkCGT0tYhdiTXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVmubkHB2VvglQoUWaF1+X+EjkXsvpM4XncA+XFnSNHKY6rbJl13c1UidKnCw9OICNIvEe1YqiI8v7fjbUiZLlsHgkU/anCPKq3f9dn2qNjgtAgcbgABoCrcqftn609L6tGxSlKsCyCTvNdXcDGGRmlsmBTtjzxXNui6S+N8JKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNg805p8; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNg805p8"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afe625404so140121f8f.1
        for <sched-ext@lists.linux.dev>; Sun, 04 Oct 2026 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791141501; x=1791746301; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPTMVIIAJFn9U/eu7HQEBuEphGxHwxWPSlT9dvO4lqU=;
        b=sNg805p8h8VJkGeYrwFn7tZnmTWuLYCBfXSKLfir0mG/cyy3I1F8RkSB93aK2a3gpP
         2KFw2BQabzQb5YW0CXG3CpqwhpWAYmAkwJgfFSTtuQTf670MstKbzQB6pdhxbIsdVpmE
         pF3T7JHVM1Caki5DJPopN+dDpOKEm7s1GyWIkE867a6rLakOz9WpqllMN639AspZNaT8
         Nwz4zoMaM+SUWycqEvTFI5EGJtLrjYXFAnLyYEtYh1msbhYoBgte7ItKoJwXNVgPVS0e
         14Zm4jfKzgZxAd1QIByijFjmRBD5HzSnaWBVU+WSwwfu3NtTLA9oEEGRMOzem1mfXecy
         Soog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791141501; x=1791746301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cPTMVIIAJFn9U/eu7HQEBuEphGxHwxWPSlT9dvO4lqU=;
        b=efWpE6o70/ZPMLw6gzjt6E8Sy8v2an8kNxrZMttIwww4XIP2IzuEDz+V0hbM5gIUCx
         XrTOCkuqszW73jAPGh0KjIhUknEof68G4NPh+bmWtCi2KW0xhH35jU44d1i4ZU4TZMN9
         XaAagJ7Lyaar+K5PiBB39ykIxJ227Pmrht7ET9PkWH05zUtsKDYDnjDThCFjpEiJGg7h
         OL1In/w52UJ8S/p36nJlGTt37ybp+3e4NHU1mRsmfoR+SdK2ljE09/qqffTb9aSb4VkE
         dKHBtda5dJIyH7sHoNsmnzw0/1mzwzo4JNyxFdumxgUghMLMEAnrVmMvPogkWwpXZ8bv
         F7Ig==
X-Forwarded-Encrypted: i=1; AKwUvBxuinONgeToJkvtqhkdFgFUxeJ4wbj9eBUFvE9Ib5A6q92EIJbIs5XCV2gTT2tpRuwqUvUFb0v5U4A=@lists.linux.dev
X-Gm-Message-State: AFuF++lze7nbTl5KiOHCHW7s2DTUnbvZwtcrovdlrJCNlkF93f7/sBu/
	tU1SP+etRCxR9P0IbKjEF1bkKDR9GNsss1eGW8P4f/WyxxBfP/RIAUGp6twy5Q==
X-Gm-Gg: AYBFou2XHkuMXvD6/KfqlkPYq1HpYbnY5OY/5DdlpVwa3PqjjF158jsLkxKOFOiGrrW
	wSobmbFT2k/R9YYmwoXdvFf6AVypePY9Se4M040yDX/60UkfOwdYkQQxasiycEJRlUBW7y+Pe/J
	pEfUM+isSC8z8iVCaoO8dIw+xw2IQZLxBt0s/qy88QAmHDlG0y1t1v1PgAMK8g6yKN03c0xpbNz
	FsHuylVAe6wAr4CKA8fG/RdznO5c7XBhCwLZxQYw0iF2FyS/7qDpjvVYuM9c2zNTjEWm1xBSoYi
	Gbi5DSbSLv0WBlIOxHypCVssN0jTjBEdR1BlFXFHbtH2yj0rEqEEYZicnHo7xmOtIwOxZhW5cBq
	MErOE3Kr3Q/ixVLwBK5lJHH5ra528ZZChhJcER4QlebhOSYxXTRp0nr+F1UnxDaZvUL0060xWOe
	e1sJQNT4hI5PTyMG+mye2CCeXG2fbZHrsd7hduDq6zHw0w82R/RGOIOMUhD4RGvjaVHzqSwsDyG
	WdHNm787Yc38iUxVAaM
X-Received: by 2002:a05:600c:46d5:b0:4a0:1ca8:70e2 with SMTP id 5b1f17b1804b1-4a02751fa7fmr143583805e9.1.1791141501458;
        Sun, 04 Oct 2026 12:18:21 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0276fa954sm279357515e9.3.2026.10.04.12.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 12:18:21 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: vincent.guittot@linaro.org
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qyousef@layalina.io,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	sshegde@linux.ibm.com,
	tj@kernel.org,
	void@manifault.com,
	vschneid@redhat.com
Subject: Re: [PATCH 05/18 v2] sched/eevdf: Add min slice check when selecting CPU
Date: Sun,  4 Oct 2026 22:18:17 +0300
Message-ID: <20261004191817.20225-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-6-vincent.guittot@linaro.org>
References: <20261002154415.2270586-6-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new level for selecting CPU when select_task_rq_fair() fails to find
an idle CPU. This last level will compare the slice to select a CPU where
the task could run 1st.
This helps a waking task to select a CPU where a longer slice runs
instead of one where a task with the same or shorter slice already run.

There's a typo. 'run'

> @@ -8771,10 +8771,11 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
>   * average idle time for this rq (as found in rq->avg_idle).
>   */
> -static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
> +static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int *best)
>  {
>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
> -	int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +	int i, cpu, idle_cpu = -1, slice_cpu = -1, target = *best, nr = INT_MAX;
> +	unsigned long task_slice;
>  
>  	if (sched_feat(SIS_UTIL) && sd->shared) {
>  		/*
> @@ -8795,6 +8796,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  	if (!cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr))
>  		return -1;
>  
> +	task_slice = p->se.slice;
> +
>  	if (static_branch_unlikely(&sched_cluster_active)) {
>  		struct sched_group *sg = sd->groups;
>  
> @@ -8814,6 +8817,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  					if ((unsigned int)idle_cpu < nr_cpumask_bits)
>  						return idle_cpu;
>  				}
> +
> +				if (slice_cpu == -1 &&
> +				    task_slice < get_rq_min_slice(cpu_rq(cpu)))
> +					slice_cpu = cpu;
>  			}
>  			cpumask_andnot(cpus, cpus, sched_group_span(sg));
>  		}
> @@ -8832,11 +8839,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
>  				break;
>  		}
> +
> +		if (slice_cpu == -1 &&
> +		    task_slice < get_rq_min_slice(cpu_rq(cpu)))
> +			slice_cpu = cpu;
>  	}
>  
>  	if (has_idle_core)
>  		set_idle_cores(target, false);
>  
> +	if (slice_cpu != -1)
> +		*best = slice_cpu;
> +
>  	return idle_cpu;
>  }


Also,

Scene:

Let's say that in our domain there are 8 CPU's and has_idle_core is false. And nr equals 4.
And sched_cluster_active is true. select_idle_cpu() enters the for_each_cpu_wrap block
and the else branch. Because nr decrases each time, and if there are not any idle_cpu's
even if we found any slice_cpu it's not set to best. We just leave the loop after checking 3 CPU's.

The same thing a bit differently happens below on the main loop too.

But I don't think is more important than typos. Typos is the reason we're here. They are the or nevermind.
This is a joke btw. (that, destroyed my masterpiece and created a new one. Saying a joke is a joke because it is,
is one thing while saying a joke is a joke as a joke is one thing. I wanna go on with this but it'll be to long. :<)

I could be getting something wrong tho. (No one is perfect, but I'm not perfect at all so ya know.)

Thanks,
Kayra
