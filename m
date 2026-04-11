Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF092F25F0
	for <sched-ext@lists.linux.dev>; Sat, 11 Apr 2026 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775917664; cv=none; b=Ao0E97GcM+cOZlH7xB8gZLX2Pgcn1swq6lvVdeiXOnMOAeuxHbgBSTYz4sGDQKnV5SrPGCzfWk8PVQyhhPHHVwEYcHGbIfrzbGdbOh0QQTd23huD1FmkrcsFs1k+g/b29c+v4+ysh17y8ikYTT0lnrgJ/4ODMfnb96Lfsxqp1+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775917664; c=relaxed/simple;
	bh=V5DXXRb/2Ik2Yfwfvi5TOAsYn3rduQUt3OicGQ3m9q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIwXhrgJM9oxJBnlDLnXoPmgkPJIdnVyL+wzpq+y+h7HHdeQqkqFDyHVUoqHfhgHpkeg5qQ0ZYiGE6rr1Uo/X50Ho5mGul7Cl61Eahioqfy5UNRWxRcun3DqfVw8Bi9eYZiKFGwqHp78kqnSyPSpS4IPfIAIMcecBPzy4OwPESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7qZUnU+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7qZUnU+"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so3067705a91.3
        for <sched-ext@lists.linux.dev>; Sat, 11 Apr 2026 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775917662; x=1776522462; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itDS40O6MZZofgf9Ri84SdBbTtJCcysOrubRuZ04fvs=;
        b=Q7qZUnU+uMFVQprFCR1+bwXgN6ZRsCF3uOIRppQ57eX8+9Jl2Y03cRwhu2KiOOp6Bs
         bupmr1dxWaErDAb9+120Cki1Lrg0xl2BQ+yIoXkWPd9OiSthsUEqcif69BT5ErHUNECI
         8AfUtzlARHMyo0ddlG2+kVhPQDPtT9QQ7Yvi5TuOrMKE9/xBUGrOjhDdKivr51cJQlFd
         tI7an4ClY6v3yFA7khmb6OyW8vkzKCCyvD/ceQff7B2vv7Gf3sM7OHlwPS6jXU1LpDpm
         zWK9PvVbJT4pF+92tXGqR4aa9DF1+ib2Unqs9kmC5pKPS+4geyjUXiqHI8bZamzIJGM+
         zn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775917662; x=1776522462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itDS40O6MZZofgf9Ri84SdBbTtJCcysOrubRuZ04fvs=;
        b=I6q3TnNZpFHlczHJZGC/AjVbr46ZSuR3FhwDIHUlBw4EhwkCaJs5W304pBFYjOwrNz
         jzo1RwnFLXcyJsneNi4gzwjiPFHxlQELewagD81YGdAsdW5p8mysTHnqIvh2BQ+jGjjf
         WyVV6mgtqa4xItTRe4PQchtXtrc67PlOBwATs0Jx82Y3Z77w3pghcLDzh9x19FZUHdJ2
         Y9LE8IbO+H+nzzAYzYQSOX225/0QdMhZRXEj7gGaokH9xPS9hKNN4ihVrW/DHGvaLVYZ
         2eRROUpqIZvUzZz4Ll4Kcpsbq4bEkrcwig14tIz5nxQFUJJ1nkygZp077HocXtuF7yQv
         Upcg==
X-Forwarded-Encrypted: i=1; AJvYcCVTaW88+2Sv3Yd/s1ycWxmXjlcGQhy5hjvV0GuUcDAF+9WExalzuvI8uFxHpGLRM+CGBv9yUvufckQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzjYNH8NqvrNI+beBBOUk3JMtpCXT7duSyVazhTcvDVQJqFCist
	yMjX+zXLutzrxZbq5uM4WQlIDFM8NoDDv9xN7zmqJ+UZj29Bpdhjp6ty
X-Gm-Gg: AeBDieuSkq+K22esY51zsf6n7lgK9v+HLnPq7JTpWl08lN6c5UrlPp8G+gulQe/PEcE
	n6fMeF8jEbCxG56pBZII5i/rP7xo+7jJIYfj3Y5FnDLhC3lp/MK07EurSsbZ47MSbmTwPOLMC3r
	qZd2zMFiV8OzQw68chC4eztrzihgIbOBpnoObhJoz7n/4cYkfOZLYHQwq3wJIfjXQQJMbD8gD7j
	pc2A4tn4n5juMaULj6dxe491Gfa99/RpnnCYKsTMUOLdQrXXT24a5kQSJ5o5RR5GYit+t0gy8hy
	fWhmKWMXEz59Z0bY4WopCzKfn+wcoYsQeteeuCtX3nmq79ogLbuy/niYB7gCqT3tjPogV+6aV1M
	5J7t2vRUfjnURdRCv2k8BV5x3Tos8oliwGT776m08QCSj/KcXzS5dIgalv0XxXhuhSEK3dhnO2h
	f9EDJJ/UvyFo1kBg6ccXgTzxCe6cb1
X-Received: by 2002:a17:90b:38c8:b0:35d:a542:2dc4 with SMTP id 98e67ed59e1d1-35e42842cc9mr7841008a91.21.1775917662343;
        Sat, 11 Apr 2026 07:27:42 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:4440:b527:db2e:c93f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e35156445sm9772230a91.14.2026.04.11.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:27:42 -0700 (PDT)
Date: Sat, 11 Apr 2026 22:27:37 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Kick idle CPU for
 pinned tasks in scx_qmap
Message-ID: <2ez5asyb7yuwldbqenmrpzvdyl2oq4oxism6lj62m6zx7fgy3d@4qk45ujilk6v>
References: <de52a1c5537e2a130d19eb244b7606c1@kernel.org>
 <cpn5bqvb6qmew2opqffmtmgcuin3lvtiqzht6vmnef5px3pvr2@bhgdpcfcmg3c>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cpn5bqvb6qmew2opqffmtmgcuin3lvtiqzht6vmnef5px3pvr2@bhgdpcfcmg3c>

Hi Tejun,

On Sat, Apr 11, 2026 at 08:57:42PM +0800, Cheng-Yang Chou wrote:
> On Sat, Apr 11, 2026 at 01:33:56AM -1000, Tejun Heo wrote:
> > scx_qmap uses global BPF queue maps for task dispatch. A task pinned to a
> > single CPU can only be dispatched by its home CPU's ops.dispatch(), but an
> > idle CPU won't call ops.dispatch() on its own. This leaves per-CPU kthreads
> > like ksoftirqd stranded, causing NOHZ tick-stop warnings from pending
> > softirqs.
> > 
> > Kick the target CPU with SCX_KICK_IDLE when enqueueing a pinned task.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  tools/sched_ext/scx_qmap.bpf.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> > index f3587fb709c9..09d1624fb869 100644
> > --- a/tools/sched_ext/scx_qmap.bpf.c
> > +++ b/tools/sched_ext/scx_qmap.bpf.c
> > @@ -314,6 +314,14 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
> >  		__sync_fetch_and_add(&nr_highpri_queued, 1);
> >  	}
> >  	__sync_fetch_and_add(&nr_enqueued, 1);
> > +
> > +	/*
> > +	 * Kick idle target CPU for pinned tasks. Without this, the CPU can
> > +	 * idle while ksoftirqd is pending in the BPF queue, triggering NOHZ
> > +	 * tick-stop warnings.
> > +	 */
> > +	if (p->nr_cpus_allowed == 1)
> > +		scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
> >  }
> > 
> >  /*
> > --
> > 2.53.0
> 
> Looks good to me! The same issue exists in scx_userland where pinned
> tasks can be dispatched to SCX_DSQ_GLOBAL without kicking the idle
> target CPU. I'll follow a patch to add the same fix there!
> 
> Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Actually, would it make more sense to fold this directly into the same
patch?

diff --git a/tools/sched_ext/scx_userland.bpf.c b/tools/sched_ext/scx_userland.bpf.c
index f29862b89386..56c53d457f45 100644
--- a/tools/sched_ext/scx_userland.bpf.c
+++ b/tools/sched_ext/scx_userland.bpf.c
@@ -195,6 +195,14 @@ static void enqueue_task_in_user_space(struct task_struct *p, u64 enq_flags)
                 */
                __sync_fetch_and_add(&nr_failed_enqueues, 1);
                scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+
+               /*
+               * Kick idle target CPU for pinned tasks. Without this, the CPU can
+               * idle while ksoftirqd is pending in the BPF queue, triggering NOHZ
+               * tick-stop warnings.
+               */
+               if (p->nr_cpus_allowed == 1)
+                       scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
        } else {
                __sync_fetch_and_add(&nr_user_enqueues, 1);
                set_usersched_needed();


-- 
Thanks,
Cheng-Yang
