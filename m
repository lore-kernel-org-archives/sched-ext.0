Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AB284690
	for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778559866; cv=pass; b=mZiS9Yv4byrYrTtBWp6yHPFC9Tn67l9WqqitC6WoWMQHbMA6D/igslmgXY/lqaMQlL2Eo8Ij1ev0fTZKZcnPvH+/SvJyKtPb11GGtku4j/nuG7IyBmkLlQtBkOaol9PpKWzg5rtKB6K0WyVA/NfDhr/dQ8QYnt/FlUovBYUdPhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778559866; c=relaxed/simple;
	bh=rEcITMB4+0LkfIr7lkfRl3YhQcJNmnW0NYCfnXkoG9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rl/bGFKLWhYlG1FYizEWcH10nfr30ARDNQCOHRyMMa5pWGv+WYz7KsI47GBxw8M7r1R+W8FipV1bcP4J60TPskOYc2Qj8WnLSSyBVueVPmxdACqXN0PDbEb0zDyJab3FLEpsBxndU5f1hM9QaGC9iT6ZZds88Li++T+YokAtD8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqw7GExc; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqw7GExc"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44a74032ff8so3718057f8f.1
        for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 21:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778559864; cv=none;
        d=google.com; s=arc-20240605;
        b=DPVf9ltXAIHL5WrsZJPOZJNr1E/kG23cRYisfHNykePuNv7qWR0fp1ePjaCidCLGcX
         P5dF2k5oClT9wOFzLBy4LEnFp+i77Qc8S4WFgixU7e709bQvfHNmvCUwj9/HfAZGkv9C
         hOqEioD6fwZoUo3FLV0d4uYPVJOX3FsSCLR1ZXSycLr+lqj7YuqcgawFQAsL6LEW3ZqZ
         5WSGKXl591NsMnnTDOk6A81HyRxq5moXsg+jZy7gPLMbHydEWix7rRHGC6aNAUXTRWgq
         qRqD5g7iXseQItkozc9gLvowJcfUN0sALMRViKRaFMSGKfgqGqG2YadAYNAipAgE/xR/
         /MGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rEcITMB4+0LkfIr7lkfRl3YhQcJNmnW0NYCfnXkoG9s=;
        fh=KtztwQR4rb5jqLLlKrN75gsrfdFpkhiGB1C9IBOaly4=;
        b=EjsCyfTjBwSBjH/nK4gsj2t60oMj4rT/Jv3g+DdpDng8QcI1NTTDrmxzKRsUfKWSNk
         SGRfowH1yofJhrYg+qomx6nhom3BoHuADVqLp1nkegENOKva2kNgWPawyD768sZS+bOy
         HBwhKWrb3fl9TdyWRR6BEsDyuju1EjOHvu0JqH7Zx+wR9Rdonc81NMpiNA54BMa+FkJT
         ff4h92AA3EIo75wjTdci3AESRAHj4Zz+EOSFp7RmH4uLMMGnkMOX64voFakenzvyEWfq
         fg30t7n7RJQJtJC3nUqFNUSOSoE3ejJIizsWdafmNWc+k2kwCuww9vwTKZ27hs/tykrJ
         hMhA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778559864; x=1779164664; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEcITMB4+0LkfIr7lkfRl3YhQcJNmnW0NYCfnXkoG9s=;
        b=Jqw7GExctx+7e2FOM52PnFFCH6ed6YArYoW+1jL8y54wi19Q94qJ/HOFUyHjJhcaZs
         +g0f9of0RDycHfC+o08eUFliy8RlWt2+jd2i2Qvc48d0/G584N7CzzBvBkn4D9B1QN4D
         Xk4id5q+FE7RHJLNZf6/7ME7cQ0HKTwPqS3KhQPM3ldKmBUML9ZKchNPbqmk+orrA8zz
         MhRGGAMsumBBPJiwH05bAEk38ZN/PbzxC8iUKufyalO3Xoq5ordyJhEUQ5GslXfhP74i
         DQyhO41odrLmlE3LFoL1WsmbzqFZL8WK1sc9OJDA23IO+ZBaVf501jLeX1AXqWEHY5+E
         3K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778559864; x=1779164664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rEcITMB4+0LkfIr7lkfRl3YhQcJNmnW0NYCfnXkoG9s=;
        b=eXWSoU4cU/aLK1PR6AM7y6NYJp2R2dqo6eIE5ShE3zOKxbHu8LkhX9yqfNDKMuiRfv
         gh0EbAG2l3iajVueXloYNIeG+/6MI+zf3191T6q9Ow6LE6Mhl7dqspPzVrlQl0gEG2SY
         cOVZ201OP+s67//FPFxTvYQokMRcyrNFv607rP6DMGNud+EPpSieUuuC/IotYz933t/o
         yD+To58KDhF37xUxe3ND6zlc0l0rUZvOcgqEtXobjafpv36XSbTzkzTfrkDSVEjt1keL
         ENsNMi8iiKcbPUAEawnlVpqUPQwsf9e8chobE2AJ4ER1GHNbLuZcMpvtcxMLl8rrNIQZ
         tc9Q==
X-Forwarded-Encrypted: i=1; AFNElJ83lLnZphN0MKtyQmSXgnpWb83WaGoUay6LlMVvACCBqjXHj6ttJAOrLI8rNwcMw6CrmTSax8r4xkA=@lists.linux.dev
X-Gm-Message-State: AOJu0YyrUuxe3dohSJmdLwbFXDyhKq+WSG6WpRyGJIojnylYaHeztxEi
	R3UlaVgODdt/wnUFEiVXYOOcrn4Ui1MtPhknAHPP8tFKkYuuDmrUbgq/qhe5GtZIWTLNTlEIN50
	Q33scC0r/bK43tMqs6tBrzLBlYMbru84=
X-Gm-Gg: Acq92OEDMT1a0kiKEbPHP8FN7W1WjaiGr26kI05Nl311QLoNunMOYSrAVFFAapH38bD
	zZn7sD8cq1x6BCvwpyGW1DJ87IGSK4zVZoBq9jNVR6tsQvpE6ezhsedsBRrZe6hW02qr0ymS8/o
	vg5B1UEgGvfvVnix00dxt0R1YnyUqSjN6/mI7hZWfYlQEPrM+yIFZEMSAjy77NsRhsJLq2+0jtC
	1/jVXRzwvL6FvkUi7+0T/+8Yp0rsJ18tzReVjCviYt9ynYD7atetrdCpNMhU2RQ51D7pvVkK0wd
	yJKGxawFtjtW6S1VTQAgrCk7VjRdf8YeHcfsCCeQxgLLXmuh5JNSgKvqIAwToNWYQg3b1OPcYy3
	hIEaDAiyYC7j+42rGl34fIpaTF3LWouVqFxMA
X-Received: by 2002:a5d:588b:0:b0:44b:7ec9:2d76 with SMTP id
 ffacd0b85a97d-4515b056d5fmr43891510f8f.7.1778559863458; Mon, 11 May 2026
 21:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260427105109.2554518-1-tj@kernel.org> <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
 <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com> <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>
 <DIGDLA5275AR.128FTQMU7Z8S3@gmail.com> <CAP01T74MP6+igNsqhDinYXbk2mFB2zW6Kk6Lb7srrWM8ANojvA@mail.gmail.com>
In-Reply-To: <CAP01T74MP6+igNsqhDinYXbk2mFB2zW6Kk6Lb7srrWM8ANojvA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 May 2026 21:24:12 -0700
X-Gm-Features: AVHnY4JbmRmoLiyIrtTCPPrLDOfNzNQqeFWDcIXyHeMkB4ngpaEfYyyARPA0-E8
Message-ID: <CAADnVQKfMHUZ8YzLkWW--f1G_+mx6bKdvVHUMArYsb+6-esWCA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for direct
 kernel access
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 8:49=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 12 May 2026 at 05:25, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon May 11, 2026 at 7:43 PM PDT, Kumar Kartikeya Dwivedi wrote:
> > >
> > > If not, the best course to me seems to be to make the flag behavior
> > > default, and just rely on ASan (and Rust in the future) to prevent an=
y
> > > memory safety issues, and drop the stream based feedback on fault,
> > > etc.
> >
> > Agree that this needs to be new default without new uapi flags.
> > How about we tweak the idea further.
> > Let all arena pages be unmapped initially. bpf progs will fault
> > on them and will be reported via bpf_streams.
> > But we also prepare one "scratch page". Let's use this name,
> > since "garbage page" reads too dirty.
> > When kernel faults we populate pte with that scratch page
> > and let the kernel code retry.
> > To implement it the page_fault_oops() can have a callback
> > into bpf/arena helper similar to kfence_handle_page_fault.
> > If fault address is in arena, do kfence_unprotect()-like.
>
> Interesting idea. So I guess this page remains mapped once kernel
> faults on it. I guess we can still reset it to NULL if we alloc and
> free a page at the same address, so it's just a drop-in to prevent
> further faults inside the kernel, since emulating instructions is ugly
> and we're not using asm wrappers that have fixup labels etc. If we end
> up allocating and freeing something at the same address it will likely
> get reset to NULL (that would be ideal). But even if this happens in
> parallel we may fault again and then will just fix up the NULL pte
> with scratch page again. We can likely also preserve fault reporting
> into streams when such scratch pages are brought in.

Yep. All makes sense.
The hope is that faults from kfuncs should be rare
compared to faults from regular arena bugs.
So the stuck scratch page shouldn't happen often and
faults on unmapped will still be seen most of the time.
