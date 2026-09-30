Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A24CA297
	for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769073; cv=none; b=AHwhMgiMcKRNUgx+Gy9rwS6vZL7LRoQbdgRR1Sk3Bz8yRBR0U0baYr6JHJ+nITyLERsSiy/Apq1YDZYv7ZWMu4JVOexUDAba4jcfdlEHvyLdURHFQSpWW9OJtzlBrUZXWHmdk4877S8xcxq1CHrgv1rjXFQYt3bRWHrpFROkFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769073; c=relaxed/simple;
	bh=1yok3FRCSGsQ646Mv0hPXKN2gXhv1QGhkM+63K5schU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ULbsv5F3wvYHohT92Dza4qOruqqdurhwzC6j5wupQqXY4uWEy35bHwoUX3N7FmrN/4psEldx1Tye4nwlnLyTwYBir9L7uoJ4sDK/P8WDONKCAInNjZSfq2yqwvIjRbSJUawOqdkdB/p0RpR0rL2vJ3ZgiRWc5h8zpticyq6e4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdD+5kIy; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdD+5kIy"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6b5c5f44so79696385e9.2
        for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790769070; x=1791373870; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NifxUDxp5Rsdto9Mf7fh+CYB6E6X8lzUhSBky1Oeru0=;
        b=mdD+5kIyMpJr9Ib48APqo2O1arzYCy8SoQK+k00E5KkBa3ZuQZYAcpgJYPLyD2mwGd
         AkJwx8gdPOSm+DnoQaYVnspgstEhdkD/Fnw+UfSSr5byP+TTg1ieY28EMcxmPDsFFJIQ
         RCYt1L3zwqKVcSz88v8SBjCyRjZObIlGlYjG63z/mBgHTFzKlh817zavXGg5Pp6bN3Mk
         O/uJfqCIHxihQqVB0qwrGTuB9RZgRhoIGnX7JDNdVeee1mkiW9WbbQo7NT4WvMnc0IPu
         AWuKL1RsUb/ZHedlI0wBcF5t0CrTeMcgOhi2a0/hhq0GV16aP20wLPBtT7TSsP+0p7/G
         UkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790769070; x=1791373870;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NifxUDxp5Rsdto9Mf7fh+CYB6E6X8lzUhSBky1Oeru0=;
        b=DvYxdRoF8IpWgViFSq9sQMTsprbpBif2LVVuXL/EbCzxiJo7f0nzcxRC9/c7030UtU
         Y5QloWAZ3rtzD6MGT0ukbN8PbYMVF5z1Nx0DZbSuBUizXq1horQsuJNV/vYaZxwNV2rZ
         49CIm+lQBtg475oVGQ8V0JgMbBvBPJz6g0jv13dV2P9LxHEOJUOLem2yFIDLYUgILz9/
         ntwCSkSsclPVTCBc4Q6AFJM4woTJ9iLlur00gWPy4iTQgiqO5UVh65NfkCjMHmYDpNyF
         bkNKmIyv3o0Qly7gyhFi/+/ok/Nyv8Np/i1mJtF/G4dDOcjy1cZQt+2bD/ZhgpBzvmGp
         mvyg==
X-Forwarded-Encrypted: i=1; AKwUvBzlQYy+CveBqJFiZTdKuI42R8JZ/wgdVccWvwoDyykXp1B1C50JlLrrcqn1hgQhuHxtkLKb01Z13Mo=@lists.linux.dev
X-Gm-Message-State: AFuF++l2GXq4W0gb9WEjGKmnNr2zSIYxzrpsKd4jrs3yfoBjWpq3nfRa
	725sjKvW8I08IdzQGqXvbDOQZtYB/pENBRKTUipG+d1LeYPcX3ogEm04oUoa3IKotdzc2i3w5RP
	cv4bmAzJMzjeyyg==
X-Received: from wmnb21.prod.google.com ([2002:a05:600c:6d5:b0:4a0:780:74f])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc9:b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-4a01afe12a1mr19133225e9.16.1790769069776;
 Wed, 30 Sep 2026 04:51:09 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:50:39 +0000
In-Reply-To: <46f4b66249f016b675fa16446b2f2f99@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929161730.185271-1-jpiecuch@google.com> <46f4b66249f016b675fa16446b2f2f99@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930115044.337291-1-jpiecuch@google.com>
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix missing
 ops.dequeue() on remote local DSQ moves
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, Andrea Righi <arighi@nvidia.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

On Tue, Sep 29, 2026 at 07:13:07AM -1000, Tejun Heo wrote:
> The fix looks good to me. It effectively reverts the enqueue_task_scx()
> half of b75aaea24c9f ("sched_ext: Properly mark SCX-internal migrations
> via sticky_cpu"), which as far as I can see only ever suppressed this
> ops.dequeue(). Andrea, can you confirm?

Thanks for the review. Following Andrea's suggestion, v2 clears
p->scx.sticky_cpu right after it's read, as before b75aaea24c9f, so the
fix is now a straight revert of the enqueue side.

> - dequeue_remote.c isn't built until 3/3, so 1/3 can't be built or run.
>   Can you put the fix first, followed by the test with its Makefile entry?

Sure, will do in v2.

> - 2/3: 7.1.y also needs 18d62044cda7 ("sched_ext: Preserve rq tracking
>   across local DSQ dispatch"). Without it, the nested ops.dequeue() trips
>   lockdep when ops.dispatch() uses scx_bpf_dsq_move() to another CPU's
>   local DSQ. It's tagged for stable too, but maybe note it as a
>   prerequisite?

Thanks, I missed that. v2 lists it as a prerequisite:

> - 2/3: With sub-scheds, scx_resolve_local_dsq() can divert the task to the
>   reject or rescue DSQ, so "inserted into the local DSQ" in the comments
>   isn't always accurate. Maybe "destination DSQ"? The new comment in
>   enqueue_task_scx() could be two lines, and the description could lead
>   with the late SCX_DEQ_CORE_SCHED_EXEC and be a lot shorter.

Agreed on all three, will address these in v2.

> - 1/3: A task can only be picked straight out of custody through
>   sched_core_find(), which only returns tasks with a core cookie. Checking
>   p->core_cookie on SCX_DEQ_CORE_SCHED_EXEC would be exact and would
>   remove core_sched_in_use() and the skip.

That's much better, thanks. v2 reads core_cookie through a CO-RE shadow
struct, so the test still builds and loads without CONFIG_SCHED_CORE,
and core_sched_in_use() and the skip are gone. I also ran the test with
the runner and all its workers sharing a core cookie on an SMT guest.
Legitimate core-sched picks out of custody do happen there, and the test
passes.

> - 1/3: _SC_NPROCESSORS_ONLN ignores affinity. With the runner confined to
>   one CPU, the test fails instead of skipping. sched_getaffinity() and
>   CPU_COUNT()?

Done.

> - 1/3: Nits. If the /proc scan stays, PR_SCHED_CORE_GET writes a u64, so
>   the cookie should be u64. ops.dispatch() pops one entry per call, so a
>   stale one idles the CPU until the next kick. Maybe loop a few times?
>   missed_dequeue_cnt and core_sched_exec_dequeue_cnt aren't printed
>   per-scenario like the other counters.

The /proc scan is gone in v2. ops.dispatch() now pops up to 8 entries until
it finds one that isn't stale. All counters are now reset before eac
scenario, so everything printed is per-scenario.

> - 1/3: The variants, error conditions and core-sched caveat are repeated
>   across the cover, description, file header and comments. Can you say
>   each once? Also, single-line comments are usually lowercase in
>   sched_ext.

Done.

Thanks,
Kuba
