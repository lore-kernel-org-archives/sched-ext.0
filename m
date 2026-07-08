Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1303D0C18;
	Wed,  8 Jul 2026 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537783; cv=none; b=QzJ2sxXPK/trhEZeWyCW0DUCji8FSPawt3ZCY2yfdAvj6Z3Xn4Ac1qZmnBpv/9GaoLH98+Xl58T6R18eZUPWd0TTyawQiiP6/26sKEjpVeUEjtTNzBunlpKnvOkhfB8EmidizXFnEjNc2uVwdQFP4sCEm4cbqzjvbRjX/bRQA74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537783; c=relaxed/simple;
	bh=T6crUMHwv8aR4ghoLWLpChAr9VRxrs95cs4D1J6rIkw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=nvJ3vwU39mhelMbOQIHPER3zAG5w2UK71ZEr1QmtXhUX4m/iTXwPivuXjLzetgcu9UJEQ3OPbgjF2xpghL/X5jTpUXpUjK3bTslE+K6UTnpXpK0aIB9R0UTkSE19xWeYhdpBtnJSisNgwYiMC1u6uke7rvb1g/FJhpy97PO3pOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feCy+Izj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feCy+Izj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90881F00AC4;
	Wed,  8 Jul 2026 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537782;
	bh=WgsIR0JnhgkW6hBxawInez0ndEZdd0HWbmZ8V4Q1B/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=feCy+IzjlOzGt69j8Jxn2K8u4U1QyP3m4fCKufo+ay9m1NA+jVc/qQZow/hbnZEJk
	 P8GRob4mW0K/A10VEh4aXijBJ8Xy/Lsdy8RC0nAWkWysdaRME1kdhRB0aib5kDI5Kk
	 OcuA4HgVK3+CR4ZBZBGg8pIaUrUzmEkm6phdmZTd5LjYbgZRvjFG3pajAqPBpy59u7
	 0A9OvMoolOe+d7DBraFz+ZJcwAu0ckgG1MjJmmsQgQQql101osW2h/c/J99Wu7H2Ge
	 9AiVqbAdPygRtxOATi3KbRRhlYF5VzfnWs7scsLw5A2RMqTYQ/6IhQxJujZ1Bjuy59
	 vOy1xq6VjmXuA==
Date: Wed, 08 Jul 2026 09:09:41 -1000
Message-ID: <70c37a43b2eb1e3d54238c02851f0b62@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 25/36] sched_ext: Add the SCX_CAP_ENQ_IMMED cap
In-Reply-To: <20260707003211.479301F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-26-tj@kernel.org> <20260707003211.479301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:32:10 +0000, sashiko-bot@kernel.org wrote:
> - [High] The SCX_CAP_ENQ_IMMED capability inadvertently allows sub-schedulers to enqueue non-IMMED tasks to the local DSQ, breaking the CPU isolation guarantee.

At this patch ENQ_IMMED is the sole (baseline) cap, so a sub holding it
admits its local inserts. The ENQ vs ENQ_IMMED split that gates non-IMMED
work is introduced in a later patch - it's staged, not a hole in the
final tree.

Thanks.

-- 
tejun
