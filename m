Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C406B352927;
	Wed,  4 Mar 2026 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641438; cv=none; b=S1VDwK7n2DeizCZraCeL4Y3oLd6972Ic3f2Dp9yoSSzw2HLZ5jgf3Ho7wNboecBmmlaiUshO27yqlkAL7FPLPUdBJDcZtYI62o0gcyhiWPYdqWj3uSH1GmkcZMTGSwF3hG8nt3lcYWrPXIppcN20AqsZ8FLfavCHIrVJ2u0Z7KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641438; c=relaxed/simple;
	bh=YoBEG/g2fRIrJHJfjj1ab9mABaW131NHA4+TCn0FA0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9oEX8x+kYH7EC17Abic1CaNgJiLPgM+rnbOn8ksSkNpFwZXmIah7Q5ND2/MyFX0+qsW9OtFocxNTyC/mi3PUlvE8HusIP1HZVPDMJnKUEZcniEXdX/KFaCYiRSo2k1nM7Oe8Hw0RuMKZfwfX1Fo6vtCFYiimMcPLOMx/k9r+mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpAvWx1x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpAvWx1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B590C4CEF7;
	Wed,  4 Mar 2026 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772641438;
	bh=YoBEG/g2fRIrJHJfjj1ab9mABaW131NHA4+TCn0FA0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpAvWx1xB3rEn+3ueggmdlyno90rYP3z4LvLwgFHkXr/X2IyJjftSY8mJAeymVWDY
	 QF1Yc8o/zzSCdbzKRGG0AUq1vfYEgqB0iivIZVLvOnuhg5/KoR0/UnebOWyDXwzCDk
	 0ZgMXTAoDWH0RCpteBkNybE7xZSeN61FOUl05iuKNf40AI0nTPiDXiLJeObhbXQoif
	 zrkxX/n6aTil30mf61vo3BG4BGoPjtI2nZKks8tAwRrPqPIcdfnUb9iEHVKQ9/A32e
	 sCs3jiW8CgxgxLDrXj6pTY5EmUPs0jcW7sM4vVBuTX3KBqqaFYsfSoX1mItrctg7iK
	 TMzH0pyKitL5A==
Date: Wed, 4 Mar 2026 06:23:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Document task ownership state machine
Message-ID: <aahcnV2xPabCGc-b@slm.duckdns.org>
References: <20260304153343.340285-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304153343.340285-1-arighi@nvidia.com>

Hello,

On Wed, Mar 04, 2026 at 04:33:43PM +0100, Andrea Righi wrote:
> + * Task Ownership State Machine (sched_ext_entity->ops_state)
>   *
> + * The sched_ext core uses this state machine to track task ownership
> + * between the SCX core and the BPF scheduler. This allows the BPF
> + * scheduler to dispatch tasks without strict ordering requirements, while
> + * the SCX core safely rejects invalid dispatches.
>   *
> + * State Transitions
>   *
> + *       .------------> NONE (owned by SCX core)
> + *       |               |           ^
> + *       |       enqueue |           | direct dispatch
> + *       |               v           |
> + *       |           QUEUEING -------'
> + *       |               |
> + *       |       enqueue |
> + *       |     completes |
> + *       |               v
> + *       |            QUEUED (owned by BPF scheduler)
> + *       |               |           ^
> + *       |      dispatch |           | affinity changed
> + *       |               |           | (dispatch aborts)
> + *       |               v           |
> + *       |          DISPATCHING -----'
> + *       |               |
> + *       |      dispatch |
> + *       |     completes |
> + *       `---------------'

I don't think we transition tasks from DISPATCHING to QUEUED on affinity
changes. Not yet anyway, right?

Thanks.

-- 
tejun
