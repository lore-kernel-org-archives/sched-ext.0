Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8D1FE47B
	for <sched-ext@lists.linux.dev>; Tue, 23 Dec 2025 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766495817; cv=none; b=qQ+7ziXc8fBh+dzJdv5tDTpcjCmIaUNtDZb6LneUN6+qs9eqcx11N40kChLqC325nrYe53AcCeVhcc9M2yE4GU0jnFPDo9z4NsI3r9HbHYGMWZBAHhleZhxcBDrjhN1x9umbN5gL04CAc3/ybFI8mDO2SKmQogcLen3qj+SklTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766495817; c=relaxed/simple;
	bh=PqhfhF63v0EqIOJHneYoEayrT89xgREoM1GadF+43hg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Hwlww5qWcW7UtETYLSUU599VvA3Bn35NmcOyMV76fD9Ew+COpcAkamZWZLNjV7p4mWx1O/31XfyfS7dbyvrdGbpBqqM/kC4w1J/aL9JC9uIkjDyR6ly6w0JiCVEXBs9amPp2CWw47ApuK38gbsWnouD0c0Swrr3boCmDfImT6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rI5ZU5lV; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rI5ZU5lV"
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766495812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0xrAD9CPNoWazfa1Ch/aZbLUbnKn6iwCo4489iQ6mo=;
	b=rI5ZU5lVHCaWfJs01fGH8rjvBHuqJ0hAyjGlJleDOdpB/FSAd157eMPB2uRi+7EgXPxSFu
	37b71Sq8+hf2cGD2W1lBDViYe9fVkMM++j/iol+zM/bsXHCRWCAUm/xLruE0eV2+TF8lMY
	wYo1PtagBfSqmZJHhWddAdNeHpBFv6Q=
Date: Tue, 23 Dec 2025 13:16:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <ab4cd403f47438a1bd1efee45b006b755560e5e6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] sched_ext: Avoid multiple irq_work_queue() calls in
 destroy_dsq()
To: "Andrea Righi" <arighi@nvidia.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <aUmOQ0PGzSGCmw9D@gpd4>
References: <20251222115318.18997-1-qiang.zhang@linux.dev>
 <20251222115318.18997-2-qiang.zhang@linux.dev>
 <aUmOQ0PGzSGCmw9D@gpd4>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Mon, Dec 22, 2025 at 07:53:18PM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> This commit only make irq_work_queue() to be called when the
> >  llist_add() returns true.
> >=20
>=20Just to be more clear, we could rephrase the commit message as follow=
s:
>=20
>=20llist_add() returns true only when adding to an empty list, which ind=
icates
> that no IRQ work is currently queued or running. Therefore, we only nee=
d to
> call irq_work_queue() when llist_add() returns true, to avoid unnecessa=
rily
> re-queueing IRQ work that is already pending or executing.

Thank you for make the commit more clear and reviewed :) .

Thanks
Zqiang
=20
>=20
> >=20
>=20> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20But overall, looks good to me.
>=20
>=20Reviewed-by: Andrea Righi <arighi@nvidia.com>
>=20
>=20Thanks,
> -Andrea
>=20
>=20>=20
>=20> ---
> >  kernel/sched/ext.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20=20
>=20>  diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> >  index 8f6d8d7f895c..136b01950a62 100644
> >  --- a/kernel/sched/ext.c
> >  +++ b/kernel/sched/ext.c
> >  @@ -3439,8 +3439,8 @@ static void destroy_dsq(struct scx_sched *sch,=
 u64 dsq_id)
> >  * operations inside scheduler locks.
> >  */
> >  dsq->id =3D SCX_DSQ_INVALID;
> >  - llist_add(&dsq->free_node, &dsqs_to_free);
> >  - irq_work_queue(&free_dsq_irq_work);
> >  + if (llist_add(&dsq->free_node, &dsqs_to_free))
> >  + irq_work_queue(&free_dsq_irq_work);
> >=20=20
>=20>  out_unlock_dsq:
> >  raw_spin_unlock_irqrestore(&dsq->lock, flags);
> >  --=20
>=20>  2.17.1
> >
>
