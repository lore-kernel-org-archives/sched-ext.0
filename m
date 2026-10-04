Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE78471416
	for <sched-ext@lists.linux.dev>; Sun,  4 Oct 2026 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135041; cv=none; b=lCd1rFQ6EAH4jnAAX0M3i5u3zGYML4jQJ5QJ2RrzRXoRFOqLFnNjSNBRpsQI3FXqQG7YR1k2qSGve6fjVpJUsORkdp+LbwkZCGB+mhJt+j9lwaXlyq0stiA+QLtXPe/bPnyo1EjeKyl05ZgB0GL/W+n/wKVlOIvSjRUyFvPDIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135041; c=relaxed/simple;
	bh=WXL5LZkJrtzk9YPJU9X6JrPpHjTvu4EMRFegf6wNEUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLVYXpNMFctEbGEtqt5RhN9F+ifY3FYgKI5lhlCqPS564Y0F2YJxwHAGFPSMkPGMcrsptB9T5ThbAlwoUukGNoy1BYldD4J4XQZCfEn1SUHunYDtmCvvSJCPyn2bOVNDGvNBwfgPmcc40jo7VOSLDGwSk21gF7dOUvXVLAbwd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/q0jqY7; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/q0jqY7"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48b0f534161so118464f8f.3
        for <sched-ext@lists.linux.dev>; Sun, 04 Oct 2026 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791135037; x=1791739837; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9BNRj1cE9nvNKn/WOlSUCpAG1T6oqBgGlxlrkhv5sI=;
        b=X/q0jqY7xYZ0jUOaTOM58SoLQPe4epQslyVDQ0Hh25vyHqr5DNgaJ0NRpOo+QkbpAf
         VHx1i6dw4UaF0hchaonpOxsceQnH9Lrq0WRobaBq6EAv9WDyXNV7sG5xL9OymSKlC/6+
         WZyk7nRnoYmKjObSjFv4bh+ajFdzhI0DU/y0NKIUj7j66SRSpRp7XIZ+KVGkNqrRLjj0
         TZkQNFuLK0rliUzR6BIoNfD/eCxv8aWksVrMJLRPY58MN49ZPDDBB4BsceyH36Q2JCab
         zpomXu8gLIzqKoXvZtnyJLljEs3SLkm28hm+cfejRp57yzkmb126ndFXe1Y0TLLVCtnH
         3UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791135037; x=1791739837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K9BNRj1cE9nvNKn/WOlSUCpAG1T6oqBgGlxlrkhv5sI=;
        b=l/sEf5dUeGFtagDKI0mgwUlJZPTVNx5GjkczWlbXC/9v9ifX2qeUdqINH3iTxzcHBu
         dJkDdpE1FWfQzvMYlwgS4a4MpveY+4I6Q2lfRQpDywgLXL9ntn5Qe5bRYtIaQSKRyQpl
         welEYKlxJS5Xp7ehLpWDleqJ7son3UcMXh5ibJUegabqNcjXXBLyTzMpx/1TBkX6TWgY
         IW5I0Z9WKOxP7KEbWeTK7hKF4mj8fpbzTMjVACBeTqN0Bu1a55rj+5fgc6Z+s5VUnX9A
         KBZ6SD8RBbvV5/ogeIkBkoTXaDcd02zubFGhD3VAQ5J9Qm1Pvv9E8NUO2a+4xvvzV+rQ
         e9ew==
X-Forwarded-Encrypted: i=1; AKwUvBxR8Snxtk6QI00xPCdHcCtDlW5xVItDZqsAyQkDyzXosFCuMqsoGOH5f7F+rB/ntBQ7ZP4tX41tkcM=@lists.linux.dev
X-Gm-Message-State: AFq9FYKwQD5N4Wahj3hLie4ZXLqA0Wn1rsrHuOVRBdHFdswvwBX20q5C
	Se9J+8b7KLARe0/9+tRI9vy480LEeDR+cP3juO79EBnN89t5Q2b2oDvD
X-Gm-Gg: AYBFou1NY4a28EigKic5SMEhwgsuo+9mYPQg/c6Imh7KR5SxHBHT76bakUEfWcqui1F
	Hx5NrPGTGkKi/zhxPWEoVeFixVGsd0KxGv3yqtwtN9v9++Wx6ADE0XLwQQq2rjI0EsZLk1uBBi0
	d8yVoRPEbD7vNAG8kzqfrDXKt1iwgQ+nzlAcYjAybPA5F7IpMt8KSx0N7q636wQfdF7oeWh7YPn
	V6yt1ggI06WHeHkV/2zyYUD6/VWpLh93skKxrHCLV9BDZIC0ADoh9SIyDMRiIo+2CHqaPeqOxbl
	i4h6pcpFNFxUFtusEwAHM/SULuPisUlulVYX4Mc3W6E3LbkC290Puq4fAGO82uHbhikwVlaftma
	OWbmjf4TD5DS4gUSw78q5CJbl2p0ddDDsgt4j6Da8y+1lktR8BdWA5T5MXODKeA+EYCWPoceHJs
	IXvkCKt9KlgIgGbsJqEtcdEXB3u0vuC+aDnY39A5TG4LTPiWPUfCCg2Q5gs93oPxxoEdptL2+DJ
	PunB6wzQVS7PltfAfaUJ/ed7SDC524=
X-Received: by 2002:a05:6000:2f8a:b0:48c:4802:e253 with SMTP id ffacd0b85a97d-48c4802e368mr8983746f8f.6.1791135036570;
        Sun, 04 Oct 2026 10:30:36 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8ab4sm18299306f8f.35.2026.10.04.10.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:30:36 -0700 (PDT)
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
Subject: Re: [PATCH 02/18] sched/eevdf: Reset lag when waking up on idle cpu
Date: Sun,  4 Oct 2026 20:30:32 +0300
Message-ID: <20261004173032.18867-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-3-vincent.guittot@linaro.org>
References: <20261002154415.2270586-3-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When several tasks wake up simultaneously on an idle CPU, their final vlag
> will depend of the ordering as the first one will lose its lag but not
> the next ones.
> Reset the lag when the enqueue happens while no fair task has already been
> picked et set as the running task.

There is a typo. ('et', also 'depend' and 'loose' Not sure that's all :>) 

> As a typical example:
> CPU0 is idle
> TA with vlag 0ms and TB with vlag 5ms wake up on CPU0 simultaneously.
> Depending which grab the lock 1st the behavior will be different:
> If TA is enqueued 1st, TB will be enqueued with a positive lag and will
> be picked 1st.
> But if TB is enqueued 1st, it will loose its positive vlag and both TA and
> TB will have 0 vlag when fair will pick a task.

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d7cc77181ef9..32d7077ef148 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -592,6 +592,7 @@ struct sched_entity {
>  	u64				vruntime;
>  	/* Approximated virtual lag: */
>  	s64				vlag;
> +	u32				vlag_seq;
>  	/* 'Protected' deadline, to give out minimum quantums: */
>  	u64				vprot;
>  	u64				slice;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8cda1d39b037..4c8f12fc8869 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -893,6 +893,7 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  			vlag = min(vlag, 0);
>  	}
>  	se->vlag = vlag;
> +	se->vlag_seq = cfs_rq->idle_seq;
>  
>  	return avruntime - vlag != se->vruntime;
>  }
> @@ -914,9 +915,22 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  
>  	rq = rq_of(cfs_rq);
>  
> +	/* You can't claim any lag when waking on idle CPU */
> +	if (rq->curr == rq->idle) {
> +		se->vlag = 0;
> +		return;
> +	}
> +
> +	/* Accessing remote rq task clock is a cost */
>   	if (flags & ENQUEUE_MIGRATED)
>  		return;
>  
> +	/* CPU has been idle in between so the lag has been removed */
> +	if (se->vlag_seq != cfs_rq->idle_seq) {
> +		se->vlag = 0;
> +		return;
> +	}
> +
>  	/* Compute sleep time */
>  	delta_exec = rq_clock_task(rq) - se->exec_start;
>  	if (unlikely(delta_exec <= 0))
> @@ -8190,6 +8204,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  
>  	dequeue_hierarchy(p, flags);
>  
> +	if (!cfs_rq->h_nr_queued)
> +		cfs_rq->idle_seq++;

Shouldn't this skip DEQUEUE_SAVE?

> +
>  	if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
>  		se->deadline -= se->vruntime;
>  		se->rel_deadline = 1;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b98084e1f5b0..69a2a749e188 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -689,6 +689,7 @@ struct cfs_rq {
>  	u64			sum_weight;
>  	u64			zero_vruntime;
>  	unsigned int		sum_shift;
> +	u32			idle_seq;
>  
>  #ifdef CONFIG_SCHED_CORE
>  	unsigned int		forceidle_seq;

Yeah, well AFAICT other things seems OK.

Also, while trying to get this patch series on my tip
branch I had a hard time. I was at the caves
of git and b4 figthing with... Everything.
Like there were no v2 tags on some of the patches
so b4 didn't tracked them. I had to do some
things by hand and finally it worked. (Not too greatly tho.)

But who cares? :>.


Thanks,
Kayra
