Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515712;
	b=erLTbekk7w3mYLam0bV+Yr8NQH6IwJ88xt5LsLe70itUFm0IdB6/DY/tAuEE6I61nbic
	 17qj3HWBJWc/MkvpcPkBaUsNIUHyeg3nCUSisdiQfiFNRz++Jprn3mGOtpTr+KkasRVWW
	 wt401WTwgU2EoWqcKtA/HpPSSaadlyRDmBZ7Xi9YBOFbPJZkjW1TxmkAU5c1tvkUao650
	 Kd2pVtpVMt/2EhNCN+wv+dRKUFD8XmlQdGK2g67wPS2BgYQ3BpdwAuZHpFgfFWn4xIdHt
	 BQpi02Ol+HZd1YbhFPC/StRZESpr5JIKXzhzMk+I0YcXytzpDec5Di5cN7C5zDe6v8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=EAb616aCFKaeCBuW+s0EO+gYz957AjGDpcMTSjjRJ0k=;
	b=o7pB+B4z4dqERwUCbYkh1yar8Ekbm9OIZNHKeVw4Q82QQm6HKLEaYIIwRKTACyzA+M/t
	 WBy+oWaotIuR+Q3zFK9h4HVBFu/aIlNzOqWeYVhGZ4dd9+2ijtIzs85sqFNmnMZpZhzQs
	 2yRHviUZ4jToQh06gk5GM0V15ZfVUZ8fGFAPfkR272pFawO2CpvxAjwJ4eV7LW6KPtk88
	 y9XUdTa/lxe9TFeQq+Hkkzh0LGj6t78YHQXLFA7OBu/CKJQ8tddnXz0kGJYkf65lmkYtF
	 8QPetijwR7Ve7mrqg3doVyN+T4WxmOTpS0gFKTH/SiDxPF0gFrWZJGu3aKzi2eL6C4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HUwiLi0I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E565606A321
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 10:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E565606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HUwiLi0I
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c518cb79197so170878866b.2
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 02:21:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515711; cv=none;
        d=google.com; s=arc-20260327;
        b=n1HjU2nyg9uc2onrhKAkDrsvx2212n5XPl4ObS83tmcFqmyZplpDsfZUNQ5owzq+Oj
         pB7QwbMpDltJD+p4rNUAs2IvuPXp839XOB86K8l9M0SYQY3u6M+2yf4jjA1SP9KyL8SG
         UBeX9YQuXS9dE/w/Vv/WE49IRrTpw+1BUyKkyzLSjJi3XmpyywdLP1mFd1T9P2jyzFNH
         ZbGSFgDa1aOMb7Nwp+Zre4YoMOZmHTvlVzI8otWIvjz6rdPc4liTJBy4JBcsdzAK/bnd
         jmlQ79MSVI4ulRd2dXWshnfQROl/9l4OSBW7KHm/+6P8sorta8xgT9J/iaFLW9wsA7CX
         XLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EAb616aCFKaeCBuW+s0EO+gYz957AjGDpcMTSjjRJ0k=;
        fh=JHkbt9DNOIJwJFAnXpsL068F5g5euU/oV+bP2hZykoA=;
        b=Eod6uwQKqUsXyUh8qltwXYBa6Fiqt6l2wc23ll75n5mFjvTEYq7i3BFr7ppjGncZsI
         di8G5NdttZZ3sE4arEn4uJ/go+dgaYUaHKPGXuDeq+2iPrt7fJtNSp5i/ua2w9DHmNQM
         lfFO8YSJtf8oFafH5G6+hxqi1oT6Gifc9siZm5Mucf8FS8KBEoiGLKqaceXdSPNKaPBZ
         aXQRekJg5mHVtlB/o4NBduUUNZ0eR+odgFW51uMhtHi3wFHpUCid9DCkE5FeB4ALEbZG
         exE6egnHVgrv1kz13PJA08fxiZm+FtOoyQfL9pCZXkl1izyFo4JFhq4PH1Cfh9Z3v1WC
         Pm/Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795515711; x=1796120511; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAb616aCFKaeCBuW+s0EO+gYz957AjGDpcMTSjjRJ0k=;
        b=HUwiLi0ISxNFkXRMrbwgY3ZvIZhfOpsEmicKTRgw969I8EP+NXu21yi5FP1pzwq1iI
         utjD3K5LeP+W44XsRIt/82YHiB/kCdH+4NyURWFgCRDJ9eOFK77qNz8fBLN0AMKS0mzZ
         3QjeVarJDXoju/jidXHinj4Cavk4M6eQf0kr/dDMTnp2V6LAxtrr9vSSJ7yezBqKW25+
         VnNi8WkuBoLAptahqjXrfE0/4PJuFAznN9UocpXhQT9vzhMaVGVYNx/Iu1oHkGkvYUcl
         tZARyyfFAF9Z5UH8wF3wL+wGsSJbE0lhvpoMKIM+OOUSSIukThXnlKQfZkboSW3rfrgY
         s8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515711; x=1796120511;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EAb616aCFKaeCBuW+s0EO+gYz957AjGDpcMTSjjRJ0k=;
        b=p7gsl/kjrriR0l4wkHdwY46uzbHxpQtlOKeBPSRClmzvrKR4sURZE1XV+HSfUKQeZ2
         evo6Qt6M1M7FzyFpBbZVDfaX9UhXOdgvlznO8GaJ6c+1ruOo+rBnoLRMflhjU4sBUywc
         dCDX9xFu26HpvT8Sf64EZVntDsY5MJOr0c+PEtJbGyByHkdbSu6aUvMIUn7TzgCkTqJw
         8twK7HAP+Yn0ucAED7z/nIatBY8ze+lFVkCKtlSucrPspk/5RVwN9+xZ4xcLKU5zYY4r
         rjZA2QaFggAljARn4NHzjBXE0NfDhT6CnJBiLQe+FVCmPNiuvEawnhBmS8urU8Z4L6XP
         YPWQ==
X-Forwarded-Encrypted: i=1; AL+hErEdp0jl82/g6qmCR9HyWyRgtjVpOXGsZDTRlKOw2aw2Bg0mhw3Ey3MmseD/m+/VCRp/+Ktt6N+5ztE=@lists.linux.dev
X-Gm-Message-State: APuU4Z8lOfBmoEIvacfgx6DHevTFyANNPxgyU244JbjH+MC0h28hMlAe
	ZZyVsSsv7Lro00KHKuPN7o/J2iipulwE2oTs2LoRwzGrHgcAGgpfG3LyvRJJBmp4HMKVUDX03cW
	BP+nxGPU5/6fLhZ3CjOOt9S4U+SNEo53ndbMrgCqvKQ==
X-Gm-Gg: AZFdTZcEVvBJhbhz8OfLEfWY2ZMSFUA9IirE4/kLK+W04pJPPBDCbq52BykmeBDYg88
	ETTNzv8vRNkrW/N3le8Lo947dJ6LkoBAoY86CtqYnuUxYf027Z+9zw2vMnS86b8ChGu19hPnbDD
	FhzsFPuTnVroWnP1PPoMBdMxUEyJH2gOELEtDhPf1s3lUTne00cpN9+MLCazvGB6PEz1rPpiSjY
	vk5/mR+wLr16Zd9P/w8NVTxYXsiwZt/CV1NDjYxevMGVEQAhZBid0HsJdtegN1Ymc2omRKso5mS
	pJwDKI726454tDsSj1B7aBfBPU5nYgcsL3qvAbCzvYysZXxtuK/WGAu6kecy0qGOfAFNlu43+k9
	A1zYYbI2fjEv1GygKcw/Ez8JdZcNa/BwwtmlizGzAyMPU62rW9C9adOIqnnfvy8/GSs+UfQ==
X-Received: by 2002:a17:906:f59d:b0:c2e:61e:f4fd with SMTP id
 a640c23a62f3a-c513a47e316mr1137772966b.5.1795515710841; Tue, 24 Nov 2026
 02:21:50 -0800 (PST)
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
 <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com>
 <20261123160934.2289260-1-penghuang@google.com> <861e8b931f99acf9c44cff722d5e94e7@kernel.org>
 <20261124004742.1248371-1-penghuang@google.com>
In-Reply-To: <20261124004742.1248371-1-penghuang@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 24 Nov 2026 11:21:39 +0100
X-Gm-Features: Aa3M54poptazUM0JGKgFwqYCHNoqGw1XuVjKaJum1hg2U8ffwlyzLqavOvLaj3s
Message-ID: <CAKfTPtANtEnDDOe-PdLVR3BU5_cm9LiWTnU6eZJveUs4Py4qog@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
To: Peng Huang <penghuang@google.com>
Cc: Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 01:47, Peng Huang <penghuang@google.com> wrote:
>
> Hi Tejun,
>
> On Mon, Nov 23, 2026 at 01:48:44PM -1000, Tejun Heo wrote:
> > I'm not familiar with this code, so I may be missing something, but
> > doesn't __update_blocked_fair() already do most of this? It walks
> > leaf_cfs_rq_list bottom-up, flushes cfs_rq->removed and propagates the
> > result to the parent. It just stops running once scx_switched_all() is
> > set. Maybe the helper can run the blocked load update once on each rq
> > from that loop instead of open-coding the clearing? If I'm reading it
> > right, one pass after all the tasks have switched would take care of #1.
>
> Yes, Vincent suggested the same thing, and I sent v2 earlier today doing
> that one-pass drain via __sched_balance_update_blocked_averages(rq) in
> scx_enable():
>
>   https://lore.kernel.org/r/cover.1795462673.git.penghuang@google.com
>
> > As for #2, are the leftover sums big enough to matter for
> > update_idle_rq_clock_pelt()? It looks like fair can leave similar
> > leftovers behind once the avgs reach zero.
>
> You're right -- for update_idle_rq_clock_pelt(), #2 on its own is tiny
> (< divider, i.e. < 1/1024 capacity per recently-decayed group) and is
> not nearly enough to cause an issue once #1 is drained. #1 was the real
> culprit in our reproduction.
>
> I only split #2 out as patch 1/2 in v2 per Vincent's suggestion to clean
> up the util_sum != 0 residual in update_tg_cfs_*() when _avg == 0 (which
> otherwise keeps cfs_rq_is_decayed() false and leaves empty parent
> cfs_rqs on leaf_cfs_rq_list in fair). Patch 2/2 alone already resolves
> the sched_ext issue.

If patch 1/2 is not needed for scx_switched_all() case, I suggest to
skip it. When fair tasks are involved, the *_sum will decay to 0 at
during update

>
> Thanks,
> Peng
