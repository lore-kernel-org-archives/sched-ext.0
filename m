Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D12DF719
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384969; cv=none; b=o2TU0hB0k/Hf3jBnr5wthlP9wz9kXLQXJFM9lRuFJv8v1hjw6jpiOC4RsI7JKDCGRBMew8YWw7YnYYnvkJ6Ymmo/3GjFlhvSDsqqdqqKTa0PdKLoB0XEVpOG4zHgcLb1aJ3/GcEdSxGKmiY/xyUS1I4IzjknrNkXISC6jA6SCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384969; c=relaxed/simple;
	bh=P1YV0XSZ6UpczBH/+VrNwt/TS36zZCJyDhp8e+m7iFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SRiNgpNCZutqih/kE3vq3kE5R0mmHDB/4zpXVIyRUFVvuSAq7flrjTx+cgw4U0KUqU9s78XYlYoHweYqvp+6bCPkXAZnD+WQxzg+aaYtM9CJlP3IH8Fq0HewkVXDnSiHbywDGlxCrjWL8Ro7TuKUYgCg0HuV9z0RDzG0wiIu6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLrk8mJJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLrk8mJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6FA1F000E9;
	Tue,  7 Jul 2026 00:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384968;
	bh=cwqz640Ym709Lpq8CG2VgPOpeycPLcEYkTkIxsmIN1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BLrk8mJJ51ZUTkxYdCIXgRompjukNqk8n6jANmCa7rzZb2g4/YLwURYp+Jmis0oRG
	 r0LCPRZ3AwJas8lJkwQtNQ05kNSdprT/31fIL3dqTHFWtawY8xLi1MljrPhYS+7AM0
	 o0fnOGvspxGemr7KqNWAKhF1kBYQaaCbMsw3atuYLcMur7bv3rsAnpmYkawvtFlb8V
	 G/3b+lCXd/rqTD3PD1SFOVeYMmYho2u1+dWckIRM+kuC8aYouN6tkexxA65v9eyuS8
	 epW7Ly2ETi21iVIa5/YYNJpS3Z57E4QWDZcYZ7hDzRYY1HC9oWv+6q/Swgsa0A8l9b
	 /B25+dt3RNJhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 34/36] sched_ext: Add
 scx_bpf_sub_kill() to evict a child sub-scheduler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-35-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-35-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:42:47 +0000
Message-Id: <20260707004248.3D6FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `fmt` argument in the newly added `scx_bpf_sub_kill_bstr` kfun=
c lacks the `__str` suffix, bypassing the BPF verifier's constant string ch=
ecks and allowing a malicious BPF program to trigger an out-of-bounds read.
--

--- Patch [34]: [PATCH v3 sched_ext/for-7.3 34/36] sched_ext: Add scx_bpf_s=
ub_kill() to evict a child sub-scheduler ---
commit a7bc8fe4077dcf82d7a123efd11e286c81b3c177
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler
   =20
This commit adds scx_bpf_sub_kill() and its corresponding kfunc to allow a
cid-form scheduler to evict a direct child sub-scheduler. It disables the
child asynchronously and formats a printf-style string reason to reach the
child's scx_exit_info.

[ ... ]

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 55cd1f9a597a0..e550cfb366ad2 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -1685,6 +1685,63 @@ __bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u6=
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
> + *
> + * Evict a direct child sub-scheduler, disabling it with the supplied re=
ason.
> + * The child and its subtree are torn down asynchronously through the us=
ual
> + * disable path.
> + *
> + * Unlike scx_bpf_exit(), no exit code is taken: the child is a separate
> + * scheduler with its own exit-code semantics, so a code chosen by the p=
arent
> + * would have no defined meaning. The reason string carries the intent.
> + *
> + * Return 0 on success or -ENODEV if @cgroup_id names no sub-scheduler, =
which
> + * can race with the child detaching on its own and so is not a schedule=
r error.
> + * Naming a sched that exists but is not a direct child aborts the paren=
t.
> + */
> +__printf(2, 0)
> +__bpf_kfunc s32 scx_bpf_sub_kill_bstr(u64 cgroup_id, char *fmt,
> +				      unsigned long long *data, u32 data__sz,
> +				      const struct bpf_prog_aux *aux)
> +{

[Severity: High]
Should the fmt parameter be named fmt__str here?

Without the __str suffix, the BPF verifier treats the char *fmt argument as=
 a
KF_ARG_PTR_TO_MEM of size 1 (the size of char), rather than enforcing the
KF_ARG_PTR_TO_CONST_STR checks.

If a BPF program directly calls scx_bpf_sub_kill_bstr() with a 1-byte point=
er
that is not null-terminated, scx_bstr_format() will call
bpf_bprintf_prepare(fmt, UINT_MAX, ...) which eventually calls
strnchr(fmt, UINT_MAX, 0).

Could this allow a BPF program to read beyond the boundary of the provided
memory, potentially causing a page fault or out-of-bounds read?

> +	struct scx_sched *parent, *child;
> +	s32 ret;
> +
> +	guard(rcu)();

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D34
