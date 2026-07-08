Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973B3CA4A0;
	Wed,  8 Jul 2026 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537776; cv=none; b=HQm8FksZE3fpb76QWXb2ao4tlFSA5RC9jFYuS2QO376gAVO6z4CEcYrmC0pCNXHK3C1T1m6qS/v/Z6TFGM4vxuTLDGrFxISsv5hVZfNlc2vAnisIHNkWxxbkaJLk4BUzZ/Ka9RMUdv690yj2+6P13KZVUXyKrJWtwflsl+SgrHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537776; c=relaxed/simple;
	bh=RrdcpBcKeDW5xnZ5OYnbT4d+Vg/wcyOCBsj0ndlvsH4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=iAURlCpYrwMx7kpzdo+qckwReToX5dijPdfl4YCmPkuLUbNhohFq9sXwcUP2FErH4+s7mKuWjJMcELbwCXumjYxIObUSPZyRF4Rfr9jgQcwHjCZ3WJ51vvvNHTrG5k1tfSJmJOjd1QXJcMXAW91jqC6II/dxAHhX4bnDSAW8HNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZOB8yvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZOB8yvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AA51F00A3A;
	Wed,  8 Jul 2026 19:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537775;
	bh=RO5aQDTaTWRjKqFaJjX7hKslyfdlPqgLp2O64rXHpNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eZOB8yvbrFXLWql1U62M/AC8Abi2JwDG9FmmfJhmeYvVMpa8Vm+xQul0NwnS8qVv2
	 FLXT6k9QJxNT/W7eH8BRnc46vl4H2McugjgQ6FJKZtcjGBXQgAL6XsAur2Vb1U+GQC
	 BoV1hMpLNn1YohvE4G/C4FuPfzZeEJtl8XwmU/G7yaMZRfJvf2ZWe56bwMYHHSeIok
	 Gp5vI0eDI7Lj5M4BDVhhaIc9gufYQvO49IrQF4Mbe1UBX8v18k/vjFdGyJt199oAhV
	 IVJP+YEp3DNbcFX1PLMdL6AgbfWiLUw6a6vakSQYxUepi5Q/XMq5d5MoW4/RmH5Pxe
	 2JoyhEhpaRghA==
Date: Wed, 08 Jul 2026 09:09:34 -1000
Message-ID: <7513197a6ed81817b3326b52b23fad74@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 14/36] sched_ext: Add per-shard scx_sched storage scaffolding
In-Reply-To: <20260707002840.A272F1F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-15-tj@kernel.org> <20260707002840.A272F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:28:40 +0000, sashiko-bot@kernel.org wrote:
> - [Medium] Missing `scx_alloc_pshards()` initialization for sub-schedulers.

Intentional here: this patch is scaffolding plus the root allocation
only. Sub-scheduler pshard allocation is wired up with the capability
feature in a later patch (scx_sub_enable_workfn() calls
scx_alloc_pshards()), and nothing in between touches a sub's pshard[].

Thanks.

-- 
tejun
