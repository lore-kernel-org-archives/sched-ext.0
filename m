Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23A32ED27
	for <sched-ext@lists.linux.dev>; Mon, 15 Jun 2026 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525861; cv=none; b=e8XW1l/py5C7ZMNNArdH3I0/hYVavBjCo07qxwHM3xGUBOliYLDTq9aOK8wqzmhj1P+K/TZMkXF/CRnEXS/hy47FIZuprkgsR5DYBNDYycyH42QxL9ikh+xGFkc+IKHLyYnD/Qu8GgNc77R9MsgH0+hXDKvPvb94jkKGh8LBc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525861; c=relaxed/simple;
	bh=16fLVsgJwQw8RxGuNkUZmp/ZZRob8n63K+bKHNgIvhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJQUg2DKitp2AVAJrNal8E65L5W1x/iT6JLA+DtN9fFL+FjaZhdK2HxTLYgAcF12zZ5306HvL1XM1jn3y2HLgs6U2BmfMSrlE4zcpu4R88RZS4ZlKXU0zTsXbI9YaD65PE7CIbaG2wbiwSZhne+ydj2neg4p3yDwNVPADNtdn+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ovT7MLQi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WZ4g3wLz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ovT7MLQi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WZ4g3wLz"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAoPQN3885701
	for <sched-ext@lists.linux.dev>; Mon, 15 Jun 2026 12:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n+cg/szuB5nopCfExxFx7dLfNUGtVuWLcGK9H/4gV+8=; b=ovT7MLQiBYVvJNiQ
	f1mkQX3XXijHtQ9LV9/YdyM2HLM0Ya8O+8QqcEk4bQ+wonLK6YDER/Cjj1CAdnjJ
	2lzyCfTkbF45tebmzrXBEkrxLiWzhA/6mnYkPnUH5XAd+5b86L98Lo+2XL60tgxY
	RdJy+s+3g63XmlEZp5m3CU04rIuLTK2XB88OpzE0bN9P6b0FO1DPemlEc1t8jAQO
	okY2ZFa6ie8h0Vb/LEy8nX5rgFJ4Ie3rXszHOp6ygltkYNVHtgWRDnUbxVCKhnZ1
	lmVk04fXm14YuAI66/yDpXZSrYkCMVukGlQe92h1bmzjcbzHO2+ZiOo6zk7HiyJ8
	H1z/Lg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjrkyq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Mon, 15 Jun 2026 12:17:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36b97b72bd7so758732a91.3
        for <sched-ext@lists.linux.dev>; Mon, 15 Jun 2026 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781525858; x=1782130658; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+cg/szuB5nopCfExxFx7dLfNUGtVuWLcGK9H/4gV+8=;
        b=WZ4g3wLzRx02JjVHuzyvTFyB+KDyPMQf1dh/hCEeyxmRFVf27cJaHfuIjOX5fvwvpx
         AW86jWo86uYKye8mrIRgls7mMi0hbeKvHx5ZggWso2PIy0hvMVhoCvmZaAvOX06Lmr33
         wjM8f00PrB6gsxB0cuPYcCCDaDZgQnKlbm0npbfIzwMz/Fpp550Ewk34mru5N9zsVhCt
         4fhxu9qmCqpunJggor0/FhHohkNXqHOOJZ62lX/eyM+1VC/IhJTYXp2gWYKhdLh3AKsD
         d9atGCAHSlmEmUtK2tVIQAlsNMv9cyeHtG+QVv1aMjICdRLJqMhZEFdiEHEObw6Q2p2o
         9y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781525858; x=1782130658;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+cg/szuB5nopCfExxFx7dLfNUGtVuWLcGK9H/4gV+8=;
        b=BdYwhB9HOhZFd+7tHV7OjbEMQuubyXdxzmipcTNHjFWFtwRkokT9/La7aICPY2bs2h
         Wox1eTwdVI670AoDN5YkTdFayBTWnoSjKB1kkQ2uHVpZC4GjvyBt0iqFiUKQ2PzVRzF0
         7lEf4SjsJbKxZqvzSEWO7vNFrjGLAgmZKV7wO8y22+s7SvjNveQnjuKhdYq19fNMNbeF
         afcGoCtI85gyzea4idFz8Fgt3uADPpG56o0il2A1wCWJ/YeZOIPnSy/9/U5ZUF1indjN
         /82XuvFC3NvpY8EYbFNeUNtpaBNPBrpwQ4I5T2bFJZPlzI2EoZg86KNz5d6kCK+osM3S
         L93g==
X-Forwarded-Encrypted: i=1; AFNElJ/Yh0d2SO+LOINbRuDDRd7oCgAMfQOIHwbDocADsbIXNmonrQQ2pQYU5ccRjDRMl2HWrnKm+Wd/iQs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwJuXsyP3vmWSiXdzWYA/Czala4u/K5+IGJgrXSjXXn5BajtwlA
	kMXIGi6kD1qtGciDOKbyfB7m+RDJEVLQj6Vx8/tt70+rG0F+CTGR9shvcTOd74u2d5UWGC+b3oQ
	e/HkSKabmvBwuJqN4TnJ0+lrUXXubz2VCefcPnnBCU90M/zN2cC1P9mazJa7OKuA=
X-Gm-Gg: Acq92OGfcUwhNdWrtcyKMjzqN+4OzqDvsPApnbdfdPee9KGEhn6/rIHM2UP4OOeKLhs
	3RUQ2DOuC9/CfnzWmvtvmOo8071Rfp+4jV9ed9CfGbykK56FQWZ/oLbFlhCFRY2KT7KFz/YX1mG
	2MSV5TqXmAX+3WjDIZHL+OK2LeHhy+ToSVw6MHL76l8huOngtz+XqnQTkwJKMotOlabBSg8el58
	XaJ6dPJtrNcPcyOLFdHP1Qlkzu9xvfvzDSnuXT/gZih9Ibfu/MPzqams+5joD1Yaoh5tFXQdfvg
	ZAAbBMfbf4CeI5Xr7F5DR/darRJSrKPpz64MFH6nLMejRkiqjxiKgeP45mqWJj83h+rhWKX1A8O
	GFjmbKNs1W8drDZ7f3NOxfjovMVoVJA+xiaHDxdagpqxKFrePy0kd6Krd70BegFKOzA7uwnXVKg
	kgUw2WVsukxkE=
X-Received: by 2002:a17:90b:3d47:b0:36b:9323:c726 with SMTP id 98e67ed59e1d1-37a030f8db0mr7226657a91.4.1781525858049;
        Mon, 15 Jun 2026 05:17:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3d47:b0:36b:9323:c726 with SMTP id 98e67ed59e1d1-37a030f8db0mr7226623a91.4.1781525857410;
        Mon, 15 Jun 2026 05:17:37 -0700 (PDT)
Received: from [10.133.33.25] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866518677dsm8855378a12.19.2026.06.15.05.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 05:17:37 -0700 (PDT)
Message-ID: <1cf3cf13-5f86-40d8-bdab-dd25a0c35bb7@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 20:17:31 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] sched/core: Skip migration disabled tasks in proxy
 execution
To: Andrea Righi <arighi@nvidia.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Cc: John Stultz <jstultz@google.com>, Tejun Heo <tj@kernel.org>,
        David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Christian Loehle <christian.loehle@arm.com>,
        Koba Ko <kobak@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
        sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260506174639.535232-1-arighi@nvidia.com>
 <20260506174639.535232-2-arighi@nvidia.com>
 <CANDhNCoKyJGZApptPo=7S-Cdu1FqPPr_Wr9djV1-NzjfVnbkgw@mail.gmail.com>
 <427e64df-2d3c-47a5-925f-ef9a751f1ca3@amd.com> <afwxsJiNJcNQrcHN@gpd4>
 <bfb4c8ca-e155-41b8-ab00-1607d9823051@amd.com> <afxlvypRoa0qCHhs@gpd4>
 <24ffc508-a806-4be0-9b33-fbe8c02d1742@amd.com> <af2TVI7ZAw41ZO3C@gpd4>
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <af2TVI7ZAw41ZO3C@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEyOSBTYWx0ZWRfX6oDKGn17Y5Na
 RjA9RHjgU/fctAh8Fn4vD5y0uMHSg9IdzTVUiveKyuYu3YobaIiAcNWsq9s6eqCHgfUzbj1/14Q
 FSEs+SGi274Es1witDTb55GuadOALikKwEktzbiLaGgBoiZqVSFDIkdwzZ8Uok0e+EHOWeUI+8X
 3IJkhYUT3rYg8D/8LmDJtZxsnnONcg5EWesNQLyHo9ovKxMO1VM7/Se1Yi4zAq3E+5eZ/F8zXf8
 qTP6q4t3iVt5tpWKANCX+nurPBcxCt9mMwfRrWB1gWeifsBXM4MDGawPRtzaUuoIDqhVj5f4uwo
 FzhwI5N141kSYO/I+UmqptiwnL9QVtfGWTpqUgqN7ux8Z8k2K4I4I31y3cYEUF2HXRARaBTMDue
 fHvou69TqXqT1gnxg5RNDIbR9dp/kbA/LOlnyOjZC+hg1XJeeai5Plvh3vms+x7zwFUHEUQsLEW
 YV7PAKz3R5mA866ESJA==
X-Proofpoint-ORIG-GUID: NxBTpB1jNKWzZTgnkHuTCALTU1QuRSfN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEyOSBTYWx0ZWRfX0wO+dYojktSX
 ezVAZ+2pmExDest/jeaOD77/D9IXWU5kGhzdNlHsq6bXGWaoK+NAVKz57FoVW+3w21KYw5UmF12
 6+l1b8gkw3Maan/nt6I91n/rQfsrhnU=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a2fed62 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=btlSXbVrFCAxagvMHvEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: NxBTpB1jNKWzZTgnkHuTCALTU1QuRSfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150129

On 5/8/2026 3:40 PM, Andrea Righi wrote:
> Hi Prateek,
> 
> On Thu, May 07, 2026 at 09:17:34PM +0530, K Prateek Nayak wrote:
>> Hello Andrea,
>>
>> On 5/7/2026 3:43 PM, Andrea Righi wrote:
>>>>>> scx flow should look something like (please correct me if I'm
>>>>>> wrong):
>>>>>>
>>>>>>      CPU0: donor                    CPU1: owner
>>>>>>      ===========                    ===========
>>>>>>
>>>>>>   /* Donor is retained on rq*/
>>>>>>   put_prev_task_scx()
>>>>>>     ops.stopping()
>>>>>>   ops.dispatch() /* May be skipped if SCX_OPS_ENQ_LAST is not set */
>>>>>>   do_pick_task_scx()
>>>>>>     next = donor;
>>>>>>   find_proxy_task()
>>>>>>     proxy_migrate_task()
>>>>>>       ops.dequeue()
>>>>>>         ======================> /*
>>>>
>>>> At this point I mean ^
>>>>
>>>>>>                                  * Moves to owner CPU (May be outside of affinity list)
>>>>>>                                  * ops.enqueue() still happens on CPU0 but I've shown it
>>>>>>                                  * here to depict the context has moved to owner's CPU.
>>>>>>                                  */
>>>>>>                                 ops.enqueue()
>>>>>>                                   scx_bpf_dsq_insert()
>>>>>>                                     /*
>>>>>>                                      * !!! Cannot dispatch to local CPU; Outside affinity !!!
>>>>>>                                      *
>>>>>>                                      * We need to allow local dispatch outside affinity iff:
>>>>>>                                      *
>>>>>>                                      *   p->is_blocked && cpu == task_cpu(p)
>>>>>>                                      *
>>>>>>                                      * Since enqueue_task_scx() hold's the task's rq_lock, the
>>>>>>                                      * is_blocked indicator should be stable during a dispatch.
>>>>>>                                      */
>>>>>>                                 ops.dispatch()
>>>>>>                                 do_pick_task_scx()
>>>>>>                                   set_next_task_scx()
>>>>>>                                     ops.running(donor)
>>>>>>                                 find_proxy_task()
>>>>>>                                   next = owner
>>>>>>                                 /*
>>>>>>                                  * !!! Owner stats running without any notification. !!!
>>>>>>                                  * 
>>>>>>                                  * If owner blocks, dequeue_task_scx() is executed first and
>>>>>>                                  * the sched-ext scheduler sees:
>>>>>>                                  *
>>>>>>                                  *   ops.stopping(owner)
>>>>>>                                  *
>>>>>>                                  * which leads to some asymmetry.
>>>>>>                                  *
>>>>>>                                  * XXX: Below is how I imagine the flow should continue.
>>>>>>                                  */
>>>>>>                                 ops.quiescent(owner) /* Core is taking back control of owner's running */
>>>>>>                                 /* Runs owner */
>>>>>>                                 ops.runnable(owner) /* Core is giving back control to ext layer */
>>>>>>                                 ops.stopping(donor); /* Accounting symmetry for donor */
>>>>>
>>>>> I think the order of operations should be the following:
>>>>>
>>>>> ops.runnable(donor)
>>>>>    -> ops.enqueue(donor)
>>>>>    -> donor becomes curr
>>>>>    -> ops.running(donor) /* set_next_task_scx(donor); !task_is_blocked(donor) */
>>>>>    -> donor executes
>>>>>    -> donor blocks on mutex (proxy: stays on_rq; task_is_blocked(donor) true)
>>>>>    -> __schedule()
>>>>>    -> pick_next -> proxy-exec selects owner as next
>>>>>    -> put_prev_task_scx(donor)
>>>>>         -> ops.stopping(donor)
>>>>>         -> dispatch_enqueue(local_dsq) /* blocked donor: ext core parks on local DSQ */
>>>>>    -> set_next_task_scx(owner)
>>>>>         -> ops.running(owner)
>>>>
>>>> So ext will just switch the context back to owner? But how does this
>>>> happen with the changes in your series?
>>>>
>>>> Based on my understanding, this happens:
>>>>
>>>>     -> pick_next -> sced-ext returns donor as next
>>>>     /* prev's context is put back */
>>>>     -> set_next_task_scx(donor)
>>>>       -> ops.running(donor)
>>>>
>>>>     /* In core.c */
>>>>
>>>>     /* next = donor */
>>>>     if (next->blocked_on) /* true since we have blocked donor */
>>>>        next = find_proxy_task(); /* Returns owner */
>>>>
>>>>     /* next = owner; */
>>>>     /* Starts running owner */
>>>>
>>>> How does ext core swap back the owner context here? Am I missing
>>>> something? find_proxy_task() doesn't call put_prev_set_next_task() so
>>>> I'm at a loss how we get to set_next_task_scx(owner).
>>>
>>> The sequence should be the following:
>>
>> Still a bit confused! Hope you can bear with me for just a little
>> bit longer :-)
> 
> No, thank you! This is super useful for me! I want to make sure I'm not
> missing/misinterpreting anything obvious. :)
> 
>>
>>>
>>>  - pick_next_task(rq, rq->donor, &rf) returns donor (because we parked it on the local DSQ)
>>
>> So put_prev_set_next_task() happens as a part of pick_next_task().
>>
>> When we pick the donor, we have already called set_next_task(donor)
>> on it before returning it from pick_next_task().
>>
>> "owner" is still not known at this point ...
> 
> That seems correct.
> 
>>
>>>  - in __schedule() (still holding rq->lock), proxy sees next->blocked_on and does:
>>>     - next = find_proxy_task(rq, next, &rf);  -> returns owner (or triggers migration / retries)
>>>  - Only after that, __schedule() reaches the point where it performs the switch
>>>    (put_prev_set_next_task(rq, prev, next) via the pick path). Ao  that point,
>>
>> ... and we don't do put_prev_set_next_task(donor, owner) after
>> (or within) find_proxy_task() as far as I'm aware. The "donor"
>> remains as the task on which we last called put_prev_task().
> 
> Also correct.
> 
>>
>> If you are referring to the bits in your Patch2, the calls to
>> put_prev_task() and set_next_task() is done on the same "donor"
>> task. It is purely for the sake of adding a balance callback if
>> we had skipped migrating away the prev task due to proxy.
>>
>> AFAIC, nothing does a set_next_task(owner) after
>> pick_next_task() in __schedule() unless I'm grossly mistaken.
> 
> I think you're right.
> 
> Let me try to recap what happens in two different scenarios:
> 
> # donor and owner running on the same CPU
> 
> Owner runs on CPU0, it expires its p->scx.slice, so it's de-scheduled and added
> to a DSQ; donor is next, it runs and blocks on a mutex on CPU0, we park the
> donor on CPU0's local DSQ, pick_next_task(rq, rq->donor, &rf) on CPU0 returns
> next == donor, we see next->blocked_on == true, so we trigger find_proxy_task(),
> inside find_proxy_task() we see owner_cpu == task_cpu, find_proxy_task() returns
> owner, replacing next, set_next_task_scx(owner) triggers ops_dequeue() +
> dispatch_dequeue(), removing the owner from the DSQ, then

We've seen an issue which cpu1 do find_proxy_task trying to schedule the
owner, and the cpu0 trying to migrate owner to consume remote. And
finally cpu1 and cpu0 both do context switch to the same task. Is there
any corner case here?

> set_next_task_scx(owner) will trigger ops.running(onwer), then
> ops.stopping(owner). And in this case we don't trigger ops.stopping(donor) +
> ops.running(donor) during the proxy switch.
> 
> # donor and owner running on different CPUs
> 
> Owner runs on CPU0, it expires its p->scx.slice, so it's de-scheduled and added
> to a DSQ; donor runs on CPU1, it blocks on a mutex on CPU1, we park donor on
> CPU1's local DSQ, pick_next_task(rq, rq->donor, &rf) on CPU1 returns donor as
> next, we see next->blocked_on == true, we trigger
> find_proxy_task() on CPU1, find_proxy_task() sees owner_cpu != this_cpu, so it
> triggers proxy_migrate_task() to migrate donor to CPU0, which triggers

We've seen a crash that one cpu(cpu1 here for example) trying to do
proxy_migrate_task to another cpu(cpu6 here for example), while cpu6 is
trying to pause itself and trying to migrate tasks back to cpu1. And in
a live lock.

> deactivate_task(donor), unlinking it from CPU1's local DSQ, then
> proxy_set_task_cpu(donor, CPU0). But at this point we're not adding donor to
> CPU0's local DSQ. I think this is the part that is missing, if we add donor to
> CPU0's local DSQ at this point we would effectively fall back to the "same CPU"
> scenario and (in theory) everything should work.
> 
> Something like the following (not tested yet - about to).
> 
> Thanks,
> -Andrea
> 
>  kernel/sched/ext.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index af9b10cd82c4a..6125c4cbd6d64 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1915,6 +1915,22 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  
>  	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
>  
> +	/*
> +	 * Under proxy execution, mutex-blocked donors can be migrated to a
> +	 * different rq (e.g., towards the mutex owner's CPU). For sched_ext, rq
> +	 * association alone isn't sufficient for the donor to be picked again
> +	 * and drive find_proxy_task(); make it immediately visible on the
> +	 * destination rq by parking it on the built-in local DSQ.
> +	 *
> +	 * This task is a scheduling context token and isn't supposed to run as
> +	 * itself while blocked.
> +	 */
> +	if (unlikely(task_is_blocked(p))) {
> +		clear_direct_dispatch(p);
> +		dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
> +		return;
> +	}

Prefer online CPUs when selecting a target — there is a race window
between a blocked task being enqueued onto an offline CPU's runqueue and
getting a chance of __schedule to push it back out.

> +
>  	/* internal movements - rq migration / RESTORE */
>  	if (sticky_cpu == cpu_of(rq))
>  		goto local_norefill;

-- 
Thx and BRs,
Aiqun(Maria) Yu

