Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B675623A562
	for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247177; cv=none; b=HlaqlIVuAGGu0PGcMdfoZMZASmCg8VyEQdNlVxUzbPpx2fpSKWPKrBLWq1aehO0fNZuvJRQRUjgL40Gtxpv/O2jCULDxqRJ+xbYzaBggxvTJAnkhg2TL3gnKV3E4qhbG9nwWm1arsqHOyz2XiuV4u0gKkvJlKgaEOPzkQS9Tg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247177; c=relaxed/simple;
	bh=k0SLljVjvUU68mdpTuNnooQKGvenM37LEipsWnhrSwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cvp513No/rIj5JsM3kGCuGuFYYstHL/oAtE3io8ripkYyQDxeyhAmBZGQUM/g2KPOg0Wy3h+vDgn1i8YGX3HDJ/dnmIxQzG41fl2ujPCqd1FugX+zzD/krrSa6+Qo1lUwMhUWF0oqFjCKDxej5yOYTK0QOT+oNJyBwDSeQj4vWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKcHneDl; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKcHneDl"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d70e3e4e7so3454600f8f.1
        for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 02:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776247174; x=1776851974; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LrcehC+K8rFGaq9Km1a7hc5FS9gzkp3p31y8dWxcsQ4=;
        b=kKcHneDlmOo7jvxBiDWQp+adSGQNR4O3FJyq/AKtR3J+ryinHPTw5sgGVR3AC0Wm5c
         g66MNH1xCnynTA3172ih/nkMx9zjLgkNPALbISDbvKr02ENoM3t56YiZ3Z/o7e4wjHt0
         RjTUAaEfxgb/yT02ra9i3tz0opSz0+mOHjno3gryFvO214xWJYvETE1dYZYHTwzT+pXF
         1Do3V2z5wj3XqIHk69q1T41YWoghJ0ZjJStrYrYOhEeYDeeW7AqPKbusxWnuSs3JPMEU
         bTae+OXvmDzR3YTHVOowjU4CvS4riI+JcBhYArU+zBD+3XOxJloCuu4T264OGEWxY3xT
         bqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776247174; x=1776851974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrcehC+K8rFGaq9Km1a7hc5FS9gzkp3p31y8dWxcsQ4=;
        b=jl93p/lYPjI+FCKqH59KYLjPzEE5rq+rSzt08dQ/j04YlpxF5h4b62l2evNerMFsHG
         8LbOQmiHjjPI/4idtQl/6S5VG1Fq3PSmmh3zVgbDuYAJN6hk4oOAL3U0a0ix9WX6Xj8b
         WZ5xMiCfN4TIhPZMpXwdA3JOqvorJcx5k6vlWV4ICRZUdwQVkm6Qfo0WhcAgKsUHW+09
         Up4qubL2ismmN8zJxEB2Z/zHBHBykbmw3Xf0G3pl3lpFBj17CLRoqL1EAlJ4Gquv/UvU
         MMe+OGEqW43/sP9kXXebMAUyeUiAkF/wa7zME/1QApapCPqIN2lJiEFwlcmjHy88xk8R
         DlEg==
X-Forwarded-Encrypted: i=1; AFNElJ/+rzSMAXAYOEuLuxNYluuk7z7K0DNEWYvK9hDJyetdDT6/DOQfly4sKp8AyueLkFeeVHOXg6DEOpw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyLMvBPoRP9btfM+sse3lIn0+n1jKU1AGNEaeIaxD5EW31LJHcf
	5LcrTRXXCrxMg/PJ27Rs7yFNR9XuTxbNz1C/dBUfrStNrOp7zSRJnpOJIbt1TB7OvfHiZGoLtvn
	zpoqEjzGtQg9cqw==
X-Received: from wmkz3.prod.google.com ([2002:a7b:c7c3:0:b0:488:7e69:14c1])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a416:b0:488:7f69:4abf with SMTP id 5b1f17b1804b1-488d67f946bmr217421435e9.12.1776247174072;
 Wed, 15 Apr 2026 02:59:34 -0700 (PDT)
Date: Wed, 15 Apr 2026 09:59:33 +0000
In-Reply-To: <3cpy5o3wdfqrmk7kuvwlvibnkesvzprjru5urhyvf66qytnjeu@jibpzykbt65k>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260413110453.357198-1-yphbchou0911@gmail.com>
 <DHS4U9BLRCPG.1S9E4BT1UIHQT@google.com> <s3khi4ec55rog6tgbgxip5skqjdhimcemhwzf3h7pbbvxslnu7@5r4v7jbv4w7z>
 <ad53CFXVxTha3EQu@slm.duckdns.org> <3cpy5o3wdfqrmk7kuvwlvibnkesvzprjru5urhyvf66qytnjeu@jibpzykbt65k>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DHTN2MJP9V4Z.221YVTILI5XR6@google.com>
Subject: Re: [PATCH] tools/sched_ext: Handle pinned tasks in scx_central
From: Kuba Piecuch <jpiecuch@google.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, <sched-ext@lists.linux.dev>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed Apr 15, 2026 at 6:17 AM UTC, Cheng-Yang Chou wrote:
> From df62cc372cb9fab7aa9b666a6a127d8248923dd8 Mon Sep 17 00:00:00 2001
> From: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Date: Mon, 13 Apr 2026 15:19:59 +0800
> Subject: [PATCH v3 sched_ext/for-7.1] tools/sched_ext: Handle migration-disabled tasks in
>  scx_central
>
> When a task calls migrate_disable(), p->cpus_ptr is not updated until
> migrate_disable_switch() runs during context switch, so dispatch_to_cpu()
> may dequeue such a task and dispatch it to a CPU it cannot run on.
>
> Extend the mismatch check in dispatch_to_cpu() to also test
> is_migration_disabled() alongside the cpumask check, so tasks in this
> window are bounced to the fallback DSQ.
>
> Suggested-by: Andrea Righi <arighi@nvidia.com>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Kuba Piecuch <jpiecuch@google.com>
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
> v3:
>  - Drop the select_cpu() shortcut, revert enqueue() to the kthread-only
>    forward-progress path, and expand the dispatch_to_cpu() mismatch
>    check to cover is_migration_disabled() (Tejun Heo)
>  - Drop kick_cpu() on mismatch (Andrea Righi)
>  - Reword commit subject and message with the fix
>
> v2:
>  - Add is_migration_disabled() check in enqueue() as p->nr_cpus_allowed
>    is not updated until migrate_disable_switch() runs during context
>    switch, which happens after ops.enqueue(). (Kuba Piecuch)
>
>  tools/sched_ext/scx_central.bpf.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
> index 4efcce099bd5..64dd60b3e922 100644
> --- a/tools/sched_ext/scx_central.bpf.c
> +++ b/tools/sched_ext/scx_central.bpf.c
> @@ -149,10 +149,14 @@ static bool dispatch_to_cpu(s32 cpu)
>  		}
>  
>  		/*
> -		 * If we can't run the task at the top, do the dumb thing and
> -		 * bounce it to the fallback dsq.
> +		 * If we can't run the task at the top for whatever reason,
> +		 * bounce it to the fallback dsq. Also check
> +		 * is_migration_disabled() explicitly as p->cpus_ptr may not
> +		 * reflect the migration-disabled state yet if
> +		 * migrate_disable_switch() hasn't run.
>  		 */
> -		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr) ||
> +		    (is_migration_disabled(p) && scx_bpf_task_cpu(p) != cpu)) {
>  			__sync_fetch_and_add(&nr_mismatches, 1);
>  			scx_bpf_dsq_insert(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, 0);
>  			bpf_task_release(p);

Looks good to me!

Minor email-related comment: I would prefer if patch revisions (v2, v3, ...)
were sent in separate emails with their own subject line, otherwise it may look
like I'm reviewing the v1, if you look solely at the subject line.

To be clear, the following tag applies to v3.

Reviewed-by: Kuba Piecuch <jpiecuch@google.com>

