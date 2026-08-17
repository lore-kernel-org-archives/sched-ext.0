Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1EA3BADAA
	for <sched-ext@lists.linux.dev>; Mon, 17 Aug 2026 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987293; cv=none; b=puwuXRPZdl3rsPtEJqYjaDu9B4vPmzVCZGwmUyCpU3V35QGIFwC1oxeblFby0xC14tf6/MUYz/xswXVTuWCvAUoCpjYw+ZX0pvawHIBHbQ+PmAB1jATcvSFMWRcSKPf/LcIL8Bsihu1RA2FBRWvmwoW5GbahYTjaxc1r8CtLmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987293; c=relaxed/simple;
	bh=s/iZC5FGF7Ja7+u+4jN40drEMRT34HrXRZBvIUGMPhQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dR6hmzsPiOJ6fsMrqRS4CHM+qBqKJhNCuTLUc3MUSHH6yZ/DHakKcJCjLh79OucHR57zbBKIN5gBJZS0wxvCVUFeDJuIYJaj38angJLJZzvJjzmPFLWn20vA/rik0feWmyU3Qzq7M57gqajDjqh+TfyprMf2yAE13Hg79Qp/VZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGEafX2v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGEafX2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDA51F000E9;
	Mon, 17 Aug 2026 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786987292;
	bh=QS8bOJOyqvYJZldNfqJ+revmVmsCiDpqVoWenzjLxY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UGEafX2v7qwCa5ElvV7KkqtQd3T/Yn68t/VutiAfFFrZJaIvzfF0j4dD5iKCyZanc
	 aa+UryZvrwjFGmG6+gQjP2qDjy6BVqMLHcnZEsENKvV0e9XnJXL6dmF+B6RLYmFkGN
	 2THU5OQRy31e8pH+Dwv/x3lTPUYIIeHNgVnA/xQ7m964XUBkEeU3NPON7RQmGBPyBX
	 4qT0K81FuqQ6JqK0EoEynoCuJblVEhhqvngAOl7BHE1u3KJ+UhdWD2a6kyknICz46h
	 IXACoBrn3CXf8zJfvY99l6zIec8vciMseaTmhFeM1391XYkwTjHarJuzHm8DdLPKJW
	 64Xm+zjjdqsiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: allow ops.cgroup_set_bandwidth() to be
 sleepable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Changwoo Min" <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260817170941.668571-1-changwoo@igalia.com>
References: <20260817170941.668571-1-changwoo@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:21:31 +0000
Message-Id: <20260817172131.BCDA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent writes to the cgroup `cpu.max` interface can race, caus=
ing desynchronization between CFS and SCX bandwidth states and out-of-order=
 invocations of the BPF callback.
--

--- Patch [1]: [PATCH] sched_ext: allow ops.cgroup_set_bandwidth() to be sl=
eepable ---
commit 1a287753fea54decaf90a63415735694726dc348
Author: Changwoo Min <changwoo@igalia.com>

sched_ext: allow ops.cgroup_set_bandwidth() to be sleepable

This commit allows the cgroup_set_bandwidth BPF scheduler operation to
sleep. It adds a BTF marker function for userspace to detect this
capability and documents the potential blocking behavior.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 18183062f751c..c48561bf108be 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4572,6 +4572,15 @@ void scx_group_set_bandwidth(struct task_group *tg,
> =20
>  	percpu_up_read(&scx_cgroup_ops_rwsem);
>  }

[Severity: High]
This is a pre-existing issue, but does making this operation sleepable widen
the window for a race condition between concurrent cpu.max writers?

The commit message notes that cfs_constraints_mutex has already been releas=
ed
by tg_set_cfs_bandwidth(), leaving only percpu_down_read(&scx_cgroup_ops_rw=
sem)
held. Since this is a read lock, concurrent writers to the same cgroup's
cpu.max interface can execute scx_group_set_bandwidth() at the same time.

If two threads write to cpu.max, they are serialized in tg_set_cfs_bandwidt=
h(),
but can race here:

CPU1                                 CPU2
tg_set_cfs_bandwidth() (writer A)
                                     tg_set_cfs_bandwidth() (writer B)
scx_group_set_bandwidth()
   percpu_down_read()
   SCX_CALL_OP(...) // blocks
                                     scx_group_set_bandwidth()
                                        percpu_down_read()
                                        SCX_CALL_OP(...) // returns quickly
                                        tg->scx.bw_quota_us =3D ...
   tg->scx.bw_quota_us =3D ...

Can this lead to the BPF callback executing out of order, causing
desynchronization between the CFS bandwidth state and the SCX scheduler sta=
te?

Additionally, on 32-bit architectures, could updating the 64-bit
tg->scx.bw_period_us, bw_quota_us, and bw_burst_us fields without a write
lock result in torn writes?

> +
> +/*
> + * Capability marker for userspace. The sleepable allowance for
> + * ops.cgroup_set_bandwidth() (see bpf_scx_check_member()) is a verifier
> + * property with no other symbol a scheduler can probe, so this no-op fu=
nction
> + * exists solely so its presence in the kernel's BTF can be detected. It=
 has no
> + * callers; __used keeps it from being optimized away.
> + */
> +__used void scx_cgroup_set_bandwidth_may_sleep(void) {}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817170941.6685=
71-1-changwoo@igalia.com?part=3D1
