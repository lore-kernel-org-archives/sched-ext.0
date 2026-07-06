Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C637C106
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303965; cv=none; b=orqcJcpALV3OeLMr1/DMEX/dgu6//w2F8840gyV+34aBDZuAp4wf80NMwP+C9DFtVLYL04d6YG1WYgV5DUe8hZgcyV/7eUlUYydyi0faPg9WQLANTUc/fuB1E9E8RBMZvpNjILI5LXcEhWuIxUZwpAR0TBvYR6M+MVRBewYofvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303965; c=relaxed/simple;
	bh=g5NgGwl07PIlas4Fo585P5LuZo+2rWF1pcA8b1VzzAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ELcpnWeGVp/WOWrULUSlbtz/3kWYnD+XKoU32dwDBpOhgNCqRwHUl/FwEV9sGnm+yFgyAlglQKjw4l+Ew9C8eXZ21ZQibsZfbLUDhQ66DAS8nFMYeCMW8WMqSq8ksvzdMmnLvFOxLWiuf/HzUJrKS4KoS/ekXvnGy3dkfu8C6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFPN2cyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFPN2cyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC461F000E9;
	Mon,  6 Jul 2026 02:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303959;
	bh=FwNwfmqip4ZCIxNH4zILoBJxxrHvMPfYZpkVhUlguxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EFPN2cyI5npENlamyje1Jewr6aQOQ83mcv5KHdm1ao1joVWpDhGn+CwXEYCq7Yn/o
	 7Z2MIq8m0hegQpRiRwhowEA+G9RJYbWZjEAxe+WUDQfygQxnI5bqKYkWJcWyRguQhQ
	 qvGODFpGzSypHa2Ou770W6XuNN7pgBN/DbnqDzqevfI/h/cWHtuZoR9LdEoXwSq2Xq
	 8zzcSMt6u/ODITNUfBxhBj9Qbw8PObxdS6j32W0oZQORQjCQwswcHBqJ2+5v140Hlq
	 llQBVYlu7f9/pCKS3c97E+k0jWgXsn4vo1WLYNRQHRZH6WoL7T966mrIa7fZ3wnWZr
	 FllKvxc+Fpo0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 34/36] sched_ext: Add
 scx_bpf_sub_kill() to evict a child sub-scheduler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-35-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-35-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:12:37 +0000
Message-Id: <20260706021238.8FC461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `__str` suffix on the `fmt` parameter in `scx_bpf_sub_kill=
_bstr` (and existing `_bstr` kfuncs) allows BPF programs to bypass string v=
alidation, leading to out-of-bounds reads and kernel panic in `bpf_bprintf_=
prepare()`.
--

commit 913e5289cfb426b3e00c896b1ac589f4f3d4cb62
Author: Tejun Heo <tj@kernel.org>

    sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler

This commit introduces scx_bpf_sub_kill() to allow a parent scheduler to=20
evict a child sub-scheduler. It exposes the bstr formatting infrastructure
to provide a formatted reason string during the async teardown.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 9e0643e3cecba..f0cdd7357525a 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1659,6 +1659,63 @@ __bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u6=
4 caps, struct scx_cmask *out_
[ ... ]
> +__printf(2, 0)
> +__bpf_kfunc s32 scx_bpf_sub_kill_bstr(u64 cgroup_id, char *fmt,
> +				      unsigned long long *data, u32 data__sz,
> +				      const struct bpf_prog_aux *aux)
> +{
> +	struct scx_sched *parent, *child;

[Severity: High]
This is a pre-existing issue, but does the fmt parameter need the __str
suffix to enable BPF verifier constant string checks?

Without the suffix, the verifier treats fmt as a generic memory pointer
rather than enforcing null-termination. Since scx_bpf_sub_kill_bstr() calls
scx_bstr_format() -> __bstr_format(), which passes UINT_MAX to
bpf_bprintf_prepare():

kernel/sched/ext/ext.c:__bstr_format()
    ret =3D bpf_bprintf_prepare(fmt, UINT_MAX, data_buf, data__sz / 8, ...);

kernel/bpf/helpers.c:bpf_bprintf_prepare()
    fmt_end =3D strnchr(fmt, fmt_size, 0);

If a BPF program passes a non-null-terminated buffer (like a 1-byte stack
variable), strnchr() will perform an unbounded memory scan.

Because scx_bpf_sub_kill_bstr() acquires scx_exit_bstr_buf_lock, this scan
happens with a raw spinlock held. If the scan hits an unmapped page, will
it trigger an unhandled page fault and panic the kernel?

> +	s32 ret;
> +
> +	guard(rcu)();
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D34
