Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794238085;
	b=0DDnLypKG+ZMquXhWOH6h7FLaNjkU/7l+cyMUPrXGLm0X1V03FU9uzCFGRZd3RUujkPj
	 LySCYjT6PFPh+KHtCJJJQURcjq8qLn9c/UGsCxCQu3z3Hqi7wH9tJHQHb9RrUGXcKUqS3
	 CNwAmYaGrCPySjCMkyejMElZVWfuGtN5LKFQcmm3DkYAXrc4E7G3atTSCiUjAjGmslPsN
	 KkzE6Z6Zo1noS6IFMvBwiWlVIigNpPcIAaudJiybgmeyxG/44z9/byJXFu0a8lCSJ5Lsx
	 8xHFm0eOw2t6qNcz1tzVjP+AYVa5Etamn7YwpiAPy+hh85mbywWxzZB6JOEuryLodIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rc8neeysb2lhJi4v3fQWNja46WdfiOwuQ6GoM/+JvzI=;
	b=BT1h+Xc9TOYhqrkGicBPuOXu2hi8h4hyxQltSbkr7cL4Yojx7BtuSiBq4FguLM4xi9eb
	 HHFotbzEyfwTovdqaxNO75qKeg4t1U3oc9ohwQZi0FX12iY+U4pg9YN5slC6+cazbnKPk
	 FfwsAdDoXreSys0BU+IfJIyeUgSTG0MLHl/DLuF9zwySYZ3Ye5YrluGQXdxrJ1a6lJV+7
	 LlW0ecEJlHuG8zpMHNblzNnu/MoZv8SPPRFT0nTB6BGobgTA6maU4bHz+uQmYONzYJevZ
	 bxGZjttAQAy/p0b+rkFghmdPYwUQBMDsJ4/w+tw4+z6qQ31kvAgezAj4w58i0nhmbAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=usR8v6+j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6F606A32A
	for <sched-ext@lists.linux.dev>; Mon,  9 Nov 2026 15:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CD6F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=usR8v6+j
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b6e7a05225so1353515a12.0
        for <sched-ext@lists.linux.dev>; Mon, 09 Nov 2026 07:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794238083; cv=none;
        d=google.com; s=arc-20260327;
        b=q1c1/gtkrxUeO660kXAsos4nWbhxYYy1/G8WDaDxf9/gm26/yzdpB7CLCpqx8lQIm+
         eo3Xq/F0W6ior1zn++tWThCXMv/UdZT7OXCbVbgneh484B43O1DGL++3bkmNrXRlWCnV
         XR9ZD6FVUcUmxAP7H6QcwGRV9c7iVVDgHkVloNh4dajCtf2yEmjVzEh5Au5D/2TmAApP
         2v3M2SjsxJWBh/pSALHFMD0LlNjoVxTTEGJqvK9Ct6nD9jNEsxH9rfKVKJjq2lQXAu54
         jBrRV083jgHj9Tj9w0Ck9cFYZQu+i4ENJz6QnbpVCCrSii8/xYB8QDVZSNx7sk2OSHZt
         mnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rc8neeysb2lhJi4v3fQWNja46WdfiOwuQ6GoM/+JvzI=;
        fh=Q260PyzkSXK3KP/PZqTDKUPtiIRojoKTUS1JlWUtTRg=;
        b=n+/LzE0Zs26nX+XJGHjLXhHbKpFl1ZWnUH6/lePuZJClp6Uz6ZtKon3uRjjTCb0CfC
         QqO0AzZIMHcnUgb0HtPwWbp8OfWCahdKcm0TJxw7qUqxN/qmdLdbIAymIGCbFeljKIsp
         63Na63oWX3k3ybhV6QiPKq8pVvXQja6BAvXSZc3d+gCp6LxYmK8GAZI7gFUGopSFteFk
         sPIIuurEk/eoxWiCbipOH3UOvPHon3weOsk3/Oygh3aPIUX9yNlszRbRMxZIX4tX2N+P
         s0G5qrR6AgxuL4VYm7gkOwWt4knIfcLFEr2vrCYwy3A4k/FDSqj3F8hQNJzLxfMuWfRC
         cn/A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794238083; x=1794842883; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rc8neeysb2lhJi4v3fQWNja46WdfiOwuQ6GoM/+JvzI=;
        b=usR8v6+jpAmQtEJWGbZ/ELrPst2461QNbnmBOqroK8wTJj+4N+CODmFGYUOD0nU8b6
         1wUmh0BT3pczioLJ8wC21uhQZ+EhDCP77C6gHZiJ/XVbIyr1p7QCCW34KbgBeO0hQuPl
         AGIq8WBlotwf7GT/GBJJy2SA+Sqq6s6ABBN5YwzFT+lIhagsz/aF4X0phhfR+o/CjsnJ
         WGGgQDw6/zmmaSIumXlggZkcoRuLc3drALxi1pRfBJqnzU/4EkRaLcQ4tRSdrWao6zF+
         GgNLynHtBVKC+JjhqwzLiiwFRfR3KW5q6xVT/Ia4zfRaoD8+IrxHmwDpgMl0o+8ApxaG
         dXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238083; x=1794842883;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rc8neeysb2lhJi4v3fQWNja46WdfiOwuQ6GoM/+JvzI=;
        b=t/sdNllYAG+C1Nw+wOMOv3b/EE465JKwU+i7WB8vBmtg85UFvw0l1QfpXyldu/9Av1
         Hqeug+p2j/B9+d7hQyVLGvf8iuR7lxwif3kcuEWO+IBJGiW+ouJnlZWpWdNCVd1Lq2BL
         tcxgrIot94j/c2UYUycQNbYb4S5lGRh1oKTOCT2lsRBpi04FPqUNSMz0WQI+yewx0iEA
         wFuuO8oYHFIL3reYMY6Ti3/2+GtyU3ASC+sP+xI2qb5dSVNdgQx3226Vj6gZ0qz/nXM2
         FzHAq28QpVOUluYpuudFxi7SHO678zVDHDrwUquyiIMWcB2GZDMv6g2XCUXCQRElu6WM
         4AYQ==
X-Forwarded-Encrypted: i=1; AL+hErEM3guRkGYh8puMs/fJAX+0EjPhNc7E49BIx1utucARcdSkUI9Q8l5TLtfvklADQe816ab7P7P/4+M=@lists.linux.dev
X-Gm-Message-State: APuU4Z/NDAHWvMOaEbhKa/M8uL/r/9/zcJrUcAhDcBKDYe9G6jkYuBBu
	tYWyDyzqqyzLXNZN3rMoiXC7wmjA9kB4RQEPbOKW/PL7IrToy3bKLDwpjA2araYGupCmJ0nzb0k
	Oey4hYTyXE/Cz19YFyKRXhonIMQO9DVrnRKCS6WZDsw==
X-Gm-Gg: AYBFou3I7tIEOv4VykOq0tQnVrOlJOKYffvx09ZZ4G/wQRdzN9F8xZNDjAmbKNkmjTM
	5FshmYfxp3QUO3PJCUPxJk7lr+phtPFEzSiIVxBXdZJpOHQFBShnklH7pWgpOQMxKr4ZQfmZUod
	v/QcqzMsOIDQrZBGg38CkEGcUVvJKU3umR5YHCMlNxp9RgpfwmVvL+nWrG6bNg3AuIN4BCrtnwz
	AZQX5UjRgcn5XNc1cKx8FG4bK9j0gsm/G8FssGaC18TRW4sxkKAC6+3ljwbRiqyyv1iNHioXywz
	LxwMGfSgEr1OvmxMunAZ08Jh0L8BhPXaBngI8aUP1bjJ6niuC4C1ha7X9/dwwDPYJVEZp610YS+
	EThNIlqL/MVogmJkW4fbAgB6waxmYAi4C2jUYdXXoTPqa40SCPCFoqPZ+OI5ZRWM/vXkRGZvuNc
	/dC76VS3O6+O7q1t4=
X-Received: by 2002:a05:6402:4513:b0:6b7:28b9:f357 with SMTP id
 4fb4d7f45d1cf-6b728b9f818mr2731473a12.40.1794238083112; Mon, 09 Nov 2026
 07:28:03 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-6-vincent.guittot@linaro.org> <au4i4IWFvJw-7Q0Q@scheduler.schedules>
In-Reply-To: <au4i4IWFvJw-7Q0Q@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 16:27:51 +0100
X-Gm-Features: AclHuK-rDLMXgdJprNmM67KERGYoPJj3EfP3DSZ08EHC8kkLhXMU79a1MZdCg4I
Message-ID: <CAKfTPtAwAkm1NaZac2HKDPgAOh=7OjasQRwgr=e5jfSeQe_R7A@mail.gmail.com>
Subject: Re: [PATCH 05/20 v3] sched/eevdf: Add per cpu cached min_slice
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Nov 2026 at 07:53, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> On Fri, Nov 06, 2026 at 04:19:32PM +0100, Vincent Guittot wrote:
> > In order to use min_slice during CPU selection, update a cached value when
> > needed after en/dequeing a new task. This cached value includes current
> > task.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/core.c  |  1 +
> >  kernel/sched/fair.c  | 28 ++++++++++++++++++++++++++++
> >  kernel/sched/sched.h |  1 +
> >  3 files changed, 30 insertions(+)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index d7c3b43158de..031efe7d49fb 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -9012,6 +9012,7 @@ void __init sched_init(void)
> >               rq->sd = NULL;
> >               rq->rd = NULL;
> >               rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> > +             rq->min_slice = ULONG_MAX;
>
> This is already getting changed to 0 in 6/20, instead of changing there,
> wouldn't it be better if we changed it here from the start?

Yes, the rq->min_slice = 0 in patch 6 should have been part of this
patch. I merged it to the wrong patch



>
> Aside from that,
>
> Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
