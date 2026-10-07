Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8237F318
	for <sched-ext@lists.linux.dev>; Wed,  7 Oct 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383785; cv=none; b=nvUpPGBUo1NYwFTscIsOh0k6gMPj80WvKqsiVo/x8apjnK5ZL6xjkh/m59IfAqqQWFt2fQgl0eU43CmSHJdvFWRz8rGGfjNVjzQ1SbN4gJJxPQyBzZX1L1S1PmKcxlxLsxfignxjzDBldKfW2Q73RNZrh6Z/D9/Bmj/rnIlfPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383785; c=relaxed/simple;
	bh=QWObiRcI8iK0yCBnTv4yWqzm10A+0RXDZ+Svr6rN6ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9dWy9AM97YLm7QHSOkftlCsnZRSYDd+S/9xQBQi4Lp1XNZEjzDGgG3P2oTa6VjkXpH5L2UJhFZArgyHWdPJbYzAwBP+5tiKZsVRyczHOmCpQN+eXqj4oa7K9bk0JtDtdHkGo2YaOyfzBEFfsPR+JDTuqt9iqxRXDHGFVXOPRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSHdWOmD; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSHdWOmD"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b0db12041so408456f8f.0
        for <sched-ext@lists.linux.dev>; Wed, 07 Oct 2026 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791383778; x=1791988578; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmqGbiXwpu78fwTCvPVzxN5FL6dMSRh2h6ri1F2bfkI=;
        b=BSHdWOmDGRuMGs+mQqR7kZOX76O17phpbr1gFBaFVeApplfS036hG0kjcRAR9F4rW8
         6sdwErMCRKeXN6BjlQyA++bTGojUEEiIom9nc51vjDB8a8sld/YvzqG4SXnvk91ZM3Kp
         UgCvZAczS19naBaIaPZ8Gvn3R62a2q+mpzUVnpnqh+kCS5pkCfe8pzoM0qobacZMJ7Gs
         LfM9Lf4A6QyhtGio3RcYZ6P7eHAGTQrtdIBR/vgMpt6SBiFkxAVjQmxTNB9epVeHLXgo
         3ODv6ICblmoQkjhhR9A0y9vBfaZbjR+c3Fl0aimSXPg0zEHxBT97mH93bmx9xs6Fz+AU
         wR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791383778; x=1791988578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AmqGbiXwpu78fwTCvPVzxN5FL6dMSRh2h6ri1F2bfkI=;
        b=hQ+bLtVCFfNRpeolSxZr8DsjAXnxX4O2UjfK3VKEJJAQ7KVB5FOWb17cbfZfEzVucD
         DMvOnJKaxJp3a49F64DPT09bvdSCEro1lPN/v3hS5j3QN6Q+GwrfiNyF+ZQu539SxfYH
         tUy311SUt7MAOV2Vn67UaRgf0ydDY5tMlyGEu8AVyuNbGc7sroA0BSJTIO9bnArKCwUP
         5vkjffcSi/AqOgnwn0VaXj6lAdZYZwITWRgpe4N6WE9SOCFtWgAvSqsv6l4QDW0y5ZDB
         Neno4943osIpKUAD5khLfX8+1RxQbfopGuQd7QKHWOXHZ2Y/jV8YZHl2Hm3pB0Yn5mMo
         obkw==
X-Forwarded-Encrypted: i=1; AKwUvBwCc3G0hoKHXdobrwHi8OKk1klzmqytw6uB7zBiQf8TNfhzQPnUZoFRAcJkYpr98xTmWUq/oeS81nI=@lists.linux.dev
X-Gm-Message-State: AFq9FYKY1nt/1aZpqN4c1ptScwgGjLa0GeLXt/oVYMjccQGbojNSc0WL
	fv2TQ1b/wOknluk1MVSaroMNwvW+TDJGojSC6r+DUVyFn4b7eKCOicNl
X-Gm-Gg: AYBFou2RBKflbog+IPBTLTO1Efqq9jG3IIye4D/+n9UDWhG5j1wKWn2imysWYyQmoPS
	M7mKFfIdMvelbVifQzW/uVXRxxwHYAZtWIfmYt1dFva9dOaIm/FdhxpwoFT1pYIJcfUJqoyvyf4
	PpATkyejTg3Vsb0mVTCWOzQZ+Ze0cHXTFGuYd9SkJNLkfD62PiiOJzZkKqBs0yDEyNudxqNB8d1
	TD1Jrt8qDi/Byd1LXypL8ECyZrChS3xDM4TicH7jGJu0PRcxa4JmxgtbACZVjBWtQbWI9gRyF7w
	hpc/mNtRl3eEnbZLa67mKTkCNw9gNHKl1/KUOjqJGS1A6f6ykpwkVmsejdQTSPpQHOS1cFywoda
	VdJGIsdhy/R9kwRO03ZoX96NLrOPxYSdndUpRZcf5PnJ8ON8WemxTZvrt0bnhRx796oKg6vVu1K
	e4D/ejp7AB5JGjbWA/yRtSX/qMZ3qscQnnKnXKV6PEoh0oK0kz6nyThSR/jP7E1B2BMZ3/qnxGe
	enAykV5+JWkFbBt8/4Z
X-Received: by 2002:a05:6000:2992:20b0:48a:f41d:846 with SMTP id ffacd0b85a97d-48c7277c7eemr3689759f8f.3.1791383778341;
        Wed, 07 Oct 2026 07:36:18 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d30603sm5948935f8f.49.2026.10.07.07.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 07:36:17 -0700 (PDT)
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
Subject: Re: [PATCH 18/18 v2] sched/fair: Take into account slice in EAS
Date: Wed,  7 Oct 2026 17:36:14 +0300
Message-ID: <20261007143614.27368-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-19-vincent.guittot@linaro.org>
References: <20261002154415.2270586-19-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When the cost is the same, take into account the slice of a task to try to
> select a CPU where is will run first.

'is'? It gives 'it' vibes more of 'is' vibes... (:>)

>  static bool update_best_cpu(struct energy_cpu_stat *target,
>  			    struct energy_cpu_stat *min,
> -			    int prev, struct sched_domain *sd)
> +			    int prev, struct sched_domain *sd,
> +			    struct task_struct *p)
>  {
> +	unsigned long task_slice = p->se.slice;
> +
> +	/*  Select the one where you can run first */

Again. A typo. An extra blank. I'll normally make a joke but,
I'm tired. ;-)

> +	if (task_slice < get_rq_min_slice(cpu_rq(target->cpu)) &&
> +	    task_slice >= get_rq_min_slice(cpu_rq(min->cpu)))
> +		return true;
> +
> +	/* Favor previous CPU */
>  	if (target->cpu == prev)
>  		return true;
>  	if (min->cpu == prev)
> @@ -9762,7 +9771,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			 */
>  			if (target_perf < min_stat.min_perf)
>  				find_pd_cost(pd->em_pd, target_perf, &target_stat);
> -			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
> +			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd, p))
>  				continue;
>  
> 			/* Save the new most efficient CPU of the PD */


Also,

Scene:

On the reworked version of feec(), we have this check:

  if (p->on_rq && !p->se.sched_delayed && cpu == prev_cpu)

A little after and outside of this check, we call update_best_cpu().
Now, if this check can get true, on this state:

prev's min_slice cannot be bigger than p's task_slice.

So when target is prev the first check is always false,
and when min->cpu is prev, the second check is always true.

Also also, I have a really important issue abot the patch
series that can finish the whole patch series and end the world
itself...

The issue is...

I need to sleep.

Thanks,
Kayra


