Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515798;
	b=vnmrFFszJeRRwuINBBAiixEtIHlAz6SMhuvQyJy3uyhASWVq/u9Z+7qngRzLI5pPhHkc
	 YrxP9JRk82NBOIlvS2rOu0NUnyoOz4Xok1ZQ56SBEWlCe/8AqYi+mP+MGqwrHgPM4xeWf
	 kVEc/9pInDNMwIew45EeWWmZaOgz7EctKELbnYN0YfTZoaFhW+zgsnPbMnRmDQQz6op2m
	 o7Z67tRM3RBIu5K5KO9+YsY8Ht7dulPE18qypc4O4vxG4imKgKfoY1pbk6oopdI9FS/1B
	 SDPr0xe3RVTisq4HzxH9eqFcLRpDbC3rI0VyX9r7T7Hx/+oIF55WQFLvQgoeb7CongQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=qBoWo02MaLgXB+hZPQ8xqyCHXhNVrv9lLkhhLMJg/BY=;
	b=nZeI1rB5IEhEN/phg75Pbl5Fj60VLKrDhpb0LcjERYyFc52ry5XcPYxRBGBNaEbsXmlX
	 nC0BUwnrQd1ulcVANDtH57X5Pa1QtCxIDwimUzFaD/W4I/OvbUC8y/eGoaBD1vqxKnXMZ
	 ICe72c1v+a0FGK6xgTcuj6Eb4/wMhsssOr/J1ydSLK5ZvBXhkqA/YBuxkQVYJHFrmzgmM
	 mS67jv+5TDSWEZGw77lxCD4+Gh/EceLzhainw53Uc0HNAimj/ZxycJolmWdAFPdKmf0A6
	 YlpXka2HOoh63YwYGov60QCAtD6cQ8n+T8DgcNFrQ0f7WSitsW1gZ7QOc9YYSqFJlHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nmRjlLsP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A585606A321
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 10:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A585606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nmRjlLsP
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so7339194a12.0
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 02:23:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515795; cv=none;
        d=google.com; s=arc-20260327;
        b=X/p417UxGG2B1gaAD//XDYoHUB+mmzaD+QDpdPv8g9WsMemCVIaaocdGm+L0FiUkK1
         7htV3jazAqZ+bcssSL12qUxDXXYixVvngRw2pBoQDX++gz/7YeBY2mpaoSfqnq3dOKbl
         06+mSTIzbaoxiyBtod+29CIML7o2OovP3Ba0qUWKJkrF/kgIbdUvRAWgGzOvUK8ugoXe
         w7mffq9Q1+3i0l8DfK515gFEHNGwFwBlC6kuZ/BaJ7InmuN3Bmj0on6JmdrIrxDgbG5B
         jX9MFaEs7yDHtBEbJJFrYUbzYIc4uQ07Hc8UfCz0SoaV7atbBL2fnQCIFjya2eG2J6+r
         ONeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qBoWo02MaLgXB+hZPQ8xqyCHXhNVrv9lLkhhLMJg/BY=;
        fh=8db7d0gYTV88cm/q/NkBkUFSgJfM23/kY5MM3C6LWn0=;
        b=MwuVMepRMvpjuFyBdIfIvq7Di9Zyrg119/ABoT7vrnXasAV9YvNqZsxmFX4CVtZZUG
         ZNKLDep7Khg+DSqHHINsgPzDQsSO+QUZtX7Q+agH1Vwk0WQAvZwZdldJMCHZBn5mIO4N
         yDfk28EXJQtjYOFrl+4DIasDHTiODQtytixLnDr4IZW+u1Gym5a6zwooO0O+U9fjjVVt
         9z6dOMVrpXZkucOlBorAFJdtSE9X8tg2AE9fN791bcOdDgi8Gabd3VOhoFuD0uw8r70F
         549+BLXLziKb0hW3s3JqragTKXR/p0hFIrDgHaL4CvmFVjOsglLiYufW9YLruyBIGWke
         yOyw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795515795; x=1796120595; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qBoWo02MaLgXB+hZPQ8xqyCHXhNVrv9lLkhhLMJg/BY=;
        b=nmRjlLsPG9xSW88MQx5H24jp4eSFGjSG4zoljGoVmxql4P6ZV6GuYnPyx4UMeXSsp+
         CUTySCwi2YIjbzJfVif1OSfYA5KeWP5nwEcYSZBG00T+gV52ijql+gl8dgrj01OdqFaS
         etuueiY6Zx2cP7NYBButGhsYTo16Zwqic34rlUPfd/KPAYm+S0k6itD6ZSnBikt/YAiG
         shpDOq9UAqXD1Quvsn10krhFf9rmUDg2KQqhXxNjEIYlQeF7k6gwZH4i2/D5VfYFUzaR
         BnTKXuqFh9G877MopPBYeA6lsnv+/aurYufPxNc0lY/d9K8fAKWGHSvwwMPuHRwjOJCV
         PiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515795; x=1796120595;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qBoWo02MaLgXB+hZPQ8xqyCHXhNVrv9lLkhhLMJg/BY=;
        b=RFAWD+I8Hb+R6NKD7sJtBCtvVYOE7sQGAz7Q13B6LYCQ65URoETZ8Wz42ChYdt8gxc
         B7RomVBK254kiKwBuOSGGFnfr5jO8F2iw5iu+SO/bOlg0zgIafN2au1OpiLmDQTligZQ
         bMbP0hhCYBTLOjUTj4UVDKCQMei0bcJYXUE10xWwHxNt/B6jxjtxFmAsHNjEi97RUpWV
         5kh6t2hV0lppEEWFWY6EuOTR/zlQAHKDNsXd2tL1QDileBEOGymczTCrx4nDgaTfg2F9
         Gbrdzq0nKYfHtDMnwLoWJuV8b9XFwcto7b8Oqk6Kw0V5gf5+kqSqiSN9g+FMKZt7Ln5u
         i4qQ==
X-Forwarded-Encrypted: i=1; AL+hErE8qWO5tCjVLKONnYz0kaNs+nxXplQJeWXIg21xunvRF3zrisjgcnxRelEH8kJmZozHoyuwvSNdbtk=@lists.linux.dev
X-Gm-Message-State: APuU4Z/8aYU8FrU2+OWnMfO3NYiLq0i8CLq6JyRwJ+3YcX/pSeeEp6ze
	QDHvvc5xh+os1oJLcPYwYlc3wos1UwlfeJv53n5gHAFDcfJeCesH/v6G83P+B6B3n9vmYOf0ukU
	YvfE1Rg6uxa+HBjn8GejXFODlkAocEDJA9pMEdA+3VQ==
X-Gm-Gg: AZFdTZfXumdkUurN5aJ7oEk09rb4zeLDQ+8N8Q9l6lGka6rmz1Km5hGsfK4Fb0U7YFq
	sG4vRUZl954cZncYCqQrHQTcukmaffzl3swaLoJlYA9fHC/npgfyIk6T0Zll6qwfobxRoQfbw4E
	nhvjjJCWVzVbQSNda1E+o2joUPxxPunpe4J22oPE4jHBVrYdc/d5EXFw9ObfnGLRlB4rmegD7gF
	x5i2R2prSfjGVYFZZcEoOdhlx2otqQh/NGy9Nyo9ePp4aKxoj8tGvampMcm+a2RcPDQGqsFcHsf
	AHE+jlHenmxrD268EP7Ispz6/2Ytm1TKjRWlV0mlbRsl7BZ7WcFK3SpdJ01sobJFI5GYihuzg01
	5L3WOH+d1Pu7OPagb6jNQLhm/rqD+IK0ueOHO2Ud5jzBc5N3s/xWmpEZ3Gf0niz49q5ERig==
X-Received: by 2002:a05:6402:90b:b0:6bb:6a9:b1b7 with SMTP id
 4fb4d7f45d1cf-6bb06a9ba28mr589950a12.6.1795515795398; Tue, 24 Nov 2026
 02:23:15 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
 <cover.1795462673.git.penghuang@google.com> <9b14aecb0ad560a3ce5f7925aaaee6e4f4a1a760.1795462673.git.penghuang@google.com>
In-Reply-To: <9b14aecb0ad560a3ce5f7925aaaee6e4f4a1a760.1795462673.git.penghuang@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 24 Nov 2026 11:23:03 +0100
X-Gm-Features: Aa3M54qNqgI5hWzy6Ve_ebg-Vzu946g_60D42C4fuPQJz6zxrRzoY5M38661JuI
Message-ID: <CAKfTPtDb6CZ8WyN8rdK_-9RNhaFRxaZGOE3+EfbkReqkFCCy2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/fair: Clear residual sums on zero task-group
 avg propagation
To: Peng Huang <penghuang@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 21:13, Peng Huang <penghuang@google.com> wrote:
>
> In update_load_avg(), __update_load_avg_se() ages the group entity @se
> before propagate_entity_load_avg() runs. If @se's _avg has already
> decayed to 0 while its _sum still holds a sub-divider residual, and the
> child gcfs_rq's _avg also reaches 0 (e.g. when its last task detaches),
> update_tg_cfs_{util,runnable,load}() see delta_avg == 0 and return early
> without subtracting @se's remaining _sum from the parent cfs_rq.
>
> Keep scaling non-zero averages by the parent cfs_rq's divider to
> preserve period_contrib alignment, while letting zero-avg propagations
> proceed whenever @se still holds a non-zero _sum so the residual is
> cleared from both @se and its parent cfs_rq.

When fair tasks are involved, the next decays will clear the *_sum
anyway so I suggest to skip this patch if it's not needed for
scx_switched_all() case

>
> Fixes: 7ceb77103001 ("sched/pelt: Continue to relax the sync of util_sum with util_avg")
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Huang <penghuang@google.com>
> ---
>  kernel/sched/fair.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0c8af1cac2d5..f6c3bbb19557 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5516,9 +5516,15 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
>         long delta_sum, delta_avg = gcfs_rq->avg.util_avg - se->avg.util_avg;
>         u32 new_sum, divider;
>
> -       /* Nothing to update */
> -       if (!delta_avg)
> -               return;
> +       if (delta_avg == 0) {
> +               /* Keep util_sum as-is for unchanged non-zero avg */
> +               if (gcfs_rq->avg.util_avg != 0)
> +                       return;
> +
> +               /* Nothing to clear once se->avg.util_sum is also 0 */
> +               if (se->avg.util_sum == 0)
> +                       return;
> +       }
>
>         /*
>          * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
> @@ -5543,9 +5549,15 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
>         u64 new_sum;
>         u32 divider;
>
> -       /* Nothing to update */
> -       if (!delta_avg)
> -               return;
> +       if (delta_avg == 0) {
> +               /* Keep runnable_sum as-is for unchanged non-zero avg */
> +               if (gcfs_rq->avg.runnable_avg != 0)
> +                       return;
> +
> +               /* Nothing to clear once se->avg.runnable_sum is 0 */
> +               if (se->avg.runnable_sum == 0)
> +                       return;
> +       }
>
>         /*
>          * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
> @@ -5617,8 +5629,15 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
>         load_avg = div_u64(load_sum, divider);
>
>         delta_avg = load_avg - se->avg.load_avg;
> -       if (!delta_avg)
> -               return;
> +       if (delta_avg == 0) {
> +               /* Keep load_sum as-is while child load is non-zero */
> +               if (load_sum != 0)
> +                       return;
> +
> +               /* Nothing to clear once se->avg.load_sum is also 0 */
> +               if (se->avg.load_sum == 0)
> +                       return;
> +       }
>
>         delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
>
> --
> 2.56.1.831.g720f3f5937-goog
>
