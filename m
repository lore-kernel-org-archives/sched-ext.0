Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D7D28150F
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547673; cv=none; b=A1mwAPlkRUdWLwCTlBxfBucNvIE8UNEoHI/19QpD03qSWpqVoONzgJLCSoXy5NLgJ/PJurv8rLoYr85OqRomsWJpgTlktnNJ7gwlMhvUDtp9IA9YHfSHuLKM/6XSqSMqAdt5YMjMK0yAkYQW+21+Gv8kM37GSjyTBkDW9jO+DLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547673; c=relaxed/simple;
	bh=NqPhJHByKDfjWfnAavJiYx42Q3SmzDN98IvmB66Df9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rkcNRNS2MVCwkgDIYFbl6N7qVnJAXqbGIVLM3I+yQUzT8doTl87nPPYN48t9gRMxLMhxfkFyihZhtxEyFuzsDZwFsJtPiMoHoxz9MXQe7vockRXQ8ygyrBZbK3Wn3fMSMjGW6AGMXOTAUiOwV0vY2Jl2C8qbXVAM+aCaEjhFxtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng0hVj2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng0hVj2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAD01F000E9;
	Wed,  8 Jul 2026 21:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783547672;
	bh=GivPGuUQ6x2VqAxbGWThK7n6lzSIfzgg2w7aZUiOukI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ng0hVj2YRz9h5IPRjOUkXJTCflX3JtlfVHIuQH04Ux4qdveDqRUdCor4ek5RC/ATY
	 P6jZ+zxbRWXXoKA3RgZVV7sDVcJkx3DtBNeoTU6/pkABaH5AJzaxx284jyL+u9Lxbr
	 cWbA0CIuh3Rsfhp06/EzpHbiFNq1x5LHzKSUSKctGXFMIGrEDXSgzJ92wvZ7cSHugA
	 r39mgWcGqAveTdYfx51HdajEq9HQzq097AV2qX00+hqPAKMleP8AoVHGENpJ0jAPkP
	 ZeSiQBhcoHBPu5HYSLXrJdiDjga9FgVAVi3QcAIJGOhTGcEpcGxy7+FHXa7Oku6Cio
	 yVI8Lq3C4Ts5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 11/40] sched_ext: Add
 ops.init_cids() to finalize the cid layout before init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-12-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-12-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 21:54:31 +0000
Message-Id: <20260708215432.0DAD01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] scx_bpf_cid_override() partially mutates global CID topology mappi=
ng tables on failure, leaving them in a corrupted state.
--

--- Patch [11]: [PATCH v4 sched_ext/for-7.3 11/40] sched_ext: Add ops.init_=
cids() to finalize the cid layout before init ---
commit 0ba160b3b7201c0388f756d1be42ba4c9fc9a45c
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add ops.init_cids() to finalize the cid layout before init

This commit adds a dedicated ops.init_cids() callback for cid-form schedule=
rs
to finalize their cid layout using scx_bpf_cid_override(). This callback ru=
ns
before the main ops.init() setup to ensure a stable layout for subsequent
initialization steps.

> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index f31113b080e90..b0ec4d76f8552 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
[ ... ]
> @@ -309,11 +309,6 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu=
_to_cid, u32 cpu_to_cid__sz,
>  		return;
>  	}
> =20
> -	if (scx_parent(sch)) {
> -		scx_error(sch, "scx_bpf_cid_override() only allowed from root sched");
> -		return;
> -	}
> -
>  	if (cpu_to_cid__sz !=3D nr_cpu_ids * sizeof(s32)) {

[Severity: High]
This is a pre-existing issue, but can this leave the global CID topology
mapping tables in a corrupted state on failure?

Looking at scx_bpf_cid_override() just below this diff, the loop updates
the global tables before fully validating the input:

kernel/sched/ext/cid.c:scx_bpf_cid_override() {
    ...
    for_each_possible_cpu(cpu) {
        s32 c =3D cpu_to_cid[cpu];

        if (!cid_valid(sch, c))
            return;
        if (cpumask_test_and_set_cpu(c, seen)) {
            scx_error(sch, "cid %d assigned to multiple cpus", c);
            return;
        }
        scx_cpu_to_cid_tbl[cpu] =3D c;
        scx_cid_to_cpu_tbl[c] =3D cpu;
    }
    ...
}

If it hits an invalid or duplicate CID mid-way, it calls scx_error() and
returns void. The calling BPF program cannot detect this failure and returns
0 (success), allowing the initialization sequence to proceed using the
partially corrupted CID mapping.

Since the asynchronous teardown work scheduled by scx_error() is blocked
behind scx_enable_mutex during initialization, does this allow the system
to fully transition tasks to the BPF scheduler using the corrupted state
before it can be disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D11
