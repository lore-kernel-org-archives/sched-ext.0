Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207C3E1212
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933522; cv=none; b=eZ5cC9TA1M9zwz4hmznLl1APWTHlN4ZuyEY0u892En/DnBvHHbVS1YPmYWlBKDi/QXjI6ty0GnuKMRoofOsj+PAHeohb0wsGUIYJJai1QcWjCZffJiOGdxqwTZJ5HRJY9L7e0mbW186S3e/aUGvLW+0+BkLL4frTf8Qgig2Dbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933522; c=relaxed/simple;
	bh=niHvY7MMeL6zV9kP1e+ImXILWXsXsinBqgjGIvN5SIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NI/Q9fsXtuT23uiwwlp39MD1aCkY2hGUTNBjqMyQ3/44zRCug82gMv4iCAyNArHHuP/5rKAafnmcheToumqJ4pFkXNMkQ5rLaPdkoAUayMFClhtkXIbzr/hYmhP2eVP//DnZJMgTFeqxmPrrLHjMylWruxjp8b3Hm+xgjYgp3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QfbGoKbd; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QfbGoKbd"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b94062e85f9so200442766b.2
        for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773933519; x=1774538319; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=11lXjlr/6EIc6z6eP9gKbX/qJapbPddaLXGFefOuYDo=;
        b=QfbGoKbdBAIx+jBbTf8tgqBM7MuJruhM3pNZBlmZoP/MsI7HFmo2Ihi1PBUoMnG1EJ
         CfdgaLaMVwSAIYb+lTWGL8RQya9Gz05ahfj/sQ2VrqllMcKGV6zInGRESjIQyEZ9WRmi
         7ZIBID+Xh24IdvpiAgIF96G0zSJ84xsofGTYiL2rtD9M4U0BxsfJcCsp3YKL8Wbe6sNB
         uZsmYonEbuKcpSO5Stpz6F0B6jS6Wv0W/aO/SZOozODK+h3zv8izFpCtdvSKADIXnAwJ
         XSxjwI8yvUvqJbSxH2y3kcU0KwxM27cij2LDoIpzTMZjE3CAWp8ycI0FVyX7bc1b9eBl
         pSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933519; x=1774538319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11lXjlr/6EIc6z6eP9gKbX/qJapbPddaLXGFefOuYDo=;
        b=LniwmIiN4D0LVocVTJPslm3n/F8DmOEeBakBxDq70EVl780b8Xcjhg29IrhkfNVjV8
         /e01K2EEkHts61f8XrVnBKdO2QWaMEBrNKGE8Zglf625Kaviukk1LHYwqap4+2s1qXst
         bnSz86b8bU2V+M8zUY/eCRWa6pgphVjwNJJUmhpsoBvOe5Uc3cg2fMRo0taDOXuYQAEq
         Em7pz22Y6/KwiwbIMlxX7OPQc6C/37/rTjknQ4F2TY1fHZ+oS2mvFS530ZNm8UVMGlpr
         yaC0DDDxgmdWSSFrG3SRS9tjAiJvQSvmsGXtxDcMzfatNtBKRZvLB6TK/wFMLxkTY98k
         itOg==
X-Forwarded-Encrypted: i=1; AJvYcCWPTg9N/VPZPRnq1gNjQs69+BzygnLK+ERqX1rtmufOW48RP0FF57MJhmKVmGLN7WAansWV08dEipM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/OSgKQVB2ZKS0xYUk9zqx4lYJ6OS1Wv1KmkT5hjG6ikL3u+Jo
	BYnc1+n5Lh6RnIKWHpOmhjCGNv8C3NQZHsjjSruGjBsOMBiA8hnD+17SIAO00MTjWwkcTWZrRCp
	5sl4MjcoIqn7OEQ==
X-Received: from edqw3.prod.google.com ([2002:aa7:d283:0:b0:667:7f8c:7f64])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:3912:b0:b97:bffb:b265 with SMTP id a640c23a62f3a-b97f4a7dff6mr431806566b.36.1773933518764;
 Thu, 19 Mar 2026 08:18:38 -0700 (PDT)
Date: Thu, 19 Mar 2026 15:18:38 +0000
In-Reply-To: <20260319083518.94673-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260319083518.94673-1-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DH6UY7YCS6LN.KMPOKET3PSF9@google.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Christian Loehle <christian.loehle@arm.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Thu Mar 19, 2026 at 8:35 AM UTC, Andrea Righi wrote:
> A BPF scheduler may rely on p->cpus_ptr from ops.dispatch() to select a
> target CPU. However, task affinity can change between the dispatch
> decision and its finalization in finish_dispatch(). When this happens,
> the scheduler may attempt to dispatch a task to a CPU that is no longer
> allowed, resulting in fatal errors such as:
>
>  EXIT: runtime error (SCX_DSQ_LOCAL[_ON] target CPU 10 not allowed for stress-ng-race-[13565])
>
> This race exists because ops.dispatch() runs without holding the task's
> run queue lock, allowing a concurrent set_cpus_allowed() to update
> p->cpus_ptr while the BPF scheduler is still using it. The dispatch is
> then finalized using stale affinity information.
>
> Example timeline:
>
>   CPU0                                      CPU1
>   ----                                      ----
>                                             task_rq_lock(p)
>   if (cpumask_test_cpu(cpu, p->cpus_ptr))
>                                             set_cpus_allowed_scx(p, new_mask)
>                                             task_rq_unlock(p)
>       scx_bpf_dsq_insert(p,
>               SCX_DSQ_LOCAL_ON | cpu, 0)
>
> With commit ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics"), BPF
> schedulers can avoid the affinity race by tracking task state and
> handling %SCX_DEQ_SCHED_CHANGE in ops.dequeue(): when a task is dequeued
> due to a property change, the scheduler can update the task state and
> skip the direct dispatch from ops.dispatch() for non-queued tasks.
>
> However, schedulers that do not implement task state tracking and
> dispatch directly to a local DSQ directly from ops.dispatch() may
> trigger the scx_error() condition when the kernel validates the
> destination in dispatch_to_local_dsq().

The two paragraphs above mention "direct dispatch from ops.dispatch()"
and "dispatch directly to a local DSQ directly from ops.dispatch()".
My understanding is that a "direct dispatch" can only happen from
ops.select_cpu() or ops.enqueue(), not from ops.dispatch(). Is this just
an unfortunate choice of words?
Would "dispatch to a local DSQ" be a more accurate phrase here?

Thanks,
Kuba
