Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E48372064;
	Wed,  1 Jul 2026 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927256; cv=none; b=mrTmMHbtnzLH/veFsDbgp7YD/BdRcrJV5+j784OFL2SyqZtbw75v9asMcOnAwjsgbdV4RUhKPfy1Iq+uufHQw6AvR1R3h7UBXfeUb08KZgXZjywU99YgVnx1a+V1UtM8XD/dvs88jAzAHy4mBgS+sXakBO0yPCj69pj5ojAOnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927256; c=relaxed/simple;
	bh=K1Bl1KqAOfHBvOb2kmsvig3E228x2yfLa+NkZz+47fo=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=K+5UJufY2sVpwq8e5lTyW34TMqzOyTcEZvsOob+Yp5mFdyueZYsSsFhgxfAOElGNhNalkzLIJOZ3dxqykCNehGM3nFuAnSfh2ewLQicEHZ9cJFljfEu2od7ArIQjYCT87VAlQme0r/+sJAxIuLXBKN+Te2kKXYavt15rAQA7iNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czDAZprf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czDAZprf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1C91F00A3A;
	Wed,  1 Jul 2026 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782927254;
	bh=K1Bl1KqAOfHBvOb2kmsvig3E228x2yfLa+NkZz+47fo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=czDAZprffhbeRV/+lAiiQEF4a57cVV8REIwfflKk4tsjs3aMUB0eC/BL5mkUM4vZz
	 8ei/oD9aSSfUVObhrSYgZvyyPFOm+9W1fy9FXkjA5P9XVT72lve8VIr/drhy1YY2Sb
	 1DAfUSsozCKzOTyyx6s1r7oFQREeJYKMr4jW7l3nfJfM6id574lZxbjXuG5/DZB6J3
	 YCtOf/D1qwws5J+d4BXUM8QOc9uVC3ZLmE3xdvNvTBVyTv5I+9uPUQPKoGtqJiyjml
	 4vs3uJvw7tNgEcikCyF6LPVZYASL+UVTYldYwKZ3MGz8NZfG3Gk3yQfYlXzf5KOrOx
	 pLVvWMiRk5jmg==
Date: Wed, 01 Jul 2026 07:34:13 -1000
Message-ID: <f75cc79a53d9f759d93b863bb612bde1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <akTmFanypN_dRJiG@gpd4>
References: <20260701031429.1892218-1-tj@kernel.org>
	<20260701031429.1892218-5-tj@kernel.org>
	<akTmFanypN_dRJiG@gpd4>
Subject: Re: [PATCH sched_ext/for-7.3 4/4] sched_ext: Split sub-scheduler implementation into sub.c
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Wed, Jul 01, 2026 at 12:04:05PM +0200, Andrea Righi wrote:
> clangd isn't happy here, because we're missing the declaration of
> scx_dispatch_sched(). [...] can relax the always inline condition?

My slicing mistake. scx_dispatch_sched() gets promoted into sub.h a few
patches later, and I posted the split ahead of that. I'll fold the promotion
into the split and send v2 soon.

I'd rather keep __always_inline, though. scx_bpf_sub_dispatch() re-enters it
as sub-scheduler dispatch nests, so inlining avoids a frame per nesting level.

Thanks.

--
tejun
