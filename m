Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88522D9491
	for <sched-ext@lists.linux.dev>; Thu, 20 Nov 2025 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623957; cv=none; b=HW3X59FeSsmQGU4y/vPqDHi2/Zb+m6/drD8shxtjuwbpRvcDOJbjxMt+qFV9wuku/WF/clicOzg+ukImUQP9YIfvbizyfktFfg2vQ6dIcpaCpsHfaZ6AX/etMI/Lm+EIZUCz4t3QPUaOiqI9f4ZIs6g9UN3s9Os0g00hb9C+buM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623957; c=relaxed/simple;
	bh=YNx2njrxVPH1MBP+/u0kea3M57xiWKqUJ9JPCcFcnOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbN5DYZjdgm0j5r9IPEm2+qAdkutoTkDjBf61KZrLOXFPppgsnJEi2qVqlaM2PijtSdypGxgZ4840ympg7/4jZIodu+3gSDIxTuTUMFhUMcyJ/WP0zF+xYxopr5fsHfVKsC/spKLQOJDsimfZMaZwPHsHe5BbyhhsTt6JNCkItc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SDg9a6Jw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SDg9a6Jw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJLksAa002688;
	Thu, 20 Nov 2025 07:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nlH/XdTUNjxgFyXUlVsWS4ZTV2ADJ0
	/mJfZ/+jZGrXw=; b=SDg9a6Jwy4ubUIU050/DSmoiRYmug4FnWPlQC58yf3m5TP
	Ykg7EPN+vzXGH3+bbW2/2I69bDuOfB3ztA/U66XQMtUOWnlLqImr3CUGg65/TE/m
	xeH20iTyW135bJ/w2r4Up9Ylt6Yrb9KR/iFKoOKbFFuW3BRvlmMOkVZmYjiOMHHV
	cbBVkIFV76BFNoMBHYKRmyxI1dOEPpp9l+Naeit+F1ZRT7Dwfji3aH9g+9xoKnoU
	36fDkyVKISYHMoq4vb7Z8y8OxmUd6GQicX8RBJuaSsxyN3z9GKt0GlrBvij8KSZ/
	yx9bd257mEGH8BobjkpVUUpHE1hudEoilPGbmu+w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejju3psq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 07:32:04 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AK7NOBR015274;
	Thu, 20 Nov 2025 07:32:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejju3psn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 07:32:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK5hsAr030813;
	Thu, 20 Nov 2025 07:32:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47y59c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 07:32:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AK7Vwd261014378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 07:31:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B79C2004B;
	Thu, 20 Nov 2025 07:31:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ECA120040;
	Thu, 20 Nov 2025 07:31:55 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.245.229])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Nov 2025 07:31:55 +0000 (GMT)
Date: Thu, 20 Nov 2025 13:01:35 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
        hbathini@linux.ibm.com, samir@linux.ibm.com, sachinpb@linux.ibm.com,
        tj@kernel.org, void@manifault.com, arighi@nvidia.com,
        changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH] sched_ext: Fix scx_enable() crash on helper kthread
 creation failure
Message-ID: <aR7D1xgzrrg_feLb@linux.ibm.com>
References: <20251119103722.309211-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119103722.309211-1-skb99@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8BA2BO_sE6yUFCO7nlTJP8nezeXqgYhY
X-Proofpoint-ORIG-GUID: uMm5xx4_to6J8KnDMRqXkmH6omxiVl0V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXzUwFdWHuvAn3
 HuIp1SbqyiULcU1YK+zHXzNViX/fnp73i6zHFYB/bxFPESVjTTbHz3f8Yh6B/XzVIQrdaBs6OWZ
 8EJJ1RhAVoqJ18yBw59xQ4ToLX2F8ejL6GUoszFdSHMf+nGmWwbJxvhMwwpcL8QFP0gVwvoO4xo
 al+XVx6EmqHPCjV6Vzf0SOL/9rqb+yk75cvjsT+vCL4g8mctpqGpdOU2JY1eODbLduZuL0V+VtE
 /fFeooZJ9/eO0WGZGiOI9733FXHu+nW1xYMyAhEsZvv4NX8MkOzk1XKTfdRGS7iVKCQYz4CQWYt
 PDfJhJSYkH+lYCqoDpVnkcReunzhZoLvlyu8YuPiF2X8zObka0I5l218h29/Hmk6Ba76vwT4Id5
 Yk2zPVxPT7j51ynAAYdvQkxdsYVWvg==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=691ec3f4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=HSaeDiFOgn0BX7bOopwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1011
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032

On Wed, Nov 19, 2025 at 04:07:22PM +0530, Saket Kumar Bhaskar wrote:
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
>  kernel/sched/ext.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2b0e88206d07..7fc0cce68a1b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4392,8 +4392,11 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
>  		goto err_free_gdsqs;
>  
>  	sch->helper = kthread_run_worker(0, "sched_ext_helper");
> -	if (!sch->helper)
> +	if (IS_ERR(sch->helper)) {
> +		ret = PTR_ERR(sch->helper);
>  		goto err_free_pcpu;
> +	}
> +
>  	sched_set_fifo(sch->helper->task);
>  
>  	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
> -- 
> 2.51.0
LGTM. Thanks Saket for the fix.

Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>

> 
