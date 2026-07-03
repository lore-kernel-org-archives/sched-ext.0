Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24943F23B3
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089903; cv=none; b=sWSyjXJcRva9o3SRUhuiUO/95a2/fGHD1JeMudeZuyyDYonarJ5KKxGDqfb6mrYKZY2DZlhAcceYBgzL4t/kN/5nhx1Ym5p9FH7mh+1jv10aMSxw/tIw47waT8bHGROvzHlPsx5xw8KzQq8EMRsGrVbloKrUAHTFDbZr+LO3Aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089903; c=relaxed/simple;
	bh=gk1yWJXfvutkG7m5FAC2deStw8S2XqF/wbuktC6pLyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NSsjptpMRbBytagITQVpBGTZ/RdzNyBENd6/1fTY5HvabRN8AfIB+3JozX58qZUIW8QTM/vzq4jVoTb4e6ettUv3P6eNllkYP5U/q0AoQsdPtXspszHTSUsPGhH2F6TfSjxlV45Sv+NiDctFKJtdtnckI2UeGl1dCfPXYda6jLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC66knIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC66knIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0281F000E9;
	Fri,  3 Jul 2026 14:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783089902;
	bh=vOwRj+ejfXxZJ+lKlZljbqL4OlnaHCe2uPG7hNj2D6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FC66knIoR/o0Q6vsvTtD161BALUe8ht5VtbVnezqWXLtk+xMqKY918HE1IcO0NaN8
	 gkWC/5B+4+Ztj0c9KJ4MMyrxXAzwHlx7ngLkHJ7BTtX5PIRo0P0kCTBs7m/rPD+zK8
	 doyaKrgSyRDBsuaU9eeoU9KMNbaQhAQB1LURGEZtHgfNeyk/fZvqsdvTnqBhxkD270
	 +1wKzP85yZJwNMjKmaFW5GaX9ziSNJ2seKrkmLj8LPIhcRZ5gJjdH9ZVi2AavDVe3H
	 cxooGxlIY3OJON8Dlkx7qKd4+RPbxKE4hzJK8EKukwAQOCPC52Z6xlLvmfFjWi3sek
	 vk/D9OddQh3DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 30/32] sched_ext: Add
 scx_bpf_sub_kill() to evict a child sub-scheduler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-31-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-31-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:45:01 +0000
Message-Id: <20260703144502.3B0281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Out-of-bounds read due to missing `__str` suffix on the `fmt` argu=
ment in `scx_bpf_sub_kill_bstr`.
--

commit dae92dbfa20b120640a7210997136f2e4d4af380
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler

This commit adds scx_bpf_sub_kill() to allow a cid-form scheduler to evict
a direct child sub-scheduler. It exposes BPF string formatting infrastructu=
re
and introduces a new exit kind, SCX_EXIT_PARENT_KILL, to handle the teardow=
n.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 15edcf4f81ee2..4baa6f7be71bd 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
[ ... ]
> @@ -1636,6 +1636,63 @@ __bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u6=
4 caps, struct scx_cmask *out_
>  	return 0;
>  }
> =20
> +/**
> + * scx_bpf_sub_kill_bstr - Kill a direct child sub-scheduler
> + * @cgroup_id: cgroup id of the direct child to kill
> + * @fmt: reason message format string
> + * @data: format string parameters packaged using ___bpf_fill() macro
> + * @data__sz: @data len, must end in '__sz' for the verifier
> + * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF pr=
ogs
[ ... ]
> + */
> +__printf(2, 0)
> +__bpf_kfunc s32 scx_bpf_sub_kill_bstr(u64 cgroup_id, char *fmt,
> +				      unsigned long long *data, u32 data__sz,
> +				      const struct bpf_prog_aux *aux)

[Severity: High]
Does this kfunc definition miss the __str suffix on the fmt parameter?

Because the argument is named fmt instead of fmt__str, the BPF verifier
treats it as a standard memory pointer (KF_ARG_PTR_TO_MEM) with a size of
1 byte (the size of char), rather than as a null-terminated string.

If a BPF program passes a pointer to a 1-byte map value without a null
terminator, the verifier will allow it. Later, this pointer is passed
through scx_bstr_format() to bpf_bprintf_prepare(), which scans for a null
terminator up to UINT_MAX:

kernel/sched/ext/ext.c:__bstr_format() {
    ...
    ret =3D bpf_bprintf_prepare(fmt, UINT_MAX, data_buf, data__sz / 8,
                              &bprintf_data);
    ...
}

Could this lead to an out-of-bounds read in the kernel if
bpf_bprintf_prepare() scans beyond the 1-byte verified bounds?

> +{
> +	struct scx_sched *parent, *child;
> +	s32 ret;
> +
> +	guard(rcu)();
> +
> +	parent =3D scx_prog_sched(aux);
> +	if (unlikely(!parent))
> +		return -ENODEV;
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D30
