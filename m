Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9AF38E8C8
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779388314; cv=none; b=kpmgGvwmpZchLrQz2R6NDiayT4fkHvkpO9/015OW3GUhiE5sRhMxS7V1bs7rSnCSCwKpocvhbk4B5erz4hR1Z9QDL9/6qYaqfHTB5CvdQNYqUqWR+nExKc5dNEvth0/tvZ8QL9qN0Ux6af0C2HLpfdfUgpqQOAP0tjc3SkOjjBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779388314; c=relaxed/simple;
	bh=pb/ckQWyF3lGfJ7uTDR889Dghh7kmJ9U+4DR+Toi1pE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Do6HC6OYu1Gd0Q3dgbmLhrKQpEpM5GXd7nE472xQafAgQXIUYgz4SPV/jPvro/3ZaPI7Pui73brX2mdUmNQQ2q1UKwZ6ylR+zPfnpaGU/UGRv5iQuK6ORNx7ZYTYn5N4VUQKCKjeaEYBhvEjgFiUruTs2BSj9MMQb0SJ79V1EVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IanBGrK9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IanBGrK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED89C1F000E9;
	Thu, 21 May 2026 18:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779388313;
	bh=4yEL1imEPtNrd9wbkQ5wkk46tQEV4LKHNsNqOKSbPTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IanBGrK9dvpHuAUIDOtEjsD62aIVkpYWhsTUH0ZRriNK76DDP2rrF8K1ZON7Z/LT9
	 G+yO91tc79dNBCk70jZD+BSlmIEqlpHrhv0XdhIwRsY++q556gBAbqR+cyNPwBZ5NU
	 2rUHP3Ma86l6IS062c0DiJEjbi2lvHBq2v9bt9Qnhj+pap2eWLkEd1+RTnnfrxXbny
	 D+JunKfmEpELxkrMzltuXUP8RkyfppfrCMyp3Pq4MCxo6nmaQw+NpUVw8BwuZbBeJu
	 NPU2RMNwk7+hbGxotb5GtwwwQORvcL96t8xiete4qoCdaXCri9BwhdpcqNtT1Ga8eA
	 Zcsqi0SQqUDUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Validate dl_server
 attach/detach in total_bw test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260521174509.1534623-3-arighi@nvidia.com>
References: <20260521174509.1534623-3-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 18:31:52 +0000
Message-Id: <20260521183152.ED89C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Unchecked return value of fclose() in write_server_param() masks=
 kernel-level debugfs write failures.
- [Medium] The test incorrectly assumes all CPUs share the same fair_server=
 runtime and globally restores CPU 0's value to all CPUs.
- [Medium] Early exit in write_fair_runtime_all() prevents full system stat=
e restoration if a single CPU write fails during cleanup.
--

commit 694643dec460b3df43c360074223ec82f5be4cc8
Author: Andrea Righi <arighi@nvidia.com>

selftests/sched_ext: Validate dl_server attach/detach in total_bw test

Extend the total_bw selftest to validate the fair/ext dl_server
auto-attach/detach operations.

> diff --git a/tools/testing/selftests/sched_ext/total_bw.c b/tools/testing=
/selftests/sched_ext/total_bw.c
> index 5b0a619bab86e..8eea12e8868ac 100644
> --- a/tools/testing/selftests/sched_ext/total_bw.c
> +++ b/tools/testing/selftests/sched_ext/total_bw.c
[ ... ]
> @@ -100,6 +100,66 @@ static int read_total_bw_values(long *bw_values, int=
 max_cpus)
[ ... ]
> +static int write_server_param(const char *server, const char *param,
> +			      int cpu, long value)
> +{
> +	char path[128];
> +	FILE *fp;
> +	int ret =3D 0;
> +
> +	snprintf(path, sizeof(path),
> +		 "/sys/kernel/debug/sched/%s_server/cpu%d/%s",
> +		 server, cpu, param);
> +	fp =3D fopen(path, "w");
> +	if (!fp)
> +		return -1;
> +	if (fprintf(fp, "%ld", value) < 0)
> +		ret =3D -1;
> +	fclose(fp);

[Severity: Medium]
Since FILE streams are fully buffered or line-buffered by default and
fprintf() writes a string without a newline, couldn't the actual write()
syscall to debugfs be triggered during fclose()?

If the kernel rejects the write (e.g., due to admission control), fclose()
would return EOF but fprintf() would have succeeded. By ignoring the fclose=
()
return value, could this incorrectly return 0 (success) even when the
parameter was not updated?

> +
> +	return ret;
> +}
> +
> +static int write_fair_runtime_all(int nr_cpus, long value)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < nr_cpus; i++) {
> +		if (write_server_param("fair", "runtime", i, value) < 0) {
> +			SCX_ERR("Failed to write fair_server runtime on CPU %d", i);
> +			return -1;

[Severity: Medium]
If a single CPU write fails when this function is called from the cleanup
path, this early return will abort the loop. Could this prevent the remaini=
ng
CPUs from being restored to their original fair_server runtimes, leaving the
system in a permanently customized state?

> +		}
> +	}
> +
> +	return 0;
> +}
[ ... ]
> @@ -217,6 +277,9 @@ static enum scx_test_status run(void *ctx)
[ ... ]
> +	original_runtime =3D read_server_param("fair", "runtime", 0);
> +	if (original_runtime <=3D 0) {
> +		fprintf(stderr, "Skipping attach/detach validation: debugfs not access=
ible\n");
> +		return SCX_TEST_PASS;
> +	}
> +	doubled_runtime =3D original_runtime * 2;
> +
> +	fprintf(stderr,
> +		"Setting fair_server runtime to %ld ns on all CPUs (orig %ld)\n",
> +		doubled_runtime, original_runtime);
> +
> +	if (write_fair_runtime_all(test_ctx->nr_cpus, doubled_runtime) < 0) {
> +		ret =3D SCX_TEST_FAIL;
> +		goto restore;
> +	}

[Severity: Medium]
This reads the original fair_server runtime from CPU 0 only, and then
eventually restores this same value to all CPUs during cleanup.

On heterogeneous systems (like big.LITTLE) or manually tuned systems, CPUs =
may
have different initial runtimes. Does this destructively overwrite all uniq=
ue
per-CPU runtimes with CPU 0's value after the test completes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521174509.1534=
623-1-arighi@nvidia.com?part=3D2
