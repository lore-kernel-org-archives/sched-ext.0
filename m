Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467112;
	b=bnvlVe5ZSdKnx1VC7xwjJDAq6Oc3zaf+Q+IMcUtTZ/HVM0aUqWWmCMsN5xD6clZaLIhg
	 yhViS9wZ8P0Yo7GZdQIypfcVC0k3VlsHvHb5B03QuMr77b1iKNGjAhzTnWReRN83D2LZo
	 iFunJo3lBAJcjTQzkrKunojO5ns9h9/OAtdF8+39Qth72LkDnqLKQ4+Rxjvl1fTMoDstb
	 tkNKvs29e0FTDirLg1L+ut/gVsRtU9Cnkw5+hd2KQEJyL7cKHwfdR27qYdhARPEuisECA
	 IvYRiPwBnX6BCZv5YFx+MkfBVkGQi1Gum+1MOJpd/aEb/9+YqdxhonLTMBpDlAbJU/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=BhXIIma0KyYX4XFmWxtnNZ2v8I5eSZ8V5FzW7KusbPo=;
	b=UPPsPVkFGa4fz81Or0vMyEjpQhbzOvdLgCLTUaLJ18RqSFSQAeNZbIEt1sye359zrJ7E
	 GROjGrqq4UIr8GOYV/P4FNHEEmxzwM9A71/k+/Dkn80yBaTqZpVS6cR4yQw7ClhKDAnHx
	 MsaH1kZdX5KRQcPpOTdtNYiTqlMeYWqVrquQaColS3MHDdCOP0CUi4/gukBhk9pLzrq+k
	 pT5m49S4WXF4ygJDXFdVACizYFwDi3r8Bf9FegoBWCmohBqeUTSwEJp0OdjsJOkaBv/MG
	 qJusUY//NNZqzfH1FUKbU1/Ougz/XlnexHQKsOy/RHjRFYQgdAi7CbfeycOE5cAJuNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=hGEIOCie;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CA606A327
	for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 07:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 655CA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=hGEIOCie
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso1893788a12.3
        for <sched-ext@lists.linux.dev>; Wed, 11 Nov 2026 23:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794467110; x=1795071910; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BhXIIma0KyYX4XFmWxtnNZ2v8I5eSZ8V5FzW7KusbPo=;
        b=hGEIOCieoDZQcUjDep1hoAFZy8TwJHLsH6HgukLOJzItC4AhIdTsAdG4HZGf5jAFcv
         lHksUhtHi4z1s3qT+rDLdXCr9NsFWvLjOYVe4RnXSglQSBbl1u21kINgv919xCDPYS8o
         82S+O12OOKfM4Srwbd5CBtjOaccIUVQLadGI9oCphD9VC1dDghEMiivtj+F0JfykaY4b
         L/KU92Wj9CHVXxHcEkaM312ZjzUKvs9lE6/fSzxsNrAqzvZRC8BvZa/eUltYc+kSEle1
         nsNFgidMdzID9YUNrU3LIHCZNx3b6MTnWczSBzgIBQp+HCpgQFoAOHK/dGB+CMpuIRWy
         3r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467110; x=1795071910;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BhXIIma0KyYX4XFmWxtnNZ2v8I5eSZ8V5FzW7KusbPo=;
        b=wfeAgahNoGwV/vFMQ2cTAlEGa6roWTc27R9SHwAlfii9tlFmCKBDqGcVX+KhLPCVUn
         905TR4bI3UD7kwTw7O60NF8iXTkNHc4fvibq1aodlOdQYMfvs0yxiUhVFEIw5OMUVID3
         p5hSA+Amf5ESIaaRVJGZNX9BgGtalCAjirsFdRjXUSumCFs/c10mWqgBLC3LqLrbHBF2
         cBa2L8npDjbHlOwS06DSksVyN4slgjABE7RqePBuFTGSBcRz13xwUlsVnmMlnyNHAt+j
         CQoqMTACUZlRpniEnFd1q1swRkplOJJMcMpBFQsoA47psaPNN/v2r8HkYx9IIbm0X4Qp
         rMPg==
X-Forwarded-Encrypted: i=1; AL+hErHMo7tTteyB6NMGhei7jbG+1hCDtwVsmfIo8yl2+/Kb3LNVrFxMHy3lYAogx6OpbPJ/uZMr36W/fg0=@lists.linux.dev
X-Gm-Message-State: APuU4Z9zhiI/i8DIoLjBxnIkFD6oygKlks5mrHuTrDbeGBTABr/ibmq+
	03HzAoGpLWvJr4tRPOiOLzItEi9E+Mw/u5KBhqhjwGuUyWMuLhiNsT5tEMlDWZ+Jm48=
X-Gm-Gg: AYBFou2ub1Q1dEZE+EHsc8Qj7hqMwb2Qg4jeyiqvKd35auOotyI2dvgLq5JS3CCa0pl
	321vIoj9JJxBBXvgNsQH/sbNkiCaBAAxFsqQuCY4z0dkwzzNPxtulQmthlnf5A1udCqLMB8tbdD
	twRxRypkNnCawl0dTMfD3z4bvFnioPQOP6wvqGUF1kevt+zpbMscvfMj3Nym7BL/KxG/mXQ2vie
	UWZE/RQ5nmgkCO54FCVHrF6+mQ/FDzNN9BFYcQ8Ey0ChRxkZKpkLfyzuq+1167yBTHQ1Pl8sr1h
	DXV5ermLRvI1ZTXTpeFneA4Oo+RWlMyrn7EUr0S9NzRVEHKIdJwhwjX5aPIZ2eNdofDoRRmEvb3
	fqTyP7aNCEyN3hqZtHOn8JYieIMtn+rCQkMC9YRU143CwoVn5okYKn/xnOU1mKSycjKzYPTk23V
	L3QcDua9RRCrtgxfCg0dvxfCwQDlkUpVKGSdjt25zGttkJSKy6MltQPXwL2SdM48L22h7aF4Lre
	SrRvWgGnSL7Hyy0733SF3AbFcLOb4sVSQLmHt71D4wWm6fK5NakBggOZxzYmf4N5hgFqTXFLeZu
	7uznWi7cz+ATASStjr7ko95FVM8JxcajtF/aXQ9oyjWqvdwtWDgrafJpbF34n5txWpjg216O7Qx
	BCM/f5Py/Yvzr7Lcckw==
X-Received: by 2002:a17:90b:4a12:b0:3b0:9fbf:8951 with SMTP id 98e67ed59e1d1-3b182e0346bmr4836706a91.5.1794467110421;
        Wed, 11 Nov 2026 23:05:10 -0800 (PST)
Received: from localhost (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6e06833sm29122375ad.68.2026.11.11.23.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 23:05:10 -0800 (PST)
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
Date: Thu, 12 Nov 2026 07:05:07 +0000
Message-Id: <DMT1I0RRNARI.1LTPB6JPWY4E9@etsalapatis.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, <david.dai@linux.dev>, "Gavin
 Guo" <gavinguo@igalia.com>, <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-dev@igalia.com>
Subject: Re: [PATCH bpf-next v3 0/3] selftests/bpf: libarena: Add
 ordered-walk and lockless-peek support to the rbtree
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Changwoo Min" <changwoo@igalia.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Shuah Khan"
 <shuah@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20261111100951.230730-1-changwoo@igalia.com>
In-Reply-To: <20261111100951.230730-1-changwoo@igalia.com>

On Wed Nov 11, 2026 at 10:09 AM UTC, Changwoo Min wrote:
> A sched_ext scheduler can build a task queue on libarena's rbtree, keyed
> by vtime, in place of a vtime-ordered DSQ. Such a queue needs three thing=
s
> the tree lacks. This series adds them:
>
> - Serve equal keys in insertion order, as vtime-ordered DSQs do (1/3).
> - Add rb_next(), so that a consumer can walk past tasks it cannot run
>   in key order (2/3).
> - Cache the leftmost node and the node count, so that other CPUs can
>   peek at the head and the length without the writer's lock, like
>   scx_bpf_dsq_peek() and scx_bpf_dsq_nr_queued(). Add rb_init() and
>   rb_fini() for a tree embedded in another object (3/3).
>
> Each patch adds selftests, which run with:
>
>   $> ./test_progs -t 'libarena/test_rbtree*'

Hi Changwoo,

feel free to keep my:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

(though I didn't add them myself to v1's patches 2 and 3,
I assume transcription error?)

>
> Changes in v3:
> - Make the lockless readers static inline. A plain static function in
>   a header fails -Wunused-function under -Werror in a file that does
>   not call it (bot+bpf-ci, 3/3).
>
> Changes in v2:
> - Drop the comment on the insert helper and keep the name
>   rbnode_least_upper_bound() (Emil, 1/3).
> - Move rb_next() before the caching patch and into rbtree.bpf.c with the
>   other traversal functions (Alexei, Emil, 2/3).
> - Hand the head to its successor at the top of rb_node_remove(), before
>   an RB_ALLOC tree frees the node, so that a lockless reader never sees a
>   freed head. This drops the wrapper, was_first and the rename to
>   rbnode_remove() (Alexei, 3/3).
> - Drop the cache line alignment of the lockless fields, which showed no
>   measurable benefit (Alexei, 3/3).
> - Rename the lockless readers to rb_first_lockless(),
>   rb_first_key_lockless() and rb_nr_nodes_lockless(), and document that
>   a caller that dereferences the head must keep the node valid itself
>   (Emil, 3/3).
> - Drop __always_inline from static functions (Emil, 3/3).
> - Add Reviewed-by tags from Alexei and Emil.
> - Rebase on bpf-next.
>
> v2: https://lore.kernel.org/bpf/20261111073416.203153-1-changwoo@igalia.c=
om/
> v1: https://lore.kernel.org/bpf/20261028060046.549097-1-changwoo@igalia.c=
om/
>
> Changwoo Min (3):
>   selftests/bpf: libarena: Order equal rbtree keys FIFO
>   selftests/bpf: libarena: Add rb_next()
>   selftests/bpf: libarena: Cache the rbtree's leftmost node and count
>
>  .../bpf/libarena/include/libarena/rbtree.h    |  57 +++-
>  .../bpf/libarena/selftests/test_rbtree.bpf.c  | 303 ++++++++++++++++++
>  .../selftests/bpf/libarena/src/rbtree.bpf.c   | 120 +++++--
>  3 files changed, 457 insertions(+), 23 deletions(-)
>
>
> base-commit: 0fb18ce8a2e9de830433923cf65838933d615359

