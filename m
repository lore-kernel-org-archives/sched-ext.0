Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC63E638B;
	Wed, 24 Jun 2026 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336516; cv=none; b=KRD1UFrZdpJKCpXpGcYfMyDkFOfJl+IvOgvfvZjgbANRJ3jPYe1cVDK6IAR4MgsIYpW95lrpW1P7rAKluPd6tt56V3p+pZs68aEJNl7W9WJc23No45QGXXrjk+P6xDtnemKZq9NZPH0ocEyT1W2S+2CEkMLmQM7aREEWVcr1vB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336516; c=relaxed/simple;
	bh=QZy+W4+BNWiqF7AxQn8o27OELqmWr3Sc1evQOKfzb4s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Vemc4vg5e83Ty6DFz2h45fpKS7cO8tKN6Q39u84YnkC2uSBJTnvZX6GaL09cVWk+Wv8QlFrBdC5WG0qA/mMcoXnNoilwZN/RW6XwXA9SpQV+eSdrozc0pwfjkHxRzek+fVFnunIiIHBcJPnFIn0KWBMX8yElsftGVoFKg5RHCBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kpr4NpSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpr4NpSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C526B1F000E9;
	Wed, 24 Jun 2026 21:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782336515;
	bh=QZy+W4+BNWiqF7AxQn8o27OELqmWr3Sc1evQOKfzb4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Kpr4NpSAE442HYOCRTJj1ZgKt2RFjQbv2YTw/3SJ7cilzNyvnG/BmMnmtRo2ZuTSX
	 s38482eR3ADGbZN4DgPZQG2+7NG4f9kF3n9/DOvqBm0iqx0WUGlgaZUTifdi23TCcd
	 cGYBVX/fz/RJdv+M0DOYQh4WnT46leTlyvvbc7nhuofsbtglm0TjhrnrkdtLQL1LFW
	 updGMf5JCGCrAeoQb8XnjQU0k9uC9cmQGJHysnzZZJRRLh3MXwYZF69CTekcFxBA5h
	 4XQwxhGTt2o3f4lPJWwzkzPlrYdp9p4pcUrXEk47TKxhfaGIz6TCPVgWSdxIuu1cF0
	 SCvow3OwZiQxQ==
Date: Wed, 24 Jun 2026 11:28:34 -1000
Message-ID: <902029b0f197f00e2697ee4de6eb6a2a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Wanwu Li <liwanwu9113@163.com>
Cc: sched-ext@lists.linux.dev,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	Wanwu Li <liwanwu@kylinos.cn>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH v2] sched_ext/scx_flatcg: Fix cvtime_delta race and add hweight scaling to bypass charging
In-Reply-To: <20260608072457.3-1-liwanwu9113@163.com>
References: <20260608072457.3-1-liwanwu9113@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3.

Thanks.
--
tejun
