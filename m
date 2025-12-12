Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8C2BD024
	for <sched-ext@lists.linux.dev>; Fri, 12 Dec 2025 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519068; cv=none; b=loyedilOp8kLSDPN08R9FRBxV1NRCiBWJ+PI+aH9eg9dLlBub9uyDouGANmrSN70vznstnpXj/zwPjZZXNweqjA2D88wHx+Tc+ksvui43eHxxVHqYxVYZIl1jjgGpd29f+LO9lE4yky7B0s3QccbeWqCpWL/rA+SmyO22L4xnvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519068; c=relaxed/simple;
	bh=fgsSX3Xvqg0pVTixbgqmuCjN8XlgMkq8rvUKPfF/H5k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JmGJ8YMTQ9GsplOS1SzLi5+tDDYjOPwLRGo/T6rizoZdQhtZiz3fOEnSFCEarbemHvi4nNogvw7DFye6V6wmekE1HQew+zhVs8cDpBxvN0U2EB65Xj5GJu6+RK3wSB2WUlW/8WbbtMZQk4SpjYiS3wWvmRGYEHDA5q6Em/1WfBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=xe5JOAYq; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="xe5JOAYq"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2d7c38352so90616885a.0
        for <sched-ext@lists.linux.dev>; Thu, 11 Dec 2025 21:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765519065; x=1766123865; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+obT2GMuFzYEIOMsvhKf6eth8yBNwnM9yUNGgmvY90g=;
        b=xe5JOAYqTXZNgFbXhJSut5owt+NmuTSomlHwPMdLPjrxHPvXpRUmcNIR6x7HBXMfN/
         XTvElF98DYPM/zbvxLCUc86br/+2oFpk9ScGTTpDS15KSfZrCfXUmHqnCQ3FdX3YuVBg
         LAO2uFMKJQVJRF+hj/qvTRGPzD5DV4R/Ba4xDjhhDYUC+/v/6Nc+1z+G52n5YTIPQO28
         j5I0zJ9auPo08497s9aLr9b2ynbX7RFkUuIJ0Z37OR4oQggOi8IEwV9YMr4VPh5y9fQQ
         gFQZJ80ABKR9MIUOZT2kW1oMxOQW4hHQzI8C1KR7Yh0rqMCyqKgzyhVKjpF0Ans1v3Un
         jhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765519065; x=1766123865;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+obT2GMuFzYEIOMsvhKf6eth8yBNwnM9yUNGgmvY90g=;
        b=SNPatMkfiBQRadj3B9oPEsGkaunsJHH3JXUzDSK8N+BVGYBCO7BmZv47xpAE8dis2P
         hp+Q1nSxWkjcuQqu/6xa7HjgoT4/urpU9YouRxQLFc0juP80zDUejZIUZFiRcCodIlRl
         PATCwywg1XzwaW6Exw8OltD/hqLhFUcjH088JfcXisGw6RmRNmFGdoW+AGDBs7Jqdk2H
         7pdCwRAVfiRVyoSUZGeIFtQJgt9/mXtp+N2f3+fgQIH8YdLbtAS1JX05/yYeCEWdBK7X
         FeFNiroPvtH0ua8ECL4Ru8MADG4BjQ09SDHmUOcacRR7J7uwJU0/5g5P9GefP/0T2EO1
         8EDw==
X-Forwarded-Encrypted: i=1; AJvYcCVdyBjDnvSCN6o//Q/IhB/RTCplEWsh/71RyWbpQwtKr/dq6woZLrMCRhN7YEJbAO0jPnRgrv6wLPg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3QqKh1F8yfN0X5q8ziqmCaXDOq/y1vchVecpZgjMkfpXW5BEw
	mbxqFNij7wN3Fqwb5IKwM6bk3CRmk3egRnqaalxbbTRrnJmxxACW4fR3NHR9r2w5gNs=
X-Gm-Gg: AY/fxX4GCJtGBUTAwR4s3Mm+ftTRbMRBMGHkuqUPDx9rmvr5QjMjMZDVWUs+iv0gS3I
	vUzWUe75Zx/rqGDxmXFUOKN8cl2sz6LB1/6bj9bnPK+tiw1VkEBvh1YfWbUbyoTWrj8g8X7QZR1
	KobXwsEaxVh0xobIisZt1H9sG1fpO+Gu13vRWMOE3p96UzPeHx3bqORhDbrojsrjlrcMvJgggY1
	Ds0IAe/q/7CY1TtD4jJU/SqsE6s29xplp3zdYivA8Sk/ouVpa8C1W1NbMI8ZbPfk1fjA4zBGYcP
	LDmRHzopm8gbTMjJgowPbXN5pdkQesGeyMBMDAP36gHB7Vcor83iqpYkAeFKCJNNFMKy0h64EKT
	XL7bmulWSJshVgEklhJPR5IqdKgw6pRHN0pngvkn+C6aK1GBCDwbzTAAQH8fjp01A23KVPu+Qyy
	IVnTTZGU8TUbIQ335L7PePlw==
X-Google-Smtp-Source: AGHT+IFJyCJZmyqnZwBk6jh7An7wM8i4gimml50s/3knWSXiY1rTb4VzoUtzWii88NakKgFz7dRRCQ==
X-Received: by 2002:a05:620a:2a01:b0:8b2:76c6:a7cb with SMTP id af79cd13be357-8bad3fb038dmr613360885a.16.1765519064974;
        Thu, 11 Dec 2025 21:57:44 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d4edbasm381614985a.51.2025.12.11.21.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 21:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Dec 2025 00:57:42 -0500
Message-Id: <DEW09WJ1U1FU.IQ9B68XD9VAS@etsalapatis.com>
Cc: <linux-kernel@vger.kernel.org>, <sched-ext@lists.linux.dev>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched_ext: Fix missing post-enqueue handling in
 move_local_task_to_local_dsq()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "Andrea Righi" <arighi@nvidia.com>,
 "Changwoo Min" <changwoo@igalia.com>, "David Vernet" <void@manifault.com>
X-Mailer: aerc 0.20.1
References: <20251211224809.3383633-1-tj@kernel.org>
 <20251212014504.3431169-1-tj@kernel.org>
 <20251212014504.3431169-3-tj@kernel.org>
In-Reply-To: <20251212014504.3431169-3-tj@kernel.org>

On Thu Dec 11, 2025 at 8:45 PM EST, Tejun Heo wrote:
> move_local_task_to_local_dsq() is used when moving a task from a non-loca=
l
> DSQ to a local DSQ on the same CPU. It directly manipulates the local DSQ
> without going through dispatch_enqueue() and was missing the post-enqueue
> handling that triggers preemption when SCX_ENQ_PREEMPT is set or the idle
> task is running.
>
> The function is used by move_task_between_dsqs() which backs
> scx_bpf_dsq_move() and may be called while the CPU is busy.
>
> Add local_dsq_post_enq() call to move_local_task_to_local_dsq(). As the
> dispatch path doesn't need post-enqueue handling, add SCX_RQ_IN_BALANCE
> early exit to keep consume_dispatch_q() behavior unchanged and avoid
> triggering unnecessary resched when scx_bpf_dsq_move() is used from the
> dispatch path.
>
> Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_=
dsq()")
> Cc: stable@vger.kernel.org # v6.12+
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c78efa99406f..695503a2f7d1 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -988,6 +988,14 @@ static void local_dsq_post_enq(struct scx_dispatch_q=
 *dsq, struct task_struct *p
>  	struct rq *rq =3D container_of(dsq, struct rq, scx.local_dsq);
>  	bool preempt =3D false;
> =20
> +	/*
> +	 * If @rq is in balance, the CPU is already vacant and looking for the
> +	 * next task to run. No need to preempt or trigger resched after moving
> +	 * @p into its local DSQ.
> +	 */
> +	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
> +		return;
> +
>  	if ((enq_flags & SCX_ENQ_PREEMPT) && p !=3D rq->curr &&
>  	    rq->curr->sched_class =3D=3D &ext_sched_class) {
>  		rq->curr->scx.slice =3D 0;
> @@ -1636,6 +1644,8 @@ static void move_local_task_to_local_dsq(struct tas=
k_struct *p, u64 enq_flags,
> =20
>  	dsq_mod_nr(dst_dsq, 1);
>  	p->scx.dsq =3D dst_dsq;
> +
> +	local_dsq_post_enq(dst_dsq, p, enq_flags);
>  }
> =20
>  /**

