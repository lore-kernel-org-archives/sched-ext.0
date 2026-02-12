Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0841B81D3;
	Thu, 12 Feb 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770921356; cv=none; b=ODCUbXeo6PCRXQoQ0fVHeSvwKHIS6pPpuN57k+USJLA/OEYqCVMpvduqBg1fDEi2XKDtK0TzuVF9vkjY9DOdR5N9/iIXlYVVupOe0kVFD/JTB53sJK6nlSAASONMjQ0lIEMAqRVt0SiyZn3xE/em506KNo1k76ULgZ7obQD7dxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770921356; c=relaxed/simple;
	bh=B51C7gSbnM3kEtEhfTrQ2m2A8zctroEBc9InOWt49Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGhV7RBwt3rmEIlik80hapCL2oRb+8ZKj049RndxjP+UOU25O2WCaBaFUWeOoJyZnswsvJYA9757Bc+iomwv+Pv8c1DlZlL/Ob3XqmiAz6X1OX6fw9AkiDiNN66ICqubTBMczNemD46hrEs7oRuVtt7CnuGSqnG2r/EAum6De68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWc6mFNP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWc6mFNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AF5C19421;
	Thu, 12 Feb 2026 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770921356;
	bh=B51C7gSbnM3kEtEhfTrQ2m2A8zctroEBc9InOWt49Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HWc6mFNPh0Blx3+OS3dB5uLw9THYCNUUqZNVrOwrjYM8ESw3wKEnuY/77RTVWowJS
	 5dMtDXAw2U1WlTdMdsTI/cxtt9Jem7PhOVNNjVfoXAXWMsNe6/f2NSLS2uGxSMMkSh
	 9DgXtMB5okngi2ctLe6glHBv2xuXsQi6r2DdaWdA4ICM3lOhjByCi1mn52LEp6xXwJ
	 QPt9vunDPOFNCKx/U1YBm7HHnJMFosOhaT7MVNWMDB5bxRGrsV2V1wqVnVoPQ0deMy
	 8hb4IEHnhK23dFvCpRwqeB4Cc0gc2tkeY/g3S967pBuAlJZllqvrMK2Cxt9rIepaUY
	 s5S6NGTzb/K3w==
Date: Thu, 12 Feb 2026 08:35:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aY4di9M4BUfutfrw@slm.duckdns.org>
References: <aYu9KzKTMfNIFDwD@slm.duckdns.org>
 <aYyo_ALV_BT6WaE0@gpd4>
 <aYzc7ZVkSrtdeHnA@slm.duckdns.org>
 <aY0EDpFD1FSrigB6@gpd4>
 <aY0EmUnmo4gGitcW@slm.duckdns.org>
 <aY2ofYcZpni9L0px@gpd4>
 <8dd4bc8d-83db-4812-b3e3-ea0bbbb24875@arm.com>
 <aY31pzTFyZ-nKK1J@gpd4>
 <aY4IuX59PsmSsi1g@slm.duckdns.org>
 <aY4YdW79Y3FBM5jo@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY4YdW79Y3FBM5jo@gpd4>

Hello, Andrea.

On Thu, Feb 12, 2026 at 07:14:13PM +0100, Andrea Righi wrote:
...
> In ops.enqueue() the BPF scheduler doesn't necessarily pick a target CPU:
> it can put the task on an arbitrary DSQ or even in some internal BPF data
> structures. The task is still associated with a runqueue, but only to
> satisfy a kernel requirement, for sched_ext that association isn't
> meaningful, because the task isn't really "on" that CPU (in fact in
> ops.dispatch() can do the "last minute" migration).

Yes.

> Therefore, keeping accurate per-CPU information from the kernel's
> perspective doesn't buy us much, given that the BPF scheduler can keep
> tasks in its own queues or structures.
> 
> Accurate PELT is still doable: the BPF scheduler can track where it puts
> each task in its own state, updates runnable load when it places the task
> in a DSQ / data structure and when the task leaves (dequeue). And it can
> use ops.running() / ops.stopping() for utilization.

And the BPF sched might choose to do load aggregation at a differnt level
too - e.g. maybe per-CPU load metric doesn't make sense given the machine
and scheduler and only per-LLC level aggregation would be meaningful, which
would be true for multiple of the current SCX schedulers given the per-LLC
DSQ usage.

> And with a proper ops.dequeue() semantics, PELT can be driven by the BPF
> scheduler's own placement and the scx callbacks, not by the specific rq a
> task is on.
> 
> If all of the above makes sense for everyone, I agree that we don't need to
> notify all the internal migrations.

Yeah, I think we're on the same page. BTW, I wonder whether we could use
p->scx.sticky_cpu to detect internal migrations. It's only used for internal
migrations, so maybe it can be used for detection.

Thanks.

-- 
tejun
