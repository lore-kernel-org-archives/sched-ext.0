Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4E1A6813
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384122; cv=none; b=ETMBy5SebqQukAgBByHIo6wmmi2BTT/Xah/YXhtMPn3auyPDerCGgTY4uNjtyblKPiPCAGws/48K4XYTw8JL4lgOppn7CyqMbadNIvMHdCKge9KuJlIDkb8fOKhlYNKn+ww8G7eVLE2x2R1KYH1ySGIkoh1wv2WYdcrErZMkCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384122; c=relaxed/simple;
	bh=WhagRiFpsOKOvgXl8/rRuy1tv/LBzkAsg6rB8cT47uE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bMGYeq23Xgf/1IcFzVUyUZaQP7os9fGOBc9MpAvAfES1Vl3yQvyOFYXTXgCAvUhWUitm8CnNXlut27leC7XyNLlK112Rk34usfa5NZ0p20abbpoOwaNjD/1hwFvyDTGOklgt5Xg5XpXaFx7ryME7D4OIBQlf5CW3A3qU/m+O+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK5nMT8y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK5nMT8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A272F1F000E9;
	Tue,  7 Jul 2026 00:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384120;
	bh=9KNdU7u/VfufzFpOlhLeeKYyrJSq45tKFAN/GF0lq/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dK5nMT8ywtuRXBKx0fUsz5aLyAOi/H1nTena/Lh/X8FyP3YtiwCAecmxfIiGE9NKl
	 x9hBSgy2Pk9xTmsCmhM7ZF6sfX8fNIEEtVrDIKmqT30oJNi51Svhz+GDPWYEVbzT3f
	 8soBtxdZnG0qcmLOua5i5zmB0ba3Mj8UDPdEmvQWWRxfkgo1EItCN3uweMkCyRX893
	 3aWgIptiYwFLe/FPqK165fd0wwoVrIP6AqLpWACgUa8gHCWczxNUWmsVEdwztDowW/
	 a57p2hiH2j3AJCTp0KATGDkC6KHs2f/lg+UfAXnujOX8fWRgeXzKcw2TbdPHHmCTYI
	 AHLN7xl5zoB9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 14/36] sched_ext: Add per-shard
 scx_sched storage scaffolding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-15-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-15-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:28:40 +0000
Message-Id: <20260707002840.A272F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing `scx_alloc_pshards()` initialization for sub-schedulers.
--

--- Patch [14]: [PATCH v3 sched_ext/for-7.3 14/36] sched_ext: Add per-shard=
 scx_sched storage scaffolding ---
commit ae38c39232beb16f17de4d69ed5e048f91e92e48
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add per-shard scx_sched storage scaffolding

This commit introduces a per-shard storage array (sch->pshard[]) for the
scheduler, allocating entries on the appropriate NUMA node. It sets up the
initial scaffolding with an empty struct and the associated allocation and
freeing logic. This state is intended exclusively for cid-type schedulers
that have an arena pool.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 340d1cf3630c3..a5e782147bf40 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -6722,6 +6724,12 @@ static void scx_root_enable_workfn(struct kthread_=
work *work)
>  		goto err_disable;
>  	}
> =20
> +	ret =3D scx_alloc_pshards(sch);
> +	if (ret) {
> +		cpus_read_unlock();
> +		goto err_disable;
> +	}
> +

[Severity: Medium]
Since scx_alloc_pshards() is called here for the root scheduler, does it
also need to be called in scx_sub_enable_workfn() for sub-schedulers?

The commit message mentions that only cid-type schedulers with an arena
pool get pshards. Because sub-schedulers can meet these criteria, omitting
the allocation in scx_sub_enable_workfn() could leave sch->pshard as NULL.

While the struct is empty in this scaffolding patch, will this omission
cause a regression in follow-up patches that populate and access
sch->pshard[si] for sub-schedulers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D14
