Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE342D77E5;
	Sat,  9 May 2026 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778342013; cv=none; b=KmmkhI+o+vpPf/QOg3cqSQV2wQsjl7F4aV53r8NIaZY67m5AGOt1qjdU2oPJKjSe/Ey59RbR/sBgbCsl3/1C8hjw81PQjjvMRpDiny5iSRIXfDsq5wAy/X9nfqLjdL0/zh81miXOrd8myJIuwcE1t2n2WLzW9wubO2dA0ozODm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778342013; c=relaxed/simple;
	bh=qwdHNsm339DgGlPwlYlDBmESvB43wCN5K9Fa8rDpWmI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ChHIPudjpel/ON9yv9v/2wVlTVA0A0fKgIN5KGNIznk9g4Ysap1ydZa7I+LKiQ3qwH+RW7RBo/0INfRmGXB9mOX5EbgOAO+vaM5GXcwb74ObipzMRkjoJWurb6JRfXIsQKRRh/Jb48ftAZeomRSqc4wsqpS0SNhNBHY87vNCZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rfm0O6Dl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rfm0O6Dl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44AAC2BCB2;
	Sat,  9 May 2026 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778342013;
	bh=qwdHNsm339DgGlPwlYlDBmESvB43wCN5K9Fa8rDpWmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rfm0O6DluNz0L5rrg0pZZ5uBP5QD+L2MJTh00/J/mKHIH10aI/uBzwBggWzf1/XLg
	 Ga6AIutlHDBWYS++jlRRp6SeN9g7y9ZxDjc9QeTYK0QcKm8EGG3l7y51wHFTL0BsbO
	 2SYTRQQ6E1mvtjjuC/TqRMj1QDSLROjWIZ/ebUmOkLVh/VOrwindvBvhifvX5gyiZ2
	 36wdu1kf/WFuySqIG89wEbpwa++9c6r5iJVKswo86kbrlC6SuMPYU6PpW4CekaOLmG
	 WI1DTyMWAX7qGxzFrWKXXVUNGXhHsOHduAeLTMgc5EmSR7TBZ1W5txPESDqUbDjj9+
	 YbUlw7YPzv7aQ==
Date: Sat, 09 May 2026 05:53:31 -1000
Message-ID: <c6bdfca8badb3e5ad3918b8957f9524e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Fix ops_cid layout assert
In-Reply-To: <20260508235946.215232-1-tj@kernel.org>
References: <20260508235946.215232-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.2.

Thanks.

--
tejun
