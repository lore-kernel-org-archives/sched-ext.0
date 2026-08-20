Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DA47A0D8;
	Thu, 20 Aug 2026 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246463; cv=none; b=hK9DoRWS7IJp8s3b4u3JIZ+L2wJ9huPow+rwE0L/S8s2gSqj/pnipyHXaQnHEqez3ZeKLhf8fegirTqs4UT7b5lhGndbZqvlyqnDx5ENJxD71LoDAFMJNodZlz+VwS/FXgTJuus90KnE5lYpP8ndRXysrmxeZSvtb71GL1JXcKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246463; c=relaxed/simple;
	bh=KfYbCyGgH+/5zIhK6ilZRspK1EknZfvpMkMD5iCHDAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbr4+Ehs8QDQNbgRWgYa4JhQlzv8KFiSwCwDGG7MDV8qGLQE6f3nvM242Xgunfnt3fjoyWiawHanRrtXgzZIeeifb3hnbzfcjpMzzCuBdRn3i6qkrCWAcqbFF5o9JpKq9JWPBszAKRATz4boVVwpNQ06Fb9GELzHlTE8KGGqIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6o2YzO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6o2YzO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B621F000E9;
	Thu, 20 Aug 2026 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787246462;
	bh=lBmkURLpssimNC7lOj//TXPNbCMltYZsryeiiKuNsYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E6o2YzO6X3zpO/FLB5nAU7uPwNKGRRHqEPjZ66AU1Y6dVdVlJeoL/Tg1TtDNSXlHV
	 CcC6QssGaV2leMGX1SCFn8nlUdjLP2J7IvDnSMFd1nLy0aP2ngA+fhOw6JApcFY6wV
	 rhcw+Mc+mfNLrm48Tvwt4keJFFqqtTM0Y9lDUuPiRwIwqLxdEB3HFTrGD7LC+m6hnu
	 Yyh/djTcExhKkvJ6Jl2zJlapIkVZCRnkLWBBhgcjtgoz/P9pGf2FhaJlzwEs50H8SN
	 qu8G1ymNMmJKIeccZeJ7KA6iZNRAM/xqPbSaszzgBEtI8q93KSka0ZdW6YAna6m1KL
	 TPZ220u6VXm8w==
Date: Thu, 20 Aug 2026 07:21:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal Blaszczyk <michalblk@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Serialize cgroup updates to prevent CFS/SCX state
 divergence
Message-ID: <aoc3fUfZDnZ0eSL_@slm.duckdns.org>
References: <20260820160956.910663-1-michalblk@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820160956.910663-1-michalblk@google.com>

Hello,

On Thu, Aug 20, 2026 at 04:09:56PM +0000, Michal Blaszczyk wrote:
> Concurrent writes to cgroup control files (such as cpu.shares or
> cpu.weight) can lead to state divergence between CFS and SCX.
> 
> For instance, in cpu_shares_write_u64(), the CFS update is serialized
> by shares_mutex (internal to fair.c), but this lock is dropped before
> scx_group_set_weight() is called. The latter only acquires a read
> semaphore (scx_cgroup_ops_rwsem), allowing multiple threads to evaluate
> and act on the sched_ext update concurrently.
> 
> This serialization gap allows concurrent writes to interleave.
> As a result, the recorded state in CFS, the SCX internal bookkeeping
> (e.g., tg->scx.weight), and the BPF scheduler itself can end up operating
> on completely distinct parameters (pairwise distinct values).
> 
> Similar races are present in tg_set_bandwidth(), cpu_idle_write_s64(),
> cpu_weight_write_u64(), and cpu_weight_nice_write_s64().
> 
> Fix this by introducing scx_cgroup_mutex in kernel/sched/core.c to
> serialize these file write operations.

I wonder whether a better way to do this is just taking out fair's
cpu.weight and .max locking into the core layer so that both callbacks are
called under the same locking. Peter, what do you think?

Thanks.

-- 
tejun
