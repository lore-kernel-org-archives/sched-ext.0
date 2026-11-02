Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605878;
	b=rU5LCF6/QihfcGRvJdq2p104Wg0cCOnmCdk6Vqb28AeRP0QpMp5ah7wZqHha7iG56WBS
	 wL6vdUbM6HFDv9p6Kj+A+gZOIaNWjcNEDpBGWvNTLzAzfGTboLjdRJr5vFRs5p0o5rgMw
	 tnrKf5DswJ3y4S4fhUpcP2iWcjrajWI6UGQb8JpbqVHob/X/IVDBu2hFyG6xynIITdeqJ
	 HM+gtnFXlYYTiNUKRUP8nXmHHQh1Nao9CpZT1bG/6Dqau3CdYsoYWLArSdF8Ddm/AoVFr
	 L+eooaB+8YSrUz7uNW/gZy+tm+//1Y+kfjoYRBU+Fine/Ocmb+MAnDwx9D9vJZIGYHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=qFmWwE/MyJZ42ZQHTeVUHFZv3R+Of1XsGPpIbsWFJaI=;
	b=dNMnPAtd3rmeMW6l/NV8gUpp5ey8CSqbkVO9q2gPqvp3XhsbKU48BXmPAQsk48VVRa/X
	 bG38XHbTqsQD6Sfth78ws+bdn4xloSChE/scVtky0O22UK42l/vf6JqSYD1eJjnNNXGna
	 Ho1pE7AthA2KEARVlS4bTV327ccayEJtt5Nc4aCrYfBg4bgz3QhNrc39+vLVa1GHCxH7q
	 KkS8TdsqeXx5eDr52SBFiqaojI13BCJ0ClFmfELJBRkGPYOdWLWoTVVdo6MawBiKiMakq
	 Yptawjn2O4vJIhhFZgehuf3+96iHP9BYzT6LTPh9jYSmOc10EItNgC0bc14QLZvpbdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=DcptVNnG;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C7606A329
	for <sched-ext@lists.linux.dev>; Mon,  2 Nov 2026 07:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 302C7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=DcptVNnG
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-89ff475a152so788723b3a.3
        for <sched-ext@lists.linux.dev>; Sun, 01 Nov 2026 23:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793605877; x=1794210677; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qFmWwE/MyJZ42ZQHTeVUHFZv3R+Of1XsGPpIbsWFJaI=;
        b=DcptVNnGQ5NU0L5DMWMm5Esl+WA744MJUSWErPeEVQhL6xGWYffW0ZPXR+2iXLVmDc
         X+hEpChHJO/zFX9wWhfMTC7VUlrukcCW0V5CWCuiaSaIacpmaG/EZ8mTVBT3O4LMd4Tc
         mMZjBpzQ+KULYbvmzBVRHraBeNDaVSIgMtaq0gwyDob5ED2Q3SVGeuNW6cfp28HgHHHz
         /7veU0+tmN1tetUvN6YkzyvumfMi6zux0SCMCt/ht11u9o2MY3pRI4t2fC32qkyhfovS
         xp+5nqneiXjdaSnzhJM9F0ZnF0Pjh3lAJsZ1/i/P4e4eO4ACTjvuYwHZbpEOWZJBGN4/
         gF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793605877; x=1794210677;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qFmWwE/MyJZ42ZQHTeVUHFZv3R+Of1XsGPpIbsWFJaI=;
        b=atFhaIg5xe+MwFyMWs8CgqJLkxY18FKtkmSjmrlAbZUnY7c54TEHWoFopSmIL7V/69
         xTsKMag55J5WyPH1119hFKrl1Fq0oMyE6mBCo0YncNds0nLiGT1YfkdRx4RFMJBJwHBc
         fn6wbSfyeiYSdPYmG+Rf1xb8TV8gj+9wg/6vfM+tmZRxpJoXC/4ahlw/BoBozXBC4PYe
         zX/9dME4T12sP/SfpqCkY8CI20CZOShIonkOaAvA2RIUs3b+88gbuTHWYUpMq2WOVbej
         tZACpsezqENmvdwe6HabVi3UNliJcsPzEOTudpFYlgga5ZZopDZyzD/K0Y8sAYXO1UZf
         JcOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCKNwaRdFJAdxujdk/3fxPFcEohPlIX96kjroUXuJHF+n6FzyQSolQp7muW7EHQ279xzCWoPk3/CQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYLUxY29ciqhmQZqAuOn4FBVSD9pq+FYCOh9ilhn5I0XdUe1/JzW
	mVOHPRlsGlZSLH1j0urYtti7lwwzI3wI3tzH0C3cEf4MmGDIGqxmzIrMy3NKNRg5S/Y=
X-Gm-Gg: AYBFou01mPcCLlnE+PFpQmjwJp2WfPq1Z9G9JdfUm8ehOCKyTiQ6kVQ/wCoF796JSVo
	HXgpodd3NsdVUgqBLW8EQTcKPIbWpofjtJUfZW1cRo5wis+1kP20/Ibg9Zae/raMS5SJDwHWhWa
	WDzeFegvIr5aqNvLHlAKKM6I9w3HT0kjh8YbLOvmKkARuIAHsnyj9sJeFLxJbq3IB11OHiz6z5Z
	liqsEJC8ClTUwGTlL/9p9kGSvbvFpveC2UzXZl9D+fFGkgGMvtmRwFYrB86pp2LG8Iv+XBMl2AO
	GEnck4qTFu1av5VF7LpK5xNRx5bIYz6NzRJ34zHkS190fOwNn+N8DV+g8j1aGjWqyKzzBDJeFRn
	mW5v33twefhJJ3xErZT4lI3W/J3y7WIc1r4i1ZJZI1BAbOlpAYMotfwER5nLjQhiwMFfo1t+4ov
	Zaqer8vaZIElGfp7FQW6NhLjJFYnrhh0Af26pZ48TmcbvLiDwuxQDGMcF60D7GsDsA4aeGfiiu9
	CMOxiG5bqpbHTOvIxBl5/2jrgLrZ0mMWfalE2ZJHH37jbj5+02M2eRpcgerUaTwdcqXmxeKV3Hj
	pK1rfUyvwYsAyNTnTlu8YJ7u28R1RP8N9ioBMOUPEQY9YlgS/xRQRLUFUA==
X-Received: by 2002:a05:6a00:4f8c:b0:874:705d:f63e with SMTP id d2e1a72fcca58-8a9bf0472a8mr7293625b3a.32.1793605877437;
        Sun, 01 Nov 2026 23:51:17 -0800 (PST)
Received: from localhost (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d047d2sm1658546b3a.25.2026.11.01.23.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 23:51:17 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 07:51:16 +0000
Message-Id: <DMKK7WGBASS7.2VBQTIIX6YEGS@etsalapatis.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, <david.dai@linux.dev>, "Gavin
 Guo" <gavinguo@igalia.com>, <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-dev@igalia.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: libarena: Order equal
 rbtree keys FIFO
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Changwoo Min" <changwoo@igalia.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Shuah Khan"
 <shuah@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20261028060046.549097-1-changwoo@igalia.com>
 <20261028060046.549097-2-changwoo@igalia.com>
In-Reply-To: <20261028060046.549097-2-changwoo@igalia.com>

On Wed Oct 28, 2026 at 6:00 AM UTC, Changwoo Min wrote:
> An RB_DUPLICATE tree links a new key to the left of an equal one, so
> rb_least() and rb_pop() return the newest of several equal keys. A
> queue of tasks keyed by vtime should instead serve equal keys in
> arrival order, as sched_ext's vtime-ordered DSQs do.
>
> Send equal keys right on insert, as the kernel's rb_add() does. A new
> node then lands after every node with an equal key. Rotations and
> removals preserve the in-order sequence, so equal keys stay in
> insertion order without a tie-break field.
>
> Add a selftest that interleaves equal keys while the tree grows and
> checks the pop order.
>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Hi Changwoo,

  Patch looks fine to me, one nit below.

> ---
>  .../bpf/libarena/include/libarena/rbtree.h    |  6 +--
>  .../bpf/libarena/selftests/test_rbtree.bpf.c  | 37 +++++++++++++++++++
>  .../selftests/bpf/libarena/src/rbtree.bpf.c   | 16 +++++---
>  3 files changed, 51 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree=
.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> index 486428911d96..00e63b12d82e 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> @@ -45,9 +45,9 @@ enum rbtree_alloc {
>   * the existing node.
>   *
>   * RB_DUPLICATE: Allow nodes with identical keys in the rbtree.
> - * Finding/popping/removing a key acts on any of the nodes
> - * with the appropriate key - there is no ordering by time
> - * of insertion.
> + * Nodes with identical keys are kept in insertion order, so
> + * rb_least() and rb_pop() return the oldest of them. Finding
> + * or removing by key acts on any of them.
>   */
>  enum rbtree_insert_mode {
>  	RB_DEFAULT,
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.b=
pf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> index 856c484a009a..1e2a0fac1e4f 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> @@ -248,6 +248,43 @@ __weak int test_rbtree_duplicate(void)
>  	return rb_destroy(rbtree);
>  }
> =20
> +#define FIFO_NR_NODES	64
> +#define FIFO_NR_KEYS	4
> +
> +SEC("syscall")
> +__weak int test_rbtree_duplicate_fifo(void)
> +{
> +	const u64 per_key =3D FIFO_NR_NODES / FIFO_NR_KEYS;
> +	struct rbtree __arena *rbtree;
> +	u64 key, value;
> +	int ret, i;
> +
> +	rbtree =3D rb_create(RB_ALLOC, RB_DUPLICATE);
> +	if (!rbtree)
> +		return 1;
> +
> +	for (i =3D 0; i < FIFO_NR_NODES && can_loop; i++) {
> +		ret =3D rb_insert(rbtree, i % FIFO_NR_KEYS, i);
> +		if (ret)
> +			return 2;
> +	}
> +
> +	for (i =3D 0; i < FIFO_NR_NODES && can_loop; i++) {
> +		ret =3D rb_pop(rbtree, &key, &value);
> +		if (ret)
> +			return 3;
> +
> +		/* All of key 0 in insertion order, then all of key 1, ... */
> +		if (key !=3D i / per_key)
> +			return 4;
> +
> +		if (value !=3D key + FIFO_NR_KEYS * (i % per_key))
> +			return 5;
> +	}
> +
> +	return rb_destroy(rbtree);
> +}
> +
>  static inline int
>  clean_up_noalloc_tree(struct rbtree __arena *rbtree)
>  {
> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> index 7f0f6dc3e17d..e6c9430f734b 100644
> --- a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> @@ -161,8 +161,14 @@ struct rbnode __arena *rbnode_find(struct rbnode __a=
rena *subtree, u64 key)
>  	return node;
>  }
> =20
> +/*
> + * Find the node to link @key under. Smaller keys go left and everything=
 else
> + * right, so a new key lands after every node with an equal key and equa=
l keys
> + * stay in insertion order. Rotations and removals preserve the in-order
> + * sequence, so they keep that order too.
> + */

I think this description is more harm than good let's remove it. Can we als=
o keep the
old name? The new one sounds like we're inserting a parent.

>  static
> -struct rbnode __arena *rbnode_least_upper_bound(struct rbnode __arena *s=
ubtree, uint64_t key)
> +struct rbnode __arena *rbnode_insert_parent(struct rbnode __arena *subtr=
ee, uint64_t key)
>  {
>  	struct rbnode __arena *node =3D subtree;
>  	int dir;
> @@ -171,7 +177,7 @@ struct rbnode __arena *rbnode_least_upper_bound(struc=
t rbnode __arena *subtree,
>  		return NULL;
> =20
>  	while (can_loop) {
> -		dir =3D (key <=3D node->key) ? 0 : 1;
> +		dir =3D (key < node->key) ? 0 : 1;
> =20
>  		if (!node->child[dir])
>  			break;
> @@ -255,7 +261,7 @@ int rb_node_insert(struct rbtree __arena *rbtree,
>  	if (rbtree->insert !=3D RB_DUPLICATE)
>  		parent =3D rbnode_find(parent, key);
>  	else
> -		parent =3D rbnode_least_upper_bound(parent, key);
> +		parent =3D rbnode_insert_parent(parent, key);
> =20
>  	if (key =3D=3D parent->key && rbtree->insert !=3D RB_DUPLICATE) {
>  		if (rbtree->insert =3D=3D RB_UPDATE) {
> @@ -278,8 +284,8 @@ int rb_node_insert(struct rbtree __arena *rbtree,
>  	}
> =20
>  	node->parent =3D parent;
> -	/* Also works if key =3D=3D parent->key. */
> -	if (key <=3D parent->key)
> +	/* An equal key goes right, after the existing ones. */
> +	if (key < parent->key)
>  		parent->left =3D node;
>  	else
>  		parent->right =3D node;

