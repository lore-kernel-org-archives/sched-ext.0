Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB62D193C;
	Mon, 13 Oct 2025 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380738; cv=none; b=nhlPzWQzpwW2A7PTmI/x42ifozX4sHySDg6FZYhWgZyjJFheL2fDxI91NORpzf/AxHzJEXN7TtEozIv6Gbf3GFUgmylvereBxCCzcjkZcJILJem3KwHU0+f9wE20vN4UVSeW3ifWTlTYBCKlMU8CHpz+manhtE6O8cOAXRQuFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380738; c=relaxed/simple;
	bh=AI6PmJfiUyFhGAxr9Ua3LjV04kfw5ZG6HNy5vWk1OGU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=kPl8tI8ot98cuzKnRK3Duk5v5J6yWppfFycufj7FVFNQZ3m1pTv/mVjVRV5fVdHTMlHpMqW9jQ/kHv6pOZPIvfBjYxvgfy0CuaEZda1seqEqfomE+AlLBeFxQTPRLHO4I9eYOa9oEDmG2GkLLr7kriMOgvjixoxYAMY5mC2U3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px6Vj/TJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px6Vj/TJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440ACC4CEE7;
	Mon, 13 Oct 2025 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760380738;
	bh=AI6PmJfiUyFhGAxr9Ua3LjV04kfw5ZG6HNy5vWk1OGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Px6Vj/TJB3SV9zCddkzpwN7SwGeUctlLJnGe+gy+kjmXqp40PeRHliNKM8shrzQWw
	 8wgyWFj0ly1Lh6+dnJsa/QwhelmrYjxHb9mj0hk6mAjskuy8CiKTO59140dJKnt4v3
	 S9LOLQq1eOHG6/gs7P90BbsH/KqbhUbd/VhY/D9+LpQeSCpYbht39kqTfQx7hzuylI
	 MWjEfIhEy1UUYBVpByKT0q1gLKxAj1nAPTI+OZo936w2Y0utBdGnkpoGQOPicqeKAV
	 plNGQJRhU2XeBPM7C/OwAEBLo7GtcZ4eilBSSCHg4FyOg0ggvWzC+u5Fb2MZt0gGjJ
	 cIrgPDqjHiWQQ==
Date: Mon, 13 Oct 2025 08:38:57 -1000
Message-ID: <156f473563d1ab78e903983c91e8cb43@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <etsal@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: defer queue_balance_callback() until after ops.dispatch
In-Reply-To: <20251010191250.3821639-1-etsal@meta.com>
References: <20251010191250.3821639-1-etsal@meta.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Emil Tsalapatis (1):
>   sched_ext: defer queue_balance_callback() until after ops.dispatch

Applied to sched_ext/for-6.18-fixes.

Thanks.

--
tejun
