Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768326;
	b=kRXMy9Z/mvPu26sV8iMOWWJh4LkgfUuSyI7YgWYSoksVk1wt1FeBZL6cfQRS6WmSTLvy
	 89m5jvrg5QGZEue3JELNKaGQ6q2qTdfLKFiSdGbhindBmne/LSESH198HKPZOcZ6Da95H
	 Y3wiXE+WvdsinHE1kpfuOg3Ki+xBtrdu8+lrHiCMGmQBLHhqjiFnCh+kUm8JmWfoTlvg6
	 PBobgCoA2lfufOZr7cGcZIETTtbiZ2J9yY5bLjdbwEMD7AoKZARoDiYYJDgf1GI1u7w3I
	 +DzcbnLt0vUbaHKIsiAs1IU4EZfexR3SczVSFd8ECupT/ovJ5TInRcdkrEWRZ31B60Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768326;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NQb0FtxkuxUvYvHs6Nlub0TObaL78GVDAE67WBQFGcA=;
	b=G8f6TXqdO05DlTQZdHL+rvP9TCA4lriA+uW5LbZ1nV5w9Fwk8p17A3nv2mGa1TavVQtR
	 HsyBj/tcGMUCd5x60WQHIfONulnuNdIWS3BphCGypANqzaPFxzjTmd7GzBlwPudvACFTR
	 FlLUcDK/FP3MMOvjszZGTazhAeByTBSNX4aOWPZbWGv9tfTxQuXiHF/APWFgS141KsXy+
	 5lHxOAS6JTu6s5pItOPZZhAITc7iQRbCgfWgZkhVoCbOxPFvSAacbkSbQ3S3WfjHXqC6v
	 rxDaD8clXF1SoJ9NMN9wG1exoNRJWzYAVBUK1isztrVPI2m7L/dy4zE0qzi/vh4nP2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTVfnvxG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC125606A31A
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTVfnvxG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB9F1F01828;
	Fri, 23 Oct 2026 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792768325;
	bh=NQb0FtxkuxUvYvHs6Nlub0TObaL78GVDAE67WBQFGcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HTVfnvxGVhvpKzq5ftUdeuEvFN7hnEAt2fU6EyuPjfDYKkMD5sjIm5rnR7qJ4Y8L3
	 v/IXv5dK5qEGQ7LeMefV+BdhK0zMSnMZQvvXttF9LeeUhquA4juNSqb3Epz7fALXCY
	 ajvpmiHHXsPIx9V9s2PtKV0bTof0TPec8gSf7so7OYa7Ybf5DZKw7yGPyVxEnhrWiC
	 HiztsUGUKERPe7Vcbyz/NVdzE6iNxscdvwGtZhMsZzbBIKt58jzXkQaCemfJsjITiT
	 eIts0qnIxBioCBTF4C3kcfsIi4z/kt0qw/gkfvh2jMYN9vyDg2wXZYzcraWDDNa30b
	 rpuyA2Ey1n3dw==
Message-ID: <sashiko-outbox-182896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Test SCX_ENQ_CPU_SELECTED with
 queued wakeups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuba Piecuch" <jpiecuch@google.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261023144811.2230393-3-jpiecuch@google.com>
References: <20261023144811.2230393-1-jpiecuch@google.com>
 <20261023144811.2230393-3-jpiecuch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 15:12:05 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/sched_ext: enq_cpu_selected fails to spread pingpong t=
asks across CPUs
--

commit e10a521c76ecd2ad846ac3d66a5ccc148e633d86
Author: Kuba Piecuch <jpiecuch@google.com>

selftests/sched_ext: Test SCX_ENQ_CPU_SELECTED with queued wakeups

This commit adds a selftest verifying that SCX_ENQ_CPU_SELECTED is set on
a wakeup ops.enqueue() if and only if ops.select_cpu() ran for that wakeup,
including queued wakeups when SCX_OPS_ALLOW_QUEUED_WAKEUP is set.

> diff --git a/tools/testing/selftests/sched_ext/enq_cpu_selected.bpf.c b/t=
ools/testing/selftests/sched_ext/enq_cpu_selected.bpf.c
> new file mode 100644
> index 0000000000000..80e40592332a2
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/enq_cpu_selected.bpf.c
> @@ -0,0 +1,107 @@

[ ... ]

> +s32 BPF_STRUCT_OPS(enq_cpu_selected_select_cpu, struct task_struct *p,
> +		   s32 prev_cpu, u64 wake_flags)
> +{
> +	struct task_ctx *tctx;
> +
> +	/* fork enqueues don't carry SCX_ENQ_WAKEUP, only track ttwu */
> +	if (!(wake_flags & SCX_WAKE_TTWU))
> +		return prev_cpu;
> +
> +	tctx =3D bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> +	if (tctx) {
> +		tctx->select_cpu_called =3D true;
> +		tctx->select_cpu_on =3D bpf_get_smp_processor_id();
> +	}
> +
> +	return prev_cpu;
> +}
> +
> +void BPF_STRUCT_OPS(enq_cpu_selected_enqueue, struct task_struct *p,
> +		    u64 enq_flags)
> +{
> +	struct task_ctx *tctx;
> +
> +	tctx =3D bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> +	if (tctx) {
> +		bool called =3D tctx->select_cpu_called;
> +		bool flagged =3D enq_flags & SCX_ENQ_CPU_SELECTED;
> +
> +		tctx->select_cpu_called =3D false;
> +
> +		if (enq_flags & SCX_ENQ_WAKEUP) {
> +			if (called) {
> +				__sync_fetch_and_add(&nr_selected, 1);
> +				if (bpf_get_smp_processor_id() !=3D tctx->select_cpu_on)
> +					__sync_fetch_and_add(&nr_queued, 1);
> +			}
> +			if (called && !flagged)
> +				__sync_fetch_and_add(&nr_missing, 1);
> +			if (!called && flagged)
> +				__sync_fetch_and_add(&nr_spurious, 1);
> +		}
> +	}
> +
> +	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> +}

[Severity: Medium]
Can this scheduler reliably generate cross-CPU queued wakeups so that
nr_queued becomes non-zero after the warmup reset?

In run(), the struct_ops scheduler is attached before spawn_pair() forks the
worker processes:

tools/testing/selftests/sched_ext/enq_cpu_selected.c:run()
    link =3D bpf_map__attach_struct_ops(skel->maps.enq_cpu_selected_ops);
    ...
    for (i =3D 0; i < NR_PAIRS; i++)
        spawn_pair(&pids[i * 2]);

During fork(), sched_cgroup_fork() initializes each child's CPU to
smp_processor_id() (the test runner's CPU), and wake_up_new_task() ->
select_task_rq_scx() invokes enq_cpu_selected_select_cpu() instead of
scx_select_cpu_dfl() because ops.select_cpu is defined. Since
enq_cpu_selected_select_cpu() returns prev_cpu unconditionally on both fork
and wakeup, all worker tasks stay assigned to the runner's CPU.

In addition, enq_cpu_selected_enqueue() inserts tasks into SCX_DSQ_GLOBAL
without kicking or selecting an idle CPU, and scx_dispatch_enqueue() does
not kick idle CPUs when inserting into a non-rq-owned DSQ. When all workers
remain on the same CPU, ttwu_queue_cond() sees cpu =3D=3D this_cpu and never
uses the ttwu wakelist.

Even if another CPU happens to wake up from an unrelated interrupt and
consumes a worker from SCX_DSQ_GLOBAL via scx_consume_global_dsq(),
enq_cpu_selected_enqueue() still puts woken tasks into SCX_DSQ_GLOBAL rather
than SCX_DSQ_LOCAL. In pingpong(), the waker immediately calls read() after
write() and enters __schedule() -> do_pick_task_scx() ->
scx_consume_global_dsq(), which allows the waker's CPU to pull its own wakee
back onto the waker's CPU during the WARMUP_MS window before
skel->bss->nr_queued is reset to 0 in run().

Would it make sense to spread or pin the worker pairs across distinct CPUs
and dispatch to SCX_DSQ_LOCAL (or kick idle CPUs) so that wakers and wakees
consistently run on different CPUs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023144811.2230=
393-1-jpiecuch@google.com?part=3D2
