Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DC22EF653
	for <sched-ext@lists.linux.dev>; Tue,  7 Apr 2026 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555667; cv=none; b=aqfFnJmh2bfD1xaDpw1frRpTe/n1Q7kNi4zW3VcdHcu+gIzJDyADCEmBh9LIj3X4f24PwPsblUgM9kOHBth197/ri8Qf9WHFuiMo8nw0ORH1MqLOYPXYZAbpS6dDKY1C8Lyx9l73BMWTb7HfQeSXkniFZeD2jALimU9CTevlXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555667; c=relaxed/simple;
	bh=JiDmOBb52ayWBZHsIMB0ZOY9VC0NkDLYiOe/EP4wUhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KR7sFipQC/wdQMKsxTFATdDeWz9tNrsA8Ctih7h6eWTJ9deCkDNL1goEFU6A0dHGIw3VRwJpte9JYdeSOYFenqhdYJKafIhhLryE/wHR2QI6jhlI7M3Fs9ELr0pTvtERrP4IiusYvE44ajVD3xUosPYwd4/KGCSkIN+98YbZOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rAiY2a2v; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rAiY2a2v"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488c16958e9so1607755e9.1
        for <sched-ext@lists.linux.dev>; Tue, 07 Apr 2026 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775555664; x=1776160464; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4vsXtEL49zVqufg8lyj0hHK/lVL3UAvs+p/Ca2lHfA=;
        b=rAiY2a2vb960LeR/gn6fpLN/2C7+L1fac4UVMAapuHq0hlin6MibZ9oqcyVcCaj836
         V/Fnzm3O8ZZ+yJBJUQ5AxJw3FitA+BhGi2aQtmu0z9FC88jOQvz+87qFJyoIcnLrch01
         XsCbrwucy5QsM1CkmXVDtCSDIMjetIJY41UCL+7p9+OpKzEnK8Xh1naxKmPQI/sHlFpt
         3sbc5i8kcCH02kIWXp1xb/HInqeXB/MHYBNF+v6qVhj4NJQvogfvHAI5iw+i6iKs1k5u
         3K8q3QYNWQKl7absUc2gjwrCg2RRV4Cl8InIKQI7dwEo90W0KCFHjHtDVI0K45KSUfLA
         9dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775555664; x=1776160464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4vsXtEL49zVqufg8lyj0hHK/lVL3UAvs+p/Ca2lHfA=;
        b=O22GtPanxrYdI2IUiZAt7m4Sp3RLmnckkNnqCUr5THp7l++rtxSdbsWQF3UA3v1VAp
         Lu6XShEdcHuZS6lINgZm+9oP9DXwmW/vbMRjcdoyVykhUM+pCDEprH7S2vZNPAzixRtd
         dN/r8cRtftNUiVgjo3qg9gTbccZiqAetkG3Gg3MUc4c5R2M8Yfhw8d39HasIoNAVt/iT
         XYKsxqlKCChc0hFyGWuwp1JsEDgU2k9wKDHAkF5r8acHaMqwS07qJBPVVlORQZHF0CHc
         KsNJVIiAqhy+zBin+JfeJuREHGBdh/rEb3AJpVrkSmeazmVy95LuN4VJKeH+4oJKRCaw
         wRSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVb/De3kCqtpfOEb5KFfR+5WEu2L0wPi0uXjQbtWLVAVIrE+xNpYDCCAjiG5jAVQH5kdce2OheJYQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxGjNaRNoH5WMPlVqvH2cn4wDTku08BXLJNAj2TDt6gfJ5zs9wS
	IZS5McAZNdAHPW63070SDOVg1aF8J0//kXqPA6jT3QoOc3wgtq4N59ng4Irutf7dx04DyxHtHgf
	yiI+r50WB/asmIA==
X-Received: from wmc13.prod.google.com ([2002:a05:600c:600d:b0:488:7c5a:b238])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3492:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-488b14fb9e4mr101613605e9.0.1775555663834;
 Tue, 07 Apr 2026 02:54:23 -0700 (PDT)
Date: Tue, 07 Apr 2026 09:54:22 +0000
In-Reply-To: <20260406114755.840497-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260406114755.840497-1-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DHMTYAUXLBZ4.RTEFCELFZ0J6@google.com>
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add
 ops.dequeue() to task lifecycle
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Kuba Piecuch <jpiecuch@google.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Mon Apr 6, 2026 at 11:47 AM UTC, Andrea Righi wrote:
> Document ops.dequeue() in the sched_ext task lifecycle now that its
> semantics are well-defined.
>
> Also update the pseudo-code to use task_is_runnable() consistently and
> clarify the case where ops.dispatch() does not refill the time slice.
>
> Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  Documentation/scheduler/sched-ext.rst | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index 404b4e4c33f7e..9f03650abfeba 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -422,23 +422,29 @@ by a sched_ext scheduler:
>  
>          ops.runnable();         /* Task becomes ready to run */
>  
> -        while (task is runnable) {
> +        while (task_is_runnable(task)) {
>              if (task is not in a DSQ && task->scx.slice == 0) {
>                  ops.enqueue();  /* Task can be added to a DSQ */
>  
> -                /* Any usable CPU becomes available */
> +                /* Task property change (i.e., affinity, nice, etc.)? */
> +                if (sched_change(task)) {
> +                    ops.dequeue(); /* Exiting BPF scheduler custody */

Doesn't the task also go through quiescent -> runnable here? The full path
being dequeue -> quiescent -> (actual property change) -> runnable -> enqueue.

I guess we should be accurate here since quiescent and runnable are present
elsewhere in the pseudocode.

> +                    continue;
> +                }
> +            }
>  
> -                ops.dispatch(); /* Task is moved to a local DSQ */
> +            /* Any usable CPU becomes available */
> +
> +            ops.dispatch();     /* Task is moved to a local DSQ */

s/local/terminal/?

> +            ops.dequeue();      /* Exiting BPF scheduler custody */
>  
> -                ops.dequeue(); /* Exiting BPF scheduler */
> -            }
>              ops.running();      /* Task starts running on its assigned CPU */
>  
> -            while task_is_runnable(p) {
> -                while (task->scx.slice > 0 && task_is_runnable(p))
> -                    ops.tick();     /* Called every 1/HZ seconds */
> +            while (task_is_runnable(task) && task->scx.slice > 0) {
> +                ops.tick();     /* Called every 1/HZ seconds */
>  
> -                ops.dispatch();     /* task->scx.slice can be refilled */
> +                if (task->scx.slice == 0)
> +                    ops.dispatch(); /* task->scx.slice can be refilled */
>              }
>  
>              ops.stopping();     /* Task stops running (time slice expires or wait) */

Thanks,
Kuba
