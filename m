Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774321CC5C
	for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545951; cv=pass; b=fLbAsfGpKncyqYkwGlLtQFM2skuWAVKYV63Q8AJj71AhJltV/BMJJP56b58irUs9PL9UxQDFO4h/mIhMeTCiOnG/G4RJ0pvOFF2rCTK3elB+dQf0O0ThGtkDU3Qy9HyTn69uj/x2UHSe4z6iYPUVQQ2T7DPxHR1IWRd5ozIGlqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545951; c=relaxed/simple;
	bh=DLipxZvxsoUVWde4JunXu3jCwr9EfsRTFS5dQlBwn7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNlfe9Jb75NltQ70rkfVp3XalrKz/a6zVTyJUwWcUbsXxDGIQfngHqrH34t7GFgGhVlXGDliyvhKdV2bzka8BztpI1QYEF4S4U5QFLJvuLCcDU5/rtAWsoHjESwiU0j2EkdoEsA9RWPbTwD+kBzOVuKkKH6LfFBrLAaCX35UzgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpxgUrrj; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpxgUrrj"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-453903ee4adso4237305f8f.3
        for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 17:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778545948; cv=none;
        d=google.com; s=arc-20240605;
        b=GaUYERhJXdDLoyzEO5Rcaacuu0cYVk3ZW+w1P/W+BRUacA88ozv4g/bNtFM3p/bMPQ
         r8hCaCLrVMpIY7A/TWjqSBqJM3kl6R9BiN/AZ97BeYfVI2V0MWTF+9MCenDgxqVATpLn
         Cg5mWU+ElwzE/Y22/m3/sRyvXHVpMA8+mrk7jf40TJ4mHejbMPTAkwEWRRN3blNqbVhk
         HNhNAeCB86PRqG7+egbv/2zHdhkFz9vrRRTPYKpTe3VVXlcWtYjfAuquAm44XdFe7Oew
         LrxcEBO9nylIJyX1duaMnb805A8eY+JWm7y/9e/+XvZ8MVtlAzFCB5ATRcmK4+/zJy6n
         jr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DLipxZvxsoUVWde4JunXu3jCwr9EfsRTFS5dQlBwn7s=;
        fh=WDlgcjw83TJOwr7wDwlIELfC2IKS/rUvd7Q+QlGFsHU=;
        b=EekCISOIa9uQDHnNuzkSy4OB+V4C4XfkYfr6S3mDINpfPKE22QdmIxDF+NHjp9L/xX
         paOhQSYfy3DZvJ5NsX0KRrQjJS8lTLFueUUtN66HJc9YsTJ4mSj76AbH830aDEMhIFqX
         WwsMf3laE0y63RtZWFbSU2GI/y8uiCwQT58+WPTxTkwML+nYHZh8rGWlkPDKEovG3knZ
         kkqBFYCGDjtH2/Xwyt7tXBLpeHTcZgWp5kPENxIb9AIFo+U7577KkIg85QToSprEWWFS
         P9seTSpI1jkB2gYry/c1R4TlOGDQJc7XsaEQRqAxM2bWL7ejcXplxfkdLvOAua3eYtyT
         A0Fg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778545948; x=1779150748; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DLipxZvxsoUVWde4JunXu3jCwr9EfsRTFS5dQlBwn7s=;
        b=MpxgUrrj5/l7logIXEl3ZfEVEYqMCdICTGGViPfwXynV+VmGUI4MCTY7e3tvvjEMLc
         Ocz9XSKBDb4Y3oT/OBEh/cVLswI+DsXYDeo7u+CaOfitzdtA4n803+dECoHLZv9u0NEl
         MrP8CBRn3h0woKSzSnYE3nhjofGL8RdiKGK7XxZdX6d3xtd8xJTJifLscHEDMwYa8gDJ
         JTb6gT1yrBPZ3uhvZIUR6C7iSBAzz9s7RKpC5wREoz3/dV3UvOITfIbioawtSwZKSbl/
         KfbUcP2VdhcWoSwG12I+Z67CnTvHfXavGpdlAbRFKCCiQCBBU6+M7kBXxVj2NnmJVYgt
         tNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778545948; x=1779150748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLipxZvxsoUVWde4JunXu3jCwr9EfsRTFS5dQlBwn7s=;
        b=rlBm4yXCFek2tFJyhE9GVQtFmFgDTcklD4b46FWefU6a2rWgiX82yfcHxxrEaBRKXN
         VaLU8xiOgMpyZfqKwu9L2AsfvHIzP8Ynl8tWI+Ygj9RPoO4soXMrCRn9oaPynkQPe73r
         U2Z+O/f27eoTt7BOPXdIfoRR20We6BZxsaVWBzecyk+RY4K7cQezrLoxwgkHHSLc4Zbp
         qWuetJKKwmzVKv4gU3/WerTgEKILKn9eMIt/Lk6ox5zpOih2ZyIbblhbHwXnvy25TfQq
         qnUErZFhOK9IAQIUrXsuO0uV1FUEcUYf4oytIqH4kjsmuiWX2lX0Vcvcdc3RkOJ1OmKA
         Q9NQ==
X-Forwarded-Encrypted: i=1; AFNElJ9TtdTWVZ/mU5jFSYFNMlP5dIKaWvAsHunJ0VPUl7utiGXsUEhpXqituZPBC6obRB8G6L50LEmmUQI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxKStSGHMikHHhDbIHK46hlzIHj6s6vjWMeRqpNie7rGhK11bVP
	Enm99CKjYzglxELS8y32h9Oj3Qs+ifsRlTEs4jiZeCB6iKfZ1ESVpkKge6TtaCf1pQaiVBBdb/s
	7q2VyBNUqxQaac6bX1iraL2wnmaOwPoQ=
X-Gm-Gg: Acq92OGHBcI+s8aurx+uYbmNZ4/x4DdDWq5PlKlfzJTm1YEW1UUCz1zmVZFZoS8nUqu
	umoApEUutwE28q5/ZNCCIY61MMJMKWYRorNqlCFJLuOi2ZmGFla7FWeodCEN8EhmVoc7bA7XQoH
	DaAqnY5OooTMNOifMq2mnI0zvIY94tm6Gem4/dRWO+SV3sRjHrZPF2HieUMOtON2G3IULeqP0mQ
	7RdZVMbOxDvM25p3cuIvgBvFy4ACS0W1HAcHsrPbjZSj/1U3ImOQdPA28liGoospX1gRQbw7rKp
	UNBh0pwPX9ucP+4NmnCQvpm2nC8TWLyq6YbJt0s7DgVnsFO4Ruz+XQ2nMmAYASsybelT9kPdVX2
	tbhCCN0JMYhliqwC8mvOf+C75w0KggsfKBu+rsiiMb4clTJR9Iph+ExRDPA==
X-Received: by 2002:a05:6000:2386:b0:43c:ef4f:79dc with SMTP id
 ffacd0b85a97d-456969c3922mr16875069f8f.8.1778545947757; Mon, 11 May 2026
 17:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260427105109.2554518-1-tj@kernel.org> <20260427105109.2554518-3-tj@kernel.org>
In-Reply-To: <20260427105109.2554518-3-tj@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 12 May 2026 02:31:51 +0200
X-Gm-Features: AVHnY4IN6SRbhkgvisYjF50cU7eRw3WpE3dVeN6f3nAoVL9QPK8GJxHjvocBCDQ
Message-ID: <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for direct
 kernel access
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, bpf@vger.kernel.org, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:51, Tejun Heo <tj@kernel.org> wrote:
>
> bpf_arena's kern_vm range is selectively populated: only allocated pages
> have PTEs. This catches a narrow class of buggy BPF programs that
> dereference unmapped arena addresses, but the protection is shallow - within
> the allocated set there are countless ways for a buggy program to corrupt
> arena memory.
>
> It does, however, impose cost on the kernel side accesses. A kfunc or
> struct_ops callback that wants to consume an arena pointer cannot simply
> load through it; the page may have been freed underneath, so the access has
> to go through copy_from_kernel_nofault(). Out-parameter writes currently
> have no equivalent.
>
> Arena is becoming the primary memory model for BPF programs, and more kfunc
> / struct_ops surfaces will want to read and write arena memory directly. The
> actual answer for catching arena memory bugs is arena ASAN, which addresses
> all memory access bugs meaningfully. Given that, it's worth offering an
> opt-in mode that drops the partial fault protection in exchange for cheap
> direct kernel-side access.
>
> Add BPF_F_ARENA_MAP_ALWAYS. Arenas created with this flag allocate a
> per-arena "garbage" page and pre-populate every PTE in the kern_vm range to
> point at it. arena_alloc_pages() replaces the garbage PTE with a real page;
> arena_free_pages() restores the garbage PTE instead of clearing.
> arena_vm_fault() ignores the garbage page so user-side fault semantics are
> unchanged.
>
> Stores into garbage-backed addresses are silently absorbed; loads return
> indeterminate bytes. Userspace mappings are unaffected. The flag is opt-in -
> arenas without it behave exactly as before.
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

If we go down this route, we should probably make this flag the
default behavior. Otherwise, we cannot universally enable passing
arena memory into kfuncs. Every subsystem will have to check the flag,
we'll have to gate being able to pass memory based on the flag's
presence, etc., which just adds complexity everywhere. It will
eliminate a few patches in this set too. From the programmer's
perspective, program behavior isn't changing much, so we can use
zeroed page (to guarantee faulting loads return 0) instead of setting
the PTE to NULL. While at it we should drop
bpf_prog_report_arena_violation, and its various users.

Summarizing past discussions on all this, with more details on various
pros/cons:

Currently, the semantics for a fault dictate that the program simply
continues, and the destination register becomes 0. One could argue the
ideal form should have been to abort the program on fault, but that
wasn't possible at the time of implementation. We added fault
reporting to the program's streams to improve debuggability. Now since
we have an ASAN implementation, you can likely run that to catch
memory safety problems. An argument against this is that it doesn't
help surface a class of issues for production programs. We don't have
data on whether stray faults or memory corruption within present pages
is the more common occurrence of bugs in the small set of programs
using arenas, so it hard to pass any clear judgement. One thing we do
lose is faults on NULL-derefs, which are likely common, but Emil had
some ideas on that.

Another thing we lose is the ability to build something like GWP-Asan
[0] that we can run in production programs without paying much of the
performance cost by sampling allocations we want to detect bugs for.
But between ASAN and Rust-BPF plans, I am not sure how compelling it
will be going forward. So while it's sort of sad to lose the ability
to fault feedback, it is also non-trivial to enable direct access to
arena memory for the kernel while preserving faults (I won't go into
the details here) without using fault-safe memcpy to move data from/to
arena on the kernel side.

[0]: https://llvm.org/docs/GwpAsan.html

> [...]
