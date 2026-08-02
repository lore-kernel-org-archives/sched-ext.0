Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA31314A9E;
	Sun,  2 Aug 2026 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785698390; cv=none; b=MUuwfsVoIbroiqIDKiL2/EPSXGTPOl0kYU1nN5tPs1l4KNLX98nJBqSxEqrU5d2shSJX8Gi8ln9Tt1J6LozfOBKKTIgcZa8fL0Eh66aeFC+ymr1yDHhVpxMjIW3m+Ft29Ivl6UIHz1+njE6fCZk2haJorR4iTTDwtaQggs8Qwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785698390; c=relaxed/simple;
	bh=3ljYw2cpsk8dk/f4GmRpwF7tUcTDJrbgT61kjZoMiXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9pZwiI3x9Auz8V9LfAX2EhSYV0WYDFSRimG21vGk8mZizDIvsjjBgMxi9i9ZFoHibd9YAbarDE5cyWS9p7V3gSx5Paj8Qh7yZSVo5YGKywAqed3PeFMxL2Sqgmj11zngmU7OSmLFea2i2k4wPQOx8aEG44NuaZJks2AIJulpec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHLJacuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHLJacuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDD81F000E9;
	Sun,  2 Aug 2026 19:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785698389;
	bh=gI5KZ0e4LVfFSjWI+ZoUmddDL49Y9Q82NbHh+k/OlDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UHLJacuc3S4lnnV3d6a0MMJ+FLckSfHXZx3qdFSAYbhWgE6Kf7ydCQdsN2Re4jxLw
	 c8WbC81XLq3atDQcKcl0/5lYIRQd8ZfbxMfZRr16Hz3ocKFQcpBbck1o7gGSXyuyyw
	 zGIRCMa+8SGU17E/gUUlVkQAsQugH1zUTWxRX4FF6mOgAUOOBS0xqtQhnqH4IwqUW/
	 IcwYYrtGPJVlWLmdYpbekL5Mkh0qYmN+7YgDtBhPh6RV+6CzJn9dETZK7N3AMhNioy
	 nDzVhxKy/J81KMVIKhiVbEcvfa8imztsqbSqqlB8Ew1YH9rE9n2yEfGsBmoHipftRY
	 BVrV5SXavdV6g==
Date: Sun, 2 Aug 2026 09:19:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Initialize idle masks before ops.init()
Message-ID: <am-YVNN5Ga12zHpM@slm.duckdns.org>
References: <20260731182406.3166853-1-arighi@nvidia.com>
 <20260731182406.3166853-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731182406.3166853-2-arighi@nvidia.com>

Hello,

On Fri, Jul 31, 2026 at 08:23:33PM +0200, Andrea Righi wrote:
> The built-in idle masks are reset with all online CPUs marked idle, but
> idle state tracking starts only after the scheduler is fully enabled.
> As a result, ops.init() can observe busy CPUs as idle, and those CPUs
> remain incorrectly advertised until their next idle transition.
> 
> Enable built-in idle tracking before ops.init() and refresh every online
> CPU under its rq lock. Once a CPU is refreshed, later transitions keep
> its state accurate. Keep ops.update_idle() notifications disabled until
> the scheduler is fully enabled.

While a sched is being loaded, bypass mode is on and when we get out of
bypass mode, we set RENOTIFY and trigger kick each CPU, which, if the CPU
has been or is entering idle, triggers ops.update_idle(). So, BPF
implemented idle tracking gets the actual idle state update when bypass goes
off, which makes sense. Would the problem you were seeing go away if we just
clear all idle bits on load instead of setting them? The lifting of bypass
mode at the end should set idle bits for all actually idle CPUs.

Thanks.

-- 
tejun
