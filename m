Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795814270;
	b=PLTCgtPuFomnIViti0ItY6948B+oE2vEJSeH8Mn5YqX64uG8e7vN/+TZF/OTo6SIwyRJ
	 yFf0f6PfWQ1DiqI+Wr7+TYQYB5gWjtRLbRFWHdpbpDwC+G2w1REWnistkFSzA+Yv8DpcJ
	 kn82cvCFckE7aMIRwH1H7yPZIsDrcWawvvhKI6MrvFaHn9DtstImZCB13VY3T9hi0ae2Y
	 ZO4A/R1LYZhf9RlydTHnsMzDKaavNRLURR0yljwamPDQ+6d/gK1LZQc0EyQaZ60j5ZGmN
	 b1u+cpXZQ+dM9PVwnsvmJejGTNI3CwrxE653UoF+4wW5eQJPOzejXI/HtTZR/p/UnlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795814270;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rorQilyNNY+SEgTQ0X7b5jv6kJLvy6ZObjLWebOaxzI=;
	b=btaFYAZ0UP/Ft/0vQ3N3REtrdVLItT9gG48ms7evSqfKGatZDaFeSoApFNtHxhz1qK25
	 K2wJxfNWrIp3/ZvmP8CX10h2RRMcOVapYpykDry1e8lvum8pKX+70qMtZ7NEMB9hPsHVW
	 8bSSDMWHD0uNzPTalE+UXHfeUXkh+VCQ+nXFllMhTvTunpD7aGsD6zF6NUPLwFNZwmdbM
	 bEU93PF1NlsMsRz9tu6uzLMWbTowHCiLxLZ3wOupghOosi8UKPK1GBSYA3yu3HUJlh9eU
	 /DnXLo6mplh2QA4BjS5iZoHfuxz9YV23EprH0R23xlmgCo0nLGUMgtCXTxz/C8yniTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=io1xOm2w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E104E606A31C;
	Fri, 27 Nov 2026 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=io1xOm2w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABD91F00893;
	Fri, 27 Nov 2026 21:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795814269;
	bh=rorQilyNNY+SEgTQ0X7b5jv6kJLvy6ZObjLWebOaxzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=io1xOm2w2dgp76TCzlPjiV4ENq+foiuRtkOJcYUD6/u1rJFuS2s19yMAG1io830aO
	 E5XXTCMNTIC1EVP++dOKKJMH2JN9RzFSDlNRmXhefwEJ/ISh3/JQHjJU7A2oT7qkzm
	 Qp+BwK4fb6Iy1FuwU7arqICSMm9yMzyGjiQ8HSDfNoPFNld1T2RhRBg3xkA6JLw5GB
	 eFLXD2R1s6q8Y9XRTgwLAy56QOFugpv3C71ZpmKxxPhuOhXsCfwzYhUEsxOHHrH8ut
	 dQno72+4bJuG1WcKmHUvHl7d50a0w1bUriZnZW+ZeaoCjBXbdHJQ6iXoWQnfNpkBMb
	 nbrKs+v1rfRDQ==
Date: Fri, 27 Nov 2026 11:17:48 -1000
Message-ID: <d9173a4ad2d24937ae5310a3066c19f7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.4-fixes] sched_ext: Enforce SCX_CAP_BASE in core-sched task selection
In-Reply-To: <20261126213212.3930589-1-jpiecuch@google.com>
References: <20261126213212.3930589-1-jpiecuch@google.com>
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

> Kuba Piecuch (2):
>   sched_ext: Enforce SCX_CAP_BASE in core-sched task selection
>   selftests/sched_ext: Add sub_core_caps test for core-sched
>     SCX_CAP_BASE

Applied 1-2 to sched_ext/for-7.4-fixes.

Thanks.

--
tejun
