Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122240FDAD;
	Wed, 29 Apr 2026 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777483004; cv=none; b=Cdczc0cSqWVtZg3+2UsibLzHHjhxrB5X2NlbegcjBhB8aruJaC43bz8i5T4579Z8wZS7XQ8t9hYwskq+K08Yu8VpyPdYRQbiWa6e16TOu99wCiViWQSKUBvtl8WD9qy0OwkQ4JOOKscmKHATX6WDDJprYR9A+wzTLmDZS9xQp+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777483004; c=relaxed/simple;
	bh=qt5dCT7I4NkqGxEpQz/y9hQy+Vap2jExtu2cUsu8q2c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=dOUhrTAI2dum6PsI8lBcsuzXl4xQgd+CR97Ct/aKXN1Kq1GQdUgNzs++tydfPQjVuKI88nfMu1tD4uytZ3JeyNEo/m4TomG49U0DaIwrTwL2Uo6gu9u+t/PGUDouPNAyPQD5YnikKrVkv8VivPfZNJ+IXODdIjjCJcBRyYUGxFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5RbehOs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5RbehOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F034C19425;
	Wed, 29 Apr 2026 17:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777483003;
	bh=qt5dCT7I4NkqGxEpQz/y9hQy+Vap2jExtu2cUsu8q2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p5RbehOs0eh0W+xgvk0sdsvsXabp8mDRmsbJVdrKS5nZrNK6A+wtaILtjNRs/bnK/
	 4IkcOU0DPXzz7KvYxSgbsLRFvQU0uBo5IGU7RIs1rdsSbXnZqSVhW0CS/EUlG8xOBn
	 bsf5uzm7x8+IwYFcvMUN6Be+XJ+k2HLbu9HT+4kuyYsOEW1NKm2MD0uUf4T6exXvBl
	 88mt3S8WLk478SacsrhWorMfcr9BAG2La81AjvMgxsEeonuWT6MbOlLa1DFwXl5CZW
	 39DNaxcSFuBQxTBhEoHfyKCY6lyuGqGE0M3//Mp0G1NRtY0p63fJ3DTv1nWgmDdtNX
	 OD7hvKELF5Iew==
Date: Wed, 29 Apr 2026 07:16:42 -1000
Message-ID: <910bd04c0492d37bbf91e7f7e4565c9d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH 10/17] sched_ext: Add cmask, a base-windowed bitmap over cid space
In-Reply-To: <b8bc70c1-8914-4a39-825d-e94cfb983d60@igalia.com>
References: <20260428203545.181052-1-tj@kernel.org>
 <20260428203545.181052-11-tj@kernel.org>
 <b8bc70c1-8914-4a39-825d-e94cfb983d60@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

I'd rather raise the loop count than punt to a kernel slow-path. On
multi-socket Sapphire Rapids, banging on a shared cacheline with
kernel atomics hard enough can stall the machine to the point of
hard lockups. We don't know what BPF will do with these helpers and
they can pretty easily trigger similar conditions, so giving them
the ability to loop indefinitely in the kernel is exactly what we
want to avoid - we want to fail hard when this happens.

Bumping CMASK_CAS_TRIES to 1<<23 in v4 so abort fires only after
seconds of real spinning. As a follow-up, I want to add a kfunc to
let the BPF loops bail immediately when sch->aborting is set, so the
abort path doesn't keep banging the cacheline while the kernel is
tearing the scheduler down.

Switching to ctzll() too, thanks.

Thanks.

--
tejun
