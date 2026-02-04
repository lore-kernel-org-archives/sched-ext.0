Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713433F8C8
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224330; cv=none; b=CsMV4eTGM2X/SmFe/Jc0JDWCskUiKCv/qdlqEkUvY9YTFBO4rACWHSetD0h+PBweAQKKMqWjE9Nfk/YZf+Ll/qPeubZKkJTvuw6VfEttHImV2pVIeXIDgmzmSJ0OEYtjK8ELbuPNg16I1zTvVDy9xRrb3fURqpVDcb0AiYh19cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224330; c=relaxed/simple;
	bh=QYi0U5Ah7uPnpZJMnGw0p2JsosrtJGT0ptSjNBuPVVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oXqwT7neOO+PVxWp8XWoaYZKgSiYfM1CQshcWqB2TTblJqZJY/TYW5epSGl2hMhn8soSng56uCokd0Nn6/qpPB8K958iSQqltDKqkDfRkN1eCgiknIRuR6hlCu+N00YBPUYRgCgm0JVnPu68j9cJWKTtBFMT9KNozRyQyHt7d1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3WNX6pUa; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3WNX6pUa"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b844098869cso359498366b.2
        for <sched-ext@lists.linux.dev>; Wed, 04 Feb 2026 08:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770224328; x=1770829128; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2a6UUIuP5/GR1+j9UCc+Shf4EKl+Lmal1pkr2RJgSo=;
        b=3WNX6pUafZ5YQnf4symoIDTM/G1WdSrHTxx0YqNDUNCFyd2iv7IlEqPwWLD0ccquYY
         O+jk7RfRU5DFnd0Ohnq8vjrylj0R6DChQMyaUVLJsI+VrUtU9uaM2781unCWb9PNwwKm
         R1OJSvwvk121zh2P3En/ybfOS7DXxXmVXR+pcOM2sebbueR/IENvk+4NVwvcx0D7gkdC
         9kLWdPh05pB07XJS3WueQ5Zp4VZELc+f2gw9PELi6Yt2zqU1wqcGnJJgodNjFbK54EUP
         XniVjh81XwKmeGNqOQKAGWodUU5qRsK7+CjkMRU1n5E5TSTqB4FoQOW/yBlhobBgeGQT
         Tbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770224328; x=1770829128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2a6UUIuP5/GR1+j9UCc+Shf4EKl+Lmal1pkr2RJgSo=;
        b=Ew6uRBz7TGI5+B+zFull4OZw0Htb781SkynBL288HGltZoreNAREawyfKiWBEzHUay
         rO+xS7MF3ZzpMr1yBVAk0/QOoVecgouQAMaxhKTGyEP0ESFQz7esPp/miXgsAi9dPBvW
         IidZD5Xyaf5qQmJaJypD0R/oQqBFb6z2V1MGwLGObeCzRYIC2TkQ9MmIK7z6L8gBF4C7
         SUi5gtgOUvuOABgI/QAEAcE30rlo85EqWdv0aHkyK8NYYija5/QIEsk0TebUrLFdn90h
         9XA8xQsAxRE5mln3RXouMAcJYkqOq4qherUo+yyYRhGg8k3CIlzfKw/Xs1NvnJfhHgVi
         jAfA==
X-Forwarded-Encrypted: i=1; AJvYcCXXBSTrnICNOrpMdFIAzmrEv0WEC4ATG/ooh8f1XRv2ZUGDqD0Z7s0HSlXWDq9GFMNgeVF/EqtaXCo=@lists.linux.dev
X-Gm-Message-State: AOJu0YyPa6bS46QuAkFS4LVE1Dh2OHz8XPOHLAAjO4pQMv3vAYwD5SGX
	qSFukz2pGw2ZrFKcGya0sg2Hi9GzwEHOD8WieZawU7YwWJKeqLHpQqUNOJIaE3fpjL2r4etTNzj
	q3E02IlEnqMAWxw==
X-Received: from ejbbo16.prod.google.com ([2002:a17:906:d050:b0:b6d:7849:5800])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:934c:b0:b87:3cac:cd4b with SMTP id a640c23a62f3a-b8e9f17ef8amr250644966b.15.1770224328178;
 Wed, 04 Feb 2026 08:58:48 -0800 (PST)
Date: Wed, 04 Feb 2026 16:58:47 +0000
In-Reply-To: <aYNnmI26oS7YNuMP@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260203230639.1259869-1-arighi@nvidia.com> <DG67IMOVU2GX.2CKP769EXJS12@google.com>
 <aYNnmI26oS7YNuMP@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG6C5HB3PHH3.2JRZX83QMLK2X@google.com>
Subject: Re: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity changes
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Feb 4, 2026 at 3:36 PM UTC, Andrea Righi wrote:
>> >
>> > When finish_dispatch() detects a qseq mismatch, the dispatch is dropped
>> > and the task is returned to the SCX_OPSS_QUEUED state, allowing it to be
>> > re-dispatched using up-to-date affinity information.
>> 
>> How will the scheduler know that the dispatch was dropped? Is the scheduler
>> expected to infer it from the ops.enqueue() that follows set_cpus_allowed_scx()
>> on CPU1?
>
> The idea was that, if the dispatch is dropped, we'll see another
> ops.enqueue() for the task, so at least the task is not "lost" and the
> BPF scheduler gets another chance what to do with it. In this case it'd be
> useful to set SCX_ENQ_REENQ (or a dedicated special flag) to indicate that
> the enqueue resulted from a dropped dispatch.

I think SCX_ENQ_REENQ is enough for now, we can always add a dedicated flag
if a need for it arises.

I still worry about the scenario you described. In particular, I think it can
lead to tasks being forgotten (i.e. not re-enqueued) after a failed dispatch.

  CPU0                                      CPU1
  ----                                      ----
  if (cpumask_test_cpu(cpu, p->cpus_ptr))
                                            task_rq_lock(p)
                                            dequeue_task_scx(p, ...)
                                              (remove p from internal queues)
                                            set_cpus_allowed_scx(p, new_mask)
                                            enqueue_task_scx(p, ...)
                                              (add p to internal queues)
                                            task_rq_unlock(p)
      (remove p from internal queues)
      scx_bpf_dsq_insert(p,
              SCX_DSQ_LOCAL_ON | cpu, 0)

In this scenario, the ops.enqueue() which is supposed to notify the BPF
scheduler about the failed dispatch actually happens _before_ the actual
dispatch, so once the dispatch fails, the task won't be re-enqueued.

There are two problems here:

1. CPU0 makes a scheduling decision based on stale data and it isn't detected.
2. Even if it is detected and the dispatch aborted, the task won't be
   re-enqueued.

The way we deal with the first problem in ghOSt (Google's equivalent of
sched_ext) is we expose the per-task sequence number to the BPF scheduler.
On the dispatch path, when the BPF scheduler has a candidate task,
it retrieves its seqnum, re-checks the task state to ensure that it's still
eligible for dispatch, and passes the seqnum to the kernel's dispatch helper
for verification. If the kernel detects that the seqnum has changed already,
it synchronously fails the dispatch attempt (dispatch always happens
synchronously in ghOSt). In sched_ext, we could do the synchronous check, but
we also need to do the same check later in finish_dispatch(), comparing
the current qseq against the qseq passed by the BPF scheduler.

To fix the second problem, we would need to explicitly call ops.enqueue()
from finish_dispatch() and the other places where we abort dispatch if the
qseq is out of date.

Either that, or just add locking to the BPF scheduler to prevent the race from
happening in the first place.

Thanks,
Kuba

