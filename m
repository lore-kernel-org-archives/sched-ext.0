Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C994315F
	for <sched-ext@lists.linux.dev>; Tue, 18 Aug 2026 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069919; cv=none; b=nuBFossw2Q5Xz+b6NyGD3FXP3zPcAfpzpQ1h8GG03+PK5vwrUqgk8MxdXtnHJFe6eXpZpnIN8AHxI20DwcTE/0IUFPKars0K6LUxwPLpmbop2hkM4RhlnBWY0Rco1n8x3UgudeZNK65hQ/0aVYs+8U1l06KPH4tI6aULlUxgkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069919; c=relaxed/simple;
	bh=Qg/TmZ3J069fPO/KVWconc0LOVRytu6iQmW/tDTroBU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bkBd9UIjnAEIrpbCg9RqFEtBllHlC0gTMcBAG3Gj0h6irCZ7DX9RWKbx9nOoMWmlRjtiUjBuVaYOVdm7nm8NtA0Jk/b46IV3y4QGN23rqSn4tGouc6Au02dQ3fYHoV088Q1CJZ1W45dEtoKUteXm79LwlGSauK3wLv0O0yJNd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjNRO5/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjNRO5/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0198D1F00A3A;
	Tue, 18 Aug 2026 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787069918;
	bh=NkBYoALVVDGiT0mHx8RtKR9xWbSClX5DRw/GS1F0Ys0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kjNRO5/CL52lmaajIWe+yJOfDLuwqUg3q5Bey2KoV3WWki31mq/toHqDx2IJZi8qv
	 nj9VL5tRJIRfY1gcHW93YVUCaeirqrCgaVia+N0ZhAs4oSqjZT67J51t9KdaF+GkD0
	 uU6SCckvwL5NPHMxQL24nX2tc7EiJ6Vj6RQ4w10f+uEoXxQiZziydPbXWq5z73UHRf
	 NV1heatVLZjCY0jgi+hbnpQxZ31WFNDOnNiMAGhXP8bEZ5tR7DWoFtN+VsqfcZwfmw
	 Y/a4LgKDlNA45nguPHrrYy6n9IlFU9Oj6ofRflqk8v1+pelJPVvUAzXyh8rGZzAsqZ
	 rYiiMWVWsbT/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] sched_ext: allow ops.cgroup_set_bandwidth() to be
 sleepable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Changwoo Min" <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260818160429.932265-1-changwoo@igalia.com>
References: <20260818160429.932265-1-changwoo@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 16:18:37 +0000
Message-Id: <20260818161838.0198D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Concurrent cgroup writes to `cpu.max`, `cpu.weight`, or `cpu.idl=
e` race to update the cached `tg->scx` state without an exclusive lock, cau=
sing the BPF scheduler's state to silently and permanently diverge from the=
 cgroup state.
--

--- Patch [1]: [PATCH v2] sched_ext: allow ops.cgroup_set_bandwidth() to be=
 sleepable ---
commit dc54116ac36c38be3f813a52900e454dacbf26ad
Author: Changwoo Min <changwoo@igalia.com>

sched_ext: allow ops.cgroup_set_bandwidth() to be sleepable

This commit adds cgroup_set_bandwidth to the allow-list in
bpf_scx_check_member, allowing its BPF callback to sleep. It also adds a
BTF compatibility marker so userspace can detect this capability.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 10af28a9f2c0c..b646711a45fee 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -8079,6 +8079,7 @@ static int bpf_scx_check_member(const struct btf_ty=
pe *t,
>  	case offsetof(struct sched_ext_ops, cgroup_init):
>  	case offsetof(struct sched_ext_ops, cgroup_exit):
>  	case offsetof(struct sched_ext_ops, cgroup_prep_move):
> +	case offsetof(struct sched_ext_ops, cgroup_set_bandwidth):

[Severity: Medium]
This is a pre-existing issue, but does making this callback sleepable
significantly widen a data race in cgroup state updates?

Looking at concurrent writes to cpu.max, tg_set_bandwidth() drops the
exclusive lock before calling into sched_ext:

kernel/sched/core.c:tg_set_bandwidth() {
	...
#ifdef CONFIG_CFS_BANDWIDTH
	ret =3D tg_set_cfs_bandwidth(tg, period_us, quota_us, burst_us);
#endif
	if (!ret)
		scx_group_set_bandwidth(tg, period_us, quota_us, burst_us);
}

The cfs_constraints_mutex is dropped inside tg_set_cfs_bandwidth(), so
scx_group_set_bandwidth() runs without an exclusive lock.

Then in scx_group_set_bandwidth(), only a read lock is held while executing
the BPF hook and updating the state:

kernel/sched/ext/ext.c:scx_group_set_bandwidth() {
	percpu_down_read(&scx_cgroup_ops_rwsem);
	...
	SCX_CALL_OP(sch, cgroup_set_bandwidth, NULL, tg_cgrp(tg), ...);
=09
	tg->scx.bw_period_us =3D period_us;
	...
}

Since percpu_down_read() allows concurrent readers, two concurrent writes
can interleave. With the BPF program now allowed to block inside
SCX_CALL_OP(), could this cause the cached tg->scx state to permanently
diverge from the actual cgroup state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818160429.9322=
65-1-changwoo@igalia.com?part=3D1
