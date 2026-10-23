Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792752140;
	b=AEOZO/AmeUJlMVYJxPR5Fz0a2J3Y59jOBFTo8v50NXxLs/U/tRME4cKu5XD8iaR2b2kc
	 mZ6Zoc9zJ18rhu8QwsBJS1LJxq+O4uGnV4TsYRpjS8YiKfsBASSY6V1TvznxrbVIBvKCQ
	 C4vLpp+uufRh8vfbWy/E7J7aCK8Z6m//c9sdPbDfwa/atK1FPiJlb/TKSDNTILfMcd0Ip
	 wZve/JKPIEKFysKMTv0oBQjtcxPwBN9Q7P2PLZ2kOj+D23tzGMZxtMCeCLLAdV1DGjQFF
	 AYadftUof2YWECKwOGzltmPgGWqtFhnDEkJW7fAOkZlU0sVIcsb6tl/zb+ps66+boGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752140;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZV4R5OqKmkTH7Oyj6hXbrI9/BN9Vv2ISKszeamvUNBA=;
	b=dNRjHj+fDomWJPmvL0qPeQlRMVqCAn/oStZ0JsvhwUbQXj//GgEZGaNMlJl+ErFi2SOD
	 VbNemKXUM+XA3jwI1Io8XoYBJjfqDup0uFHbmnfpToAqUdM8DLyi4GrmgOA4lChY+kn+X
	 vg7kG+Fpt9CvHXUpHx7FiTDN3/wgYzurrVdrulKqvWE2R7BOt7TbW2TJ/jgaPUx7uKULa
	 s3c2deEiL2Ao+7jT7L9mjag1Ry9aS5g1OVtJvhjkXgapgjxMd5qvdJgZhNNH+bb1tWZyB
	 f3n4B2VCJF1kf5SfnHXJVpXXnOeAxVNj29MOlwV3+pX5byg988PZcrAuJLkER2aTm+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RG+uck3n;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EwyBU4RQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8E606A31B
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 10:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4D8E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RG+uck3n;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EwyBU4RQ
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAEZC1597336
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 10:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZV4R5OqKmkTH7Oyj6hXbrI9/BN9Vv2ISKszeamvUNBA=; b=RG+uck3nZ9z1r3CM
	B74Z4WRDorlj92BN8xmL15qEPsX1vv/vIiexF1n7O2avMB8DcmJ9NCQdmGC3v9RX
	QmYXnvgFuWJy1X6+yv4EDZFHmVORh7MHqJz1X7syu37LUA5Oa8HAqaPGEPOwqhZX
	AqgZeT+zajZRmOMjxzVAVl1sGGOd1utZZtacuAfNx/JhZ3Vrj6Ux+C4kkuzTv02N
	3lJJMlSRiEF01+iqUm13CcEl7JNHtW0QTKQnpPVg7tc+J3BDY/htSOXRaG/9obTm
	lgIkjqxoJkOTI91xLegQ+eFT4BMBHYdaZLQoeWnm4ko+RGuhJcFb9zhYy4Agd8pR
	mAslPA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms38kc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 10:42:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ada6ccd402so716450a91.2
        for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792752138; x=1793356938; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZV4R5OqKmkTH7Oyj6hXbrI9/BN9Vv2ISKszeamvUNBA=;
        b=EwyBU4RQA1hPk7YKSUMS9km2UwqWXLBv0KBZl94Vb823tgXIdsnMhuu/xCa+5df6/0
         Cr4SrwvYezDtJq1tW9pKclb13SI/p5iHwml+Hd3fSN/4nmJI4KBps28hIhBBXwYMnfOn
         9v6Ng9+LOqgAbWiFGzqh99zStYLmAsdU+/Adb90ZQAEL47RbzqnUMuiw5FiMf7TdxExO
         iMQ9z8uHdntfN8sIeNYbUZrMMQL9cy4/ZQpDTstxVZQ0v0zj04pcSexCj/27hA/G6To+
         ln60eiV+p41m9gmm/4ioaFdbUZ+FJknFvlwXzSxYYllu7ivl55ef/jdS+ElveTD6et2r
         AYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792752138; x=1793356938;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZV4R5OqKmkTH7Oyj6hXbrI9/BN9Vv2ISKszeamvUNBA=;
        b=cnAbPt6JgbKpklvJ4315sBwY8JRR4CFa2MRpNvPI9LMdfTvRPinvuLBLtfkzHiAsEc
         E07bfw5ziiv0Fu5NA8AyfJMA+6Pz7kXPzZW3W5F4zAe0g9Z4Dj28QUf3aJyrWfNkjQ/R
         PuBuatt4AwrW8/irMOEgPlOH4rhqrHVYC16mH8Jhi9xRHdxHC7QE548blhs5W29izQ9s
         5XnBU4GmKZHJIcY/nScmjBSqh1XScky6OmrXtxeF3lC1BNk2r9IbldQJR9IoEREzk0VR
         btkRyOIYEpdXWs58W2rmjdt/zCLAG9Hs/D64+/CEmW3RzQtrVEN8Z3FiGG+m16BrbtD6
         n3pQ==
X-Gm-Message-State: AFq9FYIC76qwFtsxdkTgai5hcKgYhGgkox3hEXTI16LIVDRBcyb2P7vc
	UlD5X8xGSGvMpxnFh0YqZPdX98oUqnshKWRC+A/YcjgOvxV2aIZXIzkZIVVNX+xUvmowrdIvxLn
	nDIAp2tRHxTDDN93HUmN1vtsU+bBDlh63pqDJyEAibugF80O9vcIyXEG/CP9G9Po=
X-Gm-Gg: AYBFou3JbLzi+dVnegP8UXxsVg7QStGLaELas61yOrr9j5nAO2zXTdhnXBaiKQb9D/R
	O2+VFYv4Y2FPMF8Q1t0DoeQRd/pU57KZuWEOkuqy1JZw6SMAuTunexo7NeefOk4Fi1F/0Evr19i
	dq6Pprm4aWhdHaFwyp+AARtR5oikklVLZgb/CqnAClh9F5tvsjm+wsdHp4bFNp7ezLCftLG5wGW
	oHrtBYcp12K2pvwrwksHlpGf8etmZB0kCAskiRq9VAOBdJXxcnrKRc1kVNX5w3xiTBd5tVNSryQ
	0u3+thUejXzgwsaAEu2ZJFyBmdB/dJa62JI6IbAYCVrRrcCjJiB7zJHw0hGogKOZIZFqdlNAjZz
	Nhcx/HQZo0oCT8YB139VgccvDGTy+AYQcqPCw5MolfEjGLIjdzTolJnO1UjLfz/Ouz2JW0Q==
X-Received: by 2002:a17:90b:1fc6:b0:3ac:8446:c1a5 with SMTP id 98e67ed59e1d1-3adce7c8b49mr1499413a91.48.1792752137816;
        Fri, 23 Oct 2026 03:42:17 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc6:b0:3ac:8446:c1a5 with SMTP id 98e67ed59e1d1-3adce7c8b49mr1499374a91.48.1792752137132;
        Fri, 23 Oct 2026 03:42:17 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb1d84fasm3107033a91.12.2026.10.23.03.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 03:42:16 -0700 (PDT)
Message-ID: <8da9b59f-324b-439e-839d-bad024c8b988@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:42:09 +0800
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC] sched_ext: Support RT task within sched_ext
To: K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>,
        David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
        Changwoo Min <changwoo@igalia.com>,
        Cheng-Yang Chou
 <yphbchou0911@gmail.com>,
        Emil Tsalapatis <etsal@meta.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
        trilok.soni@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        abhijeet.dharmapurikar@oss.qualcomm.com, rohan.tabish@oss.qualcomm.com,
        guo.chen@oss.qualcomm.com, haojun.zhang@oss.qualcomm.com
References: <6b295276-4f42-4f46-b5a2-50c3ac83b412@oss.qualcomm.com>
 <52e9ca5e-0147-4450-928e-5b1c56e5d1a5@amd.com>
Content-Language: en-US
From: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
In-Reply-To: <52e9ca5e-0147-4450-928e-5b1c56e5d1a5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0MSBTYWx0ZWRfX3CDRqKU+Sp2n
 l/JJxThAuJ13Fu++EpNvtKvIo1U8v1TxWduK8cWSDvnE/vn3BMhOva2zv9a3zGB1K/ZRV3Qt5+n
 /kVSK5q2QTy/jFslDgmUyvWxnlwd9TSNi79iEW1Til6mTmvN2c2Ff4QT/drXpJL2v+79wHurFmY
 4BEOx/PK9pDVxGNTwWdeLUMofSDE7SY+uCwLQpyQhrMb89d1/k7zB0C9DI4IAWmF9Xtk/uK/68Z
 4O4QNltNaEBx+a14+7Mr/XM5m+QpCtQIds+mwzhWXcBwEE5Czw6lC+Ki4PpSK47kD9pnzAHb2i7
 z02zj6gl5h7uhehMc3uA60eO8LBSKNsr/jBWwXXFm8lpBTP04mOpqvs3VEKubnG9OpW+VAn6HtV
 2uq1ZkUmNk4bAQ96yiIS97d1QxYvovH7RcDJJd3xJ+a0ZWrVvAQKS12H5PbI9zPvTvREg30FMn7
 JxG88UnQ0FrmzFqNSfA==
X-Proofpoint-GUID: LxvPiODG6rTAOoYMlycls7GBKyjgtlGo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0MSBTYWx0ZWRfX3IX3v3ML1CQw
 KHVvYzkFa9ghvAGuW0eZR74nch29xJWS+zwv0h9tV5ANMYju9Orqld5eWvNVfVRLhtf/tBKo6Eq
 oXA3VTRFHH6LRKMk/Jj4FiR7Vz/n4C0=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb3a0b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=OGjWj8McAAAA:8 a=00vWlv48wFHvHUvh4JoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=UYjydHh6ynBBc6_pBLvz:22
X-Proofpoint-ORIG-GUID: LxvPiODG6rTAOoYMlycls7GBKyjgtlGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230041


On 10/16/2026 11:42 AM, K Prateek Nayak wrote:
> Hello Tengfei,
>
> On 10/15/2026 6:17 PM, Tengfei Fan wrote:
>> Sorry for resending this as plain text. The previous email was rejected
>> by the sched-ext mailing list because it contained HTML.
>>
>> Hi all,
>>
>> We would like to discuss how RT tasks can best coordinate with sched_ext
>> for cpu placement, cpu balance, and sched load reporting to schedutil
>> governor. This RFC is intended to continue the discussion in email list
>> from last LPC[1].
>>
>> One of the options we would like to explore is allowing sched_ext to
>> schedule some explicitly selected SCHED_FIFO/SCHED_RR tasks.
>>
>> We received feedback from Changwoo that the issue is valid, and in
>> LAVD sched-ext, they tried affining RT tasks to a limited set of CPUs as a
>> workaround for the scheduler placement, but we do know that it is not a
>> flexible enough solution.
>>
>> We also had a discussion with Andrea Righi, that he acknowledged that
>> he understands the scenario and current problem, and he would suggest
>> not changing the current core scheduler, but instead using bpf ops to
>> bring the RT tasks under the sched-ext control. We are trying to explore
>> more on this path, and welcome to suggest or comment here.
> This doing everything in sched-ext and eBPF attitude needs to change.
> Sure it is good and all to ship quickly but you'll be left with a
> sub optimal configuration forever and will always be workign around
> that.
>
> If you have some magic sauce to detect which scx threads are high
> priority and matters for the KPI, why not just send a signal to a
> userspace to demote the task temporarily to SCHED_OTHER and then
> later move it back to RT when the situation allows?
>
> You can always use a BPF Map to communicate the pids that need
> promotion / demotion right? What is stopping you from doing this?
> I thought that was the feedback from folks at LPC.
>
> And if that is not possible, maybe you can convince the folks who
> originally used the RT (most likely to get around some old issue)
> that the custom scheduler is good enough to not hamper performance
> and everything can now be a -20 nice task in sched-ext for
> scheduler to know that it must be prioritized.


We are using sched_ext for the current experiments because it gives us a 
convenient way to test different ideas. If an idea works well, we would 
be happy to bring the results back to the community and discuss whether 
a more general solution makes sense.

Simply demoting these tasks to SCHED_OTHER does not fully capture what 
we need, since we still want these selected RT application threads to 
retain their RT priority information and behavior. For example, when 
there is a choice of CPUs, we would prefer them to preempt a less 
important SCX task rather than an important one, while still allowing 
them to preempt an important SCX task when there is no better choice.

Following Andrea's suggestion, we will first explore preserving the 
requested RT policy/priority of these selected application threads as 
metadata, making them non-RT, and using this metadata for scheduling 
decisions within sched_ext. We will evaluate whether this can provide 
the behavior we need, while keeping threads that require native RT 
behavior in the RT class.


>
>> LPC topic:
>> [1] https://lpc.events/event/20/contributions/2561/
>>
>> Slides:
>> [2]
>> https://lpc.events/event/20/contributions/2561/attachments/2025/4612/2026_LPC_Support_RT_tasks_within_sched-ext_.pdf
>>
>>
>> Here is a text-based description of the main idea presented at LPC.
>> If you already have that context, you can skip the section below.
>>
>>
>> Background
>> ----------
>>
>> In most of the Android gaming, video playback, and livestreaming test
>> scenarios, non-RT threads work together with RT threads to construct and
>> consume a frame. Finishing the frame on time without frame jank is a
>> key performance KPI. A balanced workload across CPUs with fewer
>> unnecessary CPU frequency bumps is another key power KPI.
>>
>> More specifically, taking a gaming scenario for example, UnityMain and
>> UnityGfxDeviceW are the critical normal threads that have significantly
>> higher load and usually run on the most performance-efficient cpus in
>> gold/prime cluster. Other than those high load tasks, the other normal
>> tasks mostly have similar workloads.
>>
>> It has RT threads like the display HAL tasks, SurfaceFlinger, and the
>> GPU related tasks. Those RT tasks have workloads comparable to those
>> of other non-high-load normal tasks.
>>
>> In our tests, sched_ext runs in switch-all mode, with
>> SCX_OPS_SWITCH_PARTIAL unset. It schedules the non-RT tasks
>> covered by this mode. SCHED_FIFO/SCHED_RR tasks still run in
>> the native RT class.
>>
>> Below, we call these non-RT tasks "SCX tasks".
>> SCHED_DEADLINE tasks are not part of this proposal.
>>
>>
>> Observed problems
>> -----------------
>>
>> cpu placement:
>>
>> In our tests, RT tasks can run on CPUs used by important SCX tasks.
>> This can cause the SCX tasks to be preempted, waiting longer to run,
>> or lose cache locality.
>>
>> Here is a diagram for easier understanding:
>>
>>          RT task + important SCX task
>>                      |
>>                      v
>>                   same CPU
>>                      |
>>                      v
>>                CPU contention
>>                      |
>>          +-----------+-----------+
>>          |           |           |
>>     preemption   longer wait   cache impact
>>          \           |           /
>>           \          |          /
>>            +---------+---------+
>>                      |
>>                      v
>>         SCX work may finish later
>>
>> RT tasks have higher priority, so the preemption itself is
>> expected. However, from the whole scenario perspective, better CPU
>> placement could reduce this interference when another suitable CPU
>> is available.
> Seems like a generic problem, no?


This is a generic placement problem. We are currently exploring it in 
the sched_ext context, as sched_ext provides a convenient way to 
experiment with different ideas. If we learn something useful from these 
experiments, we would be happy to share the results with the community 
and further discuss how this could be developed into a more general 
solution.


>
>> Load balance:
>>
>> RT tasks can be scheduled in the same cluster of non-high load scx
>> tasks. This can also be a preferred placement decision. While the
>> load balance within the cluster is also hard to maintain.
>>
>> We sometimes see RT and SCX tasks on the same CPU while other CPUs
>> can become idle very shortly. We need to check whether those newly
>> idle CPUs can pull and run the scx tasks. While if RT tasks are also
>> in the same scx scheduler, it is easier to make decisions from a load
>> balance perspective.
> This is also a problem with fair but fair scheduler seems to have
> figured it out well - we have newidle balance to pull tasks and as
> far as I know, SCX has ops.cpu_release() callaback that can do a
> re-enqueue to a different.
>
> Why is this not enough to move this high priority task away and
> preempt something else on another CPU?


For newidle balance, pulling a preempted SCX task to another CPU may add 
waiting and migration overhead and hurt cache locality. We would prefer 
to avoid this when better initial placement is possible.

We have not looked closely at ops.cpu_release() yet. We need to evaluate 
whether it is sufficient for this case.


>
>> sched util calculation:
>>
>> We also see a difference in load tracking. Our implementation
>> uses a frame-window model for SCX tasks, while the RT load signal
>> in our setup uses PELT.
>>
>> The SCX task load is flat and steady, while the RT task load
>> sometimes spikes. An unnecessary CPU frequency bump up can be triggered
>> by RT task load spikes.
> Wasn't UCLAMP specifically designed to avoid those bumps if they
> are unnecessary? RT can make sure you preempt first and UCLAMP
> can ensure you don't boost frequency unnecessarily.
>
> I think sched-util will request the highest frequency when an RT
> task is running but that seems like a more generic problem to
> solve.


In our experiments, we observed cases where the SCX workload utilization 
was already close to a frequency transition point, and some additional 
RT load could trigger a frequency bump.

We have not yet verified whether an appropriate uclamp configuration can 
avoid this unnecessary bump while still providing the performance needed 
by the RT task.

The RT/schedutil behavior itself is a generic issue. We are currently 
exploring it in the sched_ext context, as sched_ext provides a 
convenient way to experiment with different ideas. If we learn something 
useful from these experiments, we would be happy to share the results 
with the community and further discuss how this could be developed into 
a more general solution.


>
>> Why CPU affinity is not enough
>> ------------------------------
>>
>> We could use CPU affinity to keep RT and important SCX tasks
>> on different CPUs. This could reduce the time they compete
>> for the same CPU.
>>
>> However, CPU affinity is fixed and strictly limits how tasks can move
>> between CPUs. If the number of background tasks increases, CPUs perferred
>> for critical SCX tasks may still have spare capacity. With fixed CPU
>> affinity, non-critical SCX tasks cannot use those CPUs even when doing
>> so would help balance the system load.
>>
>> Ideally, the scheduler should be able to choose CPUs dynamically as
>> the load changes, while still keeping tasks within their allowed CPU
>> masks.
>>
>> CPU affinity may still help, but it does not provide the
>> flexibility we want here.
> If you can consider cpu affinities an option, you can also consider
> demoting them to SCHED_OTHER as an option no?


CPU affinity was not intended as the solution here.

Simply demoting these tasks to SCHED_OTHER would not fully capture what 
we need, since we still want to retain their requested RT 
policy/priority as information for scheduling decisions. Following 
Andrea's suggestion, we will explore keeping these attributes as 
metadata, making the selected application threads non-RT, and using the 
metadata within sched_ext to provide the placement behavior we need.


>
>> Possible options
>> ----------------
>>
>> One option is to let sched_ext schedule some explicitly selected RT
>> threads together with SCX tasks.
> Who gets to decide this selection of threads?


We don't have a final selection mechanism yet. For the initial 
evaluation of Andrea's suggestion, the selected application threads will 
be explicitly specified by userspace through a simple configuration, 
e.g. by PID. This is only intended for validating the approach; we have 
not settled on how the selection should be made in the final design.


>
>> This could let one scheduler choose CPUs for both selected RT
>> threads and SCX tasks.
>>
>> For example, if other cpu is idle, or running a low priority scx task,
>> or running a low load scx task, an RT task could use that CPU instead
>> of a CPU running an important high load SCX task. This could reduce CPU
>> contention for the frame important KPI and help balance RT and SCX tasks
>> across CPUs.
>>
>> Such placement should remain a preference rather than a fixed
>> rule. It must respect the RT task's priority, timing needs, and
>> allowed CPU mask. The other CPU must also have enough capacity.
> I fail to see how "RT task's priority" is respected if you are
> suggesting a SCHED_OTHER task can be prioritized over it.
>
> Also how do you infer a timing needs of RT? From a traditional
> theory perspective, if the task is of a higher priority, it
> always preempts.


We are not suggesting that a SCHED_OTHER task should have higher 
priority than an RT task. What we are describing is a placement 
preference when selecting a CPU for the RT task. For example, when 
multiple suitable CPUs are available, we would prefer the RT task to 
preempt a less important SCX task rather than an important one. If there 
is no better choice, however, the RT task should still be able to 
preempt the important SCX task.

The term "timing needs" was not well defined here. For 
SCHED_FIFO/SCHED_RR tasks, we do not have a separate timing requirement 
beyond the scheduling policy/priority, so this wording was misleading.


>
>> It could also allow RT and SCX tasks to use the same utilization
>> model. We would like to study whether this can make the load
>> signal more stable and reduce late CPU frequency changes.
>>
>> Another option is to keep all RT tasks in the native RT
>> class, but provide enough information for the two schedulers
>> to better coordinate CPU placement. However, this would also require
>> placement and load synchronization between the RT scheduling class
>> and the sched_ext class.
> This can be a generic optimization too right? If RT task has a
> choice to be scheduled on a bunch of CPU, maybe there are
> heuristics that can be used using nice value, CPU load to better
> place them.


This can also be a generic placement optimization. As mentioned above, 
we are currently exploring it in the sched_ext context, as sched_ext 
provides a convenient way to experiment with different ideas. If we 
learn something useful from these experiments, we would be happy to 
share the results with the community and further discuss how this could 
be developed into a more general solution.


>
>> After the LPC discussion, we'd like to explore option 1 and use
>> BPF-only hooks to achieve current needed RT tasks within scx class.
> I don't like it one bit but what exactly are you planning to do
> with this BPF op?
>
> Direct RT task placement to another CPU? How is the RT scheduler
> supposed to verify if that alternate placement doesn't violate the
> RT guarantees? (And please don't say you'll use the ext's dispatch
> path to do this)


The suggestion at LPC came from Andrea. We don't consider to directly 
place native RT tasks on another CPU through the sched_ext dispatch 
path. As discussed above, we will instead explore preserving the 
requested RT policy/priority of selected application threads as BPF 
metadata, making those threads non-RT, and using the metadata for 
scheduling decisions within sched_ext.


>> One option is to have all RT tasks with a priority lower than the SCX
>>   helper thread go into sched_ext.
>>
>> Migration thread, sched-ext enable/disable threads and IRQ threads need
>> to remain outside sched_ext. With this option, we will need to verify
>> more common scenarios. We can explore the first option first.
>>
>>
>> Open questions
>> --------------
>>
>> * Can sched deadline can used to optimize those scenarios?
>>
>>    It is possible, of course, so we put it here, welcome to share the
>>    possible configurations of which tasks goes to deadline. However, here
>>    we discuss only the topic of plugging RT tasks into and out of
>>    sched_ext for these scenarios. For different scenarios optimization,
>>    there is of course no single solution. It still can have different
>>    scheduler optimization to make a specific tasks a different sched-class.
>>
>> * Other ideas?
> You can always demote these tasks from the userspace bit of
> sched-ext and there is no explanation in this entire write-up
> that says why that is bad / insufficient.


As mentioned above, simply demoting these tasks to SCHED_OTHER does not 
fully capture what we need. We still want to retain the RT priority 
information of these selected application threads and use it for 
scheduling decisions. For example, when multiple suitable CPUs are 
available, we would prefer these tasks to preempt a less important SCX 
task rather than an important one. If there is no better choice, 
however, they should still be able to preempt an important SCX task.


>> We would appreciate feedback on the problem, the possible
>> directions, and what we should try first.
