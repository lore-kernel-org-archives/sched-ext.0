Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909E1643B;
	Sun,  8 Mar 2026 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772929187; cv=none; b=azD5B7EqeknGFKZyLhE2TtNH9+URLB6dILJOeeFSDGLGAEv0z/MMZhN7a/DsF0axwyYKuyv2XdQYJawH/fZZuU6dtFHxTMsdtS81rtkoA2AWVJ2ESREej9j7KJydjTXuEUQ9va1DU+6idehthQcda5CqqP253jTL0tGAVtRgHzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772929187; c=relaxed/simple;
	bh=vMgZXIg6P6xY0MeriolN0qkP7axZCIZRzFdvMsrkQN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALLCOXTCBNHiqEMzd5hI3UIvxeVBLpHWUq0S9D1atqxFzjDZK6BAwvY+KSp0Si+SCnVbQVT4xo+Qtq6h4kw6QAQm5jptdjEFYeCjvxKtEnKTjm4gg/mNyPIBBaeSN06TEqrDSqAPQlVLBNIZvwwyF83S+Ta1HhGcCIHW4DZRsLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv0tdRKn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv0tdRKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0821C19422;
	Sun,  8 Mar 2026 00:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772929187;
	bh=vMgZXIg6P6xY0MeriolN0qkP7axZCIZRzFdvMsrkQN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nv0tdRKny5Jsdp0C6DXi6ltsu9bI0P7Hu1U+cCjEFcT5vL+WbWATO2Ptz44nnfQQ1
	 HNwyIB5l5Tvkv/fTkKxN6nFAn6yHhqhEXaWBsthgk9XtdYzsB4Tdd99KqKUwY62DFc
	 WClYSynLs/5yuwkdYQj5SPiYMMFf1uOZkF6K2C4x3yC+YjRNz1Jg3p8VXdkExHStIi
	 MG9T0FuhIZPW4IGba/xnRMvA+RzBVlyCp7l3fk9G6OuRsL6vui0cb2NKGOrhrFMhax
	 TZxaOwjW4bboxlPYmhmYFGzBG2XZPH6zxCjb5XU+hqyVWy8uNC/mp3wr1FrzzMLb9X
	 RtFc48MGKOUjA==
Date: Sat, 7 Mar 2026 14:19:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1] sched_ext: Implement SCX_ENQ_IMMED
Message-ID: <aazAou_Tak-yGYZI@slm.duckdns.org>
References: <20260307002817.1298341-1-tj@kernel.org>
 <aayofhyFFX9jng1h@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aayofhyFFX9jng1h@gpd4>

Hello,

On Sat, Mar 07, 2026 at 11:36:46PM +0100, Andrea Righi wrote:
> This looks interesting, but I'm trying to understand the typical use case
> of this feature.
> 
> I agree that we need some kernel support to "atomically" determine when a
> CPU is available (it can't be done fully in BPF). Initially I thought the
> main target for ENQ_IMMED was to improve latency-sensitive workloads, but
> this actually hurts latency, due to the additional re-enqueue cost and in
> this case it might be better to be "less perfect" and not use ENQ_IMMED.

I don't see how it'd worsen latency. You atomically get the CPU or not. If
you don't, the only thing you can do is reenqueueing to find an alternate
cpu if available. If you don't do that, the task would end up waiting for
the CPU which is now busy doing something else to open up in the local DSQ.

Thanks.

-- 
tejun
