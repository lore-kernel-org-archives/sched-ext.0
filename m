Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEFE3570BA;
	Wed, 11 Feb 2026 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770849434; cv=none; b=uHrdhW3evkJYg5hRe0TdfPnWmTbx8kVja5Wkl+EIlS9DC7EOqCtgnYeQXOPPbDjtHZzFwH9HikCCwO79JMnmGkccVKBbM1B98TassIicOS4Vq2hVP+ZYGh292YDQ8mbyHLlDT/WqkN9699yjKFGaPbLZzf5pUZY0F7UAArLXKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770849434; c=relaxed/simple;
	bh=8vJ+H/ZQ76FHxaUk7zPWnPSXoJ2Z7lQuelVqmINcXcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBMo9NPimkgTeORzcGkVCnjVFEoxLOjZDNjjiq1pKQHBnlit7kOD7gb3KOC3F6ymPnX5pk1tDf7dnxj9brkGMF+3beJPBH/YcjuegfMQw6arAIiLR95R/dY0kJ5twIcAol+PblfU8px2JxZZtU3ACYjIz4HuzWWBEK8rHP3YkI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4LYdpfG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4LYdpfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EEBC16AAE;
	Wed, 11 Feb 2026 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770849434;
	bh=8vJ+H/ZQ76FHxaUk7zPWnPSXoJ2Z7lQuelVqmINcXcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4LYdpfG0lgDhodbCChfKDzFri4zctJh1CMNcvHq6YrfCqWN7wRNogjri/bxTiF1v
	 Aa+WkGdK8jLqIk7f/nF35znEaMxaxh3gR6TyYWzv+0uGICKNu0wwWLT/NJ8tBP+eMa
	 22tYlN+098jbyuLO8DeJq75kEpwKJP+aCf34zwtOj+OEwRap9J1/79sT/XYJY5C7H3
	 W/niVwkuiM/sogAIWFkI7NObwEA7VNI6qJYyMlxOu56/gzDzHFHIQapQ1gcRvAMDfV
	 OiU+jBvX9WeShf7LAU8jc3nBMAvfY47FlYZbEkZ4EsJEeZfNC2u8oYBCGtBUcD3Aqj
	 uuQiej+7u3FCw==
Date: Wed, 11 Feb 2026 12:37:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aY0EmUnmo4gGitcW@slm.duckdns.org>
References: <20260210212813.796548-1-arighi@nvidia.com>
 <20260210212813.796548-2-arighi@nvidia.com>
 <aYu9KzKTMfNIFDwD@slm.duckdns.org>
 <aYyo_ALV_BT6WaE0@gpd4>
 <aYzc7ZVkSrtdeHnA@slm.duckdns.org>
 <aY0EDpFD1FSrigB6@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY0EDpFD1FSrigB6@gpd4>

Hello,

On Wed, Feb 11, 2026 at 11:34:54PM +0100, Andrea Righi wrote:
> > The end result is about the same because whenever we migrate we're sending
> > it to the local DSQ of the destination CPU, so whether we generate the event
> > on deactivation of the source CPU or activation on the destination doesn't
> > make *whole* lot of difference. However, conceptually, migrations are
> > internal events. There isn't anything actionable for the BPF scheduler. The
> > reason why ops.dequeue() should be emitted is not because the task is
> > changing CPUs (which caused the deactivation) but the fact that it ends up
> > in a local DSQ afterwards. I think it'll be cleaner both conceptually and
> > code-wise to emit ops.dequeue() only from dispatch_enqueue() and dequeue
> > paths.
> 
> Does this include core scheduler migrations or just SCX-initiated
> migrations (move_remote_task_to_local_dsq())?
> 
> Because with core scheduler migrations we trigger ops.enqueue(), so we
> should also trigger ops.dequeue(). Or we need to send the task straight to
> local to prevent calling ops.enqueue().

I'm a bit lost. Can you elaborate on core scheduler migrations triggering
ops.enqueue()?

Thanks.

-- 
tejun
