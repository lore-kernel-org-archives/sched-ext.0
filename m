Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD43A7F62;
	Mon, 11 May 2026 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485675; cv=none; b=HR5U3H1JvAGobPnwrWvWrhpRaUTIPrPEoH1wILZVbi+JxXkSb1jDTZX6Iacd4q4DGU5C+w0Lj9LtlTQMrpIn0809neXlRI4VzOimtDCNbXzGRchZYHeH5HTpDvpRbPy+dIG2pe/mzys1r8fZDhfOKQ1745CBwFhPlmkrXkrHCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485675; c=relaxed/simple;
	bh=dfbHAQRxQzkUPAYug+9exwagv1QwK5/7Z1gWKqP+R1A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ZLVQ0H5ERIaDPoThAs6hxQ/7uyQ9SaEHnWEuP01SPa4/4yEXpbXxZY0T4HvJyVIIm0CJoXidIv7wqF2Bya6Q1ZQhcOj4fg0UhKPklPRZ9oxKzl+HmGn+iVDLeAZCkJU0poEleU08r++P0b8DGlzdGS2D5iR44V0zU35WbCkd9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amTaerdY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amTaerdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BFBC2BCF5;
	Mon, 11 May 2026 07:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778485674;
	bh=dfbHAQRxQzkUPAYug+9exwagv1QwK5/7Z1gWKqP+R1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=amTaerdYlWe52tWO03WXz4tBqCrY6Aon4cTJlmUKWkVk0CGkmJ+THrOs4Gx04d30x
	 nJIVpXGg6zcOiNRFw9RFlEo/ywF/5mGzQL6b+qG1X8000PQecViKYM3yKNKnF/VVx6
	 i8sDrJ7DtR+JXdHAUwPIwABqwDWlGAzOTR0/0zucOUh3OjPUjgRQI7/j+TjTWqQ9dA
	 JQUCM1O7b5kr6GYvJXRm1nzjcHg9+Q7uini21UVGen/7L1xADp8K3aB/cRTlNg/hSE
	 5FgYwl/zOsWU5DJQFwnmjiOoqDLj3SHpmqPkD/6mpvn9rET6udNmIVWfmfvrKy064X
	 emITf1IHy3Sfg==
Date: Sun, 10 May 2026 21:47:52 -1000
Message-ID: <0dd41fa159da749a1e3ea88cfdbcca17@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Fix ops->priv clobber on concurrent attach/detach
In-Reply-To: <20260511061812.2459458-1-arighi@nvidia.com>
References: <20260511061812.2459458-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

Applied to sched_ext/for-7.1-fixes.

One followup if you have cycles: scx_alloc_and_add_sched() can still
fail after rcu_assign_pointer(ops->priv, sch) (sub-sched
kzalloc/kstrdup and kobject paths). With the new gate, that would
leave the kdata permanently -EBUSY. Could probably be addressed by
clearing @ops->priv on those error paths.

Thanks.
--
tejun
