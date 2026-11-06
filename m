Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988345;
	b=c+/RpVGwSwKw5W6Lt78ivwrVX0QYGJcqY1tSGVRMqA6KgG4fYXBTaYeq7XPTv9B2SVYj
	 JfOm5orUnV7GFLG35i7IRNbODsDQYCKZYihWESE366K52joO/c3Y+u7p37gZRoS1bCfjZ
	 0Svf/GwZ1M3VmBVt9A2jIFn8W3jY7+SFv6I4QYdDc7xtlsHn8NIqUhmwCFOHX5u82106Z
	 LFkdwCWBizyCwliBujQPYg4mQmjLOB5hP2TvZkUAXAElA+riQyzGPni1jhlTGUFmkERmR
	 7StXqyAVIEyxiIztlLYTAS6+ByaQEJ2hJS8irHvUVS5oVJuCkHB6hkoN8LAusN2ImSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3SJCRFOyyzqNtQQYZheoRjYTqtXjqo/uUdL5tCibwPE=;
	b=Q2DIEpdRpXgMYldMf6m2vVCUs6ciPhKoP7zbLyoY7K2kVzdR7Ty6ykjjydEJo2xaVxKC
	 wNyy5HNMf4Ye+IO0w2h79wFwoP8RrYzw4Ix7oHH1pZIKSo2xiw3jqJaJgeCjEh0JsLiNl
	 /JH0mxCA8MCr2yR6Z45fbblFV9FybQD6gF3N7sJrDA5xYzvwWRpylvbqBZkVKFpyDkBam
	 YCMhrgoVM1Im0FbRDOhNGL1nLFiL++xN1iCd7V4Oq7RsdAxKdEfATMBiQ7PnGYMcodVr2
	 jd39rY6OnbpfWa8r1ZWHucvs5ZYW3cLxrMLfoOqugfG4Hy+H7uWLXAi/riCoG0ZKTcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HqshyMyD;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5250606A32E
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 18:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5250606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HqshyMyD
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4ae34ad9bb6so836615e9.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 10:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988343; x=1794593143; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3SJCRFOyyzqNtQQYZheoRjYTqtXjqo/uUdL5tCibwPE=;
        b=HqshyMyDvoUsV31jHGz5YkyaX/snoE4/wmY9rPoVdDQWqwyKWDRqwXyUGThDXZsaK2
         chbqiQqocpokQcR6n/KzKViev8rouSK4mcx8crQdkpapNLQ+zeAcn/+a74hHWTP6QGK2
         LPVppYnqh223XqYZvS2hhgdJufl9wFXmomJZ2Xsj/k2qeCOqutJueS0lsizQQILukOfr
         hkHXYQXeWCblsN/dBvoayPnp5A93uwT0MmNcj5qh+b4Ve74dhM0pEbUVgnKBSDR09IL2
         /B4DQ8snJmT7FYbSsKwy2Lkl8IUb/O9v44Qs4npugk/an3CtXKJNlZ3ZrX+xZi+kapVA
         GExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988343; x=1794593143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SJCRFOyyzqNtQQYZheoRjYTqtXjqo/uUdL5tCibwPE=;
        b=GZRVhtmW4CBcxzGSZCnDorsvGTSbMC/URsSeGyZPsU1UC5Z/K41hWoStyjGUm6y537
         A3rRYm6NFixLpPRwT3nvfGoSx2rkT/oednhdpwRjVncv6oOfRVm6BoatJBh0REdaIMzq
         bu/zM2+jYo5u24dF/deQEynj5FauTlLtvPIrPKgPj3ZzkdF9XryG7QgBdQW4MslY0WQJ
         1Pxzs4oR8SAzrHKwSCuE/YqLA70Va3ccJDm9SWVLBMFM/XtCgVT/GsnX7iCfn5q1Hf0I
         vbJEQdD41bM2VdQH3Z0MXd6LG+RI4sPdoAbU+OEKfB0hj9T7lA6bLLxkn4JtaKndCyNs
         PjhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxuWc97hgDP/m4vxe09rtExnAP4GacSrYxG35+6GXXVu9933h5mf6ZMaBXpOFbpkIbNRUIScAXiydw=@lists.linux.dev
X-Gm-Message-State: APuU4Z8NJxmSIyRw6M4HiXD01QA6X+gVZ2314E+2asxuuv7Y24TD811j
	EFmv3sLdXaUnfd/ORj8x7jZoyyll65PJJe+AzgBhFJkD1No5QAfipnm/
X-Gm-Gg: AYBFou0ifeVNBCQ0gorPGdmoJUYtZ3n0LQwGljCKfYAZn83xVTHDWzhdC1Xj3F0rEHU
	VTtVV+nltpcDN5vl1zO7qJr/h8WVxVAv/VsiJHum8oFaj9sK2BZOsOPac5xFO/aAOYMIBUjj+PY
	+vTvXcex3Fsv+BZ4J3MnMk1PNflDns151hKq2u1dGvR05sy5WhkC6TTNZZLxwP0uT0ni2Yk55Wf
	Cb31pNoqE7OOy9qnNWWBGlaNLQLaQ0A7W+QyzJlOObH1YSMb6CwtxtfACRQjQK3WX7gdScp8YWv
	Y61AFEp5Ci2d+YSiSx4XBbVfxKY+v+vAoJ5TeLoUZO59YrJVr+cGTAr0SYQFc+N5zoZru5/TGFJ
	W/zrv4qAnPgMqzSBirY6MVDBvukA2+QYe0u8KztTR16lVoTVKR0TpnkOURjttlQsrgsHOr5RUuW
	IQmrdo2dRsbMrcNr1jHAbrsNwrZfC62glFZz/flZYipmcLXO6Sk0xZgN2+fXNcaPBweGAtS9KC5
	gusi5TExqoruPuri3uyInGVWhMj1FQY7vpAdHZqs4PcR/gO+Ktb+zeQJryw2zJWs1uJXPUFLUvl
	H3lvlw2uZMQv/nuXs1k+GHU9V4S3fbtcsLKqG+FjFKZ+gD9PvQbOEO4LzDbAreMwrIXAAa19t8B
	d
X-Received: by 2002:a05:600c:8590:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4b6dcd99da1mr43174545e9.1.1793988343041;
        Fri, 06 Nov 2026 10:05:43 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572caf48bsm171361085e9.11.2026.11.06.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:05:42 -0800 (PST)
Date: Fri, 6 Nov 2026 21:05:38 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 03/20 v3] sched/eevdf: Reset lag at wakeup when migrating
 and prev has been idle
Message-ID: <au3_SlJ-5Hh98m8Q@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-4-vincent.guittot@linaro.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106151947.3991524-4-vincent.guittot@linaro.org>

On Fri, Nov 06, 2026 at 04:19:30PM +0100, Vincent Guittot wrote:
> When prev CPU entered idle while a task was sleeping, we assume that the
> latter received enough running time and the lag can be cleared similarly to
> what happens for a negative lag.
> While migrating the waking task to a new cpu, Check if prev CPU entered
> idle in the meantime.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 79f53811274e..945de0215abb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -932,6 +932,27 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
>  static unsigned long task_h_load(struct task_struct *p);
>  
> +static __always_inline
> +void entity_clear_lag(struct task_struct *p)
> +{
> +	struct sched_entity *se;
> +	struct cfs_rq *cfs_rq;
> +
> +	if (READ_ONCE(p->__state) != TASK_WAKING)
> +		return;
> +
> +	se = &p->se;
> +	/* Negative lag implies delayed dequeue */
> +	if (se->vlag <= 0)
> +		return;
> +
> +	cfs_rq = &task_rq(p)->cfs;
> +
> +	/* CPU has been idle in between so the lag has been removed */
> +	if (se->vlag_seq != READ_ONCE(cfs_rq->idle_seq))
> +		se->vlag = 0;
> +}
> +
>  static __always_inline
>  void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
>  {
> @@ -10049,6 +10070,12 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  	struct sched_entity *se = &p->se;
>  
>  	if (!task_on_rq_migrating(p)) {
> +		/*
> +		 * Clear the positive lag of a waking task before migrating to
> +		 * the new cpu.
> +		 */
> +		entity_clear_lag(p);
> +
>  		remove_entity_load_avg(se);
>  
>  		/*
> -- 
> 2.53.0
> 

Yeah well looks good. I need to test this on my head tho:

CPU1:    CPU2:
TA       TD
TB
TC

Let's say TA sleeps and has 12 lags. And while its sleeping TB and
TC leaves:

CPU1:
TA (Sleeping)

Then some new tasks come:

CPU1:
TA (Sleeping)
TW
TR

Now TA wakes up, we enter try_to_wake_up(), from there we pick CPU2 and
enter set_task_cpu(), from there migrate_task_rq_fair(), and to
entity_clear_lag().

And from there this just works correctly.


Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>



Cheers,

Kayra





