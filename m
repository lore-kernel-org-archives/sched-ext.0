Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815C30FF30
	for <sched-ext@lists.linux.dev>; Sat, 19 Sep 2026 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778585; cv=none; b=ITENiZ3Zkmg37f9ORweXZlQQQQKtOhD0oWlOWg57KpGlGu1dWadyeT/OQqroJgd7dj+Kr6Pr1GNyUaaIsOX26CmIHt0DT37em1IOOe5vRnC4B3MJYlItnjKyP/tYE7zxguIdEfRAuzRg9CEx6Tu8svRWEcJrpjCxrzomNRrrOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778585; c=relaxed/simple;
	bh=TD1WrA6OZmP7xX4alyUbo0YS0RX8wGKi5/i8003uMpM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d1wGyLQbgOnarZpiyd5167sVDa/EPDkteQ/0yXz0mcsCbtt3f5/z0noyhQ/AE8XAI4gi2v4rSLoftKVRvQGKQXj49m+lAGWmYjOmwz0MXkDVRAlGeyIiZpjJdV53bZFrraPB6nSKvgTUG0npRJCz8iWozdlv3XlePaLZlVxSpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THirgkK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THirgkK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AF81F000FF;
	Sat, 19 Sep 2026 00:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778583;
	bh=y7aXaQN8MvcN1ukp9V4XDowIphp9Ovl77mV8T/E/PzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=THirgkK5JelyWRqahAKPG4GaDWYTaS1q/A6y1HoT40Kh0lGoURz76EpiDIHNKoql/
	 mG/Ts0x/TtbeAYx4giC9z53utJINK9K6bWr6v1WnZNx3E0FsYlW/DNpQIBwORAeX54
	 kcN62Ce65csZ6LPUSX+t43sws9BwYi/BKWuZ+ekgD6CCoYZ0SuixGgKcLLOobZ1Q4T
	 g9DSNsRX5jq/GqLcJpBdrsuNSdwd89bP6VzKplKSZEM+nYI0/8QR26onvoppw5TxnN
	 GX+EOhAeYJ06dZ4P6AKTlgRnndm5Q01nGFWE71/lJSw3EZnZKlNKuitDObL3ufcI+c
	 hethK2FAHIqjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Check the cmask cid-form
 ops.enable() receives
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260919002838.1960071-3-tj@kernel.org>
References: <20260919002838.1960071-1-tj@kernel.org>
 <20260919002838.1960071-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:43:02 +0000
Message-Id: <20260919004303.13AF81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/sched_ext: data race on global error variables in check_m=
ask()
--

commit 72058557dd9acff8213206e33ae6e84591889e86
Author: Tejun Heo <tj@kernel.org>

selftests/sched_ext: Check the cmask cid-form ops.enable() receives

This commit adds a new cid-form selftest to verify that ops.enable()
receives the correct task cmask. It checks the mask against p->cpus_ptr
and ensures that the initial set_cmask() matches enable() and is called
in the correct sequence.

> diff --git a/tools/testing/selftests/sched_ext/enable_cmask.bpf.c b/tools=
/testing/selftests/sched_ext/enable_cmask.bpf.c
> new file mode 100644
> index 0000000000000..bbbf989d2c698
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/enable_cmask.bpf.c

[ ... ]

> +u64 nr_enable, nr_initial_set_cmask, nr_set_cmask, nr_set_weight;
> +s32 bad_cid;
> +bool bad_want, bad_got;
> +
> +UEI_DEFINE(uei);

[ ... ]

> +static int check_mask(struct task_struct *p, const struct scx_cmask __ar=
ena *m, u64 *fp)
> +{
> +	u32 nr_cids =3D scx_bpf_nr_cids();
> +	u64 h =3D 0;
> +	s32 cid;
> +
> +	if (m->base || m->nr_cids !=3D nr_cids)
> +		return -EINVAL;
> +
> +	bpf_for(cid, 0, MAX_CPUS) {
> +		bool want, got;
> +		s32 cpu;
> +
> +		if (cid >=3D nr_cids)
> +			break;
> +		cpu =3D scx_bpf_cid_to_cpu(cid);
> +		if (cpu < 0)
> +			return -ENOENT;
> +		want =3D bpf_cpumask_test_cpu(cpu, p->cpus_ptr);
> +		got =3D cmask_test(cid, m);
> +		if (want !=3D got) {
> +			bad_cid =3D cid;
> +			bad_want =3D want;
> +			bad_got =3D got;
> +			return -EIO;
> +		}

[Severity: Low]
Can these global error variables be overwritten concurrently if multiple ta=
sks
fail the cpumask check at the same time?

Since bad_cid, bad_want, and bad_got are global and updated without atomics=
=20
or locks, a race condition here might lead to mismatched or incorrect value=
s=20
being logged in the error message when the test is failing.

> +		h =3D h * 31 + got;
> +	}
> +
> +	*fp =3D h;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919002838.1960=
071-1-tj@kernel.org?part=3D2
