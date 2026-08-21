Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFBD2E1746
	for <sched-ext@lists.linux.dev>; Fri, 21 Aug 2026 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309488; cv=none; b=i5NTW3bUNR1ltiLra5n+rRQqUIRB9hanNZ7eXka7m/xpkZzO0tKEyZ6Y27aC+r3t4QbsjKUoQVBHOQWlaUynUXkKy/Z7ffMTC9GKC9rJvXexPptzlh4jABZhMY9il/HBBZjlDxWUrRADNmJurKR2ufUATJu0P/wvaUoRPpJOAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309488; c=relaxed/simple;
	bh=pnOHacPiJjOustDq3ioKb1SGwv3LjXZQa2x7Or5xOMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NzgaPSp3fW86ZVV8Xz7SGOstgi03USasF97NgzyFEGbcftrYkGpQd+MlmyAMiB/PQpfIgY3LWUciUK9uMmn/h0ToSWZP16Kh05KQsEa6mJbpp+BoQTz8R7KSLnrcbRtC0F5LCkmhFhzqc117TQeiwCqrBsDOzDTHsAGaGFI78ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL4uSCAH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL4uSCAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DF71F000E9;
	Fri, 21 Aug 2026 10:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787309484;
	bh=tAhU0a162db0bW1rlkaOhhevY/2ZJbeOSta/eSoL5ZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aL4uSCAHv/N4ATOZN9l3JDx5qGb9GaGLL6LMqvUel7/VhbJCFC5jdHAwLRHXbAU4D
	 HntLjOEyGFTId2Qe7NH7TlQhz9GgmBE4icnRcZOOKSi4scwEgmxd3QMAgsvYbwBWOV
	 WBnMPEUqmDsAA7NdY7XVWG8p78raNihu9hT3PXoVUtZn3bNgFxAIQM7AiEyr9X/U33
	 G/EeezoUgJNxSPKm66kVIThtGLnNHweP6YYqmsZia/MHkVdxlHG/KKtbL5oqy2J7Iv
	 WhnVPQyPlb1oftRR2fUQ6jTS42wwJzYEJZDOIbQMAjrnDG+AKeCy9c+gMcWZk0WgiS
	 3eLZFc/xZNMnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: serialize concurrent cpu.max writers in
 scx_group_set_bandwidth()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Changwoo Min" <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260821103519.535987-1-changwoo@igalia.com>
References: <20260821103519.535987-1-changwoo@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:51:24 +0000
Message-Id: <20260821105124.B8DF71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Acquiring a global mutex inside a per-CPU rwsem read-side critic=
al section causes severe starvation for scheduler operations.

Pre-existing issues:
- [High] Concurrent writers to cgroup bandwidth limits cause the CFS and SC=
X states to permanently diverge due to split-lock domains.
- [High] The write-side mutex fails to protect the lockless Read-Modify-Wri=
te cycle, resulting in lost updates and permanently committed torn reads.
- [High] Missing serialization for other unprotected cgroup attributes (`cp=
u.weight` and `cpu.idle`).
--

--- Patch [1]: [PATCH] sched_ext: serialize concurrent cpu.max writers in s=
cx_group_set_bandwidth() ---
commit bbcc7e2a9caf9650a3bf7bd4d7036631840fbfd4
Author: Changwoo Min <changwoo@igalia.com>

sched_ext: serialize concurrent cpu.max writers in scx_group_set_bandwidth()

Concurrent writes to a cgroup's cpu.max are not serialized by the cgroup or
kernfs layer. This patch adds scx_cgroup_set_bw_mutex to serialize SCX-side
updates, preventing interleaved writers and torn 64-bit stores.

Link: https://lore.kernel.org/sched-ext/20260817172131.BCDA51F000E9@smtp.ke=
rnel.org/

[Severity: High]
This is a pre-existing issue, but does the split-lock design between CFS
and SCX cause their states to permanently diverge?

When two concurrent writers modify cpu.max, tg_set_bandwidth() updates
the CFS subsystem sequentially under cfs_constraints_mutex, and then the
SCX subsystem under the new scx_cgroup_set_bw_mutex:

kernel/sched/core.c:tg_set_bandwidth()
#ifdef CONFIG_CFS_BANDWIDTH
    ret =3D tg_set_cfs_bandwidth(tg, period_us, quota_us, burst_us);
#endif /* CONFIG_CFS_BANDWIDTH */
    if (!ret)
        scx_group_set_bandwidth(tg, period_us, quota_us, burst_us);

Because these locks are not held atomically across both updates, writers
can interleave. CFS might commit the second writer's limits while SCX
commits the first writer's limits.

[Severity: High]
This isn't a bug introduced by this patch, but does the write-side mutex
fail to protect the lockless Read-Modify-Write cycle?

Handlers like cpu_max_write() and cpu_burst_write_u64() perform an RMW
cycle by calling tg_bandwidth() to read existing limits locklessly:

kernel/sched/core.c:tg_bandwidth()
#else /* !CONFIG_CFS_BANDWIDTH */
    if (period_us_p)
        *period_us_p =3D tg->scx.bw_period_us;
    if (quota_us_p)
        *quota_us_p =3D tg->scx.bw_quota_us;

They then modify one field and write everything back via tg_set_bandwidth().

Concurrent writers to different fields will read each other's stale data
and overwrite the other's update. Since the new scx_cgroup_set_bw_mutex
only protects the final write, doesn't this leave the RMW cycle broken,
allowing corrupted or torn 64-bit limits to be written back on 32-bit
architectures?

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index b646711a45fee..a2fc581d9636d 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -4945,6 +4952,7 @@ void scx_group_set_bandwidth(struct task_group *tg,
>  	struct scx_sched *sch;
> =20
>  	percpu_down_read(&scx_cgroup_ops_rwsem);
> +	mutex_lock(&scx_cgroup_set_bw_mutex);

[Severity: Medium]
Does acquiring this global mutex inside a per-CPU rwsem read-side locking
section cause starvation for scheduler operations?

If multiple threads write to cpu.max across any cgroups system-wide, they
will all acquire the read lock and queue up sequentially on the global
mutex. If a system thread then attempts an operation requiring the write
lock, it must wait for every queued thread to individually acquire the
mutex, run a potentially slow BPF operation, and release the read lock.

Would reversing the lock order avoid inflating the read-side hold time?

[ ... ]

[Severity: High]
This is a pre-existing issue, but do other cgroup attributes like
cpu.weight and cpu.idle lack serialization?

For example, in scx_group_set_weight(), concurrent writers can
race through the SCX_CALL_OP() dispatch and the subsequent assignment
to tg->scx.weight.

kernel/sched/ext/ext.c:scx_group_set_weight()
    if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_weight) &&
        tg->scx.weight !=3D weight)
        SCX_CALL_OP(sch, cgroup_set_weight, NULL, tg_cgrp(tg), weight);

    tg->scx.weight =3D weight;

Since the BPF dispatch and the cache update are not atomically linked,
writers can interleave, leaving the BPF scheduler applying one weight
while the kernel caches another. Should similar serialization be applied
to scx_group_set_weight() and scx_group_set_idle() to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821103519.5359=
87-1-changwoo@igalia.com?part=3D1
