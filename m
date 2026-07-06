Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6A937BE7D
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303698; cv=none; b=dPbYHqpbC9MSIDK+BdZ0nPV9njqQ3sU29SPU41que4t216gziIGf0QPiGf2tmx+iwIU2W4bsTxFc8Yuwr5OMtpkIky8n2s5n/nwSTqChipT8zMpXrhvInvhaa5Dl0TUm9AK+tuMGvqJ6OAL5hiuH4FYkM4h4zDYQAB6D67rK5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303698; c=relaxed/simple;
	bh=gdQADdA8ym8YIhCtg5ZOjSoMlHoZy1kXs2dtRJHGRDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZfQ7xAkvK/fMZdjcToVYHB4Qk7hwZC9jMwAkbhxPuOndqfiJhFMsTQIV9gg9nNCg96I3xU+GslgSeZXImANycW1x755k2XIsQDVWjGim3M/VMV17KiPtRpZg39g+ZOojvv4/DRbEGwdDUePUGIgqzXSbWN11VKQ3Z2TLVpOtMXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7pWIK4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7pWIK4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1771F000E9;
	Mon,  6 Jul 2026 02:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303697;
	bh=mBHTq0N9c/jvwppIKwo+mzC7JUEqh57AihBJ8EIf4bk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c7pWIK4QVxOpwUnZygWHCt9qJdF3qmj6jwWQbL2iNpfpc5ezMfw2eCzhbpRLhzUYR
	 tmyw6a/XXx61rO6HGG3fiSljh/rOR/UapjlIchf2pv8g3t5yO/uU1YbG1KB/7Rsdvg
	 r86n+2Y6it5ApC38aPs444UFOttLN3cdszkWIy+BstLTp+4AXRbFuijpjAj5RwUBFZ
	 yANHmOX+cOvKDn59mTDuHikHPQM5NyUmvQyJoJnVDexlO6v+o6NJRS83kSKGmmRcq8
	 paZ/ornx9/wboGac7erj2vSPFD/CXteBvGUiH/uMGLtA+1vydZivwSGtkEx9oAcxkb
	 dAlfqHWPbqwqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 10/36] sched_ext: Add
 ops.init_cids() to finalize the cid layout before init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-11-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-11-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:08:16 +0000
Message-Id: <20260706020817.2F1771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `scx_bpf_cid_override()` failures are masked, leading to full enab=
lement of a broken scheduler with corrupted CID layouts.
--

commit f3e3b0bef46dafbab2f0d836c3f5b9732c01f8e1
Author: Tejun Heo <tj@kernel.org>

    sched_ext: Add ops.init_cids() to finalize the cid layout before init
   =20
    A cid-form scheduler that calls scx_bpf_cid_override() to install a cus=
tom
    cid layout can only do so from ops.init(). Enable-path setup that depen=
ds on
    the cid layout thus has to run after ops.init(), and ops.init() itself =
can't
    use anything derived from the final layout, which turned out to be too
    restrictive.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 150e74129266b..ee390d95cd2e3 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -6684,15 +6684,19 @@ static void scx_root_enable_workfn(struct kthread=
_work *work)
> =20
>  	scx_idle_enable(ops);
> =20
> -	if (sch->ops.init) {
> -		ret =3D SCX_CALL_OP_RET(sch, init, NULL);
> +	/*
> +	 * A cid-form scheduler finalizes its cid layout in ops.init_cids(),
> +	 * which may call scx_bpf_cid_override(). Run it before ops.init() so
> +	 * the final layout is in effect.
> +	 */
> +	if (sch->is_cid_type && sch->ops_cid.init_cids) {
> +		ret =3D SCX_CALL_OP_RET(sch, init_cids, NULL);
>  		if (ret) {
> -			ret =3D scx_ops_sanitize_err(sch, "init", ret);
> +			ret =3D scx_ops_sanitize_err(sch, "init_cids", ret);
>  			cpus_read_unlock();
> -			scx_error(sch, "ops.init() failed (%d)", ret);
> +			scx_error(sch, "ops.init_cids() failed (%d)", ret);
>  			goto err_disable;
>  		}
> -		sch->exit_info->flags |=3D SCX_EFLAG_INITIALIZED;
>  	}

[Severity: High]
This is a pre-existing issue, but does this adequately handle failures duri=
ng
kfunc calls like scx_bpf_cid_override()?

If scx_bpf_cid_override() is called with invalid input (e.g., duplicate CID=
s),
it calls scx_error() and returns early without fully populating the CID tab=
les:

kernel/sched/ext/cid.c:scx_bpf_cid_override() {
    ...
    if (cpumask_test_and_set_cpu(c, seen)) {
        scx_error(sch, "cid %d assigned to multiple cpus", c);
        return;
    }
    scx_cpu_to_cid_tbl[cpu] =3D c;
    scx_cid_to_cpu_tbl[c] =3D cpu;
    ...
}

Because scx_bpf_cid_override() returns void, the BPF program might still
return 0 to ops.init_cids(). If ops.init_cids() returns 0, the enable path
assumes success and continues.

While scx_error() queues disable_work, that work cannot execute because it
requires scx_enable_mutex, which is held by scx_root_enable_workfn() until
the very end of the enable path.

Consequently, the kernel will take the scheduler out of bypass mode
(scx_bypass(sch, false)) and transition to SCX_ENABLED state, actively
dispatching tasks using the partially modified and corrupted CID layout unt=
il
the mutex is dropped and the disable work finally runs.

Could we check if an asynchronous error (sch->exit_kind) was registered by a
kfunc before proceeding to enable the scheduler and taking it out of bypass
mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D10
