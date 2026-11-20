Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795145564;
	b=ZYli12XQ1c2vz982df1XpaIqJvtI8PrVOc2oA7Kdtx1kcAZ9jN13KKgqds4pY5hJI4Mj
	 NnefLk9KXkoGaSrI4UCq8lAbwoya/eienIDXwaC7UTb0CvhYKy81JYFrS1wvVg8MmgrqB
	 xdDQxawmgpIsrIJ/YBdJdaLvDbJ2JMVhYNmgW4n4GvdibDMwa0Rj0H2DXTWhowH9+08kD
	 Ey3trcYwls8wnc33XLiARlByxm/SYTafrFmI8egawc+ap/WsMIVroFZq4NmG+Xg9/rI/M
	 5toLnE7SOMvtTmf0d2ACMT5MuLjOKL3UdsDj44Sz+JcMwsT8sE5+qBhoCKitqiFWt/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795145564;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0fECNG54n/Lw7Y7dKtGt1E6g844G0gDaHuevu60/s64=;
	b=J6DHNwxze5HcPqzZDYu80QOeiKZzm6/B6Toh/ypSZFHTaNWKuWg87+XGRNjtSnvnx2aF
	 v5L4svZAM0WAlBC79uwOYjYMDU7NDYZRGDr3JlVROhqdjMgqKxYVNM4ET4tnvq0BqfKCe
	 6fYFIcFCgwlcjUx/V+Ema8PnfjmFH7O/VuAqvW1ZwosIVsLDrNYx5cS2tUYKmwo4t/0rb
	 5aGMqezzx7ZoQtAQ1V5j3M6P6DFroIMby/wEmXYLkodxFXlzZiU8m/XvljxEavUk14FNC
	 oX78W8k+lG5TFVXhu/PGvkKem8Lq035odNPU4zH2wwcTU54mJ/Wil4WgTrKdT6ch/ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="gO2FpF/f";
	arc=none smtp.remote-ip=95.215.58.149
Received: from mta1.migadu.com (out-149.mta1.migadu.com [95.215.58.149])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B9606A326
	for <sched-ext@lists.linux.dev>; Fri, 20 Nov 2026 03:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A84B9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gO2FpF/f
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=RTGjO70kQTAFrOBvzmLzPFg5yur4DkRsk7Mr2E4IJY8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795145561; v=1; x=1795750361;
 b=gO2FpF/ffEFAVnc1mnDDF77r/aKWTt7jnIQeCvgm6qU+pdYnpnxpWhZQ+eA11DOW6D1TiQWI
 OaxH+3De3KiV2AxLJ8Ykef8WA3En20VikE4NWWpRF22ZRk/pcPDVlJTp9wV0yvuF2gQLgLPHwNR
 DDQtw3FRwAmq2dcuo9X+jxyg=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id d9dbb3b872ea00c7;
	Fri, 20 Nov 2026 03:32:41 +0000
X-Mizu-Trace-ID: d9dbb3b872ea00c7
X-Migadu-Flow: FLOW_OUT
Message-ID: <8c25083c-dfbe-4fdb-80b8-bb42f0394de4@linux.dev>
Date: Thu, 19 Nov 2026 20:32:37 -0700
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
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/17/26 12:21 PM, Ihor Solodrai wrote:
> An incompatible change to a kfunc's prototype, such as an added
> parameter, breaks BPF programs built against the old one. libbpf
> ignores the ___<flavor> suffix of a kfunc declared in a BPF program,
> but makes an exact name look up on the kernel side, so the kernel
> can't keep the old prototype available under the kfunc's name.
> 
> sched_ext ran into this. cded46d97159 ("sched_ext: Make
> scx_bpf_dsq_insert*() return bool") kept the old prototype as
> scx_bpf_dsq_insert___compat, expecting libbpf to bind old binaries to
> it, and broke them. 2dbbdeda77a6 ("sched_ext: Fix scx_bpf_dsq_insert()
> backward binary compatibility") reversed the naming. A ___v2 kfunc
> declared as vmlinux.h spells it doesn't bind: 56bbc91219c0
> ("sched_ext: Fix scx_bpf_dsq_move_to_local___v2 compat detection")
> fixed a compat macro that silently dropped enq_flags because of this.
> 
> With this series, if the kernel's bpf_foo kfunc is missing or its
> prototype is incompatible with the declaration, libbpf binds the
> bpf_foo___<flavor> that has a compatible prototype. So a changed kfunc
> can keep its name, and the old prototype stays available as foo___v1.
> 
> resolve_btfids fails the build if two of bpf_foo and its flavors have
> compatible prototypes, unless both have foo's exact prototype
> (aliases), so the fallback finds at most one match.  This ensures at
> kernel / module build time that no ambigous kfunc flavors exist.
> Documentation/bpf/kfuncs.rst describes the rules.
> 
> Compatibility is determined by bpf_core_types_are_compat(), the check
> libbpf already applies to kfuncs. Of the 70 same-name kfunc prototype
> changes between v6.6 and bpf-next, it finds 8 incompatible (arity,
> return kind, callback prototype). The other 62 (const, typedefs,
> parameter names, integer widths, pointee struct names, annotation
> suffixes) were made in place without breaking old callers.
> 
> The flavors feature is backwards compatible: declarations that resolve
> today bind the same kernel function. The exact name lookup is
> attempted first. Declarations rejected today for an incompatible
> prototype, or left unresolved if __weak, may now bind to a flavor, for
> example scx_bpf_dsq_insert___v2 as vmlinux.h declares it. Older libbpf
> and light skeletons don't get the fallback.

We had an off-list discussion with Eduard and Andrii today.  We agreed
on the implementation as described below, which I plan to submit as v2
of this series (soon).

Writing from memory, please correct me if I forgot or misremembered
anything.

A single kfunc selection mechanism in libbpf:

   1. Find all functions in kernel BTF with the essential name (the
      name before the first ___ separator) that matches target kfunc's
      essential name. "bpf_kfunc" decl tag is ignored.
      This gives a candidate list.

   2. From the candidate list, find the one with a compatible
      prototype. Error on ambiguity.

No exceptions for "exact name" match (as in v1) or anything like that.

A function prototype compatibility check here will be a little
stricter than bpf_core_types_are_compat(). But it's also not going to
be a type traversal as done by bpf_core_types_match(). It will be a
new check specifically for func prototype comparison.

In particular, for pointers to structs, unions or typedefs *the name*
of the type will also be checked. And the typedefs won't "skipped"
anymore, but shallowly compared. For example:

    void kfunc(struct foo *arg);
vs
    void kfunc(struct bar *arg);

become incompatible now. And

    typedef struct foo {...} foo_t;
    void kfunc(foo_t *arg);
vs
    void kfunc(struct foo *arg);

become incompatible now.

However:

    typedef struct foo_v1 {...} foo_t;
    void kfunc(foo_t *arg);
vs
    typedef struct foo_v2 {...} foo_t;
    void kfunc(foo_t *arg);

are compatible, because the name "foo_t" matches.

resolve_btfids built-time "no ambiguity" enforcement remains.

The consequence of this approach is that a BPF program expecting a
kfunc that changed its prototype in the past in a CO-RE compatible
way, will now get an error if loaded with new libbpf. The fix is
simple: use an up-to-date kfunc prototype in the BPF program.

A notable recent example is bpf_cpumask_populate() change [1].

[1] https://lore.kernel.org/bpf/20260709182800.2037938-2-main.kalliope@gmail.com/


> 
> [...]
