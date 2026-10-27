Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085080;
	b=JKiU2y7wQ+QWQJYa+6/KLBoz9ph16BNdf6sEnFteJq5IwwssO7CZzc6bir1UAAb9FNhS
	 +lM98TP+PjpK96WDZQh4KAuNa79ztRs/gEUKT9SYVwNb6m5aGXwO4xiD4bwVCfF3KOHyo
	 5PEWcqiIdNzQyItWbf0xMvrZUSkKxmFpxdx2+qWxmAYk+R3CiuVdijPhmVPd/styKivUa
	 Kr4IP/XwPrIhesEAikIYGZk60mRC2tZ6Byh1YiExPIK7mBE4YKxy7VEZJuTRHEacYJPSA
	 oPLeqsv+EMaoe4vbmEn6RqkNon8y9CPprjtW15Vi9IoVWC7t700hXCTbC1592A5EHxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085080;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=kzCCSxGqIOflYF/5kOzEFXx9NL4cCf/soNclBud8pGk=;
	b=O7JZE9tdMr9SMU1G3Wl6T16/4qRJGlC+rVd5giAF2yeb2idcPnzkqHcfDfj9abDQj5Tg
	 3GwbwopiHlLjw31VywAMvvwedLEbmUMLJWd0aDr9RbGg0j1C2XG9QzLrEJQu12dz2B8G5
	 5YcdFEtl413Sx1EzCSV4N6Kn7tSWyOD3+OsxS1h+FdaACf/3Wfy49I4cR+w3AJfym8ynZ
	 drMwZrKflplPipNdSNvFYdRm+GFTI0JHQ+i/ntHZ/V24x7TdOTjKevcqKa1nB7uuKWo3V
	 DPYfji4eaB6ow5fCtaWWh1r7MtqGrl2yCSkaJXP1rXRHkEE0nVnlpdkDCwjvuUYGbjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5VSyw38;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C7606A31B;
	Tue, 27 Oct 2026 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5VSyw38
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65991F01825;
	Tue, 27 Oct 2026 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793085078;
	bh=kzCCSxGqIOflYF/5kOzEFXx9NL4cCf/soNclBud8pGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N5VSyw38/5x7qTXDKuXGHR565Cxa4aKdrrXOj8xdmuUwg5It6Uy5MtD9ilin3cNkj
	 U5X2uqM007HR8gzxZizwNj9C31ZjA24gNp7ZTEr8oRq+/MJM4FaqlJ08UDg+KLO9i1
	 gEE5l016a9e0v5uRcKIBCwKugGGp6dyPIH2uZSETZTaP0TUjEOhgkJ0Uh5kfAcW3B2
	 hF8HjLMGCiZID9X7NKUJmpdNtPyPlTUGlQigXbYAcy6rWkdIA+Eo1OdIDIcLTcgMUc
	 q941vbvLchHAkkUnkVGaMCTAcE2IqYwig9KUY/MuC0ktop5FYw3NkKxCuce44ZadFa
	 WmC5DdiUiNZFg==
Date: Mon, 26 Oct 2026 21:11:17 -1000
Message-ID: <ff5acd0de29994bdad47b17a43ad5861@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Fix the stall watchdog testing and blaming the wrong sched under bypass
In-Reply-To: <20261026204300.3618150-1-tj@kernel.org>
References: <20261026204300.3618150-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Applied to sched_ext/for-7.4-fixes with the following tags added:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
