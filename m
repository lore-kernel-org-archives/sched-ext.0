Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C7C18B0A;
	Sun, 16 Aug 2026 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786915942; cv=none; b=Fv5XG7jHFg9gGsZ7ApDP0XyjqgoVFIz4x80ffKJ+YBZIset+AQd/dIAYK6rySb+tJSRYIlESbD37bFUwZ5U+MxxoX/ZbBTytuLM3MYOHb1pRFCkGX/oJLGoSupVxoqBMdq7vUBxoaz+6+Rshnh+4fqIrhK4XVotjuwdx0Y2huas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786915942; c=relaxed/simple;
	bh=EyP/QHQiRQS7PY+KnF7H2e7K3abfc9X9Pof2qEWvaak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLvHFt5/PoyfFMW6hf8TfBVFSBoMFxN6M4KP1eTlxn+FI6R8KwQpZ/nKnjMZ67oe4xdzkhSvlA0UghyfilBSaPF0KphTaFIIHXGumZdArSByMrDjcwktg/l+dVFSLb/kFT4Rc+8vrRBrRPL3kLf/qKof40wpsB4G/ufe5fVoNbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBZJSo52; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBZJSo52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC0C1F000E9;
	Sun, 16 Aug 2026 21:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786915941;
	bh=lzM5vgfZQLM7rsCPE9KChtHF+Is62CelWcEByYvqRi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KBZJSo522D9wQB1tw3WmwLcD2NCxfwvcvVTeJV8xchJw4fBipd2I+A9FjcBkzTNeD
	 G+QTtUkoUX+wC3J6Bcvf2iVN1MNYmmxWNWCRmHR2tSnT81wD41eBAeSp8RePNuN7hw
	 EWMVv5ZJOHaXlHGwclujNTQPw1kuaRexNL/zoeBYK84bKopwnkBKzCLTjuaL4wGCE9
	 UmV3+69v8Mtw2M5f346Dx8qL7ylsqEG08IP3s7kO+7oJeEc1ovE8LVB2JdrNGtvLI2
	 NQFTaaVoGD5EuvnYFxcMq7EekIQHrMrt8RA7yOnej8sdIOaLGZsp28bEqBW9HZplgB
	 eNCOfLrJCTddw==
Date: Sun, 16 Aug 2026 11:32:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] sched_ext: Block proxy donors across scheduler
 transitions
Message-ID: <aoIsZGwElUYmeePF@slm.duckdns.org>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-9-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816173732.17162-9-arighi@nvidia.com>

Hello,

On Sun, Aug 16, 2026 at 07:35:06PM +0200, Andrea Righi wrote:
> @@ -11295,6 +11295,15 @@ sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
>  		flags |= DEQUEUE_NOCLOCK;
>  	}
>  
> +	/*
> +	 * Don't carry retained proxy state across scheduling class changes.
> +	 * Compatible RT/DL PI transitions could preserve the session so that a
> +	 * boosted donor continues proxy-executing its lock owner. Defining which
> +	 * class transitions can safely retain that state is left for future work.
> +	 */
> +	if ((flags & DEQUEUE_CLASS) && next_class != p->sched_class)
> +		sched_proxy_block_task(rq, p);
> +

I suppose this prevents RT PI propagation through existing proxy execution
chain regardless of sched class in use? That sounds pretty convoluted and
overlapping anyway but John does this look okay to you?

Thanks.

-- 
tejun
