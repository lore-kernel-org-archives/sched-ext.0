Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043632;
	b=x4QCZXKYJf8WA9POUyefhlW+pESk9wB3AoqUbtb4bDADGEuXOvErh+Ccf14mx0TELrAz
	 i0OOBjId5GdKjOMBIdG2fMsud1dp3UFdWKSoUmOcvqBtC3OMEsA0GUEjyqXX7WZZ78VGL
	 LRNgGFqEbwUtMyf4Hn8PE0xGOjuunoHgOVO8YDU3+3ny26Q7VaRg2amEcOqdEaTG4/P49
	 jhIO+uom4rC3PYIQ+98EjOZIqUXyYUxIgMXVe8O3/R6W2Yomc/4zAQPYG+N7964AjdLlx
	 Ca/verLLZWrVMVF+rDouQaG0fxU/6oZQARGl2T8iqNYNh62aKeKMj1F/p9mZiqKIT2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043632;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ffLc8M6kgUXDxTvAEIl4EfnyU6vkbLzw92jR7anCh+k=;
	b=OSK/v3Y0j8fx6Z+xKV5zZOFwJBuFiEYGeksEjhg6Igsb7otBBYCH4iHvX17phlg+Dknx
	 wJuKRMNX+KI5Zeqan33QUNT8FP+mPFT5VWrbMh2jToidraW9TeWFssLeGPsnYCsHuVxmF
	 KjrnY6y51V4VMd4goCkCv/IE4+eAhswYS/eQ5abJS1b1KOzNKZI1Ls45zfdbiH6aVBnl7
	 GFhqqsAadjdSxUW86ftgaAYIeTzrE6QyLMjDAGwQqCyHeS05KtXaH7itupr7mTPe8z9Mu
	 UhxDmSl8gqp1aim5zXWFUNg98wiRnktUCjC6LWbhZlLtgOMqYdCECrEAv4ssUARaVew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pkNX7Yzw;
	arc=none smtp.remote-ip=91.218.175.224
Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B6606A337
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 23:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F06B6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pkNX7Yzw
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=tQf2RroZFgidYhH8VlIC9DnLVfLCV5SLUf0kaG6u5o8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795043629; v=1; x=1795648429;
 b=pkNX7YzwK+FuVIyZfuh5RjJtDnRvtBq+7ZddG4QVLwCF9uT8BupvhW/uLdI4cBZwoGEcRDBM
 vIq5v4fDzsNHFN+ygqXlBv5iKS7uBPpK1NKr+sPVsRE4k80UtSn5QtCWgwJWngejOO4iRwiOgIw
 Iid1i5Gt9taTIgFrkozNOEMc=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id db2b73d50699373c;
	Wed, 18 Nov 2026 23:13:49 +0000
X-Mizu-Trace-ID: db2b73d50699373c
X-Migadu-Flow: FLOW_OUT
Message-ID: <a54689c5-83d8-4a81-a8a2-ba971793d981@linux.dev>
Date: Wed, 18 Nov 2026 16:13:44 -0700
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
 <6a1b6f05-448e-461c-bd79-0acd67fb7edc@linux.dev>
 <d2f665211f7c294bf7a8f3897b247863090e4e19.camel@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <d2f665211f7c294bf7a8f3897b247863090e4e19.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-11-18 3:11 p.m., Eduard Zingerman wrote:
> On Wed, 2026-11-18 at 14:37 -0700, Ihor Solodrai wrote:
>> On 2026-11-18 2:12 p.m., Eduard Zingerman wrote:
>>> On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:
>>>> An incompatible change to a kfunc's prototype, such as an added
>>>> parameter, breaks BPF programs built against the old one. libbpf
>>>> ignores the ___<flavor> suffix of a kfunc declared in a BPF program,
>>>> but makes an exact name look up on the kernel side, so the kernel
>>>> can't keep the old prototype available under the kfunc's name.
>>>>
>>>> sched_ext ran into this. cded46d97159 ("sched_ext: Make
>>>> scx_bpf_dsq_insert*() return bool") kept the old prototype as
>>>> scx_bpf_dsq_insert___compat, expecting libbpf to bind old binaries to
>>>> it, and broke them. 2dbbdeda77a6 ("sched_ext: Fix scx_bpf_dsq_insert()
>>>> backward binary compatibility") reversed the naming. A ___v2 kfunc
>>>> declared as vmlinux.h spells it doesn't bind: 56bbc91219c0
>>>> ("sched_ext: Fix scx_bpf_dsq_move_to_local___v2 compat detection")
>>>> fixed a compat macro that silently dropped enq_flags because of this.
>>>
>>> Please prefer examples to prose in cover letters.
>>
>> The sched_ext story above narrates the commit history to illustrate
>> the motivation for the feature.  Would you like to see code samples
>> from there, or are you suggesting to drop the paragraph?
>>
>> The documentation patch includes code examples of the new binding
>> rules, I didn't want to duplicate that in the cover.
> 
> There are two ways to act while reading the above paragraph:
> - follow the referenced commits and reconstruct the issue (time consuming).
> - ignore it (not helpful).

sigh... There are more:

- Read the paragraph to understand the issue on the high level,
   without loading the entirety of the details into your head.
   Example interpretation:
   - sched-ext had a problem with scx_bpf_dsq_insert() changing the
     return type, which led to reverts and inconvenient hacks
- Give the paragraph to your helpful assistant and ask it exact
   questions that interest you. Since the paragraph has commit hashes,
   it's trivial for ai to navigate this.

And other approaches in between. It all depends on how deeply do you
want/need to understand the specific thing.

> 
>>> Also, please de-Claude the included prose.
>>
>> Please be more specific. Which "included prose"?
> 
>    sched_ext ran into this. cded46d97159 ... kept the old prototype as
>    scx_bpf_dsq_insert___compat, expecting libbpf to bind old binaries to
>    it, and broke them. 2dbbdeda77a6 ... reversed the naming. A ___v2
>    kfunc declared as vmlinux.h spells it doesn't bind: 56bbc91219c0 ...
>    fixed a compat macro that silently dropped enq_flags because of this.
> 
> This screams Claude from 1000 miles distance.

Sure. So what? Have you read the bpf list lately?
(I also use Codex and Muse btw, not only Claude)

AI-generated prose is not a bad thing by itself. It can be no less
useful than human-written prose. Yes there is a wide spectrum of
slopiness, and submitters need to know what they are posting.

Personally, I try to be careful about commit messages and cover
letters. I iterate on them multiple times with AI, then I read them
and edit by hand. If I posted the first generated thing it would look
much worse.

Look around on the list. Do you think this paragraph is the worst slop
cover letter compared to things that have been landed already?

I'm a little annoyed by your comment, because the slop filter you are
applying now is not applied uniformly on the list. It's not fair.

I would write the cover entirely by hand if that was a strict rule
here, because I respect the rules. But it's not.

> Maybe I have reading comprehension issues, but in order to decipher it
> one has to:
> - "kept old prototype" - figure out that two functions were declared
>    "scx_bpf_dsq_insert" and "scx_bpf_dsq_insert___compat"
> - "bind old binaries to it and broke them" - figure out that existing
>    bpf programs referred to "scx_bpf_dsq_insert" and libbpf mechanics
>    didn't work as expected.
> - "reversed the naming" - like a new function became ___compat or what
>    happened?
> - "A ___v2 kfunc declared as vmlinux.h spells it ..."
>    Now there is a ___v2 in the picture.
> - "... doesn't bind" - figure out that this refers to libbpf mechanics.
> - "fixed a compat macro that silently dropped enq_flags because of this."
>    Incomprehensible w/o looking in the code.

Your reading is a valid approach to understand the history in more
details, and you are correct that the paragraph does not provide them.

However IMO those details are unnecessary in the cover, but pointers
are useful. Which is why I left this ai-generated paragraph be.

It's a minor issue, however. I'm happy to drop the paragraph, I just
disagree that "it screams Claude" is a valid reason.

> 
>>>
>>>> [...]
