Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD8280331
	for <sched-ext@lists.linux.dev>; Wed, 28 Jan 2026 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769565907; cv=none; b=egqyRAvbtbQL+EVHnFElKfq0i1PuuLMYs07pi8uEMkPp2qg7Ct6kXbdmM3rTDh1B+w0VgpkvDtb9okJCIvZerGrN/DikqTvvtGC7rkkxMLLlg4ZK5EbzGNMkzZfQrMErGoHkIa/HK4ApvODK6WP+iWZUKNAxI4puHx9l80wcHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769565907; c=relaxed/simple;
	bh=oDB5Zbzv3SdJa4aWbJmK4Es/Fgfpzg5RI9b3eOW0HQ4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=nn9u3onFH9SqwCPt9GXKZNyoysVaAKEVNeajVvzjTriTqSB4ck/hmI7Ce3Yc115sX3cQBvaJ9KxQGSCiNJFQu/HfVpxy8E4ChdjvLnEh7NFQP/wFwl++rAvFtc9V2xvMEX1TcgNfTiAZxcGW4hGP7siv+x8ayK9NHlOF5aNHVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXKshO1W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXKshO1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC6CC116C6;
	Wed, 28 Jan 2026 02:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769565906;
	bh=oDB5Zbzv3SdJa4aWbJmK4Es/Fgfpzg5RI9b3eOW0HQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UXKshO1WMLHKN7XrXYRo0TIZ6iYCo6kEoSkymjKbR0+8bBRfQI7uTLfFD9uzy3nRq
	 7Jy0M72+US+4KLlS0Hay2rrC1eFCtTp3gjeT0QLKb/qA6gb3aSpbDS8ANzC6QbEE8b
	 KRGtGrZ8hpD2Jcz9xeshHXFT49Elq/tfJzWhyVCLXKLuky3E9UI+l/dZxe301WLyAN
	 rvNFj1vsk0L3SswLNBYeZZrH5p917m7gb9/iBMIVgLaH12ePcMVTQObm/NPiBEOW8v
	 EjnyZD9CmtHrNXL0y9efdjah2xUiyd8hcEKU+WRRKI6BLePz1eywrHY2Yv7aIMlghK
	 SbhNDucMg0sXA==
Date: Tue, 27 Jan 2026 16:05:05 -1000
Message-ID: <2c2085f356fbefe5d3bd8004e1f7dafe@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: sched-ext@lists.linux.dev, changwoo@igalia.com,
 arighi@nvidia.com, void@manifault.com
Subject: Re: [PATCH v3 0/3] tools/sched_ext: Add example C schedulers
In-Reply-To: <20260123032605.49140-1-emil@etsalapatis.com>
References: <20260123032605.49140-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Emil Tsalapatis (3):
>   tools/sched_ext: add scx_userland scheduler
>   tools/sched_ext: add scx_pair scheduler
>   tools/sched_ext: add arena based scheduler

Applied 1-3 to sched_ext/for-6.20.

Note that there's a bug in 3/3 which I noted in a separate reply. Please
send a fix.

Thanks.
--
tejun
