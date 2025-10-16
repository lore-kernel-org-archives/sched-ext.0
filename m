Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B8149C6F
	for <sched-ext@lists.linux.dev>; Thu, 16 Oct 2025 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639706; cv=none; b=c3EkTtoFYj4is6LdPnpAlE+wSRjEk6a22TEFQZgwpkKGtBgn4yz7p+/6L1A67MPBGF//n5AUB+y1dC8AzSj2WJ7JJXeFk5BPt9LJ8VkZRFgsUEY7kk/CFk/1lNHc5pJSp0rOATT7mlSS3mlad738CUsIacgLx4yJ4AmXyGXOyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639706; c=relaxed/simple;
	bh=y2+5SG9GIw6IyhWFSZpZ4hSJ3R2tOMjEeJFQyJs4W/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WejZcuozbZDJZtho0L64JLJEr1iesAyWfJmXPmZ9rvrm8D096U9ffMcZamnhmMh0Jay8/HYHXeZKKhk1DD+WbWVEAjyTl50bTBWljPRzCKe5hxPJf6oXVHJHiEdhtN5UzDnc9rP6WebeIWUnN2TO3MoplnKVUcwqHeyln6j5dC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPts5YVZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPts5YVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B305C4CEF1;
	Thu, 16 Oct 2025 18:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760639706;
	bh=y2+5SG9GIw6IyhWFSZpZ4hSJ3R2tOMjEeJFQyJs4W/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPts5YVZS0pQ1kXcux5ttf+d8pbjc3WaxXbOaPoBDKsB5CGztObN9X67kXvHF2xna
	 mbOLa/0ly5t/nv3oSLEKauHMUv8QMBRFwcTJn4AbHSNgDRlnM1eOzwT+Nb01wQMlAZ
	 DGXyFK2C8EsIkMMx68mOjDdjacZlVAfqeuUiV+l9OAenPvrKoOe87u8oaEgIuOiy7J
	 iQkmKCIiSxhhMibzTcdj/amqW5pLqv9h0H5WfRxwUR71xyN5cRc/eruoFimjqFKk2p
	 PxWUAeuzpMRzdcNBZoxgA4FG5VHdnNbaQiXjmRIMe6ykNFnhxHPX2Tg4CFcfyKONwj
	 +wzF1myuxGmoA==
Date: Thu, 16 Oct 2025 08:35:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <etsal@meta.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: fix flag check for deferred callbacks
Message-ID: <aPE62NqS6MWkJfyv@slm.duckdns.org>
References: <20251016181125.1482502-2-etsal@meta.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016181125.1482502-2-etsal@meta.com>

On Thu, Oct 16, 2025 at 11:11:26AM -0700, Emil Tsalapatis wrote:
> When scheduling the deferred balance callbacks, check SCX_RQ_BAL_CB_PENDING
> instead of SCX_RQ_BAL_PENDING. This way schedule_deferred() properly tests
> whether there is already a pending request for queue_balance_callback() to
> be invoked at the end of .balance().
> 
> Fixes: a8ad873113d3 ("sched_ext: defer queue_balance_callback() until after ops.dispatch")
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Applied to sched_ext/for-6.18-fixes.

Thanks.

-- 
tejun
