Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D544375AB8
	for <sched-ext@lists.linux.dev>; Wed,  3 Jun 2026 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508488; cv=none; b=f19q22Aem8oQoq6VLEvdsQgib9jCtTUOVhb3eL8oV5GKuweTf5eaMMgoU/NW1KBLvSlENZ2cWrABwEqFDfiE2CFu2txyR74sfwIDM7QsYC2gq0woI7oRw0OO69rZMNei2lcIQbCVicD+HvmKEIJM9ZXZbXRtpbedzIhGNCP0PhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508488; c=relaxed/simple;
	bh=lM2lubi0Bz/HIZnUh39a9SrtDEjbUTuXdry7cAzwscA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HjwsOWOy2vZWh48ldRtCf+muSf3OdbsbYp05Cp0pMgoSikLn9I2DmR5lvY3H28INQuwfPELTPYLZKRnJNHlI9PahUBCEhcpQhJJvjXlnf/kdRxt4DU/O+qYvHRdITnP1F5IhW3nuZA0RD2yk130U3xUHPUXmhzcbOf81/fAK0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7BKn/OO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7BKn/OO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0679E1F00893;
	Wed,  3 Jun 2026 17:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780508487;
	bh=VkxzLApeGau2d/TfvUmKObmBCjIVICXYDNtb1uluVZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7BKn/OO1dNPtBDmI919tTlXD/U2NfHSHU/vDshIBAOS9lDRVYLKEZwkCXu1l6LKT
	 bV8gdaJ3KwVoNpwxWZ8Es0N0UlcnseebtAZG6bNkw2D4DLMFxPqcBlFRiO9YFzNAo2
	 h7UsfdG1TH/onE5/bP9FFX0XM5oIodSG/DHq7QzOqR3wG+/piCELSbM3ahAt9e0E1h
	 ZmU9w/0+PTIH55AvZTn51UGwYzk6XrMll7aZg+eOxVj/9A2fqfU5AYiHxoDp1PivnF
	 7kk6c00ZTcKd7XiOtdR2/x9RhfHzENOdmGYkWIuyzOYXSeq/KQ6XsmVGJxfgi7uhM3
	 fX1BPfmfMdLcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Add scx_cmask_test() and
 scx_cmask_for_each_cid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260603172153.3081861-3-tj@kernel.org>
References: <20260603172153.3081861-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 17:41:26 +0000
Message-Id: <20260603174127.0679E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] scx_cmask_for_each_cid yields out-of-bounds phantom CIDs due to an=
 overestimated loop bound and stale padding words.
--

commit edd3ffa1eb6aa37c70fee16c5770f542f1484a83
Author: Tejun Heo <tj@kernel.org>
Subject: sched_ext: Add scx_cmask_test() and scx_cmask_for_each_cid()

Add single-bit test and iterator over set cids in an scx_cmask.

> diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
> index abea22ba2cc25..d4c3ebba74162 100644
> --- a/kernel/sched/ext_cid.h
> +++ b/kernel/sched/ext_cid.h

[ ... ]

> @@ -218,11 +218,42 @@ static inline void scx_cmask_reframe(struct scx_cma=
sk *m, u32 base, u32 nr_cids)
>  	m->nr_cids =3D nr_cids;
>  }
> =20
> -static inline void __scx_cmask_set(struct scx_cmask *m, u32 cid)
> +static inline void __scx_cmask_set(u32 cid, struct scx_cmask *m)
>  {
> -	if (!__scx_cmask_contains(m, cid))
> +	if (!__scx_cmask_contains(cid, m))
>  		return;
> -	*__scx_cmask_word(m, cid) |=3D BIT_U64(cid & 63);
> +	*__scx_cmask_word(cid, m) |=3D BIT_U64(cid & 63);
>  }
> =20
> +/**
> + * scx_cmask_test - test whether @cid is set in @m
> + * @cid: cid to test
> + * @m: cmask to test
> + *
> + * Return %false if @cid is outside @m's active range. Otherwise return =
the
> + * bit's value. Read via READ_ONCE so callers can race set/clear writers.
> + */
> +static inline bool scx_cmask_test(u32 cid, const struct scx_cmask *m)
> +{
> +	if (!__scx_cmask_contains(cid, m))
> +		return false;
> +	return READ_ONCE(*__scx_cmask_word(cid, m)) & BIT_U64(cid & 63);
> +}
> +
> +/**
> + * scx_cmask_for_each_cid - iterate set cids in @m
> + * @cid: s32 loop var that receives each set cid in turn
> + * @m: cmask to iterate
> + *
> + * Visits set bits within @m's active range in ascending order. Relies o=
n the
> + * head/tail-zero invariant of bits[], so no per-cid range check is need=
ed.
> + */
> +#define scx_cmask_for_each_cid(cid, m)						\
> +	for (u64 __bs =3D (m)->base & ~63u, __wi =3D 0,				\
> +		     __nw =3D SCX_CMASK_NR_WORDS((m)->nr_cids);			\
> +	     __wi < __nw; __wi++)						\
> +		for (u64 __w =3D READ_ONCE((m)->bits[__wi]);			\
> +		     __w && ((cid) =3D __bs + __wi * 64 + __ffs64(__w), true);	\
> +		     __w &=3D __w - 1)
> +
>  #endif /* _KERNEL_SCHED_EXT_CID_H */

[Severity: High]
Does this iterator yield phantom CIDs outside of the mask's active range?

Since SCX_CMASK_NR_WORDS() overestimates worst-case capacity (e.g. for
nr_cids=3D1, it evaluates to 2), __nw will be larger than necessary. The
iterator lacks a strict cid < base + nr_cids bound check to compensate.

When scx_cmask_reframe() shrinks a mask, it clears only m->bits[0] and
m->bits[last_word]:

kernel/sched/ext_cid.h:scx_cmask_reframe() {
        if (nr_cids) {
                u32 last_word =3D ((base & 63) + nr_cids - 1) / 64;

                m->bits[0] =3D 0;
                m->bits[last_word] =3D 0;
        }
        ...
}

Any words beyond last_word remain uncleared. If a mask is reframed to a
smaller size (like nr_cids=3D1), SCX_CMASK_NR_WORDS(1) is 2, so the loop bo=
und
__nw is 2. The iterator will process the stale, uncleared bits in m->bits[1=
],
yielding CIDs outside the active range.

Similarly, if nr_cids is 0, scx_cmask_reframe() skips clearing entirely, but
SCX_CMASK_NR_WORDS(0) is 1. The iterator will traverse m->bits[0] and yield
CIDs for an empty mask.

Is a strict boundary check inside the loop needed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603172153.3081=
861-1-tj@kernel.org?part=3D2
