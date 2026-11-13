Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559628;
	b=DwrWdlTWM79x0ApsOcxcYmtfCaNplkqhZ8MW50g3JjJ/LwubC0AcwnDLg5Uu9pTO1rku
	 fHGgcBYyT3gWH+mc+HmX9e8lHf4TMlVOUCLAWbYORaRG+DfMq0Q3hYt9My5BCUhoQT8/e
	 Yw9sdKXtIMCrNZ0xkq1ns084EDODXVwc54M+yNNnDiKpKZVKuH2bMVCYLCcxZhCEV84rY
	 gWgEFBoLefovAMujQv/zv/rFmoeL8F2iuEOXy6yjK803P91mLv4OD/2wznYCefGZLmP/v
	 VW/8QeIbxs6fWV98x+qJ8R5AENtSr66UIU6wUv1YorUrIT0p7KaSSfkDu7psaJdL6Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559628;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Subject:To:Cc:References:
	 From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7IK0olkrbLVYnqLKQcOR+p0F4uBvZyrDMfmTykxx+8g=;
	b=4NYpyknFY/pLygip0vnmETm+/2dj6kPViPV/9W6gxD7DWSiICHwsyIalotdOX1UePRF3
	 DZXTdTJJYL/FjxLCHfv1c+KFCJTq0/9wH6Rx6ick7vGyIDr1cgpz9U0DjwUX4ZWcZAdxV
	 TT/Dnf3X/yuv9wgyZVL9y+rmHIsHH3SRcb2M2G7kS6I5crFP8Hf/0OO5Uv/B1y8JqOEt8
	 Sap7S0rJqEjA/ax6ZPMjTq9RcZcaGmHXuPImIS1lckAMg2zKgwBkHw5Dec7DjXNszhULH
	 RM4+W/VVZoTp9iNVWjMn1C6NoukCmKAICLDrWvm07dRP2fuEauUWGd3WuZC/dElQy4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.51
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302A606A33B
	for <sched-ext@lists.linux.dev>; Fri, 13 Nov 2026 08:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D302A606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08146114|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0105523-0.00030552-0.989142;FP=13248491661041634554|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=likunyu@open-hieco.net;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.k1B5v3a_1794559620;
Received: from 172.18.25.145(mailfrom:likunyu@open-hieco.net fp:SMTPD_---.k1B5v3a_1794559620 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 16:47:01 +0800
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org,
 tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev
Cc: qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com,
 sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org>
From: Li kunyu <likunyu@open-hieco.net>
Message-ID: <6033be91-bdb6-ce15-5b65-eef73256d175@open-hieco.net>
Date: Fri, 13 Nov 2026 16:47:00 +0800
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
In-Reply-To: <20261106151947.3991524-9-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

On 2026/11/6 23:19, Vincent Guittot wrote:
> /*
>   * select_task_rq_fair: Select a target runqueue for the task.
>   * There are 2 ways to select the target runqueue:
> @@ -10552,6 +10712,18 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
>  	cfs_rq->curr = NULL;
>  	if (se->on_rq)
>  		__enqueue_entity(cfs_rq, se);
> +
> +	if (next) {
> +		/*
> +		 * The previous task might be eligible for being pushed on another cpu
> +		 * if it is still active.
> +		 */
> +		if (next != prev)
> +			fair_add_pushable_prev(rq, prev, next);
> +
> +		if (next->sched_class != &fair_sched_class)
> +			fair_queue_push_tasks(rq);
> +	}

Regarding if (next->sched_class != &fair_sched_class) - would it be more
semantically correct to change it to if (sched_class_above(next->sched_class,
&fair_sched_class))? The current code migrates all CFS tasks on the current rq
whenever the next task is not of the fair class; I think it would be more
appropriate to do this only when the next task has a higher scheduling priority.

I'm not sure whether my understanding is correct.

-- 
thanks,
kunyu
