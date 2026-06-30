Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF193EB7FB
	for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813257; cv=none; b=RXek1YoeEPbxMit+Gxx2+ooOkApeJdcwpkZuTnAhRF9DwKgj7jYpbthmcpQ90kY95UAgVaXWU7Shsj022N9nTCQR0gBygi1DdqcCnDG74Zd1KG4P0tKefbT8L4eZGvhZp9jwDzJdptwMxWvlEL1Efl/+Ku05rf82ynzWSk23Hic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813257; c=relaxed/simple;
	bh=EFPekGZsZTIoZc2iL1kRyL6KGOLbXoH6pZMaxt1PcjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiWoI1yX/8z98YsdnEoMplp+J+x+y1FTUKMIzo6twk7tCsr48E+8xDBycAigh+tKbz0Vh36/7rbFg83azCF2lQbJqxv9DBPSanVMijVs2CygY39li+Pygf75T8rAqKC3Egg2p3hwBJ3dvo0LKOwIVU7QBp1GDHhzP7QjPPdXqoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CKoQmCHb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HzVu3Bfu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CKoQmCHb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HzVu3Bfu"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nBM71606238
	for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 09:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ifrVDpo63bx4Jsv0HgCNLjZKGwmAhOiGi4dhseDvN+E=; b=CKoQmCHbv1iRdXhQ
	G5rcGf5yB85Yz894N4xJdfUVx9uJqSINVU5ZyYIWOiSfj4ARs1uBL05CBAlJU4ra
	mc+aYVy9UWr8JKmSmEWdNgYwvpo1EZD8SflMK9G4za3vilSy5QU0wcQM6Lto/bwF
	LJUrZ6PgIOySVPcKedLcVWvm/PqGsLgpAg1yPMeQR3+qd4NJXCmyTHfykd+MQsQU
	kPcCkMNdUK+/pztlwLzrTt+K0IQqD7v7wECXJ9Tbns8RBjUZw2ZoaQA7kr0zRTXk
	z8oQJnp5PvnmE3K8CHsd3f5DZxOCQQpznxDtTihKketO+DzOy2II+VO9nl32CG/g
	7lyl5w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f45k5snn0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 09:54:15 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8477ffa650bso218700b3a.0
        for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782813254; x=1783418054; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ifrVDpo63bx4Jsv0HgCNLjZKGwmAhOiGi4dhseDvN+E=;
        b=HzVu3BfuWQbZkCS9OOHc60xKuqcbtE/UeqZoVNPsIuzktfuBnDgPi/To5ynfQGVHWi
         S2Rkdtk6y/PDKIeXB7EQKxJBir3j2uKG+JYHouuKw0mCvTBigWPzebdHA65tJy6byY/R
         fWWUqCgGWsCzf/tE91lkWA0GWH0PMLv1WOUQdAwQePC0hgPWf3WPfdu1DNnNYhp3WDSk
         MwTYtb/VmeAA09hF6XwlFgDevg/1C1ZGWDG9CzSgw/kQr0qHmqLmjDbd07Hyh2xmu/wE
         bbTTapW76V91OktzFd+4JA25XG/J2Qi3tdK4xlEWt4unIOgCkqC0jxrIisiU2iNCBV+f
         sI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813254; x=1783418054;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ifrVDpo63bx4Jsv0HgCNLjZKGwmAhOiGi4dhseDvN+E=;
        b=hv7x/rvNKKqgWqRnRdZZ1e83OwLSNByhGoM7DeFg9IY+tQIxNht27nexVK3QNgw7ot
         rYyyZh4e0MGzKDs5gazof2iFlbF/IPDEt2dcSn7AjLQv5gSIQSDjMJRgmVRxp0ntAqAC
         jxK8GiFl9wowONYrXU2MfkI+0XrHe1Ygt5SOCXwAxCq322omgn86jNwY1lAvnP20LHBJ
         vmlUIfpWSeIJcuMXlxT//bABU1garO1tJ8J27nqb0XJBDMC+o807tdtbi28c6pQAFJKd
         SP5aX72J/9wse8cv0HUZMTZYuO0iNxkClScXct7dPSJelHnBe+3Adv1paMovBbGPZT+r
         35HQ==
X-Forwarded-Encrypted: i=1; AFNElJ9m19ZP/X3Vv+o07fwtvHhDA7nJ9qSgL4wL1mDUuCNoCFnTk25H6VCXWeP/xVvsOdJQvyrlVrASN74=@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ/ky3/m96uT+jU5tme27YBGKDXZQ8OFA7l6MvohX91+HTwQtD
	bp/h/sF69GwKxAm42tpmS+lSKdKKy4txcd1lbrqkt12mmY2UL7B7fJ2CRfCTbmTRFQVqW4Bh4vU
	rbDPc+e3bDWHi/Z/AH4TS9oqfHzfwCA5DQHibzIsUxV1Pc7kzVj1Yvogdf1kar80=
X-Gm-Gg: AfdE7cllZzA27iyvkrue/xOkFIia4rpQ57xbudE/FDNoHkk1vSsg5qTNRGGfAPcvHI+
	coxHSoNhPC204D+Gg+NUHteqWeezi1q/dAhF4MV1skJe2aKmJsAqfSefTC5iJhXAxgThSK0QLUz
	tzOHL7oI9B/d7PPYnioBX0EuQR7hqfDRIIVwmhLRn7CmhmaNGkDzAJIF7STqzDUzSE95xAVJDTS
	wklNTwLhW/XAnxCFlpLxFt4Hf2yjhSZEN/rH4E18kMzTpu8zeDrNavgI+PS55UzoLi4a9iU9vih
	7wRx5221J5WybKOS74/e6YV29xkKVhmmygXt1mMq6QH6xGbojDi2Qnn7y6FlIhMYi4pUrZkLSFU
	J3RUww/kCxQJHcSYIAZwLPhmBq+t5hY4wzSa0KA5pTUsoL+EcMy5HclOK/5l0HVezOi10rUf59R
	8A
X-Received: by 2002:a05:6a00:b94:b0:82f:99c5:868d with SMTP id d2e1a72fcca58-8479f25a6c2mr1655274b3a.4.1782813254205;
        Tue, 30 Jun 2026 02:54:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:b94:b0:82f:99c5:868d with SMTP id d2e1a72fcca58-8479f25a6c2mr1655253b3a.4.1782813253569;
        Tue, 30 Jun 2026 02:54:13 -0700 (PDT)
Received: from [10.133.33.21] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03778basm1565810b3a.49.2026.06.30.02.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 02:54:12 -0700 (PDT)
Message-ID: <3c395530-30c0-48ed-9307-a8fde8c500eb@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 17:54:07 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched_ext: Don't warn on core-sched forced idle in
 put_prev_task_scx()
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
        sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org,
        Kuba Piecuch <jpiecuch@google.com>
References: <20260629225548.3562257-1-tj@kernel.org>
Content-Language: en-US
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
In-Reply-To: <20260629225548.3562257-1-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=6a439247 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=qF2snBwGOhp659cOopEA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: GtdRsaFpHS0W9xy59OcIKviOrPl54gxT
X-Proofpoint-ORIG-GUID: GtdRsaFpHS0W9xy59OcIKviOrPl54gxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4OSBTYWx0ZWRfX7ke1VdoTruKz
 hukUARcQs32qxwoscXOoHzc4G6fELuHMl27z5CkXenuyttYmD2WM7xk5aSzpSLL4IewqvUm2GxY
 7AmKgJKnRlLT3qXHDk48kBWzj6I28DijtuAeWypcpsHGAjIUfBq99luLaG0ij1oRZKp+uP/GAUY
 GNZDOq3ErZbmivpM4e3e/fRY0XuWjosqWDGlCooziw/p/JzwUV2i26JpZ61/d9FnzyNhWPIn1yr
 edEILuip6Y5/G6QgKZ9UpVzDaWbrvAyBUR/DKQNLIgQSYQBcNe5urFjhzeX/ALNmp8Dh3fVi+Fo
 mH9EzWuZ6xeQiHgc+EfZHPrIg/8fc4Sa2PxCAVBIo/IEMRWKge6L9Yh6+5Z7L504WINlsF27hQ4
 Xff1tnDGjm2ZZa0GyqzRijyGyDMrV0YgqINhRwmy1I7Z2SYTwPfQQDs5n+9okdBGlVaVG8CQv66
 MwCpWZfpBG6QckslUiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4OSBTYWx0ZWRfXyN3/p82LThow
 epDHJCWWTFCnDkoDSypFpYkv6FbPtOD9rXJx9HORGN3U1FcHFTK0Cqz8CoqRvPgov6MSMgE3D3F
 w+qohJGPEQh1sPOouKNR3PLYCy2qJMw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300089

On 6/30/2026 6:55 AM, Tejun Heo wrote:
> put_prev_task_scx() warns when a runnable task drops to a lower sched_class
> without SCX_OPS_ENQ_LAST, on the assumption that balance_one() would have
> kept it running. Core scheduling breaks that: a forced-idle SMT sibling
> reschedules through the core_pick fast path in pick_next_task(), which skips
> pick_task_scx() and thus balance_one(), so a runnable task can drop to idle
> with ENQ_LAST unset.
> 
> Gate the warning on sched_cpu_cookie_match(): a cookie mismatch means core
> scheduling forced the idle, while a match (or core scheduling off) still
> catches a genuine missing-ENQ_LAST drop.
> 
> v3: Gate the warning on sched_cpu_cookie_match() so it is suppressed only on
>     the forced-idle CPU instead of whenever core scheduling is enabled, so a
>     genuine missing-ENQ_LAST drop is still caught (Andrea Righi).
> v2: Reworded the description (Kuba Piecuch).


The version change log information don't need to be present here.
Usually those kind of information will be present under --- and don't
need to be added in the real commit message.

> 
> Fixes: 7c65ae81ea86 ("sched_ext: Don't call put_prev_task_scx() before picking the next task")
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext/ext.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 3b2e13bc924b..e75e2fd5ab7e 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3090,9 +3090,14 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
>  		 * ops.enqueue() that @p is the only one available for this cpu,
>  		 * which should trigger an explicit follow-up scheduling event.
> +		 *
> +		 * Core scheduling can force this CPU idle while @p stays
> +		 * runnable. @p's cookie then won't match the core's, so skip
> +		 * the warning in that case.
>  		 */
>  		if (next && sched_class_above(&ext_sched_class, next->sched_class)) {
> -			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
> +			WARN_ON_ONCE(sched_cpu_cookie_match(rq, p) &&
> +				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
>  			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
>  		} else {
>  			do_enqueue_task(rq, p, 0, -1);
> 


-- 
Thx and BRs,
Aiqun(Maria) Yu
