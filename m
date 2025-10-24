Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E42D4B4B;
	Fri, 24 Oct 2025 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761344830; cv=none; b=QsxPMh1LuYQISrTdn1zXFD1nU7Gk/sNjc7U4TICncUdPbMBaG0W+ZfRTHjwqQRjt02EYwrSVpfmMf4rPxH2p5Fy2L+paH32k6we3aLokuUESaStGG92K+INJYLq7qCXZqvcdifqviZI+o/fT9IdCwUtIUV0mKrfLaRqMsY7HEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761344830; c=relaxed/simple;
	bh=P0JOGPiW4WGWHT0Vm0W96zgmiSISxAEZfrnCs4PAoCk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Q1vRdjH1IUlPofPlOyMQHYKW4LgIUawwyG/MSWjcRRqbjauqEz1ERL8ZF1NSMb1ga8CskrDSUI4YZ+mr3ovAA6uhWobjqSa42By2rJLtuLvA2x9nnN8BvO5HR85JkTecQpyThGJo+J7Ih1lksMJFuHZtz2dU3X3b+zYA9N+Utjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8DBnfyU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8DBnfyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28926C4CEF1;
	Fri, 24 Oct 2025 22:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761344828;
	bh=P0JOGPiW4WGWHT0Vm0W96zgmiSISxAEZfrnCs4PAoCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N8DBnfyUYuy1bF2lYOX5lhKtAli2Zq5IrUl0ut0yyRNeGlJT+2ReId9cGk7ylNs9f
	 B4nYC+G8FDkgpdYDfemKELwhJOawzG6nt4upWnZwWRf9o5IOf4U3u2U+mJt5JuCCJi
	 qiwT8lYsYdANC6kJs73DqDHEGK/WrHFyz7mfce6ljfDEgyq8z6Bwze94X9rmKsDpRe
	 aqvyC9dJ3gxnRIhUzihST8DjoOXwjTGiBvRYJ9wXxkn3GnVScTyTGz/u74OKy553gO
	 /IAR1wBcdfWS9xjby54u8b9FsULXytzN8EhjH+BVZB+UEmLCYXj7G2ZtAv1v0YW6cJ
	 cVUX5+xQdevKg==
Date: Fri, 24 Oct 2025 12:27:07 -1000
Message-ID: <5046d156f3991d7d8cbc0bc18401df85@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Ryan Newton <newton@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Fix scx_bpf_dsq_peek() with FIFO DSQs
In-Reply-To: <20251024220102.1556384-1-arighi@nvidia.com>
References: <20251024220102.1556384-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Andrea Righi (1):
>   sched_ext: Fix scx_bpf_dsq_peek() with FIFO DSQs

Applied to sched_ext/for-6.19.

Thanks.
--
tejun
