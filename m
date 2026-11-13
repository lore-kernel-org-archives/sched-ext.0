Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568863;
	b=CViTZmp5pRk6bj3rXiCJotr4oLI1a19v7xwOnT3LqzM/ol6Od5Zp4+onUPmfrxmCdU04
	 Ve5D5jOb3En1yue5PRGamnd3sp0jM5+2S3OZQmFha+m2Ro9lvwo5Qck64tFTeaEYBNmKP
	 XFbpGhsXPWagW2pn7GIhaJlmBII0H7elHUzQkgQV4ANiEt0JgRCo7qBm8kl9xCsxmopaN
	 HLcIzQblglkL23FMNLGjxnCGu3JcDIWKIFnIz4ZnNl5vSx6Nd0fDs3U0cxN7zOLnzUMoz
	 7AW97WyHkLWwBO0YDnbXdFR0KRTkzIoG3VjgSwqa7a30IMFZAbLd8W1x1pc62VAqU6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568863;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Subject:To:Cc:References:
	 From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MR0fWnoK4QnQL1900NGokJWJSfxcJIOVpOHCYAdceVA=;
	b=x+7yEcq+HUaVTFbbBwn+HhER/GAJm0qsiduHyLtfg8T316sQIsuMYHYUDrIaBMZplNwM
	 0lhdEt9Y0ezILwpPZuImvvCO8iY2PiNHCBgEAra3E6HaLHb/taXgR59TI0L0snmkXH1fa
	 XMlMh6QZP+orH3kMRgAQzPPaBUdpdookd7EmMkiqlXyW36+NLHd5xsPin0/9RBZxICRby
	 /gb/WoovSct52Zo/fYjM0NfiQOpYoP4VQ04y23Ezlr8XMv/KaO/8MII0BoWZqCeNerDE9
	 No9n4d+tuE+tmkbqL4m+7z06idfHUQiTcHYllnM+OpWM1pkVKhwUos5U4D1a6bKgztA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.76
Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D42606A335
	for <sched-ext@lists.linux.dev>; Fri, 13 Nov 2026 11:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1D42606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07439558|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.661871-0.0475943-0.290535;FP=3948912221684073562|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034254;MF=likunyu@open-hieco.net;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.k1BY8yJ_1794568851;
Received: from 172.18.25.145(mailfrom:likunyu@open-hieco.net fp:SMTPD_---.k1BY8yJ_1794568851 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 19:20:53 +0800
Subject: Re: [PATCH 13/20] sched/eevdf: Try to push short slice task on a
 better CPU
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org,
 linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev,
 qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com,
 sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-14-vincent.guittot@linaro.org>
 <fceb72e4-0042-249b-8223-f912f2a50d80@open-hieco.net>
 <CAKfTPtBE3pU=71EyEfVRSbOBG+Y9itNEhfwd7svT9+JZhek-vQ@mail.gmail.com>
From: Li kunyu <likunyu@open-hieco.net>
Message-ID: <b2cd1ca8-f838-be30-4d71-d36e51bd3404@open-hieco.net>
Date: Fri, 13 Nov 2026 19:20:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBE3pU=71EyEfVRSbOBG+Y9itNEhfwd7svT9+JZhek-vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



On 2026/11/13 18:49, Vincent Guittot wrote:
> On Fri, 13 Nov 2026 at 10:25, Li kunyu <likunyu@open-hieco.net> wrote:
>>
>>
>>
>> On 2026/11/6 23:19, Vincent Guittot wrote:
>>>  static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
>>>  {
>>>       if (!__check_pushable_fair_task(rq, p))
>>> @@ -10120,6 +10137,12 @@ static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struc
>>>       if (next == p)
>>>               return false;
>>>
>>> +     if (next && next->sched_class != p->sched_class)
>>> +             return true;
>>
>> Would it be more appropriate to use sched_class_above(next->sched_class,
>> &fair_sched_class) here? I think placing prev on rq->cfs.pushable_tasks is
>> justified only when next belongs to a scheduling class strictly higher than fair.
> 
> class strictly higher is the most common case but we can have cases
> where sched ext dl server preempt fair task

Perhaps I was thinking of scenarios with moderate to high load, such as cloud
computing or server environments. In such cases, there may be few opportunities
for successful migration - for example, because it would only put additional
pressure on an already heavily loaded CPU - and even lock contention could
become a bottleneck. Of course, this is just speculation on my part.

>>
>> I also wonder whether doing this in the normal CFS hot paths -
>> put_prev_task_fair(), set_next_task_fair() is really desirable. PATCH 09/20
>> already replaces the unconditional raw_spin_rq_unlock() + task_rq_lock()
>> sequence with a raw_spin_trylock(&next_task->pi_lock) that skips the push when
>> the task is already locked, which I agree is an improvement.
>> But could the push decision itself be moved into the load balancing path
>> instead? That would keep the hot paths free of migration-related locking and
> 
> LB is not the right place for several reasons:
> - the period between LB can be quite long compared to scheduling constraint
> - EAS disables load balance
> - periodic load balance looks at balancing the CPUs in a scheduling
> domain without taking care of indiviual tasks requirements. It looks
> at CPUs and then tries to find a task on this CPU that matches the
> constraints whereas the push mecansim is done per task so we can take
> into account task specific insights like slice, min capacity,
> preferred_llc when looking at a CPU.
> - We want to use push in a selected number of cases where we want to
> act immediately

I have an idea worth discussing. For example, the push could be added to
sched_balance_softirq or a similar new softirq/interrupt context. This would
avoid issues such as inconsistent load-balancing intervals and EAS being
disabled. For instance, the push could be triggered when the current CPU's load
exceeds a certain threshold or when the CPU is not running purely CFS tasks.

>> select_task_rq_fair() calls. Or is the next-aware context (knowing which task is
>> preempting) something the load balancer cannot reconstruct, making the current
>> placement necessary?
>>
>> Is my understanding correct?
>>
>> https://lore.kernel.org/all/20261020083746.37068-2-likunyu@open-hieco.net/
>>
>> The SMT push work in this patch is intentionally quite simple; I think
>> it could be generalized with only modest changes to perform push at
>> larger scheduling-domain scopes, such as the LLC (last-level cache)
>> domain.
>>
>> I realize the push direction is somewhat at odds with the current
>> cache-aware scheduling work, which instead tries to make cross-LLC
>> migration less attractive. Still, I'd be interested to hear whether you
>> see any value in a push-based approach at the LLC level, or if there
>> are related plans I should be aware of.
> 
> I think that Chen is looking at using the push mechanism proposed here
> for cache-aware scheduling
> https://lore.kernel.org/all/as2-2b417B8ZaFdO@chenyu-dev/

Going forward, I will continue to follow your code and the CAS code, and I hope
I can contribute in some small way.

I'll step away for the weekend and circle back to this next week.

> Thanks
> 
>>
>> --
>> thanks,
>> kunyu

-- 
thanks,
kunyu
