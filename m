Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC946F48C
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092748; cv=none; b=rYc8rB1siG8hRbR60MOHaSGzfQ4Rt1EQ4oF28ZkbWTgsYrwsIY80knbRIsten6WoYffLTmPDDnxfvbhmfJYrGmPaqE8Z3OK/6oXhNvapzTHVflvov230JyyrN16j7cSx7gj2IiKQyOkueKQPpMmv/vVPiovRW+3XEDXW+T/PSZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092748; c=relaxed/simple;
	bh=DlGB4qP/ppalsA19lAZrDerwBXp+FcAj5RUB0gkW7lE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iFAsED3RSYHh8G47RmOz3Kjdi7esfNvEVE6EL1+cwaY47AcKHNSHxwDzA55BvJbmNPURWw0YbFEwAftgWYl1Bk3tdzN/gBdafWxmsktfnd4L81Xi2adyCvRlMclRcmAObGwlI2bTUpaykKwKzU7Q+jshQ24VVjeDjzPR+h+BTak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo+kHGKk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo+kHGKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EB91F00893;
	Tue, 22 Sep 2026 15:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092747;
	bh=1npNBKElnqzvdFUzf5GuDTs4gNM+NaTkobJl80+gdy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uo+kHGKkA0NqWSu8B6aZUwa0YqPiCYM+KWIv0t+kTz24HPoQuU7t4klF2L9Yrb80p
	 wEtqCarQlKY0bjCAnZSoKH9VyT4FoJaLPdTD4j6KIvIR9/4Uvaq44dMMm7ebJW8M+X
	 XOhkpBO8D3eSBxO4b2eUDfZqhtzjvNOMB7I/YIn7JRqD7tvGCJYxXc9EZ4gBnJNZnj
	 M4rDkKEd51S3BGGbz2cXJX3gzxdw13cyZyqH+uIkMoMG0Cv/lzonpHH9kpM55Jk/EZ
	 Rwjk1Uw2qHGXvEjiMJtzHhiFyOVa+rQ0WQW0EEKNMBo6eALvIQFFEjWt/5Q3xB499/
	 XIau9Ojy3EFFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext for-7.4] selftests/sched_ext: Fix rt_stall
 runner abort
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260922155037.17494-1-yphbchou0911@gmail.com>
References: <20260922155037.17494-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:59:06 +0000
Message-Id: <20260922155907.41EB91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/sched_ext: file descriptor leaks in error paths
--

commit bd4cf2003fa0e397ca084d4257a65e3f8e741ed8
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

selftests/sched_ext: Fix rt_stall runner abort

This commit drops the ksft_exit_fail() usage in rt_stall in favor of return=
ing
false, allowing the test runner to handle the failure. It also refactors the
cleanup paths to avoid leaving SCHED_FIFO tasks spinning on failure.

> diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing=
/selftests/sched_ext/rt_stall.c
> index a5041fc2e44fd..a1552b38a6e8c 100644
> --- a/tools/testing/selftests/sched_ext/rt_stall.c
> +++ b/tools/testing/selftests/sched_ext/rt_stall.c
[ ... ]
> @@ -151,13 +152,11 @@ static bool sched_stress_test(bool is_ext)
>  	float ext_runtime, rt_runtime, actual_ratio;
>  	int ext_pid, rt_pid;
>  	int ext_ready[2], rt_ready[2];
> -
> -	ksft_print_header();
> -	ksft_set_plan(1);
> +	bool ret =3D false;
> =20
>  	if (pipe(ext_ready) || pipe(rt_ready)) {
>  		perror("pipe");
> -		ksft_exit_fail();
> +		return false;
>  	}

[Severity: Medium]
If the first pipe creation succeeds but the second fails, does this early
return leak the ext_ready file descriptors?

[ ... ]
> @@ -172,7 +171,7 @@ static bool sched_stress_test(bool is_ext)
>  		exit(0);
>  	} else if (ext_pid < 0) {
>  		perror("fork task");
> -		ksft_exit_fail();
> +		return false;
>  	}

[Severity: Medium]
In the event that the first fork fails, is there a chance that all four
pipe file descriptors allocated earlier will be left open?

[ ... ]
> @@ -188,7 +187,7 @@ static bool sched_stress_test(bool is_ext)
>  		exit(0);
>  	} else if (rt_pid < 0) {
>  		perror("fork for RT task");
> -		ksft_exit_fail();
> +		goto out_kill_ext;
>  	}

[Severity: Medium]
Could jumping to out_kill_ext here cause the pipe file descriptors to be
leaked, since they aren't explicitly closed at that label?

[ ... ]
> @@ -199,45 +198,47 @@ static bool sched_stress_test(bool is_ext)
>  	 */
>  	close(ext_ready[1]);
>  	close(rt_ready[1]);
> -	wait_ready(ext_ready[0]);
> -	wait_ready(rt_ready[0]);
> +	if (!wait_ready(ext_ready[0]) || !wait_ready(rt_ready[0]))
> +		goto out_kill;

[Severity: Medium]
If wait_ready(ext_ready[0]) returns false, won't the short-circuit evaluati=
on
skip calling wait_ready(rt_ready[0])? Since wait_ready() handles closing
the file descriptor, this could leave rt_ready[0] open.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922155037.1749=
4-1-yphbchou0911@gmail.com?part=3D1
