Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E5F78F39
	for <sched-ext@lists.linux.dev>; Sat, 29 Nov 2025 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764442762; cv=none; b=YNkOFutnMnQc0QZc+1h80GMNkOtfUyM3r4MKJatGFq/jqFv/Bpj+81PNYCeES9bQavLP7xeTZ1NrT4w7PWsZMViXYoA9nrCsd+qehxQ+JDbRH8MkMa0ABOybtt1jNPROwpnqHjrn3n2okASFQDTfTaJOzywpIqum/OBSogyiilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764442762; c=relaxed/simple;
	bh=U0cymfnGd9sZ8UOhOS9FDEGWE2z8F14KRPkUlY0MfVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fT3QDIXZVVSGJlP42aqIPzvTXt/1KEeXhdZLgcBJm3yCBNvA7CzrTOIyUzY1a0VXNytShHhe/wbE9tb/wjtdp/YmxfOWc/Quu1Ie6A00C0ZcXejykEK1LaTj3FasUOE1U0kkKWsfDD2HgNw2wTU6zc4g3OwOMTrBdYM0VcV/zxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ttZCgne1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ttZCgne1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ATIj1HG021116;
	Sat, 29 Nov 2025 18:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CXdSM1
	fygDyDk2bs90yVru1LpLTZ8BZIQb1fXYyeOj0=; b=ttZCgne1Bqzea+A68KEGxY
	GZLqXq7u1TWat8bwkbVNxqvLOLR55WnUCNxyGLaWIQUAFeA5wKvjcAMVTBOqzlvF
	HAIwSkY3e+KhslJ52seYNzwpHXbUEBha8TpN6R/01eQNGwz319XwiLvBFE4rhNcs
	WJsyWWx3aOpuXxs/O2+BURMvgq4KPiOX73esDfyZd2/+9DFu8ws7MkUasA8GK9WM
	ts9ys9TZ4CK/qwy3tGwyunnTc7/m2oArFCVZ3PcmDNjKTI+xpSbzAgNPvrn2NGkv
	Xp4j20ba1YAbWX62X4tXh/6M+q2E7H5wFu0fcccddB/dDiZP8MFbogt0h6LlG62g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8u9kb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 18:59:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ATIx7lA010936;
	Sat, 29 Nov 2025 18:59:07 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8u9kb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 18:59:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ATHe8eD025089;
	Sat, 29 Nov 2025 18:59:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt721sy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 18:59:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ATIx4Ks24445398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Nov 2025 18:59:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54E7220043;
	Sat, 29 Nov 2025 18:59:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1065620040;
	Sat, 29 Nov 2025 18:59:01 +0000 (GMT)
Received: from [9.124.219.208] (unknown [9.124.219.208])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 29 Nov 2025 18:59:00 +0000 (GMT)
Message-ID: <b26d7ab3-e07b-407b-bb24-6741d4043315@linux.ibm.com>
Date: Sun, 30 Nov 2025 00:29:00 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] sched/fair: Avoid rq->lock bouncing in
 sched_balance_newidle()
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
        void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
        sched-ext@lists.linux.dev, mingo@kernel.org,
        vincent.guittot@linaro.org
References: <20251127153943.696191429@infradead.org>
 <20251127154725.532469061@infradead.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251127154725.532469061@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i86vSGG4-UZiGvemDHSh6NhQK-1Ns1NW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX259Ke+ew02SO
 7c7BjUykYtTDDXv6xeJIPmDtwbBIzA7oIGUVOnvbpj/slamApE/eEGxRMjt1ViJLISZrnWo3edw
 oJXSZVhAwB4qMqlMESDLQTGTinH26hYIJgsJmw1iWSMTgkWeZmYTw9MktGfC3u4fhqG1PwIhFSh
 XFMwxKF299KxVVhIDBtPZt6U6L4J+PwvatVuJ5E+CHGanBKTlX+4fJass/CtL+Qa0C210aAmMih
 al7Ra3JI7N3sHYp06Q0m3Ua7uV8yNQFpaY1eLDYLKeRqp21NGwHPvtzpLqIfjYhbndQ9nWXYkoV
 F88g/up228Gi+Sj7xDB73ACEsXcF0zy71RmooQF8p7RST3/3kUr8BYmQfe4r12AuhOCBcgpuddQ
 MpCz4BcitrN5JkCpezt6QKSnTmBYuA==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=692b427b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8 a=gOS4FVK8poV6sGmnfIsA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: I06hEHCkWP48w5RMA5CZBx5kR-BHzszo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290008



On 11/27/25 9:09 PM, Peter Zijlstra wrote:
> While poking at this code recently I noted we do a pointless
> unlock+lock cycle in sched_balance_newidle(). We drop the rq->lock (so
> we can balance) but then instantly grab the same rq->lock again in
> sched_balance_update_blocked_averages().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/sched/fair.c |   27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9902,15 +9902,11 @@ static unsigned long task_h_load(struct
>   }
>   #endif /* !CONFIG_FAIR_GROUP_SCHED */
>   
> -static void sched_balance_update_blocked_averages(int cpu)
> +static void __sched_balance_update_blocked_averages(struct rq *rq)
>   {
>   	bool decayed = false, done = true;
> -	struct rq *rq = cpu_rq(cpu);
> -	struct rq_flags rf;
>   
> -	rq_lock_irqsave(rq, &rf);
>   	update_blocked_load_tick(rq);
> -	update_rq_clock(rq);
>   
>   	decayed |= __update_blocked_others(rq, &done);
>   	decayed |= __update_blocked_fair(rq, &done);
> @@ -9918,7 +9914,15 @@ static void sched_balance_update_blocked
>   	update_blocked_load_status(rq, !done);
>   	if (decayed)
>   		cpufreq_update_util(rq, 0);
> -	rq_unlock_irqrestore(rq, &rf);
> +}
> +
> +static void sched_balance_update_blocked_averages(int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	guard(rq_lock_irqsave)(rq);
> +	update_rq_clock(rq);
> +	__sched_balance_update_blocked_averages(rq);
>   }
>   
>   /********** Helpers for sched_balance_find_src_group ************************/
> @@ -12865,12 +12869,17 @@ static int sched_balance_newidle(struct
>   	}
>   	rcu_read_unlock();
>   
> +	/*
> +	 * Include sched_balance_update_blocked_averages() in the cost
> +	 * calculation because it can be quite costly -- this ensures we skip
> +	 * it when avg_idle gets to be very low.
> +	 */
> +	t0 = sched_clock_cpu(this_cpu);
> +	__sched_balance_update_blocked_averages(this_rq);
> +

I think we do update_rq_clock earlier as early as __schedule.
no warnings seen.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

