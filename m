Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795712623;
	b=kyaGY0Lwpcv2qxW3j4kvIt1le81B0plsK1vTxYq4kcgwhHVsSQC5GOjbHx6mBJCTeZpl
	 VPda6aDhewjRalhI9IUE6df4WcsPirG4lYlxCuD+SnMhwxdqZSteb+gdsdes9YxqJ1NQb
	 uYE9A4GlxAclNlnXpbVM4v+Bn6htMy1/krW50pJ7TKbxWh4jUVzxhug4v55IMcCkQ11HN
	 VsAKKiSm0Y6xjKeb4YtmMh2/C2i5haiMSJRY2+XmzUfk9uD+w5k9NA4a8d48loy+yxFSg
	 dIIb9Nvw/g/Rph5MS0NZcC8zHCKPGtLiGC4fN9+2WLClPIjlzH0cTrlfyk5VWPQUvtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9+fJ/MNcJCzccF7MdK9Ukp6LXKmZ9d7V5PuIGgCcDMI=;
	b=fEmdcOzTJ1SqmsPwstJa7NlTFgT4COJMbdwDLUoFyv6j2ZqkJfmdVID6ampUHgWJBa4+
	 g9R9XzarU75b85O6uUEXEIyAekIYZ60ZC0J12MNJnVUfpD2FEcSwIVK9ldhsOmGmaUu77
	 nVsFx1AO4md/Ehn1/xL2ERSYpqAcfWBLIO5IWVSUCQU4uJbfCi1eXM63szz742F75Tsyc
	 kY+5xULWU+1LahmM9v4J60egLusVGft+Mv/ZFWXOnSO9RlAhUL4GZTOR/Hw9ALX110qc9
	 6CrYH9c9EbdBpFw/O5klWIQcI6uCUeq7L5h1x8UejO4u61fUMjFw0hiCe41Li6/E25w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WDqQO35M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39209606A31C
	for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 17:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39209606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WDqQO35M
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ad0102edd4so63341251fa.1
        for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 09:03:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795712621; cv=none;
        d=google.com; s=arc-20260327;
        b=gMad2Uhr6gyv3Yph0ZmumH4qFM/qPbHDAZSFiJgSz7ijt1HF2ID3tZirEJ3qg+AjWG
         Lit1ewKk8GmRini8BiSF/ruuK0Fw/Q03KhlvAy+BgKaCmxQv2t8NOZfvxsFttlLf/SNO
         rlFPDtYDfpxpwASueL25gt7rb0w0J4WyFnP0IzXQime+qG70NMa/89RsyJ5Td5vtd/Hc
         t6UH4mkbs6HKub6qz65RAFO6tk2WHvhyyktzQ7329UjzAxqIM17qvwJW/BswXuvCCfGE
         lbVQbFJBCmJFcPFZSwpJSoU2SGfRgcFzRKl7rezCPB7yiqwB42qcVz8aj/cAXEP00hqU
         R0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9+fJ/MNcJCzccF7MdK9Ukp6LXKmZ9d7V5PuIGgCcDMI=;
        fh=8LnHb/Khp5xWBV7g/QBh4iIGLWyP1tQfbx/06mNN2v4=;
        b=eP3vxtOdgGfB2PZ0bj+nKqvaQ9ouMUkZ4m5FTePq/ygT/knkJssKRdPQc1bh65QCt8
         5lRQkQF1sDMHNAiC7u7lkBWT5aRUMz8ckC1ZO1fJid7J6uZ4ifNUbz/PZH8gROs5dtOr
         +LhdykBTqepsHj3nfQCNFR7LQa7f9MVI/sLjXgnTnu8juDL4LfG4UII9VKM235NoFGeB
         DjJkGGfZuRDL6nqNAY4CA9uw2eESDyfjAFyfTnnCBJPYBcNQz2nf0QXwW101cPc8rENr
         yymHv9cLuuBeHZEnphaKX4/6F9G4dyS6M7GwxxnHIm/qyuIdWUxCPtc9RPfESchW2uP2
         qj6w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795712621; x=1796317421; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9+fJ/MNcJCzccF7MdK9Ukp6LXKmZ9d7V5PuIGgCcDMI=;
        b=WDqQO35MpNqMVWdZq1G2UAjvcoo3x/0bR+wuuGNiopayZt+3ZfWrAbjNPN6ynbj/Ko
         mzQ7e1lbYOzYuMfPQAv/0lt/7LA6AeTYvPngZwH/MzQB1rwyHAZ067EAbB8vy+C15d68
         L7UDPTjd46IKX1OgAptbJHVTqjU91jSRgOe2tjwaa95IeZ3TmdSRIV1odpBf79XWrJId
         rHlPjyoOI+e509Cdgwc8K5txojRgZikJydWDIGcej829TFw4Z1oP/K4tfPvQ4SQJ5Hru
         dtH0QdkKWWPw9hFTs9jDLaPaXPY5B5lcsxZVlBRmeKZ2FbShvut4gC1Ml+OfUyN/e9mh
         gHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795712621; x=1796317421;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+fJ/MNcJCzccF7MdK9Ukp6LXKmZ9d7V5PuIGgCcDMI=;
        b=BvEd0wR8XqDDGxq/Xsx8q/Psjjo9jyWsRuFMKr3pNaqtOyOakktyhEzKCL7bw4hBmS
         bkS3wPYxGbvPi9NMwKB7ejgCFS/WPvbG8TYzK2Mfnorub4pHobArhfWTGSyfOJFcWS6y
         q/dH0vXDpgsVyXvbfO7qcc3bASlwHznDureQMokux20vQt2FoxPNhRX130SloUg9sLHd
         mNyqvynitHIYtROTo4fMffgHQHvMoag0bPLl9rvqAJm7GE+HXv7psr4Y5YMHI1f4btDO
         NCKmMv4G1xEL1kTgmh0dSQ/wIjQqxrCzdxxDc2Q395Dg06GJENEWsS6w762KpBwlfOLn
         twVw==
X-Forwarded-Encrypted: i=1; AL+hErF9icZy/FrC7aJ4jJmrPhRrwFXWTkdIe6cqmmh6pwKEzYwkk2SYIRinC+B6TgvBf0RHEql2yN7l2Z0=@lists.linux.dev
X-Gm-Message-State: APuU4Z93NvVTylcKkuT1iczQxqC8q7bKhxaRF+94iFM+BnTbV0666NEQ
	P6a/9kZqte0fAg+ouzeAQKBWKplOGMyLxZVJ/E4pcKUBWB/n4j/MhBwkfh1EPXOlYiaGtdfa2I6
	NN3jf2ZCEMiBW3cct0D/ggUCwT0UjTJg=
X-Gm-Gg: AZFdTZcgEwys8v33iPS969B3wJMqTqrQ242Qa3yAo2NcD9C9x8RFtMJKsRHSS55e8/s
	qRSl2bceRJnMh6YQbSvRETUNrCNDH3S4mzsbQnIeAuC4f1P4bMQ9Qrx24B3XwTEw6k3jozKEUDN
	9cOftvP8q84bw7fHtOeAyDHqD0CcxoMW9i1GvOwKhhQUiJdglaOZhhlywKEWItyEyZgW8SH3Fkw
	qK6kwrgiqEhz0Uttzf9MZwt0kX1lCALn+f9HYIMOFdzPoOnb+Ef2hh8HhEvK44uEMBhPvn3WXcZ
	oIb/lN02bMn/FH4LECsNaTJweAHXF0lom55ZOrzQaQ88KbVY3b3Gd/lagIlijQcaSu4E5Q6/oes
	OCi7iSKyZrwcaKWiaLktO3/dcg6KlRQsR4TYwbWSGCRzJws+FlkjfQYnjnVu9A/BKCMlEXw==
X-Received: by 2002:a2e:a98d:0:b0:3ae:7eee:15d2 with SMTP id
 38308e7fff4ca-3ae7fa63ad1mr67706561fa.18.1795712621201; Thu, 26 Nov 2026
 09:03:41 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261126162700.22257-1-yphbchou0911@gmail.com> <20261126162700.22257-3-yphbchou0911@gmail.com>
In-Reply-To: <20261126162700.22257-3-yphbchou0911@gmail.com>
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Date: Thu, 26 Nov 2026 23:03:19 +0600
X-Gm-Features: Aa3M54pMJJ_YDN6FEUok4MV7qr3Ypgnk5485IR27NNeQwhjhL6TdAKskizbXdfw
Message-ID: <CAFj_506c59K-XDwcvdk4i2dAJZz+B2f7bhWrVx2R6Jgp9B1_wQ@mail.gmail.com>
Subject: Re: [PATCH 7.3.y 2/2] sched_ext: make DSQ iterator stay drained after NULL
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: stable@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Kang Chen <k.chen@smail.nju.edu.cn>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for fixing the 7.3 backport and cleanly factoring out
scx_reset_task_fields().

Acked-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>

On Thu, Nov 26, 2026 at 10:27=E2=80=AFPM Cheng-Yang Chou <yphbchou0911@gmai=
l.com> wrote:
>
> From: Kang Chen <k.chen@smail.nju.edu.cn>
>
> commit fcbff7b56a881bbe041b6c5ba12831a3c1ac1bb4 upstream.
>
> nldsq_cursor_next_task() unlinks the iteration cursor when it reaches the
> end of the DSQ.  A later call sees list_empty(&cursor->node), starts
> from the DSQ head again, and returns the first task of the same
> iteration.
>
> The verifier relies on the iterator contract that once next() returns
> NULL it keeps returning NULL: process_iter_next_call() marks the
> iterator DRAINED and treats the result of later next() calls as the
> constant zero.  A restarted DSQ iteration therefore hands the BPF
> program a task pointer while the verifier believes R0 =3D=3D 0.
>
> Remember the drained state in the cursor flags and return NULL on every
> later next() call.  The cursor has spare flag bits and the BPF-visible
> iterator layout is unchanged.
>
> Fixes: 650ba21b131e ("sched_ext: Implement DSQ iterator")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> [ chengyang: drop __SCX_DSQ_ITER_HAS_REENQ, which 7.3 lacks ]
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  kernel/sched/ext/ext.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 1049a0914d60..6db6ca912bb3 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -492,11 +492,13 @@ enum scx_dsq_iter_flags {
>         /* iterate in the reverse dispatch order */
>         SCX_DSQ_ITER_REV                =3D 1U << 16,
>
> +       __SCX_DSQ_ITER_DRAINED          =3D 1U << 28,
>         __SCX_DSQ_ITER_HAS_SLICE        =3D 1U << 30,
>         __SCX_DSQ_ITER_HAS_VTIME        =3D 1U << 31,
>
>         __SCX_DSQ_ITER_USER_FLAGS       =3D SCX_DSQ_ITER_REV,
>         __SCX_DSQ_ITER_ALL_FLAGS        =3D __SCX_DSQ_ITER_USER_FLAGS |
> +                                         __SCX_DSQ_ITER_DRAINED |
>                                           __SCX_DSQ_ITER_HAS_SLICE |
>                                           __SCX_DSQ_ITER_HAS_VTIME,
>  };
> @@ -10255,13 +10257,24 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf=
_iter_scx_dsq *it, u64 dsq_id,
>  __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_sc=
x_dsq *it)
>  {
>         struct bpf_iter_scx_dsq_kern *kit =3D (void *)it;
> +       struct task_struct *p;
>
> -       if (!kit->dsq)
> +       if (!kit->dsq || (kit->cursor.flags & __SCX_DSQ_ITER_DRAINED))
>                 return NULL;
>
>         guard(raw_spinlock_irqsave)(&kit->dsq->lock);
>
> -       return nldsq_cursor_next_task(&kit->cursor, kit->dsq);
> +       p =3D nldsq_cursor_next_task(&kit->cursor, kit->dsq);
> +       /*
> +        * nldsq_cursor_next_task() unlinks the cursor and starts from th=
e DSQ
> +        * head when it is called again.  The verifier relies on an itera=
tor
> +        * which returned NULL to keep returning NULL (see
> +        * process_iter_next_call()), so remember the drained state.
> +        */
> +       if (!p)
> +               kit->cursor.flags |=3D __SCX_DSQ_ITER_DRAINED;
> +
> +       return p;
>  }
>
>  /**
> --
> 2.56.0
>
