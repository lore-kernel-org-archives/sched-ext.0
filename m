Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8492931D2;
	Fri, 14 Aug 2026 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746896; cv=none; b=NsKGlQS8d+JkT/p0mmcf35ZN5udp13LqcVxNB00hlq5LVgz3z0PNMzFWMpQZadJ3m9fBS1qykAQztzOa7L86zGnzVvjhYUKF2GQbKLIXvDP5mdCBgVz6QR9SZovJJibO9Rvt0LP58vZwGiXTVv1lSQdlGau+5y4uBPPIS9xlPrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746896; c=relaxed/simple;
	bh=Pr6JgasY8cdZc/CAIerO3IBccT8bZwH3cHh7qYHe3rk=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=Uc5di7fhaEOEiBvKeJyGOHUbAJ98zsP1fUh5+c3N051bRxAC3N/0TnVEAD/9IcpxGD+gO+6xgLyH4m+AlY0GNSRDQFdfn6bGDzDwAVX+asKDdMmzDHbG41jlQz9JfNP8RicnDi3ghdry19XulIEOMM4UUXZ0xgT0AtRRh/GKFRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyTPKPHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyTPKPHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6AB1F000E9;
	Fri, 14 Aug 2026 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786746895;
	bh=gRScg7kTTKP5QC+mwsYqWg2jzuEN+O506rd/2vJ4gVA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=SyTPKPHstUDRr9zG1f768/nbU1ybcRKv+WxlgkAqEK8poikvd5cyqFoxUClxYfCdK
	 RhJsRHGLKgrBvI38aqR+5PrcpkCzNZLKYwyQVDtn4Dk8NHmGMMZbB5yLeH800eIEZj
	 gZWPtolneWKyt6rorouXjcSkMzIfail22r5sJxeAGMYUcMDNoCdXG/LQG/SG3AhPTT
	 Cj9oInFMQjzJv+xbirXH/iukWRNkGZpv4y+xKpOXVMI9nV5z5zMJDKRJM2LkWI9FhO
	 r8drhVIqXd3HkVoxMV8OF3h2kEBCwnrIDzpJjVJvoretp8x0eypT9z0MsoZkX3XJmq
	 +IPcrF8YgHTMg==
Date: Fri, 14 Aug 2026 12:34:54 -1000
Message-ID: <9a87b991e47916a87c00c1277e00066d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Michal Blaszczyk <michalblk@google.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
In-Reply-To: <20260811141358.2767765-1-michalblk@google.com>
References: <20260811141358.2767765-1-michalblk@google.com>
Subject: Re: [PATCH] selftests/sched_ext: Fix flaky ddsp failure tests on busy systems
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, Aug 11, 2026 at 02:13:58PM +0000, Michal Blaszczyk wrote:
> The ddsp_vtimelocal_fail and ddsp_bogus_dsq_fail tests skip calling
> scx_bpf_dsq_insert_vtime() if scx_bpf_pick_idle_cpu() fails to find
> an idle CPU (returns -1). On loaded systems, this results in the tests
> skipping the very assertions they are meant to verify.
>
> Eliminate this flakiness by falling back to prev_cpu if no idle CPU is
> found, ensuring the illegal dispatch operations are unconditionally
> attempted and tested.

Applied to sched_ext/for-7.3 with the description updated to say that
scx_bpf_pick_idle_cpu() returns a negative error code on failure rather
than -1.

Thanks.

-- 
tejun
