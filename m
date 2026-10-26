Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050293;
	b=ZJh/eMruPqek4mNfXmkLdVQaEePdzsBshxzYw9v+nSMTAcq0+6cfY0PnmHdetCcRH6IX
	 fTjkKYodfjBBLQIx/FI9LmysOochlfR2tAeskd7Swt6IhZ+g4J1ySKtXpW2pHP6MzlvNc
	 KQdw/YzBGbGkqACjZ37QtI+w+KS5/ljV+3lPtyXAGBKDno9dzTKXGIqv3WXJD3xHN6HBS
	 iUjDlBsdyWsjjmWlUocwDYyxfpLIz5mWun3uReo8vtlNFb0+bhYIgbXL1/JYoD+8Xu2YO
	 jpz2NmQiJlwcX0Hf1hjWWma/YobcPStpTmz+amVkMgu2JWWY6Pr0ybXYfOqgVJFYFdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050293;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=QAZO2U2buipAMosUpk2DpMngQda1cdEFmOeI66sHe/8=;
	b=jexEwGYz7NSc6MhPHInPGbpA/bqQ+fpbGZu39RiTBpmcDt6iFmOCCXQCPJsoN4b2Qi9G
	 17Zh2mskb8ppEcbxQNJRYXyiQBYjfOh/bLxEWf3+8MEsPlc96vO8F16IO1C6U7oRUsHGH
	 TIRXweq26C5wKB7qrIxgvnzIVp9LTAU6qb+gfna6tkbWYSwwjoJVj/4VICQerNGHFf4cG
	 q3NkT1jAaiLuaUP9yJgEzZja5ex5TK2aGsy8kB/dV4IWlhPZWqbPmlz/YimIr8aU9yAbn
	 JFcPa0bUNtDGaUBFBWJPB0XWLBtv7E+S4P5yFkrdr8kLWQ3WYY4GyTmdavjPP04ZD7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g5Fb/id+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5759606A31B;
	Mon, 26 Oct 2026 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5Fb/id+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A688D1F01829;
	Mon, 26 Oct 2026 21:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793050291;
	bh=QAZO2U2buipAMosUpk2DpMngQda1cdEFmOeI66sHe/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g5Fb/id+HU0nH+0M2wGL0MABjto8KT5EeR2teSmJu2jAh4IOIQEJBJq14brkNiWRv
	 Nt3j0oB5zIDjiXuzLeyWHXz/Sl1D0iumutCkgZGbjzjNo3QJY4c6WRT5IDrbKZCaZb
	 FHLPIGPMIeDWAHqMJ6RQsFHE+aRNm8VBW6EfJh2BNwk5AYI9qr9wqcg5BUquXnB2XR
	 on5K0KLcXATXPuKj+6PobUrUard1zxK7Sb5x5cDeuZ/TdSHDYWVvpgfyM5iBDjJvjb
	 6mGhKQUZczft9yVgJgUuysG9WkZgl+R9h+Fpjaeg7hXHAMwyjfVzCPCrgwjl6Wsu3s
	 jGUClLjyNNWEw==
Date: Mon, 26 Oct 2026 11:31:30 -1000
Message-ID: <f8a9aa002627467080c0a3f15c54a28f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] sched_ext: Fix queued bypassed tasks stalling when the host loses SCX_CAP_BASE
In-Reply-To: <at4kd-78BbpBX-_4@gpd4>
References: <20261023175608.4120910-1-tj@kernel.org>
	<20261023175608.4120910-18-tj@kernel.org>
	<at4kd-78BbpBX-_4@gpd4>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello, Andrea.

On Sun, Oct 25, 2026 at 04:47:03PM +0100, Andrea Righi wrote:
> Not a blocker, but I was wondering if we should preserve the old head or
> ordinary balancing when the donor still holds BASE?
>
> If a selected donee refuses a task homed on the donor, this can put it
> at the tail of the same DSQ. A proxy-migrated blocked donor is refused
> by remote CPUs, so repeated balancing passes could keep pushing it back.

Yeah, the reenqueue at home pushes such a task to the back of its own DSQ
on every pass. Rather than restoring the head put-back, v4 has the walk
skip the task from the start. A balancing donor tests whether the task
can move to the picked donee and leaves it where it is if it can't, as it
already does for a task with no donee. The test is factored into
bypass_lb_can_move(), shared with bypass_lb_move(). A drain still sends
the task home.

If something changes while the move is in flight, the task is still
reenqueued at home and appended to the tail. That's rare enough and not
systemic, so it isn't a problem.

Thanks.

--
tejun
