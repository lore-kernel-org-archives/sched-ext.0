Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E94F339705
	for <sched-ext@lists.linux.dev>; Mon, 15 Dec 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765811163; cv=none; b=NQOVwiVSJcUfVHrHCWX6IVd2GDbBLAOJT0LqIc7VQMDZhMIcqqhzxA0zR8fNKSyDrA9UT5pQtET/3fHjUju15rff2Bp93cdK3QwhIOynMjY3GTCt+0HU6kQzWQivRzrI5oXQ2aPHQDDfWINSLMcVPQmsth2yY2roG164NOA+6uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765811163; c=relaxed/simple;
	bh=nrOkWpxHjNEBOqPfArlOaEnMZvp+OVYYOoIRNrFkLbo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=us75u8rY2obolnSolcxkFI65El1A0gt5wPZjaxs55e2tL0+WlxddghInESgIq9oobVqhM1wAEYonzefB/S4fL9auFr4c41sFrzghAKW9x3rqVmJFK1jsJExOkfTeiRxYYrnMp1vtuhZtY5B1x3ZRHrmOtXqu/+bu1qZItAwh+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=mYkcp/34; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="mYkcp/34"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed9c19248bso32824501cf.1
        for <sched-ext@lists.linux.dev>; Mon, 15 Dec 2025 07:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765811160; x=1766415960; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8UioMReDfbBNUZGk/2S8/TUNrw8scab+rc++O6vx8U=;
        b=mYkcp/34MOd7S+Vdwj6u5Md+zxWMDNWn8gRc9elL5jllTQC2NWD2L1se6/Zkxt67vT
         vTm2pICwJPOw5G1mG6ucx0U0z/EJi88MGEGYxEfc2rLE/Zjq4mO8GaGsqDEe40zGIoFs
         xGwqlnEg0c8f3Y/MwKgnsRSvfjn+THnCLfgeDHBbih6ZqQEYe1DKleue/T+VyUalTUjB
         T6NlkQGV31WQIK1K/lIinV0U/0CLRo/5mhSwF2sDCY6jj6iL98a7TPZIJU/zcWvd13+m
         kQdNU/oJD5liBluNBZKhc5/8lNmFPujYg405Ke/o1SFZkRNwig1DLZWsGBbtiwtCkrG+
         a3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765811160; x=1766415960;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8UioMReDfbBNUZGk/2S8/TUNrw8scab+rc++O6vx8U=;
        b=fkBDnC45IpesbrXdfeNuUyax4x0A2OOwprYvPEwmLTB0+ZlBBXFhbIT0Kh5Nbpp9BW
         XgPJ80AjJAl98wt+RhIUquUCGPGToYdMRHHK2eIICA+fx8iXqXXf8UpA0g6bufw32zqb
         2atvM8mFI2mcf0DhYEZ5dt0SeEqr/8CF/BWrvW6fT0SaLizQU/QF8+mgwgjJ2IkOs82v
         Vhu8yNIM49/xrFNdYWggYHJDlhmKczCD7jsiv2WEqLm9tczajOOC1eLEF+42Dh7GMcU1
         oTR1ORZscu8HCNqs2Bq36s7NKBnMTgk+7bovg00cEhUuRDlHr9lLi89NIrNHsFXMyPIp
         TyXg==
X-Gm-Message-State: AOJu0Yy1SlTpab3QTkjAkTFE4ZeStBi5OgU9hqagxkkmJqcjqeJdTi/o
	QFvCidNolm5RmVpoykuo3FATLR0ApH9/nAsYsWcWjnbmQRSIkIMRF/bJhl4DjqpqAJo=
X-Gm-Gg: AY/fxX7mFGzjDIIddBzs1xXoLCVtKcCEnldAV1vGEKI4HEOhg+xbuosKvGeWCU3rrE+
	Rk6SVAWBgOLfA8n+B1RzVbbZUUOTn2UbyiNO8Yxc5sb/55zZ2xXKOUJC/h4+615P0mUp9+6FMW6
	/7tQjrwXm/6UnQubMzu4PErxjRMyTZN3Cjn9AbWNfMMnE9H9k23zwTMut+WlJdI1RJCdEB+sarJ
	jdNelwMBdA9a74M/yyRA+HZtwNnhOBnCmKkRlYLduuIsZdJZLJPlLZqeuKg94k0qbqu0qdgSw9C
	rvOYSUGuQa+o/N/y1ipmmU+SYmk4MHlyqZJs6s68Emd67/imkgKr3SPDSHmKtGRl6XTFJGld1e3
	6NJTNWZi2awKvSxpHm9pJsV7I4F9LwsZuUBFAgmb3qk+pvzhv7slK2X+3oOWRTjTs9eCuPGwFPP
	0Gg5lTcyAkpx4=
X-Google-Smtp-Source: AGHT+IFf/1z4E8WernvLA0LqWEq8FCxr779h9f4/oeq1UH2bhP28LEaUKg0/8EUQOpyKrasmcQwaLA==
X-Received: by 2002:a05:622a:2c1:b0:4ee:18e7:c4de with SMTP id d75a77b69052e-4f1d0622d74mr168157141cf.78.1765811156465;
        Mon, 15 Dec 2025 07:05:56 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bb78f21a50sm639135285a.40.2025.12.15.07.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 07:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 10:05:54 -0500
Message-Id: <DEYVT9MLT9MB.2GOBKYGZJ495Z@etsalapatis.com>
Cc: <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched_ext: Remove unused code in the do_pick_task_scx()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Zqiang" <qiang.zhang@linux.dev>, <tj@kernel.org>, <void@manifault.com>,
 <arighi@nvidia.com>, <changwoo@igalia.com>
X-Mailer: aerc 0.20.1
References: <20251215112940.23640-1-qiang.zhang@linux.dev>
In-Reply-To: <20251215112940.23640-1-qiang.zhang@linux.dev>

On Mon Dec 15, 2025 at 6:29 AM EST, Zqiang wrote:
> The kick_idle variable is no longer used, this commit therefore remove
> it and also remove associated code in the do_pick_task_scx().
>
> Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()"=
),
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

The change seems reasonable, but why is there a fixes up? This is
followup cleanup, the original patch is perfectly fine.

> ---
>  kernel/sched/ext.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 695503a2f7d1..94164f2dec6d 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2446,7 +2446,7 @@ static struct task_struct *
>  do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>  {
>  	struct task_struct *prev =3D rq->curr;
> -	bool keep_prev, kick_idle =3D false;
> +	bool keep_prev;
>  	struct task_struct *p;
> =20
>  	/* see kick_cpus_irq_workfn() */
> @@ -2488,12 +2488,8 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *r=
f, bool force_scx)
>  			refill_task_slice_dfl(rcu_dereference_sched(scx_root), p);
>  	} else {
>  		p =3D first_local_task(rq);
> -		if (!p) {
> -			if (kick_idle)
> -				scx_kick_cpu(rcu_dereference_sched(scx_root),
> -					     cpu_of(rq), SCX_KICK_IDLE);
> +		if (!p)
>  			return NULL;
> -		}
> =20
>  		if (unlikely(!p->scx.slice)) {
>  			struct scx_sched *sch =3D rcu_dereference_sched(scx_root);

