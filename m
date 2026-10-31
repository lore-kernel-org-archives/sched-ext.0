Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466753;
	b=Xl1sPB1kZ9kEcdtBZKDNZMg6h8mk/2/8RqNlS24Htrh16htwQ1oKvsJQFMYcgqebZoXZ
	 fjCiJG/iEoSHfkqhR06DhieDT7jdymuqbrRHUWcFKJzHgMlsvDUJy6k9PBJMDN6VqnToL
	 JyI65F9xbb69uwD19LPdsnIBu0bsL1zA+IdfknSlEM1qHthnEqVHv7B6zja5MJDtJ2E/3
	 /0WqD2p0AYnzedYI271PmkMNSOb4TSxCs5dq91pOO3CnqUE5U/esdPAJmg6qM1FrYL/Th
	 xSCX8aaOag9abmIFCDjaF1Ap98eQ79Wq4SWBr3732i4wWgzDqe4JTtxr8OJqQbPjD5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466753;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5QoTciqchHc1DZnh2HnM6bO2wRR5rC9uSeYDGjDzUo0=;
	b=21WK4mXyv4rzxCqaUcHYbTr3LHsffvgThkMeDG/7KMDZKN1yChyO16bXJVFdDefxHTaX
	 ZSBoHfhI1FjQeRbKoCWLPm2OhBmadAtmrX+KxE+dCOQlbZNvd3+zYb5Q4tcc5rHjrG/AS
	 Wv3qvKhFVrD4ajeOdARaMWLXAJGlNgdW2/pNNrvu6/hmvnJRhNLosA0rKEJJ14P4iMVFq
	 FBxw8k1Nup5Zdwt5VOmsSWefthtWfQjykQwn1Zuczb85J5ak5f7qBwESWCd8NVZ9m4Odr
	 wYSkzqykVckrFujHlRqVsXnk7iSoAeBoT7frYS+UQQq+pGDiZgQJNysPExBnGxSHxsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dtjf1Ss0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7CD606A31A;
	Sat, 31 Oct 2026 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dtjf1Ss0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E157D1F000C1;
	Sat, 31 Oct 2026 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466753;
	bh=5QoTciqchHc1DZnh2HnM6bO2wRR5rC9uSeYDGjDzUo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dtjf1Ss0KXyiDdRmRV9NpJdZAX6yPCjj3/oLLoGbBonSOEAYntnglTnZiu49xb0Iz
	 mOCgXL4BmZZnI4basCcHB7bSB9eT3W/dgz+pfTLyVxEYRCXfdyuJ0LParRRjQ6zgTg
	 7CR2SsL9rRR7YJRbmxB7cCG5PaJdecAueI2V1J8Bk6wGKfWTRzU107MOlcdxmvgZC0
	 Wngm0BC7M3MRZ9UxfHDKNXzpu99xi/SDtSKYfGw8UOaltXjwK0jI61sVL85oNlA9si
	 gjAbn8iKV4RTcD28UAqyCdgrQCYJo0PZ8mXqUW3y7ohv4cVPsn3KXxsSVmHOLXOasG
	 P17xuFptDPhEA==
Date: Sat, 31 Oct 2026 07:12:32 -1000
Message-ID: <3a0b7df208af30eb77c18104c6df156a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, sched-ext@lists.linux.dev, Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH v4 sched_ext/for-7.4-fixes] sched_ext: Fix stale pick when the donor changes during dispatch
In-Reply-To: <sashiko-outbox-192051@kernel.org>
References: <20261031162803.541236-1-tj@kernel.org> <sashiko-outbox-192051@kernel.org>
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
Content-Transfer-Encoding: 7bit

Hello,

On Sat, Oct 31, 2026 at 04:55:55PM +0000, sashiko-bot@kernel.org wrote:
> - [Medium] sched_ext: dispatch_one() emits ops.cpu_acquire() before checking stale prev

ops.cpu_acquire() is deprecated, so this doesn't matter.

Thanks.

--
tejun
