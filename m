Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50803F39E0;
	Tue, 14 Jul 2026 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016465; cv=none; b=n5JNcWqCU5kQP52od+YwT0Edee4/cq1cw2Jy0246JVOfa5fov4MeqNEjtpFI8OAJF9CwfeVVuU6lFuh9MJRGBtn/NRhZ4Kpu5S/xFHackX/1ZVqf2o385hH7ScwsoLa1Zv9H2yEP+s0go2iyBf36uy3sdOIaZ2eAC/MO0IveILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016465; c=relaxed/simple;
	bh=yymu7pX1olpJnZgqTPiyuTAISFaK+DCGp0TLxJXpy40=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=jcHSZdIKyAnHVQnEvra46cQ3xXrtnZjnMRLxVOGPWFUsg58GM3UW9QK2jzsD5yT79GzFHeyVFNg67wws9nwfQxJRMZG23637+0e2wNYkQ31jyweLfunKRBX89tRx0OmpX1DOCka9iE6t4gROVz0kdEwoUGpm3a0ka+bhnqQbjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B38z0U2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B38z0U2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C741F000E9;
	Tue, 14 Jul 2026 08:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784016464;
	bh=yymu7pX1olpJnZgqTPiyuTAISFaK+DCGp0TLxJXpy40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B38z0U2YqQznd82KM/pwQYnIG0UYBctDO+hS0jUtCdrorRk2wZMR7RL+8s/ewNJe7
	 IHXAgwP4be/2rKwqC+/R09kNveQZzDeOz66tNz6JB0qdNpDYWgia/Uodzg3+s+gxm+
	 kn6ABAWSbFW7/9S7pnecVsJ1G3su6tFsJ3hI7ddlEbyxT7RKGyHZgCjiCv7zlMJTZ/
	 GFKFbLmuR1MUumFgfEFHJxwU3BcHpEKty/UQf5yOum7inaJADn9MnUSRaTWMRrO+iP
	 ytj17XGQvEmFH2I2EF8zm4/KHJqFr34nv1pCQPhW5ADgc0mX9lJt6F+iJSg1jAnalt
	 dJs4ZhlrlJIsA==
Date: Mon, 13 Jul 2026 22:07:43 -1000
Message-ID: <8839b71f9320a2fb81be66a2ca84cf86@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v5 sched_ext/for-7.3] sched_ext: Capability-based CPU delegation for sub-schedulers
In-Reply-To: <alXg1Ux83csDVjKf@gpd4>
References: <20260709225041.1695495-1-tj@kernel.org> <alXg1Ux83csDVjKf@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Tue, Jul 14, 2026 at 09:10:13AM +0200, Andrea Righi wrote:
> I went through the series and tested the resulting kernel under virtme-ng. I
> couldn't trigger any crashes, lockups, or warnings, and I don't see any issues
> that should block applying this.
>
> As I mentioned, one possible follow-up optimization would be to introduce a
> "scx_has_sub_scheds" static key, indicating whether any sub-scheduler is
> attached. This could preserve the current fast paths for the common case of a
> single root-only scheduler, avoiding the small potential overhead of
> sub-scheduler-specific hierarchy walks and capability checks. And it could also
> enable additional optimizations in the future.

Yeah, gating the sub-sched-only paths behind a static key while no
sub-scheduler is attached is on the todo list. Will follow up with
incremental patches.

> For the series:
>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks a lot for the review and testing.

--
tejun
