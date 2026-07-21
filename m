Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD17408631
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616627; cv=none; b=t3n/ru7xh6jWdPt0k/7RM3OsRo78s22euKlShnfQZ6hOtFCYL51MVUvC7mUPKOBL4Bj8VxKgOmf2nZbthpbXmsO4AqBFBGHG5FlX0udI6q4NyvgptfxsUNK4cjVogo94r82tBvX2g3W8N0WHWAuJk+b9iYpxPOdVg2Wf7a1Bq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616627; c=relaxed/simple;
	bh=LgGv7Hf1uCsoqpJFiVzPHT8h83rsICl9C1q5dpADsHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gJPRY6lt6NuE/TQqLq01hZXeV5JFKm9fRP15sOMxmwi9n3vkFc3SQWYM7Kat+sO9vZI/reIlIxjm5VVqn0gijkoFZGg63worKHaSvI5UcsjTQk0RGn8PC+UqWBk2Cpa/47AgSYR5dzUBtsrMjO/aY57JYePOqYBW7zinYiU24lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8HtZdy3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8HtZdy3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580A21F000E9;
	Tue, 21 Jul 2026 06:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784616625;
	bh=Sj3ZkJB3mqzeU4pMuw8/UlnreZeWfHBK8ZBGdPcWcoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i8HtZdy3IXw71pXx1MG89YLkg3Sql26SfISTrGbQWEoklTapfZXg3pVvoe0SR7LXJ
	 xM7ABiXSontw6po1CaWNTzrpAhccNtlx39+eXVuLkzC6QEdLphul6YsfTgG9HGFlQ7
	 A52gtBYGlObADQ04bxtfzTsZELbDFUCga4MVX6CTKaOFUyrxTedWUAij5vPSFLH89J
	 zRKljDHX4IsV7j/3FS5hoiW2u2F8UsCEFKZg26tmKGDHSdkhExrh+FtV/69LGxKndv
	 yd7TCSBW9jB5Pbj1kKB0St6Vxpm0hcA3AHOb2IMrveW6HWNybwIuWIPwpsoL/uRlP5
	 wsK4pGZQBMaYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] sched/core: Avoid false migration warning for
 proxy donors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260721063242.552774-2-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
 <20260721063242.552774-2-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 06:50:24 +0000
Message-Id: <20260721065025.580A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The warning for migrating a migration-disabled task is incorrect=
ly suppressed for all sleeping tasks when proxy execution is enabled, inste=
ad of just for blocked proxy donors.
--

--- Patch [1]: [PATCH 01/12] sched/core: Avoid false migration warning for =
proxy donors ---
commit 3b0fd432ea71e1ba27a8e56bb387fb372b053daf
Author: Andrea Righi <arighi@nvidia.com>

sched/core: Avoid false migration warning for proxy donors

This commit updates set_task_cpu to suppress a false positive warning when
migrating a proxy donor. It allows moving a blocked scheduling context to
another CPU even when the donor task has migration disabled.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
[ ... ]
> @@ -3376,7 +3376,13 @@ void set_task_cpu(struct task_struct *p, unsigned =
int new_cpu)
>  	 */
>  	WARN_ON_ONCE(!cpu_online(new_cpu));
> =20
> -	WARN_ON_ONCE(is_migration_disabled(p));
> +	/*
> +	 * Proxy execution can move a blocked task's scheduling context to any
> +	 * CPU without moving its migration-disabled execution context. The
> +	 * wakeup path will return the task to a CPU where it can execute.
> +	 */
> +	WARN_ON_ONCE(is_migration_disabled(p) &&
> +		     !(sched_proxy_exec() && p->is_blocked));

[Severity: Medium]
Does this logic inadvertently suppress the warning for all sleeping tasks
rather than just proxy donors?

Because p->is_blocked is set unconditionally for all sleeping tasks when
__schedule calls try_to_block_task, this condition in set_task_cpu appears
to suppress the warning for any migration-disabled sleeping task whenever
proxy execution is globally enabled.

If another scheduler component, such as a load balancer or a BPF sched_ext
extension, incorrectly migrates a normal sleeping task that has migration
disabled, this overly broad check might hide the invalid migration and mask
further issues.

> =20
>  	trace_sched_migrate_task(p, new_cpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721063242.5527=
74-1-arighi@nvidia.com?part=3D1
