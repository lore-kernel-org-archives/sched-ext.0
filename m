Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD202E7F03;
	Mon, 10 Nov 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811983; cv=none; b=tzgd35g9GZEhJ6vcT1HmsQxbhvu60BRuW+3K5T0Uf9I0URiPuf3x2SHkbr2NinkUbLDQPxB42HgcuDZsgJSkC9STpG2R4QLBYSTTJmWDBatIejEqQYxsR8hNikD7t7Np11W2QOr15PtCGLJE2a/i1CfG1syhpU5tR19A2MwO6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811983; c=relaxed/simple;
	bh=HC+ZNej206m8HsGOj0VYIe8C2fFlH92ejCTZev5uuiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFiMb58zvWN0eNV4C2E7REZKFZQkosLQvtAUA8Hx1+yX3zMItrgCm8zy8GoEOPjS/sffH9fykW2HzKly2aVV2sU+hUtdOak5ItNibLbr19/X9ejLkcIjEY5y7h3/ooAWKHMm/XoK9IrsBfVBzBEn14gONbQ62KyhJgFlbBouf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmAvLu8b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmAvLu8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96499C19425;
	Mon, 10 Nov 2025 21:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762811982;
	bh=HC+ZNej206m8HsGOj0VYIe8C2fFlH92ejCTZev5uuiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmAvLu8bpbWmB3zD7M8FYQZLG5zwkl1p23IjD/a1V074csQvh/8nK1NJfrxjg3GKR
	 ezzlDsDuMnp1KToOxUumTMztg+4gam7xB59oaAAD9er91aygsuVxIXxaKf/V1f1VT2
	 Stctxvy+l5vbDsuCDRIqZL7/IM25pXOtHi701NxevVu/WAIYsgemMROhfIENhi/FEo
	 UgONtJPNqvzgqEYhBB54u269WxLcktf/DIZ2GibjS4kGcXvs/1H1F9ot55/ysIFQpS
	 2oz7oOfYhmegNy7RvItz20vQs3ZPXY0hK9jBM8/dDiSNFrmT4kAbpPDumn8basjjPf
	 t+XWCVfg/Jjlw==
Date: Mon, 10 Nov 2025 11:59:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <linux-lists@etsalapatis.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH v2 04/14] sched_ext: Use per-CPU DSQs instead of per-node
 global DSQs in bypass mode
Message-ID: <aRJgTTiAnHzrMN8y@slm.duckdns.org>
References: <20251110205636.405592-1-tj@kernel.org>
 <20251110205636.405592-5-tj@kernel.org>
 <CABFh=a6rP08+vsK11Ubi5qv2o2yOYFSoiMMM8ZahSVy=LzXpow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABFh=a6rP08+vsK11Ubi5qv2o2yOYFSoiMMM8ZahSVy=LzXpow@mail.gmail.com>

Hello, Emil.

On Mon, Nov 10, 2025 at 04:43:23PM -0500, Emil Tsalapatis wrote:
> > @@ -1298,7 +1298,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> >
> >         if (scx_rq_bypassing(rq)) {
> >                 __scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
> 
> Nit: The bypass label has a single statement, and there is no fallthrough to it.
> Can we just add the logic here:
> 
> dsq = &task_rq(p)->scx.bypass_dsq;
> goto enqueue;
> 
> and remove the new label?
> 
> > -               goto global;
> > +               goto bypass;
> >         }
> >
> >         if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
> > @@ -1356,6 +1356,9 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> >  global:
> >         dsq = find_global_dsq(sch, p);
> >         goto enqueue;
> > +bypass:
> > +       dsq = &task_rq(p)->scx.bypass_dsq;
> 
> Nit: If we keep the bypass label, we can remove the goto since the
> label is right below. Otherwise, we could remove it

This is really subjective but I like the fact that the local, global and
bypass labels look symmetric. It doesn't make any different to compilers and
I think keeping them so is less likely to trip up people.

Thanks.

-- 
tejun
