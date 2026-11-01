Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494990;
	b=Enw7cajyFFESXUBJXGXF/xCzVgaA5UNv9k3jh3bJNQNsJipNs9NB+xA40MSJg72fwACs
	 al5SeXpbT9CU2WYKqRlRg2f9yxkUyHos1z+DJXWBhZf/yecEd2VOfSSmfJXD+iQjCwx2J
	 Jt4HMLIb8WqZM/zq1WO16QMrYHW+lDbhqRFmY138T9E01xQa2JJ4xuZpN9xW7wnpCFJzV
	 odjxLx15dFHVh6DNzXmciX3zQZwadVTzvNeiKg85s7V0F8Fd2g2NqwDfEjzjACDoN9HQX
	 3jNgPBg/RKGM+pE5rVH4E9YJ7Bh/4FG7w/cijC1Pvnxcq8Rd6sYj++3Yaha2WGFuhwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=/U+dm6O7ibLuqp1u5mfZ05KhbMMiFWjnF5fZVcet2uE=;
	b=RzutA8dUV1l5OsgdGJFgymzD+rk2x8sGcymhD9oia/joxzAiTrzLhrCx0d0+QVWzz8ZE
	 KQERtuSHett1uwutfkCBPOktJu9CdGZ6FIK2AKDB89sKLiD+mBnan2HXJdQpLZvTC8l6l
	 j6YfuXvQ82bbMSUVNk1adFMcjZn0mDmGEsJTqCE+ak76ezKkCTtdNFL5R61LLg869g+wF
	 YvO402tmF8mFCV2ahn1PS4dk2rQBUdEEIpcNuu51MWcX9WkDKiZJb2PuELmY4+u4KZybe
	 hh/g76h7ucb+g1byX8RRzgd2IXMRovYGSz217DRVX/wRdddFpt5DvIXY8wC7ahw0K7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XRqk0x5t;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187AD606A31D
	for <sched-ext@lists.linux.dev>; Sun,  1 Nov 2026 01:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 187AD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XRqk0x5t
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab98332238so1020150a91.3
        for <sched-ext@lists.linux.dev>; Sat, 31 Oct 2026 18:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793494989; x=1794099789; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/U+dm6O7ibLuqp1u5mfZ05KhbMMiFWjnF5fZVcet2uE=;
        b=XRqk0x5tt/XODVX9vLYr5NUao2Rk8yPoKPVDlB/KDevYIlou01sNlFbQGxNLeVoofu
         MJim0M6aM1ezczwKmp0UIAo8aT0jr99Sjbl6WAVoy9K2OzBvoToT/2NHHFZN+mQPdv46
         p8vl80mDwsr0W/sJbzoa/PngWYktXJPGpBRI8rqrSpvRbpuuDd/Adrnbm2F5OlW5OyMJ
         VHrC/MFmSodB3tDi76y4UfMClHc9dqTQhov/GuYOKg9Oobx2RsgWtKVzaLlqFlMaH4Gh
         eFCs8e0CgzkF+yS06/igDBX32KZRBtXbAUYqVRsqmq59BdoKm96vpHXYla6kdxxesMW6
         58/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793494989; x=1794099789;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/U+dm6O7ibLuqp1u5mfZ05KhbMMiFWjnF5fZVcet2uE=;
        b=o9UrGr3xjFl2EStAkPhYjvyyCr3Mc7CkZAzSOOqo/3wfzxJ8AAnliIdCeLlU3yHldC
         ibsrs2aq+jrSWYlluin8LyAT8ak+yVibHo3oWggEkHiPT1wTR1OQ2mKtMH1J9+aKAWSd
         cWwU0v8d7YVu416CshpcOy+PkvmREsw/v4IHEOCVzTWOUQlaDrhpyk0L3j/x7cIYAOJo
         o20ZX4VKXyqaOkfOeOw2fKR3kOY6noh3vSRvNrqy/QZN1PoF+nNHf/ihMPYLDQdvuBM+
         5pCe5ySpv8a83uRMdqYmoDposTtZ0F+UZw31NjolXTdZmz/tLcFwWNpn/veiu9gK5Xu2
         SM0Q==
X-Forwarded-Encrypted: i=1; AKwUvBylKXOB98Ics5VXiE/+xU97vJZXWIMVPRHkwnJjUpkteIKc2VKw7OJ3SibP/oi2CSjYkRjldXct+lg=@lists.linux.dev
X-Gm-Message-State: APuU4Z+eD/arg/VEZaZ58My0Sc16tEdmqMVUSw4TQqGyiKndf7QqYMLA
	6TrwMMItPXMCNTVKrcDkrvGHyE5Qhr6wwoYqf0MCl5sEdtzbYQB/eAwW
X-Gm-Gg: AYBFou2PWP+JADge+5+t+w7PFrt/INcR6Mh6oYzpB3ORXVAUpYl8kkpOc+NABuv1zSN
	F9/horUgujd/FAaHjMHmJOL+OLfR39dpVo0uQD8EPOdpgMaq9BQlk4lorHCqdd8RR5qu7zK1ElS
	Gki/2uYVrLi/VYcqenjyOqq1cip7klzlocEb1Jzovc21c5HUvmmoNzQ3JaO5whSHVpkLYEyfOIl
	Gwe+bIMtpEvLJYR4z0HwYfNGgsC1GRR8F2UlJo7x7gD5+pwV/RZ3TMsnUudm4maxR4yVP71SOU8
	ODl6Br2+Bv11tto1WyNxpPORdVnNErklVpOylStMbpEXUQNtNOcz4BLtb36j8gV90Ebve6XT4u9
	tyQFKKldQoP7y2/nuENebPOVKSiAwOCGM4mESWSHMBUkFhZajaJ6pWrCBPQAt3ZFfJ/4qW2ycwc
	1BUb9RXHIJfqud4+woAjZPdTUKdaY4iDRxMsVgA7mJV4RFp8PEebiUy1CvMSFgCHeokh9NPFOMT
	z70+Gk2QU2wCnUbPEQYGHoqiy6V9yutQyUktfO24mXlToUeD/7Iv3elt+nkhAkbnoAJ874Zo0yA
	XnbVkdEzsJ6nEN0zWf9iWvQiRZ0o2Rp13Od2u5fkMh7D+lOiG+0HK/XK2yMD3z6LyUAtoHibqa3
	DUZ+n4a10SFEsE5KIy1rsRrM4DsIuJIrwbE7hbEMDXR7Jr31zvW6pq2w=
X-Received: by 2002:a17:90b:17cb:b0:3ac:9ed8:f309 with SMTP id 98e67ed59e1d1-3ae89736030mr5688613a91.29.1793494989295;
        Sat, 31 Oct 2026 18:03:09 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98afe3sm13151497a91.12.2026.10.31.18.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 18:03:08 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 01:03:08 +0000
Message-Id: <DMJGWV96Y5SV.33OTYFHFZQ1WT@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, <david.dai@linux.dev>, "Gavin
 Guo" <gavinguo@igalia.com>, <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-dev@igalia.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: libarena: Cache the
 rbtree's leftmost node and count
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Changwoo Min" <changwoo@igalia.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Shuah Khan" <shuah@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
In-Reply-To: <20261028060046.549097-3-changwoo@igalia.com>
References: <20261028060046.549097-1-changwoo@igalia.com> <20261028060046.549097-3-changwoo@igalia.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 27, 2026 at 11:00 PM Changwoo Min <changwoo@igalia.com> wrote:
>  struct rbtree {
> +	/* Writer fields, on a cache line of their own. */
>  	struct rbnode __arena *root;
>  	enum rbtree_alloc alloc;
>  	enum rbtree_insert_mode insert;
> +
> +	/*
> +	 * The leftmost node and the node count on their own cache line.
> +	 * The writer keeps them current, and readers may read them without
> +	 * the writer's lock (see rb_first() and friends).
> +	 */
> +	struct {
> +		struct rbnode __arena *first;
> +		uint64_t nr;
> +	} __attribute__((aligned(RB_CACHELINE_SIZE)));
>  };

That's 16 -> 128 bytes.
Without perf numbers it's a premature optimization.

> +	ret = rbnode_remove(rbtree, node);
> +	if (ret)
> +		return ret;
> +
> +	if (was_first)
> +		rb_set_first(rbtree, next);

In an RB_ALLOC tree rbnode_remove() frees the node and then rebalances
the tree. first points to the freed node all that time:

  CPU 0, holds the lock            CPU 1, no lock
  rb_pop()
    rb_node_remove()
      rbnode_remove()
        rb_node_free(node)
                                   rb_first_key()
                                     first = rbtree->first
                                     first->key    <- use after free
        rebalance
      rb_set_first(next)

buddy_free() poisons the node. A prog built with ASAN gets a report from
rb_first_key().

rb_erase_cached() moves rb_leftmost before rb_erase().
Should it be the same here?
Move rb_next() from patch 3 in front of this patch. Then at the top of
rb_node_remove():

  if (rbtree->first == node)
          rb_set_first(rbtree, rb_next(node));
  WRITE_ONCE(rbtree->nr, rbtree->nr - 1);

and no need for the wrapper, was_first and the rename to rbnode_remove().

Patch 1 looks good.

pw-bot: cr
