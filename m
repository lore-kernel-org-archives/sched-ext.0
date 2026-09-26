Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE34380FC1;
	Sat, 26 Sep 2026 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452351; cv=none; b=ZhXQpNlgMP/r6LNJ1dtSKibEUSAKNMnUzG3WzPgh1kqgduE1SnqCwbCC31+zvCkGqmZoKlkZI5fyh3wO6MI+O6D7THHlHkKg/rlThRb0iVHdAA2yf8SObDOjhosMCOaAI1Vp4m7DGsWS2Sv1BKHUgqPV/ST8quzWCs4pwdWzBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452351; c=relaxed/simple;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ru8d3eeKbcFhiswmqiUh6LtnAp0lJyvtYusFF+093U5ZSoYMbcCD2+sdlmxOU4Qkq0MH9w99O2rQAl4e5NHWDTrUetEOiSv4BTl4pelIqVGGmXbzwmTKMST074Hj6vkKRVWLBW65vpzoTWj3XAxc+f9i7Y8UfA95xzxjejHOf2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0NE8ouu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0NE8ouu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8591F000FF;
	Sat, 26 Sep 2026 19:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790452349;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H0NE8ouun7l/2MoNzAq0KAlU6tpb7pwCarVZU1/wGQz6lncSKl8hVTGFog7frI1Xf
	 /4odZ70eaTQmCWHf31Nxf2gAcQHUGoga55pkM6bVF0rSVmkGwfVHN0oOZVAw/JgLAQ
	 sS3T7IoEm+iZkuSLYbgkX01LybnoVob8gFVkoiGDXXyLCPpHuFT9tubcTrLG2ppvMS
	 E/FWPBfvurloT+nWCLCfqSfmBafgDSHbYDKWXVi8MJgyygKiYrKNpau+r8nJ8YKHsl
	 WI0cV//ysHeYlESr6Dh0XseOcvP2ulNjkJ6H9YNvFzb4X/qTJ6UITfGfiqXEKtARaA
	 8kL0YD3UJF+6A==
Date: Sat, 26 Sep 2026 09:52:28 -1000
Message-ID: <936f4e6383cdfed5198ac3edba80ae13@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Add a CID NUMA node lookup
 kfunc
In-Reply-To: <20260925144604.2451177-1-arighi@nvidia.com>
References: <20260925144604.2451177-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.4.

Thanks.

--
tejun
