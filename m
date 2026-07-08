Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5D3AA1BA
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547722; cv=none; b=rtqkzgkH++b0kwxp6VC9spxKRXbJdvMeaWpUKDuv4Xxfl/LumMrBkI9CRD5zQQZGBG5RFwd0syFQJXzbM8/mn6/+sZAgeEe4dVdrWLlhGQysCwra04VMhKnZDZG1/XJehVqjHJY3881iraCUwlCT+nA3dgwO2IxvjNYHmb/52Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547722; c=relaxed/simple;
	bh=AwyfwDmTf1LqazX95+WQ/xiMVirdI9rvjcRtYmVUxZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RP+Lli+VYE4ZmHJiA6Ac+MBdTAGz2vzRZF5Ii76BkZVpgNfI1ndheX3TzDtrjErFISVaK9jkvTKh9b2D88Y28+uAviZ09idlN02W+RzUPPKdrIMhxNYsoBEujfQZO72rfptGKV4CLseLN38ggeANQppdM/6JNFXGnemYObXCaio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goAEdIv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goAEdIv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5461F000E9;
	Wed,  8 Jul 2026 21:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783547720;
	bh=EXt+jEPWnVK34BIfGGAh8hKIcQeky4FaRqaf4L/eTVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=goAEdIv7N+jxae/iqTigNvpIG0IV3MU+wUyGgx6S50fL6aydAzUiefrQFAQrbw8xt
	 OBUzmbceYKopHSMDlDFjL/e5iSlOFHpEz3u6oW5q/5A4DYXr+WHHJcok+Eozxi5+QS
	 guNlBAbc2xXVROFtL/mFdd9hM0TE8HHLRUsFij84/ise4EQjGTVznCuo/5Px1i5bdf
	 Knrnuiyab6DMRJpbNxQ0fMoA6XhR2CyOrscrXbMX9etvWgbQvs7GdEWQpKJWMupw85
	 2wEXF+SjdgT5a3febkDEvHrVSUP2Y18C582HCB5Pdu+FRBNfwgOxRpPrNtvhmo3Ajp
	 UTBJNlvNIFUAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 20/40] sched_ext: Stop resolving a
 disabled scheduler's programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-21-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-21-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 21:55:20 +0000
Message-Id: <20260708215520.8C5461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `sch->dead` check was omitted from the `!CONFIG_EXT_SUB_SCHED`=
 fallback version of `scx_prog_sched()`, leaving the Use-After-Exit hazard =
unfixed.
- [High] A parent scheduler can invoke a child scheduler's `ops.dispatch()`=
 after the child's `ops.exit()` has already executed, bypassing the newly i=
ntroduced `dead` flag protection.
--

--- Patch [20]: [PATCH v4 sched_ext/for-7.3 20/40] sched_ext: Stop resolvin=
g a disabled scheduler's programs ---
commit 4eb6882510c7d2ef68878ed595f1b7ecec9ef3cc
Author: Tejun Heo <tj@kernel.org>

sched_ext: Stop resolving a disabled scheduler's programs

A scheduler's BPF programs can outlive it. A timer it armed or a tracing
program it loaded can fire after ops.exit() has run, before the programs are
unloaded, and scx_prog_sched() still resolves the program to its scheduler
through ops->priv. Harmless while kfuncs touch only lifetime-stable state,
but a hazard once a kfunc reads global state a newly loaded scheduler can
change underneath it.

Add scx_sched->dead, set right after ops.exit() and drained with
synchronize_rcu(). It follows exit() rather than preceding it so exit()'s o=
wn
kfunc calls still resolve to @sch. scx_prog_sched() returns NULL for a dead
scheduler, so every kfunc's existing !sch bail rejects it at one choke
point.

> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index dce07b83c1663..87582bca5cc4f 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h

[ ... ]

> @@ -1968,14 +1969,20 @@ static inline bool scx_task_on_sched(struct scx_s=
ched *sch,
>  static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux=
 *aux)
>  {
>  	struct sched_ext_ops *ops;
> -	struct scx_sched *root;
> +	struct scx_sched *sch, *root;
> =20
>  	ops =3D bpf_prog_get_assoc_struct_ops(aux);
> -	if (likely(ops))
> -		return rcu_dereference_all(ops->priv);
> +	if (likely(ops)) {
> +		sch =3D rcu_dereference_all(ops->priv);
> +		if (sch && unlikely(READ_ONCE(sch->dead)))
> +			return NULL;
> +		return sch;
> +	}
> =20
>  	root =3D rcu_dereference_all(scx_root);
>  	if (root) {
> +		if (unlikely(READ_ONCE(root->dead)))
> +			return NULL;
>  		/*
>  		 * COMPAT-v6.19: Schedulers built before sub-sched support was
>  		 * introduced may have unassociated non-struct_ops programs.

[Severity: High]
This isn't a bug introduced by this patch, but does the fallback definition=
 of
scx_prog_sched() also need the sch->dead check?

When the kernel is built with CONFIG_EXT_SUB_SCHED=3Dn, scx_prog_sched() in
kernel/sched/ext/internal.h is defined as:

static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *a=
ux)
{
	return rcu_dereference_all(scx_root);
}

If a BPF timer fires during the synchronize_rcu() window in scx_root_disabl=
e(),
it seems this fallback will unconditionally return scx_root without checking
its dead flag, allowing kfuncs to execute on torn-down scheduler state.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 17ed0d28f3839..8d98250936497 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -344,6 +344,15 @@ void scx_sub_disable(struct scx_sched *sch)
> =20
>  	if (sch->ops.exit)
>  		SCX_CALL_OP(sch, exit, NULL, sch->exit_info);
> +
> +	/*
> +	 * @sch's programs (an armed timer, a tracing prog) can fire after
> +	 * exit(). Now that exit()'s own kfuncs have resolved, stop
> +	 * scx_prog_sched() from resolving to @sch and drain in-flight resolver=
s.
> +	 */
> +	WRITE_ONCE(sch->dead, true);
> +	synchronize_rcu();
> +

[Severity: High]
This is a pre-existing issue, but can a parent scheduler bypass the newly
introduced dead flag and invoke a torn-down child scheduler's ops.dispatch(=
)?

If a parent scheduler calls scx_dispatch_sched(child) from a BPF program
holding the RCU read lock while scx_sub_disable() is waiting on
synchronize_rcu():

Parent BPF program                  scx_sub_disable()
                                      child->ops.exit()
                                      WRITE_ONCE(child->dead, true);
                                      synchronize_rcu(); (blocks on parent)
scx_find_sub_sched()
scx_dispatch_sched(child)
   child->ops.dispatch()

It looks like scx_dispatch_sched() unconditionally invokes the dispatch
operation without checking the dead flag. Does scx_dispatch_sched() or
scx_bpf_sub_dispatch() need to check if the child is already dead to
prevent access to torn-down state?

>  	if (sch->sub_kset)
>  		kobject_del(&sch->sub_kset->kobj);
>  	/* not added if enable failed before scx_sched_sysfs_add() */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D20
