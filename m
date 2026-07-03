Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A7389100
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065747; cv=none; b=Dbn/q9XmI8tWkmklkEpl3shG2jb18LMfR403Vnvef3MBOnFjFtYr1qxlKTWJF/li4XwfqEV+6zgFf7+BPnIrHgC/qMFjNt263IQLGG5OI50bwsGcwOkegtn7G5+oxch3In9BbHrpMci9vXGbEGBq+z5GSQnqkizdCXb3tXC3efs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065747; c=relaxed/simple;
	bh=NN/jfeJFGOBkV4/tq3bgdm5fv3G+AOsx6LPd6UUVFzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7ogXyzQKqwM6Atg2VSE2bPgKGsQISjlzTs4WPqXc7f4/YP+Mv7jGAP5L3sICIA1HnpzaNQLRrAfhX/RyT947b4VZrIoN6krRj0vCRWFtf9rlb4SfY2ou0/rW+FM+sXBKGYhxw+Ruyw95oMfjCKD8dh91pKP/QZJJ8whTLz4c6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ED26ANj0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HvLmzuho; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ED26ANj0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HvLmzuho"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rwwP3126415
	for <sched-ext@lists.linux.dev>; Fri, 3 Jul 2026 08:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nWp6srCkGJ+4X+X8huIe6UD062LWbNs4S60lhudW/fQ=; b=ED26ANj0zzhtsLXX
	+nPsV34j+PG/t/k8CIkYVZf2yhKQcIOW2n5mhHxkWOsIBIZ4lVVoYEwLkH1SXQxY
	cUTDe6dLz7xaUywYrURMovujGOmT3EkzD+Mfi5O96OSs7/Us4MJrGW4Q3eQ2exND
	j1gyzfVI5seK9aNxp2avj7aBa4WsPfb8sEsxS7fc0eZQj/Izd7p77ML5KdE+GHdh
	2l3DV+HD1vzsgaft9e03K4TQy53EFFZARofEu9ZvNfEHRLQU8Lw+f4xY/U+afXKM
	KPVTYzOerwiOIaDxxIpPQUScbNaLQ8c+fVQ6OCBs1CgVOtoHoWNNI7KLp5Yx9WLP
	SXcdmg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5tpnkep1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Fri, 03 Jul 2026 08:02:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c99fce9190so1278385ad.1
        for <sched-ext@lists.linux.dev>; Fri, 03 Jul 2026 01:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783065743; x=1783670543; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nWp6srCkGJ+4X+X8huIe6UD062LWbNs4S60lhudW/fQ=;
        b=HvLmzuho+pw8btx5qV86Dx95961xP6Y2+vImBvsSMUMjTF5j3rUsNmMxRGtZwWUThP
         fbBchGcHAKBlNJVxIuSUGtdCVq4PZu8Zp86FjqXE0XRU7IQu76dc72YjULLoeHdraPDE
         X7zVgaf4TC/wA4AsAejVSi2uBf/afzJW+3kbQ8hepaqVsK7dKDq1UZNtY3Nwbzx1YBDt
         4KBUqjvqIcA/KAGxOWB1fh01nDUXgKmyphkoK5/Bk2QbOHBAD2a8SCuydnjgvbFbo8s0
         I6TrDRaIkI5ratssy7HqZDomg5ElMtFZf5mgjDgWY62U+KwS9mR8g0JL3lMNT45QJGqa
         TmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783065743; x=1783670543;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWp6srCkGJ+4X+X8huIe6UD062LWbNs4S60lhudW/fQ=;
        b=BZkyumBhYzW8Fu7lu+LnzjJc3lvJzw1lc7SYJ040RTM3Cl38AS1nN7hx61CH2m7Sng
         thGzuC05ff7a+1zGV1AW0LQvU0Rn8giOaQJbRkGNyTFVDGmbEA7jPlO3yQJkA/8NHjds
         4LSKIjytnMLg2pvQiGSK6eqf5W6q7lDGIQ9t/6KTYsoTyDfP6mUYK6G1PAWVgPMuALRk
         gWcvtnWlunb7ZeO5fMbOBdQsAiG8kNE2HGCLi9Uq3BDFlsShorqcKRZf6rJlFzwXaEzy
         zfMnF1SEpq8gAxjVgxr/Yn8/6Zk3nO+dtonVJuBa63XvEr2nhFbJQNozFmbomtF4eH43
         jDyA==
X-Forwarded-Encrypted: i=1; AHgh+Rq731uVwqCsFdkZJTb8Cp0J8fBDbu3JUF83MrHKfje8SrZdswoSc0xOuXZCdvMuBGBnSg5XmgFnNoY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxFSKFG3+CcrH+NJkkWQR8MWWk3oP7iyT9EkDsMzGsfcBqGPMho
	6OgjBBqIabFTXHai9qFdC8hJ3IPXVeWdFuCSNw6Cw4GK63tXm8vfQPp+onbwvrIwE38x3AM1qvj
	wDiYjnzVeAhEPeASsU0GwbDIrE814KFUPSzwNrLbmNVow60fPH8Q/nzCVN5+h3CU=
X-Gm-Gg: AfdE7clQ45VWi1lPRXid5sGeVPCQ6r+R6kfsPddWW6F9Gj3i1eu9IWBrLLkEko7Hssz
	hvBcKBN8SIHHTW6wPbgtfA1k7UCnQis+Oztpczp8b+61g/2faDzDXPmbA7aW2z9loYjQjT5Z9AH
	yH/zmba/YtNnKYt5bSVHi1HG9gWhZjHzQ8mJqiQI33UULcKNF6yjTItmZJrUUSOuZcChH3jqmTz
	Hesk9e/FEmSxLDrruUaG10zZzNe5S7RK7Anq4zSiQh13OsNadLbAl/tA+AGziXtAP4xco/0BaFw
	ADgTpMeHFkJn1hKQ5D6x4W1nzh70+BocaS60WFHLZ0EjYzC8ZokvNH6S2w1jeeJOU3QAJBEz5TP
	c4WMJxUyd4mWdAvH8WKe20N5tpmIe3RWchslk1ZQSZObrq7FPWoQ+KvWMyHVDVJwxeQJXUL3b33
	HNdg==
X-Received: by 2002:a17:902:cece:b0:2ca:11ee:b002 with SMTP id d9443c01a7336-2ca7e85c0e0mr65298075ad.5.1783065743354;
        Fri, 03 Jul 2026 01:02:23 -0700 (PDT)
X-Received: by 2002:a17:902:cece:b0:2ca:11ee:b002 with SMTP id d9443c01a7336-2ca7e85c0e0mr65297715ad.5.1783065742742;
        Fri, 03 Jul 2026 01:02:22 -0700 (PDT)
Received: from [10.133.33.129] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7765767sm5463305ad.46.2026.07.03.01.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 01:02:22 -0700 (PDT)
Message-ID: <1d647745-35fe-41cc-8712-aeeeca090837@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 16:02:16 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] sched_ext: Avoid migrating blocked tasks with proxy
 execution
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
        David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
        John Stultz <jstultz@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Christian Loehle <christian.loehle@arm.com>,
        David Dai
 <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260702171909.1994478-1-arighi@nvidia.com>
 <20260702171909.1994478-5-arighi@nvidia.com>
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260702171909.1994478-5-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hwg5r8M8nEQtmJOdW21qMQ624sLmy7UT
X-Proofpoint-ORIG-GUID: hwg5r8M8nEQtmJOdW21qMQ624sLmy7UT
X-Authority-Analysis: v=2.4 cv=UMft2ify c=1 sm=1 tr=0 ts=6a476c90 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=T-V_DFgFBbllJtQJZNIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3NSBTYWx0ZWRfX9X+yNQ/Qc1i2
 Hc7eq1qetXGYcqPP4fF+8uwu7vStE/Cazrb6mDvPD+mnvLNQd2K8TCrfkBIWNqHqVXkQzf4SBz6
 8FhotAkt66lKYX//rrUqQKYkAy+7zEg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3NSBTYWx0ZWRfXzyZ28SGd6RtD
 iO1PHJeqp+5jjPxBh7GRSBh5XJVo0McUMbIeevnerpgKnMT+H/OGWQkHnI7VTh+fUALTELxRZri
 JSzjIDzW8eWnpMUaCR0pikDPyxaXtuK3oEPIUNYST10rbPS13yURmqSM3wovCfOya1S/J4peu/T
 5RNPnjuXB70VBwJO+xDxBfjJlT+DQtn0BTnsBNUhofsN6AfJf3xtA8kj4qOdIU01t+HSzvTR3nc
 Hpkz51gf8vE6+8BipubP42lw7Gnhd56B4ExoFaa0WI/ywQLX1GQV74QnB1oeK18XrAgUxfg5SfQ
 28XvPyW+jTzxDXKYmIrsTy0BDB1KRBJ1I5saAYiLBoEmDWS4A9mD95PJxKlthRcF7rVegGT4+GW
 sydRwZoToZbfPme9OMf4TiXzid9fnFfeUr/8iUGMtUTOg+GsOWA2Itv6W+FbnX15qepR06TKiI5
 S9OZr+k3KloC0n7NLwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030075

On 7/3/2026 1:09 AM, Andrea Righi wrote:
> From: John Stultz <jstultz@google.com>
> 
> With proxy execution enabled, mutex blocked tasks stay on the runqueue.
> Later with donor migration they will be migrated when necessary by the
> core scheduler to boost lock owners.
> 
> Don't try to migrate mutex blocked tasks, the proxy logic will handle
> that.
> 
> Co-developed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: John Stultz <jstultz@google.com>

SOB was suggested to have the current committer at the last line.
Not sure if it is the same rule for the subsystem here.

My understanding would be:
Signed-off-by: John Stultz <jstultz@google.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>


> ---
>  kernel/sched/ext/ext.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 1588565050679..9a672b9a55f6e 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -2150,6 +2150,14 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
>  
>  	WARN_ON_ONCE(task_cpu(p) == cpu);
>  
> +	/* Make sure tasks aren't on a cpu */
> +	if (task_on_cpu(task_rq(p), p))
> +		return false;
> +
> +	/* Don't migrate blocked tasks, proxy-exec will handle this */
> +	if (task_is_blocked(p))
> +		return false;

what about return true here for owner_cpu?
if the owner_cpu is in the move_task_between_dsqs stage for example.

> +
>  	/*
>  	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
>  	 * the pinned CPU in migrate_disable_switch() while @p is being switched
> @@ -2784,6 +2792,23 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  	if (p->scx.flags & SCX_TASK_QUEUED) {
>  		set_task_runnable(rq, p);
>  
> +		/*
> +		 * Mutex-blocked donors stay queued on the runqueue under proxy
> +		 * execution, but the donor never runs as itself, proxy-exec
> +		 * walks the blocked_on chain on the next __schedule() and runs
> +		 * the lock owner in its place.
> +		 *
> +		 * Put the donor on the local DSQ directly, so pick_next_task()
> +		 * can still see it, find_proxy_task() will be invoked on
> +		 * next->blocked_on and either run the chain owner here, or call
> +		 * proxy_force_return() and let BPF make a new dispatch decision
> +		 * once the task is no longer blocked.
> +		 */
> +		if (task_is_blocked(p)) {
> +			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
> +			goto switch_class;
> +		}
> +
>  		/*
>  		 * If @p has slice left and is being put, @p is getting
>  		 * preempted by a higher priority scheduler class or core-sched


-- 
Thx and BRs,
Aiqun(Maria) Yu
