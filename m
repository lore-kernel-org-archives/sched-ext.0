Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9EA335BA;
	Sat, 18 Jul 2026 04:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784347929; cv=none; b=W86CJ7+wtXwRxwv/UCHc3o24oWx8BmhSJiK6A8KeDP0xy1qXPmhTHWxmSqjR8Mi/nO9ul5HecfAsaqZolmBdXGx6CBDb+YhaNHTtgk5diXXmVpcc+tBziyIZhhy30bZ4BbJuI6QZFz8yjGsztX+nnw369/xe5MG0Ad70Ywicpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784347929; c=relaxed/simple;
	bh=4L9npshErjUDXkNVK2Z4XzYI+AZmLxIoYpef+vSPW7I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SgF+Fk/Xfts13aK+hfnJ/3gNqFD1mf0lEhsO4F7vpu3wXL5jlTHS6At3NbXXUxzBDo2n4/Sb6CgfaBNtM+JDTKpMkJRq2aLQ5fF0EBhhCpV6BcOOaDreFk1xya95Z7JQOw7PS4aTc8VVlMsUuNxVM09BSKa17w04ZwTJBV/uuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoLhPavK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoLhPavK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEDA1F000E9;
	Sat, 18 Jul 2026 04:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784347927;
	bh=4L9npshErjUDXkNVK2Z4XzYI+AZmLxIoYpef+vSPW7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CoLhPavK9s54t455VH/GZ3BbAiGRxunjKz9jpSyVzmwHeGlIcVz0CgWNoFEQCZ52I
	 ZFHM4Meq+baDfzA6xB4+Z9qDZlJytbtvixedI5ebxPH8LY3xxUWXPn1Z68+5zDDYkv
	 4iA+5vxpJZLVeFrYD2qqy3Ph1Pd6YiERryHN1snPLWfY9Y5L8nR7SlYZiABqx0P4zT
	 5JJFNTdAl9IXE5rnilFMm0/42Xm14xZTv86OORhQEdPlVcDHRatfZgRwFcodA8fZ0S
	 dWfJc2T4OnLVva0BpQ0z0/zZ7YCCWraBhg/ayFYfJjU1yS4/IhOxjWg1YjkLtbvNyS
	 PXrJBwucVeciQ==
Date: Fri, 17 Jul 2026 18:12:06 -1000
Message-ID: <07c4ead225875c51af6599ee22c2e7a6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.2-fixes] sched_ext: Assorted sub-scheduler and cgroup fixes
In-Reply-To: <alnxrsexEe_nQwqL@gpd4>
References: <20260716213058.1739522-1-tj@kernel.org> <alnxrsexEe_nQwqL@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Fri, Jul 17, 2026 at 11:11:10AM +0200, Andrea Righi wrote:
> I randomly triggered the following with this applied, but it looks unrelated to
> these changes:
...
> This might be a pre-existent bug, I'll investigate a bit.

It is pre-existing. Cgroup migration doesn't update p->scx.sched, so a
task moved out of a sub-scheduler's cgroup keeps pointing at it. The
sub-scheduler's disable path only walks its own subtree and misses the
task, and the task ends up holding a dangling pointer once the scheduler
is freed. In your crash, the watchdog read a garbage timeout from the
recycled memory, declared a stall, and the exit propagation then chased
a garbage ->children pointer into scx_claim_exit().

Reproducer, on this branch, KASAN reports use-after-free within seconds:

1. Run scx_qmap.
2. Put a CPU hog in cgroup A.
3. scx_qmap -c /sys/fs/cgroup/A
4. Move the hog to a different cgroup.
5. Kill the sub-scheduler.

I have a fix series which re-homes tasks on cgroup migration in the
works and will post it soon.

Thanks.

--
tejun
