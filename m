Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD2C223708
	for <sched-ext@lists.linux.dev>; Sun, 17 May 2026 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779045290; cv=none; b=l5B8xM+jRetUT/SMxyD6X18DhKcR5FF5zr/gQEe1PlEKBXADHAG/iAHRfiu2p4gNc9ec27Ywqf/hR8/DAIRt7hLAKWbqHrA+pfUaqYj+F9Pp3fNV3mJ1ZYgB6VyMwxlFh4pIw7rFKDxjBf19fPZyK7JORBBzGhdprmpGfpKjq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779045290; c=relaxed/simple;
	bh=zxkME9ysxabVK3e4xltqf3xEx0B89n9Fh8Av39sf/VQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pmU2uuZrLBZElzm1sNRJ6x17YR3uPABRrm6uE6Y+w60MwfmHGGcA0ThGvy6JXOm1X0v/TDkyiqPsXazebdaqsWlBbYeeWpxPHGIBB2ud/TgxFJrV4OImA6UpFBhDewIbkDV2EFZSlzB04a9XwG8NbfCQLJRRm6KoxReBLr8S0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHbn0Kfq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHbn0Kfq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0306C2BCB0;
	Sun, 17 May 2026 19:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779045290;
	bh=zxkME9ysxabVK3e4xltqf3xEx0B89n9Fh8Av39sf/VQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fHbn0Kfqp1TiN4zxddJlYMDbGbaZba246PlnbC5bB88rA7wkDZbTi/T786R1R3qRP
	 fzbb8XeE8ZyPjiFtZcx9eQ/nH9jT7IPRowyT0p21Agi3L/Iyvdh7Ab1jtQgpSYV4B4
	 KKjKSMajXN4MqDMe2nRd+JNZjMa2T21frNl7Rzht0lKMw9Y9zabx+hW6xZulVSP8Xu
	 wxQ9rn7d2QjuOdwwyXKZzr17Pc9uA00nPD4Az9KeaArQbnqBWZq9VKTOGTM3iOcIFH
	 y71yVp6ivPqVVJNEx0The6JlwFGC7t33gKO1xmiy9dZl5s6fbG+PKlKtUHPqZOjWPs
	 g69sY7l9HPqHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Track bits[] storage size in struct
 scx_cmask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260517183614.1191534-3-tj@kernel.org>
References: <20260517183614.1191534-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 19:14:49 +0000
Message-Id: <20260517191449.E0306C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Uninitialized per-CPU cmask scratch buffer silently breaks CPU aff=
inity tracking
- [Medium] Missing bounds validation in BPF helper `__cmask_init()` permits=
 arena out-of-bounds access
--

commit ef0793b90f8713b1c92aecf6ec1f064d2df562a5
Author: Tejun Heo <tj@kernel.org>

sched_ext: Track bits[] storage size in struct scx_cmask

This patch adds tracking for the allocation size of bits[] in struct
scx_cmask to allow validation of active range reshapes. It splits the
bit-range API, introduces scx_cmask_clear() and scx_cmask_fill(), and
updates the BPF mirror functions.

> diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
> index bdd8ef8eae3dc..f50319c5c65e1 100644
> --- a/kernel/sched/ext_cid.c
> +++ b/kernel/sched/ext_cid.c

[ ... ]

> @@ -274,10 +316,9 @@ void scx_cpumask_to_cmask(const struct cpumask *src,=
 struct scx_cmask *dst)
>   * Initialize @dst to cover the full cid space [0, num_possible_cpus()) =
and
>   * set the bit for each cid whose cpu is in @src.
> + * Clear @dst's active range and set the bit for each cid whose cpu is in
> + * @src and lies within that range. Out-of-range cids are silently ignor=
ed.
>   */
>  void scx_cpumask_to_cmask(const struct cpumask *src, struct scx_cmask *d=
st)
>  {
>  	s32 cpu;
> =20
> -	scx_cmask_init(dst, 0, num_possible_cpus());
> +	scx_cmask_clear(dst);

Since dst (scx_set_cmask_scratch) is zero-initialized via __alloc_percpu(),
does it ever get its nr_cids explicitly initialized now that the call to
scx_cmask_init() has been removed?

If m->nr_cids remains 0, scx_cmask_clear() will return immediately. The
subsequent loop calling __scx_cmask_set() would then ignore all CPUs because
the bounds check in __scx_cmask_contains() fails for a 0-length range.

Could this result in BPF schedulers receiving an empty cmask in their
ops_cid.set_cmask() callback, breaking task affinity tracking?

>  	for_each_cpu(cpu, src) {
>  		s32 cid =3D __scx_cpu_to_cid(cpu);

[ ... ]

> diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/incl=
ude/scx/cid.bpf.h
> index b9dcc14870d3a..211f4077f43ac 100644
> --- a/tools/sched_ext/include/scx/cid.bpf.h
> +++ b/tools/sched_ext/include/scx/cid.bpf.h
> @@ -44,20 +44,71 @@ static __always_inline u64 __arena *__cmask_word(cons=
t struct scx_cmask __arena
>  	return (u64 __arena *)&m->bits[cid / 64 - m->base / 64];
>  }
> =20
> -static __always_inline void cmask_init(struct scx_cmask __arena *m, u32 =
base, u32 nr_cids)
> +/**
> + * __cmask_init - Initialize @m with explicit storage capacity
> + * @m: cmask to initialize
> + * @base: first cid of the active range
> + * @nr_cids: number of cids in the active range
> + * @alloc_cids: storage capacity in cids, at least @nr_cids
> + *
> + * Use when storage is sized larger than the initial active range. All of
> + * bits[] is zeroed.
> + */
> +static __always_inline void __cmask_init(struct scx_cmask __arena *m, u3=
2 base,
> +					 u32 nr_cids, u32 alloc_cids)
>  {
> -	u32 nr_words =3D CMASK_NR_WORDS(nr_cids), i;
> +	u32 alloc_words =3D CMASK_NR_WORDS(alloc_cids), i;
> =20
>  	m->base =3D base;
>  	m->nr_cids =3D nr_cids;

Should this helper validate that nr_cids does not exceed alloc_cids?

The C implementation (__scx_cmask_init) safely clamps nr_cids to alloc_cids.
Without a similar check here or a call to scx_bpf_error(), passing an
oversized nr_cids allows __cmask_contains() to pass bounds checks for bits
beyond alloc_words.

Could this allow BPF programs to bypass intended constraints and corrupt
their own arena structures during cmask_test() or __cmask_word() calls?

> +	m->alloc_words =3D alloc_words;
> =20
>  	bpf_for(i, 0, CMASK_MAX_WORDS) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517183614.1191=
534-1-tj@kernel.org?part=3D2
