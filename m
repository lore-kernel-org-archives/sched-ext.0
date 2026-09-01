Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC164334BC
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276599; cv=none; b=Y1S0FDlgyJ02UV8vLd4NTeE/br0q+Hl6rspoqscC6vYDHgLpebnAGJUtppC8cCOF/cBeaub23BFwqUicz0RgBoTPgyNmrcillFBqOMOvoE+FD9WDGSf9cjdWSOkVwPZIIByToKsUDXT/CRlomW0PXLnh40qCRgW9ormw90aITPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276599; c=relaxed/simple;
	bh=X891DBvLHvGEGRZB3WBm5Av3Lqhz0Kfquc2qIHykYmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rHd3aWGLI8GPa8iFDj8PICbWXuwbdyhedatMWXFNSQufuMZe8kPbiNBkAH8rkXW3vMugNbSIluOzjmK920eMnJQpO+lCYIWxd/Ujv5HpAJkF0seNRyLcT/STy/+qL6y1BGP45RPOFidASDgVXtB6lrBfZveGZF3XPQhRwRc9UYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m43DKcOj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m43DKcOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9A61F00A3A;
	Tue,  1 Sep 2026 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788276597;
	bh=LF+x0eOnaKSLnkBXCcUutFUamQ6fYqfEUsjKGlwvKCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m43DKcOjWmPzdhfKfD77P/cO044wzGd4rZiK8bYwK6412jtVWf4yqfyaw5ycZUB7R
	 MhUm1PbHjWkgWJZwoAHXcQnJm1xTGa5vM5kOzrEooZIuXhPWnmyB7msD3onzN7nvdo
	 XEvNXar4jLWJ2FLK7NdwlDixem9Quz+dlyv2qkRa3WCLGc/pnwcmN0tWSKayzzNVGg
	 +TKGSBlXNoOkU+pmKmbegya+wWHC7EXy1kxNCboRp/ohZBcwNWdYcevpMUYLNxlJf6
	 V9n9tDeawbIaG9nH8CD/7Zz5ZSrlrzHvafrLAel8TmtDCVLRx/gWWjT2eO8UU/ixN/
	 8/80FpWJh8AIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Use atomic cpumask_clear_cpu in
 scx_idle_test_and_clear_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Blaszczyk" <michalblk@google.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260901152212.1691696-1-michalblk@google.com>
References: <20260901152212.1691696-1-michalblk@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 15:29:57 +0000
Message-Id: <20260901152957.BB9A61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch attempts to fix a data race on the locklessly shared `id=
le_smts` mask by replacing `__cpumask_clear_cpu()` with the atomic `cpumask=
_clear_cpu()`. However, the fix is incomplete because adjacent non-atomic r=
ead-modify-write operations (`cpumask_andnot()` and `cpumask_or()`) are sti=
ll performed on the exact same shared mask. Mixing atomic bitops and non-at=
omic whole-word operations on the same memory words allows the non-atomic o=
perations to silently clobber and lose the atomic updates.
--

commit f5e98ee81f9e1114c10e89759d2151f581c39afa
Author: Michal Blaszczyk <michalblk@google.com>

sched_ext: Use atomic cpumask_clear_cpu in scx_idle_test_and_clear_cpu()

In scx_idle_test_and_clear_cpu(), the shared idle_smts mask is modified
locklessly by concurrent CPUs. Currently, the code uses
__cpumask_clear_cpu() to clear a CPU from the mask. Because this is
a non-atomic read-modify-write operation, concurrent modifications to
different bits within the same memory word can lead to data races and
lost updates.

Fix this by replacing __cpumask_clear_cpu() with the atomic
cpumask_clear_cpu().

> diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
> index 6f93cc32b650e..7be0b5d189cdc 100644
> --- a/kernel/sched/ext/idle.c
> +++ b/kernel/sched/ext/idle.c
> @@ -103,7 +103,7 @@ static bool scx_idle_test_and_clear_cpu(int cpu)
>  		if (cpumask_intersects(smt, idle_smts))
>  			cpumask_andnot(idle_smts, idle_smts, smt);
>  		else if (cpumask_test_cpu(cpu, idle_smts))
> -			__cpumask_clear_cpu(cpu, idle_smts);
> +			cpumask_clear_cpu(cpu, idle_smts);

[Severity: High]
This is a pre-existing issue, but does the adjacent non-atomic operation de=
feat
the purpose of the patch's atomic fix?

If CPU A locklessly updates idle_smts using non-atomic bulk operations like
cpumask_andnot() here, or cpumask_or() in update_builtin_idle(), it reads t=
he
whole memory word into a register.

If CPU B concurrently executes the atomic cpumask_clear_cpu() introduced by
this patch, CPU A will then write its register back to memory, silently
overwriting and discarding CPU B's atomic clear.

Could this lead to lost updates to the shared idle_smts mask, potentially
causing scx_pick_idle_cpu() to get caught in an infinite loop as mentioned =
in
the code comments?

>  	}
> =20
>  	return cpumask_test_and_clear_cpu(cpu, idle_cpus);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901152212.1691=
696-1-michalblk@google.com?part=3D1
