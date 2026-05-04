Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D212D8DDF
	for <sched-ext@lists.linux.dev>; Mon,  4 May 2026 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881655; cv=none; b=K44q+LHKhtSuNDYUStljMijDRsqbnVUS9BbU95sa59jBRyRnIoSKU/5R5GpM9R8e35moG/sT4Mn8KPkwbpO0LsDM0IvaGG00jK05MuJzpeGa6i8bzRlja7jl1oupVU03cXBKCZePCXQ08En8r4rW5LfVzX+UtayORKXxq4FnRro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881655; c=relaxed/simple;
	bh=lyrMExmbCcWT2Z4UqkVO5ztFoPUtMbRy+H74bmJO44A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E79R5zdQCyJ/hdSXffWd5pFmmCkQlWYI7YBD80hohcOM+tfy5k9B5yAEiam/CE0K9ewYrqwUz6rOuQ3akjV3bYpVXj5fNEVyZ/xLcmeE80D9QdyiTiTB29QbUJnVxFURmGqZWWUne4NjSuftqKutXgtO21nKd/mHR4/B2qz9NGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVHmfnpT; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVHmfnpT"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43efc93e4f6so2817883f8f.3
        for <sched-ext@lists.linux.dev>; Mon, 04 May 2026 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777881652; x=1778486452; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouola5UQHpZvd0UAQzdvHkVdaes55Utp1ZKXgRfSFq8=;
        b=SVHmfnpT4HwlQs7bkuPNzqBdWYO0Vo8i7C+5t4ed5ybKEzbDyU+FfwD/ZXrgRBkz3s
         twiipcMbrHTTpnFCrqntNuW7R8Uomb1Kf1Vbot62w0MtFlNtGVabWVuPT5ikLIZkeHJ0
         5NqedAKdb72IC9a3Znmr+BXp0b09P6G2s0kdi94kjZApxBFvYemO1gJC6e1qtkQCWh0Z
         ZiU4lS987WmT2+uTHbf/m5AagQGlUxd3HV2DfLd+6peO+0KEvZ/OXDNrsq0dhMtjnhX2
         oVE1cjtjvP9Aw1wwHM8GZxg1aOI79UcZA5qKpDOoF5RbpnlF/fam3tjHNNw4Qyb4o7OL
         XyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881652; x=1778486452;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ouola5UQHpZvd0UAQzdvHkVdaes55Utp1ZKXgRfSFq8=;
        b=IdBKtxX3WdEhZZicDij3+dNPjntmOlcWfcCU9I0XISRXkfjrOW6Mat6+a6PTWk44a0
         7Tmo7JaepAyOvb+Fo/xaOdV2/L2jh5KhBpmKnG6Y2d1XnH0b3H5JJhI7QCZsqOSAKcS4
         rnNRM68Row1dTVW5Awl1foYY7T7mVkEm7FOjORun6deits3eTRyAVLsPtNB1km2hTyXB
         9l0Nxx7LUu+pfbNz38pztc+yNY+gnXlIvCxgtqIdCgU+HxPqHPkJ5J6OHZsTuBpaGerN
         /JhIo6GUUTmJCw5BPwd2hL4tUf+5RPp1kmkuLsjZh4iSoJ1zuqjUFwchsDlrTADVXf70
         Lw1A==
X-Forwarded-Encrypted: i=1; AFNElJ/7WSuwVcBlNMPs5ZlYoxcTSBbe0lwOwHLEV5lVGaGIs1P6gzwtkWZ1zLZaMYgyn63JiNg93EUTcLg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3H5XnW+CApJ1nj90+cVc5FDBmkCfTOeemxzqpJfgYQhR4l2Vk
	T21EHtvhTxrtnK/EmnLekFFuB9gNJTJRYH6p4gXGHhZkeptMnkCySF5IaMUv8wxgIBY879kyQNc
	COX8UUeihMRpN6A==
X-Received: from wrog14.prod.google.com ([2002:adf:f40e:0:b0:43d:758b:6178])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:24c9:b0:43d:21a:9a3e with SMTP id ffacd0b85a97d-44bb65dfc18mr13027948f8f.32.1777881651504;
 Mon, 04 May 2026 01:00:51 -0700 (PDT)
Date: Mon, 04 May 2026 08:00:50 +0000
In-Reply-To: <20260502000039.Ga94c@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260319083518.94673-1-arighi@nvidia.com> <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
 <abxl-xw7nt1jp5qT@gpd4> <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
 <acHJED4iAeytdC2l@slm.duckdns.org> <20260422142633.G7180@cchengyang.duckdns.org>
 <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com> <20260426093756.Gd781@cchengyang.duckdns.org>
 <DI3TFV6PNXZ7.3OR8GY5SBIEZ7@google.com> <20260502000039.Ga94c@cchengyang.duckdns.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DI9QFXIX3Z0R.23PU1FB6DEMPS@google.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
From: Kuba Piecuch <jpiecuch@google.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng-Yang,

On Fri May 1, 2026 at 4:19 PM UTC, Cheng-Yang Chou wrote:
>> >> 2. Do we want to restrict ourselves through the one qseq slot provide=
d by
>> >>    dsq_insert_begin()? The most flexible approach IMO would be to sim=
ply
>> >>    allow BPF to read the qseq directly via a kfunc and then supply it=
 to
>> >>    dsq_insert() later. With this, we can have multiple qseqs saved at=
 the
>> >>    same time, and we can even pass them between CPUs, e.g. if one CPU
>> >>    dequeues a task for a sibling CPU, but we want the checks to be ma=
de inside
>> >>    the sibling's ops.dispatch() (I just made this use case it up, it =
may not
>> >>    be practical.)
>> >>    That said, exposing an internal thing like qseq to BPF may be a st=
ep too far.
>> >
>> > In Tejun's reply back in [1], he suggested dsq_insert_begin() precisel=
y
>> > to avoid promoting qseq into the BPF ABI =E2=80=94 which matches your =
own concern.
>> > The single per-CPU slot is sufficient for the one-task-per-iteration
>> > dispatch loops used by existing schedulers (e.g., scx_central).
>> > If a concrete cross-CPU use case materializes later, we can always ext=
end
>> > dsq_insert() to accept an explicit qseq without breaking the current,
>> > simpler path.
>> >
>> > [1]: https://lore.kernel.org/all/acHJED4iAeytdC2l@slm.duckdns.org/
>> >
>>=20
>> Well, Tejun doesn't explicitly say there that he's against exposing qseq=
, but
>> I won't be surprised if he is.
>>=20
>> FWIW, ghOSt (our Google-internal BPF scheduling solution) uses exactly t=
his
>> approach to guard the dispatch path against racing dequeues/enqueues.
>> Every task has a seqnum that gets incremented on each "event" pertaining=
 to
>> the task. In the dispatch path, the BPF scheduler reads the task seqnum,
>> does whatever checks it needs to do, and passes the seqnum to ghOSt at t=
he end.
>>=20
>> Admittedly, what works downstream doesn't have to work upstream, but I s=
till
>> wanted to provide this data point :-)
>
> The ghOSt data point is appreciated. If a concrete use case emerges where
> the single-slot approach falls short, extending dsq_insert() to accept an
> explicit qseq seems like a natural next step.
>
> Tejun, Andrea, sched-ext folks, any preferences?

Random thought: If exposing qseq values to BPF directly is undesirable, the=
n
perhaps a less objectionable approach would be to expose them as opaque
cookie/token values? Same semantics, but fewer SCX internals leaking to BPF=
.

Thanks,
Kuba
