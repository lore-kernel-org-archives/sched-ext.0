Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED93CF1E4;
	Mon, 28 Sep 2026 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622383; cv=none; b=IE67onFTKUbGytAMtMQdHUy47gnaNh8gzzmf6/AzMiylhcwOQgn2I/D8cAGPnMTIXQmhKFIuaybWK6T6Qi362Q5ZVJbY31ehLOfo8M91AcqyTyH3CqgxOQxai2v4e9+Pcb67iMc8A3jwwvQqyOjtm7GbSNUwcLLED6J26TjQ5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622383; c=relaxed/simple;
	bh=7+gE61dcUY204w9DsN95+0EUEWwdapdMXBRbIeEpmKk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBe6lxN0fvhETT7aNyCVwiv1l0O6y5kVutq/z0OO6FolNyAcoC5fusElFYX57SXBuzfUhRHIFyanZycJgYb2RNtoMw+rMrh+JM3VdI7bYDPchmLjd2SbvjfgK+0Xgg9EUDBeycmp86Skg5TDQk7JKddOz1Wx2RcYNiy5bPsH91Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvXbHEBv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvXbHEBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08491F000FF;
	Mon, 28 Sep 2026 19:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790622382;
	bh=7+gE61dcUY204w9DsN95+0EUEWwdapdMXBRbIeEpmKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mvXbHEBvifPacnAPP31/nlYitgpV7GuQbOt3E3i0FrxRX4fuJ9KZ2k5S6EKrWIe7l
	 qeRCR8iXlJYBt562YyVxhliPtv92T4ks781wBIy0cHefmyVODlnN2sYotvoN6W1VMB
	 lOhgE1H6b8cQyCYb/7/B1JU398QO8yvwHSY0Xftxw4GhYtDbyyvQfM0X0I3VsgdbbO
	 ZFeRVY5BPMge69h6Ie819emyweBm2oB5tSJeS9M4F8AZgOx2Mq1I1UbsTT50E9WO2V
	 lCDq9ynzty70WUqkwVoMF/otxk4/7W3EvZsufhXciBAb9Wu7Edyg8Cxu8DGk8QumwK
	 fKHXDMINBXA+g==
Date: Mon, 28 Sep 2026 09:06:21 -1000
Message-ID: <4aed937b9a7376fd50c1e272f9e1f177@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Count cap-rejected local DSQ inserts in
 SCX_EV_SUB_REJECT
In-Reply-To: <20260925070500.565561-1-luoliang@kylinos.cn>
References: <20260925070500.565561-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello, Liang.

On Fri, Sep 25, 2026 at 03:05:00PM +0800, luoliang@kylinos.cn wrote:
> The first two are counted but the last is not, so the number of tasks
> diverted to the reject DSQ is missing from the counters exposed via
> sysfs, scx_dump_state() and the scx_bpf_events() kfunc.

I have nothing against adding the counter, but we don't count every path,
so an uncounted branch arm isn't a reason by itself. What's the rationale
for counting this one?

> Fixes: 75a8c8202c91 ("sched_ext: Add reject DSQ for cap-rejected dispatches")

This doesn't fix a bug. Can you drop the Fixes: tag?

Thanks.

--
tejun
