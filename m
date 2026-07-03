Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB837F012
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072280; cv=none; b=jdIRBbILKk97fMI4wXGAS58/HwBlNV3RI65UfXi4/jtvDTlMeLLaPY+PeeirgOgcr9gidFDS6E9xgzywTxdH8q/djpT2dL+MDe3zOMvb5BVBvE97JUWWtkKyS8xmf7aevFNc26LKIxjItmqBYRjY9M+LL6XdAb0TUY5AYmbDi1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072280; c=relaxed/simple;
	bh=vTToMimXUJyyAaLtQNHlBmgD9k3egMJ7Sw8JsrBL1ew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j+649a4HTciLWVoCrBbObLJ+9C9ABA8tlgfV70ersg+2gwwj9HG302i6cbJ2PnPaFSuM6gS+1NXMFDyn9aibe4yD4AGDQNlHPhKLCVU4ii4F0IJuMlnBvOy/mUk3vpCH45lyccxYv30abq/V0mmMw/63llryI1cxi5bV6jGIzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbdGFkge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbdGFkge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6102F1F000E9;
	Fri,  3 Jul 2026 09:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783072278;
	bh=hNCVnxXk2zTCM6VAbC18224Ell57pe8uHZu0zEyNYNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QbdGFkgenL/nfVJDvW7xbiF6QbhmWaZPRBMhxIS2/BQ6D7Hlnn6BHhB42zAed+bVQ
	 1IpVBxibrrxRkmqU+HotO3CGpbPnjy6NFSZQLhWguUlSZ2lGIf7J4VJC210j1/PXpk
	 bOrHkUayZKV3f+iFuqsikan7aYPIlFrSDE3Tx5kgDB413rAPfU4QvzvRbzPS9oIJkd
	 XgXfaVl5TEVvsgVyIkSjY3hot0gY/9epOqMJEA6PwZEF2/fxisin4XV2+G463tjAZe
	 N5UDI3q/MB/3iEJuP7jC6/QjFeU+HKo07pP+8glj5lyiwmIjT0xRgGq0juj/oNDbXY
	 owh9gioqwkHAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 10/32] sched_ext: Add shard boundaries
 to scx_bpf_cid_override()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-11-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-11-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 09:51:17 +0000
Message-Id: <20260703095118.6102F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Concurrent modification of userspace/BPF-accessible arrays `cp=
u_to_cid` and `shard_start` bypasses validation and leads to out-of-bounds =
writes.
- [High] Changing the signature of `scx_bpf_cid_override` without renaming =
the kfunc breaks backward compatibility and `compat.bpf.h` versioning, unco=
nditionally causing load failures on older kernels.
--

commit 8e4715e8e1c648121e31ca200c7493656e918c11
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add shard boundaries to scx_bpf_cid_override()

This commit extends scx_bpf_cid_override() to accept an explicit shard layo=
ut
alongside the cpu-to-cid mapping. It updates the validation and assignment
logic to handle shard assignments and modifies the tools/sched_ext compat
wrapper and qmap tests to supply the new arguments.

> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index 9d75b9311978c..bd0467e8a8d29 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
[ ... ]
> @@ -442,13 +511,56 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cp=
u_to_cid, u32 cpu_to_cid__sz,
>  			scx_error(sch, "cid %d assigned to multiple cpus", c);
>  			return;
>  		}
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		s32 c =3D cpu_to_cid[cpu];
> +
>  		scx_cpu_to_cid_tbl[cpu] =3D c;
>  		scx_cid_to_cpu_tbl[c] =3D cpu;
>  	}

[Severity: Critical]
Since cpu_to_cid and shard_start point to BPF map memory which can be mmap'=
ed
and modified concurrently by userspace, can this cause a TOCTOU race leadin=
g to
out-of-bounds writes?

If a buggy or malicious userspace program modifies cpu_to_cid[cpu] after the
first validation loop finishes but before this second loop reads it, could =
'c'
exceed num_possible_cpus() and cause scx_cid_to_cpu_tbl[c] =3D cpu to write=
 out
of bounds?

The shard_start array also appears to be read repeatedly across multiple lo=
ops
after validation. Would it be safer to kmemdup() these arrays before
validation to ensure consistent state?

[ ... ]
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index 133058578668d..cf469d5ff9ca0 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
[ ... ]
> @@ -122,15 +122,18 @@ static inline bool scx_bpf_sub_dispatch(u64 cgroup_=
id)
>  }
> =20
>  /*
> - * v7.2: scx_bpf_cid_override() for explicit cpu->cid mapping. Ignore if
> + * v7.3: scx_bpf_cid_override() for explicit cid and shard mapping. Igno=
re if
>   * missing.
>   */
> -void scx_bpf_cid_override___compat(const s32 *cpu_to_cid, u32 cpu_to_cid=
__sz) __ksym __weak;
> +void scx_bpf_cid_override___compat(const s32 *cpu_to_cid, u32 cpu_to_cid=
__sz,
> +				    const s32 *shard_start, u32 shard_start__sz) __ksym __weak;
> =20
> -static inline void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_t=
o_cid__sz)
> +static inline void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_t=
o_cid__sz,
> +					 const s32 *shard_start, u32 shard_start__sz)
>  {
>  	if (bpf_ksym_exists(scx_bpf_cid_override___compat))
> -		return scx_bpf_cid_override___compat(cpu_to_cid, cpu_to_cid__sz);
> +		scx_bpf_cid_override___compat(cpu_to_cid, cpu_to_cid__sz,
> +					      shard_start, shard_start__sz);
>  }

[Severity: High]
Does changing the signature of scx_bpf_cid_override() without renaming the
kfunc break backward compatibility for BPF schedulers loaded on older kerne=
ls?

On older kernels that only have the 2-argument version of the kfunc,
bpf_ksym_exists() will still match by name and return true. However, because
the compatibility wrapper now makes a 4-argument call, the BPF verifier will
reject the program due to a BTF signature mismatch.

Should the kfunc be renamed (e.g., scx_bpf_cid_override_v2) so
bpf_ksym_exists() correctly returns false on kernels that don't support the
new signature?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D10
