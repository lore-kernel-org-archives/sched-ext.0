Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95F2C21E7
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966718; cv=none; b=RCWynQubD8sVKb8loiojzVOqIRvL/YBboDF1TYm6jRSt/xiSA3Au6GbzKoDvdgWsLh7auzpy2GqKnbhyRBEFw70dtAqhwyqmbq2HvgkFMdHpSZ1OaKLt7ACHbcEBfYJ9TMCSgg/e5uO5PdJ6BVcB5jBvMfwRVAdRCOMkvJys1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966718; c=relaxed/simple;
	bh=7BBZQkA8C8ZlhF5BB9okWj6Jm0J0fFO3/JxAlVOUCoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DURdFyhN+fyKIHX0IMLQU30FnswkuWbTUsKAeLcjpIuPyZY7k5ONIC4oLF4wLoxs3RkCMEfq9SwVxana68Bd0Dv28o8w45J3cvMGGnSyL040BlTSezuruxETr/jDCZPYLMEmfkQ1QSTfMk5KvdsCY0IcRnCvwlIi58FvkXD/ktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwyklZmA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwyklZmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B643C4CEE7;
	Wed,  8 Oct 2025 23:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759966717;
	bh=7BBZQkA8C8ZlhF5BB9okWj6Jm0J0fFO3/JxAlVOUCoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwyklZmANecKRETD7g0ZKsIKCLgbe2ujvQc821xOzXhDLUWbr9a417ExB5afjauzX
	 f+rrvxl9UYpuY3+eLBvJ6fMnD/Z2Nm/C5GHTsK38UJbtkIFlHFiXTnxrFpuiuoLcKi
	 OnOLrQxysPeVABuuc2YB4crEpGUS53FG/3RQEcH09QuJ22INfvSxlv8jTJ6r2sDDdq
	 Xw+JK+6pMlRbMWqOSCYTpZ4UruQtKswXzLpQvkL4+1iW77gyhBv1EDsLWV3axhGAMZ
	 mywCRReowXz88xTQmLldVChxAF7wXKMxqtfmCIDGwG8fN4x/jhI0f10MlfBb04+cOK
	 KKOyEoC1AY49g==
Date: Wed, 8 Oct 2025 13:38:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Phil Auld <pauld@redhat.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: Re: [PATCH v2] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily
 using kvzalloc()
Message-ID: <aOb1_Ep3F8w6O1x1@slm.duckdns.org>
References: <20251007133523.GA93086@pauld.westford.csb>
 <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
 <aOYAV2ZQvMt5aZxu@gpd4>
 <aObPQF1-o-Uek7bd@slm.duckdns.org>
 <aObcIMFpUoMy7vJI@slm.duckdns.org>
 <aObkkKf_UCHySRGz@gpd4>
 <aOb1e7R1lAGVGH-2@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOb1e7R1lAGVGH-2@slm.duckdns.org>

Hello, again.

On Wed, Oct 08, 2025 at 01:36:27PM -1000, Tejun Heo wrote:
> On Thu, Oct 09, 2025 at 12:24:16AM +0200, Andrea Righi wrote:
> > > +static void free_kick_pseqs(void)
> > > +{
> > > +	int cpu;
> > > +
> > > +	for_each_possible_cpu(cpu) {
> > > +		struct scx_kick_pseqs **pseqs = per_cpu_ptr(&scx_kick_pseqs, cpu);
> > > +
> > > +		call_rcu(&(*pseqs)->rcu, free_kick_pseqs_rcu);
> > > +		RCU_INIT_POINTER(*pseqs, NULL);
> > 
> > Is this safe? I think we should replace the pointer first and then schedule
> > the free via call_rcu(), like:
> > 
> >         old = rcu_replace_pointer(*pseqs, NULL, true);
> >         if (old)
> > 		call_rcu(&old->rcu, free_kick_pseqs_rcu);
> 
> *pseqs is the deferenced per-cpu pointer and we're freeding the struct
> that's pointed by it. Whether the struct is freed or not doesn't really
> affect the pointer storage. Let's say the struct gets freed between
> call_rcu() and RCU_INIT_POINTER(). Then, *pseqs is just a dangling pointer
> inbetween until it gets cleared.

Wait, you're right. The problem is that the readers can end up fetching the
pointer afterwards. Will fix it.

Thanks.

-- 
tejun
