Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327C37AA92
	for <sched-ext@lists.linux.dev>; Sun, 10 May 2026 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421755; cv=none; b=HZifxFHDfuesdEFCwct5wOgugIMTKd2V31gYczIoDIc6GygY1e9es1SRQ3lseRBR+KGhxxEpaYa+S2mGlvIUhMHkcTeKLRbUqmmuapqMsiXJSQvY+0m2w6ftJip6gndVchhSIhzf+wPKpkhIK94imVTPtedT+pHcqB9gfWV5HWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421755; c=relaxed/simple;
	bh=7Sf0D//qh0TXbgQFOYzbkNGB7dW0WFvf28k2a9ijlTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW071iv6z8af/5npnRt8QOP17wimxCvzTbpH/H1D3NloM/iA644pHuIoO/0mPW9mVWpQG1s7bWvIUzMRsW4o/97A3Q0cnqAkN3HhT7lmLUAzFfXaRADuJeJSyRylki8R6wQ4aFOjyjUxjHPn2qSzCOxOOZ2vews/nkn3wW3DYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWIDq373; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWIDq373"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6590C2BCB8;
	Sun, 10 May 2026 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778421754;
	bh=7Sf0D//qh0TXbgQFOYzbkNGB7dW0WFvf28k2a9ijlTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWIDq373jaqYdSXxzHILaNVJ1qlj1P1z1h+OUI4qdThyP1kyKN6uSUTQYyOL/eeQO
	 1gml1A9neV9lmxO8Ib9MfZgcPLfUmWcPK5JGMuAYDr4D32h80tRxMjTAP1KXLi+t8L
	 4omumq7XTOO20FbkJ9VI2VSlwHjtQP5HZHxbaQXoEXtS8vCyU6Sj8A6opLL/z2A3Zr
	 9K0iUgxrexDfW0ZJiDIrw8r/yiKRgvS6kl6HfcDIeqvShT/czFod+vaYsPDwxdWIt2
	 F5U8OwqWe0snVCjUvFRxV0nh1YILG7UE1COGt+Xxwobp+U5DS9VBKXziH5SMEp3lw6
	 k50LcDsSWcuIA==
Date: Sun, 10 May 2026 04:02:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 1/2] sched_ext: Add dispatch transaction API
Message-ID: <agCP-e9ZL8smNoNQ@slm.duckdns.org>
References: <20260509191223.168648-1-yphbchou0911@gmail.com>
 <20260509191223.168648-2-yphbchou0911@gmail.com>
 <af-l_M9p9npc9FUA@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af-l_M9p9npc9FUA@gpd4>

Hello,

On Sat, May 09, 2026 at 11:24:12PM +0200, Andrea Righi wrote:
> Why not passing slice to scx_bpf_dsq_insert_commit()? Is it because of the BPF
> args limitation? In that case we could introduce a struct similar to
> scx_bpf_dsq_insert_vtime_args.
> 
> Speaking of vtime, we may also need a scx_bpf_dsq_insert_vtime_commit() that
> accepts dsq_vtime as well, otherwise how do we use priority DSQs with this new
> transaction variant?

Given that these are only meaningful when targeting local DSQs, I don't
think vtime interface is necessary. It'd probably be a good idea to
explicitly restrict usage to local DSQs.

> > To support explicit token passing, rename scx_dsq_insert_commit() to
> > scx_dsq_insert_buf() and add a qseq parameter. All existing callers
> > preserve the original behavior.
> > 
> > This mechanism is intended for schedulers that do not implement
> > properly synchronized dequeue. A scheduler whose ops.dequeue()
> > synchronizes atomically with the dispatch path does not need this API.
> 
> I'm wondering if we should validate qseq also in mark_direct_dispatch(), it
> seems that we're not validating qseq in the direct dispatch path, or am I
> missing something?

In DD path, the task can't be lost and it'd be a bit silly to use this
interface. Again, probably good idea to at least start with just allowing in
dispatch path.

Thanks.

-- 
tejun
