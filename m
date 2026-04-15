Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073B3FFD
	for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232935; cv=none; b=peC6MX/BVRLsOOku+AjBDsssExBRIkhKKdp+dCS8h/Y355vfhg0uMKk2OUgViXdHOqp0r2enO9QiCbWmHV39ilit89VI/1HnM+LTrd5nHnJB6dmvgd5deoPlBf/FvulL2abxHJSdfy96MAYmWZ8LicuPQi3psgW6URHTWoK5tGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232935; c=relaxed/simple;
	bh=BFI4cPodxwVV3TvcCeaoMe0bXGI5djgMAdqnDe1leHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNugUvY/Aapjd9QrrT8bwiDBtz56GT+MpEtTVkTfeUpGoe1TAC1BlY5NM+OYVi9tpp0hP7Yiu/8ZhC3t1k5URwJ9hN2zZknDLhQqUeHeGN8Jb0itNVsy1X2M/AmrsCbyKJgnvOojegMLSn1ncJfyeviXzUY/vYKhjqCK9vJ7UF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzxt5ime; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzxt5ime"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b4650d5f5cso11349375ad.0
        for <sched-ext@lists.linux.dev>; Tue, 14 Apr 2026 23:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776232934; x=1776837734; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qwR/JvXIufIng//jeNtzV6+wlCVfsQL9+54aeW+MS9o=;
        b=Jzxt5imew8v29eidFhl4zef7NxEs/1jTOq6gXy7IDlJIwa9LENEo+JryG450OhveL0
         BqWrbA3+WXwRTRIH1s9LxBf5gTRodkEPCKqcZOsJeVlSKC1aq4rdrLygrM3XlOzf3b5G
         8A7KQjpbCcxa5QtuaN4LtYuWHFySdp7U3MqSfehFtdUkLLPf/aQ33E2Cw6lCkT9ZDAlZ
         4JU6SHSX70H9xbbXvUeBgqxeaIQDAA0uuygoqaTCvSs3zCWbL07SNuZB4sTfqSwPxCdE
         UkLDHdd25Hy/G1NM0xu0dHJcKlRsGf5M2Pscvvp3Hrwl4fj0fsbtzjDUX073zRii3ir2
         5sRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776232934; x=1776837734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwR/JvXIufIng//jeNtzV6+wlCVfsQL9+54aeW+MS9o=;
        b=acG+J3jTub3s7rLaWHoo6PGbwka7szMkufRjp+x+rLpfv0HA8ijMU5tYXaoh+++lx0
         Lc7c+/nTvOsH6avjQKnHXUljTPQfMgFFbdxDrITrggCv2m2URxTnKvEwDKXCQ4MeTRy7
         BWL9f/hD4d82cabgRZCTnmgM3K88fhnNfnbR5zZf5XPaHaSwJzpY7WXQFj3cgphV8GKi
         UuauFyKeq1DjoB2bJRcCltXyk1Con41Oo6iSdOT8ACRHwbUF6upcTV7pGPYi+9pye2qY
         pGc7JlK9bjPQpIC0oLWFesSH5mNJVX1Ws+nRW+FeQGr8QE8x62rfR9bv5Sigzj4s5Epl
         4itQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Y9b6r7bjcvFa2YtrTvxbGLK0XPIGJBooToOnPyC3CYMWKN27RzLAOGWBMijRKaJeKJWJF3ElkLMc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxg+EZQVoiBhdLINlRAaaODwbBtyii31B8tbA2TktHh4ocoEzXP
	hIJYkCQ2hbgnASePVTI2fT/U1BOneaCh9NJ1sqfq/djgDVV+Drxs5zrO
X-Gm-Gg: AeBDietMEXItNEeHpRI2MrTM20usVmcyt23kiNWVtdLljygoO+ZPksL80tYb0gbshCp
	b1hLHtVGNjP51LCFgaWshKVp5rzQMrMGIxjwn/5y/b1AbcgCJ4lqKhPbwBOkW9yoUA6BO9OzVAE
	XilSG7mnvxC4iLDI/IPxvneomcx8jc4boDdOiX1DbpwJKVxe5q+/prTUgzWOJ976Qyt1M5K4FGY
	XwB5pLKcYEEm+M3A6ZrU5/BT4neETFHeQ9Q7puROaSQhd3ke4ghEPopRS+s1jZFEFTjTVpJ3ADJ
	MxYfPMTPZUWH6vLiVzYFrA5BbZrLjFhYZtCWe+5b7lUuuWvwIzrRKO/sbWIVWZjlxqWBGKBWQ7B
	D8Yl0r/TEEqIbLV2XvjJ1hgJDpTXYd3NKqJRI2C/sIw8Ei93D5mFX62JjpPqrgVTGVm6DmSS//w
	k7CWg3XN9QExCcmPfzqSNWYkegjxUSpWOch3fwONE=
X-Received: by 2002:a17:902:d50f:b0:2b0:b290:f2f4 with SMTP id d9443c01a7336-2b2d5a557d5mr205813685ad.32.1776232933615;
        Tue, 14 Apr 2026 23:02:13 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:839f:5f0c:bfd1:44c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478294874sm8039535ad.59.2026.04.14.23.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 23:02:13 -0700 (PDT)
Date: Wed, 15 Apr 2026 14:02:08 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Handle pinned tasks in scx_central
Message-ID: <mzqpqngaraq74zyxqsidphn2rs64mohdccvjnbeqjfqnyecy7j@bndj4tz7nstr>
References: <20260413110453.357198-1-yphbchou0911@gmail.com>
 <DHS4U9BLRCPG.1S9E4BT1UIHQT@google.com>
 <s3khi4ec55rog6tgbgxip5skqjdhimcemhwzf3h7pbbvxslnu7@5r4v7jbv4w7z>
 <ad6rDORuL6SAYCN9@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad6rDORuL6SAYCN9@gpd4>

Hi Andrea,

On Tue, Apr 14, 2026 at 11:01:00PM +0200, Andrea Righi wrote:
> Hi Cheng-Yang,
> 
> On Tue, Apr 14, 2026 at 11:45:59AM +0800, Cheng-Yang Chou wrote:
> ...
> > @@ -155,6 +166,13 @@ static bool dispatch_to_cpu(s32 cpu)
> >  		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
> >  			__sync_fetch_and_add(&nr_mismatches, 1);
> >  			scx_bpf_dsq_insert(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, 0);
> > +
> > +			/*
> > +			 * Kick the task's home CPU to pick it up from the
> > +			 * fallback DSQ promptly.
> > +			 */
> > +			scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_PREEMPT);
> > +
> 
> You can also pass SCX_ENQ_PREEMPT to scx_bpf_dsq_insert() and avoid calling
> scx_bpf_kick_cpu().
> 
> More in general, do we really need to preempt the CPU here? It'll be preempted
> in the central_timerfn() handler later, right? If we preempt the CPU here we may
> have lots of preemption events when many affinitized tasks are running (i.e.,
> stress-ng --race-sched 0).

Yeah, this is wrong :/ Thanks for your explanation!
Will fix this in the upcoming patch, enjoy your time in the UK!

-- 
Thanks,
Cheng-Yang
