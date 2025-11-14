Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246B355038;
	Fri, 14 Nov 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155193; cv=none; b=efpmGE6fGMokW+viZSwx6x9yZTCgk4b4DCu7j1YMvXXefNmtygrrc+eY4vUB0d63cp4Dei6AEQ+VS4XhvtURqu1VXBvF11zoGqh826R/fPL8cjafPe6snxXsUHxntLs9i7idXxJs8IijIUUvQY/NKMdSgqBXVQh4Q9A1BTwnPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155193; c=relaxed/simple;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=aX0KNE1jeCPTBE8l9j49T2REFLgrWDueAP4t6fGi9otlHvICgVbv/ozuzWxGTTmiBgcrlNinqeyRWoHJVDUyjZzc3L/H6JByYEe1UNxVoc7eCdyheYY5eA1QApVJXo2HfzdoEOUVGCSHS62HTcOL5NJl7/7czDZW0F+qWj7jSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYKirlEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYKirlEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE19C113D0;
	Fri, 14 Nov 2025 21:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763155193;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gYKirlEfny8N3KdR286RTXvPNfeCzNAly6zYxNlLKWyfG6m8lgwt3PYiQgygpxHqZ
	 lm0HmdWT/eXK3NdwL09AvDep1E7Uyc8P0rMmWSclR6hs6ws80k2bxlkiplVovIeXl8
	 nnuD4e5EGP9zeUl9+ujyfmK2w2VlGJTOXD5g6ENCxgL/8QvIKrQ8VKp6Ks57rigKEu
	 xwjqFM0Ml/0s88DoE+VSxsW3f5N6/oNn9F+qCaCpkuWaPmKQxOi64XxPrMhxOTtjny
	 Kl42ww6bKlPB7NI0k1LUOmoA6Cfwz/mwk7FRWNBLmM5da91MDiEE4ppxNuVnOEse0J
	 U3LSvQP8X2wIA==
Date: Fri, 14 Nov 2025 11:19:52 -1000
Message-ID: <c1e8f03629102565c2bb65d9b638f320@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>, Andrea Righi <arighi@nvidia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Pass locked CPU parameter to scx_hardlockup() and add docs
In-Reply-To: <aRaG9X9xfS_QL2QF@slm.duckdns.org>
References: <aRaG9X9xfS_QL2QF@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19.

Thanks.
--
tejun
