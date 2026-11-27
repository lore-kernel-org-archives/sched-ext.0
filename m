Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792235;
	b=ANWc6PZqQpcztH2anLGKnrxFOOkbG/EB3sRSzBYPg+YJgaDlvWMaDM0l0JoBSzH4OuQk
	 AFThE3coDwSx1Hv+vCMMJCaTsjfxC4kf5+bn0Su8f1t115H1l/l0auRuiYgFS9t1g+suj
	 mjz0mapbFl1f9IXiOKYWLGTnidvrXWgmVqe8IruYfytAFZFSkFVr/DOqQJ3ruDsezw5MT
	 9GnRagn9QvSjI+i0vXZ1o3GnhF5Ug6OoEUENSrE03106f0+Y8+xF+0yBvZHRtzvk2l/2A
	 eOrGEjUjQn0TP7ouWVF071/PAXL8s9kMlpy224Pw5A86I7brslKvok4YD4sTMd3Ie0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792235;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O2umtZ+zup/WbEXNkwNY/g+UeqMYXsfXG/V2mgGFg9s=;
	b=fyA8iWRjZD7Gx9nYTbsf4shBqir5hchjYPsRpaKm98osJZkt5aod+ZC7JHamoUrIPYsA
	 j8rsB32fDi/wlNGg7WF6je2YbUUx29zy7qGK/VLwHmsSFymlGgwVE8l0FdGLYCsGBJTCP
	 5sbsyiLo/nvNqcpD/rwr8kxPUy/yh54DhHO2aBpg5o+I2xMhX/JA8BO2VvVlFWNrAgSw2
	 BLDCwQDWffyrecn9zr2u3GtiMsPHcEIb3dNqZjtUqudwx7HcA/IL462dPGate+umFgrvo
	 1hUdTQRvxm1wr15h9KVsQQLO4OlA4LhYvIgWEiqPPrz/T7WbEFUzhSIXxWsfEzsg8og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTQ84w62;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04204606A31E;
	Fri, 27 Nov 2026 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTQ84w62
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A8A1F000C1;
	Fri, 27 Nov 2026 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792234;
	bh=O2umtZ+zup/WbEXNkwNY/g+UeqMYXsfXG/V2mgGFg9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eTQ84w62DCXgn5p537M9i+0esTxmFdk45VmcQnmDmE7WTNJNobGnKHbXU48qDROB/
	 Ej4ceqHkIenlkRPOhYyuI7J51Ud2tWmynkLvkx35YGuQ8NXi0EcMGxwFYVRIkJh3ym
	 rRmfaF6gUWO3DDmlZZis5TbW5lhGhK5OACr4rV0z1y2eRZS/gY106ng/qyLHOLzQPn
	 wXzpkCbsWWgHFzQB0nIdO2WyEng0zfHyqnJklLO0tfWF53Fr57gp2oMv4fJhk7fahf
	 pgVRlRxIQzxlJeTHADP+FCDKkVlcnUfd21wYyoXD50WXPQpFqFd1xbQRzrmDwAT9AB
	 HeDPmoWq2H6RQ==
Date: Fri, 27 Nov 2026 05:10:33 -1000
Message-ID: <df1075443b0ae279117917df4bf50425@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>, Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] sched_ext: Reenqueue IMMED tasks when a higher class wins the pick
In-Reply-To: <20261125114932.3198836-2-jpiecuch@google.com>
References: <20261125114932.3198836-1-jpiecuch@google.com> <20261125114932.3198836-2-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Kuba.

On Wed, Nov 25, 2026 at 11:50:52AM +0000, Kuba Piecuch wrote:
> Rather than chasing every path which can make a higher class task
> runnable, check once the pick is final, whether or not proxy execution is
> enabled. Add scx_settle_pick(), called by __schedule() after proxy
> resolution, on the path which every pick reaches.

Yeah, wakeup_preempt() misses the transitions which aren't wakeups. This
looks correct to me, although it also looks like it can replace most of
what wakeup_preempt() covers.

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7340,6 +7340,7 @@ static void __sched notrace __schedule(int sched_mode)
>  	clear_tsk_need_resched(prev);
>  	clear_preempt_need_resched();
>  keep_resched:
> +	scx_settle_pick(rq);

Peter, what do you think?

Thanks.

--
tejun
