Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994633F5BF1;
	Tue, 14 Jul 2026 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016516; cv=none; b=GxqGhglYpmdPCTgU9P23WPgu2p2Kxv3pkocXz9C3bQRTMqYYD0cIinaNF+NHTHpg/hToo3s8ZmBdgBB4bcnlhGE/ec4CZeW7gdh/XeM/8Ynxo+keW+4m9CQk2JqKLuToRtMt7OtXmH7LIf6eipAHVwNMOjAIeKNRpyIOSf4pQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016516; c=relaxed/simple;
	bh=beQq+pOqEgJdpF0gy8OhqUUM1PyV8k3bcIwHp4mGJls=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=IsYphw+MG81YSg1VOw+Wub+DZVcs+6Y3oVU+oz5dav7VRn/V0cE31o8KEka3Lom05GmGtUUHk/0ikNqQRAh6x1Hq+D7q5t495Yt8/Mj0BvpkIG/s6kNjTfTOZle479XlqlkHOcrPuC/+fbGU1Y0FqrTVCA7gwopwxwOpays0pyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtGRpAT8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtGRpAT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0541F000E9;
	Tue, 14 Jul 2026 08:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784016515;
	bh=beQq+pOqEgJdpF0gy8OhqUUM1PyV8k3bcIwHp4mGJls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TtGRpAT8lRwO0/DWiTvVnO9S4Jnszq28NcOjlLDJzL5ZXkEQcPNCd9DPklpx1LItz
	 u+CXNoAZQw3CCaXPuWYl0kAdeVGEi+c6x+7rMenQV9CZxdHV1e9zCKOoeD+kuVLM1w
	 N2/cNt9mpQk58JyyesABd6Qr1RkQ9D4T3WhnCh/SHpDrwfQIjYnRgC1sxJlNP7jgmo
	 2H+etrfeIuhaw8WPpZjbqfa3SjP5yhrDTm7BdAjmse0q+q9vAKI1Dr87o5mJfHIURY
	 AoqxvzYVgEnlh0YJZd8LjftZyU9PcSYXGpaLO91/XDv04AmilNmZa/NsMS21zuWx9y
	 A8LLOVTYeGBIQ==
Date: Mon, 13 Jul 2026 22:08:34 -1000
Message-ID: <5f8e1695cf3d1fe7692aacb0bf7f6209@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 sched_ext/for-7.3 28/33] sched_ext: Route ops.update_idle() to sub-schedulers and re-notify owed scheds
In-Reply-To: <alXUrLY3WMdAyXIc@gpd4>
References: <20260709225041.1695495-1-tj@kernel.org> <20260709225041.1695495-29-tj@kernel.org> <alXUrLY3WMdAyXIc@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Tue, Jul 14, 2026 at 08:18:20AM +0200, Andrea Righi wrote:
> So, this makes every real idle/busy transition walk the whole scheduler
> hierarchy and potentially invoke ops.update_idle() for every cap-holding
> scheduler while the rq lock is held and IRQs are disabled?
>
> This becomes O(number of cap-holding schedulers) BPF callbacks per idle
> transition.
>
> I haven't benchmarked this, so I'm not sure if it's a valid performance concern.
> We don't have to fix this now, it can be a future improvement. In that case, if
> we prove that we have a real bottleneck here, would it make sense to maintain a
> per-rq list of schedulers that both hold effective SCX_CAP_BASE and implement
> ops.update_idle()?

If this becomes an actual problem, we can add an opt-out for update_idle
notifications and maintain the list of scheds that are subscribing. With
shallow nesting and most cpus granted exclusively, which are the expected
initial use cases, I don't expect this to be a problem in practice. We'll
see.

> Also, for the root-only case, would it be worth keeping the old direct
> ops.update_idle() path behind a static key which is enabled while any
> sub-scheduler is attached?

Yeah, will gate this and the other sub-sched hot paths behind a static
key in follow-up patches.

Thanks.

--
tejun
