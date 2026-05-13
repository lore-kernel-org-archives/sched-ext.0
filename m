Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301F26D4DD
	for <sched-ext@lists.linux.dev>; Wed, 13 May 2026 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648906; cv=none; b=dBRJA2q8t8hR8EeEBRelKuWu9SR+lOwE6dVzDd/WEJLWn6nzfPLnBKFQ29alGmgFPVFolYJnsVfLjAA6FD/dL5pxe7QdLTueTxPgjchA+rfkyFTEPy5MqMrEoDOZ/W2bvQAoBV/y7jtQED6xPgimH864vCbFDwW67YlEtJM5HRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648906; c=relaxed/simple;
	bh=4WvIoq4MNzuXKg4Kv/mzLxwjC6l7DblsX8eSOn9BFxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NDt05FMVCOM8mkjbDeEV2mSW8Pkqgv4WWsxKfnBcR5C5J3eV8a4hDbM25z+uUWRp0b2xx7xMzZl6XTCAbECHHPR1PRPGu0AyK1XluuZrCAWAHtqsOR0sHNXYoExnXkqkCST6nhiv+BFkaPeyldPNc/OsawD8RbLJK0Vq9OcSxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TObtMjag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TObtMjag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC89AC2BCB7;
	Wed, 13 May 2026 05:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778648905;
	bh=4WvIoq4MNzuXKg4Kv/mzLxwjC6l7DblsX8eSOn9BFxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TObtMjagZZRqrDTlMYS8M3d9Nky4YzuS/yv8UBrEtg/EfmpYyKKjLUQJWtEJ5wo4z
	 7wzKc/Vr77wZeo6YzmbsqAlvr3LQhLu1KjTJSHNWAtn9jI/DS3vYLw4QR8upg7HTQp
	 B0fURczbRdQyYnb33SeNVEpt2OYqGDnxeLRf+lZN3+sqvGym8zY4oai3ajuTF464zY
	 fCIOWYcrzeSh+FH5i8ku55sCgWuXOUn5x0zObtK42rcSzOpwW6kvrNwrFE54feT9UU
	 j66lbOFLUNcZALT8/ErTtGO8JN9QoUNkne+buVFk02byBLlJliSQc7QsY/xwckdQGb
	 fi3m2XRNaU83g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Add tracepoint for scheduler exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pat Somaru" <patso@likewhatevs.io>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260512055632.1096713-1-patso@likewhatevs.io>
References: <20260512055632.1096713-1-patso@likewhatevs.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 05:08:25 +0000
Message-Id: <20260513050825.AC89AC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `sched_ext_exit` tracepoint omits the `struct scx_sched *sch=
` context argument, preventing BPF programs from inspecting the kernel stat=
e of the exiting scheduler.
--

commit 7146aa62d89650b7f56b6cb199c8f8b8e35dfc3a
Author: Pat Somaru <patso@likewhatevs.io>

sched_ext: Add tracepoint for scheduler exit

This commit adds a tracepoint to scx_claim_exit() to allow BPF programs
to dynamically inspect scheduler specific state when a sched_ext scheduler
exits.

> diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sche=
d_ext.h
> index d1bf5acd59c56..9ccf884919c1f 100644
> --- a/include/trace/events/sched_ext.h
> +++ b/include/trace/events/sched_ext.h
[ ... ]
> @@ -84,6 +84,25 @@ TRACE_EVENT(sched_ext_bypass_lb,
>  	)
>  );
> =20
> +TRACE_EVENT(sched_ext_exit,
> +
> +	TP_PROTO(__u32 kind),
> +

The commit message mentions adding this tracepoint "so that BPF programs can
dynamically inspect scheduler specific state at the moment of exit".

Will BPF programs be able to inspect the scheduler state if the tracepoint
only receives the __u32 kind argument?

BPF programs attached to tracepoints only have access to the arguments
defined in TP_PROTO. Without passing the struct scx_sched pointer, is there
a way for the BPF program to inspect the internal kernel state of the
scheduler that triggered the exit?

Also, since sched_ext supports a hierarchy of sub-schedulers, exits can be
propagated to descendants, triggering multiple concurrent sched_ext_exit
events. Without the sch context, how can the BPF program distinguish which
specific scheduler is exiting in each event?

> +	TP_ARGS(kind),
> +
> +	TP_STRUCT__entry(
> +		__field(__u32, kind)
> +	),
[ ... ]
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 345aa11b84b28..d38a5c7dc3927 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5974,6 +5974,8 @@ static bool scx_claim_exit(struct scx_sched *sch, e=
num scx_exit_kind kind)
>  	 */
>  	WRITE_ONCE(sch->aborting, true);
> =20
> +	trace_sched_ext_exit(kind);
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512055632.1096=
713-1-patso@likewhatevs.io?part=3D1
