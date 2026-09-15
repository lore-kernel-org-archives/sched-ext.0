Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A930C618;
	Tue, 15 Sep 2026 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491711; cv=none; b=mP5ArFlihb42A+zFUoHTiFFf7pbGHWlGxp6KN0Mii++y1aZMaLuPQxr//oj7LdGfhC1UYlu9ZAWctOxF9Mc88ej5oQx1n0V5eiLezgIZ8KSYiZ3DiJtHFZnLxg6NrQZS+ZURiFMSRDdOlcRGacR7Omnaj4YDZL+CDUcfsZ4ayHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491711; c=relaxed/simple;
	bh=wkI+Uq9CoTiFuOD2krFI0IZ7m1fd2wBgU5Jf/Dso6Pw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Trzg2IHf5QanrOiOGwaYblo6XCMpBiliwsYdv5J32/8x0WzGxJzza8h7R0ELS09bzaYbayKYw9iLfHRcAQVEcJcrFqP3FlTYefVvzKBGpbYf/lCrvAsTXR+nExBIqsnc2JmMpKSgJZtFb5Zqz7vQzvNqnB8Ptu2rhuJBcOl9EAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvwPg9gu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvwPg9gu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28961F000FF;
	Tue, 15 Sep 2026 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491710;
	bh=fUdvVWUeeMhxJ/c8azgXuwRmK/SDZMMRuDb+OuJ+VNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XvwPg9gujN+iVIX6J8gs5z5aBhg+F9B3JHHMp7/PV6fAkMGLkJSMVImvytlclOAz7
	 pTmvDJ4D0MMxxlzzZ1nvkwUT64aG3tmVwTW5unJEQac8GMX1sqhYI9t0BTNskjUK2R
	 Ar1KUv/5fjTd+rUToussysWizbvaJXLovrawMAc0A8EBXxqbOOwEyzEsZB7M6SLdoD
	 etoB0k0t7Iim98Gz6fuXl7ejtObHwz8akyOypydhEnNHWSCFos5SEddhJYU2bzMdnl
	 pzMjKQIpvVI+IQUvWRoxm3JhBVGzp8cPAt1DJ9OLW5ybe3MHNKjTzDyleL5x7FJjJR
	 6NtMuUXynAsnw==
Date: Tue, 15 Sep 2026 07:01:49 -1000
Message-ID: <17cdcfca5509c320dd1344c66fff4289@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.3-fixes] sched_ext: Idle claim
 recovery and online cid mask
In-Reply-To: <20260915082725.3881071-1-tj@kernel.org>
References: <20260915082725.3881071-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Mon, Sep 14, 2026 at 10:27:23PM -1000, Tejun Heo wrote:
> This patchset contains the following 2 patches.
>
>  0001 sched_ext: scx_qmap: Restore unused idle claims from ops.dispatch()
>  0002 sched_ext: Maintain an online cid mask in the scheduler arena

Applied 1-2 to sched_ext/for-7.3-fixes with Andrea's Reviewed-by added.

Thanks.

--
tejun
