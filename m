Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C95267B05;
	Mon, 22 Jun 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118026; cv=none; b=qVaBMO+I2nctT+Kj4L0l+OUMjUF2XZ6tBIYQoe6Qrwkqw7B4X0StJ1Nbl04tTrdeOY8+ReXIKZDV5E1qIzGag/xDb3xkv561SzEMqXy7O4f18JiEGYphgqQ5hiNOceKzDSUXnjS9KXrL5yBKQ795JzT1IHGejt78OnRU7DakMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118026; c=relaxed/simple;
	bh=iBha+PMUk18SuRFYrez0EkRqF6mD2z5cmbuDCED8orY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKHScjA8mttQ3N1+kySwIBvj2ADKX4BRRVOzHaaaUA2mpGdvjGEmj75ZhL1igLp1f2NWij+nEeI3Ckg3O/CvOkCQ4JPjPw3lIuYLOhkUh5LInvshzpoDMoAkR7a5uWujtthVSRdxxX3v5izbPnB+zJEv1LcUA9FP+XFCZBUwlUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KWUvz402; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KWUvz402"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SuQRrDG1FqQfW29FJxh2E+p0Poe39QjBqjlwKZrI5R4=; b=KWUvz402BDiQnNAOstzCXMb9sa
	PgMTc2Q0skyPuQ6uX8YyqE60OwwAqRIjylqqQAlfw7lXyokLo2t7pX43309jx2oIv64yiKKeE1/VK
	AvfQI/5dbUQjgQY5dViGcUWp9mqBoGQsxZ7JsFiGE+HUBcIx7LoRZLPkSNlQBFZb+wTEtE8eRg8fc
	0BXEXVNdd8yfqhDiJDJuounWcUHVvBMv3357Jff7FGhglwyqLiX0ZcNrDykS8Bif6ubUD5T1Er8sF
	jZoOE7wtefhoFhlAIgAWp4YAp0vCYT77G8J3SnCtYOsEaoOgi46syp/PYpMrOnjaTrK0epM0FyPRb
	+hUErqDg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbaIz-00000003vNy-2DLx;
	Mon, 22 Jun 2026 08:46:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 53856300B5F; Mon, 22 Jun 2026 10:46:57 +0200 (CEST)
Date: Mon, 22 Jun 2026 10:46:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Move sources under
 kernel/sched/ext/
Message-ID: <20260622084657.GZ49951@noisy.programming.kicks-ass.net>
References: <20260621163026.434856-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621163026.434856-1-tj@kernel.org>

On Sun, Jun 21, 2026 at 06:30:26AM -1000, Tejun Heo wrote:
> The sched_ext sources had grown to ten ext* files directly under
> kernel/sched/. Move them into a new kernel/sched/ext/ subdirectory and drop
> the now-redundant ext_ prefix. ext.c/h keep their names.
> 
>   kernel/sched/ext.{c,h}       -> kernel/sched/ext/ext.{c,h}
>   kernel/sched/ext_internal.h  -> kernel/sched/ext/internal.h
>   kernel/sched/ext_types.h     -> kernel/sched/ext/types.h
>   kernel/sched/ext_idle.{c,h}  -> kernel/sched/ext/idle.{c,h}
>   kernel/sched/ext_cid.{c,h}   -> kernel/sched/ext/cid.{c,h}
>   kernel/sched/ext_arena.{c,h} -> kernel/sched/ext/arena.{c,h}
> 
> The include paths in build_policy.c and sched.h, the MAINTAINERS glob, and a
> few documentation and comment references are updated to match. No code or
> symbol changes.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>

OK I suppose.

Can I take this opportunity to remind you that most of the ext files are
not clangd 'clean' yet. That is, they don't cleanly compile as stand
alone entities, which causes LSP/clangd enabled editors to throw a ton
of errors.
