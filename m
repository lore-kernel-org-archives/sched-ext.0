Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3388F3290CB
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698543; cv=none; b=n+y6XJF4FNJ0O0Bi8lUKNmWQHlaUs73/pwyr7zEYqfJNBbCr7oYv/DXd+frYghVkGPx2baBQRVDmlfd/4n6AnGMvvyNeoC6zrWNF5x8RnVVUqy0Q1ikvIEgxwf4CiLblDKMwo0MMDDWciPgNRfaYrPubfEiaV2od2UrFX6+fbdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698543; c=relaxed/simple;
	bh=A+AEZA+rfNzYXIuDDCRtRjtBfBAgBX0skS2BU+gg3T0=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=ZiH0P+QyZmcNUJJV4K/fsldIeAwhdn1sy2om8A2vjDPAF+H08viFoJ6Df0iUCF+F2WbChoDuqV5CLJqfrtqINdrefH+rveUCkYL1JkEccFgRWac/DXSM9aaFGa9NprYTijG+T5oKCW1UCbpWwt5NXjQbPaz0Ejl32KhUaaGh+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnhfpGTk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnhfpGTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1405C2BCB3;
	Thu,  9 Apr 2026 01:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775698542;
	bh=A+AEZA+rfNzYXIuDDCRtRjtBfBAgBX0skS2BU+gg3T0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jnhfpGTkzH6AZXnBQ6c5KBJHr5VepYXlARTjuZKjrZu4ywgJqC0Sg810C7tiZGRcr
	 ZAlgvQ2lbKgenJjJQAVf9po337XRayWPxxV7US0EZ/Hj5JfSNzl5eC/D160aKAJaAj
	 1X7Dgj3WMDuqqjmT8QQqo+5fVu8rBmhyJSNh4ZoXXDEjTMxwbnGjDvN0izAzNzLC4x
	 bRtiBMmvVHofRQgKzJCE02nvc53IwviVUECuStr+1CpF3jYo6PXXlm1Rdn7SmLMVD/
	 T/TCT/c+HxeiwQg/obbQnvJpaQ3N6YTHI9vB9WZTtTfncBsA5VHZsc0bLiyENzF2UV
	 d7ZLESZoIVm4g==
Date: Wed, 08 Apr 2026 15:35:41 -1000
Message-ID: <2f275663260c2178d78fbaed529ae813@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	chia7712@gmail.com,
	jserv@ccns.ncku.edu.tw,
	sched-ext@lists.linux.dev,
	void@manifault.com
In-Reply-To: <20260407235715.3770516-1-yphbchou0911@gmail.com>
References: <20260407235715.3770516-1-yphbchou0911@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] selftests/sched_ext: Improve runner error reporting for invalid arguments
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Wed, Apr 08, 2026 at 07:57:15AM +0800, Cheng-Yang Chou wrote:
> Report an error for './runner foo' (positional arg instead of -t) and
> for './runner -t foo' when the filter matches no tests. Previously both
> cases produced no error output.

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
