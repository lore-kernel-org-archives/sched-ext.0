Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB9C29B77C;
	Wed,  3 Sep 2025 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917589; cv=none; b=q8Ueqp27IKXMeUaQjpd+LnEmAh1zpZ87WWItpMzhFUgehjavnLBiZ8/E4yUpOpqH86RmLG604mOBswj76blizDTf7W6HayDndPgLgafMVMDcrxihIopsFnYsF0MeYMlitpMsn0UxI6oN1B+3RDvx07RPmK/VFBA7kJHbBTdyPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917589; c=relaxed/simple;
	bh=4xRku4XtOTDToOKPiNwObOm/Bt8oBs7xsnvycED4J84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftjeLGASpMTa463LhvSf61W/sf3jf/TF0riamyhvVexGeCh7aWGpibTh3MQpN9MZT26y7IASodJ8/6nR2lt2/PNfpa+Dcc8iHVS4EW4NWCxLZNlRXPmHGzNV6KgWgu9PcJGFynz8mawJOXz2KcSb8HcsnXXr7+lZVzpQQ+U1BDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DicF4OT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DicF4OT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE6AC4CEE7;
	Wed,  3 Sep 2025 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756917587;
	bh=4xRku4XtOTDToOKPiNwObOm/Bt8oBs7xsnvycED4J84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DicF4OT8Xs2oUdig/Lr9peFQ0ctIQQ1kTMfzBAIhoT46nnc4LnNFktSD5fY1AOtuF
	 EVHtsLh829iSOUKgmdu6gyKMc1KG1TmsKf+FTSZKpXE2XNKXY6PdPWWruaHmkTshnW
	 xhzIDCt2/DWQI7yzOBYwJdDVZMSDFaZKqQfFnfxDHDQVd+sAhY3cWnj9VSFfz5LDBa
	 StdHes1Cht/fH/wG1dw5/gP93oWcKwf0Sj81N6HO/WtM0XSLvkdqReYU4cLxi8efXr
	 mCL1lLHWw67SdO2HUNQVgzd8qh1ZvGWZqAOi3AXcxAcSdcSkw5nJSNoypi/4eitxf1
	 Z8xKdfTRk42OA==
Date: Wed, 3 Sep 2025 06:39:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Use cgroup_lock/unlock()
 to synchronize against cgroup operations
Message-ID: <aLhvUpkanqxNHyZe@slm.duckdns.org>
References: <aLeANmpO03QiPgSX@slm.duckdns.org>
 <aLg4SsZHY66n3Vi2@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLg4SsZHY66n3Vi2@gpd4>

Hello,

On Wed, Sep 03, 2025 at 02:44:58PM +0200, Andrea Righi wrote:
> >  static void scx_cgroup_lock(void)
> >  {
> > -	percpu_down_write(&scx_cgroup_rwsem);
> > +	percpu_down_write(&scx_cgroup_ops_rwsem);
> > +	cgroup_lock();
> >  }
> 
> Shouldn't we acquire cgroup_lock() before scx_cgroup_ops_rwsem to avoid
> a potential AB-BA deadlock?

There's no existing ordering between the two locks, so any order should be
safe. The reason why I put it in this particular order is because any
cgroup_lock() holder has no reason to grab ops_rwsem now or in the future
while the opposite direction is still unlikely but theoretically more
possible.

Thanks.

-- 
tejun
