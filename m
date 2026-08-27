Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7E40DB42
	for <sched-ext@lists.linux.dev>; Thu, 27 Aug 2026 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823531; cv=none; b=YHmbHlY4z5EnaOkJjhNOBCykxs9/Iok3GG3tCVMZ4Bbo9vOK7njYZK9gp04xKbYl3God2e6pB1P5/WDWB4R04XnLJBgNPBiYCaVGstuDy8lQbtQMoKNQZirMQ3vegVKLgfBa3i3pmAVDmnYyICmq2Kn6k9bPRI53q9YXCcWrJYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823531; c=relaxed/simple;
	bh=Acbi/5Z1s4IMhsfByjxEE/zcDhBASoTNbBSqV/XBPS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u86ggBAZ8HuVEkPGKVyJIL5cGWZJZ7iTa43pk6GGJYX1pd8q0fhWt60pa4bAwnUc99FurQnQPaiG8uAAMwHhmqJoehzu8C2kkIdTgxwe1xzCLACJVr9bIx6Iuej8goIP94Q732hVi4Qs26k+YAvbCWwuBmdBI8ZAYqetJFHhuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPOBd4hb; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPOBd4hb"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1c9879395so1560406a12.1
        for <sched-ext@lists.linux.dev>; Thu, 27 Aug 2026 02:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787823527; x=1788428327; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fh4l8uX631Tci1dujRkQbbJ7tiB/SAC2IQktwximJc8=;
        b=HPOBd4hbSoisUyullHUAgdMND6Jwqoikg2KpuX5awGPspWGUVQSmkCwOGVpi/9frwD
         rSTEJ88rTdXmv5sXHBDsDWky8padTzdGMjKSTskG6F2vVhO2B84pW3zyy1yy2aSN6fwj
         r4ZU9aSot6CJHLMO5nJt1vzKiXGrc/mO4oBtwV0pFXo2Sf0vf6HZzFwOH2dUAbDCOjDI
         T6P9kKztZilJcEv94S/8aw30rMJcnZBP/EO5VwsfDxPad/Xi9QDbn2psH7AnZRI64McS
         2ZtmUrO30ZJ4cQpd81LsNUMhZnsfkri6rYvg9bBvN47quCzT/oWiYmrqUbiAEmU9aXmD
         VXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787823527; x=1788428327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fh4l8uX631Tci1dujRkQbbJ7tiB/SAC2IQktwximJc8=;
        b=dPsqEOdx8JXjGd2jKoDnnPO87bz3CVVZ1qK20icThvueOgN44qzzRVCb7CKMX97Pj0
         zfbIZ45DjLdL7vl0p1+Kq2JNVyBToCs68NznqEVUTg3x/Q+GJ5LKE7a624/nznSCBzFV
         qv704hPgF4bvXnY2t1TiHivIvKz1ODHIY8OtaHDDzp2XrqMvNYd1YQSook+YTqeGikt3
         d0/8XjiQ1v2V0r38RVTAaYX7aB2T71sea0HXXIzFxv2YW3YbvKE/rWtntM/OZ0v8IdIs
         7m+Cb3Y/0BfhRoKgHBUXIIzlb87IWOQJlLqfd/m5O0CNrnfUUf6OOHbGMD0ijfcAwOzb
         vcig==
X-Forwarded-Encrypted: i=1; AHgh+Rqhq9/JZHF4kDRU4ynBdvMkDrDeLRuzllzEGo7pJO/oWOWDpRGPeIhY65PBgq8FXySNqwB3949uGl8=@lists.linux.dev
X-Gm-Message-State: AFuF++mC/07uT7i74HKb1bCPdTVzyr1bbe5ZCzwxLfIAsaQwf2u2a75H
	oxiH3Z/LeWCpr5cI2TKIibC0HESIRM49ngLVu/ldLNhI8EZeO0FHWQp6
X-Gm-Gg: AR+sD12eB/FFkIBLConjOEBcNuR8+uoIChFTGEPp1B/lTVJ7nngZ/lGiJmjxsqMReg5
	NdhMJusghfsC6rJPFMRRik4l6737YRd2ZuDgNlsLpShn+0u1wdTRDkiztkrjgvxLRvHaGNPGpVM
	wimdu+olS8l5HW9+dlD8tkkAWFgyJUCSI3HUh/t3IIqKlXlH+zjcNGkw/iNtQrz7CzKwwaiLzuL
	QioTql7xpdGYPQbpWqynF2hfTx2cn6AkhGw3RmZLr/2upk8LXmjLUwTivztejF+efAiaZvbulXk
	dpOYoWhbo61FQC4eEjF8zrscCNKRG6+Gz/H0Ocr1Dv1rCbPZcwpjYdAR7T8GHZ5zTxmCbccTowz
	PjX8/eWHiUAFi9OgHosrJdnxd2gp3yz+M+Kyc7kB+KsU7+4Muj1de1BGMVd22tTqRpyDHzvxtYJ
	Pa/E8Vu6RhXFOsTIXCW7Glll8qKeQk9+Ziob8PH8klrfBrvSIsYK2IJ7VLIUd3oN5rJbVgkvuFN
	pM1
X-Received: by 2002:a05:6300:6690:b0:3d1:af47:5f80 with SMTP id adf61e73a8af0-3d1af4762b9mr4401002637.11.1787823527042;
        Thu, 27 Aug 2026 02:38:47 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1bec7f491sm1905900a12.23.2026.08.27.02.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:38:45 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: fangqiurong@kylinos.cn
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH] sched_ext: Skip per-CPU data allocation for built-in DSQs
Date: Thu, 27 Aug 2026 17:38:38 +0800
Message-ID: <20260827093838.532352-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827082329.3368255-1-fangqiurong@kylinos.cn>
References: <20260827082329.3368255-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

On Thu, 27 Aug 2026 16:23:29 +0800, Qiurong Fang wrote:
> Every built-in DSQ still carries nr_cpu_ids * sizeof(struct
> scx_dsq_pcpu) bytes of dead per-CPU memory.

It is quadratic rather than linear, which is worth saying.  The number of
built-in DSQs scales with nr_cpu_ids too, because most of them are
initialised inside for_each_possible_cpu():

  ext.c:8681  SCX_DSQ_LOCAL
  ext.c:8683  SCX_DSQ_REJECT   (CONFIG_EXT_SUB_SCHED)
  ext.c:7172  SCX_DSQ_BYPASS
  sub.c:672   SCX_DSQ_RESCUE   (per rq, via scx_rescue_init())

Only SCX_DSQ_GLOBAL is a single instance.  Each of those then allocates
nr_cpu_ids entries, so what you drop is on the order of nr_cpu_ids^2
struct scx_dsq_pcpu, which on a large machine is a very different number
from the one the changelog suggests.

The guard holds.  ext.c:1130 is the only read of dsq->pcpu, and it already
sits under !(dsq->id & SCX_DSQ_FLAG_BUILTIN) at 1127, the complement of
what you skip on; the local DSQ branch above uses sch->pcpu instead.  All
five ids passed to scx_init_dsq() carry the flag (sched/ext.h:58-62), so
nothing is missed either.  exit_dsq() contains nothing but the pcpu walk
and the free, so the early return skips nothing else, and it is needed
rather than tidy: per_cpu_ptr(NULL, cpu) hands the loop an offset pointer
and list_empty() would read it, so relying on free_percpu(NULL) alone
would not do.

Two smaller things.  A Fixes: tag routes this to stable, which is more
than a memory saving asks for unless you see a correctness angle.  And the
mail header says "Qiurong Fang" while the From: and Signed-off-by in the
body say "fangqiurong".

Thanks,
Zhan Xusheng
