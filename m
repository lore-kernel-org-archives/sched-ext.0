Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A53309DB1
	for <sched-ext@lists.linux.dev>; Wed, 19 Nov 2025 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571296; cv=none; b=olCiqY86j5rb6OvUj6Mn4Q1gKxdlTHSAenauLUuEKTGgNXg+AgBOPvtQmpSu371aS7QpDQWIFDABDKLXpA+FGsOmxZ+Gn9Mve8UjOolR86UUhy+V6TBjcCD/IthbcpN/GIFBpZDIWPaGePkGKlIlQC4faLahmVxbJcTSpO1i544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571296; c=relaxed/simple;
	bh=pkCDzPnI2lQYnsPz3aoF2VAkpie5CWQDanbduneyFcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jU7KsQtzt06cJ3X85wTaYWFoMGS5H2ZbK+xyLHGFknydpNJ+NVxi8QNk6EdF9K7rZV+nngzH8LSTfe3SVPkYfVsS88sgId1AOgjAx6XLZMHsarL6wlGJ02qLyu+wN8XHCUvxP+PiTvEv8qGUMcjH4CzV2U3gz7wU+CKq95XQwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WY5GoJ+0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WY5GoJ+0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8t1pd011607;
	Wed, 19 Nov 2025 16:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q6xPa7
	bRjRBEOQRFne4NAtS4VVpytqhFmuJFIjeUAUw=; b=WY5GoJ+0212zgs/DpdXHUR
	H3BOePVvPPwGRFkPUkWzGfIrNdJFpxerF5WbkhYQXK90AMCrQ2JBh6D5t80IMQ6G
	zKgJO9fKAxicALdPbNyZc1BUtdqe7S5xr3sNWZSDjiku12nPykX+TeoNN7anIpgk
	sc55sOtL68juscheTvgfEgnwsME89cGKweaAkrGPAh3xCI8AusF8i2qUYdUxjFO1
	a3KUdov06Jpa7wEqQR72qCe4KIvGTm6s/x7C8vi6S9PA+lG+JOUZTTjhbHWB2FJg
	ufl/tabTN5jD4oaHmNRbgur1dUme1/Ky68fh8N4waXq7XIekxRmFGT2e8WtwG8FQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1hswd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 16:54:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJGsY7l025736;
	Wed, 19 Nov 2025 16:54:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1hsw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 16:54:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJESvET030851;
	Wed, 19 Nov 2025 16:54:33 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47y1xvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 16:54:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJGsWoR16777968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:54:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4750658065;
	Wed, 19 Nov 2025 16:54:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E573F58069;
	Wed, 19 Nov 2025 16:54:26 +0000 (GMT)
Received: from [9.61.247.101] (unknown [9.61.247.101])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 16:54:26 +0000 (GMT)
Message-ID: <b8391b8e-ec67-4e84-a0d7-529e85660f5a@linux.ibm.com>
Date: Wed, 19 Nov 2025 22:24:25 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Fix scx_enable() crash on helper kthread
 creation failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, sched-ext@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, tj@kernel.org,
        void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com
References: <20251119103722.309211-1-skb99@linux.ibm.com>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20251119103722.309211-1-skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691df64b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=FvzHxZVCrgmYc3naLNIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xX26GOivM6G9BMhPWME1v2zcBscNtOnK
X-Proofpoint-ORIG-GUID: HB7NAfJXeiaNW8Sjh650vvH9hN2bGhAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX6dWjdMoydYrY
 Q08xO7MN36MUzKvZGyD/4vtD/y/G5akrF/LxfjVo5+uRyfZ45CurYJxLOmzaa2pxnW0vmig/dLQ
 0iLzwBi+1iEP5DBp/+wjlZF+vZZ9f+zpExMh5vMkxggOcWrOmF8pRA9jtfWDufOwuPaERMUrjvP
 Ij7tHDuLyzSv0YMZZa5vIxcB+j1a1mMPQAEm/9st5DGGtXCUu+l2R/FOId4IOsDOcdjf28c9UwC
 fgACwPVFFRlsPX7yZxqLezx6hutndm+Gqh4IHxg2oLSpUI0O2icRDt5fZQU5vhNiTt2GWsf/AnN
 AnRa9Ff+xzpm9e8jsXpJQLiqmPd0xaGViLFpha6NDgnwo5xTFgW2s+siywQamzs8oe3JvGHnARf
 cDHEllZputd9Cjfis8rX//Q6My4eVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032


On 19/11/25 4:07 pm, Saket Kumar Bhaskar wrote:
> A crash was observed when the sched_ext selftests runner was
> terminated with Ctrl+\ while test 15 was running:
>
> NIP [c00000000028fa58] scx_enable.constprop.0+0x358/0x12b0
> LR [c00000000028fa2c] scx_enable.constprop.0+0x32c/0x12b0
> Call Trace:
> scx_enable.constprop.0+0x32c/0x12b0 (unreliable)
> bpf_struct_ops_link_create+0x18c/0x22c
> __sys_bpf+0x23f8/0x3044
> sys_bpf+0x2c/0x6c
> system_call_exception+0x124/0x320
> system_call_vectored_common+0x15c/0x2ec
>
> kthread_run_worker() returns an ERR_PTR() on failure rather than NULL,
> but the current code in scx_alloc_and_add_sched() only checks for a NULL
> helper. Incase of failure on SIGQUIT, the error is not handled in
> scx_alloc_and_add_sched() and scx_enable() ends up dereferencing an
> error pointer.
>
> Error handling is fixed in scx_alloc_and_add_sched() to propagate
> PTR_ERR() into ret, so that scx_enable() jumps to the existing error
> path, avoiding random dereference on failure.
>
> Fixes: bff3b5aec1b7 ("sched_ext: Move disable machinery into scx_sched")
> Reported-by: Samir Mulani <samir@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   kernel/sched/ext.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2b0e88206d07..7fc0cce68a1b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4392,8 +4392,11 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
>   		goto err_free_gdsqs;
>   
>   	sch->helper = kthread_run_worker(0, "sched_ext_helper");
> -	if (!sch->helper)
> +	if (IS_ERR(sch->helper)) {
> +		ret = PTR_ERR(sch->helper);
>   		goto err_free_pcpu;
> +	}
> +
>   	sched_set_fifo(sch->helper->task);
>   
>   	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
Hi,

I have validated this patch using the tools/testing/selftests/sched_ext 
test suite, and all tests passed without any issues.

Thank you for the fix ..!!
Please add below tag for the patch set.
Tested-by: Samir M <samir@linux.ibm.com>

Regards,
Samir
