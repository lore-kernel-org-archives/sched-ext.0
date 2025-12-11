Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4381E304980
	for <sched-ext@lists.linux.dev>; Thu, 11 Dec 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765463048; cv=none; b=L5O3YNWOIOSDPm5H/1l8XCdK9CDxAZlzcxtja3EAX2nMOaCJU9nvWr1ChvkzG3IKhly1yR0JvicdrdfWxnF+j8pbom33x8iR+8M5P79TvHtFqIP8VfLmAUMzEjAnZzXe2rkKniVENMyrqyPE6gqfXj1XcwAAQM2/3eM2bjf2jZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765463048; c=relaxed/simple;
	bh=e1XHdI3f932TjkztfbxisSyCsKvisyhKnU3z5nE3GGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rLzQexwwetmTkgJjGEyfUCBvSR6So5S/pB6+0GVcEr2L9ZbXVCZCI4fF/lFRNzbvuCnsMXFClW6AErL3AJas6O/jdjSN+AsKquxuxV3HUogQlokcb7lAjyTIrWGFKe/FGU5BXAgMvYzWgN0rs2fF+gsdwzp1l5JkAUu61Ij/SQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CUyupJua; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUyupJua"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47921784b97so1111995e9.0
        for <sched-ext@lists.linux.dev>; Thu, 11 Dec 2025 06:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765463045; x=1766067845; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGf8tytkhcfK83uzRhmu6L15V1EuZ+Gq3Gzcf0Y+UOw=;
        b=CUyupJuabD6iZF/j1CUhjcdwQG6jez2ns68XlEbAzP3+vaDvkyqmiFoM40b4Yj2IzD
         PX+B+tV+0QzvgCBfKVSI/ELYb79QU8WE+aTL83acSeO144+YItAUQMHKLZJ1N4qX5XEe
         SZHXhe0Eldo2EN5+QZDLDFKqU9BkmDOAEnZHygWkaM8DsXjfivhqgANEvoSjWDPr/eS6
         tXFcA0dEutSiSYu13L8khg4QfqhB3OtnZH35y/rCTpa4kZP9efli0iXGbGJ9K8rsbi+n
         J7dtVCv4nrAEbR46ZH72AgxMa8c0GanT+6vTNhxfGI+MvI3hEn5bhTOz6nJKVPElbU5n
         GD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765463045; x=1766067845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGf8tytkhcfK83uzRhmu6L15V1EuZ+Gq3Gzcf0Y+UOw=;
        b=ETA6BFRGZg4pOVhgSZ8qlAizs63Moq2RLlOgEayGYSVyz7U+LWhNYAsOtscMI0kZk/
         UhAhsSrpONR7u+jxSjlnfHqeMQzRKFGoYuofMk7Hdo+gApLTZvLSPR/yn9qgnx1N616J
         RXQo0n7pf3Bb/2V8KSB54rLDyDfwDbrO3pFkRhGqpvElUlkYav5vbkCxX4BNqTr6B3gv
         NwRWJnaHlOw1OsQgR1InYyZjfSeFSISyVeGBD2GSohTIvLDclgB9oSYKeklDBhLkcJ/n
         gljdjryD6nGvo2bSZAJvjho6OqyYukThLCwwdhMLF7QrZF4u6S2RUKDS6q+ugwAsrJE0
         mI2g==
X-Forwarded-Encrypted: i=1; AJvYcCX4uDGE2yAfml2o+fINBFtOp5c4IJw1LqnMLTu84ShGUp4HAgyN2aPOa+xoFJNAkaDp0XFocaE3kKg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzV+zLsvyDyALw8NtscchAIdqegumqTAzoXlo3qH/OoZrk5WimA
	5gAJFY7gv972jq8m6sd5ma4qwAdVtZYqgo99n8tJrJrWwzMsL176VMiroRa/+ui8A0hwpqk3mea
	6nxt3pFAjxtks8A==
X-Google-Smtp-Source: AGHT+IHhEGxqJ0vj402qs74xX1FoqzH/A2sThKIHEVsgGHDvQN9bgz38z6DTsIhRjbqIENF9nS1kve9ss0axzg==
X-Received: from wmbgx1.prod.google.com ([2002:a05:600c:8581:b0:477:9856:8f53])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:310d:b0:479:3a88:de5f with SMTP id 5b1f17b1804b1-47a8385903emr51674065e9.36.1765463045634;
 Thu, 11 Dec 2025 06:24:05 -0800 (PST)
Date: Thu, 11 Dec 2025 14:24:04 +0000
In-Reply-To: <7e9b27d70e31c243da3ce77e622b0af5@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251025001849.1915635-1-tj@kernel.org> <aP-3vOtH9Dyg_R9w@slm.duckdns.org>
 <7e9b27d70e31c243da3ce77e622b0af5@kernel.org>
X-Mailer: aerc 0.20.1
Message-ID: <DEVGF29ONM1A.CCTFEV5OZI9D@google.com>
Subject: Re: [PATCH v3 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <andrea.righi@linux.dev>, Changwoo Min <changwoo@igalia.com>
Cc: <linux-kernel@vger.kernel.org>, <sched-ext@lists.linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Wen-Fang Liu <liuwenfang@honor.com>
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

I think with the proposed implementation, using scx_bpf_reenqueue_local()
from arbitrary contexts can have highly non-intuitive effects.

For example, consider ops.enqueue() for a hypothetical userspace scheduler:

void BPF_STRUCT_OPS(example_enqueue, struct task_struct *p, u64 enq_flags)
{
	if (p->pid == user_scheduler_pid()) {
		/*
		 * Remove existing tasks from the local DSQ so that
		 * the userspace scheduler can schedule different tasks
		 * before them.
		 */
		scx_bpf_reenqueue_local();
		/*
		 * Dispatch the user scheduler directly to the local DSQ.
		 */
		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
	}
	...
}

I'm not arguing this is the way it should be written, but AFAIK it's perfectly
legal.

Since we're doing a direct dispatch, the user scheduler task will be
inserted into the dispatch queue in enable_task_scx(), without dropping the rq
lock between example_enqueue() and the insertion, which means reenq_local()
will run afterwards (since it's deferred using irq_work), removing all tasks
from the DSQ, including the userspace scheduler.

A similar problem arises even if we don't do direct dispatch and drop the rq
lock after example_enqueue(): since dispatching and reenq_local() are deferred
using different irq_work entries, and irq_work_run() processes entries from
newest to oldest, dispatching will be handled before reenq_local(), yielding
the same result.

The user may be unaware of this behavior (it's not mentioned anywhere) and
expect the reenqueue to happen before dispatching the new task.

I think at the very least we should make users aware of this in the comment
for scx_bpf_reenqueue_local___v2().

Best,
Kuba
