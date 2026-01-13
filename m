Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF21182B7
	for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320366; cv=none; b=rv5N5SlsozHFL23HweFjD2xZJBp4hFZIyLkD00KlgQKluQ3sF9jERkTB2ryjtcGt6urTNyfIUA9L6t5hv+jEtRQBpShALW6bWW9ASojFefluPIHTIhJZ4ejZgUnVs6UEh0e7y9GoDML3jAvJSl8cB3YhS2QMQix9kgDpzDBF1X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320366; c=relaxed/simple;
	bh=kUjsyfh9FOZguuBCbog+RcCXb37tigv68HrwxCJnx9U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fhe40vPqKq4uvsjyQO3hkk2X7IgKslzO5aXWver/W3rk7S6APPUAlMAKFigUUmNCgoKRis7BlCWPG4vAAd/QTtr/jU8nR5D7Q+dwOsbCOjpm8f/TLTEGNnWmxd+O9sa4IRbMiaYeJ+cXB8zwxWZrdgTdSQ8LBEEw22j15nKZA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Xcir6Dkb; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Xcir6Dkb"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8907f0b447aso86725516d6.0
        for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 08:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1768320363; x=1768925163; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0AcZKbWg+QUyLfzKd99VBD2tXthdBDKeMSY799CSjM=;
        b=Xcir6DkbZghjeihio7zmpPXRhUp6mWTs3T+Jv/rze0ypB22nli5vTrT58UvzRc1vk5
         NEPwKlCHpC90oURsbYNoQlK5/3prcTqnhv8UY7U1M/C5aF/oc0XYtgvKlkxSDZVBcNgO
         1aTcZn0rydq1BjP8NuV/KakLZl+wIrCkg3aDV1Y7H23aBJHYEJTMZUkD4Y+xVV0ElcaK
         6UFCcJtZHkHeHn0QLLjQJw+Gy393LTCADewLPmXKqa8OsCZBtgHyMIX9fo0B5u8HkAE0
         jMUwqqztUttAyYhThXDQVxoGA6Hsd32kTZqG3ILIU88d6grjGIWT/CxrmIh6lKCGcZMp
         5smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768320363; x=1768925163;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0AcZKbWg+QUyLfzKd99VBD2tXthdBDKeMSY799CSjM=;
        b=hzDR0y9yZf3FXKFKEIk9ORNzAf0NRBj/fLfwIvtCP+Rlm5MffXZqE91d8AVUl1o9AH
         iZLLSaxCZVsfz8wDIBlNiJoqdVhShgpqD7oTgBz26iljPFh3jLB8Ue3j+OOcWt/RgXM5
         vddL1rHflE+mDVO1HHYCsAFCozgPaVYVMG4Bfr1v9aiydltPMYVZV6LhZukE0OrzPe9Y
         3N3jHl4XvNJpLGjChPdSaWgxiRrvFyf6NMup45LJU9S8S/QJfk574cOQdX0dWVExmfpV
         cy5NxJZs9IfH336GPErm/fzWcezhct1VmRBT+9+0p7CRuupnY5SjJVrCeIYB6I2MWVOf
         zEsA==
X-Gm-Message-State: AOJu0Ywk1ts2E/KsXtsnnovomIog4BDI1mz+uSX0gjf+ZKvtRk1dFUzh
	OaNNKfIHQ9cxbVPhmwyxo1oKi13QD/C6fcaMEQ5URKDjhFZI6p7gQHh/h1QFyQj45xY=
X-Gm-Gg: AY/fxX5/fOEdqqkLTn1bfIMJ1fX/PcZ99ww1UqfAttHqd8I1W/cENLP+QS2u05o9V/i
	QgM1Bg/qAQwoIE2qBK702NOBGHuxITTmetoYBHTteDzbKtUvS5nT73FMqM4R18hU+d5ObMuJaK7
	rtWUFp+xoMaFjAoOWoArTdB7V/rG9Ei2sASY1fqdu9TAApmRaR+92+alkgNKaUQy40PYe9t+sZ5
	vCd/G2XAn8MNX6spg3H2WQCf9BrEYPyoDDSiBjFU29Qd6GdDbxMgyC8dWsLARfpuOfGor5bqU/M
	D46mJ3jkFrtQQVkAOtmeE3WOduaVkNd+OGrA9z2IJDCNyjeTJRqivmUANUx3uuBxtnzNdhOELLe
	bAK0Dd2wrf2k12zSvDVbDzJaoVJNdp1xpbzk5rqr6nm1sIqkemehJrJRsTG2wqAi7RYd+loYmFL
	7DAT1EqfKVDLw=
X-Google-Smtp-Source: AGHT+IECb+fU9htwWDxZwRPAJzKN2ct6XhP0lF/Ck+rQC5YBRReQ0NPPgzlPotZx/0RK2/StdKnhcg==
X-Received: by 2002:a05:6214:1ccd:b0:890:3f67:307a with SMTP id 6a1803df08f44-8908418f77fmr320485226d6.17.1768320362253;
        Tue, 13 Jan 2026 08:06:02 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077267b9esm170003446d6.48.2026.01.13.08.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 08:06:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 11:05:58 -0500
Message-Id: <DFNL926T4XG6.OKU0AB1NG254@etsalapatis.com>
Cc: <sched-ext@lists.linux.dev>, <tj@kernel.org>, <void@manifault.com>
Subject: Re: [PATCH 0/4] tools/sched_ext: Add example C schedulers
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>
X-Mailer: aerc 0.20.1
References: <20260112214131.50236-1-emil@etsalapatis.com>
 <77b165ff-0cc4-44bd-b3ef-9221f8238f20@igalia.com> <aWXnTUC1kXitcpTw@gpd4>
In-Reply-To: <aWXnTUC1kXitcpTw@gpd4>

On Tue Jan 13, 2026 at 1:33 AM EST, Andrea Righi wrote:
> On Tue, Jan 13, 2026 at 02:57:13PM +0900, Changwoo Min wrote:
>> Hi Emil,
>>=20
>> On 1/13/26 6:41 AM, Emil Tsalapatis wrote:
>> > Add to the tree several C sched-ext schedulers developed and maintaine=
d
>> > out-of-tree by the sched-ext project over the years. These schedulers
>> > demonstrate sched-ext's feature set and provide a starting point for
>> > scheduler development. Place the schedulers together with the existing
>> > examples in tools/sched_ext.
>>=20
>> In general, I am okay to include more examples of C schedulers in the
>> kernel tree. However, I am doubtful whether it is worth including the
>> nest scheduler, as it has been barely maintained in recent times.
>
> +1 on that, even if it's a good example, it's still unmaintained code.
> Maybe we should just move it in a separate github repo.
>
> For the rest of the schedulers I'm ok to include them in-tree (still unde=
r
> the assumption that they should be considered examples).
>
> Thanks,
> -Andrea
>

Makes sense, I will remove the nest schedulers and resubmit. Also wrt
testing, I'd like to note scx_sdt depends on changes in the current
bpf-next to verify, so it should be fine by the end of the merge window.


>>=20
>> Regards,
>> Changwoo Min
>>=20
>> >=20
>> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> >=20
>> > Emil Tsalapatis (4):
>> >    tools/sched_ext: add scx_nest scheduler
>> >    tools/sched_ext: add scx_userland scheduler
>> >    tools/sched_ext: add scx_pair scheduler
>> >    tools/sched_ext: add arena based scheduler
>> >=20
>> >   tools/sched_ext/Makefile               |   2 +-
>> >   tools/sched_ext/scx_nest.bpf.c         | 652 +++++++++++++++++++++++
>> >   tools/sched_ext/scx_nest.c             | 240 +++++++++
>> >   tools/sched_ext/scx_nest.h             |  18 +
>> >   tools/sched_ext/scx_nest_stats_table.h |  20 +
>> >   tools/sched_ext/scx_pair.bpf.c         | 610 +++++++++++++++++++++
>> >   tools/sched_ext/scx_pair.c             | 180 +++++++
>> >   tools/sched_ext/scx_pair.h             |   9 +
>> >   tools/sched_ext/scx_sdt.bpf.c          | 710 +++++++++++++++++++++++=
++
>> >   tools/sched_ext/scx_sdt.c              | 101 ++++
>> >   tools/sched_ext/scx_sdt.h              | 113 ++++
>> >   tools/sched_ext/scx_userland.bpf.c     | 344 ++++++++++++
>> >   tools/sched_ext/scx_userland.c         | 437 +++++++++++++++
>> >   tools/sched_ext/scx_userland.h         |  17 +
>> >   14 files changed, 3452 insertions(+), 1 deletion(-)
>> >   create mode 100644 tools/sched_ext/scx_nest.bpf.c
>> >   create mode 100644 tools/sched_ext/scx_nest.c
>> >   create mode 100644 tools/sched_ext/scx_nest.h
>> >   create mode 100644 tools/sched_ext/scx_nest_stats_table.h
>> >   create mode 100644 tools/sched_ext/scx_pair.bpf.c
>> >   create mode 100644 tools/sched_ext/scx_pair.c
>> >   create mode 100644 tools/sched_ext/scx_pair.h
>> >   create mode 100644 tools/sched_ext/scx_sdt.bpf.c
>> >   create mode 100644 tools/sched_ext/scx_sdt.c
>> >   create mode 100644 tools/sched_ext/scx_sdt.h
>> >   create mode 100644 tools/sched_ext/scx_userland.bpf.c
>> >   create mode 100644 tools/sched_ext/scx_userland.c
>> >   create mode 100644 tools/sched_ext/scx_userland.h
>> >=20
>>=20

