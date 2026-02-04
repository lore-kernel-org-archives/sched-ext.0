Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358303AE6FF
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198664; cv=none; b=Vt3bbAhBTrgiEUJS5XInvbBQk2aUzsBMw797IVIy7/Bk9vzQK02OjMiRsv3ls/2+0dnpdff7k8GXbEvOzHanh5mt0Mpdf7vDDO7HlpgggS/grn/haiQ78So7TOMlTRea1yvb+0ACleEIcQQNV2lIF1tjg+K7yK7FzNQCrBMdyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198664; c=relaxed/simple;
	bh=vLvss+Df18mwcv3kvmTDuXXVfLHpH42VLJXIFjNzRQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ic8BWVP9zuzMStLlTl8t/vyHv/BPNln3fADnpSRzNCBDbWtnEKcp08bRHeuX+F3j9/DGEnGtvr8jFBk2wUlPIcoEMp4z+/nUtmvQabg/aWzXMDLIzOdu0Bd8MeE+xHstGfTb+a8DNsX0PSDf/uhmPTk6I98iV+7v9CI/rLvZnAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FoN8SHqm; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FoN8SHqm"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-65811f8a102so5984688a12.2
        for <sched-ext@lists.linux.dev>; Wed, 04 Feb 2026 01:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770198662; x=1770803462; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=70cmIgnUVUOGlf8++R56za90YLRrQn92YMbZ46tqNGY=;
        b=FoN8SHqmIJS0UQbQumQCNfYmK0lwc+vcpOpEFKM66fMImHI03HrZCDlVCPaSf4SzTx
         xNWTbWj0FrqvJWv7L4kvYUzmBQO3fa7uAahT1Pc/YmmB1VDevLZlRGeC93Yr/eAgrnI9
         zaLOJeviq066ws68MIYqzH6Us00ndMc2mRtWo2qZP8Jkz2VdUOCCeGLJ5oyJogx+unF+
         q4959QVSSF7GVX6jrwD/KlhvqROzL9lYKdV+u2KL8UrZUYnzhBOwoMFWqMGkeI8b7zPt
         ORXO9BGNCw72OQf8UASR8hi2aOF3HqhpYpNaV176wN08jiWhBthPnk83ik5l4nIIq4IL
         viug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770198662; x=1770803462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70cmIgnUVUOGlf8++R56za90YLRrQn92YMbZ46tqNGY=;
        b=ePKw5wGL773kRICZs6fjMjK7wGV3r5mq1TUvf+SF6Rk87nbUzqH3e+Y5amBmh4jOZI
         8U9XxM9vCARWJyeFW/WsHJTRLESUKJjjXrSk9SVhGT7lGcfsWm4pSEqRNNTC2WjUlAf+
         +/vTBiabavfS4xf/bwziqWqWUpXzCYI5F0FbEVBnsmHJdZ4x6OEp4+qb7SUrVfVM2Oln
         CimOsRNssRLECni9qLGKUOnf/YZFXX0ZeAeySfkrTn+a4Ho/22u3AbFxzIX41IK3cHrr
         ChCFZxuD5mUO2Uc/dr9dmXjpqvwOdzRCFAfdNIxrw6xx2Y13VuSyOQvH9EOWN2crqdDR
         e8UA==
X-Forwarded-Encrypted: i=1; AJvYcCVYJGCRFe8EsqWoSgQOcOuPkq0ARYy5kO8LYdW1bIP8G1PzYXQSVMlXsF+yHi3NBwkexiq9ipakaXk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyb6in8HRGZHJOpGomuNL1X2eg1/FRRHrllEb/QF2IHtNmvYJ6r
	z/6JKFVeCYfOXFz5VkEgiAvDTSSzcCgrKi3bZZf2zvZiGIUtC0cj7EbCXy03FKj3qnjbwdvkyE1
	nQJC/R+uwLfm13Q==
X-Received: from edgi8-n2.prod.google.com ([2002:a05:6402:a588:20b0:659:444a:bd52])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5c8:b0:658:e713:2126 with SMTP id 4fb4d7f45d1cf-65949fdc209mr1438233a12.34.1770198662490;
 Wed, 04 Feb 2026 01:51:02 -0800 (PST)
Date: Wed, 04 Feb 2026 09:51:02 +0000
In-Reply-To: <aYMTOg8PoMKxK432@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260201091318.178710-1-arighi@nvidia.com> <20260201091318.178710-2-arighi@nvidia.com>
 <b868ee48-4545-4b1b-b313-d5863d65608d@arm.com> <aYBWAzFDX8Rv-paN@gpd4>
 <DG4J31HM051F.L7TOYLETMY2I@google.com> <aYMTOg8PoMKxK432@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG631YPXWWLA.1NQQ6JWR8MAJL@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Feb 4, 2026 at 9:36 AM UTC, Andrea Righi wrote:
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 292adf10fee1b..b189339e74101 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2260,6 +2260,15 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
>  		if (!is_terminal_dsq(dsq_id)) {
>  			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
>  		} else {
> +			/*
> +			 * Locking: we're holding the @rq lock (the
> +			 * dispatch CPU's rq), but not necessarily
> +			 * task_rq(p), since @p may be from a remote CPU.
> +			 *
> +			 * This is safe because SCX_OPSS_DISPATCHING state
> +			 * prevents racing dequeues, any concurrent
> +			 * ops_dequeue() will wait for this state to clear.
> +			 */
>  			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
>  				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);

Looks good, thanks :)

