Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835B3750CF
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774524181; cv=none; b=QvM7wswfD2Dg6bfQgpaM/Jw7lwSmABlc7tmecHtYodVbcJ7Ng8qajrhxawBbCZekWq/7ccyCJzenVTnkxqRLE2rfeBV6FE11iesTLglSlyXoH7CPuRLp/j60o1T24h7dRJ2vXooauLQhUyPecWMSa6hxJKjgn0iSST94TDwr46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774524181; c=relaxed/simple;
	bh=s4qlCKqQQTakSE1LVh72i3q0E8rhe6HdHBgK/H3l8wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnFOxqLmmoWsGbzGXj6DFPBj+HrrKDekbLQU8ezDvZJieer9Q7WEw1SYNS4j57NOGRHr8nfRn8kVUFPAiqU7K+KPzB/trtH0pw6hBeNvDe70nTQpgkH3Ib4yxRyd2e3TH8MD6QY9fruKCT/CRTSoOIyN4GRhzF3Bau0ohrjRkqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USB5T+id; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USB5T+id"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F51C19423;
	Thu, 26 Mar 2026 11:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774524180;
	bh=s4qlCKqQQTakSE1LVh72i3q0E8rhe6HdHBgK/H3l8wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USB5T+idQrtQfnecV79ZSXO4inYF5qgZlS8xkP5g6eVb+CXmcDFUxJ1XJrmp5RSEU
	 Iq8XPjzfaTz1eF2F2BHEtF1+e1ySnQ/csMNEu8nrOw5J4n7jgla4fazZeCcqbBqyqK
	 yilOtMFTuGMdn/GgwYE59MUkPTQuL/iWHTJhYSukXUxYCQWkgWZk1X/zerSv53KAYD
	 uxGPbw0agPFAt8sHmlgC+ZDe107IFX7n71tWvtZkJopOJHFW8lt0VksjYJcIecQoW3
	 kCf2d5Myn3OjLAAAmmbZyrU1HqQHVjySBIPrhbWvDJd1wyY07s2gT1IzDKqA+pzv30
	 xlxnNkwBWK5GQ==
Date: Thu, 26 Mar 2026 01:22:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: Fix scx_bpf_dsq_move_to_local___v2() to
 handle SCX_DSQ_GLOBAL
Message-ID: <acUXEy9NUVMb40Lh@slm.duckdns.org>
References: <20260326091756.816828-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326091756.816828-1-yphbchou0911@gmail.com>

On Thu, Mar 26, 2026 at 05:17:30PM +0800, Cheng-Yang Chou wrote:
> scx_bpf_dsq_move_to_local___v2() called find_user_dsq() for all dsq_id
> values, but find_user_dsq() only searches the rhashtable of user-created
> DSQs. SCX_DSQ_GLOBAL is a builtin DSQ stored in the per-node pnode and
> not in the rhashtable, so passing SCX_DSQ_GLOBAL caused find_user_dsq()
> to return NULL, triggering scx_error() and aborting the scheduler.
> 
> Add an explicit check for SCX_DSQ_GLOBAL and use find_global_dsq() in
> that case, matching the pattern used in find_dsq_for_dispatch().

This is intentional. Both global and local DSQs are terminal and don't
provide interface for direct control once tasks are queued.

Thanks.

-- 
tejun
