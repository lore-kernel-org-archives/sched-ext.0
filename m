Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455895;
	b=S2+GppuS27riMNaHzrSw3HQeh77PR6Eci0DpwjC5TMUdhqvvqFPB3eqLZ1sFwBLYPxRs
	 LOnOAc+nbg4p85tYXvZWZiUPOhnSRysbVTe6x96aNh3cZQM7AQNw11S/XT3Yj7kjnTFL3
	 LbJgpu+AyBCMwIMxeEZZt4UCAFmqDJ3aauZZU5l+093nQsDlWlj+hZCjfQVWJxjUqJoBL
	 g6hxfUCLqFcsfZyaYo0ej9UrINA3npJFNQMUaEjoLFb9mOcwUZ9UFjK8k1RU44outCyKG
	 JlgqIUPiDJGnkReY8JDTg1oSvuhvXbNjcyBvObO2UxMJJQC1ZhpDapNVtRGQn3WrzOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455895;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=27WmAjSob6zP6gYk4hcXOA3sghxa7IPp+OrXD2/+M+Q=;
	b=dxPHgMo0DCkyAKUO1/2RIiTi62pprB25LamkWIYxZZx5UOitOW2axB0Sz5VpPhNaMm/b
	 rT9KotANRQwJ/M5HaKf+mWnM4FVxdDKoNF7XaiZp7gQiXmCgFtUJHgZjAIaBPhHW0z09K
	 z6t2xauMl0LvZQgBAY0Lf4v5fNDxQk0hIVyr47bWAbWCz/3p7ABLe2UHD/Blf50HQE3sc
	 t2/A5nH1ydK6S4UcUV+6F8EmPx5ekbEMdWWg3BhDLuTLH4IVV+rjxgJC00ADfG2SxJfcV
	 8CI6kb+yck3cqUFxpiY+na8+rEIeJpaeF3j7QPG4uZ/CWCB8qTGC+i73O+nslagjd0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kfgN8Gup;
	arc=none smtp.remote-ip=95.215.58.167
Received: from mta1.migadu.com (out-167.mta1.migadu.com [95.215.58.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21597606A31A
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 17:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21597606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kfgN8Gup
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=3y/flRugDbB2r8GNLKzFkQ+01L/n3n4yEfzM8gw2f0A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795455892; v=1; x=1796060692;
 b=kfgN8Gup134i96SxfDANCNtc/IOJFMvY65A8ST7TyQ6JH3JfwOcWQvU5iU4yW10wAq4zk6rE
 VVNSOjUbYqdoh5njFfzCXte9e43VWU23RPZ7o8/dalarir0JSeRaSQwPWqLhLusTDZChG20xatd
 +6O+3ngaNIq2OO0sFJZcH2Cg=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id f4a296c957b79296;
	Mon, 23 Nov 2026 17:44:52 +0000
X-Mizu-Trace-ID: f4a296c957b79296
X-Migadu-Flow: FLOW_OUT
Message-ID: <faecfef3-ac9f-41be-8bc3-83a66572066a@linux.dev>
Date: Mon, 23 Nov 2026 10:44:46 -0700
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
Subject: Re: [PATCH bpf-next v2 1/6] libbpf: Separate interfaces shared with
 in-tree tools
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
References: <20261121003403.2928928-1-ihor.solodrai@linux.dev>
 <20261121003403.2928928-2-ihor.solodrai@linux.dev>
 <adf5a84b-5d80-4c02-91f5-12def2c37304@kernel.org>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <adf5a84b-5d80-4c02-91f5-12def2c37304@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-11-23 7:55 a.m., Quentin Monnet wrote:
> 2026-11-20 17:33 UTC-0700 ~ Ihor Solodrai <ihor.solodrai@linux.dev>
>> resolve_btfids links libbpf statically and uses its BTF header
>> accessor, field iterator and SHA-256 helper. libbpf_internal.h
>> also defines logging macros and poisons kernel integer typedefs,
>> so resolve_btfids wraps the hash helper in a separate source file.
>>
>> Move the shared declarations to libbpf_tools.h and use them
>> directly in resolve_btfids. The header is for in-tree tools and
>> stays uninstalled. No shared-library symbols change.
> 
> 
> Hi Ihor, the change in bpftool's Makefile looks OK and I understand the
> motivation for libbpf_tools.h for resolve_btfids. But I find it a bit
> confusing to move away from libbpf_internal.h only partially for
> bpftool, and to have a split dependency on both libbpf_internal.h and
> libbpf_tools.h. Have you considered moving the other objects that
> bpftool requires from libbpf_internal.h to libbpf_tools.h as well?

Hi Quentin, thank you for taking a look.

I haven't considered that, and it seems like a good idea to me.

The way I thought about this is that in practice libbpf has at least
three levels of (userspace, non-BPF) API:
   - public API defined in the symbols map
   - internal API, shared helpers and such
   - API for the in-tree users, that doesn't make sense to make
     public

I felt like the last one needs a header to reduce the amount of
copy-paste. I don't like "libbpf_tools.h", it gives me "10k loc
utils file" vibes, but I couldn't come up with a better name. Open
to suggestions.

I need to look into bots' feedback, and I expect there will be a v3,
so I'll see what bpftool parts can be moved to the new header as well.

Thanks!

> 
> Thanks,
> Quentin

