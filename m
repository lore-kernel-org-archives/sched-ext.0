Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7F3563FA
	for <sched-ext@lists.linux.dev>; Sat, 26 Sep 2026 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790451279; cv=none; b=nP2o/XIhHKir3Yz+PHbDp0apVBYPOGhFBwn9mzn+Jhgl6Yl98zjsDtn8ATUO2vm9BvMY2am83yMjU9fJn87h+d42SCP4e5kTsHsp5wZ0cz/aH9txhvtRzbo+vGOYhqgqWbpXjfD38CbmQv+Pcm1gAo5n6ay1A/Vpt4WnMsnD11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790451279; c=relaxed/simple;
	bh=wT98grqoPOxCSo7I0QPeswjcLF2lqCjMjmkr60SK30s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MYdVLziK6nn/o1B5rV9mwmrroCZyA0n/BSOpBW5uAl0trRuaGGgtnJ6LMSR/8AhVgQLBbgjp8gSkx7hIOo5qXVUhFOoE0f9Y1XzJV/lJ8I6c7iwQdIL8ajaVYWst0E1Z1NXSnhO9KjVD2NAGVdQukap3DsjKGvkdr4pK1u1XNAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dac4S/Wk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dac4S/Wk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CFF1F000FF;
	Sat, 26 Sep 2026 19:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790451278;
	bh=Tv6/qQ8kgN7R0nddeqbP/wiUAIHH9YNESpD3uvGqWrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dac4S/Wk0Xlg3TVJsxF/NHSRXoFYMux1nMA2OZYnARmr8Dlb48nMHtouYLqbjnMvO
	 W9kX25zqhn5TRAh6C6exPAOw3Oe4X8VMAhtQrCpeGMc+9nSCR8aBgB7J50tV1mZJ9y
	 xh1mK4GPbLRpMFR3r2lSaFRUoUobstDl4yqQMKcerSe1Q+jO9mRp1agf+tkIfCksFa
	 cXU3lIbbiaZagpOMALKlENbT8n8wQctEEAyvWDq7dW+eo3eezKqS3W98ygXk62FR8C
	 CKjhn/ZA/u77ZNs5q+sfpRbd3mfuJaoMvlc7/FgvToKeQVf8TLyDJkuEH5324hffhX
	 yykSl4pVHinow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Add a size argument
 to scx_bpf_cid_topo() so struct scx_cid_topo can grow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <fa6479d36b528573565ca22914451317@kernel.org>
References: <fa6479d36b528573565ca22914451317@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 19:34:37 +0000
Message-Id: <20260926193438.38CFF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: scx_bpf_cid_topo() requires unnecessary buffer initializati=
on
--

commit 20cb7828d17e22cbc3ce2d88fade05994d50f729
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add a size argument to scx_bpf_cid_topo() so struct scx_cid_topo=
 can grow

This commit adds a size argument to the scx_bpf_cid_topo() kfunc to allow
the struct scx_cid_topo layout to grow over time. The kernel copies the
smaller of the provided buffer size and the kernel's struct size, setting
the remainder to -1.

> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index bc4eee5bb4cbf..4b08866d75f6a 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
[ ... ]
> @@ -912,30 +912,36 @@ bool scx_cmask_empty(const struct scx_cmask *m)
>  /**
>   * scx_bpf_cid_topo - Copy out per-cid topology info
>   * @cid: cid to look up
> - * @out__uninit: where to copy the topology info; fully written by this =
call
> + * @out: where to copy the topology info
> + * @out__sz: size of @out, the program's sizeof(struct scx_cid_topo)
>   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF pr=
ogs
>   *
> - * Fill @out__uninit with the topology info for @cid. Trigger scx_error(=
) if
> - * @cid is out of range. If @cid is valid but in the no-topo section, al=
l fields
> - * are set to -1. All fields are also set to -1 when no cid tables have =
been
> - * published yet, which a program may observe while racing the root enab=
le.
> + * Fill @out with the topology info for @cid. Trigger scx_error() if @ci=
d is out
> + * of range. If @cid is valid but in the no-topo section, all fields are=
 set to
> + * -1. All fields are also set to -1 when no cid tables have been publis=
hed yet,
> + * which a program may observe while racing the root enable.
> + *
> + * The program's struct may be older or newer than the kernel's. The sma=
ller of
> + * @out__sz and the kernel's size is copied and the rest of @out is set =
to -1.
>   */
> -__bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out__uni=
nit,
> +__bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out, siz=
e_t out__sz,
>  				  const struct bpf_prog_aux *aux)

[Severity: Medium]
Will dropping the __uninit suffix from the out parameter force BPF
programs to initialize the struct scx_cid_topo buffer before calling
this kfunc?

Since the function fully overwrites the buffer via memset() and memcpy(),
forcing BPF programs to pre-initialize the memory creates unnecessary
overhead, as the verifier will reject uninitialized stack memory without
the MEM_UNINIT flag (which is applied when using the __uninit suffix).

The verifier should be able to map the size parameter based on the __sz
suffix regardless of the memory buffer's name (similar to existing kfuncs
like bpf_kfunc_test_uninit_mem(void *out__uninit, u32 out__sz)), so
out__uninit and out__sz can be used together safely.

>  {
> +	size_t len =3D min(out__sz, sizeof(*out));
>  	struct scx_cid_topo *topo;
>  	struct scx_sched *sch;
> =20
> +	/* the error cases and fields the kernel lacks read as -1 */
> +	memset(out, 0xff, out__sz);
> +
>  	guard(rcu)();
> =20
>  	sch =3D scx_prog_sched(aux);
>  	topo =3D rcu_dereference(scx_cid_topo);
> -	if (unlikely(!sch) || !cid_valid(sch, cid) || unlikely(!topo)) {
> -		*out__uninit =3D SCX_CID_TOPO_NEG;
> +	if (unlikely(!sch) || !cid_valid(sch, cid) || unlikely(!topo))
>  		return;
> -	}
> =20
> -	*out__uninit =3D topo[cid];
> +	memcpy(out, &topo[cid], len);
>  }
> =20
>  __bpf_kfunc_end_defs();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/fa6479d36b528573565=
ca22914451317@kernel.org?part=3D1
