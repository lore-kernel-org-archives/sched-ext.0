Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D22175A99;
	Mon,  3 Aug 2026 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776486; cv=none; b=Uz/vJn4AdWE2aobeu4OpwRagTjNfZD3Fskt78dtHMNVkFN4FFarQEha+xVZl0K+8uonKXGIKdOrFheAYILvX9FvqUfB+lBTmP6grNaE32+hBRqlZgBhC4EjW2dG8KQvC94ia2euHXntEHGWF87Jb1LU0YMPkY9HSoA5z1b/dns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776486; c=relaxed/simple;
	bh=mWA5q61Nq8aU5SXvCtU4cO/ljydw9x+ha9QPuZ68uvE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Eo9VrlqYYX1Jp9oEQ5o6FLMz4DbY9OfWy4g8g6od6oXe/ovsFfpj8KweqiiHpNWScqezObiDDS8Wx08951LaAh0HNWX+Hcxfpm+F5rrp0eGEw9QQCotZzlkt0SJjoloacE0WSCbcd5DHS3XLm/ZjwQfR8FE0RHsxAY/PWCD4OTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFuJlriv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFuJlriv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E34A1F000E9;
	Mon,  3 Aug 2026 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785776485;
	bh=bNeITFwfh14AVDcTQDe33mAACM+20aipdaRJfv4v2qU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VFuJlrivZCSAF8sRyFCLbAkGBTU6hfABgd3zuc3pG3mwiF5s720BA4ec7tyYaaVso
	 9gVeAn7+Yzd+6lu8ehN3GKrn9YZluiQfs2cr3naSXlyYow15mymvVeNkylON5mgG0W
	 /WjsVU2egEb/0lgYoZnf6r682nfQqZ0+7NTTbnTM600lRDDGw+qJfiRgpRn17bnfI8
	 F/O6IDb6jasVRooMFu6TbTXzQFmc7rj78956XNpD7tsMEi208cEiLL2JEql+aZPBbr
	 3+x+xDiIyi0UYvai5Jl2xXDDEpj607ty5NxtQgVtl72PoErBZjMtQ8kXjGuXNUx7aO
	 8T152GnLj1QdA==
Date: Mon, 03 Aug 2026 07:01:24 -1000
Message-ID: <a0cb485c0ab8a55f384c79922b46ca3b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 Kuba Piecuch <jpiecuch@google.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v4 sched_ext/for-7.3] sched_ext: Fix idle CPU state
 initialization and validation
In-Reply-To: <20260803060930.4111746-1-arighi@nvidia.com>
References: <20260803060930.4111746-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Andrea Righi (2):
>       sched_ext: Initialize idle masks as busy
>       selftests/sched_ext: Make allowed_cpus idle validation race-free

Applied 1-2 to sched_ext/for-7.3 with Kuba's Reviewed-by added.

Thanks.

--
tejun
