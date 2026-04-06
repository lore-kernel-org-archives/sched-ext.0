Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC0838C400;
	Mon,  6 Apr 2026 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498979; cv=none; b=b/DAze2bcj/5+vwUP/6cOMmMkLJgN57YKbwGLoVzwXnqJBqEY1qkjp06t7b7lg5k3RM+XoOHo0OJcBN7g3xsmq2h5jE1zeQP7LsAvZn+x4RtVizqVtXRtEoTku9TjYxlfh6ZgbYgM/pxCsB1wTZ7zAGYNMUys6dgO9SyTzk8szI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498979; c=relaxed/simple;
	bh=k2DB0gjCJ782E3afagDCPKDKbv6nTHXh3DvSfKib1G8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=RrYIzpPu225xUTnsiHd+PrM+7bCVqkVS+oF9UzPBLexOEV3bcg01GwmzBAwQuVLY43SKTlqfXjHawt9oL4K0kdintVcbzcFRAvij8uCLgY7oekAyLzQM+MUj1YBgZfdgc5OzLEr+aLeBlKx6bF/C9nutBOd+U6z54qrN1dg3TMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIddGS8W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIddGS8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6D1C19421;
	Mon,  6 Apr 2026 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775498978;
	bh=k2DB0gjCJ782E3afagDCPKDKbv6nTHXh3DvSfKib1G8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BIddGS8WR+n52WIVkzNuMslLOFZ4R1lRYIdxbMTED6tVyjyXlzatQcjqqWOkcmQSX
	 UbLkRR3bVpjp5kFS7UeM69qDsRz8+tLKQ2OV6E4avXiOznPi4HkIuKk39GVEqPbwo8
	 odODpZeJewYkH6DgUG35evXyVOh8khZY3YRM/2jpkNO7zDgoqNxpG1ZNyaWDdjmGRg
	 pj/Tu1CsvVAd5fhU5YCATeyKaSneD57dUVPIbMSIjj89hmaQxesmr8tInhzBw3smKN
	 psKox0SoNhks9K/sVtllXpHO3PLYDaLCxCRHDTgPTv+YOpI8LAbpcKNAHoLGGAnMt6
	 kkANstHSSH2ew==
Date: Mon, 06 Apr 2026 08:09:37 -1000
Message-ID: <9ea17de9397d2c93a688105d06405eb0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
 David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Kuba Piecuch <jpiecuch@google.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add
 ops.dequeue() to task lifecycle
In-Reply-To: <20260406114755.840497-1-arighi@nvidia.com>
References: <20260406114755.840497-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> sched_ext: Documentation: Add ops.dequeue() to task lifecycle

Applied to sched_ext/for-7.1 with Emil's Reviewed-by added and the
Fixes: tag dropped per his comment.

Thanks.

--
tejun
