Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA213959D;
	Sun, 29 Mar 2026 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774743643; cv=none; b=o7M7zGyBJY5LAIEtTBej3lJpS+Dte046jpJTYqonjafocXdsr0td8wbyKRwWnrbWX+zE8JBLuotQHx/E8XoHo2N5/pfCC4JGpNL2apj9OWTXuy+Wf0zIW6tDSVjXVcL9MX5cEBmahNSedar705LDkw7vEWASv+nGc8gMch8MkiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774743643; c=relaxed/simple;
	bh=iBjcUas4szwLS8i0MrfSdHNF7sZCD3Sz7+3s4V9sygc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=exu+4HzkoHJs19a9jZqWG/ro6zxTa9PV0Wl3eMYyuk40lB9k73HzbTae4e8+vDKGLbmVt5O233AgYYVwSimhHp5ahv8DZCPifCCnV8Tbqv7H7vxy923x2CZlpKkGrCfDsN+EZ/PDdi1pVPz8e5cGnbJ4OlOjru0uwNx/WeGbs6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+yco74Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+yco74Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C20BC4CEF7;
	Sun, 29 Mar 2026 00:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774743643;
	bh=iBjcUas4szwLS8i0MrfSdHNF7sZCD3Sz7+3s4V9sygc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A+yco74Q7BzpZYZwjOjsFZJYWfrK5y9N9jZfy3aInEgj6+H5rMW/BPCcCvGRrTMCW
	 K2rrEb+WtOO8p0YTXH4qLb9UDvbAXwkmE2PP05OZMCUbomIPrfe7HWGm4BgbFYAXOI
	 8gwe3KKmGGCdP5kvjmmpLeDq4U5IcIOIEx8TOIcGajyOiKLNmKQNuWv1OcPmonncMb
	 C9h/MrQhMtxQOkUlfJYrpRVEl8Xhe3u2TR7gicfn8MxOoyWKjNDUPiogjJwZ9igxHU
	 teUUklngX0PipFLAxlk65ukGjl2M3OhZxY0hlqILMQKVzFQ0vR+6ej48ExII5jUQvI
	 GRv024csBYmxw==
Date: Sat, 28 Mar 2026 14:20:42 -1000
Message-ID: <cf8ef7e34ed7748699a9af01f9122bf1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 mingo@redhat.com,
 peterz@infradead.org,
 shuah@kernel.org,
 dietmar.eggemann@arm.com,
 emil@etsalapatis.com
Subject: Re: [PATCH 1/2] sched_ext: Prevent SCX_KICK_WAIT deadlock by
 serialization
In-Reply-To: <20260316100249.1651641-1-christian.loehle@arm.com>
References: <20260316100249.1651641-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

I posted an alternative fix here:

  https://lore.kernel.org/r/20260329001856.835643-1-tj@kernel.org

Instead of serializing the kicks, it defers the wait to a balance callback
which can drop the rq lock and enable IRQs, avoiding the deadlock while
preserving the concurrent kick_wait semantics.

Thanks.

--
tejun
