Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520428;
	b=0t7gArROEFtOLmxtwOyplPjaO1PwBYbd5SFSZDAi3ROO/jAoOqYibeFJ2klDb1r7sUYb
	 kuk/dlJl2KLTZ/wB7zSZTHOPapaSsJkMHA/2mOe/z0zQWb/4MkPGJs2XqIOg7mpuit/tz
	 X4/sX2cO73C2zeQG7J0T/rc+W0A2W/ca15oXJTf5zNhISkPQ1BJ3FISHFQbY1wIGnya5Q
	 X3jHulDBBUpDJtPU+PeCJey2nZ4M74hstXI2ildRIKZ+9rwui+4h+G/iCRYkrm1q+Cu0T
	 qRIIDhw/P3ovU9+Ckjqc+9YpoR8WHDfrzfoOxXDUSsU4x6Q7FhX3nkiWCjH4UlNVctg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520428;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type;
	bh=60a0/HLjQTWhu7YxyY2UEEVoE9Eqcv8bbTKkNoYxrVU=;
	b=a+bTLIiCzkCHdRn2QsJsUlhVK87pbgcd/rZMIqBc4e/lVBJOL3VLZaG+6ZUFoYju3zTB
	 NjJfZi1SwODhzagc3pNrgBg9ZV7kxH//qd8Ba32DvgnB9/SXoNX44wKOPDamily1I+FWg
	 qd4auvodp+E11HUF06iXSJxlgUhSSlzrx4Hn6e7pT1A4Hqa6qifkBtk3sWjKdkcBUDYIm
	 EaxhIUvYNzUm8/D6cdOURO5pvWRQR8uuLfSjUr88utd16Qi47Ic0bNNBsL/9DPlJnVODx
	 PUluX1QeZhrF3BdFbpgU99Pz5k3hXYZX4/mprlgU0/JRebfOY3jbcjVU8cGI1HWcc9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LV3V5260;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800160A2604;
	Tue, 20 Oct 2026 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LV3V5260
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5EF1F000CA;
	Tue, 20 Oct 2026 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792520428;
	bh=60a0/HLjQTWhu7YxyY2UEEVoE9Eqcv8bbTKkNoYxrVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LV3V5260sE1114HjG/6nIxnUyuDEUuIIxNlqt/oi2dsY8x1elkjgcQ9q3udnuU38d
	 K2MbtZDzpch0EHOCj+k9aWKrZ+MZSqqkfKdDa8jPmWRx4Ke+wZwh1aUKam8mr4RSpx
	 bPTTb9WKWokpY2Q7CwvLISnZChHsnMwjgMgguuk6GKOcMv5Sl8Y2vcxWjSnw64pWGN
	 /yPCERNZ5vGKeEh4uLMJUwoVNZWJBGzXusg/Z3lm6yZuN02BL/9JYTgVI6YMwcC8gi
	 y9WouoVU5nBlcV6RYJxVOL9tg1DEsVkeFkgI1AhngZYdFRUuoNN1r+6z55tNzGnoDh
	 eEkIAK7t8t5PQ==
Date: Tue, 20 Oct 2026 08:20:27 -1000
Message-ID: <1a2249f7b86926dc7c617424853af24c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched_ext: Remove the foreign CPU check from the kick_sync wait
In-Reply-To: <20261020084400.845842-4-arighi@nvidia.com>
References: <20261020084400.845842-1-arighi@nvidia.com> <20261020084400.845842-4-arighi@nvidia.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Applied to sched_ext/for-7.5.

Thanks.

--
tejun
