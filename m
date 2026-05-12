Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6C384CEA
	for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588959; cv=none; b=axN2zGhcQgpCJeTzu/klZ+K0vbHkfJGZKDeuAUtqpHKetb86bpGY4cNSEhea2vRI07fyaU15XFD/NsTaIEIM9syx5ERE7eu5dxAzFvZYFCc0Uihx7QE9kX/hLdiSFG0CmkYQAT4s4WQt+oWZIE5+mA75uAuf8iqTJxLX5TiL28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588959; c=relaxed/simple;
	bh=umVNWktZmfkRdQrYKl483CR+VTehRJFRdPI74iAAm9M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OVBWKhVKtHhuIveus4NjmdfRSMV4sY+dI51GcdaZo4cL46bLu91JVsTYJSspv4V2Jfa8Y92dlbvtIm7QanvcNgczFflHHXtFW2gewdzeCffdnnl7HAllQ9f4tzBIGOVP6Oonnz5H+VSjnaW1PkpldsizDbWdJYN+59+ANE9KR5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=cF9LNjYa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="cF9LNjYa"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b9e9a6802aso21867855ad.3
        for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1778588950; x=1779193750; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umVNWktZmfkRdQrYKl483CR+VTehRJFRdPI74iAAm9M=;
        b=cF9LNjYaNSz0cFbFrk1QUp089SGno9eYJ8vvhrodnTrrRyYYooBPZosQnZDd40Uk9k
         eRlylyt+uqtDyuz0XN/djXwp4k04ws7sSCuAM6Z7Oc9pDXuLEiiawcNa23Ro2DBOAonT
         2xYqCKR7Kfre2YeHeRVr1JRgdDqERAk3qfpLzgkqsvp0RBZyeKWcMb+/kWt691KSwdlq
         gLRzsnCVUyWwxrmhpVgcqpTiqVGcY44Fzu05pecakL58ojA4hmX7rnQ6SUA3bwlP9Ywq
         w1dt/g5c6hlu4GNN6i1HuXUpvpk51I3bNBGQ4Q8SdkcCWJL7n1Nw0BJOLZLnKqfKsKjt
         WPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778588950; x=1779193750;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umVNWktZmfkRdQrYKl483CR+VTehRJFRdPI74iAAm9M=;
        b=pvqUGy3Kc4yHbjMObxgdXa4h9toUaSP0Xk48sC9TyQvvdnrMS1n9wKeFDNYnm3bQ9O
         vHBdB/iGPriObqlyqVne3cddO+7YHJKF2VQMfU6dEzG/+pu5Jhumu+4na6c6fjjqEsOM
         pu1gaZskG8kaR316hYJZe2YAiiomHLBnua9yWGd0zhosEo9qpIg3CM4O4tM2SH+dY/aE
         N1JkN2OQK+mCJi0RuH2jZrbtui7DQ4prIj6XXdegohSMmWGCp0e9fjUDZo6UPW4CfQ5G
         wNs53AnCkhEe4zXOX7x/xt44KnotCVoZ7ce77ueLJvdGOQUgCZfT8ywV8xwJCtc5hi+5
         TZ0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8GAfdnBXlJUwaNgt6HK7mj8V+8Ts+xAxD2ySC6GTjT4i+LJym1wHNXeCdW9Dlqb2g1qenh2KdtbV8=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywd31Lj+RL7yP3h1OlnjvPb+seFdYvLuNSSJwQpVnDCFDZGlo6A
	y8RApZQ+M+MyiGHmnpIBtPEd/hHMpH5coKwCBFQgPjgjaajJ6H17owcNyWjsJCbBV/0=
X-Gm-Gg: Acq92OGwxc/XI70s2SIIhlPaxQRHGdA5FV+EO9wMXhrCmH9pp9qQsw1VGP2WsiuJ9JF
	yrLbdR4t1WvGjpCLpZ4mhEZIitYhhoyyJSir7YEwy6ZmcqvxkxcNK27QVAuxu8/se2tfwBxfHLK
	tlzyRWbW8yOYo+NGw50qic/XSwp9PjxJpdDNrAvsfBRwjvJCLxGzGROGfgv0CyFeR/ChvrY9cRS
	LCLlc9UafZGkFHy1I1u6AKyBYQec0t3A6zpNQUO+T7+3f30JAuyOkNupKq6n+WoXd67iyi25j5w
	m77k8kG6wWNt91ISlQA1r5lwkLGOIpC+YE0NszLxGpVUkKOxLcb7SLUzqV//3TcUYmoQ5mKfUNC
	MfX71elEJi1dJOT1dxh7wGpYX6hLOgklLdLVL/HeYmJBoiOCGP2e4GgF9+MTWnuQc27wYg/PfOs
	bxXUTtT4k4CadRSfLG1EEpPwmb
X-Received: by 2002:a17:903:2d2:b0:2b9:4941:7f6e with SMTP id d9443c01a7336-2baf0cf399emr200710255ad.2.1778588950278;
        Tue, 12 May 2026 05:29:10 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d405adsm137845385ad.28.2026.05.12.05.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 05:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 08:29:09 -0400
Message-Id: <DIGP5VDNWMJ9.2HXDCVLOPWAMT@etsalapatis.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, "Tejun Heo" <tj@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "David Vernet"
 <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min"
 <changwoo@igalia.com>, "bpf" <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>, "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for
 direct kernel access
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260427105109.2554518-1-tj@kernel.org>
 <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
 <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com>
 <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>
 <DIGDLA5275AR.128FTQMU7Z8S3@gmail.com>
 <CAP01T74MP6+igNsqhDinYXbk2mFB2zW6Kk6Lb7srrWM8ANojvA@mail.gmail.com>
 <CAADnVQKfMHUZ8YzLkWW--f1G_+mx6bKdvVHUMArYsb+6-esWCA@mail.gmail.com>
In-Reply-To: <CAADnVQKfMHUZ8YzLkWW--f1G_+mx6bKdvVHUMArYsb+6-esWCA@mail.gmail.com>

On Tue May 12, 2026 at 12:24 AM EDT, Alexei Starovoitov wrote:
> On Mon, May 11, 2026 at 8:49=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>
>> On Tue, 12 May 2026 at 05:25, Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> >
>> > On Mon May 11, 2026 at 7:43 PM PDT, Kumar Kartikeya Dwivedi wrote:
>> > >
>> > > If not, the best course to me seems to be to make the flag behavior
>> > > default, and just rely on ASan (and Rust in the future) to prevent a=
ny
>> > > memory safety issues, and drop the stream based feedback on fault,
>> > > etc.
>> >
>> > Agree that this needs to be new default without new uapi flags.
>> > How about we tweak the idea further.
>> > Let all arena pages be unmapped initially. bpf progs will fault
>> > on them and will be reported via bpf_streams.
>> > But we also prepare one "scratch page". Let's use this name,
>> > since "garbage page" reads too dirty.
>> > When kernel faults we populate pte with that scratch page
>> > and let the kernel code retry.
>> > To implement it the page_fault_oops() can have a callback
>> > into bpf/arena helper similar to kfence_handle_page_fault.
>> > If fault address is in arena, do kfence_unprotect()-like.
>>
>> Interesting idea. So I guess this page remains mapped once kernel
>> faults on it. I guess we can still reset it to NULL if we alloc and
>> free a page at the same address, so it's just a drop-in to prevent
>> further faults inside the kernel, since emulating instructions is ugly
>> and we're not using asm wrappers that have fixup labels etc. If we end
>> up allocating and freeing something at the same address it will likely
>> get reset to NULL (that would be ideal). But even if this happens in
>> parallel we may fault again and then will just fix up the NULL pte
>> with scratch page again. We can likely also preserve fault reporting
>> into streams when such scratch pages are brought in.
>
> Yep. All makes sense.
> The hope is that faults from kfuncs should be rare
> compared to faults from regular arena bugs.
> So the stuck scratch page shouldn't happen often and
> faults on unmapped will still be seen most of the time.

This sounds great, it pretty much retains all arena behavior that we
care about. The most important part is that it reliably reports the
first memory access error, which even now is the only one that is
meaningful. The delta with current behavior is that subsequent accesses
are not caught, but we don't care about those because they are very
likely caused by reading zeros during the initial buggy access.

Would the scratch page be actually mapped into the arena radix tree, or=20
just the pte? Because if it doesn't then I think we don't even need to
worry about resetting it from the arena side. Just allocating it at
a later time will overwrite the scratch page PTE with new valid page,
Until then the page is accessing the scratch page, but again we only
care about the first buggy access.

Small nit: Maybe default page instead of scratch page? Scratch page
sounds a bit like scratch space but we don't actually use the page to
store any data.
