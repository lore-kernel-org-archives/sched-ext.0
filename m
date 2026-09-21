Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEFC3AE1BD
	for <sched-ext@lists.linux.dev>; Mon, 21 Sep 2026 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976835; cv=none; b=Kx7vZqmJ8R7rBmbcBqmpWcy3gBD5u2aBpyE0vDcgdqaPN2FJtPJmY+OWQVgzRGJNcLb1g85FlgG3iAjZjhMQZjh07hTtQTYP4IUaERIdXQpDTYw4GkU5GThAFtbAejl31xDaeZbOR39QxkW3dGn9DLeo/5jpryjgUvlxwud5T00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976835; c=relaxed/simple;
	bh=uHqzEv3bxIoes2LtlPov0BRmSAZOsCBWSajsNKxiV1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/awxCybqWanpTDRdVz+QLaBZUjdpxNgZ8Foe/P6gKxKOukAKlqwLCB7vKkWhfaGjUyNHCEdaAdrg4gjsCI7gm/vacCiMCg9f9hAf5UKq6doj6NoBZOwk6hrpdu4Swz/A5UBZo4aj1RTsPqK7vyR9rYthlH81UEUdxphF2CiHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UA0o/9zZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eoy6PZZD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UA0o/9zZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eoy6PZZD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7AOIJ4013393
	for <sched-ext@lists.linux.dev>; Mon, 21 Sep 2026 07:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gUu4bEc3zeYui4hd3ktvRDKKi+11f2S8vhCkBPJg2go=; b=UA0o/9zZBA88HlBd
	W4hiEnubln+RVKIrC8iim/G+mK9eUvVH5J/D/ZBx20NSuM0S5aoPeUpxzT//oWEQ
	2xVGC6REZnN29C9Gmex+ttlwkfjYkEzps/LTR3hT6QASlgGAzqH2ZQlPZQqe4MAF
	2j/ypFkTm5WK5MfvTg0cbn22QFxUGn/P8Bt20SF+Yzao9qrVoNNqUem1tGcFPz5Y
	SztqCXex+ruMK642k6XCGun0fhirhGyPG1to7jhVsNFJv+7ion4Tz0m5DBllvwan
	/XN9OLQZHfexRmxzXYla/TON/KzVgGjR+IelHeJd+zpR3WjsCPIr9GR6xUu7Q6JE
	Xn6P7A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjs859fx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Mon, 21 Sep 2026 07:47:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dc7337e2a7so34746995ad.0
        for <sched-ext@lists.linux.dev>; Mon, 21 Sep 2026 00:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789976832; x=1790581632; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gUu4bEc3zeYui4hd3ktvRDKKi+11f2S8vhCkBPJg2go=;
        b=Eoy6PZZD/Lnl3snTjkfYEjMW1jphoZSMdx1euyzu6WlCwrJ4KPlw2I/FvxTI4VCSyy
         MoS6JLzs5wLa3q/SjMYULOzCIoUglgvck6GE5yJBS2LKiIlHXJxuBSR6uCkvtzdtW3hS
         FQQPievkMcYC4/fo9g8ie1xLZVU5iy0u6Uv6tImV8JKsIVMHY19qkhC4mBhmr4DlbGzg
         ks2ijfr9Nm0TONdlZQHo/BhOIlDQraAibxVm3BshqKMdBa5f14mcqWvDtXYJZrbyZ2hb
         ap8nLPw1NHKtxw8v5Zi441tEz1YgS43TJIA8g72qgXGYZpNaNUeaDYwy4tNH87Mtiupi
         lRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976832; x=1790581632;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUu4bEc3zeYui4hd3ktvRDKKi+11f2S8vhCkBPJg2go=;
        b=ebMpKifRlSUjbl10x3WVtqVCyLHuRt0JelZh5fRIKQ+AfW0FpltMXE7vuMQ+Rtpo+J
         sUr+7yb9xgE1WM8xMyrmpYIo/8F0J7+xrhRP8vdV6s2+Q5+f39U8s/+RZ5pdLMRrGA+R
         t9TxUqiTF3C+v9CaVKBjwxI7V2YV0LDlUEBkdsgYkEWVGemOk36oiSzcny0titULufLV
         MC9eEOfm7xaiI/F9839vd5YZ0x0wIYAJgcpjWe7eXdlCyqqLYMhMj/2X8rdEcbpbz7gN
         R3KE08d9iTlSHMCZyXRicqhQSu80RLaU8Ef4iiwdiLwPQ4J/3yKuHB/V7oTK/GzRaH16
         TZHg==
X-Forwarded-Encrypted: i=1; AKwUvByvcnxytxueS0ygwZPH6s32Y1Tyez0WcVso9mQJI8vtoIkdG0AuCkZO22FYs7p0L6kPqEB7dU6Yv6E=@lists.linux.dev
X-Gm-Message-State: AFuF++na4QmR9zzbQI3OjdAF8IDu5Fpnosp8LRw/Lb5Zq9FBrzBjiS6i
	6aMF9/evFf4CfXTcmp1Pf+LOg6c+OUBEUEq0boAF4Vsrdv87PSr3bD2Ul+1/cccsEGu8T/TAy6a
	0H55yGFtxhEkZZeeY6jPeJwXWnc4IRjMkr1fTkbhwYwwnFsM3CTjws1j0iRna358=
X-Gm-Gg: AYBFou0NTkIHcgoiwj1yh+O2lrRsW9EqpXObJ9W7KjcHkSFwKrXrLOgD5K6V3GXLTUk
	NPT8AE7byM002w8FZzw5Clvjy7NF9rCgzOWXw9KxCjoWxnbqEKsaDlcRO6UxPrA/6gc+AjhjnZc
	OOPV4M94EnsrqTU7AUuWlRq4BM188UQO2ATvKD66EsOIUiZXrnDOO8n6+3UBQr6kob/FmAr9D8U
	O5CJqWbXGdu4WDfvL25LYaSq4T9iFyHbW2thyEEtYIXA0zCZRlScsv9cTJRIAMScaVDMtavZ8WC
	jZ1QxfuMv6ovlWnqLEeNGsqbBvia2sdkHw/NzVy+3ISA2+t5dPdrNBze2QbLdfUKewQaGI1RC8y
	XKoyxyGQu0CipxeS/rj3XVKhcLHtj
X-Received: by 2002:a17:903:298e:b0:2dd:c100:80c1 with SMTP id d9443c01a7336-2ddc10081dcmr89823265ad.60.1789976831689;
        Mon, 21 Sep 2026 00:47:11 -0700 (PDT)
X-Received: by 2002:a17:903:298e:b0:2dd:c100:80c1 with SMTP id d9443c01a7336-2ddc10081dcmr89823025ad.60.1789976831226;
        Mon, 21 Sep 2026 00:47:11 -0700 (PDT)
Received: from [10.239.132.187] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179e248sm29105175ad.36.2026.09.21.00.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 00:47:10 -0700 (PDT)
Message-ID: <f8e91551-64d8-4cad-9757-f461fb13fb7c@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 15:47:07 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched: add CONFIG_SCHED_EXT_RT_EXPERIMENTAL to move
 SCHED_EXT above SCHED_RR/SCHED_FIFO
To: Tejun Heo <tj@kernel.org>,
        Fredrik Boettger Bratberg <fredrik.b.bratberg@gmail.com>
Cc: Henrik Austad <henrik@austad.us>, Peter Ziljstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@kernel.org>, linux-rt-devel@lists.linux.dev,
        sched-ext@lists.linux.dev, aiqun.yu@oss.qualcomm.com
References: <20260414125933.3520885-1-fredrik.b.bratberg@gmail.com>
 <ad539mUd8A0lDWAw@slm.duckdns.org>
Content-Language: en-US
From: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
In-Reply-To: <ad539mUd8A0lDWAw@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: w-DWwuQSH5qh9rrJENeLTib5Ay1a63XS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDExMCBTYWx0ZWRfX5Wxou2XC+z57
 m9RPuaUH1GFla5RjhUZB/6gmF3MWWNO9otVJ6YuUvSscaimefdMvL60tSYnGB3o/NkODxNTPZoV
 Miag1ec0N5V1PAeASam4de5l9NeXYPY=
X-Authority-Analysis: v=2.4 cv=YqWa1IYX c=1 sm=1 tr=0 ts=6ab0e100 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=8ueUhNlu720Qx81Ww3kA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDExMCBTYWx0ZWRfXxVeKZHa2D9hB
 n1/VwGDm8r5gOc1e73Ddd5KpzRSTFZyZUkY2Bbjt00E+r5IbetmvsVjbYDcuSI/PCFp2yClnVBC
 7TuXSV/8ftwJv2Np9ShVePQCISU5sXxTXkCwU6qZdpqc7P8MfxEAuRCxH7I8/2uJMV6nQJJabId
 YnKGKQ6Q8xW+KYdsRIxsqOun2bKFB7XH4MrF3ZoCKPKB1tCL3dnIYMNXORwm5UmrnidQPYIo16N
 rsMzKmFjc0k5X5zP6V+fnmRWkdUmUEml4sEWrlLOeSRsMPMV5ofjwfBxpXH1SfIcPXuGVkh5K61
 /IRXbbpkZgaxIOiNXO1d7ylRKWPqHVqBVBalB/WfJ0IN9GSQP09M1W/8nkihQURTGgfHoiFlgki
 oAuqGZ8IdnMCXxmynPpsUy8snojMqi44WqGOdrUUBTZpIP+TERkLFMullE5ZYfxWdteSEyfv3RB
 I3s4X1cRuhholnmR/fA==
X-Proofpoint-GUID: w-DWwuQSH5qh9rrJENeLTib5Ay1a63XS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210110


On 4/15/2026 1:23 AM, Tejun Heo wrote:
> Hello,
>
> On Tue, Apr 14, 2026 at 02:59:33PM +0200, Fredrik Boettger Bratberg wrote:
>> A recent paper published in the 2025 Real-Time Systems Symposium (RTSS)
>> "Enabling Flexible Scheduling in ROS 2", would presumably also benefint
>> from this feature. The paper aims to address and improve the real-time
>> capabilities of Robot Operating System 2 (ROS2). As part of their paper
>> they implement an EDF using sched_ext. They do not explicitly address the
>> issue of their EDF SCHED_EXT tasks effectively having a lower priority than
>> SCHED_NORMAL, but it is a known limitation of the current sched_ext class
>> placement
> Isn't that mostly solvable by just not putting tasks in DL/RT and enabling
> switching_all?

Sched_ext is an enhancement mechanism rather than a replacement for RT 
scheduling. RT scheduling continues to provide the latency guarantees, 
safety properties, and forward-progress guarantees required by the 
system. Additionally, the system must remain fully functional if 
sched_ext exits and falls back to the in-kernel scheduler. As a result, 
in real-world systems, assuming that RT workloads can simply be 
eliminated is often not practical.
>
>> This change conditionally reorders sched_class selection such that, when
>> enabled:
>>
>>    STOP > DL > EXT > RT > FAIR > IDLE
> The problem is that RT being above EXT is required for safety as EXT depends
> on RT superceding it for enable/disable path forward progress guarantee. If
> you put EXT on top of RT, it's relatively easy to stall out the whole system
> without any way to recover it.

Rather than requiring all RT tasks to be isolated from sched_ext, it may
be beneficial to distinguish between recovery-critical RT tasks and
non-critical RT tasks. Recovery-critical RT tasks would remain outside
sched_ext control to guarantee safety and recoverability, while
non-critical RT tasks could optionally be handed over to sched_ext.

This would provide a balance between robustness and flexibility. In
practice, many RT tasks, particularly those with lower priorities, are
used to satisfy latency requirements while still being tightly coupled
with the scheduling behavior of other workloads. Allowing sched_ext to
coordinate these tasks may result in better overall scheduling outcomes
and workload-aware optimizations.

>
> Thanks.
>
