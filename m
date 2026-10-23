Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792751556;
	b=0AC0XmTogduKaTj5qYGJXPF53dzOr6fYVGzacxYP8hjBzFe5qKVFP0LOUyCLOVBwulV/
	 9Ys3tFuxmqmNgU0pJs66DTR1iXGlKyQw8vUL1niHEWNMTSwFgx/wElnsEAdJH7Bg5105h
	 rgnG4v1RoIzDrEp7NYXnqcLKwubyiV+GZn+yXRNAID35BCmFbxkTebN1Ii120e+MxTIb3
	 laUySRIwrOB9lPunlCVDorFn0M8s2wS6oHTxXO7TIRst/2QZbZoMenPPyDW1M51M4pNs+
	 eM/4hzHvoz/DO2c0facIX9pz77ITTfebd72WYisSQrLLoL7pkaTglL1QNGJOrelT4/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792751556;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HMuaYCpA/e+dlFcm3ZWdKsQuoNOCcM75wMFXYmlLNfM=;
	b=LF6Z64qUHG99ZNTpr0g7sPPkxO/7LFpRplqnpHUXkHwoBLKEVrg3dIo3xcyBHKciwZm1
	 5iXen1ENFL1sAjcHbrQZ+GMUdxG6uEwV9bUQpON1pV8kEabTselWp/WCSrd0rQEtMTYFi
	 4HcIMkhzSsNJ5Iz+54sTbeAC7pMqsrVEylI7lGy7/ZzGTFpQp7bQ9jhuDwv5PfWp5ReM6
	 o4RcSFn/PI9TlHzWIP3qQbZeq4ZozwuU7E17O9UEEnvxaQi3ZKZ1vVOEsH2GARJkJS6r2
	 RkbCS7yNi16VFB8LtFitsu/HJmlWX9jsE53Go0ghDHVGNPYR9MbwbpEC6+NV+AdzhQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bQl6oOUU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iAEq24UK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED34606A31B
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 10:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BED34606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bQl6oOUU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iAEq24UK
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAbrh980694
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 10:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HMuaYCpA/e+dlFcm3ZWdKsQuoNOCcM75wMFXYmlLNfM=; b=bQl6oOUUq/Z9hFq4
	aVYDZ2BtjLebKbnQDqakFGMqx8g6/L1nU0tUqVxFhw3SVKt1rPOf22cGR3wAk+kE
	usvWc++X5lqMTETZEHz70TiuXAZLUYrberzPj3FgeoJKT8oO5bri/fiGUXasZyt4
	7cySdvIA0eAMgvaGMJwOEYSjfCz8Xq827KBVWMCif6CfE6G5RIqmeGquTI+WItBn
	3+NqNPwPEiqgi8+ySp5f9LMSL3SeWn5spDRm3BvGGoo1/irmnslzJ7gB6vM2ZA2U
	iDT58qirKAfQZhxFlY7Q1KKgBZ/f8PEEbXZwNE2yZKZ+PljziE9Vd18J223JjL6e
	EHyBXA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmatq0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 10:32:34 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a03834d8ffso1142531b3a.3
        for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792751554; x=1793356354; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HMuaYCpA/e+dlFcm3ZWdKsQuoNOCcM75wMFXYmlLNfM=;
        b=iAEq24UKI8o9moIO3wwYu+BbCVi899MyOjobL5atVs4eXu/PbiMVf/WL2BXO25ZsPL
         fVwegzfLQtDEAXPXUQlON6xSa/KqUOJUUdrM9rnukyBR4ZwQCHoCsXffz98+TMH4EPiK
         9CD9KhHkjYmXt5Sorv22Ld6wgWRYvm44G9hJ9fTkE60NOCvqc3jxuvsYtXMMCO9DxUL1
         ULMJ1ODnttELV8K1rc0NJ43EcDMo7tCbHaproUJhdiHarKD6pJyV5d3HmkOOpfHZLUUR
         EDmBTO6L6iqgLeLALNngGoA8UIvhKyNY+omYJtTgpbBxKoZ42jvujihp2+bteAQe4pHR
         up2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792751554; x=1793356354;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HMuaYCpA/e+dlFcm3ZWdKsQuoNOCcM75wMFXYmlLNfM=;
        b=E3scNJ+npXdOYsFQavDzvu/f0DYMMuPgFHl+pDuwAporAEI3EcQt8K9WShk8WHDadv
         WYdSutc3s3Dv4Mv0UAgZD9AYEQ6mIidqf3LZtmyAR2oGBre0puQn7M3mNB/TLqiLaa60
         WgGk0nW+5llEj1p2BHZw5Tz6GBjvLuK+y7HzZ6wN64nIPUsfEye7onyULz+mb1O3MWhT
         efdw5zO+YKnJYFIOZ5fyK9ZAT28SIDpAzXNvgkoadj6l+6vJp20yjcaLVVeLwijbxa71
         kKpxxnEdXSzTih5EW3UKut81+W/ZIaiqGXsLvpDjzwLTYykdXm98rUAWC2UY9QkPvZBL
         76hQ==
X-Forwarded-Encrypted: i=1; AKwUvBwl4nMeimpMfMcqqjDDq3SPT1xDNdmpqjd7v2dlWvOBk3csJ0gdNTq3dnBK8lU2IjuUkKK30DLCrhc=@lists.linux.dev
X-Gm-Message-State: AFq9FYJwk3e8UY/thr+YbcN92RhaKr/8ef32wyfLYqNw/yy0NzHMw0/+
	Vq6UZskfilDosYLWvnZkQ6n6LQZtBcGA0UzBaD25Dc9ikp8c+aswGWMuIsx2Cjoc2+gdfCU8Atc
	Cy4iRA0z+8h2hW9lZDCVIz8DdrVuMs/ZS4GRb46GxCt46et/NeV4AXHznSaWFeQc=
X-Gm-Gg: AYBFou04fTxubGdq8afipOSyk4vcgcwSh6zFpuHoQo0++MSQU6Vd+USRKhOyOkFAz+5
	NOX5CnGriFGiL5UN8IQhaHiKnHa49QGcEImOJJ8sfkwyfjW6/l6pF15e0SvvHZ8El4biQduEv6T
	grKr90ggAv/HkDzjQpGnbpApnzVMxJSfceZjYrphRbtulDgSBDe+wU/KibHmWzU1PXldEifmvnq
	WevQpZrLThcBHgD2SEAJ5A57xerzGQLd59HSWtL2OJCISHu4IhnqysIX0LJKtKK7QE2JpGP4O4x
	L288iY+ZKBanvjX4Gxumz/A/dZ36pnwK5XL9Hl9pshXR7gcdFwIsw/oHYsLF3K3VGG90LEyh6Hc
	mBl1GmDHSBTeJaiatFNVSho9fvDLxkLKOjOPWS9vGzu3e76wnZ3yDqZzGVJv7F2/8anG3aDw=
X-Received: by 2002:a05:6a00:17a7:b0:857:7337:5db7 with SMTP id d2e1a72fcca58-8a2c6501cd9mr1651646b3a.21.1792751554148;
        Fri, 23 Oct 2026 03:32:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a7:b0:857:7337:5db7 with SMTP id d2e1a72fcca58-8a2c6501cd9mr1651615b3a.21.1792751553661;
        Fri, 23 Oct 2026 03:32:33 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a2c8ffc99bsm579150b3a.43.2026.10.23.03.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 03:32:32 -0700 (PDT)
Message-ID: <6c17505f-e5a1-4505-a6b4-08b0c88a6dfb@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:32:26 +0800
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
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
        Changwoo Min <changwoo@igalia.com>,
        Cheng-Yang Chou
 <yphbchou0911@gmail.com>,
        Emil Tsalapatis <etsal@meta.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>, sched-ext@lists.linux.dev,
        linux-kernel@vger.kernel.org, trilok.soni@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, abhijeet.dharmapurikar@oss.qualcomm.com,
        rohan.tabish@oss.qualcomm.com, guo.chen@oss.qualcomm.com,
        haojun.zhang@oss.qualcomm.com
References: <6b295276-4f42-4f46-b5a2-50c3ac83b412@oss.qualcomm.com>
 <atEBWwXSt4D8befY@slm.duckdns.org>
Content-Language: en-US
From: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
In-Reply-To: <atEBWwXSt4D8befY@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb37c2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=gj-EQvdIbOrD_K2NeO4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0MCBTYWx0ZWRfXzMf/6iqAoNHF
 PvhYsuj+HweLKmOIC3APOtzX1nc3R1aiAK/IRKmLZ8yydODz6yLN4k/NI6xGWUTkHZAoANFLQHr
 7TAzn2J//aY+vfciwQcUlTK3wX7D99Y=
X-Proofpoint-GUID: snCQk-VhehSEsqTlezu_MgTE0-I-zTrx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0MCBTYWx0ZWRfX6mCCSLDmkXfs
 g24x93CZDRs87ilIavAzVbZ3JZ6IwcYpTDKOSp25B/Q7Qb1QmNilHznuuOYU5fSlVBXB1FF4irD
 w2mviiTPUJRFEW5VMn0HPsFXuhNu46/Toz4Xrpw2n9TXDMM5ihy3AorHttdHGI1Nl+Pg5oke6qD
 79bIjeY7sq1FeeruaE4dMp+kMfTq+xXnUXJ/j9j/o/8o47YtZnUxgS8t0n6XBV2EM7ZoLaTxVCv
 71gcxgmIl5/oDzVLLt+rJvZKRkIe7M5axlrRpcrI8OrjUcBewM/7Ht/Mq0zWrM0ZLZjh4muiQfe
 7n5TnfkLXuU0L/zSGvryBJAZ52PXMGESTM6E5bRb9WHbRYhKQ3aEynH43C+dqdkXWfvQY3pPD99
 hrMRbRfynyorSfrGgHHOx0Wr7IubgZM4frFeZVVz/HJT4Ge7qh0pmrtEgcDzZope2QgloMfzURn
 xqfVGQSZ5U07dynpF/g==
X-Proofpoint-ORIG-GUID: snCQk-VhehSEsqTlezu_MgTE0-I-zTrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230040


On 10/16/2026 12:37 AM, Tejun Heo wrote:
> Hello, Tengfei.
>
> On Thu, Oct 15, 2026 at 08:47:12PM +0800, Tengfei Fan wrote:
>> Possible options
>> ----------------
>>
>> One option is to let sched_ext schedule some explicitly selected RT
>> threads together with SCX tasks.
>>
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
>>
>> It could also allow RT and SCX tasks to use the same utilization
>> model. We would like to study whether this can make the load
>> signal more stable and reduce late CPU frequency changes.
>>
>> Another option is to keep all RT tasks in the native RT
>> class, but provide enough information for the two schedulers
>> to better coordinate CPU placement. However, this would also require
>> placement and load synchronization between the RT scheduling class
>> and the sched_ext class.
>>
>> After the LPC discussion, we'd like to explore option 1 and use
>> BPF-only hooks to achieve current needed RT tasks within scx class.
>>
>> One option is to have all RT tasks with a priority lower than the SCX
>>   helper thread go into sched_ext.
>>
>> Migration thread, sched-ext enable/disable threads and IRQ threads need
>> to remain outside sched_ext. With this option, we will need to verify
>> more common scenarios. We can explore the first option first.
> Isn't an obvious option to just make them non-RT? The load tracking aside,
> the fundamental problem seems like you don't want these threads to be always
> prioritized over some of the OTHER class tasks, which definitionally means
> that they shouldn't be RT, no?
>
> Thanks.

We still want these selected RT application threads to retain their RT 
behavior. For example, if an important SCX task is running on one CPU 
while another suitable CPU is running a less important SCX task, we 
would prefer the selected RT task to preempt the less important SCX 
task. However, this is only a placement preference. If there is no 
better CPU available, the selected RT task should still be able to 
preempt an important SCX task.

Following Andrea's suggestion, we will first explore preserving the 
requested RT policy/priority as metadata, making these selected 
application threads non-RT, and handling them within sched_ext using 
this metadata for scheduling decisions. We will evaluate whether this 
can provide the behavior we need while keeping threads that require 
native RT behavior in the RT class.
>
