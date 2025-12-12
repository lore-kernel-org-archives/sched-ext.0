Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934A301014
	for <sched-ext@lists.linux.dev>; Fri, 12 Dec 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563594; cv=none; b=MOBaJZ+SoWtzKd/qJETCycqCi9AW7Rut6XmewEUx2iDdKpn2bM+CHMf/qip1xzMySnWQ3jBnowBlLlwr3zqOANJ1Ua7ml0zAYgMe3IAsYKleW2fXysuLb/4v4A+2BiWv/Wc+/uUTsqIzKz4xd0f+oxJkxaVBO18FGABWUgnNgAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563594; c=relaxed/simple;
	bh=D11VZpRhmNiomMaDcpqQBghBTZIUSrMB1joo2gaaf7s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=YT/3fSATINpXS0ZXFeW7b4gi8mdKWIICShXj6vGm+ZkRrBS/VIIaXyGGzINe9JAFYOQ9vnsjiC5S15XrGjL349F95o80w6JZCs0fUGjg5ZzrENfcYtWjP1JtVCT2NvjWzaaWpm5lzCqvlIScn2eihXMt3xGGjKKmQckwbnAlJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai8oMYOV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai8oMYOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AE5C4CEF1;
	Fri, 12 Dec 2025 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765563594;
	bh=D11VZpRhmNiomMaDcpqQBghBTZIUSrMB1joo2gaaf7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ai8oMYOVInlTrvFGIRUYj+BPjB5f5Fwg8u8kNkEMB7NT2pQ0w25zEkHLF7QFdiqzM
	 +KrYsGO+G3MYFWsNOZbu18hWjAY5aqt7rDrxPSQ/iEUlCDkcdl2Tt/4b6hOQsKGCeY
	 4WLJNpq7otnslnOrQk9f1zTJ0QezMYLAQRrfiOSk7M31B0Di8eEUJ9lzCTUeTiOEal
	 3upvhR6EP4lVvJWX/eDZzjC0RnXPv6yahCuNKLbtLIQcsD/bFD37YeN99sbjUXpAuY
	 nh/ts2FTN+/d7Tej1tGkvfCDZWKIVBt/R5uKo7TjhnGOlWxv0HSRkKO3qMOVRHl89W
	 ikEniNU9i/4dQ==
Date: Fri, 12 Dec 2025 08:19:53 -1000
Message-ID: <d851dc853de1688f70eed313d835f4fe@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <etsal@meta.com>
Cc: sched-ext@lists.linux.dev, arighi@nvidia.com, changwoo@igalia.com,
 void@manifault.com, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] selftests/sched_ext: flush stdout before test to avoid
 log spam
In-Reply-To: <20251205212314.3553009-1-etsal@meta.com>
References: <20251205212314.3553009-1-etsal@meta.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19-fixes.

Thanks.

--
tejun
