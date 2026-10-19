Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792450684;
	b=U3qb6xbooblp8g8SCJtULiQ8BIj2dgE2OZINOPPnc73qCTqhxdjESh04H4fm6F4iP2qV
	 DyvNsnFJdLafEJPlJORBdW7eSJZDDYj1nX2Fp8LLAcooyc/2WKEUB2ShZjcH0DCjpyeug
	 oAv1zzzgxN0NDsCkEyy2NU9ZXzKDj49YelWH/+4U+TwG6Q6jMZaIl3LXa8/2MEIkZq7ya
	 X+sY4ZBf3hW8wxLU/6gHTzzV2t3d2sePuiVZKJLlcOjD+mcunAcj3cLTZJWGQ8PDntngg
	 uXaeedSRjOtwsZlH/mSNpfWFirqS1gHD07xhyTzjQGCu+tKEAC2VZgW/qkeJaKaragQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792450684;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rhapnzAYrhWyTbzfTftSFyCbKvu3PgENmUDk+iIn0Qs=;
	b=3bqiUiSf8UOKSAb7oK8RvpPpNMf7om+U7WKAC7gXSxnetYhWi7/VeG7DDdaKvcJtXGYk
	 00Zy7jmKMvpiKPs0JJxKlwIIH08ZF9mhyfTrBE+Duzf0yA28jj+KWwCUrHJyX6y+iKalG
	 vsbI2xOyFPljVbDGVmzX7clfp6WpxhDnkAiZKBFGshRYteAZzYmD4sYgEZfYaF74iAVKv
	 G5j16AI50T/pESquA+qfQXLRbqQjdb1pIhmQhrDgiqkYZxwYF6iAXwue2ElisgVBv57NO
	 NERczNJDu9G27aKJ8U2E2r+jVKHYN1GiJBRviQKIG1C+yOik7xatqvQaEuEUbXWlpEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BA8CVgUL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F8606A319;
	Mon, 19 Oct 2026 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BA8CVgUL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401C21F000C4;
	Mon, 19 Oct 2026 22:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792450683;
	bh=rhapnzAYrhWyTbzfTftSFyCbKvu3PgENmUDk+iIn0Qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BA8CVgULnQUUobSbJQdFrI9oLCtvhPgKY4pSYLBBFry/d32AL4rTpDRDgTVAtnMuV
	 PFMnhTzuHrSEasCByx18i6yrcBbu1qDe9u1jL7RTrxHO0D94FTDtmSLVf/RsLWMtz3
	 R0g8jUpCbpafpsNkOOIRqMfzMBv6GFN1OhMbzuH2lb1OiqD/zQHemziVTJHjrW90cv
	 /hXwOu6jirHYPputNSomq/60bK9GXGF5tn9ta1uQmFtnx45MaBZiUgeoldRXk2v+8G
	 UIUfC9lHg7ITXQBWt9+g5MuFQh2cC+i3MSLAYOxtXp9Hfepnw9KO4pk7i92V98CV4f
	 qQqqLEEY7F0jQ==
Date: Mon, 19 Oct 2026 12:58:02 -1000
Message-ID: <6e866687d1c01a62e1f277b4f2bbcb41@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Michal Blaszczyk <michalblk@google.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Kuba Piecuch <jpiecuch@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Reset runnable_at when a task leaves its scheduler
In-Reply-To: <20261019124146.3582127-2-michalblk@google.com>
References: <20261019124146.3582127-1-michalblk@google.com> <20261019124146.3582127-2-michalblk@google.com>
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

Applied to sched_ext/for-7.4-fixes with the following tags added:

    Cc: stable@vger.kernel.org # v6.12+
    Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
