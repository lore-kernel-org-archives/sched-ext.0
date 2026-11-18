Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038502;
	b=K/DFXUSOW9JRTWOoNRDMzv7+efroQpOMe6Cm/n1F/75IYSMmqFFlrc4HJLt3JP892iTf
	 FnBHqLNRdR/8cqB9Gv/wpIKwpBhvf6Sw2OhnPJRTaiDSjP8I4hCtC5ayvj566rWo6isyl
	 JgV00KswDrHdTQZo8dsvfvpYRmz74fWoWxdkcswlbW56d9+jglixVMkSzBlcl25uUr4im
	 zPwnzYUctOk/qhhk3Tj5q/0H/oVJaHIW7wvVdMdr5VC0Sns7pXuLjg7uKntO3t6jcuyEl
	 GbEnCM5PQLFVsvFTmP0GgZCbQ3MRzYUyyalnX4GB9gVEAASSWQM4nrH3wx4CpVP1L+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038502;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=FmazbUcyJv2DZJt0DwoZZdCNAhZOwPEZbzF3LjOaQzI=;
	b=NTEWZ2SxjGGu6b28dxxG9rr5HU85zpJCoN44MPxvvxk1YoWH9/xGDOoQmtOFBaloUp4U
	 nCbizr1WQdsmcCgCru108k5KCOotQh9s6g801nyumzPFrPeEnJ8rZDCQYJAB/fGVMsE0w
	 9qyOW0AeM8K3dAVvWMmlYPKTXklwvnwaJmLh3DeeRn3Sh6mztsph9cL+i+CjoH8n63U1i
	 22Qtm+T6Le51DaRaCT1ha9CUhpRK4iFL6vZ0KI++SEcvf+i3itB5unRnWDBexCIr1cHLc
	 KO8CMFXwMc3FUkq460nxywflEmwIBkHY1WDoZlzi+ndE8je1CqHd2HbSSd+eqd8uQ7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gAcAFoHd;
	arc=none smtp.remote-ip=95.215.58.94
Received: from mta1.migadu.com (out-94.mta1.migadu.com [95.215.58.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE3606A31C
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 21:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9AE3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gAcAFoHd
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=lDmX3HacvpZlC7SbFW4I0h+2lCXa1G37/dwBApAQGSk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795038494; v=1; x=1795643294;
 b=gAcAFoHdp4xk5/UlomDuBIX+nOan9LWgGTV/QicK5nTZcCBJIUnIIk5mn+rMltwXiNK/kKJ0
 N68YbYbkWak8XoX971oKCogU2xsRET2RVj1Kpba8KErsFafajb+5CX1WDbLU02vZgZ16xyxaALi
 o16SO3chHuUqcVOL+JIJ4e3c=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 79200d32be978053;
	Wed, 18 Nov 2026 21:48:14 +0000
X-Mizu-Trace-ID: 79200d32be978053
X-Migadu-Flow: FLOW_OUT
Message-ID: <dfba2231-4cf4-4bb2-90b9-6261b7567895@linux.dev>
Date: Wed, 18 Nov 2026 14:48:10 -0700
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
Subject: Re: [PATCH bpf-next v1 0/4] libbpf: Support kernel-side kfunc flavors
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
 <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
 <08d6be6e9e0dcf6570ecd83671e9dbe63a417607.camel@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <08d6be6e9e0dcf6570ecd83671e9dbe63a417607.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-11-18 2:42 p.m., Eduard Zingerman wrote:
> On Wed, 2026-11-18 at 14:12 -0700, Eduard Zingerman wrote:
>> On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:
> 
> ...
> 
>>> resolve_btfids fails the build if two of bpf_foo and its flavors have
>>> compatible prototypes, unless both have foo's exact prototype
>>> (aliases), so the fallback finds at most one match.  This ensures at
>>
>> Why is an exception for kfuncs with identical prototypes necessary?
> 
> Ok, my helpful assistant points out the following use case:
> 
> On kernel side:
> 
>    __bpf_kfunc bool foo(struct task_struct *p, u64 flags);
>    __bpf_kfunc bool foo___v2(struct task_struct *p, u64 flags);
> 
> 
> On BPF side:
> 
> 
>    extern bool foo(struct task_struct *p, u64 flags) __ksym;
>    extern bool foo___v2___compat(struct task_struct *p, u64 flags) __ksym;
> 
>    /* Resolves to the kernel's foo(). */
>    foo(p, 0);
> 
>    /* libbpf strips ___compat; resolves to the kernel's foo___v2().
>     * workaround used before this series.
>     */
>    foo___v2___compat(p, 0);
> 
> New mechanics adds an obligation on the kernel side to maintain that
> foo and foo___v2___compat are semantically identical, despite being
> physically different functions. (Does it?)

Yes. I just replied with exactly same example (it's used in sched-ext).

> 
> Would it be possible to use some kind of annotation, e.g.:
> - __alias(foo___v2) (an ELF symbol alias), or
> - __kfunc_alias(foo___v2)
>    (resolving to some sort of btf_decl_tag for resolve_btfids to act upon).
> And avoid allowing functions with compatible prototypes w/o exceptions.
> 
> ?

My intuition is that it's possible, but it'd be more complicated.
The question is why? libbpf side might become marginally simpler, but
we'd add complexity on the kernel side, no?

