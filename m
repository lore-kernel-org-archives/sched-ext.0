Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200FC2BEC5E
	for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551515; cv=none; b=f01Uy29PJBix07CkbGoriazG9y0D7DVPv/FFM0ONH4+b5yQWtRlEiZgpHK5RH0SZBnSa1yferh7y5DQPDzBvNO2mV8UJSoSqX44UM1OmxqH2bftvtd9xwfCJZhNFQ/m9EQs3zuTJN5f63mwRXGEY225Gt3bYAzPPGPA9YnQ/95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551515; c=relaxed/simple;
	bh=UBGLLCMo7yiQ6SX7rkr8NS7qSympvxKDRjTQiWrNbas=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=EGsYFURVNSlx5fco0ayOxHLMW/4TTN1aYUcgWe46fmP6owaQFqtscSz7uWrtD+QTl0luKvrE99nwhPtbKamfi07c1hor/wbEFt90o/3kYEU1keEILu5Jt6v/TLmlX0Fq++rn57yadNYAKbvQ+FUzh9tIi7/OSforZmjw6Eo/O8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=yOj4xq8/; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="yOj4xq8/"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-367c26471f5so2072624a91.1
        for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 19:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1778551511; x=1779156311; darn=lists.linux.dev;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBGLLCMo7yiQ6SX7rkr8NS7qSympvxKDRjTQiWrNbas=;
        b=yOj4xq8/rn3A89c6e+g3HzsOMQJE2GSbqcPVq/xELK1TBOJNE0dLCW/K2zuJF5fGzr
         seNkRJ1RkUbSNOwNLwo0vYFeifE7BZUdpAqpeTJW6Etc/VTAR5UJDMv9xull51iV36r2
         5nDwgalDyDSKuFJpipDUc2HsZkYcqxl5NlDhvQcun4gpO/y+xlicnPhF2U5dK+bXbd65
         7LJD+dvDJTC5YZOZaIKGUXjHIV9tkAQkxrDTxxqWW2bgzF9FrhjVGYw7gLUbyK1rMPMR
         oLhWv8dEgH3K5Y3pOXqTfx/Ho9YCglD9sNiruC/t1iG1p/9VmqITjAPo5nnZT+rkf2y1
         L/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551511; x=1779156311;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBGLLCMo7yiQ6SX7rkr8NS7qSympvxKDRjTQiWrNbas=;
        b=ZFf77rpwSUC0J4DVseQjqCePSo14pl5ULCJ1NUCcHtzSNsa8lYsZgOUC5n3Os9CJsD
         dtMhw4N/G6PQLSwbG8qdobkmclFCdVAve9/ISPFI7hhMq6pnGM2mBmBIW09O+UgMzWMD
         qAN65kHjh9kiUV9A2dEhJROBVrS9nbvGtqB/DhPk8SGNAH3Nj2+jSx/NuvXjmxU8HZa1
         R0ZZcJrimXWE+H6S/NMdRImeJbP36S49KzObQN1zcJWpBZgIssA7NkIZM5mAsu9o+VNw
         XevTzMrTJNIINDReP33sdvrfUFUGEF36rksdq8Cn4QkKWkdBJ0Fy224xEGfaD/Gw7AjW
         0gGA==
X-Forwarded-Encrypted: i=1; AFNElJ8m+On/Xg5oCYJCBqvB9kFZ7MF8EHsSHHz3yhkuViOZt6CdCvECurU7yg2ZdfLGYWC4HSnPUWBr1nY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzVyPTuPsrBND444m2UthQyDY1dr09c87m9MpbTduECDZrDCWLs
	VSsZMrnEIl8GCAjT+X/LBI31limR3wYcwxKYWisIaXMW4UbgQCABhnlsdg4OUk84Afs=
X-Gm-Gg: Acq92OHG9LzixLiXk5z3WAOfdFTeCUVw4BC644e6vfQI8XiH8WVc44+1GGFx7Hmq277
	gMcmWiFEbDjldYuigWaCb/sGTKTCqiNdJIfDEpR05nJP9hvJO7xBluuY2XsaAau6smtk1zk/Vvu
	VI/v8Q+tRwDU0e6XBXCeKgYUbgfo4z5XNo8mpjos33AAXsataL1/gN8HsSg0LadahB0dqBna+k8
	92cIwPj5SwWpt90S9VWBgjqxwDdKsxV1ua0N32mAcTUbeRGoLHhxzbdT75a4EBObY3gmhESCqx7
	R+eH0F/yxK57NNbq60NtBZwqE0sb/xr1jTeipfH8E8/PYEW6VhRMdjl9tz1rIRVBhRhEjbdnjpZ
	UI91R+VgYWWlrgwm9yI9Ph9oE3uqpmqhGBReVjgnyTRIy3zHjESgpnaJ0xAT7RUnODRPZ9t61B2
	ovHho6bXmboORunoeXEzV0kjtczi5azicB+OM=
X-Received: by 2002:a17:90b:2f4e:b0:35f:c46f:2b0 with SMTP id 98e67ed59e1d1-365ac080c4bmr25713690a91.14.1778551510958;
        Mon, 11 May 2026 19:05:10 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368b9afd07csm152067a91.6.2026.05.11.19.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 19:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 22:05:09 -0400
Message-Id: <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Tejun Heo"
 <tj@kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Eduard Zingerman" <eddyz87@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, "David Vernet" <void@manifault.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for
 direct kernel access
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260427105109.2554518-1-tj@kernel.org>
 <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
In-Reply-To: <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>

On Mon May 11, 2026 at 8:31 PM EDT, Kumar Kartikeya Dwivedi wrote:
> On Mon, 27 Apr 2026 at 12:51, Tejun Heo <tj@kernel.org> wrote:
>>
>> bpf_arena's kern_vm range is selectively populated: only allocated pages
>> have PTEs. This catches a narrow class of buggy BPF programs that
>> dereference unmapped arena addresses, but the protection is shallow - wi=
thin
>> the allocated set there are countless ways for a buggy program to corrup=
t
>> arena memory.
>>
>> It does, however, impose cost on the kernel side accesses. A kfunc or
>> struct_ops callback that wants to consume an arena pointer cannot simply
>> load through it; the page may have been freed underneath, so the access =
has
>> to go through copy_from_kernel_nofault(). Out-parameter writes currently
>> have no equivalent.
>>
>> Arena is becoming the primary memory model for BPF programs, and more kf=
unc
>> / struct_ops surfaces will want to read and write arena memory directly.=
 The
>> actual answer for catching arena memory bugs is arena ASAN, which addres=
ses
>> all memory access bugs meaningfully. Given that, it's worth offering an
>> opt-in mode that drops the partial fault protection in exchange for chea=
p
>> direct kernel-side access.
>>
>> Add BPF_F_ARENA_MAP_ALWAYS. Arenas created with this flag allocate a
>> per-arena "garbage" page and pre-populate every PTE in the kern_vm range=
 to
>> point at it. arena_alloc_pages() replaces the garbage PTE with a real pa=
ge;
>> arena_free_pages() restores the garbage PTE instead of clearing.
>> arena_vm_fault() ignores the garbage page so user-side fault semantics a=
re
>> unchanged.
>>
>> Stores into garbage-backed addresses are silently absorbed; loads return
>> indeterminate bytes. Userspace mappings are unaffected. The flag is opt-=
in -
>> arenas without it behave exactly as before.
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> ---
>
> If we go down this route, we should probably make this flag the
> default behavior. Otherwise, we cannot universally enable passing
> arena memory into kfuncs. Every subsystem will have to check the flag,
> we'll have to gate being able to pass memory based on the flag's
> presence, etc., which just adds complexity everywhere. It will
> eliminate a few patches in this set too. From the programmer's
> perspective, program behavior isn't changing much, so we can use
> zeroed page (to guarantee faulting loads return 0) instead of setting
> the PTE to NULL. While at it we should drop
> bpf_prog_report_arena_violation, and its various users.
>
> Summarizing past discussions on all this, with more details on various
> pros/cons:
>
> Currently, the semantics for a fault dictate that the program simply
> continues, and the destination register becomes 0. One could argue the
> ideal form should have been to abort the program on fault, but that
> wasn't possible at the time of implementation. We added fault
> reporting to the program's streams to improve debuggability. Now since
> we have an ASAN implementation, you can likely run that to catch
> memory safety problems. An argument against this is that it doesn't
> help surface a class of issues for production programs. We don't have
> data on whether stray faults or memory corruption within present pages
> is the more common occurrence of bugs in the small set of programs
> using arenas, so it hard to pass any clear judgement. One thing we do
> lose is faults on NULL-derefs, which are likely common, but Emil had
> some ideas on that.
>
> Another thing we lose is the ability to build something like GWP-Asan
> [0] that we can run in production programs without paying much of the
> performance cost by sampling allocations we want to detect bugs for.
> But between ASAN and Rust-BPF plans, I am not sure how compelling it
> will be going forward. So while it's sort of sad to lose the ability
> to fault feedback, it is also non-trivial to enable direct access to
> arena memory for the kernel while preserving faults (I won't go into
> the details here) without using fault-safe memcpy to move data from/to
> arena on the kernel side.

I completely agree with the discussion points, though imo we do not=20
need to make this flag the default if we support it. The complexity is
mostly checking whether a kfunc that takes arena arguments accepts the
burden of validating them, or if it depends on the new flag to prevent
faults. Any new kfuncs should have clear semantics on that, and we can
validate proper behavior with selftests.

Whatever we choose, I am strongly in favor of keeping some kind of error
reporting when touching the first page in the arena. This has been by
far the biggest indicator of bugs, and if we only keep ASAN then we lose
our strongest signal for most use cases. This is made even worse by the
fact the new flag is incompatible with GWP-Asan, making it too costly to
run sanitization at scale.

For the flag, the solution would be to move reserving the low addresses
of arenas from libarena to the arena itself. The arena would have a low
watermark below which it would retain the existing faulting behavior.
The kfunc would bounds check check the arguments to ensure they're not
below the low watermark, and fail if they are.

It's not ideal - it adds the burden of bounds checking into the
kfunc - but it's reasonable that arena-related kfuncs should take into
account the arena's semantics.

>
> [0]: https://llvm.org/docs/GwpAsan.html
>
>> [...]

