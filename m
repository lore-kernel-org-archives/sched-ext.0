Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E6334C27
	for <sched-ext@lists.linux.dev>; Mon, 15 Dec 2025 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765811209; cv=none; b=UBtTGHJPJL+idLktyzw2cgQ86TLVrrrmRUSliruO3SZeeRDs3iog/a1woYqIW4LBgxaQEGiodrqjGD4frHX/p+RbsyLcDVJ/qHvDCZsBJ3ixC9GuPs2b9IENmHwM77gY1wvZD6MmTwL0HJfCyy3RuW8NAXrEYE2dPs5RmrnvxZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765811209; c=relaxed/simple;
	bh=OjWyaveieyQFwEuXihYRsT8yTNIoJywqA/5FdNOoCs4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RztkH3PlmCsWM8GFHy/wJSLUHtRo7WW3CA1jYhrghJok+CPGr1AS5CjvV0DRX+zUrsN7bEOPqSWipw2xIeY7IOFeL1QrpHahicfb2lzh+rlObtnjuxraUdvc63QLoOq876oDHdamZlaicSm3nTWnPlBO+MSut2UZCVo0KBKpYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=wszNJget; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="wszNJget"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b29ff9d18cso401862185a.3
        for <sched-ext@lists.linux.dev>; Mon, 15 Dec 2025 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765811205; x=1766416005; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79+wzmXa71VTx6agEVBXAhqr4t3bPb9GBjmcnaSZdD4=;
        b=wszNJgetO3Y5mMX0GAobicjPEjrkoYLreHarwkCEGOq9iUG5YKmthYkaPhV43clx3O
         zq40FoHUtC9pr/rRiHXrZRjglC/9VHXdMxQcm1AQflYSTP35QGDekfHEfgdH4/Svn4Ce
         R6RdPFGsihc1l7MxCYRdR84PRbRAPSOM7ZHipriQcPzkpKaMcARzrTw9INPff26O1XZn
         7wZJnTotlJmYoTKaviz3yaYrfpTEPOGB3vx0S6mkiAi6hK1K/Fj52TEp2Q6meV7VxiZF
         9CIRugFmwxIwfNNwRm1jOhoGxmKIrRW0iU9xm6bwTOI0xl/4odyJO7yVH9a8cu5djr9+
         zn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765811205; x=1766416005;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79+wzmXa71VTx6agEVBXAhqr4t3bPb9GBjmcnaSZdD4=;
        b=CbBGprjKIGYhhdPuV2D4gUGVug4pixRxDYldPZgG8y/6AkQKI3bhR7S91gJxZW4Ds1
         1scym4KQp4oqGkJbfbUN18BOUx8u9dgdHehiytNfuEh5RQRuDMZnWcJ3W1R9M7MbgwMi
         s/3MlWPv/Fl8VJ2Bqi8MxJ7yM9zq56Y3268j917yfOB1pYVVMopM59LB1H0XMwZoL3Sf
         rN8KE/t5nrpMuenxddzugDVjujA+cUhjzQX6d2x+j+aRWvhc7R023w6OqNZqrGA3RWlV
         PtNwDnVBHg9J1YBvbyF5XNcZSYpUuvDmmKKjAtpvvo6CzPNgjopLJCwb+DdaNItsJ+CG
         zOxA==
X-Gm-Message-State: AOJu0YyY1m22J+STXFVyfCYAeTb9hBlm1FgaQRMcSh7/vmer+RPomxc3
	AQM//Qy7j1XiF48FgjSm0XKSQSyz+4rK906zu2hWrwCUQHr4eMX0xf/hoqZp1hNpKBQ=
X-Gm-Gg: AY/fxX5Y4Z8w6wmUwD+fiCfDpJN+TMh1AzsBVTXHIXmvKg3UyIVh23v3uFMfU/uTiSX
	0LcEKirg4w6hpNaxwIDUNO7zcEJNf9j55MJ0UFie23Oi8gDnKdbayLhXaK2bZiIM/oHegpeqaF7
	7JA8F417gKt3bbzVV7/JlQq62hRKuSSmlsnOndk6FTvWFB+36aE4rODgR0DiPmPZYKd2tWKSRDA
	SYt34iM97SV4HN4qPC1Af3XS4T+bpwWROc6/KndkkEdxqfaUG+KhYxxbSdj9GI8ASUivUegMtru
	d3t5mI16Ds7S8h09expnznQWRt8n4b1J5Yd1p7sykT3BrED+zZo45beP+R1W5wIZ+H352NTOAHK
	Oz8l2sZyWtMtHfHhi5M0UbjAxL0tX9YPsTkqhaQW4n1ak83YVeZc5na06G6bHNVrWToc4MEjVDS
	2UVqQ6Ar5+KrU=
X-Google-Smtp-Source: AGHT+IGbxYRqlHlBsLcHTx/J0KOfAKQ1jXoSnZf/7OIJzM1fXf3Ycfphh2QqPatWllCjKZJ4YyHFgQ==
X-Received: by 2002:a05:620a:4015:b0:8b2:dccd:7315 with SMTP id af79cd13be357-8bb3a39e901mr1472596185a.88.1765811203619;
        Mon, 15 Dec 2025 07:06:43 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab47f6f15sm1121603685a.0.2025.12.15.07.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 07:06:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 10:06:41 -0500
Message-Id: <DEYVTV95347Z.14PG6TGXWB4XE@etsalapatis.com>
Cc: <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched_ext: Remove unused code in the do_pick_task_scx()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, "Zqiang"
 <qiang.zhang@linux.dev>, <tj@kernel.org>, <void@manifault.com>,
 <arighi@nvidia.com>, <changwoo@igalia.com>
X-Mailer: aerc 0.20.1
References: <20251215112940.23640-1-qiang.zhang@linux.dev>
 <DEYVT9MLT9MB.2GOBKYGZJ495Z@etsalapatis.com>
In-Reply-To: <DEYVT9MLT9MB.2GOBKYGZJ495Z@etsalapatis.com>

On Mon Dec 15, 2025 at 10:05 AM EST, Emil Tsalapatis wrote:
> On Mon Dec 15, 2025 at 6:29 AM EST, Zqiang wrote:
>> The kick_idle variable is no longer used, this commit therefore remove
>> it and also remove associated code in the do_pick_task_scx().
>>
>> Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()=
"),
>> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
>
> The change seems reasonable, but why is there a fixes up? This is
> followup cleanup, the original patch is perfectly fine.
>

Oh and of course tag aside:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>> ---
>>  kernel/sched/ext.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 695503a2f7d1..94164f2dec6d 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -2446,7 +2446,7 @@ static struct task_struct *
>>  do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>>  {
>>  	struct task_struct *prev =3D rq->curr;
>> -	bool keep_prev, kick_idle =3D false;
>> +	bool keep_prev;
>>  	struct task_struct *p;
>> =20
>>  	/* see kick_cpus_irq_workfn() */
>> @@ -2488,12 +2488,8 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *=
rf, bool force_scx)
>>  			refill_task_slice_dfl(rcu_dereference_sched(scx_root), p);
>>  	} else {
>>  		p =3D first_local_task(rq);
>> -		if (!p) {
>> -			if (kick_idle)
>> -				scx_kick_cpu(rcu_dereference_sched(scx_root),
>> -					     cpu_of(rq), SCX_KICK_IDLE);
>> +		if (!p)
>>  			return NULL;
>> -		}
>> =20
>>  		if (unlikely(!p->scx.slice)) {
>>  			struct scx_sched *sch =3D rcu_dereference_sched(scx_root);

