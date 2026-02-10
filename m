Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE57E1A256B;
	Tue, 10 Feb 2026 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684125; cv=none; b=KEOWn2tUZH0dpMR4CjjbEvbYQo2Cux4C0AsVlsX0h/Ms+tA3laClq3HIp5R7IgEUrLY3bbMA8xTFkgAFwcPgM+N1FUoQ/SI7hHhp+eKX49K2PHFOH1OGD3uRQNRZxNOvX4+f7legDkHxLnf5u7E+tXE6hF0yFDG6WIQgyXiokdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684125; c=relaxed/simple;
	bh=I2zN1F1g4OhEwUeFsCF4EQQYEFDrMHzWSoEbgAkIdfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOTHWvQCWhEi7wXp6ulVzRiAECqz2D0qkH2O34lJ72E3k+YtmzbulPUaE4x3HubocRX+y+jp+WqFBg2fxri0EFZ+LFR1DEqe9w0q06+w4+/ObLaHOhCaPEjZVjTtxLWH/aq/awWtAB9yLuhpuHQhs6/VofiPqMP09Ev/fBAFeJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbraqC66; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbraqC66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F535C116C6;
	Tue, 10 Feb 2026 00:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684125;
	bh=I2zN1F1g4OhEwUeFsCF4EQQYEFDrMHzWSoEbgAkIdfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jbraqC661BgdR4h24CtN/AxcT5yyoaIbkcQxHqr65cnVQTb+DXoOrrQTwRJJBpuah
	 msBk98gxnZAfWXVf2UjYBpWArxrRpuFvt0h1bE80+2Jen7WLsHgxdHUz0XHq9iGYn4
	 eRFehyZ19JnT7JP5s0e63bg2WOD1eq7XaaulJ4yaFQvZ1fISsji1ctpL+FqWzlBlvb
	 LuvodHewaPDu93HX8F+EArQtzziTeB4imsutfj6jFpPKpjeYPE0SZiRbwlGZWcbEdw
	 ylEY9jjOLQPXgC5d4f6OT8O0Qpf1ZNA/lMCgzMVvut/GNDK5IXWXAXzHPjnpRJheGs
	 dnfQCTsI6vtsg==
Date: Mon, 9 Feb 2026 14:42:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
Message-ID: <aYp-3IPOWMsEeEq5@slm.duckdns.org>
References: <aYiVv998mfMGVMCq@gpd4>
 <DG9RY7Y4VMWB.2IL8Y6Z4P5IA8@etsalapatis.com>
 <aYjtOQP0tmGIqoOM@gpd4>
 <aYm00oHl3BRWNFFA@gpd4>
 <DGAIRREHTBTV.E8XTJPHQUAN8@etsalapatis.com>
 <aYoAmES8tKNZJkdx@gpd4>
 <aYoYECCY_k1IrGqp@slm.duckdns.org>
 <aYoyxIkzp0E5dL1g@gpd4>
 <aYo_NsAkKvyMoXYv@slm.duckdns.org>
 <aYpeG8ZUHKizSLAE@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYpeG8ZUHKizSLAE@gpd4>

Hello, Andrea.

On Mon, Feb 09, 2026 at 11:22:19PM +0100, Andrea Righi wrote:
...
> Ok, what you're saying is that a direct dispatch from ops.select_cpu() is
> just a shortcut for work that would otherwise happen at the head of
> ops.enqueue().
>
> So, while ops.select_cpu() itself is not "being in scheduler custody", the
> semantic operation of dispatching a task is still the scheduler taking
> control of the task. As a result, a dispatch to a user DSQ from
> ops.select_cpu() should be treated the same as a dispatch to a user DSQ
> from ops.enqueue() for the purpose of triggering ops.dequeue(). The fact
> that this happens in ops.select_cpu() rather than ops.enqueue() is an
> implementation detail, not a semantic boundary.

Yes.

> Under this interpretation, storing a task in BPF internal data structures
> from ops.select_cpu() should not trigger ops.dequeue(), since the task has
> not been put under scheduler control yet. However, dispatching a task to a

Also, ops.select_cpu() putting the task in a BPF struct doesn't affect
what's happening in the enqueue path. ops.enqueue() will still be invoked
and the task will be transferred to BPF side iff ops.enqueue() does not
perform a direct dispatch. Imagine the following (unlikely but possible)
scenario:

   CPU A                                   CPU B

   ops.select_cpu() puts task in a BPF
     data structure
                                           ops.dispatch() sees the task, dequeues it and
                                           dispatches it to CPU B's local DSQ.

                                           finish_dispatch() runs but the task is still
                                           SCX_OPSS_NONE and dispatch attempt is ignored.

   ops.enqueue() runs and returns without
   doing anything. Task transitions to
   SCX_OPSS_QUEUED.

Afterwards, the kernel considers the task to be owned by BPF but the BPF
side thinks the task has already been dispatched. It just doesn't make much
sense to do BPF enqueue operation from ops.select_cpu(). The only reason it
works for direct dispatch is because the kernel defers the operation to the
enqueue time behind the scene.

Thanks.

-- 
tejun
