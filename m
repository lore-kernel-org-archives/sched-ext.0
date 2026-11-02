Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606829;
	b=eKmQwEArH0h5+nXHzXZFgJwBUlbST+1Y1KLJ2GACZz7GseqLPvemUNo//gKnRUSuJ2Q/
	 YRbCVstRAgbpo+yMe/P2/3mks44NN04Wjaz4aglbE2CXzSFZuSoaMVGKU+bQbPtKBUhh6
	 t6LdOTGWDx/QunEsSs2++E9A56XJ6RzvXvFYD8vP5rdFww4m2Q9v9D4XYMiInW8rR943a
	 ezFqCJBMKmJmjuHpANUPK5veYvH9AM+beuESsQmlHD4kqvxkWWQEOj84C9qwuJvqW52xS
	 +Gqi9yAiTp3iIyncCVWASpkRnL1PyZvaaUsBHBrxjU34Qo67y+HCsc4olJ5bFUihN+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=ZFKEz2Iu0aOPt9Nq3i/pKYGCNKHVigLA2BmD6KDbRRo=;
	b=Vo6kUSKy4S+Xfy1bVs7EIfN+uS8qeFWNQ0w6+ZKjGcBBepdQSpZ3NinlXfzI0sF/saVR
	 158whGme5x3Rlz5VlX1LRuOaZloZYCzRTWPxIlXdjl9xQ/tIKm+49nvVoCB8xSW0RN1kA
	 QDFx+xk8uhjjHw20j6WawIh7bCBsPpljcfLx37R/hTfGkndPx5M873bUmO0pVJtheK+EA
	 ytevT9DxqmRkuPkhJ/0DdElKSkf4sJkEjWJvdSzo73qbqvHGQUo2RylSrM2UTgtvatt3+
	 7tSa3XSwn5euKboSQwqi/CFAuw79Mk0ERhH2WpQzqL4LoWaQ5e68ZhO+Pdj4J/Sua6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=0v3lotcn;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6E1606A324
	for <sched-ext@lists.linux.dev>; Mon,  2 Nov 2026 08:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA6E1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=0v3lotcn
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ea7987517aso18049555ad.0
        for <sched-ext@lists.linux.dev>; Mon, 02 Nov 2026 00:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793606828; x=1794211628; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZFKEz2Iu0aOPt9Nq3i/pKYGCNKHVigLA2BmD6KDbRRo=;
        b=0v3lotcnujO4i1qS6BRjOKTKAdQlsCQ3zJlDtNnKP/blJlSp39wE7MJB1wgbikRqdg
         ToXbqTrzMUvGW+8dPuC3TNEA27wWXw63fQ2F0DW3uHuc0rJ7ob7bZfUAYXiiOeOmTlWx
         /piue8DuR7Mre7wNFmwk27C2wAVaSjlNEYPt8HYfwN2/bfrYPuwtrSFN4Z2mhVw3medX
         8S+61Kwm5gJzGoM8fAMPTP1vR2ID2BYT9IgxGBmOdaeoYmFh3wJXpaE4F2IDGcZstlUH
         NkQjSygN7PJlBr7E0Rm89robikpiSQWrKLY9JuNR4fLVKPJtSe+bJIOwQ55AWTrJdRc1
         zjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793606828; x=1794211628;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFKEz2Iu0aOPt9Nq3i/pKYGCNKHVigLA2BmD6KDbRRo=;
        b=MwVCjH6mPJ8Fo40QvFrptW5pZkSNE1LobnRw5knPyH0xqYVhnwRovKBusgiEJciM3y
         oD6KqcXrPc7ah+TplEh/6OwSVA5PRYz6/p/+A7h074y+X8VFvI3ZR8+OW8agIigYO4Su
         PbGW3WiAiqg2zXeKYV4jXnafNyvnxMDiBWSyBb0mXerKuMkdh5xh5kW3wqCmB0Wl+QmH
         PhJdOwlqCJ9GwnmM6pi9z/RvwL5feAVwnVODjPMn+Beo0OpmfvvphdIPZVbXs9mQ00cp
         GGIBj2BIh5wOF9AqLMa3j/t1awDfd/3UyIGBh9psZPnElfmj7UhXFv9VjhdGVhtNX5MO
         MluQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSnTVwGlasOcAkjohfdooekMQI/vWAxpWmLSpgfc9YNuobRzVOAl24RPgHaYr2wvfHwFcQvwZdBxI=@lists.linux.dev
X-Gm-Message-State: APuU4Z/QNXZkGzwK4cvuQWypT2K0FpdcmjWCc/s4Axs6N55aN0jIUgsU
	ynypazuuKWprN8meKXoTbsV3e5ak3c+8X37Oe/414ZmJQCb8V7q3U/fjXmiB5RYtZ+M=
X-Gm-Gg: AYBFou3nk/AxqjlX0q3SIqTQjPheFAL0lLhXznIQHkkKSv7m2XcJlpXsSIXNAs5pEuw
	VE97xZU9V2csDT1wy8NKqxPgaHjp5K6TyV/4Xr92MPNZqWXkD2iI6CzCZZwEWuZGp/sfPZ+dZIl
	nMdY4tOonrB4econycJIDZBEivE2PTB50LJgUSZDYCbPRX8lBfB1R74jAIHA1whLo89JzzlTHE3
	Hx+n5Uwq8af+syVmx+M/Z7gtqSnkOZAPfgp9RMhL0Mu5a1nruDL6u3vNjaxjy80fjTsK2DLc2Ka
	v4RD7BlMV/PrqsMfPsCriJM1h1+I4Ssi9jndNXSIpq/whiWwxRpDaU3Vkgk01PLM7ZLX6OHUfhp
	wveCYy7oD48jGMlD5KiCK5etmPknCaP+5iQA8j7HrpykDRhYJZauzwbXro7gxA3gM1nfLZ5n1nV
	DwGu9LTtSrYcWzJv3PazD2JZGodTGO+xG3pmnt5CFNOpIp9v7x+16RhrOX0/zyoEKus/CW+7m6G
	pF98tIGU4NhdYGf+t+ff+YP2bw2ZW5OvKIj3gcdZRWHJBvMlI4VOj5aD354feThuQiznLWcxiAy
	Z6ftiP5fpj/xcozBKsP0rs6NiUgqyYsVla9fuKIn2Kr/cXDRTfSSR2/+9yR61Mmv+ARrajoxiQ5
	8WTI3
X-Received: by 2002:a17:902:eccb:b0:2e5:d2b1:c70b with SMTP id d9443c01a7336-2eb36536d3amr90256725ad.60.1793606827873;
        Mon, 02 Nov 2026 00:07:07 -0800 (PST)
Received: from localhost (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39265090sm23623165ad.41.2026.11.02.00.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 00:07:07 -0800 (PST)
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
Date: Mon, 02 Nov 2026 08:07:06 +0000
Message-Id: <DMKKK0ZLYSKU.3UZ614ZC9DH05@etsalapatis.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, <david.dai@linux.dev>, "Gavin
 Guo" <gavinguo@igalia.com>, <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-dev@igalia.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: libarena: Add rb_next()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Changwoo Min" <changwoo@igalia.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Shuah Khan"
 <shuah@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20261028060046.549097-1-changwoo@igalia.com>
 <20261028060046.549097-4-changwoo@igalia.com>
In-Reply-To: <20261028060046.549097-4-changwoo@igalia.com>

On Wed Oct 28, 2026 at 6:00 AM UTC, Changwoo Min wrote:
> Add rb_next(), the in-order successor through parent pointers.
>
> Add a selftest that walks a tree with repeated keys and checks the walk
> against the order in which the head leaves the tree.
>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  .../bpf/libarena/include/libarena/rbtree.h    | 23 ++++++++
>  .../bpf/libarena/selftests/test_rbtree.bpf.c  | 54 +++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree=
.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> index a8dd8c2e7596..956b4a24b52a 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> @@ -103,6 +103,29 @@ void rb_node_free(struct rbnode __arena *rbnode);
> =20
>  int rb_integrity_check(struct rbtree __arena *rbtree);
> =20
> +/*
> + * Return the in-order successor of @node, or NULL if @node is the last =
one.
> + * Walking from rb_first() with it visits the tree in key order, equal k=
eys in
> + * insertion order. Call it under the writer's lock.
> + */

Let's move this to the main *.bpf.c file, with the rest of the traversal fu=
nctions.

> +static __always_inline struct rbnode __arena *rb_next(struct rbnode __ar=
ena *node)
> +{
> +	struct rbnode __arena *parent;
> +
> +	if (node->right) {
> +		node =3D node->right;
> +		while (node->left && can_loop)
> +			node =3D node->left;
> +		return node;
> +	}
> +
> +	/* Climb until we leave a left subtree; its parent comes next. */
> +	while ((parent =3D node->parent) && node =3D=3D parent->right && can_lo=
op)
> +		node =3D parent;
> +
> +	return parent;
> +}
> +
>  /*
>   * Lockless reads of the head and the node count. They need not be calle=
d
>   * under the writer's lock, so they are advisory: the tree may change be=
fore
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.b=
pf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> index 57c4395c046a..784cc9edea17 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> @@ -425,6 +425,60 @@ __weak int test_rbtree_first_update(void)
>  	return rb_destroy(rbtree);
>  }
> =20
> +#define NEXT_NR_NODES	64
> +
> +static struct rbnode __arena *next_nodes[NEXT_NR_NODES];
> +
> +SEC("syscall")
> +__weak int test_rbtree_next(void)
> +{
> +	struct rbtree __arena *rbtree;
> +	struct rbnode __arena *node;
> +	u64 seed =3D 0xcafe;
> +	int i;
> +
> +	rbtree =3D rb_create(RB_NOALLOC, RB_DUPLICATE);
> +	if (!rbtree)
> +		return 1;
> +
> +	/* Pseudo-random keys with repeats, so the walk crosses equal keys. */
> +	for (i =3D 0; i < NEXT_NR_NODES && can_loop; i++) {
> +		/* LCG using Knuth's MMIX constants for determinism. */
> +		seed =3D seed * 6364136223846793005ULL + 1442695040888963407ULL;
> +		node =3D rb_node_alloc((seed >> 33) % 16, i);
> +		if (!node)
> +			return 2;
> +
> +		if (rb_insert_node(rbtree, node))
> +			return 3;
> +	}
> +
> +	node =3D rb_first(rbtree);
> +	for (i =3D 0; i < NEXT_NR_NODES && can_loop; i++) {
> +		if (!node)
> +			return 4;
> +
> +		next_nodes[i] =3D node;
> +		node =3D rb_next(node);
> +	}
> +
> +	if (node)
> +		return 5;
> +
> +	for (i =3D 0; i < NEXT_NR_NODES && can_loop; i++) {
> +		node =3D rb_first(rbtree);
> +		if (node !=3D next_nodes[i])
> +			return 6;
> +
> +		if (rb_remove_node(rbtree, node))
> +			return 7;
> +
> +		rb_node_free(node);
> +	}
> +
> +	return rb_destroy(rbtree);
> +}
> +
>  struct rb_embed {
>  	u64 pad;
>  	struct rbtree tree;

