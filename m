Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A548550C
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261275; cv=none; b=kp8pEjvHVUzXipeS6rJNGHNUC13zfbL51v/YE23eN+vrqWQ8L4dVnKz0ry5HwENOTbgVfYqi9BV4lVPcPq/b0bqRE3g9SndT6hIt6yapvFoYOxTN1s8V4uv6n6ZZPWmAzvDvonKgCZ9t8VUbJjW1A216rVs3kdNgSYWjPhPyATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261275; c=relaxed/simple;
	bh=6urUQxJn/4NcQqGR0VxEoBYglFi9a3tiSKrl53gL3M4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GLNIYfVV9c7dVHrQwj9/ZP/s3jPonGDZ40ARDC8xeQH9Z8/zKre7Oq+SoRbFvTteqbdfJsJxNDhxEsJEjWdiCYUEpOcuhPky9dSbYhWTND3aLuPgYYBXRx32QQY4FK+ZsO7OjXrTjFiBqjnmqTF/PK5PmuvYxxFIdYO5mZ8464o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIc44xmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIc44xmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D22E1F00893;
	Thu, 24 Sep 2026 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790261273;
	bh=22Tjf5R0jXq2p0kNHV6IKp5oPR+qtRqAN71oBuEbpyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BIc44xmdRNI2Nl79epr5MCRlXoxO5t0ss3b00ITz+yxNNQRPinXGeHC2+exTWU+yR
	 o7tJUe5twcIdBg+wU+jmzFrR5ordOUs5PXjxA4Xoqlk37ThDSu1umS5umV3LWZze08
	 8X9w09JvTJ30kn1YfrM8YHhjGn71dizqpJJWoUcH2kQZn1nmDH4HejCcxr5WDIAZyy
	 z90Ho28h7GlJ6S95yumyI+M3f7wJCaUAZPLHNueicaIgucink9IBzwak2wGIJ2my71
	 LbdH/is2U0hjsabw9MzEjETdSEv8WCa6GuZtwWdclqsOkpIMXfPXAvbBvJwjpcpf1V
	 KXYwjltWNh9FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] tools/sched_ext: Increment nr_queued when a task is
 queued to user space
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanwu Li" <liwanwu@kylinos.cn>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260924143659.268595-2-liwanwu@kylinos.cn>
References: <20260924143659.268595-1-liwanwu@kylinos.cn>
 <20260924143659.268595-2-liwanwu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 14:47:53 +0000
Message-Id: <20260924144753.9D22E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: lost wakeup in scx_userland due to nr_queued TOCTOU race
--

commit 58872b4f72d7bfd3655086348da64ace07a2573a
Author: Wanwu Li <liwanwu@kylinos.cn>

tools/sched_ext: Increment nr_queued when a task is queued to user space

userland_update_idle() decides whether a CPU going idle must wake the
user-space scheduler with "if (nr_queued || nr_scheduled)", where
nr_queued is documented to be incremented when a task is queued. But
enqueue_task_in_user_space() never increments it, so tasks sitting in the
enqueued map are invisible to a CPU going idle.

Fixes: cc4448d0856d ("tools/sched_ext: add scx_userland scheduler")
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>

> diff --git a/tools/sched_ext/scx_userland.bpf.c b/tools/sched_ext/scx_use=
rland.bpf.c
> index f29862b89386b..648c6bd230eb2 100644
> --- a/tools/sched_ext/scx_userland.bpf.c
> +++ b/tools/sched_ext/scx_userland.bpf.c
> @@ -197,6 +197,7 @@ static void enqueue_task_in_user_space(struct task_st=
ruct *p, u64 enq_flags)
>  		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
>  	} else {
>  		__sync_fetch_and_add(&nr_user_enqueues, 1);
> +		__sync_fetch_and_add(&nr_queued, 1);

[Severity: High]
Will this introduce a race condition with the user-space scheduler that=20
leads to a lost wakeup?

When the kernel atomically increments nr_queued here, the user-space
scheduler unconditionally clobbers it without any synchronization:

tools/sched_ext/scx_userland.c:drain_enqueued_map() {
    ...
    if (bpf_map_lookup_and_delete_elem(enqueued_fd, NULL, &task)) {
        skel->bss->nr_queued =3D 0;
        ...
}

If drain_enqueued_map() finds the map empty, but just before it runs
skel->bss->nr_queued =3D 0, a concurrent kernel BPF program enqueues a new
task and increments nr_queued to 1, the user space code will overwrite
it back to 0.

Since both nr_queued and usersched_needed would end up cleared, could this
cause idle CPUs to fail to wake the scheduler, leaving the newly enqueued
task stranded?

>  		set_usersched_needed();
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924143659.2685=
95-1-liwanwu@kylinos.cn?part=3D1
