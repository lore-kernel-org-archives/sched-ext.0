Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F63D6CD5;
	Wed,  8 Jul 2026 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537786; cv=none; b=lF4vGHcPax2Xf6fGPmNLO/2n4p80HqvbArcy94IqgeLPjaroUMCLI5gpFX8IV70QbYpB1VuWdluheHm+C95X18AY2vvpkUyloouLrYsDDqV1Tth43RtEiWVupFtNsKTBI+gmw2MT3J2XRwEOyolXvXtIB/ZyP/V6MnPaPkhBAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537786; c=relaxed/simple;
	bh=KPKxPKsOPecyQpIY1sMevDB/UFKzhwMVrS0dfPyvwSo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=PRtkNC1YYrQb68n0+B+IArm+TZsRlMDSS25SKRPAheOljE+SWLlcVo6oqupoNdh1bPAlqikYdXa0bdFpwy+GyW1/J4YgjU7J6pYYbOjDXK44HNvGfAGagHP2E05PnhMXi5N57kMexPf03zTOSpkjeeN/nCGcEX9MOZlJDetj8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc31gzG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc31gzG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD381F000E9;
	Wed,  8 Jul 2026 19:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537783;
	bh=bA/4jjt6qbGI3tqGRVMOebYbAisg3QV1u0AShYq8WgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Gc31gzG0K1tJWwz4LT4yxqePehG35u704NLXUHMiRROdgCT9tX2h5LH3vD8QDwH+P
	 pG6FIkN0lJyImTjnB0GF+THAO0Rr2vuCrkZ1oCb+S8IIZGLIqkZPJNRnwcg6F8tLHF
	 Kh+7cg2kKHPTs+dcDDEGNGoJDQ3o3nZf1WnBbNXgjQMIDgm/tQnQHSk0EM0cXUABJi
	 hBtbqRMGVnhca2M5DLeMM+DDA/yg8dGK3g2nM7f2ja2hfamYIOHeDlWyh4+kxmsFWz
	 GXeIwtqnEKmHXrCNKlxjyYL1cUKhjQ9Aryt6iJLDA7J07/CZ7MM28V5V3olA84bCXk
	 4oIVwpvmzXm+w==
Date: Wed, 08 Jul 2026 09:09:42 -1000
Message-ID: <068c733e651131c5b45838697d9f67de@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 28/36] sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice
In-Reply-To: <20260707003821.682BC1F00A3A@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-29-tj@kernel.org> <20260707003821.682BC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:38:21 +0000, sashiko-bot@kernel.org wrote:
> - [High] A TOCTOU race in `scx_bpf_task_set_slice()` allows a BPF scheduler to corrupt a task's CPU slice and bypass capability revocation.

Real. A remote wakeup migrates a sleeping task via select_task_rq()
under pi_lock only (the one cpu change not under the source rq lock), so
the cached task_rq() can still equal the locked rq while the task is
elsewhere. Fixed with a runnable_cpu stamp maintained under the rq lock
and cleared on leave, checked in place of the cached rq.

Thanks.

-- 
tejun
