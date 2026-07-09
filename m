Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D103D75BC;
	Thu,  9 Jul 2026 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635185; cv=none; b=GhKlp8jcNAOb5tdmraJ/hH5R5m+HSZFSiwrBK5cHqUUXxbndkTokO4whk8brezS5wMQBSVxj0rkBdiZ05gA8w1EfWNzCUP97XCG8G14dWv5z1CFwsjcsTQ6Z4WAUbQcBIhXm1KmUl8eK4ez9toW6TEb3+9zfDSyiug2ZlD9WtbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635185; c=relaxed/simple;
	bh=88RPW6hFj1iDYYcc08ZhQFyvbmegRtVxiHYAeqqk5+c=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=nGBtKJSaibbGREaj1PXsv0gWFrUmI8JxWfUVG3SCsryF+26OZPMnXFs49KkzDGIk1Ec4sxUJOI+HE4wc9UBNeZEW9bBM6k6eysBNZ/0HZ5kZ84qBdbLs0PSX4JLlyeb8QSyjMurW2HejNbbBJOw+rn+1ea1ZL+ve4SFy/YRwYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIpSCeAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIpSCeAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E6F1F000E9;
	Thu,  9 Jul 2026 22:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783635184;
	bh=88RPW6hFj1iDYYcc08ZhQFyvbmegRtVxiHYAeqqk5+c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=HIpSCeAlP/XyrKpXDUnyY3Ubrt4a760rARoq9/LviApyBwo44trkXdCPv3+VoK0Ux
	 jLjIuKkSiE1DnFHznRClMERniNdE5f1PhKNXQuHS0FMOeRh4fIqSq+5KFTMBMVYo63
	 pjtwZmawIgiaMCJWXLC7ACHGS/QEQyVJ1rwI2NoVgOugo8sYpZMEDy9i1zM1memOp+
	 J8c2R3Sd8eD7Q63PFmbNkNfpPppCmQ6H6WbAN8UxxM01PiYdoh9e7xGOP1TkVQLwDB
	 eDtx3YiINkLvcTyokqhPaatevgYjnCESQudzQqVHI5LeBZKd7cBPomdSSNLQ9FydXc
	 chRivxh6IxlZg==
Date: Thu, 09 Jul 2026 12:13:03 -1000
Message-ID: <44ac99342c0ec0389c39155a022c41b0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
Subject: Re: [PATCHSET v4 sched_ext/for-7.3] sched_ext: Capability-based CPU delegation for sub-schedulers
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied 4-9 to sched_ext/for-7.3. These will also drop out of the next
posting of this series.

Thanks.

--
tejun
