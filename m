Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9812D8DC8;
	Tue, 28 Oct 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687999; cv=none; b=TUyn4w/9wXmDj9fPOl730ebhIrhpJiu50SIss+BOwpXoPfb2RsHijUGZz23zKaEbSzt0He2ii5kSS9jkmEn/NtnsRsljZj1a3YDc9Ue9n5mPbwDjbQc49l5VDc+qKrPICYGu7zXR5Ad5ww4vLROB1tRF1R7StLiuRXlJ372F8mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687999; c=relaxed/simple;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=gPjB4jG8jubiA6hLAN1iRlS6rR/c8N3we/LZjK4J9aUAejALbY774Q8faX/5GO9KAkAX5EiWdm7ys5aGtaCcfF5jMY6+PFrbe6xVr8aI/6Bm1Ak+KVEDPtEeGRTXw0avDA2+Q0f7rC6JCJBZ11cRaSpG/Mg/u9iBIomqxFbgAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rugj0stH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rugj0stH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319B9C4CEFF;
	Tue, 28 Oct 2025 21:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761687999;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rugj0stHDGAZfFTgDOzPqjRVS0o19zSVqH7cWV5rUxT6I1PsOha+C+8ZjT8mHcYt9
	 MfozYdvFdBYRSoQv6Nw9OnyBI2iE42ESBoEby6dsrzFdyt0kvrPcZaEtRuE9GYa2As
	 vy22Be7tyfQTmgA2/CRj3x32zdLke+LddFO6lhRaY0b4p5iloxanIKeas+QkSR/MXL
	 bPmyY+Wyyt7VxjJVgUOKbJRpb37MyMBig3fZIyV0Pg+awFUpX9xC30FpwMNb23+VPw
	 f1aFPfFOrj5WbtJQKIzQNuR0zbR4eoJ6ssApdyHeCCtB5+n/mMNpwXPH+EOGVNLn2U
	 kZMyKG0X2VlvA==
Date: Tue, 28 Oct 2025 11:46:38 -1000
Message-ID: <5b07f2651dfe61d89f199055356562d3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext: Use SCX_TASK_READY test instead of tryget_task_struct() during class switch
In-Reply-To: <31c2ba69c73dc25b022533ca00300256@kernel.org>
References: <31c2ba69c73dc25b022533ca00300256@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19.

Thanks.
--
tejun
