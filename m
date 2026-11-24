Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531594;
	b=iht2rsodTSpVnKtl2yfyw1Kme6EspOMzGFQne8F9zrmklXqq/vYgKoY7qYrNmwOpC/jP
	 Pg6DTHMsVnfcUM+mUCPJvzVfOg0XcC224iszQEetTnyI32Hn5aDv0GNiBiFlWDvWFcYsd
	 ZcvlEqZNOJC0jjxNTmQtM2VCfSCah1C/ImjExQvl2PfplFGaTMLeRVJFSA34yGm6PI2N0
	 bhzZ2S59uzYmZB58/w9EtQ5Wl3zrwA6U6XW7yga3DOAdGWwD7Tzz8UQKAdzTbnnpF8Zod
	 P8g3FH8wiNX9PAK3oPXArfl+FH2eh9kKZ27lQ1TXs+RJkPbV3A7bIiqDEmqmRIv1+1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531594;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3Lv9eGAT4sC6Ih+H1I7zqnLbKSrdGGSIjsX699t43rk=;
	b=PAH2RbBlgGuL2rXLSFFMsrU+L3yisxnqQKgX5rGvp+S9RgOygfeJ8kfkAtD13xa5miUg
	 XmygbkHJWDZhlh/XBwciTJRwEhr/XctM587TdiRBOJBrIjpjpvR5rEb9Kahg6pOKVoqqk
	 eynrqF69GJ2uJqbOlJUqGcUgM4+M0tMYyOSUW9DIzYhHI8ho0aBt+myW92teHFOwymEhS
	 4Ag5AaemGjh1yAtEeGht7HifLrvuEI+JEcxVtE9hdAY2bb5xPgX2r5ADmkvYNmmc6dVe/
	 I5wzpdlxqfs7u9SQ9XdMhS/lzwDcYQ8/Dx48mWIEUalixBcB8DP/6tEGtjCN9RWWLtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjtNl1ZJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBEB606A31E;
	Tue, 24 Nov 2026 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjtNl1ZJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5752B1F000CF;
	Tue, 24 Nov 2026 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795531593;
	bh=3Lv9eGAT4sC6Ih+H1I7zqnLbKSrdGGSIjsX699t43rk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AjtNl1ZJJ/kWR35fgzCFeqiUpEtHyfkuEy2fOtvVlpQq014Di5dffjjwrqFzC7oLw
	 PPypvHbaFyhjed6O7UnnvlttxnJr6JsafvACoySk9pft0bjZJulIvffj6KAIy239Bb
	 x0Znpb4OyRuap6G6m2CEhedVjsC4IjnTiJgaMYBa5gy6YOzNr1I8GLadnYZd/+RbGd
	 x2ZpSRUidubrrzMrtmfW4n3AdNQvNW5u8gSNOEapmOJDMlnL7mDxCJgXTQrSqUCyeO
	 IRQz5TzFPzgEnP81cgC4wFRpdH6KDqyWRT2Y1PKNPdObxsUZkVsnVIO8WXSyaMiMu6
	 glB8qBpidzDog==
Date: Tue, 24 Nov 2026 04:46:32 -1000
Message-ID: <63a74522c0ac114cc14846a3880424e3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, Ingo Molnar <mingo@redhat.com>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] sched/core: Preserve WF_RQ_SELECTED across queued wakeups
In-Reply-To: <20261123171637.3859594-2-jpiecuch@google.com>
References: <20261123171637.3859594-1-jpiecuch@google.com> <20261123171637.3859594-2-jpiecuch@google.com>
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

Hello, Peter.

On Mon, Nov 23, 2026 at 05:18:01PM +0000, Kuba Piecuch wrote:
...
> Fix case 2 by preserving WF_RQ_SELECTED across the wakelist in the same
> way WF_MIGRATED is, so that ttwu_do_activate() passes
> ENQUEUE_RQ_SELECTED to activate_task(). Case 1 is unaffected.

Like Tao's ENQUEUE_RQ_SELECTED patch, this one only affects sched_ext. Can
I take it through sched_ext too?

Thanks.

--
tejun
