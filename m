Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D81F0E25
	for <sched-ext@lists.linux.dev>; Mon,  1 Jun 2026 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335015; cv=none; b=UMpTjLk3GCnaQXXnMPyFK4cZh/Sq89Dr3rd9QMeB1Kf37GiPxQDBasUAiiJZBqHCXFNK1x92EGBISw0GjACkSRKrnnklyIyQ2yK4kLT+mVejScvBQfaa8SM4cXFGW3be1yBobJ9geqvgI+k1ZiZ+bNyR2FkUOvoxlJMBvAmwzt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335015; c=relaxed/simple;
	bh=ZnT0eHWt6hkh+ajYJs3ANnmiBDNPLkb353ySdGePJDQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=XBH2R9sMrNXVyHBEyhRRPUl6rvJ4/ORgO1Nu/IwbS4PGHzq8oiFz+2dtfRNxyB76QAT4SAi3XJkAY3cSa+EuvHkPxFzntEcAdYFTlGCZFLCTrF+GDCdUMHY4CiQysf8l3mJ7mu0Nz1AM7opOXXf7t+BtC4BhqmS+OsVhcFUzNf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKrJnAu4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKrJnAu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F7D1F00893;
	Mon,  1 Jun 2026 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335014;
	bh=ZnT0eHWt6hkh+ajYJs3ANnmiBDNPLkb353ySdGePJDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SKrJnAu4+45VCSLw5+18fDOcVOng/1R6EVvLtuWq3g8q+Dzkjbl5NGYK0DWQEy5tH
	 CZOk6DzBgcjOhPbkUUiqLWN1foPrMuW/IumQDrcQKKN0sNcCkvO8oXvxLV+JA2Tcl8
	 u7Rxrpe6EwWt1I4P33Vs4yNtXCGpLbXqy62HYFFbPmV/C5Bw83jrykAXtXTmuZWVtd
	 SeoBWtTshLIBw5jwCRD1d4tXxbT87Ou8XmTpLtM4F4C+2tJOMnw6ll3O684dkqBI+3
	 iRtFbFX6/4oXYGDzmPCo6Fx7a8D++TcqBLmZae3ecj82Gnod5QgKtx3ixtaFtvcp38
	 QCOxStvl1nz4Q==
Date: Mon, 01 Jun 2026 07:30:13 -1000
Message-ID: <ba2a2f1e418ef56641c60d2c22950de6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.2] selftests/sched_ext: Fix dsq_move_to_local check
In-Reply-To: <20260601155426.1460441-1-yphbchou0911@gmail.com>
References: <20260601155426.1460441-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Mon, Jun 01, 2026 at 11:53:48PM +0800, Cheng-Yang Chou wrote:
> scan_dsq_pool() checked == 0 against scx_bpf_dsq_move_to_local(),
> which returns true on success. This inverted success and failure,
> causing peek_dsq_dispatch() to double-dispatch on success and skip
> the real_dsq fallback on failure.

Applied to sched_ext/for-7.2.

Thanks.

--
tejun
