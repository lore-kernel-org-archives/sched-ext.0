Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9878728FABE;
	Tue, 17 Jun 2025 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150234; cv=none; b=ftDHsfdpME3uzv9CtWknaIBdCWkaFFz+/+OjHjAvJbQ8OXXEUf1oLeolSYR2Pgy5bAggqore+lTNEcOnwRCCFN41qStCtIP2t2xflwiLm5gLCHhaYKCwsrTQYFoo3r27OBh94bRNHKOj4VR+Ym+6L0zJLmGjDic/vmKFHOYczuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150234; c=relaxed/simple;
	bh=zXDoeyDAdE2WUIqbdzQe8rsxVp43jDDXe1eMfCh0QgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDKfdy0Ym+s/P4FAGVXoU53DRkqyGju55mDtHXvNVuQjWKEbqRO9iEH+nHmGbHIE9WkNs4r7x4Bnh1dDbF0FZDkGSud6ZPYUT3zxB58VRHk3GczyJJGhL4RUG5fLpg4lcZjAGVmxBgcIFq3gfKivHYODvM0ETE4Vo5gBlSdgAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZDjzZf9V; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZDjzZf9V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eg7igDB5AItT34OGvj2hl3G+l8FTS6o11OyHnXLlxf0=; b=ZDjzZf9V8VBGb10ZONh8VtbAx5
	Fe7+DtTMg975datHJ+Yu/KZW/gkhi7petKipvJLOvj+Fv93uJ7dnTipr5gjWSGl+i/Pu35zPul/C+
	rhj7zqFIhUWvEcmSM1+9sBuMp1Gko/3lrPIUD5Get3UET51PQbeAWmGhd8F+q0zwojcAYN8dl2abA
	w6vN9WuhqympQH48Pnwn6eiidVspUKoLQa9ZSxxsJXhd0iul7Wq8rwlgp5lBLAtC4DBSPwKUuLrZk
	DhPexfNsGb/CLWiaY6z1UWyrZwVL78jmdYEoUfXiJPrD+3PCchSNv40DsP+ON3j1nHUtUGtCPgVvD
	i4QKA0EQ==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRS1V-0000000Guld-26Hs;
	Tue, 17 Jun 2025 08:50:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0A1E3308523; Tue, 17 Jun 2025 10:50:28 +0200 (CEST)
Date: Tue, 17 Jun 2025 10:50:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH sched_ext/for-6.17 1/2] sched_ext, sched/core: Factor out
 struct scx_task_group
Message-ID: <20250617085027.GM1613376@noisy.programming.kicks-ass.net>
References: <aEzRVj5ha38RAEr5@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEzRVj5ha38RAEr5@slm.duckdns.org>

On Fri, Jun 13, 2025 at 03:33:10PM -1000, Tejun Heo wrote:
> From 55aa129e6add97a98340326451bdadd4c5dd3242 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Fri, 13 Jun 2025 15:06:47 -1000
> 
> More sched_ext fields will be added to struct task_group. In preparation,
> factor out sched_ext fields into struct scx_task_group to reduce clutter in
> the common header. No functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> These two patches are on top of:
> 
>  + Two fix pathces pending on sched_ext/for-6.16-fixes
>      http://lkml.kernel.org/r/aEyy27BecPPHDWHc@slm.duckdns.org
>      http://lkml.kernel.org/r/aEyzhBAl5zkP6Ku-@slm.duckdns.org
>  + tip/sched/core patchset to reorganize bandwidth control interface handling
>      http://lkml.kernel.org/r/20250614012346.2358261-1-tj@kernel.org
> 
> See the following git branch for the merged result:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-bandwidth-control
> 
> Peter, while this touches sched.h, the change is contained to scx part and
> shouldn't cause noticeable problems for other scheduler changes. I'll carry
> this through sched_ext/for-6.17. Please let me know if there are any
> concerns.

How do you want to do this dependency on the bandwidth rework? Should I
take those patches into tip/sched/core and then you base your tree on
top of that?
