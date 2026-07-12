Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F79A3AA1B8;
	Sun, 12 Jul 2026 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888016; cv=none; b=YT8/e91Z0WwTzUz3PevLAq88Vebvig7/fsiR4tOvIHhUOIVjmiRKz/rIuS+s/Lq07RqBAx2OfC6PQTilw3CWAqHwpzRUOHgBOiMfKs3ygUXXhb1WAzeOq7MMz0lQwELFoCFpjPC30tJ2mzSObQS3Hn49NGLraI6bTrm8VF+wZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888016; c=relaxed/simple;
	bh=eCf1408MFwUzNB2SfuMvSTZh13dv9dkzqobURrkEYAI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=c892k2ORuH1/bs8CaVBHun36dTuoYdbt5pgYd63JgjLhivvNvlGmfhWvL9q04sLCUXDRqrWOYJFbXXg6mGCpFvkmSCfA+wV1m8mGFFgKjDA/K7wTPBLXQePkgxnezersOxKmtJGwfS1G4wEGLxcAfRroIjFBcOMkkWNu7Ed7ssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2n+77Fc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2n+77Fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DA61F000E9;
	Sun, 12 Jul 2026 20:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783888014;
	bh=eCf1408MFwUzNB2SfuMvSTZh13dv9dkzqobURrkEYAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U2n+77Fc9fwhTD8H+MNxdJB8y6OeyW+zoGqZ1+ZU0uVCoXLUsGDyvVOWl72NGlqpK
	 6IsPOEjEqad87TdSfvxOaiM5d3+NeteplkTwrmrhgkMIOhzDyLe2cjXS9GU2czvSoI
	 T/ZJyJ9ihclIMzfJ+hE8Hg5GYVdnJlAWiECLDWkrwKR4OSaXKeo8d4cNEXHoQvs4+t
	 F8xa2iadSHEA0NG6391fkwdKclX03z2Vfydb3p2Sgd8v3NHSTgXmTXKDuOa+con6Ih
	 hQXYkI2Q87xPl7cvydOxoH8bwilRSsnIQH4cRbB/NHKeGYmTCIC7wPF7sNaxrhbgXq
	 e6SXKVdOFRfYQ==
Date: Sun, 12 Jul 2026 10:26:53 -1000
Message-ID: <60b5a9ee3c9d3f248cf70e68014b8cea@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>,
	tj@kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/2] sched/psi: Create the psimon kthread outside of
 cgroup_mutex
In-Reply-To: <20260712180032.087AF1F000E9@smtp.kernel.org>
References: <20260712174619.3553231-1-tj@kernel.org>
 <20260712174619.3553231-2-tj@kernel.org>
 <20260712180032.087AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello.

> If this error path is reached (e.g. by racing pressure_write() with cgroup
> rmdir making of->priv NULL), the calling thread would sleep for an RCU grace
> period while holding cgroup_mutex, stalling all other cgroup operations.
>
> Could the trigger destruction be deferred until after cgroup_mutex is dropped,
> or handled asynchronously to avoid stalling the cgroup subsystem?

This is pre-existing - rmdir and cgroup.pressure disable already destroy
triggers under cgroup_mutex when draining open fds. Maybe something to
improve in the future.

Thanks.

--
tejun
