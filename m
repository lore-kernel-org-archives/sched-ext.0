Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795157086;
	b=VWcyxxBEhu4EnX6xFRUSNOQDzkBAdmRsPmzvWmLuZ7Lhq+VfH1Gvm4tbdgnfx88mBIMd
	 69goMCvVZIDiq/PwCmQvRS16e+m9NeZM7K1lQJBZksYTboYpPMzsgstywSBx4VL+k7mqQ
	 DRNjvcOxWUYKdfUm06SAHgYE8vt9l7Onbg+0hiwnES0VScnW9GpRrCMEPvHn9AdtJlhkT
	 TglN6ly16uLAbtxocKY/vrK13GgE8ICiyP7W+XAlCEcAS4hMtKHg75/smuMjl0G7CGyC4
	 BQGAuxtoKQILNnWvcOzEPSek3NA/xfYuuB9mqqOCwwLQZksWpVjvg4mC6Wkwt9M2RSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ibHuc2Ky7x6xbIQztLyKbwCm/OGk8fLoxdPIGUt/hMM=;
	b=zpa2ru+cWgEuU9NLbz8nsvI2sA8tI4ZZeS2ckEqbshSOZ34fRY4EavgiHWTdrbKTUdgx
	 e4YxCtiwtGUl8LFUBvtR/xuW+pXzkHXQOvlZ2plwX7JZe1jxdk1cFxH6w4t6HUgbqL+Rj
	 Psy2GnA0gKRTJ8qAH24Yu6LWpM4CFm4G41HnohSiGQT/jktVIrsZsbSmNAHhsFw3w2Kub
	 aLQOLhv75La/SxueGUdwBTji4ZfPO8pksFZO5YKPRDQJvAE1yXsUXxvk4eLo44xx6y58/
	 eOaHIg+eE7foR6qmbM8C3JWisHMo0wczbPi8dqlpakJVFvNL+AAzQ+s+VEC0nqVP3PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ywxQjVY7;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDD606A330
	for <sched-ext@lists.linux.dev>; Fri, 20 Nov 2026 06:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59FDD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ywxQjVY7
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so329304a91.1
        for <sched-ext@lists.linux.dev>; Thu, 19 Nov 2026 22:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795157086; x=1795761886; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ibHuc2Ky7x6xbIQztLyKbwCm/OGk8fLoxdPIGUt/hMM=;
        b=ywxQjVY7bgcQtr7LiKs47YFHC5ztRMHkf7vkwgXIffgQURbVUS+B7mBy2fBkkxhyBA
         nqYikTdyiwOcrsbl+ctu50EDt2EEc++n5WDjP19gmF73ye0jEd20vrwmotu3WV966zcu
         OOCVRWB/FLnNEfIzT7K0nNtwxNSSMzCaGzZxj1ZjomkaTHclZ6GJzw7BCEGDsLycXYm0
         f+HJqyygAA45tYcdO8GZTpG1gu/iXysMPNr5e3ZA0dyC+HkNEfGKUqE20rUp3MVwGatx
         uHumjYa570GdtDqa7jsCWFUol/dvlxsH+wG052yyiugKH3Zw8ZCoGetEufhka3QWgmU9
         hYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795157086; x=1795761886;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ibHuc2Ky7x6xbIQztLyKbwCm/OGk8fLoxdPIGUt/hMM=;
        b=wwveMxPe7z6dp24JC1IgAFPLJybjBwbwSLriv1nG3LxvDECTtZbZYDRvDQq5Oj5u3B
         v4dxSPWmD4QC2En+nRklLyIN3vvLJQFnib/GLVp4ZleQC6ZEC/R1Fhu25Yb0/cR7kff3
         3MxgYrOVVWQavYvtmw3MMrEOsWIBh8ZLIAjo8mAmDDWLa/w2g4mbo8wRA67QWidvRWv8
         fKnSEr+rFD+m1NijRj4UT/U4tP1YOERgzZUQKc1CpPVmNGlfm3WdsisSJedgOEDLO1Tg
         7IfOoINEBzdJbSHlIdUy0aBeexNcg5TdyTh6WsR+oCX01lURhF3Mg3cnzgk3VfMzDlg1
         keAQ==
X-Gm-Message-State: APuU4Z/6yQ7BXHsV+tMv4xgwX/BYoVGqszbUvdHsjBWUgSAMuRaGNJYT
	wFeT6TCI6G18WRv7nBDmONaT1c6IYNPCZP9QFRblEdQPRcoP5BX4wr6j
X-Gm-Gg: AZFdTZfHPWskoSiFuQmsVxynJ+kd42ldQughVrIRNlA7Rj1XVBEVADpBGqHuMvkdxlR
	F+LUr4jKkTpd1gRz/HflmWhYFd6kypf/2RpXKmpZQaNe0RBmZqXPNHNI3kvBfmCD2+k3G3ntvXu
	Ndxxk6CdQQ9uHyKE8+68CSnLw1S6pUJMUHiEuU+JzghAGH90vdgYWlUhzdgn0Ya5dZ9NeykC0Eh
	pO5SCVzsCm5WFF5pcuEZK8hxl3lrsIBPVBnjNGDjXCcPe7HP4j/0xq0OHL2vPk2y3XhDoqAx0S4
	4YcdN4bzsCzPstKmuPdHB4+sm7MMFJz9sr9Hg/7O4Lm83iG2MD7Cs2JudDGUNj9xtuFPYzuZirH
	gwPtzzef035HwQxam3qrD6aD66Li6gNo1laNt7B/z7d3bTEXu3RgL0R3lS/MZNxREKr5uqAWbRF
	zkU7NsO0AGO2MD4wXPS2V5oRIBp2eVu1jsP48ohApXFqBxKGFznvg+nopQlhbEDhV4RSW7aPY8B
	uWhJLZqMj+SMMIqOVd24H3h73+VYBYfgVaCw40sk5b7XDyX1SntT2x8Ymc3wibOvFT7NXyVi02e
	XNKz+FX2Hq4Ldgc+V324txpE328OHr6aIYSgc4VKhAgTVF+tRvYAsg==
X-Received: by 2002:a17:90b:5546:b0:3b0:a1c6:95ae with SMTP id 98e67ed59e1d1-3b41c941f9amr1058404a91.31.1795157085609;
        Thu, 19 Nov 2026 22:44:45 -0800 (PST)
Received: from srsys1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4323bda5esm12916a91.3.2026.11.19.22.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:44:45 -0800 (PST)
Date: Fri, 20 Nov 2026 06:44:28 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	haoluo@google.com, brho@google.com, joshdon@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: reject oversized dispatch_max_batch
Message-ID: <av_sTGpIbkzvsp05@srsys1>
References: <20261120054913.3795562-1-rhkrqnwk98@gmail.com>
 <av_oLZQzAtFe2vTr@gpd4>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <av_oLZQzAtFe2vTr@gpd4>

On Fri, Nov 20, 2026 at 07:26:53AM +0100, Andrea Righi wrote:
>Hi Sechang,
>
>On Fri, Nov 20, 2026 at 05:49:08AM +0000, Sechang Lim wrote:
>> bpf_scx_init_member() accepts dispatch_max_batch values up to INT_MAX.
>> The value determines the size of the per-CPU dispatch buffer, but
>> __alloc_percpu() rejects allocations larger than PCPU_MIN_UNIT_SIZE.
>> With BPF_F_LINK, an oversized value passes the struct_ops map update
>> and triggers an illegal-size warning during link creation before the
>> allocation fails with -ENOMEM.
>>
>> Calculate the buffer size using the effective batch count, including
>> the default used when dispatch_max_batch is zero. Reject values above
>> the per-CPU allocation limit with -E2BIG during the map update, before
>> the allocator is called.
>>
>> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
>> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>> ---
>>  kernel/sched/ext/ext.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
>> index 10de6bd865e8..93128da6b126 100644
>> --- a/kernel/sched/ext/ext.c
>> +++ b/kernel/sched/ext/ext.c
>> @@ -9197,9 +9197,14 @@ static int bpf_scx_init_member(const struct btf_type *t,
>>
>>  	switch (moff) {
>>  	case offsetof(struct sched_ext_ops, dispatch_max_batch):
>> -		if (*(u32 *)(udata + moff) > INT_MAX)
>> +		u32 batch = *(u32 *)(udata + moff);
>> +		u32 nr = batch ?: SCX_DSP_DFL_MAX_BATCH;
>
>The fix makes sense, but with clang:
>
>In file included from kernel/sched/build_policy.c:71:
>kernel/sched/ext/ext.c:9214:3: error: label followed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
> 9214 |                 u32 batch = *(u32 *)(udata + moff);
>      |                 ^
>1 error generated.
>
>(also reported by sashiko)
>
>Can you wrap that case in braces, matching the nearby cases?
>
>Thanks,
>-Andrea
>

Thanks for catching that. I'll wrap the case in braces and send v2
shortly.

Bests,
Sechang
>> +
>> +		if (struct_size_t(struct scx_sched_pcpu, dsp_ctx.buf, nr) >
>> +				PCPU_MIN_UNIT_SIZE)
>>  			return -E2BIG;
>> -		ops->dispatch_max_batch = *(u32 *)(udata + moff);
>> +
>> +		ops->dispatch_max_batch = batch;
>>  		return 1;
>>  	case offsetof(struct sched_ext_ops, flags):
>>  		if (*(u64 *)(udata + moff) & ~SCX_OPS_ALL_FLAGS)
>> --
>> 2.56.1
>>
