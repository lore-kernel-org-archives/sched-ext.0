Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E8322C73;
	Tue, 10 Feb 2026 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770767680; cv=none; b=s+WlKpUvikt5h/NVl7YVorb4kkyXwiCT/9CpwObQd7YthNj6y/QxV10pvGqLFl1fCIjRFVhG/lxSghPzSRB6LDxBIhZBhmFfwmWyxiiljkPFeqghYr7Zug7IHuTD+kSxSydkdy7PzHStboP0g5ZOAkwoxEivJLZKEPO5DM6seCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770767680; c=relaxed/simple;
	bh=Mr+wFX9eNldoiIQyoF7xkBtFIRX1Gg/MG23I+GZ3NtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXXTLJkQH5LCMqXibFI1Jybn2JhODmXcGT/nIyAyhwHjGaKlZV/tXKun1UbrOZqa0UpC+5sIS2olf6zjQ2FHljsPK+3kA4YJF8AnvIKK982CTttPIb3EMcwWytnV9w1JpoKRiMxO7ev+YdZteGjvOxFool0a28Cc/jXOQwV3Klc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYKqTRlH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYKqTRlH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53D4C116C6;
	Tue, 10 Feb 2026 23:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770767680;
	bh=Mr+wFX9eNldoiIQyoF7xkBtFIRX1Gg/MG23I+GZ3NtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYKqTRlHCjjM1sCjRWoA1Eapv5WXDw8kaup5uxjnKpewDNuM1mKH1VjnYUJqP4ub5
	 rRmqVCD9U+/vh8mis/Ub8pWruhBH3Wrfpb0Ge+5pwm/drVFZVutGxCj7s1Yx1TlObX
	 5PjGJNnRLxsnbCTv2HaWN3OvDPf6+vYph4VCpKgcdg/NUHqeSguh7/BvMGGNNFlB1E
	 e5osO/FWft77IbI0CmrDt7zofBLJiXiwYuz2wkXSbK1gMJNHB+6ar1bujeat5PTPJU
	 K/38g8vu2JQKCn6/tArdJrc1rscO5H6Jf2Q2G72J1LuSTGbi1ko05vipfEsMPUUPsp
	 kG4vYee+Pkesg==
Date: Tue, 10 Feb 2026 13:54:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYvFP4T-TQHuez3X@slm.duckdns.org>
References: <20260210212813.796548-1-arighi@nvidia.com>
 <20260210212813.796548-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210212813.796548-2-arighi@nvidia.com>

One more comment.

On Tue, Feb 10, 2026 at 10:26:04PM +0100, Andrea Righi wrote:
> @@ -1407,13 +1446,19 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	 * dequeue may be waiting. The store_release matches their load_acquire.
>  	 */
>  	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED | qseq);
> +
> +	/*
> +	 * Task is now in BPF scheduler's custody. Set %SCX_TASK_IN_CUSTODY
> +	 * so ops.dequeue() is called when it leaves custody.
> +	 */
> +	p->scx.flags |= SCX_TASK_IN_CUSTODY;

As this is protected by task's rq lock, doing it here is okay but can you
move this above atomic_long_set_release()? That's conceptually more
straightforward as that set_release() is supposed to be the "I'm done with
this task" point.

Thanks.

-- 
tejun
