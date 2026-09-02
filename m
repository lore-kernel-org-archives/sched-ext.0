Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF06C48035F
	for <sched-ext@lists.linux.dev>; Wed,  2 Sep 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356922; cv=none; b=FKMT4bVsI1XZRYMr4MrEez9QnuAYhQN6aDVeBRSvVqQ8y1euV1KEisZ3Ndszp+7xsApzL+a7VfJUJfcmf+Aq8QmUyWPx01+EVbBoQQ7KL1SyM5mKBP2C7rNio7CGXam6YM0S3F8N4GKtuXcYkg3oa7BbyFdplHR+0uYG83gvBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356922; c=relaxed/simple;
	bh=87Z5OhzR6c8NOsJI5P6GJcp7NU6H5/Cmawvf4H5Lw3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S79FhKmljIsAKonrQRckLLfn/Fjen4d+S8yEusEpaEsyweCqccaXP10QC6+VoJUFgVHuN7jSD/H09V/dyq/Uz8C5x0QlDdxc8YsPcLkkIiyJSg1WXLPGZ68SAEOO75W/RUbIB6BmP+ba9+umTWQmrrQtrxZ7P68SJRDg6gbptKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fbc14782a6d411f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d1a90793-1942-4e46-8b27-88fcda1c7dce,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:fdee754c57a0b882c07c64f0f407005e,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fbc14782a6d411f19a56ed5b684f684d-20260902
X-User: liwanwu@kylinos.cn
Received: from [10.42.12.206] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1468981474; Wed, 02 Sep 2026 21:48:31 +0800
Message-ID: <1d5f2636-a5e3-4b67-bbb9-12922fa0d804@kylinos.cn>
Date: Wed, 2 Sep 2026 21:48:28 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched_ext: Reject NMI calls to lock-taking kfuncs
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <3a9bfba228c46c69408fe1ef392e60f0@kernel.org>
 <20260902023124.1422942-1-liwanwu@kylinos.cn>
 <49faaba5039a29f38ab6f254da6fb8dc@kernel.org>
Content-Language: en-US
From: liwanwu <liwanwu@kylinos.cn>
In-Reply-To: <49faaba5039a29f38ab6f254da6fb8dc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tejun,

Thanks for the review. v3 folds in your three points (single
scx_kf_allowed_ctx() macro with no wrapper, one reject in
bpf_iter_scx_dsq_new(), unlikely(!sch) in scx_bpf_destroy_dsq()).

Continuing the audit that the sashiko bot kicked off, I swept every
kfunc exposed to BPF_PROG_TYPE_TRACING through the any / idle / cid
context-filter sets. I found a second class of problems beyond the
lock-taking set already covered. The first subclass I plan to fold
into v4 and want to make sure you agree with the scope.

Three "any"-category kfuncs read scx_locked_rq() on their success path
and treat a non-NULL return as "the rq lock is already held by me",
which a false positive under NMI turns into either a data race or a
wrong result:

  - scx_bpf_task_set_slice() (the sashiko bot's finding) races its
    direct p->scx.slice write with update_curr_scx()'s RMW of the same
    field.
  - scx_bpf_dsq_nr_queued() resolves %SCX_DSQ_LOCAL to
    (scx_locked_rq() ?: this_rq()) and can therefore report the wrong
    rq's length.
  - scx_bpf_locked_rq() hands the interrupted context's rq to the BPF
    program, which may then operate on it as if the lock were owned.

A second, different subclass I have NOT folded in, and would like your
guidance on.

scx_bpf_pick_idle_cpu_node() and scx_bpf_pick_any_cpu_node() pass the
caller's @node and @flags straight through to scx_pick_idle_cpu(). When
@node != NUMA_NO_NODE and SCX_PICK_IDLE_IN_NODE is not set and no idle
CPU is found in the starting node, the search falls through to
pick_idle_cpu_from_online_nodes() (kernel/sched/ext/idle.c:151), which
writes the per-CPU nodemask per_cpu_unvisited (idle.c:146) under only
preempt_disable(). preempt_disable() does not mask NMIs, so an NMI that
lands on a CPU whose interrupted context is mid-way through that loop
clobbers the scratch nodemask the interrupted context is still
iterating. Same "irq/preempt-only per-CPU state is not NMI-safe" premise
behind scx_kick_cpu()'s check, just a scratch buffer rather than a
lock or a list.

Note this is a wrong-result / lost-scratch race for the interrupted
struct_ops context, not a hard lockup, and it needs CONFIG_NUMA plus
per-node idle tracking to be reachable. The non-node
scx_bpf_pick_idle_cpu()/pick_any_cpu() force NUMA_NO_NODE and never
reach the scratch, and every cid-set kfunc is an RCU-read lookup, so the
hazard is confined to those two node-variants.

Should these two issue classes be folded into this series or are they 
out of scope for now? Looking forward to your suggestion.

Thanks,
Wanwu

在 2026/9/2 14:44, Tejun Heo 写道:
> Hello,
> 
> On Wed, Sep 02, 2026 at 10:31:24AM +0800, Wanwu Li wrote:
>> -	if (sch)
>> -		destroy_dsq(sch, dsq_id);
>> +	if (!sch)
>> +		return;
> 
> unlikely(!sch) like the other kfuncs.
> 
>> @@ -9756,6 +9755,9 @@ __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *i
>>   	if (!kit->dsq)
>>   		return NULL;
>>
>> +	if (!scx_kf_allowed_ctx(kit->dsq->sched))
>> +		return NULL;
> 
> new(), next() and destroy() always run in the same context, so reject in
> bpf_iter_scx_dsq_new() and drop the checks from next() and destroy(). With
> kit->dsq left NULL, both are no-ops.
> 
>> +static __always_inline bool __scx_kf_allowed_ctx(struct scx_sched *sch,
>> +						 const char *who)
> 
> No need to wrap.
> 
> Thanks.
> 
