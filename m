Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520426;
	b=Fg5swCOh8OXM55VipCP/Nkrd6Cu1GWAL1Fo2ktyTYVaO7pTicIL3giL+4ZMV2yEL6s5K
	 QWVIw2puQICbKMFKhXXp3Q3pe43a0qIQ3XkhbmFpUJDKlG/xoS6yFu6I18RnelJu2LB3P
	 tOf5qGc76vAW9GbsepXa4uQY2wVhT9yDfpPSIBR4aCUkUkywWIY2zl3K58EpVOTmkyg/D
	 0W97lFv3QZRSL8DNvpGxI2wZmrUzUAfccFEaDNjaNYH/FLbHYEr8esW3xy/adsTlGskO6
	 V1dKyafmZG2BXHfAlphq4rzOQPngKqkYcX4LKQvpLnmPnjfM4MKIWbJvAo+bj4+oetw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520426;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type;
	bh=FRF7RPDifJkg/ZD/PDvhMwqiHBwk0rimMw1zZS0oS7A=;
	b=5DzF3hFh0eC/4TJDpogJhuHdm61yNJAcgqEw/FcbWNJWi4PascWCE0uUyyWu5VzrtGbC
	 GAvmb32z8YE9naG3lBlq8TlQagx35jO8xgDLFJgPVgbOSwwnmFx8YWswD0UJGNqgMWCk8
	 gUbXh53mFra0OenMEakw1rn2Bhn4c/EcBLoQYYpmMGsBhW4tX0yVShyt/ZU6YSJDn9azi
	 65KRc0d5mpXAJqieyJKXaaqsagn2bsUaW1QdSUvjm/c5iJYOcGUlpfMZhqcxqhH9L636f
	 OF/k29NfKLXHfhVE5g4Aiqai80bn2necmjkAxy6JH25dxRNf/ulSmMDIE8XvzvZthoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d/x4prD3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212E606A31C;
	Tue, 20 Oct 2026 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/x4prD3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36061F000CF;
	Tue, 20 Oct 2026 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792520426;
	bh=FRF7RPDifJkg/ZD/PDvhMwqiHBwk0rimMw1zZS0oS7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d/x4prD3w3vKwaIxUYZglz7tWs2JGqGLEdp1dXSKkEcCbpKz+9UB9nIhsYkt9loaX
	 JeWlGiCMjuhp4eXPci68nCxPYXxAAh4f2phkmIv1cyl/jgli6gBwgq1GM6E+cY+o5P
	 l+cfKLYsgi71PGJnbQbumLKD5B7khFOArpuR/GopTDiGczzoS721rsZMBh+0/+/Lw/
	 G9Cp7hCxC/iRCMN3vRum8lLr07NdDp0+GaJ89PIdsgPJ9qdGxttCGS3JrDrB6uflX1
	 ifH/fbrMB2STWkPG0sve7OVjbvAHcCEK9EesBE+DHUVeXMMxbpe1UqccxdMsqzcuBX
	 PMcxP+sfYE8jA==
Date: Tue, 20 Oct 2026 08:20:25 -1000
Message-ID: <61d3176fb616261d1571449114fd9f67@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/core: Avoid requeueing a singleton balance callback
In-Reply-To: <20261020084400.845842-2-arighi@nvidia.com>
References: <20261020084400.845842-1-arighi@nvidia.com> <20261020084400.845842-2-arighi@nvidia.com>
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

Hello, Andrea.

On Tue, Oct 20, 2026 at 10:43:19AM +0200, Andrea Righi wrote:
> When the callback is the only list entry, its next pointer is NULL, so
> the existing duplicate check misses it. Queueing it again links it to
> itself and causes the wait to run twice.

The last entry of a longer list has the same problem. Its next is NULL
and it isn't rq->balance_callback, so it can be queued again:

1. A is queued on an empty list. A->next is NULL.
2. B is queued. The list is B -> A.
3. A is queued again. A->next = B and the list becomes A -> B -> A.

do_balance_callbacks() then runs A twice. This doesn't affect
kick_sync_bal_cb, as nothing gets queued between the SNT_REPICK and
SNT_PICK calls.

Thanks.

--
tejun
