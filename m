Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856972727FC;
	Mon, 10 Nov 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791672; cv=none; b=gIKQC2c3oPYmboni757JDKxJq0Skr6pnbyjvaC42d+Q66GYOcjoXRBwNXppMiNPAkhWywPMkZPsruRhYDZ15FLWewJ93bled5hD6bIqq996dIiGF8+KvpCMFW6DPWRpZuJQe7m2xpoe8Cn5gKUETGB9nSfJi8aPYO0JRrqKLsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791672; c=relaxed/simple;
	bh=CtKARUJuudEJooUibxGvhhBnogXfLxhB8I8BJhRHqxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMpwOucgnLEpURXhlauvY2jhaT/8FB3MeWqzoJWpvfcrlMT8/RD96DKlTtUdtp0tN9qke07r2CL/WF+jhIGYILWJCxQQ+SoqeUEzPIwqyXyE4ZIRF7d6ZYKuXhsc8CJY3qKZyNa4bbh+/FJyhU9U6Z5LK/Sz8B6UQK09298SOcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaYDA5os; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaYDA5os"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8899C4CEF5;
	Mon, 10 Nov 2025 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762791672;
	bh=CtKARUJuudEJooUibxGvhhBnogXfLxhB8I8BJhRHqxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaYDA5osKvlhmt+e8NQMJsvXj3AJtXg+etgrIR0eQBanTs89p6crTI5XrALS2XMvV
	 uq3xo6SSvR/iZBiIQ7QcdPtosb8UuwF9tqvdT0zRz0o+qd+W+s3UimjqnP/hqSzGLA
	 0d8b8tmwGAJFIr01VlXsV5eMGnZrjIXvGMWInoqeOCISZw/7jWzBe0tEczu7Gl5WIK
	 g0/qIOq0IPkFP7MHYvlVgvS7ifOahlIUA/t9Oyn3+/to9k97qWSQwBNBBrqA0RBVlE
	 OSC6GPZzGYJhcEFYiIKaoYsRDbCuMoaKsR/9PhxBlgOtyUaaPo2craQOtrXmplIBvE
	 45i0jLqb/S1gQ==
Date: Mon, 10 Nov 2025 06:21:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] sched_ext: Make slice values tunable and use
 shorter slice in bypass mode
Message-ID: <aRIQ9rptcggpUVft@slm.duckdns.org>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-3-tj@kernel.org>
 <aRGOSSN9PiCBCoWy@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRGOSSN9PiCBCoWy@gpd4>

Hello,

On Mon, Nov 10, 2025 at 08:03:37AM +0100, Andrea Righi wrote:
> I agree that slice_bypass_us can be a tunable in sysfs, but I think it'd be
> nicer if the default time slice would be a property of sched_ext_ops, is
> there any reason to not do that?

My thinking was that a scheduler should always be able to avoid using the
default slice. Even if we allow the default slice to be overridden by the
scheduler, it's still very crude as it will apply the same slice to all
tasks. I'm not necessarily against moving it into ops but a bit unsure how
useful it is.

Thanks.

-- 
tejun
