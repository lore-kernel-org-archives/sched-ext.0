Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B60C2E8896;
	Wed,  3 Sep 2025 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887281; cv=none; b=VgTOl2G3/mB+652l1duv6oTNtcObKTPV8OyeRg5DGP1MSxD+tPO/+ripj/s6IJm/3pR0uDiDwm2d3PwpIPdgAa3bilH6iJT5YXi8rG+Re/6DEhswVHVQDk+nq9Yrr8vfGGVkQnDhWRomy/X+6laglR8X8v1szuyzMrMBOkG2+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887281; c=relaxed/simple;
	bh=fs+KWwZR1QzA87GtTYQdJ+LTlKnXWvFf7ZvudGJ6gtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpI4ZRATNPmy/vFq0TjD/3O6JpKJYuQACRSyxAz60oJrNAK7vFu1ak0q5llmRoIYH3DXQDCt1cOcRG6pJuhiHYx2NYRg6MLfc1WxET+O0mq0b7MLZ90Zz2Scoj0AlTyqmftIYojpe7jMwSe67IdCvUonxwaQsC5ntl7TCKQVFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lxGAarQo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lxGAarQo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=32qY64HQUKLqyiUo1HqOoBz1g0vVm/t/Ehcvc+7u+8o=; b=lxGAarQosFF7RE+ye+ERnM2ENo
	2dDYCQZOOCcQag2wVOe47w1koeDOpg2aNnk3aJ2ck6TYq5vtV1IREfXERnGoDHILgwNGNFdwInnwl
	g+Zly/a0ANxSxxWSsI1ELtzQX4Hxo02DQENWPJ/78S4DXOfGPKhP141zthDFkHp+VlCW/vmd/fb3V
	mnXuJIA/tiD63VqWpjhEq12TxFSR2TZ9dbSiSbMjm/LIP+JFWhF58Po8PbGogG6Bj2sobfajJK0tj
	pJ82MuBcWpA6TiqiRTHOycYtS1ckq5gFA3FvXFvG0IMYz5pLHtiA4peIGJOeHTxmqTQHV/2QzMxC2
	StfiIfXw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utidZ-0000000HXNZ-1gxt;
	Wed, 03 Sep 2025 08:14:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 988F13003F0; Wed, 03 Sep 2025 10:14:37 +0200 (CEST)
Date: Wed, 3 Sep 2025 10:14:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Use cgroup_lock/unlock()
 to synchronize against cgroup operations
Message-ID: <20250903081437.GP3245006@noisy.programming.kicks-ass.net>
References: <aLeANmpO03QiPgSX@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLeANmpO03QiPgSX@slm.duckdns.org>

On Tue, Sep 02, 2025 at 01:39:34PM -1000, Tejun Heo wrote:
> SCX hooks into CPU cgroup controller operations and read-locks
> scx_cgroup_rwsem to exclude them while enabling and disable schedulers.
> While this works, it's unnecessarily complicated given that
> cgroup_[un]lock() are available and thus the cgroup operations can be locked
> out that way.
> 
> Drop scx_cgroup_rwsem locking from the tg on/offline and cgroup [can_]attach
> operations. Instead, grab cgroup_lock() from scx_cgroup_lock(). Drop
> scx_cgroup_finish_attach() which is no longer necessary. Drop the now
> unnecessary rcu locking and css ref bumping in scx_cgroup_init() and
> scx_cgroup_exit().
> 
> As scx_cgroup_set_weight/bandwidth() paths aren't protected by
> cgroup_lock(), rename scx_cgroup_rwsem to scx_cgroup_ops_rwsem and retain
> the locking there.
> 
> This is overall simpler and will also allow enable/disable paths to
> synchronize against cgroup changes independent of the CPU controller.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
> This results in a tiny simplification on the core side. Peter, if you don't
> object, I'll route this through sched_ext/for-6.18.

No problem, that's fine. 
