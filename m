Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128266;
	b=BQFyZqvH6+wnFTZ8XHT8W8SVGw2JOq8uayPrA7o204n3wv3gc65kp/kPudUcVacoTk0w
	 pLaIEj71W6GTfuTa0zzHGN6yaQb3KjDwYcOn6p9CCNGWCPnTrp7yQ8O+YG7bpbAagWQ3/
	 Tpxh1vL/Jzi1ksw188C+uNw6Bri5Gjav12lpksDCURmptfssZ+B9IjAKFXGwVUOcenAl+
	 tSDnfOdD75OgsRVekwuSxIB8xUY29c2Wwi0axB4FrdheqtRf2F1kZFluifii34rexymuU
	 /OrFV29vXJNuBJIt8Lkin8k2JQMg1MDK1d9erOm3NOpldqFFcrObHA2+LbmNo4JrhSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128266;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	b=BYVKP6fFlj8z4ztU4DHYt99kgBGL/3xgz8rRoy9w/W5gmtL6YQYJdP8XGRuo46SquF08
	 59TQhLsRSm2JlKv1CrzmDBecXXzMo6mO+H9BJPXeHvgpq42+JJ9/ITcdwfZwBQHsBvNIY
	 Fs7wnaSY9Cxc+R39Ut624Mjj+800rZ3fXnTSIFXPV0xWFRKiOzmVsn842qEYEkqEyRndJ
	 i0RYrSXk481hwTqke/k3c/iEBxUmy8V67Dz/Fl8qiMBBcYCV0FnJuSsoTkyWA0QBLGey4
	 43/7wThnbLBlXouboyP3ljfd/l79E2wUP8OniK5pQVUC5zntbp7TPvu5v9QguOxGy1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QB6JRvIO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E4606A335;
	Tue, 27 Oct 2026 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QB6JRvIO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED471F031E0;
	Tue, 27 Oct 2026 19:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128265;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QB6JRvIOMgvNL00jgkWxwss1h4mMzm2IqsW4BD66CZZbFFgNELS3rjqRxouP7RRH8
	 ZS7uisK61J2xG5jGrlvJdnVpk8Xb9/5Y1U1wpq6yHneFvziOXocM2Gixne+nETKne8
	 kPNmNQXMWC7/hu3L/AunWWD1cVUhsy42ea7pBj86njYQik9PoM5SwpA2RC3pCQgzgJ
	 yvnXBI+D2c5dzN31cTDx8Z9AsufxRdZaBekwiFZENMJGZDD7egHB8ttdfFjLOsTI/0
	 IsdlwvbB5kaIWTfvD3jCq06gnqgQJiUaBZreos1HEAtSlsoLHft5UO7XNi/diXDjOB
	 C2WaKnwp+5Yhg==
Date: Tue, 27 Oct 2026 09:11:04 -1000
Message-ID: <1cebd7f7531f3cf4f69cc7edfd707712@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>, Junbin Zhang <sprooc69@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Reject scx_bpf_sub_grant/revoke() in tracing programs
In-Reply-To: <20261027183325.2479784-1-tj@kernel.org>
References: <20261027183325.2479784-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Applied to sched_ext/for-7.4-fixes.

Thanks.

--
tejun
