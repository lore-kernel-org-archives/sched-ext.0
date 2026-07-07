Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF730C16B;
	Tue,  7 Jul 2026 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783457769; cv=none; b=YJU89tHPhBw52KzaoSd9/pyXo7P/LApI7gxO7AHG0h3lSqH9ZFP8B7OdCUJR6g27kXFXVs3G6WPJZhFleziXr+jk6pQronTekgLuiQoUlBQG97sjdmJzHRID5yVEY9K2iIMsgzWnJBLdTm6h0X+vd7+npM+kWTz3Vd1j1Ls4Jr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783457769; c=relaxed/simple;
	bh=g0+3wSgZwdZaynDTz1U5e3AO3NW8zKRTJYH4XudBjgI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=klbBgqKER8RwpxM6v/hZXI/4RzDIn3NoDqOhSwPhZcV9+sTp0u4FXoWg5cVSu02Nh3X0CPkd5S0JozkzZbPI9bGWY5B/huX6GnK2UMG9NhpIcAlCd7Q2Li/r9tpnJRimf+oqbnRvmXMji6I0vwZZIm5YPhLQZpgjuBRWEl+qe1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNU2RHp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNU2RHp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD911F000E9;
	Tue,  7 Jul 2026 20:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783457768;
	bh=Npb3YLTKLVJaTMYsF+LZZKFA80MEjnC8KqeJ/Q5kecs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kNU2RHp9pleiXgQscyefRtr0fI8xibnUgVnEwFdS8uRhuZ0hBCn2RNwxou9SEWsSB
	 F12dLT7i9/24oh5OI6fg4mFw0SNNvefoTUOGCubiqPBJ7IC471XCDPvlVwOKebvsH/
	 gh6rtc3nelYv9nMg+DKrQlkc6qVAl8FOIBqXfo+7HGT9POoow8m5gkHerqJ/rOG5nB
	 peS6jxHadbRedT+vFup8UFk2B80+W/YYEmPm9FTHsY3ZCF0J9VVZ32VFvlL85J1UZ+
	 djrsN4038dRwb8IPIAEhWOhq2iVZ2zT8qZL2ADL4euUpasydCmfr98+yyLxWLKygyF
	 fY1HjEkakIZbQ==
Date: Tue, 07 Jul 2026 10:56:06 -1000
Message-ID: <e18280314c02c349b186b09a3fef41af@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Enable tick for finite slices on nohz_full
In-Reply-To: <20260707082537.918068-2-arighi@nvidia.com>
References: <20260707082537.918068-1-arighi@nvidia.com>
 <20260707082537.918068-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Tue, Jul 07, 2026 at 10:17:59AM +0200, Andrea Righi wrote:
> 	if ((p->scx.slice == SCX_SLICE_INF) !=
> 	    (bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
> 		if (p->scx.slice == SCX_SLICE_INF) {

The slice type is tested three times here (the XOR, the inner if, and the
finite tail). Can you split on it once instead?

	if (p->scx.slice == SCX_SLICE_INF) {
		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
			rq->scx.flags |= SCX_RQ_CAN_STOP_TICK;
			sched_update_tick_dependency(rq);
			update_other_load_avgs(rq);
		}
	} else {
		if (rq->scx.flags & SCX_RQ_CAN_STOP_TICK) {
			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
			update_other_load_avgs(rq);
		}
		if (tick_nohz_full_cpu(cpu_of(rq)))
			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
	}

update_other_load_avgs() lands in both arms, but the infinite/finite split
reads more directly than keying off the transition.

Thanks.

-- 
tejun
