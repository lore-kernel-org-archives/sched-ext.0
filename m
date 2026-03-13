Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF4237DEB7;
	Fri, 13 Mar 2026 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398447; cv=none; b=djmiAy2IOMqlpuz0ty0QFm1k7IwV+9kc7cRO12rmYSV9o7IlhJzfj2WwT4VNuE74XXbgP9dwqXxZuomR2BHNBxVIls3cKRKpf8ug1ZInlbleVToTACMX5CFR9d1wOO6FpUePo/UX6Ha3CnF+cVB3rR89bqtkepPEdfbOB330sfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398447; c=relaxed/simple;
	bh=ZeQHm99S9pvlk40UZypkruM8uOmbwzv+2q+pQEmCvvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZUGTGXpWUJTwP+zxwok6lMzGSItgBW2iCsMzjGk4rp4qk833kNEp3XMF+NLa0ym5ePXZrS4BpmGcpwYNiColeYCZ9cZSj267BipCRc+PsELngRo8Jku6eDiIKTfXO4jP/5sZ9+Vecg4UDBIhcqVTLHBcKZFHVrxo6Q0j87qLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXHu6wG0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXHu6wG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5017DC19421;
	Fri, 13 Mar 2026 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773398447;
	bh=ZeQHm99S9pvlk40UZypkruM8uOmbwzv+2q+pQEmCvvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tXHu6wG0SGJZ9bd1h0U5MFK09OuR8GZRVtke0CMPxOAerrFY1nnP95iaAkFXOR5YW
	 GTKuhz1Us4WILa7Ab3WU5iUUc4LtkkVuyxLR9EONW7WHl5e5H4jWr5dvMdgLx6G7da
	 aVoIxDUmY+YhfZN5uP+sGZLdAQxH8Q4EGhOLIni+RD58/QTgO+c9UKPwSLTxuyDFtk
	 G0OCgQ2BJI+UKXmDme2H5IClUS8/x8n2W/cvkB7+sK9O4Upd2DFMu61YOkgs/TxZ10
	 KNjg50SqRCCwgmGJAjOu7fEmVMAL3Y3upTYkYJZRAQx/KAmQS8SZIU4snBmoa01OLb
	 WirNUP8sDIPZQ==
Date: Fri, 13 Mar 2026 00:40:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Implement SCX_ENQ_IMMED
Message-ID: <abPpromdlJNm8DGd@slm.duckdns.org>
References: <20260307002817.1298341-1-tj@kernel.org>
 <20260307002817.1298341-3-tj@kernel.org>
 <aa8E6WauTRALRCqs@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8E6WauTRALRCqs@gpd4>

Hello,

On Mon, Mar 09, 2026 at 06:35:37PM +0100, Andrea Righi wrote:
> > diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> > index f8df73044515..cd4272117be4 100644
> > --- a/kernel/sched/ext_internal.h
> > +++ b/kernel/sched/ext_internal.h
> > @@ -31,6 +31,8 @@ enum scx_consts {
> >  	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
> >  	SCX_BYPASS_LB_BATCH		= 256,
> >  
> > +	SCX_REENQ_LOCAL_MAX_REPEAT	= 256,
> 
> That's a lot of re-enqueues. What if we simply ignore SCX_ENQ_IMMED when
> SCX_ENQ_REENQ is set?

It's meant to be a safety mechanism against system lockup, not a workaround
for BPF scheduler misbehavior.

> This would solve the SCX_OPS_ALWAYS_ENQ_IMMED issue and naturally limit the
> loop to a single retry:
>  - first attempt (IMMED) fails -> task re-enqueued with REENQ flag,
>  - second attempt sees REENQ -> ignores IMMED check -> queues normally on
>    local DSQ.
> 
> This approach seems more robust and would avoid the latency overhead of
> repeated failures (the re-enqueues were actually the reason of the latency
> issues that I was experiencing). If I don't use SCX_OPS_ALWAYS_ENQ_IMMED
> and I selectively use SCX_ENQ_IMMED with just one retry I can actually see
> some small, but consistent, benefits with scx_cosmos running some latency
> benchmarks.

The intention is making IMMED guarnatee immediate execution - if IMMED is
set, the task will get on the CPU or get re-enqueued. On v2 patchset, this
behavior is extended to staying on CPU. If an IMMED task is preempted for
whatever reason, it gets fully reenqueued instead of e.g. silently put back
on the local DSQ. The goal is giving the BPF controller full latency
control.

I don't think it makes sense to paper over IMMED failures. The BPF scheduler
shouldn't be doing that in the first place. If the CPU is not availalbe and
the task keeps requesting IMMED dispatch of a task on that CPU, the
scheduler is buggy. Is cosmos doing DSQ_LOCAL dispatch on single-CPU bound
tasks? If so, it shouldn't use ALWAYS_IMMED. Instead, it should only mark
dispatches that know the target CPU to be available (IOW, claimed idle) with
SCX_ENQ_IMMED. I don't think that's too much of a burden.

Thanks.

-- 
tejun
