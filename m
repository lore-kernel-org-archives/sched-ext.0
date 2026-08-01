Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947723644C6
	for <sched-ext@lists.linux.dev>; Sat,  1 Aug 2026 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785575166; cv=none; b=fdeUNHBbIFNPSV+1MRntxmh2IgYnRwBtldGVQwIuGP3dlX82F3J9fmZoRPUeXKkakdEGWrtaCl8uDbPpv1G/J85L7I4FnxCP/jwbIAJwzTef3tsDONXGyMFSvIMDeEDSgma7yUDPWBWW65NnZEHuQ2ZfDa2nVj+2cnkB5ewa/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785575166; c=relaxed/simple;
	bh=bPOXCpmZ+YIw1CGraL8Do22QM77MUdMj6fe8YuhqiUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LAgX6KBM7EnjghQBbjbNw+MVwKXmlAlG9ig8ZTtNJGdfksaBrecPZ54iOnsfq1WpyU5U0u7EOh7XgIo1Xk9xsvJEkrpDH5hj3dbpjpPXhuEG+qZ0rKieVXGHtwQ7IElsG6gT1cTuBlm8EPefbEfjjPrIb9AXxGUxqUE8XWoQsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/VjJbuq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/VjJbuq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593D51F00AC4;
	Sat,  1 Aug 2026 09:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785575163;
	bh=oo68dWqBOFNuo1pdlHB0WQf779pQCSNli3bE6aKVOD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P/VjJbuqW6/HN/oHvrpUfoNqbDm9wJTe9/vg6MaG9fashusIRULiAsODxgyRsF0YO
	 Y0uzk0CJ+z3QwhC2YBzKNeAo9fFc9GcmLeXRXZYB5wkGqxS497SQG+Dtd//5M+s2ca
	 kxRwShgfihVT+N8RttmQzvZVs5yfvKYHA586Njk7/nCKWhH0EU4DJYQm2+tkq5m4IO
	 1tXGCtZgXpSklki2tNLeQTSRxK0entk3RSFtFzZpuZhWjMLe7F/9pCPMThkxqSvws1
	 V+aC41imhJc191TsqxrSD2J2YKR83IhGdcAYjP6ltH6SH+GwgWuPW0w1GuP65bLfTI
	 hGQ9rUyrKI2Hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] sched_ext: scx_qmap - Add rescue support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260801085150.2697653-13-tj@kernel.org>
References: <20260801085150.2697653-1-tj@kernel.org>
 <20260801085150.2697653-13-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 09:06:02 +0000
Message-Id: <20260801090603.593D51F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `!(enq_flags & SCX_ENQ_REENQ)` check for stranded tas=
ks causes an infinite enqueue-reject-reenqueue loop when rescue is disabled.
--

--- Patch [12]: [PATCH 12/12] sched_ext: scx_qmap - Add rescue support ---
commit d8697209a4441d32aa069b5cede51b062fddcc4c
Author: Tejun Heo <tj@kernel.org>

sched_ext: scx_qmap - Add rescue support

This commit adds rescue support to scx_qmap for tasks that have no self cids
they can run on. It updates the qmap_enqueue and qmap_dispatch logic to use
the SCX_ENQ_RESCUE flag and scan the shared queue to redirect stranded task=
s.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 9a0321e84e88f..b6e7b004611c0 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -449,31 +449,33 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struc=
t *p, u64 enq_flags)
>  	taskc->core_sched_seq =3D qa.core_sched_tail_seqs[idx]++;
> =20
>  	/*
> -	 * A node with children delegates most cids. A task of ours that can run
> -	 * on none of our self cids (e.g. a per-NUMA kthread pinned to delegated
> -	 * cids) would starve in SHARED/FIFO since we never pull those on a
> -	 * delegated cid. Force it onto its first allowed cid's local DSQ with
> -	 * needs_immed(): if we hold access there it runs, else the kernel
> -	 * rejects and bounces it back via REENQ_CAP. Best-effort
> -	 * anti-starvation nudge.
> +	 * A task of ours that can run on none of our self cids - the parent
> +	 * didn't grant them or we delegated them to children - would starve in
> +	 * SHARED/FIFO since we only pull from those on self cids.
> +	 *
> +	 * Force it onto its first allowed cid's local DSQ. If we hold that cid
> +	 * it runs. Otherwise the insert carries SCX_ENQ_RESCUE and the kernel
> +	 * diverts the task to its rescue path.
>  	 */
> -	if (qa.nr_sub_scheds && !(enq_flags & SCX_ENQ_REENQ) &&
> -	    !cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {
> +	if (!cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {

[Severity: High]
Does removing the !(enq_flags & SCX_ENQ_REENQ) check here cause an
infinite bounce loop when rescue is disabled kernel-side?

If scx_qmap is executed with -B 0, the kernel capability check rejects the
insert and bounces the task back to ops.enqueue() with the SCX_ENQ_REENQ
flag.

Without the check for SCX_ENQ_REENQ, qmap_enqueue() will immediately hit
this condition again and force-insert the task back to the target CPU.

Could this lead to an endless, unthrottled loop that locks up the core?

>  		s32 c =3D cmask_next_set_wrap(&taskc->cpus_allowed, 0);
> =20
>  		if (c >=3D 0 && c < scx_bpf_nr_cids()) {
>  			taskc->force_local =3D false;
> +			__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
>  			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | c, slice_ns,
> -					   enq_flags | needs_immed(c));
> +					   enq_flags | needs_immed(c) | SCX_ENQ_RESCUE);
>  			return;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801085150.2697=
653-1-tj@kernel.org?part=3D12
