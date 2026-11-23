Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464862;
	b=yPkJmipdsPhhezIKzMVKgHkhRsT1jaKYiDNC16K3OovYftBlvxzdvUAcgaDIfU5Yx3Ck
	 fqjXZGMqZS6qAW6TCM0+VNBT+clj6DlseQ0SB9YnbSJ2qRcBiRzi0e0F3X1fOaM+gssBA
	 ebTkApd6O9Es+ROHQbK9lnM7NK/sYjIfkJb1g6BAl9KvK8XmGSlk0CaNmdlpXqlhBKDpO
	 +OOn/Jr5lYQu1mFmehYdltc/T/TYc5XKm9cM8xJuDvC+kXkVy5J2XdyEHhlYeHZb9c5Ko
	 poTfd8IX1+v1aPleExtyb6P/fqt8cOpM/+ZOVTpAydoZHhvrX6Q2Z5/bR+UCTXtKcrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=cPrfk6ONyb8N7CKSwNcuu5XHZjwnL6CQE/ckKsJyYbw=;
	b=AVeY0XrKzhoJLxOW8oU4hBzvKGvIowVE6werl7MWaB2kJWR4jgcgxYhjaB6ty0RYmZzG
	 quiQNCmH3W5rsB4R0k3Uf7b0+Ks0ukBte1Y+Zn6vDu0Lz9U91W6GNEdyb3tWeRAHnDSOs
	 xe1c0llJpk7koRc7NSMG5xH4IhlF7f/c5ysdLgNxmN7qMd2UsKE6BCm0ztUlIpVRuI0gP
	 xR+jgtp7eOJSOA1wHT2rJ8cVXmEs14lHqrCKCV6zYy8M1Y+/80AtmW48NwJsNQrs5nuSd
	 2ScpHqycSmBtib9vQHDADODXzLuxjf4h8W7d7TEcZwn1D+AJz7NqiYSLnJplFnRERwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lpVnQfRL;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2B606A326
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 20:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20C2B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lpVnQfRL
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-382af5cfc58so1716052eec.0
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 12:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795464861; x=1796069661; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPrfk6ONyb8N7CKSwNcuu5XHZjwnL6CQE/ckKsJyYbw=;
        b=lpVnQfRLN3Bm6Sv2n90tXTmB2qC3gRvgc9/HB/9iO3l4rmr4zIZN9wbIGenMx654xG
         Q+VXEVQBlpplr4ozdOYzpqWO1tdJ1BzC6zu6YaK5jQCFogNF0eh7xNyNqsWGKIts2HQC
         ivKG94ybBEwHr6J40asqQef6cIZwPNhCKVo/LijSc+uXGwsvYDUbkvL+G5qXaOoss82q
         SU9+Etm9Y+pjABItw/nm0sJYsoicoWlyByhMOZzK9mhSJP8+Q/uysnK8pb9FwPuTZqJy
         8gvpKshlBz6EXV6lprvPnogul3iL39Ir4wt+5g+fhy3ePcaCEiDspVL8f3F+eQ4tU7pu
         /GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464861; x=1796069661;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPrfk6ONyb8N7CKSwNcuu5XHZjwnL6CQE/ckKsJyYbw=;
        b=zhgjQuN1IYjzYaEAEajxT43IHdT+uY8qeBYH5K9SqEmY2viHOHqpxJkQ9a7lWzQHK9
         eYYi6ttIX/O1j7MxmWoJReYrXu1eB5OZ6jQvp5IZbjWVMWgIo07IbrkUOgd3PMFq1Onq
         OD6Gh5kvjzyezn0efkTS6mW7Wir5eV2Yv5UgeitimOB38/7Gh158u0iQ4XHasUD96sN5
         8VpT3WtgJ+cEisqlM27dZUyQyFIol2aw8cmYyWeznfukB2vrU6yu9lQ/UqK20nNSD5Yp
         RG3VSG+QC7DfNWk5Za3hUYuQsXuXyu/jkzzHJqsQ7zk0ISbc8hRLJQSirqSAoJq/blAP
         wttg==
X-Forwarded-Encrypted: i=1; AL+hErHyWIQJUrcqJFJt9k3Lwf8Av0zB+kbPKqow5eu6JwB/s5Z11d5r26bSJdJxuqwiQl57jl/Ho+W79TI=@lists.linux.dev
X-Gm-Message-State: APuU4Z8AMK9VjPcxY/HwXdXzSXAoKnuNfJevQfkrTBELKFXSRUk3yWDk
	nQMeAPZuEo2mJwXsOf2e8UNpnC2hHPKtE+0GkczrEzs9ICYqBttDyCcYJnLRZnj4y4WltHV0Oun
	90EYKA/gYSp9YM5ws0A==
X-Received: from dycai24.prod.google.com ([2002:a05:7300:fb18:b0:385:58ae:e3af])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:87cc:20b0:358:3426:d601 with SMTP id 5a478bee46e88-3856c0d0961mr13564449eec.2.1795464860602;
 Mon, 23 Nov 2026 12:14:20 -0800 (PST)
Date: Mon, 23 Nov 2026 12:14:20 -0800
In-Reply-To: <CAKfTPtD17e-veL1QgrhO6i4nsKyA3QfOEm8jNinJ_zf+vc8RDw@mail.gmail.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
 <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com>
 <20261123160934.2289260-1-penghuang@google.com> <CAKfTPtD17e-veL1QgrhO6i4nsKyA3QfOEm8jNinJ_zf+vc8RDw@mail.gmail.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261123201420.3970775-1-penghuang@google.com>
Subject: Re: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
From: Peng Huang <penghuang@google.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peng Huang <penghuang@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 18:07, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Yes this seems a better solution but It would be good to reuse
> __update_blocked_fair() which already does the work for pelt signal.
> Regarding your issue with util_avg == 0 whereas we still have a
> util_sum != 0, we can use delta_sum = gcfs_rq->avg.util_sum -
> se->avg.util_sum; in update_tg_cfs_util() instead. When util_avg == 0
> we will be sure to clear util_sum too

Thanks for the suggestions, Vincent!

One small detail in update_tg_cfs_util(): under CONFIG_CFS_BANDWIDTH,
gcfs_rq and its parent cfs_rq can have different period_contrib, so for
non-zero util_avg we still want new_sum = se->avg.util_avg * divider
using the parent cfs_rq's divider. Keeping that calculation while only
skipping the update when gcfs_rq->avg.util_avg != 0 or
se->avg.util_sum == 0 preserves period_contrib alignment and clears
residual _sum whenever util_avg reaches 0 (and similarly in
update_tg_cfs_{runnable,load}()).

I have sent out a 2-patch v2 series implementing this along with reusing
__sched_balance_update_blocked_averages() in scx_enable():
  [PATCH v2 0/2] sched_ext, sched/fair: Drain blocked fair load on scx_switched_all

Thanks,
Peng
