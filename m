Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E22D594F;
	Sat, 15 Aug 2026 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786787290; cv=none; b=qhQzTujmzz3a9rC6WWdzLLohMenafJ7TgUdJyQ8p78MdUd+DijU33p1cH3JaatrR57zVpze7VYOsM2bXfHtNkCXy9rt7aPQsajEkmiBj+amG/hv8TLtLFyk3H5ZbPo1mtLL6rFWhpmcwP7Qjb7TzhnJyPJjEV1LAa1UW6+cJ14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786787290; c=relaxed/simple;
	bh=Y19gfHfFvRjVYjUQZUipBAp6c8/xserdE4PmyyXMOXk=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=fIMc6B5k7PlMwqdMYYHWNoW3E1yBHit3Tr9d6PldhIsxRcHqIhh9HxSzhibNPNBq4vig30U6RhqyOXeVpZn0yXrzchP9X2XcVAT44JOMsfdoLzC5okvdl8fcqJhmD18JxnIvFH6mngOCeEvIYNXVvv1vJHFeLtmWVQVyOkHzlu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV3XnTT/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV3XnTT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16B11F000E9;
	Sat, 15 Aug 2026 09:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786787289;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=EV3XnTT/g3Kl++mDtAy8GOZ7N1BklG9lN5W/Aecx80cWP7laCxxDoYYp1Z3LXfS/R
	 lMa7V6Ef/VXN8/mZpNWIvbASlMsNJANL7vA2EZVjSYnSBcllor6zVpwxDqKGrF1BBW
	 N7shqea05+IeimqzjaYHiqnvnUPtvlY0nwh8UBQU6zBntJWz4Rkq5JUfBsAKONR67L
	 xzstbkQbEvml4LEKlhBAEDm3Iwq6xlrkWUd5OppRHTgM0HpqV/7+mIDCVNZiYwXsVw
	 FGwyzLBQo9lDDSjL/RvsbQxAjDih61De8H/tmVpi0HTz+mBNSBUqicMCrxoDJZ4zma
	 m6xtTZ6wmaKTw==
Date: Fri, 14 Aug 2026 23:48:07 -1000
Message-ID: <e28a62975e57bc38437a4bf1f4d08e54@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>, kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev
In-Reply-To: <34c6e5eb01c406d93c8845b94a990069@kernel.org>
References: <34c6e5eb01c406d93c8845b94a990069@kernel.org>
Subject: Re: [PATCH sched_ext/for-7.3] sched_ext: Make SCHED_CLASS_EXT select
 GENERIC_ALLOCATOR
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3.

Thanks.

-- 
tejun
