Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CA13AB26A
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816787; cv=none; b=qWVjwVFKFZ6LkQZKYdx/L3m+nyoh6O2cV8nJK7PXDfZm9w+m9l2WTtEyMJ+ihPaSdGNUGr1JAz7c8dg7sVpZ9dvPoyPd1OJquw+4ZnZQXvm88gQPX4KTFZYl72t7XesBuUvvQCMkqwUVYOBKMnTEJpps6ZDcQTRF23qpuG3U0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816787; c=relaxed/simple;
	bh=Aipx6XFRYAhhBPJ3K9/DR+mE+gu38wFTNo2L5aXLAc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=umBqgsfXcgeMnU9gFS4y1hgfS5QJj4O55M8q4ecdkN5itsjD3DvhVFUFgPs2cs3seIW+vxt+Qn94bMXgzSuGrNOI5+Upm+K50BYe+TNtQqm3Cx1jkMPM5MFJcNfYRZHRqCuH5ERPK1u+rVJR4b1zUcRrRbVfyx8uYI/bSobdz6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBW+qqr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBW+qqr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3C71F000E9;
	Tue, 26 May 2026 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779816785;
	bh=oPk1J7iYRxbk5HYSJvjtheK7zuayV838bqRJE1CAx0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jBW+qqr43fp/Z7tPJWlNPxXEXSkznGt2gOPhRxOizSdCTUXByQ9a+60Ew6KY3sX77
	 otzBbZodqykIFdAEKYfIg2uerJiVp5UxbgewVqVL0S+UGmXHr9EdirdW6PhXtasT8J
	 64sCtmn6Kx1ZECywIdQqbegNAe61sNLlXYBohENSKEZS/Pf86zmujAWvAt++lkXiTc
	 nq6Hk8IQhN/gNlhtht+Fvcg1lXIppTloWlAm/LVBWfylxaFse+ZyAfdQENMZ3Tx9Bo
	 G1CQp3VK1hMX9cILsVF0B25qw4DklxCd5f0ejbwvifAJw5n4XxT2vdlSIwcOj6pdK1
	 l2IK1G3KEid5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Validate dl_server
 attach/detach in total_bw test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260526164420.638711-3-arighi@nvidia.com>
References: <20260526164420.638711-3-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 17:33:04 +0000
Message-Id: <20260526173305.5A3C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The dl_server runtime and period parameters are parsed and writt=
en as signed `long` instead of `u64` or `unsigned long long`, leading to po=
tential integer overflow on 32-bit platforms.
--

commit 6475744500400f1c70cab62bc90b17ee9b9cbbea
Author: Andrea Righi <arighi@nvidia.com>

selftests/sched_ext: Validate dl_server attach/detach in total_bw test

Extend the total_bw selftest to validate the fair/ext dl_server
auto-attach/detach operations by doubling the fair_server's runtime
via debugfs and verifying total_bw changes.

> diff --git a/tools/testing/selftests/sched_ext/total_bw.c b/tools/testing=
/selftests/sched_ext/total_bw.c
> index 5b0a619bab86e..2af01cee90cc0 100644
> --- a/tools/testing/selftests/sched_ext/total_bw.c
> +++ b/tools/testing/selftests/sched_ext/total_bw.c
[ ... ]
> @@ -100,6 +100,98 @@ static int read_total_bw_values(long *bw_values, int=
 max_cpus)
>  	return cpu_count;
>  }
> =20
> +/*
> + * Read a per-CPU dl_server param (runtime or period) from debugfs.
> + * Returns the value in nanoseconds, or -1 on failure.
> + */
> +static long read_server_param(const char *server, const char *param, int=
 cpu)
> +{
> +	char path[128];
> +	long value =3D -1;

[Severity: Medium]
Will parsing the dl_server runtime and period parameters as signed long
lead to integer overflows on 32-bit platforms?

In the kernel, dl_server parameters like runtime and period are represented
as u64 values (in nanoseconds). On 32-bit platforms, a signed long is 32
bits, which can only represent up to ~2.14 seconds in nanoseconds.

If a test system configures a fair_server runtime larger than ~1.07 seconds,
doubling it could cause a signed integer overflow. Would it be better to use
unsigned long long or u64 with %llu to avoid this?

> +	FILE *fp;
> +
> +	snprintf(path, sizeof(path),
> +		 "/sys/kernel/debug/sched/%s_server/cpu%d/%s",
> +		 server, cpu, param);
> +	fp =3D fopen(path, "r");
> +	if (!fp)
> +		return -1;
> +	if (fscanf(fp, "%ld", &value) !=3D 1)
> +		value =3D -1;
> +	fclose(fp);
> +
> +	return value;
> +}
> +
> +/*
> + * Write a per-CPU dl_server param to debugfs. Returns 0 on success.
> + */
> +static int write_server_param(const char *server, const char *param,
> +			      int cpu, long value)

[Severity: Medium]
Similarly here, does taking long value as a parameter restrict the maximum
runtime that can be written on 32-bit systems?

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
> +	if (fclose(fp) !=3D 0)
> +		ret =3D -1;
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526164420.6387=
11-1-arighi@nvidia.com?part=3D2
