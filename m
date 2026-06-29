Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D533342C
	for <sched-ext@lists.linux.dev>; Mon, 29 Jun 2026 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757477; cv=none; b=dOmqRPi4xVgI4OpYiJvaHgmkFz40QJagMLMGQxRx2OpyUr/z+ghioDtgVGz8ePm0xIGwAEfFc7NXZs1uWIq4WpS9/oIdr03O+m25DjSGezR8+4WssTRGmUkqbpYPBfIGBLn8NWBx1FzFll38FmmPNL3vA+9CcP/Mh5B+1BFzcfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757477; c=relaxed/simple;
	bh=BkKuvFU+lVKPZM8MaVjJri5iDUgnDTTHvT63Fqeg1YY=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date; b=A4lrxbVyqFxeZuiQaSy+K+PzReVxVe01oD6UeJsLd0RrYerZQS2/9fhCryQCAVlU7aSzbePCEcwJ91nM/s3Hsc6/uocRnlttGQure6VYE0VuYXNelQRP1po1t1UR3qiWL2EUUuF4E/zUIrASwn0WSBfNX/uVKBKjmv1wj447GtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kw38+YG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw38+YG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C681F000E9;
	Mon, 29 Jun 2026 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782757476;
	bh=vTJ0Zj7weT8kCqPcL2aRmrKyRRmeFoQK3KGJsSGoRnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Kw38+YG45tj4PdutC5TFRMAO750aE/JEcK5WhbrSKSSrQ+peMLMWJ3lQ+PJfw/Tnf
	 Zm2v1KbojqZdMLfDmA5gLnF3msXv1VVKfMulQZ45WEHjy0ebg5uzgI/zB8CNGRGYRL
	 IiCdfI2EAEKiclJCXbTXKZpX8WNU/dG7Fw/wZ93w+2ZpGZAo2u6EONRwfQKtKaiTF5
	 dQbPTj7FUYelgYZv7D96lYigDvj3tU3MiGMbdj2GC7T88Lf5HJgVC1LMD9TNhulPHZ
	 f9PVBTTtVMQg7d7Ku8pJYlDuzfbvi4kPd/hjzZpkrj/nOao+uW4OVPIgtSFsHMoQvp
	 uYfRQnzm1VcXA==
Message-ID: <29d059023bf75cd5c40996d5384ed8aa@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	chengyang.chou@mediatek.com
Subject: Re: [PATCH sched_ext/for-7.3] sched_ext: Replace open-coded event lists with SCX_EVENTS_LIST
In-Reply-To: <20260629143532.15014-1-yphbchou0911@gmail.com>
References: <20260629143532.15014-1-yphbchou0911@gmail.com>
Date: Mon, 29 Jun 2026 08:17:43 -1000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Mon, Jun 29, 2026 at 10:35:11PM +0800, Cheng-Yang Chou wrote:
> +		const s64 *src = (const s64 *)&per_cpu_ptr(sch->pcpu, cpu)->event_stats;
> +		s64 *dst = (s64 *)events;
> +
> +		for (i = 0; i < NR_SCX_EVENTS; i++)
> +			dst[i] += READ_ONCE(src[i]);

scx_read_events() can expand SCX_EVENTS_LIST() too, like the other two
sites:

	struct scx_event_stats *e_cpu = &per_cpu_ptr(sch->pcpu, cpu)->event_stats;
#define SCX_EVENT(name)	events->name += READ_ONCE(e_cpu->name)
	SCX_EVENTS_LIST(SCX_EVENT);
#undef SCX_EVENT

That keeps all three sites consistent and lets you drop NR_SCX_EVENTS and
the s64 casts, which assume the struct stays a packed array of s64.

Thanks.

--
tejun
