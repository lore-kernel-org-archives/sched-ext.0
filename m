Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0136A037
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770040768; cv=none; b=BBdBTCKNuwgVYadyjEiK0j466EOGjY764Cv9xrz6yXyHxu8G1ImtH9YHJwsibuJgO1bRM1VZGTuDO6u5Y78HYwdBksHkzR9Wtziq0b/6mN7A5DTNmAYbBqCsD7RnGdbrXKSI9y5iF0onXQhhf54qzd9/8Wk5nFLhq5pSdeJJaKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770040768; c=relaxed/simple;
	bh=7GpqL5xBpxxOzYwK1ZiatJgtIrWZ25EwDTOzl8gLm3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q1WzLwk5WvEVNS5kIpiWRatfyvbEl89i1e6GpBpxNbbs9ZRkHP6OaWbNHx9uH+MB14Ev1b8C/Nx53UP/IbG7E4kHXX9JyuIdmUy3lILFBJfTWw8dvCGf9b0ucgL8V/UqYS3M206oGyATwFX0KHomZ+2/qrUA7tm+K1QI6WehLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bN8cZG1h; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bN8cZG1h"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-434302283dcso5145977f8f.0
        for <sched-ext@lists.linux.dev>; Mon, 02 Feb 2026 05:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770040765; x=1770645565; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=45VMUXcTemBGf3CqcsoZ/vU9NbYkXPZ2OV0ZXsHP48U=;
        b=bN8cZG1h7tZrj8TEKv/nthX1qU1ioAuMQCcAk8WGlxKxc/0lAjg3oCkO42bQaSa9If
         qvGA5IFRobiVJtFyPJ69hrB0O7q66aHjtq3Rr21xiBrNR+uZRoayfZfsGN3dncmQx1lO
         Y5DN85Io8SAW1tExLHNIT34KMW9th8vZFSZtox18o2hsWmHf9yT+YvYimBSIv6TvXqbU
         OkIYJgnl6QnegRK3Zhd61rNYnT1Ayq5jz42fsOYdHtBPYoFAptIBJB4iQPP6iZRCERbx
         KqaQnSuBfZLlox7ubVCxEwWozZ40XXL4R/rFz0xqPi353tGXmcQT0i42FQpZbNy57xtN
         RPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770040765; x=1770645565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45VMUXcTemBGf3CqcsoZ/vU9NbYkXPZ2OV0ZXsHP48U=;
        b=eSDOhVaxUkJFm1qMg8DFswicoa1NcFWsZU/Okm+5oIMcuU/t5P+EWUxgX85Did6wnA
         GXfWPHpsVHtvAo759vnFoS16sEI3RzdoeVcDvm/tTUCrbLJGhQqy6uTnNoQOPf2Q+wZ3
         XDQ3XUMtraNyh5QDrPZyK46gWNfPhi90g1kEpbxTtN9FgiP2dIZP3BD/aUNebW0hMfls
         p4U8jODY41FsphpotWNFynAJjvMdxKvgX2YcICbbd4Eam4Z4K9DMcqBbhkFbYB0dQ5Xs
         eNDpEIgs65yxeVRGnFTJxl9zO0ThMFGOzpBEiN8pfcrsXfAl0C+8tDcBZsjUc8VLnQpQ
         ov8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBkaaF3jgVcUzp98iRpAAH5iopgGRCUX/HHGjUOQ4b+d1wpFgraKsc6otvG3FlCV+GMbToLW1VN8M=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5Sm8SZpMZ4EY3Gezea0SZ61btKItvQmF+PIqD+79wB0gbozkA
	mEoHWzOK1YXya4ifpFx9lesfqt+OQ5VHb1I6Y2+KAGyqan0N1gY04j6K+j/V2YnpjHnQ5o+rCmj
	9q3CVlpVCZ5Lz6g==
X-Received: from wrbch4.prod.google.com ([2002:a5d:5d04:0:b0:435:962c:27aa])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:26c1:b0:430:f3ab:56af with SMTP id ffacd0b85a97d-435f3abc7b7mr16762977f8f.48.1770040764862;
 Mon, 02 Feb 2026 05:59:24 -0800 (PST)
Date: Mon, 02 Feb 2026 13:59:24 +0000
In-Reply-To: <aYBWAzFDX8Rv-paN@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260201091318.178710-1-arighi@nvidia.com> <20260201091318.178710-2-arighi@nvidia.com>
 <b868ee48-4545-4b1b-b313-d5863d65608d@arm.com> <aYBWAzFDX8Rv-paN@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG4J31HM051F.L7TOYLETMY2I@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Christian Loehle <christian.loehle@arm.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Kuba Piecuch <jpiecuch@google.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Mon Feb 2, 2026 at 7:45 AM UTC, Andrea Righi wrote:
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6d6f1253039d8..d8fed4a49195d 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2248,7 +2248,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
>  			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
>  		} else {
>  			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
> -				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, task_rq(p), p, 0);
> +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
>  
>  			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
>  		}

This looks risky from a locking perspective. Are we relying on
SCX_OPSS_DISPATCHING to protect against racing dequeues? If so, it might
be worth calling out in a comment.

Thanks,
Kuba
