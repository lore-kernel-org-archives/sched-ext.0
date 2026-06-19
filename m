Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CFC379EEC
	for <sched-ext@lists.linux.dev>; Fri, 19 Jun 2026 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874747; cv=none; b=NL2ou/mbwSnlEm8y8LtaT4DOs+0/Y0EtgUobFjNLII1W3MIfoyC0z/kiCWU+SiqLQg0eYS6muRbO4+5kydNCoUwhgyHR/1m/ZGkDVHPyNBtjYu2M7U3fh0xvrRpep4PV2dHsi3cjG+99ALwCPf0vyn2dWLTqs+89fU9t1wrc0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874747; c=relaxed/simple;
	bh=tI8FWr4t1Tam40JsvYQNIz8kDX58QRx2y73o7JnaLJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fKmNUEfHBHEA3atVjChrkF7EWt+h408kIR0kqtnIi0RhSoHBYopbwRVF6DZvs8/Z5urfeuee3QD+bXhpkwPP2Q3FCVzuHWGEAnere9hoJsKd5Y8HtBjtjN+OfPEH/QJ8j11qHK9sZLyqam03P31hWExocLBcraTeH4c2f8vXkOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TL8iExli; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TL8iExli"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45eec2badc4so1065965f8f.2
        for <sched-ext@lists.linux.dev>; Fri, 19 Jun 2026 06:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781874745; x=1782479545; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6wwPOWK2IcIFVS6cg4NCDP0w8aIO3Ri3aHh6++DWsQ4=;
        b=TL8iExlia2xPI+WaX/nLg7XQe1iauIGyHpDJZdeCG8sd3CKmapngmXu+P3Qxn5W+IP
         K1b4aWtaHfymtaDPplTvmsHes1OAWDbFPWvF4yrArLV3XoukEYrVj4zkgOQ7LVKpoQTq
         73ftVUx0NC0vpGJM4d8ouiqxBvPGMOHp9qyeVQMGrx8lZZmKblXdwSTXd4gVl+ionLNt
         t0ulSCvucxJznyp127OHQOESMx7OhoR6PgdoFw7voSk8fqc40kdjZsDQ3IYSRHNkC0BD
         GTsmKDIvZzDVbjob/D/yJfzTlaIl8RUdXrQyaOmuWf84lqgkIE1jw9QdGOpUIOnSOg0H
         iYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874745; x=1782479545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wwPOWK2IcIFVS6cg4NCDP0w8aIO3Ri3aHh6++DWsQ4=;
        b=TDvXIWwroFP1fxDhQgPhE0CpRim8ECIeixMR23u60Lb55QY3SiY/6JKsrNZCFAkxlr
         OjPSjxdhz1Ff6+QUvYWdZTS2PboyJvczYn7HNy+izgeYsEc8lO4pEKkWfHJ90XpO9ZMZ
         BuqN27tqSl1iV7MQMgvgobScCNYvoPm01ZE60RV8lYyOB/nJXKQiOUrDtpOSwPE0nxJX
         lgFcfz6vE+RvuqCt+hF1Ofm7ASimUO0z0tVl6SI1PT8OiTU+8wXm+TwHaWXO1oGmo7cG
         iguWfDkxhJ7JHfvOoD1eVZMpj+wz0NzkGIAXwT2JSlCUMXqMxKbLxbmOVhYr4hvo3nHq
         Gisg==
X-Forwarded-Encrypted: i=1; AFNElJ86VoBdGO4YPO3km+GSauRpaQ/NjhUpMNCEiwIqQIvRXs2cl0iwE8udPvix3SmpNh2Cp+kRlsUnybc=@lists.linux.dev
X-Gm-Message-State: AOJu0YxuisNXwyzNBbQ5fgnCaI86OPjWd0zwkKewpEdJQigdXFKhvCCR
	QjV9bNTPCVbW8XA9ZzHFS8zrZtW1Il1qONjhXWzYVJmJY1GnC7iJighphyNRY/M/3svgIFvraSo
	Sf4+hZt4+UgK/Zg==
X-Received: from wmbjq12.prod.google.com ([2002:a05:600c:55cc:b0:487:2186:fcf7])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6d89:b0:490:e196:e8aa with SMTP id 5b1f17b1804b1-4923f582bb4mr49573435e9.28.1781874744344;
 Fri, 19 Jun 2026 06:12:24 -0700 (PDT)
Date: Fri, 19 Jun 2026 13:12:23 +0000
In-Reply-To: <ajTwP6tQxR_6UGsQ@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260618170047.283701-1-jpiecuch@google.com> <ajTwP6tQxR_6UGsQ@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DJD1VLM0CHEK.3NG5X8N6D4AMT@google.com>
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: check remote rq eligibility
 under task's rq lock
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>, <linux-kernel@vger.kernel.org>, 
	<sched-ext@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

Thank you for the review!

On Fri Jun 19, 2026 at 7:31 AM UTC, Andrea Righi wrote:
> Looks good to me, but we should also update the "Cross-CPU Task Migration" doc
> in kernel/sched/ext_internal.h to be consistent with this change (see below if
> it makes sense to you).
>
> With that:
>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
>
> Thanks,
> -Andrea
>
>  kernel/sched/ext_internal.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index b76633c52c96a..b63d80ae21157 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1471,18 +1471,20 @@ static const char *scx_enable_state_str[] = {
>   * The sched_ext core uses a "lock dancing" protocol coordinated by
>   * p->scx.holding_cpu. When moving a task to a different rq:
>   *
> - *   1. Verify task can be moved (CPU affinity, migration_disabled, etc.)
> - *   2. Set p->scx.holding_cpu to the current CPU
> - *   3. Set task state to %SCX_OPSS_NONE; dequeue waits while DISPATCHING
> + *   1. Set p->scx.holding_cpu to the current CPU
> + *   2. Set task state to %SCX_OPSS_NONE; dequeue waits while DISPATCHING
>   *      is set, so clearing DISPATCHING first prevents the circular wait
>   *      (safe to lock the rq we need)
> - *   4. Unlock the current CPU's rq
> - *   5. Lock src_rq (where the task currently lives)
> - *   6. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
> + *   3. Unlock the current CPU's rq
> + *   4. Lock src_rq (where the task currently lives)
> + *   5. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
>   *      race (dequeue clears holding_cpu to -1 when it takes the task), in
>   *      this case migration is aborted
> - *   7. If src_rq == dst_rq: clear holding_cpu and enqueue directly
> + *   6. If src_rq == dst_rq: clear holding_cpu and enqueue directly
>   *      into dst_rq's local DSQ (no lock swap needed)
> + *   7. Otherwise, verify under src_rq that the task can be moved to dst_rq
> + *      (CPU affinity, migration_disabled, etc.). If not, clear holding_cpu
> + *      and enqueue the task on the fallback DSQ on src_rq.
>   *   8. Otherwise: call move_remote_task_to_local_dsq(), which releases
>   *      src_rq, locks dst_rq, and performs the deactivate/activate
>   *      migration cycle (dst_rq is held on return)
>

Absolutely, will send a v2 shortly that includes the documentation change.

Thanks,
Kuba
