Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F50246773
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956801; cv=none; b=Jcxj0QxDD/eiKNYFf/1okHIBmMjgQtODgkEHDLuHUA3y1VOkk++iU2Lcg+KQZoxg97TPKh8Mt0rfbsktUlibLgok3j6wNzBrkM5fVmNKQayGiJeZODa+bajYw/WHrGdE+qJBN16SZ5/pHHyeYn/p1tvpwS6k1grxbdcXIDV2N2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956801; c=relaxed/simple;
	bh=g8Vys+du9YqXpqsVQzw47wDiZ/gGc8+tvn52ir9WXCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSqF353VacVSr0AUQ/CnjFLpAS1MZ2+9LHmtB7N2M03zVpdTZuyPV0GqIUXtODPb6l1ri0HIBwYfIhoyHo2sYuSGrnUP8fwpeIh1txu+ROfalU9dIqL8Eb06lTf8Da0XfLcMNdMaADmyUIKGM8+mreLb4oB6eVWmFly30v6I7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIvIBnBc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIvIBnBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281F0C4CEF4;
	Wed,  8 Oct 2025 20:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759956801;
	bh=g8Vys+du9YqXpqsVQzw47wDiZ/gGc8+tvn52ir9WXCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIvIBnBcFsaDUmV2bWi+73+L713j/hBlHyWOCfcbf2IrTcqdOaerbkBdDuiK9qyVi
	 iBBFAfhHG9NLk5HPD5h22NgYpGan1FXwCj6Gv1A8BeybYAEgTuG1Ir5Kx2cGElJlqS
	 c1zwFL9mWcilb/89aQZr7oK8jIFf+CzC6Tteab158PKQUGb/k5PX21WPa+M6RYLfKe
	 pF9Z/AeJN0xxStQrqnmS1MgexCs/39M+yv0vY3aOYk2AswPGJJmLu8ss+6BHei3mk2
	 rXx78ooDqAbYcNBm8LBRSsaH/XmyA9tgnSMpGVExhJfnMTWKImyLtrcNu+A1bJM3OA
	 SqfWks8GvQe8Q==
Date: Wed, 8 Oct 2025 10:53:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Phil Auld <pauld@redhat.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: Re: sched_ext and large cpu counts
Message-ID: <aObPQF1-o-Uek7bd@slm.duckdns.org>
References: <20251007133523.GA93086@pauld.westford.csb>
 <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
 <aOYAV2ZQvMt5aZxu@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOYAV2ZQvMt5aZxu@gpd4>

On Wed, Oct 08, 2025 at 08:10:31AM +0200, Andrea Righi wrote:
> > @@ -5082,7 +5126,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
> >  {
> >  	struct rq *this_rq = this_rq();
> >  	struct scx_rq *this_scx = &this_rq->scx;
> > -	unsigned long *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
> > +	unsigned long *pseqs = __this_cpu_read(scx_kick_cpus_pnt_seqs);
> >  	bool should_wait = false;
> >  	s32 cpu;
> 
> Should we add:
> 
> 	if (WARN_ON_ONCE(!pseqs))
> 		return;
> 
> Not sure if we can race with scx_disable_workfn() here.
> But for a test the patch looks fine as it is.

Oh yeah, I think it can. We should probably RCU free the arrays and add a
NULL check here.

Thanks.

-- 
tejun
