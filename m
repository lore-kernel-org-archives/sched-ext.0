Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792713813;
	b=gNOjIe4H5NzSlso49Q/mSWFG4NeXUvl5zv7YgWU4ns5ox0X6uGAHJwd14iiFDVPiEuKO
	 53x48MRQcQpmPSBU9KbzxMV85YPc0Mlyb8NnMo4XBz3QPaDrs791gQZADIoN/JyVAOetU
	 PDTITA75prCWataxjkgqd6T+qWQ+3c+VrM5uAtjbGwk+V41+sfhSgUVz3yNJtM8VDGskm
	 1HsnVD/Tdr5c3WJSD8Tzi2ZOVbrZw4YJC4RC0qUX8VI1B5MzeIjTk0det+HULWnzgBHd4
	 CihmLhk//Bc7YtLIXOnQPVg5V+/oc0yFNE6Bfk2O39r2bcXxxueGPrBnxFbgGmRfCWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792713813;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=O6v8TOT8Zv3cJuIGyi4e4QKoLabmEVlogYEBr09n+zM=;
	b=YuXjN/Cs0YlxiSiXKmoqGzL1lr5JZzIdV8K56SszMaZ58tQLLwb83cuRHHssYD3YLyqL
	 yjDZLc61+bcIn3yecIB434FZ+zcZ4n0/2J+GuHskcSJ8x0uOVUwU9lu1O2AmIqQWc8Adz
	 AU/P20T1C/6c/ZiTX1VqkHG1nt5NxLHd1iq5UvLeBk3FlzccOLA7TN/2wCpaCk1y8BrD5
	 614ClZtS0B2Tgmtjvb7Jc1hkCECyy9n43NIhtCGiFJWsQwEAWEteEQQvB3hoRx7Tz5aJk
	 MBGqw4ugcGPC/YIhusHkaXRdzWub0wBMQOXZFQ8ogpxvlf+tVq7poOpS+b5YTia0vSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEdYuCi+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75570606A319;
	Fri, 23 Oct 2026 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEdYuCi+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C4D1F01828;
	Fri, 23 Oct 2026 00:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792713813;
	bh=O6v8TOT8Zv3cJuIGyi4e4QKoLabmEVlogYEBr09n+zM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZEdYuCi+Ntt0aZix4twMZzayrBid1ob+NTP5O0Y91hDAP50GyZCzfoWNzOJ+t6WDz
	 Ny1Z/1Te3j64+jNjxVBKV15AOHDLMLxNO1B6xPQAr0Fea5oxSYTxqKm9ywXhXtmOz2
	 knx2JPjBiKXNnz0u4BG74HxoQDDP21TLgeEm84LxAKvLhhX4J8UEc9PR8B5uhV9a2s
	 P0guBQzNF/WLVrB4+1f5rMv+9Nn2IBnKjXWIwtVq2r7QxtKoyjNaYz7Ja/5b8pAje7
	 89qMKgieRkM2q3bg7KMpr0kCvWBDtfRm6/08O7RGVcdCZZwj+wtGAX0SYrOuChuGSz
	 V+SWEsrgSQOOg==
Date: Thu, 22 Oct 2026 14:03:32 -1000
Message-ID: <f80c1546b3d2831782241fb613e5c3ec@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 06/14] sched_ext: Fix a cpu idling with a runnable rescuee
In-Reply-To: <sashiko-outbox-182079@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org> <20261022213836.2259069-7-tj@kernel.org> <sashiko-outbox-182079@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello,

On Thu, Oct 22, 2026 at 09:56:08PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Should the scx_rescue_keep() check in kernel/sched/ext/ext.c:dispatch_one()
> run before the SCX_EV_DISPATCH_KEEP_LAST check above it?

No. A rescuee which passes the keep-last test is on a CPU where its
scheduler holds SCX_CAP_BASE. Either the insert it was rescued for
lacked ENQ or PREEMPT, or BASE came back during the rescue. It can stay
on that CPU like any other task of its scheduler, so ending the rescue
and refilling a default slice is fine. The comment saying that the keep
above declined prev is wrong for this case and the next version fixes
both the comment and the description.

Thanks.

--
tejun
