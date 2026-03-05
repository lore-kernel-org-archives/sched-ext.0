Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01411799F;
	Thu,  5 Mar 2026 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727949; cv=none; b=siasSTVCk2TnzAgY8j1W5Pm9P4RqQMOf5tHP0L4TgRiLgNbhNHO/03RzHTyznsNvZQAjV8BW7cJsVa3fUJsYksw1m4RKy5PrqYiBb5IiqAuQu5tZ85SssZzFq36cxw2aiGIwQr5hSKAPmCxa5s4yAHCouh4a73mb3fTC4O8teCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727949; c=relaxed/simple;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=fiEvOfgElW+XL5FDQCHtCvT+SavlYRU/VJKsuGEi1KXw3IqTYJv9kjm3LDhSyYAk6ZkSCfSZniO7xpfJyJbiBRUApKhVKmxMZ6vRqnVS6sq7bWE+nfeh+mu8CXlTX0qq8MAZVP3BoNQtLi5Cd03m6DPuFxEz9F8XxBIigNY0JXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSPPWyfE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSPPWyfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FF6C116C6;
	Thu,  5 Mar 2026 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772727949;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QSPPWyfECMXvwTD7GY4Yrok+85eAkWd11kCRb3LvGYuGjsXpyjKNuOFqrgoc4eAJq
	 Kte+vZi9ldHhzJiDm5z3DioNitGqsrcjid51y7QFyW3eNIHlORVZpMJ1Dr14s2ZNhO
	 0E6ET7rN0OR0QY21Aadj7CXGZ5ozxGjLh4+qlH9S2vfEnt6HgfKdv4aBqDJbuoFT+o
	 mYY5DU6VoUg6ymvDbcK4BAKf8Hjq4+sfkFda2jsNPZibU29b6AfrwdBonKDrJUvyFU
	 jsOo3+ZX8V37Jpxb9DiJE34Ocfiw7U3OWxA4LCwvnn1gL4t+ZlOJ+WonhHI9nS4BhT
	 zVuLLan5HG09w==
Date: Thu, 05 Mar 2026 06:25:48 -1000
Message-ID: <32c9f0513c0d8d7244d0c1115543b21d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Daniel Hodges <hodgesd@meta.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Document task ownership state machine
In-Reply-To: <20260305062900.43450-1-arighi@nvidia.com>
References: <20260305062900.43450-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
