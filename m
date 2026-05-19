Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA893AFCF6
	for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217500; cv=pass; b=J/BdyWOTyL8F2QHLwG24CoJd0Vz/Hw52ccGM8Hz7RlhXLDrsYPSja8onPJ4IHKQ/HuCuCRSBP3SStTNtDDBtbNIWndeGzmW8d7gPeDj/klD3ltcf32eoTxzkOphRkay2zK3EC/NXuJj84iaOmJMn8eWvHaK9NlSfTO1eM+d9Bes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217500; c=relaxed/simple;
	bh=cojGRWW/Ex1hiO5wrDav3feItUxRSAUPq9EN/ARWbRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrSem9tDsISlmIow/6FZvFYrAZ8AMeD5eKJ/uop41NTVG0MPFNnFWeZIenOFA6sx8KPzYm+oZ7OABMn0egXoquTroAonKnTsFnBwnZo9EJMQT4nABcMDVL/XywLRDA3dwhWeO6VdybRhNZ0VgZXR+ewKmIfeNUPV7DlquTFMC7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKdXqJ0Y; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKdXqJ0Y"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so23488645e9.3
        for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 12:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779217495; cv=none;
        d=google.com; s=arc-20240605;
        b=bbiGyirHwKOpjt1RSYNhY4CqXiMWH7UfnaHVvAQRnhuTJKRbLxWJHpWPgRaRDgVa5h
         awk90qFuKw7bCpBGaGk18vyx3JAMTa4hDaFsKTwSuUTu1co2xvBrpfD1Q/cwIT47wBKc
         aPl2zt1JIkSW9WlEl+LHVjQ9f1uqOB9oapEJrKxsXiBZoiHzS93gPxDZXg/kD7tacEQ6
         MZ5tp+5H7A5wYJ6yotQJxgsfCZB1uxKIIVBCW/L8NIyGvm97r6E+3PdaSbiGx149I2p1
         ozh4k2nC6rnM/g9P5FA7OfL1yMdVj9Ls6UmgV1dfrTmv+fgSxTOfZrV+I4N2DJeDL33H
         JqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cojGRWW/Ex1hiO5wrDav3feItUxRSAUPq9EN/ARWbRI=;
        fh=6g50fVg9s3n6YWnBNdeDHwzk7nd9ryvlmwpxTBg5xzM=;
        b=QbDhDIZqIV8JI+rdDHQB1zexMuEJdkaUsnRLlF+cjMv+79iJMy0rrWFPOapffeAYIM
         lV0weTHeMCLa4KncqOJfMZh5hWbzdrM6klQUGaeAQpdimrMoIwShqsujFZsQLTK2XGlX
         Kmns6cI7ebt28ez/4cpxJ1ACX8tbQktx2TZGqqZTQm9DxM3VpmcL7Psr+9sCxM7B+Akb
         bGEg3EuGnWqH7EPpKPfBP/qvZQYsPd96Ubs16FZMqiI+SjsD8plhCCZT8sKUAwYkBpZd
         8hMUj4/3cFfpvlZ8iykfJ/FdFVyGdwhxnvV51KQhcW233fwOsSpQlfhNrYNXKzMcpdHf
         a/4Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779217495; x=1779822295; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cojGRWW/Ex1hiO5wrDav3feItUxRSAUPq9EN/ARWbRI=;
        b=YKdXqJ0YfppTbm+F3uLnQLyaTwJFNZFHjFSKHFr5zopLBc6NsYjHoyv7fUG5fAq27j
         sKwItJ7+iq1K/NqJl9fSqDg8TlI5osCBllw396ZoQ/xpiV4sEwPRJ4Yrt0QOVZj3bKHU
         OJ032BfKUuplQ4+FxlAZx/e6q2G4iy6UyPhH2npOFUa/1unQbakVgcEt7cT8cD/mPyDK
         dhm1ZMQDpPlsKUKZIrO8uoHEG5vSaZjV0e2snSgd4fWHGEqZuuXJWzbfLhcRFAKFmb3G
         JTHAGGn4J0BIbmCq59KTYVRlVAXTuLZYQyuPgLTqFPsj7OLAAXOEZ+l91FZMCQZxKvmm
         oFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217495; x=1779822295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cojGRWW/Ex1hiO5wrDav3feItUxRSAUPq9EN/ARWbRI=;
        b=ait06Jh+ZBVRkgJQFKQOprRESAO3+NH/tJNq2BKEalpodez24IALRnXMpae0iPUUIe
         WbH6eTE0Sj4SmMYvqHPajAVkUKqXYR0uTJChifYhONthJoVTAxKPAb9NWfvtvFkPgggX
         D601k5v0UsHgwuFAtR9M5uOTQ9Doc9xvE8G4612oR0mPyeylYq7liH60pUCJF88POQbD
         PO58RWRX47j0+PFMJ24px8aJ5A4PAwhKYMmnTOsIKrzUXhgazkkAqEuF0zItVOLb8aRW
         evKOHX2vEWGxnHvP98EDeLWYU+0j9pOh1+CeTA6QnH8DxGCyvaveCJaXndjDcBoTZ5VE
         cEgg==
X-Forwarded-Encrypted: i=1; AFNElJ/AYyMKAv/RMssXQMVp2JMyBGamgPzJ3y8U6zp1avWMBzUEQv3KNBlnuY8EPEJnBLhG4tFQ1S5hIsI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5ceSL1oWQxDHIBTIv3sUQ/ZIGaaVQm6XUJcYbcXJoTy25DmYk
	fsvKmh6f/+6QkCffrj59BhJHHcHEWXmM957NrInzKM9VB6ooulGJvQOgMCGGQGGW6ga0wrvmg3v
	6uzLolHfMDX092hMGF6bnuBJsfOXg6OY=
X-Gm-Gg: Acq92OHE+lwqBqtoRXx3GKkqS6ZSSyUa7HOA0OL6gZP8lbtiJQxYuQ5BREuU5r1K+I/
	xrsaFownI7ghHPrKqHfg2+cshz15v9v3eO4nKFKgt8UJT3qRjxqiTe+ZySeuTHHRQAWMMa9Yh4s
	PPPmOVxN0En6sYwelNe/GDWbvzF/o6SWWvUDA15Yexm58xK/FORm6IFYegLaGDlBxxEojNT2/Iw
	MwHpy2bXAdzvthXnjG+Khj718Oeozi3rTMYfUX00lntj/KKs2A/pwdD7KXahvOlwtaq/zrp2lKX
	c+RItm2dC84RN7H1tSdtNAGGonoDKmLcYbX5Xpa4Zu84AJbnBvCh0nnp170MjwYmXWEo8WU=
X-Received: by 2002:a05:600c:a00f:b0:48a:5301:bb5c with SMTP id
 5b1f17b1804b1-48fe63263dfmr337569515e9.16.1779217495209; Tue, 19 May 2026
 12:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260517211232.1670594-1-tj@kernel.org> <20260517211232.1670594-2-tj@kernel.org>
 <9ba50fd2-077e-4291-9276-9adb18186873@kernel.org> <agtuPrgIDNKSu2Oo@slm.duckdns.org>
 <2f02d90d-cdc9-48ef-abe3-99e00f22595f@kernel.org> <297658c4ae2d6e7103f5968efc936224@kernel.org>
 <04b03066-86d3-4c0b-b077-307fd0f3bc9c@kernel.org> <5590fd3d-dae1-4070-b52f-bc40982ac678@kernel.org>
 <agyZxmHoueGwBAQg@slm.duckdns.org>
In-Reply-To: <agyZxmHoueGwBAQg@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 May 2026 12:04:36 -0700
X-Gm-Features: AVHnY4KnCVsDx1rhJ5Rhju09kIJne6tHjry-aCcLnmL6aRppUmxM6vRJAa3dciI
Message-ID: <CAADnVQJt0p7hSn2G074QZRh2LEdthy3RKYJ9j3w5yeJ-e8UQLw@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: Add ptep_try_install() for lockless empty-slot installs
To: Tejun Heo <tj@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 10:11=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, May 19, 2026 at 11:40:48AM +0200, David Hildenbrand (Arm) wrote:
> > On 5/19/26 11:05, David Hildenbrand (Arm) wrote:
> ...
> > >> The only requirements are that the kernel doesn't oops and the
> > >> violation gets caught. Beyond that, behavior at the address is
> > >> unspecified, and which installer wins the race doesn't matter as
> > >> long as kernel integrity holds.
> > >
> > > You'll have inconsistent TLB state.
>
> Wouldn't it still be either or with both cases being okay?
>
> > > I really don't like that approach.
> > >
> > > We should really try to just take the lock, and remove any code under=
 the lock
> > > that could trigger such unpleasant deadlocks.
> > >
> > > Is that feasible?
> >
> > ... or can we run into similar problems with kprobes? (I am obviously n=
o bpf
> > expert ...)
>
> Yeah, I mean, that was just the first TP I found scanning the code. Any
> kprobes or other TPs in the path would behave the same.
>
> When this fault triggers, the BPF program has already malfunctioned, so i=
t's
> not going to be a high frequency path and performance isn't a primary
> consideration. So, anything that can ensure that the kernel doesn't crash=
 or
> lock up would be fine. Any better ideas?

As you guys already figured out the trylock is not an option.
The fault handler has to install _some_ page and let kernel continue.
Scratch page or arena page doesn't matter. Potentially different CPUs
will see different page. It's not a concern at all.
bpf prog is buggy, but the kernel will continue to work without a glitch.
bpf runtime will disable and unload misbehaving prog.
