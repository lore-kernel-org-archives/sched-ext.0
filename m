Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529936;
	b=G/9BPY5JosrGBeJwCm11mGuelMV4w82xkIb8835mfSXTBeFnGJFRkAKzK6FkfoqEmUZj
	 xkxct6tAW23Y97JrTZ3AGg5P5FFrI5oRX4TMyeFDmHNykF4jlnreMuqCUvmK/jq5BFOzS
	 2x9PWcfE11FtM767w7RlL6RxTM/MQ6YQU2QKsSd1EzVdpz77ithuvYIvu0QD/BzL76KJ6
	 MZosC9BBDDqh0eQw6IeHIUB9I6NhkgHfsKdYqoZU2gTrrdh1WQxJX2JBYpfv+ppQryvu4
	 L2MNogFBACGT936JjEDviYRniNGcqoZFsyrVSi1DMcIpap4zrYtWbPmNekrP7AaloMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529936;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kzCCSxGqIOflYF/5kOzEFXx9NL4cCf/soNclBud8pGk=;
	b=AYwDXbjTd+NSWtfuX0MsWG1ngIyu8mjFimKtaOBJnlsVLTSHzK+mUzHOwzkWeuq4oQt8
	 KLuVvuWVnrZ61V8+8gEx/tLfYTiPVSdcuGAKGI/b9aU8Ep31eD2Cq+JDR4JrmEfBCFbrR
	 HKRno5fTvKA/9B66URxgkcx8UKUR7kJmlDcJUQso0imqEcpl4J7v7cglPj2V/Kw9RwZKd
	 ixxbVFWkuHzFRVqwX4IdAv0WiHcajUj748KLKsPSoDvUGpNmBxg8bvHNj2DiX0XIpbEnA
	 oUyam8PTKHY3aPgZQW9vsyTeF8C4pNdfRnhihK3yW033FZkj6zL87LqCElg27wujnwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX96GzWU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD2606A31E;
	Tue, 24 Nov 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX96GzWU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE711F000E0;
	Tue, 24 Nov 2026 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529935;
	bh=kzCCSxGqIOflYF/5kOzEFXx9NL4cCf/soNclBud8pGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KX96GzWUWzvDzFPHESVhAmTt4OEHEHBLnXDxsj2Fid9385pGQnxB7vFgSeAlf+3r2
	 wrHXxhqq/skUDITPtxXz8yjfZz70rCTWilj2kPN5OIANyu3owpbFT5P6AHnIvknBzQ
	 3WoMMjOaWMZojjL4F+aVfEIHmtPO2wUHofOrAHeJ1H0MO4uC2HU3aAAftzCT5vlje5
	 s7UdyDZjYKEmFO+/P5ZbsyW4qU7uRX/b0ThEjAJTWQk6pqrayWzPlEwfrtLU+cTLA2
	 77KC/xEYZ7wr0HJRVSGF35lChFbQLxdfFtz8cbgs3L36QIJevAuFO76EyPzwav0tmz
	 LpTross9hChdA==
Date: Tue, 24 Nov 2026 04:18:54 -1000
Message-ID: <6a0ed81b224fe5e2f09fb1415b3c4b07@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Ryan Newton <newton@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.4-fixes] sched_ext: Fix suspicious RCU usage in KF_RCU_PROTECTED kfuncs
In-Reply-To: <20261124103043.339553-1-jpiecuch@google.com>
References: <20261124103043.339553-1-jpiecuch@google.com>
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

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
