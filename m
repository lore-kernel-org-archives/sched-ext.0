Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4F5FDA7
	for <sched-ext@lists.linux.dev>; Sat,  1 Aug 2026 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574690; cv=none; b=QidMvMBWPNoA+WjtEb7kh2YqornhQC1yajA+vjyU9jp231NJyEKGHGN98oUWsvtUJSbrlZyBkysBizZZLK4ZrkNUPn/AAsTQ6ERiXqEj2vrRZDnJtihmnmC2VNzRySjTIZdDTHxiKkb7S5P0x0Nvfay2ZUZUGvpOZx+UrSK+hRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574690; c=relaxed/simple;
	bh=zJN3Ljb+GeyiS9at55cJbv7TspBnL4YfwWBhA4Z3caA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YV+iTI2LYKh743YJ1p0NIpTC8XmTl7h8YE8yJwpfXuihqN1lEhlW1/AHjtD5KiOYS+MJa0+jot9BFzubxGTlETq9hC4YASGi4jO7VKZA45VlhwDQVMSgcrDpKY9fGcSP9Ckgw937Q+K7MHA82t6cLbale0UVNXNjSySJAzSBL6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgfXlQkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgfXlQkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE2B1F00AC4;
	Sat,  1 Aug 2026 08:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574688;
	bh=V97t3PNvdwdE/LDagdYw8WglqlWr5NGYN1KuYzgsJMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VgfXlQkz/e2NqEK45Nwj/BfqHXGPay467w5Lwn10SUuMAbakkEreE/SkL4qdn1pwC
	 dMByT6iU64goi7F1NRpQhd8Up+6IXAdfne/q+w+gBBwEqhmRnLyOm1ZsBYeaW3Nvt+
	 ql1dm248ySNKk1FXSdfTmoB2CQQ/bdALds5/0qBkO+RnPpxjYpXRiIVh9ItFZaiTsc
	 /B2bCSCLCOR+dS+5u6BOw+wXvq2lrc0uUyV8yiDCnJo/IDmJKn1tpcMFTf3NhjcKmB
	 8HaGTXjyxFeS0si+0C+SDhnVRTwJ0/TWGJFQyKkwnoyTbyHliAgOjoW/Vrf+TuZCFe
	 qUI/65Tm3P4RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] sched_ext: Make several ext.c helpers available
 outside ext.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260801085150.2697653-3-tj@kernel.org>
References: <20260801085150.2697653-1-tj@kernel.org>
 <20260801085150.2697653-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 08:58:08 +0000
Message-Id: <20260801085808.AEE2B1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unconditional definition of `scx_sched_all` lacks a prototype when =
`CONFIG_EXT_SUB_SCHED` is disabled, causing a build warning.
--

--- Patch [2]: [PATCH 02/12] sched_ext: Make several ext.c helpers availabl=
e outside ext.c ---
commit 2fbc86143bb66368e04e606cb09e7ffe2b987b3d
Author: Tejun Heo <tj@kernel.org>

sched_ext: Make several ext.c helpers available outside ext.c

This commit exposes several helper functions and the scx_sched_all list
by removing their static keywords and adding declarations in internal.h.
This allows them to be utilized outside of ext.c.

> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -38,7 +38,7 @@ struct scx_sched __rcu *scx_root;
>   * All scheds, writers must hold both scx_enable_mutex and scx_sched_loc=
k.
>   * Readers can hold either or rcu_read_lock().
>   */
> -static LIST_HEAD(scx_sched_all);
> +LIST_HEAD(scx_sched_all);

[ ... ]

> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -2014,6 +2021,7 @@ extern bool scx_cgroup_enabled;
>  #ifdef CONFIG_EXT_SUB_SCHED
>  extern const struct rhashtable_params scx_sched_hash_params;
>  extern struct rhashtable scx_sched_hash;
> +extern struct list_head scx_sched_all;

[Severity: Low]
Will this trigger a missing prototype warning when CONFIG_EXT_SUB_SCHED is
disabled?

Because scx_sched_all is defined unconditionally in ext.c, building the
kernel without CONFIG_EXT_SUB_SCHED hides this extern declaration in
internal.h from the compiler.=20

Should this declaration be moved outside of the ifdef block to prevent
compiler or sparse warnings?

>  extern struct scx_sched *scx_enabling_sub_sched;
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801085150.2697=
653-1-tj@kernel.org?part=3D2
