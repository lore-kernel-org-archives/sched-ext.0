Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D943C05C
	for <sched-ext@lists.linux.dev>; Tue, 28 Apr 2026 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381230; cv=none; b=Z0OLW3yEh0rsKdQTycSwTWfd3xi6nIqSOfjgSYWOtfRaBgSOCiTqJF8XIE8T+VJzuOGAzCo0tmkrCfe1zznqHKpzJ7m14hodrR+p9moZpjRMfHx4LdLc2BhCs258W24zb669qWU1ATp1yTtH3oxSlJPhThLAbamLcBt7qmVGzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381230; c=relaxed/simple;
	bh=pXOTBlzOS4XFAor8wVp44/K+YV3cKSifsR9b0pwKmtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Aq/SkePXVNDT2mJAtdSGnaRWpuh7qTh11FAC2H0C+ALSIi1MRp3zk0EYhV14qs5DdRuk8elDGNVhgdbH9NX38keG01gm35gUMr7Yjquzj8/xozvQ4eYVnGzyoZ/Vgk0I5yfR1RpQWXBLuQwYBROHJj8IpdthuDelcBNi8XkRS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvZt9zQc; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvZt9zQc"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso79102635e9.2
        for <sched-ext@lists.linux.dev>; Tue, 28 Apr 2026 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777381223; x=1777986023; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FTVdVD5mINKkDtc8pjzLtIeyaI54xQ8u+57++otcEqs=;
        b=lvZt9zQcTz+0e+bnHiNtF5/V80yBUVVH7wHkDCnIFZWATlu0Q8nF2Pn1ikhusfUFQ2
         sou9bHvSbgDiYgEBFU/fYSBmpYoxnKwlGraZWQ/YX+VqHGrPft3CX9FZLC/K4v8urdXM
         1pxIytgAXTkNCuk2/kPcXyuSavUWTVhY8Q0j3PJjP/BjupWI9oDQoZRmEIhgZoFyICth
         p7X0yo+3HbATZhKA1drd4keuEbJYUNGRIWA2S5EI/hAlbqFWpPXiTPdM8EGG5cWDqb+D
         PMMX8LjNbpqL9D8pro6+G4e5qZZFX/pxVB287XyLI2m6NkM0BQtLvGf8Bm3GR2RpXKFf
         cZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777381223; x=1777986023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTVdVD5mINKkDtc8pjzLtIeyaI54xQ8u+57++otcEqs=;
        b=HO750sSnRIITyl6P8v87/pAZwl96tK/hxiss2HmL5yq0DNEudEL1EgVARQQVwcMZs5
         hddkSirkZA7MPSX3mHhE/8QxErU6Prwq36ep+g0W9ZUQfpzItdk21sRwmFWBORWV2uiP
         wnvHUQ5lyoOPG6gfOaQvp8UpVMbprMUO7KiRdOwq/WwtCXtVc2iEHWkh8atLBvxFvAat
         B2hrH/wFCFNEQVdN/tm0Ywd2Omkdx2cIywtGGsP20CUr4Z9AUbm9dJ2vD3CICIT7R+4f
         EP2oqvOGPXODILOahz51RmO2l1LHRVnvdvk3r8stGBrj25RDFtHObmKdYq+DEWdB2mHE
         4xsw==
X-Gm-Message-State: AOJu0Yz59ff2CsYdYo6RVD+keqaXhsn8v9VQ1KZxJtSfH0D33TYzg7FF
	8ssa3g1MQa6D64YDV5rj2f3yvVK7UcOLz54TftgHoOSXJ6PiBQbcG8Jhx6wn4BM1z+zySpivcxR
	/4aAWIsbSpmre6A==
X-Received: from wmth18.prod.google.com ([2002:a05:600c:8b72:b0:48a:55cc:4954])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d0a:b0:488:a824:fe04 with SMTP id 5b1f17b1804b1-48a77b1e893mr50478545e9.26.1777381223250;
 Tue, 28 Apr 2026 06:00:23 -0700 (PDT)
Date: Tue, 28 Apr 2026 13:00:22 +0000
In-Reply-To: <20260424172721.3458520-8-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260424172721.3458520-1-tj@kernel.org> <20260424172721.3458520-8-tj@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DI4T25FH7PEY.1VCTSR0XNJW7M@google.com>
Subject: Re: [PATCH 07/17] sched_ext: Add topological CPU IDs (cids)
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: <sched-ext@lists.linux.dev>, <emil@etsalapatis.com>, 
	<linux-kernel@vger.kernel.org>, Cheng-Yang Chou <yphbchou0911@gmail.com>, 
	Zhao Mengmeng <zhaomzhao@126.com>
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

Relaying a minor finding from Sashiko's review:
https://sashiko.dev/#/patchset/20260424172721.3458520-1-tj%40kernel.org

Might also be worth having a look at the findings for other patches in the
series.

> @@ -6727,6 +6728,16 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  	 */
>  	cpus_read_lock();
>  
> +	/*
> +	 * Build the cid mapping before publishing scx_root. The cid kfuncs
> +	 * dereference the cid arrays unconditionally once scx_prog_sched()
> +	 * returns non-NULL; the rcu_assign_pointer() below pairs with their
> +	 * rcu_dereference() to make the populated arrays visible.
> +	 */
> +	ret = scx_cid_init(sch);
> +	if (ret)
> +		goto err_disable;
> +

Are we missing cpus_read_unlock() on the error path here?

Thanks,
Kuba
