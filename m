Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21953806B5
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264424; cv=none; b=Yk4vgJFXbT57tfRAQ+FH2Gv7xEpmkMePD+wKO5YXFo/PenWz7qHRBNid6ZwYWJjzPu7BKTaR1tVSR5Mqoaf7fu+ZG6R+TODRkhiN32xi6rXdwKqe/v7uTt9kP0Hp64+u7g678Ew8I+W8KlYKhCY9ZL1wkbvWIIVg5nMdw4iNULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264424; c=relaxed/simple;
	bh=NBQbEK+asSZHgocV8IIhhjil+/Q5UjnRJmCD2lZwoUs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aVRw88UabGVEa6F2TYD9v+hdVPbNkWGAhyJYCidI7ukLV/5IlGgpOrBAqOzL56C76RXd2ODhClRf5fOauu6XaY3YcfpicvKD7rL7HJfWJNB1OzMI6stvMX8IRPAnyjwjRjl/8LEip6OcXPOHL2ys/NGRySj3EMw27Kh5ARQ9SfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql7r8TF4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql7r8TF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1CAC2BCB0;
	Fri,  8 May 2026 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778264423;
	bh=NBQbEK+asSZHgocV8IIhhjil+/Q5UjnRJmCD2lZwoUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ql7r8TF4hzFhw6AXgaquL8nHR5tkWOwW5WpXNAMUP3Atdqx5/HeZgcysPr3q+ZoO3
	 4lge+v38iA7OvzKS4tnXwOlyRD8Gu55dMnEFnLfZ+QvfxZfFkFZHnSsjNe72m4thz3
	 bAxM45i5REUf43rv0XK+brZmzROzL179TErYBG2wCPw8B+y2CuEAIxdGos6VEaXyMG
	 Qb06c7su8a+HBhYgbLXiDYtDt693tnKEjqLybvg/EfKBM3k3bf6V/TE6gJ6wJ8BMb8
	 do6xmfVWOBLdtu8clDeNSwg8J7o4b0mUcWT41pYhfJkD45BRquxtlE2GHFsAxr4jwu
	 1MH731wt8enmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] selftests/sched_ext: Fix
 select_cpu_dfl link leak on early return
Reply-To: sashiko@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260508065514.1723906-1-yphbchou0911@gmail.com>
References: <20260508065514.1723906-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 18:20:19 +0000
Message-Id: <20260508182023.5D1CAC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Child processes are leaked as zombies if an early return occurs =
during the `waitpid()` loop, bypassing the cleanup guarantee the patch aims=
 to provide.
--

commit 804f29ba6f027f7b0b2d5d4230d76424d3576212
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

selftests/sched_ext: Fix select_cpu_dfl link leak on early return

This commit attempts to prevent a BPF link leak caused by early returns in
the run() function by moving the skeleton and link into a context struct
that is safely destroyed in cleanup().

> diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.c b/tools/t=
esting/selftests/sched_ext/select_cpu_dfl.c
> index 5b6e045e1109b..7e342c0cec653 100644
> --- a/tools/testing/selftests/sched_ext/select_cpu_dfl.c
> +++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.c
[ ... ]
> @@ -43,25 +59,31 @@ static enum scx_test_status run(void *ctx)
>  			sleep(1);
>  			exit(0);
>  		}
> +		if (pids[i] > 0)
> +			nforked++;
>  	}
> =20
>  	for (i =3D 0; i < NUM_CHILDREN; i++) {
> +		if (pids[i] <=3D 0)
> +			continue;
>  		SCX_EQ(waitpid(pids[i], &status, 0), pids[i]);
>  		SCX_EQ(status, 0);

Does this leave child processes as zombies if an early return occurs
during the wait loop?

If SCX_EQ() triggers an immediate return before the loop finishes, any
remaining successfully forked child processes will be abandoned. Since the
pids array remains stack-allocated in run() and is not part of the context
struct, cleanup() has no way to find and wait on them.

Should the child pid tracking also be moved into the context struct
so that cleanup() can reap or kill any remaining children?

>  	}
> =20
> -	SCX_ASSERT(!skel->bss->saw_local);
> -
> -	bpf_link__destroy(link);
> +	SCX_GT(nforked, 0);
> +	SCX_ASSERT(!tctx->skel->bss->saw_local);
> =20
>  	return SCX_TEST_PASS;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508065514.1723=
906-1-yphbchou0911@gmail.com?part=3D1
