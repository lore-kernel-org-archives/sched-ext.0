Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7072AE7A;
	Wed, 24 Jun 2026 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338997; cv=none; b=boGzUnfIIXDix2h/TEZJ3cYkltCyyWPMq+b32VUsTlhzK9khjJzrZVGMv4v0XepHJ3xjRjoUK4IONpzEr5zmloc/9weWgjEX5n3pX06MPscprOMEKt4rwpWshqI3/wHUcmTp+wOlxb8MDY90hbTTaM1C5rUq3KJHtAf4FA/04iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338997; c=relaxed/simple;
	bh=ugdv1NCK8N1F1806OOroUfrszZdf1g1UdAO1bdlK0TE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=AV5PBuWeun7wkQwCHNnX123h+LaKI+qhLlkZ03IkKCJlyZjHCbazhmMrpxm0TV21anZ7Jgtdg9Zuo12T+iRHHv5594F6LvRRHrFG6gx7mmi4s6yp1KNqHJC+2meLxHN6gAtopqPhIYdsJsHO1zs6mR0ubz+ls202eBjZxWMXaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAkTImSg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAkTImSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404831F000E9;
	Wed, 24 Jun 2026 22:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782338996;
	bh=ugdv1NCK8N1F1806OOroUfrszZdf1g1UdAO1bdlK0TE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RAkTImSgly+CRL0chR/WOax3im5XpQNifWjE+YCC+J58N1Iq4w5aprGs/HnxuZuDQ
	 x+tnVeoVllSI0EWyjT+W4PQlVKn8AjjRKrcX3jGnM5R4/+BizuM5Wb2yvppwg3sU/0
	 HbQeAr6WB6rcRHftB6RzRIwNcUralGL3Q8y6kGxZoDPSnNgzx8EYrym/zoC01u78F4
	 ci2UffZphEF6vWJrYubWjAXDcL3PgKZBjoQZ8Hy509l7mOo4ZLQqirGK/JzpUyvWA0
	 5U7+KSP2vKOqdJvBvBEDa1pAYRAMoH0lbTwr7pFlGjXX+cClNEvjxsGixLAQMpR3Nx
	 qNHlCfKLdx+LA==
Date: Wed, 24 Jun 2026 12:09:55 -1000
Message-ID: <7955e0a06702031606f67e0f163f33f8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.2] sched_ext: check remote rq eligibility under task's rq lock
In-Reply-To: <20260619132359.831936-1-jpiecuch@google.com>
References: <20260619132359.831936-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Kuba.

Applied to sched_ext/for-7.2-fixes. I rebased it onto the
kernel/sched/ext/ source reorganization that landed in the meantime, so
the diff now applies to kernel/sched/ext/ext.c and
kernel/sched/ext/internal.h.

Thanks.
--
tejun
