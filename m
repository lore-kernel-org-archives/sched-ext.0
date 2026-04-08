Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AF2E541E
	for <sched-ext@lists.linux.dev>; Wed,  8 Apr 2026 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652013; cv=none; b=hoYeJrpmbB6EO7PhTZ0QSsKteWCUCdpoZpQCJlT922ZU1vk+EEHl2oLGKLb4WY8rgwIH+qyscgODhUKU5/fZ4mLK15cujjvaQuIjKY8soXFCnFlw+fXzH7/Q5FEKqgV76SlRQjnxWJUVpvH92k9tJw7H19WmMLLxUv7Iux5Nq4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652013; c=relaxed/simple;
	bh=oBisJrvmTUoJbacY+XdL9I+cTHQ/btwhdYGTWR39rcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+RgmKk7x5/mhd5RDtgtDm/VEQAXAB0EEAYVBah4r8xB5cXyWYHFQHJ96DRAAwVHBTLe6zMttotsOB3tkE0bswX9y5IYywvzo6S/UD1vbDVFpRjlBSnFCfaE6cvpOVXMa/u7CtMS3W9vc2A+N6EeM1dPs4F1vOWImpZNkJbqWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sd/kuvNi; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sd/kuvNi"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b9c029c06bcso549843066b.0
        for <sched-ext@lists.linux.dev>; Wed, 08 Apr 2026 05:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775652010; x=1776256810; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=seKR2RIz3AtZiCRTNc2MR0WnPUrsv2QsEKLqRoGCnCA=;
        b=sd/kuvNi0n/xGfFBr5OjoSSJ1D9f/dsSa0jmDmR6W7PopIS4Z743wdxixDEuRnIH3W
         caSqN4j/XqT3PAQC91uATHb8/33kjssUvr04w+jm82ucbQbi9shd9iJo178cNUrqDGJ+
         ZmA0tJ8odPdi201dPrayzdW2gLf90br54fJhMJTmX/S5Kh7z5Fa/lAUVrRazeG+ggWxN
         r9N8hdtFE6Kb3XTNGttrbej6+7ufhaUR3FDLB6RXXhUqzH8I3h0gMD3qXCfbWcYWbbPu
         BrTBfTw8fWV/+ROAxBb+DD5JUBUv7QF2LUrfbrokKEW5wHJY3Bjx5YeWbetqLJfxtBhj
         yugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652010; x=1776256810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seKR2RIz3AtZiCRTNc2MR0WnPUrsv2QsEKLqRoGCnCA=;
        b=O2ApZDu89HaKIyAYq1Ho/6YIgvGnegYamNdTtCTzEi/WpZiuAtCLsabg3PQ0Do9Iud
         2NEXStADw9VWLLtEGgtiAreLf9NrmMbl4xZ7jVL8B8F25NddBGgYQFCWd0FVwy1q8pmQ
         0jWMMIQB7/mm8RrJQrNWqtHW5gZbFqvE6Wlynk3f87iYzFgDwTq/Ej+DcSb1cuvd0woq
         3AtS/VlmCuvvuGvswi50vxYfnvCc2UfdVvcTX1x0ynmBa1EOBXnaGQhKhTeI5d2jZhZm
         EOU746uEV1N5jlm4hGQBcFPd85oK26U/j7iEZqiN7UuItdOEdMXAGzGlkFv0T1ygzDjL
         oJxA==
X-Forwarded-Encrypted: i=1; AJvYcCWmYCT8EbdDUayr46z4O7iCdtC8WrU1I1/ra2WBReOTflEsXDxDgXQhSXU08mpg3n9tZiYooX62vV8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzXQ2A0ksFFaG92UVWafVAxPVOdoJLLItsHbFZqBRFTrkhtWytA
	hjYu/Q+tVCq8uidorplvEUXgWDt3pk4x2/zmpeRWT7x/7kS/LTVOJo5x9lA1tOaODm+O6Pei4BZ
	nJGouUP8YjuVkXQ==
X-Received: from edvr1.prod.google.com ([2002:a05:6402:181:b0:66b:81cf:c90b])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:350f:b0:66e:b997:2b61 with SMTP id 4fb4d7f45d1cf-66eb9975d30mr6479730a12.18.1775652010071;
 Wed, 08 Apr 2026 05:40:10 -0700 (PDT)
Date: Wed, 08 Apr 2026 12:40:09 +0000
In-Reply-To: <adY76wiI82pUBYkr@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <adUxZ5Qp_vH6cBZj@gpd4> <20260408091821.91063-1-jpiecuch@google.com>
 <adY76wiI82pUBYkr@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DHNS3RWRB1C5.29B8SXO481CHK@google.com>
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add missing
 calls to quiescent(), runnable()
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Wed Apr 8, 2026 at 11:28 AM UTC, Andrea Righi wrote:
...
>
> Looks good, but I noticed another issue, should we also change the condition up
> above as following?
>
>  Documentation/scheduler/sched-ext.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index 29d36e248f58b..99df4cc982375 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -423,7 +423,7 @@ by a sched_ext scheduler:
>          ops.runnable();         /* Task becomes ready to run */
>  
>          while (task_is_runnable(task)) {
> -            if (task is not in a DSQ && task->scx.slice == 0) {
> +            if (task is not in a DSQ || task->scx.slice == 0) {
>                  ops.enqueue();  /* Task can be added to a DSQ */
>  
>                  /* Task property change (i.e., affinity, nice, etc.)? */
>
> Because we trigger ops.enqueue() when the task expired its time slice or it
> becomes runnable and has not been added to a DSQ.
>
> This also represents correctly the sched_change() scenario: a task being
> re-enqueued after sched_change() still has its time slice > 0, but we need to
> call ops.enqueue() for it.

I agree that the condition should be changed, but I'm not sure that this is
what it should look like.

Is the "task is not in a DSQ" part of the condition there to handle direct
dispatch? Apart from direct dispatch from ops.select_cpu(), I wasn't able to
come up with a situation where we would reach this condition with the task
present on some DSQ.

A more general comment about the pseudocode: I think it can be useful to
introduce someone new to the general flow of the callbacks in sched_ext,
but the documentation should be clear that this is a simplified view that
makes assumptions about the behavior of the BPF scheduler itself (flags like
SCX_OPS_ENQ_LAST, whether the scheduler uses direct dispatch), as well as
the overall system (Can sched_ext be preempted by a higher-priority sched
class? Can scheduling properties of a task be changed while it's running?)
Without stating these assumptions clearly, we risk leaving the reader falsely
believing they have a complete understanding.

Thanks,
Kuba
