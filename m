Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA0D4A99A8
	for <sched-ext@lists.linux.dev>; Wed,  2 Sep 2026 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364711; cv=none; b=AfUfPiQ/eAgMWi69O09XeLytwZS6B+yr4TX9BnWBtnHm0Rmn/PVttXW9QCA2QgU8uwtoFBP1rMgHPrGOM8wkdsaGRzorwGMaemnGQwxi9f98fU7KdFS5jAdUdyobK5D+4xHpfgAuy2ee2LqOKnGeRuscW/0AA5dSaaAQTdGQ+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364711; c=relaxed/simple;
	bh=4JbRuy3c5OcW6XLbtFF/tU1Wa96prpEgKPTSn3Iusqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=obLBLZMbLYTD4pjIqJB2PGftISFDZix5WrM+NAGvH3nle0x+2r9ggN/uf0zqRmrnTEZwtsEsFNWm/eUuQlaeTSpmBUTFGt9NU3FELYRQ87m8T8RJqt19KNJ3/EH2cZshpfWEmQ5rN2Voin5AKKhz5C5F3pGgV+tTtRKtHQYiSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcNfKwlm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcNfKwlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF681F00A3F;
	Wed,  2 Sep 2026 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364710;
	bh=AI8qddd9wperhOfLylfztQxkII6UhJBrztRI2rPSToo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TcNfKwlmjDaS6uS8PwOw9a2Vtgg04nUjBtVGck2Bn3uIviHOUjz5jd0PNlEZN8GuK
	 K+fdUVsoVR/J3yPKAMXAE2JjqqmH+vswQvZeyBIwUqVpzOt5l93p3dSYD+xAJ7LjXu
	 JB0wHVu+DBNyWRdTGj6C5aMq/N88pkqzhaLdtCQiloyPTg5DrZAvWGPJ/AfEWL6S3W
	 hfwBuxumbh1tuTWRZ4Zloh8msyBVQZM0qjgocAqUAeETeGnlq1eDAF5KIXPR8JMi3p
	 HoaJFiK/fTMPau0qa2teDKAUTCxZD65foErNBeYaqkCMRZvd32xVG0i9OqiZsdK1n6
	 hD4gzQ5foHE/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Fix NULL sched deref in select_cpu_and
 sub-sched error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanwu Li" <liwanwu@kylinos.cn>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260902153640.144791-1-liwanwu@kylinos.cn>
References: <20260902153640.144791-1-liwanwu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:58:29 +0000
Message-Id: <20260902155829.CDF681F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch deliberately excludes `scx_bpf_dsq_insert_vtime()` from =
the fix, leaving a NULL pointer dereference and lockdep violation intact. T=
he author incorrectly assumes that `@p is always the calling scheduler's ow=
n task in the contexts where it runs` because `SYSCALL` programs are reject=
ed. However, `STRUCT_OPS` programs (such as `ops.enqueue` or `ops.dispatch`=
) are allowed to call this kfunc, and the BPF verifier only enforces the `K=
F_RCU` flag for `@p`. A `STRUCT_OPS` program can obtain an arbitrary task v=
ia `bpf_task_from_pid()` (e.g., an exited task or a CFS task) and legally p=
ass it in. When a sub-scheduler is attached, the error path calls `scx_erro=
r(scx_task_sched(p), ...)`. Calling `scx_task_sched(p)` on an arbitrary tas=
k without its `pi_lock` or `rq_lock` triggers a lockdep warning, and if the=
 task is not managed by sched_ext, it returns `NULL`. `scx_error()` then un=
conditionally dereferences this `NULL` pointer in `scx_vexit()`, oopsing th=
e kernel.
--

commit ea8e652cd7b48dd94e0786bbc598c91806ffad36
Author: Wanwu Li <liwanwu@kylinos.cn>

sched_ext: Fix NULL sched deref in select_cpu_and sub-sched error path

This commit fixes a NULL pointer dereference in the error path of
scx_bpf_select_cpu_and() by using scx_task_sched_rcu(p). It deliberately
excludes scx_bpf_dsq_insert_vtime() from the fix based on the assumption
that it cannot be reached with a NULL task scheduler.

>     scx_bpf_dsq_insert_vtime() has the same error path but it is not reac=
hable
>     with a NULL @p: SYSCALL programs are rejected for its kfunc set and @=
p is
>     always the calling scheduler's own task in the contexts where it runs=
, so
>     it is left unchanged.

[Severity: High]
This is a pre-existing issue, but is the assumption that @p is always the
calling scheduler's own task accurate here?

Although SYSCALL programs are rejected, struct_ops programs (such as
ops.enqueue or ops.dispatch) are allowed to call scx_bpf_dsq_insert_vtime()
in kernel/sched/ext/ext.c.

The BPF verifier only enforces the KF_RCU flag for the p argument, which
means a struct_ops program can obtain an arbitrary task via
bpf_task_from_pid() (e.g., an exited task or a task managed by CFS) and
legally pass it in.

If a sub-scheduler is attached, the error path in scx_bpf_dsq_insert_vtime()
calls scx_task_sched(p). Calling scx_task_sched(p) on an arbitrary task
without holding its pi_lock or rq_lock triggers a lockdep warning, and if t=
he
task is not managed by sched_ext, it returns NULL.

The scx_error() function then unconditionally dereferences this NULL pointer
in scx_vexit(), oopsing the kernel.

Could scx_bpf_dsq_insert_vtime() also be updated to use the same
scx_task_sched_rcu(p) ?: sch fallback that this patch introduces?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902153640.1447=
91-1-liwanwu@kylinos.cn?part=3D1
