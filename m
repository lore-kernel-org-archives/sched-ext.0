Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3711B87C9
	for <sched-ext@lists.linux.dev>; Sun, 30 Nov 2025 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764507895; cv=none; b=TE5DikA4Rc0zJ83VIDmZzV5vIqhQjxcc1xOQHxbwmjNsHuGQUk4300HoYUwH6A7QrVyRkD6QIEbqncr5ZmGpd/fO5QFcxiHfPvYp7mO21+oZ8HbDMTijPmy7D1N3GZOZ7geWXHzUUqvwBj39SJngQMdwSG5i4dXwBpyQfqV5EFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764507895; c=relaxed/simple;
	bh=9D2oLr7trhIbpW8bM0H20UCRmcz8bUJF/twI6SGc3yA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5He4g1rncOu2lcoLuItnXExeLp754mobJJ7bG+pPbWOn+J9bXIP8X5GS2gr7Lr7MWP2BMMXZtq+vUz3g0F6qXZdQFAZXqFqjHIY9PXS5sWkgoHaYJb0zb2WbmjdoPHc4VxfQP3ktTGS7g/6d3lcpVNoWJerdt4pbIdu7qcU55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OdNuKO6s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OdNuKO6s"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AUBPqq8013463;
	Sun, 30 Nov 2025 13:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OHzlFE
	on4imSqC3SwPUNWzFfhRRAqH6KzFlvf//uhqM=; b=OdNuKO6s8xWde+5RKQVvsG
	t3pkEp8/td4DY+WiQHMVvnXjV6XeTcn2XWQGhNm5mrKzWwihA4k5QnMhtmKiJgjv
	N4fTLRg6hGyoFIuy+OPSzkbBxKf1wrb1ZjXMq296YRYG+x3pc78JW/BNWP8jw+zd
	s9Ve4EE0oSSNfAhQMPdAQ0a29gQA3lIR/OCWyKSQDjq/3tJnDOi3KXG1igqWET49
	WvAgHVBuAKwndWXNihv0AoCh+YAqTyaJdslM0/aa9yj00vB3pUNYKU072FRPHP2I
	swxeYFkgVc9toDVzsCpCrWNcCLw+XiKMvEB3ktRwhh6Zji3DfABsswDlvlSBJXug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9b3b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Nov 2025 13:03:45 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AUD3j6h017999;
	Sun, 30 Nov 2025 13:03:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9b3b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Nov 2025 13:03:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AU80ZBe008594;
	Sun, 30 Nov 2025 13:03:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arc5mhksp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Nov 2025 13:03:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AUD3fB043581920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Nov 2025 13:03:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCDD420043;
	Sun, 30 Nov 2025 13:03:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2C2A20040;
	Sun, 30 Nov 2025 13:03:38 +0000 (GMT)
Received: from [9.39.29.117] (unknown [9.39.29.117])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 30 Nov 2025 13:03:38 +0000 (GMT)
Message-ID: <38d96de6-f946-4cda-9301-c407425243d5@linux.ibm.com>
Date: Sun, 30 Nov 2025 18:33:37 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] sched: Rework sched_class::wakeup_preempt() and
 rq_modified_*()
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
        void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
        sched-ext@lists.linux.dev, mingo@kernel.org,
        vincent.guittot@linaro.org
References: <20251127153943.696191429@infradead.org>
 <20251127154725.901391274@infradead.org>
 <3d9d0e43-b73c-4bed-b59c-dc1387d183e4@linux.ibm.com>
 <20251130113227.GB411057@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251130113227.GB411057@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kKsLY8gyBTYhQttASQcVrHKzT-PIv8am
X-Proofpoint-ORIG-GUID: xiYJivgbFkZy1wTdqS1O7HMMVXB4az04
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX82VyXW/XDx6o
 zMedt0otKTtj8wrxhYvbMUO8kLYpxq5GlGANukGFqN7TYndG4Wqur75tTC6jidVcZ1uFRH3ykAO
 MMxXezgZCnQ0YnAgf14gaE3yL1ImGNvwGFeWuArq1D3P+RlBL0C8LobcgcGQyhiclK/tv2LE5od
 AEi7VOCMElRbbsN4UY/eaub9qDPl44Rd2oEj21AEdyhBnE5Od4+U0FEeofXnKQYfofeX5XxL6BX
 kY11ag85bI7a0jqNVUDLDVbd0Egx9/Akf/9z7iKLezFKloFPPY+oQ7F8jogcywCcYT+6PRFeDWE
 kUteJhErooQSunyynDhurRRRVOQ0uPZM6pK/VuVFNkKf5dSl7PaQyaA7pYBnMwfgKymJaI6SKtg
 smgrUl5PINPAnIxCHd/lqMfUybYUIA==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=692c40b1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=4aJiliTLZlJ0WOxwvTUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020



On 11/30/25 5:02 PM, Peter Zijlstra wrote:
> On Sat, Nov 29, 2025 at 11:38:49PM +0530, Shrikanth Hegde wrote:
> 
>>> @@ -2174,10 +2172,14 @@ void wakeup_preempt(struct rq *rq, struc
>>>    {
>>>    	struct task_struct *donor = rq->donor;
>>> -	if (p->sched_class == donor->sched_class)
>>> -		donor->sched_class->wakeup_preempt(rq, p, flags);
>>> -	else if (sched_class_above(p->sched_class, donor->sched_class))
>>> +	if (p->sched_class == rq->next_class) {
>>> +		rq->next_class->wakeup_preempt(rq, p, flags);
>>> +
>>> +	} else if (sched_class_above(p->sched_class, rq->next_class)) {
>>> +		rq->next_class->wakeup_preempt(rq, p, flags);
>>
>> Whats the logic of calling wakeup_preempt here?
>>
>> say rq was running CFS, now RT is waking up. but first thing we do is
>> return if not fair_sched_class. it is effectively resched_curr right?
> 
> Yes, as-is this patch seems silly, but that is mostly to preserve
> current semantics :-)
> 
> The idea is that classes *could* do something else. Notably this was a
> request from sched_ext. There are cases where when they pull a task from
> the global runqueue and stick it on the local runqueue, but then get
> preempted by a higher priority class (say RT) they would want to stick
> the task back on the global runqueue such that another CPU can select it
> again, instead of having that task linger on a CPU that is not
> available.
> 

ok. This helps to understand.

> This issue has come up in the past as well but was never addressed.
> 
> Anyway, this is just foundational work. It would let a class respond to
> loosing the runqueue to a higher priority class.
> 
> I suppose I should go write a better changelog.
> 
>>
>>>    		resched_curr(rq);
>>> +		rq->next_class = p->sched_class;
>>
>> Since resched will happen and __schedule can set the next_class. it is necessary to set it
>> even earlier?
> 
> Yes, because we can have another wakeup before that schedule.
> 
> Imagine running a fair class, getting a fifo wakeup and then a dl
> wakeup. You want the fair class, then the rt class to get a preemption
> notification.
> 
>>> @@ -3899,6 +3876,7 @@ void move_queued_task_locked(struct rq *
>>>    	deactivate_task(src_rq, task, 0);
>>>    	set_task_cpu(task, dst_rq->cpu);
>>>    	activate_task(dst_rq, task, 0);
>>> +	wakeup_preempt(dst_rq, task, 0);
>>
>> Whats the need of wakeup_preempt here?
> 
> Everything that places a task on the runqueue should do a 'wakeup'
> preemption to make sure the above mentioned class preemption stuff
> works.
> 
> It doesn't really matter if the task is new due to an actual wakeup or
> due to a migration, the task is 'new' to this CPU and stuff might need
> to 'move'.
> 
> IIRC this was the only such place that missed the check.

Point was, we might do resched_curr twice in this case.
Once in wakeup_preempt and once by explicit call following
move_queued_task_locked. May remove the later one?
