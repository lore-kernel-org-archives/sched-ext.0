Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063BB225775
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 01:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303122; cv=none; b=jkf50Qmg/lpJ0zvotDg889/g3WDW1m9cKBTnOQ0HPYBYvKG16hgdo0Z2l2aRjOETR+1MzbrzlW+0dVU24rANE2haJFh+HxKgtEb415S4wDB4mWhLCGdte/lj/XVuhmSU8BgKK5OYYhsSaSuh0iwwvvGqhcHx1vMlkyvbleTeG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303122; c=relaxed/simple;
	bh=LprPqqwytlTmFKlbljijWbqSp5w4+gUEToPC4tFxMpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hXMoZRLvZ6J9gM3glINcZMp0Fc8BlHFReLu9vHjOfHOPAem4faEL1bX3yH7PFELK8JQHJehtx5RqSSL/G+7rL06eLIfmgzCYb6LeFBZTXApLUK0s+HJoUr3YiKhHEFrkOcxC/Gre4uDHZer2+wEYRZUbJ2JJku9EkrKTr0OaHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQkwp997; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQkwp997"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD561F000E9;
	Mon,  6 Jul 2026 01:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303120;
	bh=HX0QkHD9m5x4KrfeNonK8wicHptjNUVw/QZGmaLSzW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jQkwp997t+raU2iNTLOiDO8KxJo1HpyzG1GwHx99H8W/OkAdlInia6EY5SGl18kq1
	 0g/o+6lj02X4gVk3IHYipElh/gMTzvGkhDUsJsqxb52vY5HqqUItkvxvk2vGWsYden
	 JANMYp3sEv0JlYOzXBp7PzNmzw0Gk5+O6U5i4LRjMVzn8kGhIBMltbvlZEzDA8MXse
	 MWNyFIebk32HK8mdjRPjX/hIDoPV0sRMPbV9zzlsNATSXke0w8GeukgAm3HCKBXozH
	 Bh7mbqJ5dRSnXPdLLT78JOou6Dx9YUyEOTlYwyr4IbQfX+LmUNpFh4LcULV2mMofsC
	 vBylSEirI6Pug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 15/36] sched_ext: Add scx_cmask_ref
 for validated arena cmask access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-16-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-16-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 01:58:39 +0000
Message-Id: <20260706015840.5CD561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Non-atomic Read-Modify-Write in `scx_cmask_ref_or` and `scx_cmask_=
ref_copy` clobbers concurrent BPF updates to adjacent bits.
--

commit 1141e7d64b0f45ca499fc3944be4ed4e896ff3b8
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add scx_cmask_ref for validated arena cmask access

This commit introduces scx_cmask_ref to safely validate and access BPF
arena memory used for struct scx_cmask. It takes a snapshot of the base
and nr_cids to protect against concurrent BPF mutations, and provides bound=
ed
shard read and writeback functions like scx_cmask_ref_or() and
scx_cmask_ref_copy().

> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index 6a22bead4c601..42fc8348b3b4c 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c

[ ... ]

> @@ -669,6 +675,12 @@ static __always_inline bool cmask_word_op2(u64 *av, =
const u64 *bp, u64 mask,
>  		return (READ_ONCE(*bp) & ~READ_ONCE(*av)) & mask;
>  	case CMASK_OP2_INTERSECTS:
>  		return (READ_ONCE(*av) & READ_ONCE(*bp)) & mask;
> +	case CMASK_OP2_REF_OR:
> +		WRITE_ONCE(*av, READ_ONCE(*av) | (READ_ONCE(*bp) & mask));
> +		return false;
> +	case CMASK_OP2_REF_COPY:
> +		WRITE_ONCE(*av, (READ_ONCE(*av) & ~mask) | (READ_ONCE(*bp) & mask));

[Severity: High]
Does this non-atomic read-modify-write clobber concurrent BPF updates to
adjacent bits?

Since this code uses READ_ONCE() and WRITE_ONCE() but performs a
read-modify-write sequence, if a BPF program concurrently updates other bits
in the same 64-bit word (for example, using atomic bit operations), could
those updates be lost when this kernel thread writes back the modified word?

Would a cmpxchg loop or a proper atomic bitwise operation be necessary here
to prevent data loss under concurrency?

> +		return false;
>  	}
>  	unreachable();
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D15
