Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE224A069;
	Tue, 23 Sep 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643188; cv=none; b=udrtayoZbksHOkKMvkvzaZaTzx2RjdRkcpybsx1HHUxJyM3/UTOIh1ttGK7V3WvJQQCOk3qK/HdL4tyIFCxJ6ROH3NTwgUAfZPsMKhRGcML112ajpyEZbchPOE4tUqU4c+r/JIiK7a67Ao2rq3WBtssKcR4zd7cJ8eEL3poRX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643188; c=relaxed/simple;
	bh=OPABmEyGnPQSyBcbY7LSpv4rtdz/RSrpokDjOltAltg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgCpC5FmXuTjQ06pNpD+kQFm2iPD8gjng3ceDhuD2MsDy/3KpTaWRqH6Om3ypGYjS+EB9qT5TemLiF+UmENCcQAUQha30Qzo8UfvBV1MfsZhsVkQ/W7digomFVMavL0bo7McmCK8NBwtfabO20BiULUWwfWhLXmp3QKGY4NYFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hg3YGxM8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg3YGxM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B00EC4CEF5;
	Tue, 23 Sep 2025 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758643188;
	bh=OPABmEyGnPQSyBcbY7LSpv4rtdz/RSrpokDjOltAltg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hg3YGxM81QvBOiXohQm5qIxWkA81n17wfKrZKDXMf05gmyR9iy8bkWVtKsyrSZFh9
	 FFKhjfbO4fWOLwfloqztLxvg9Rm0eGEfAl5DIGKKMxSmDKa6c0DpDcACp7YysZhD//
	 5jjZY8IyKui2v38+zTvikMtTqUoD9b8iA9EWVvC8aOHtOfIHICRSzmTs/APSyCAfjy
	 3EHkTriU6lEzYFCsBtxRQAdBhbX/R6QnlnKWNUK78MkDhp3nTKejQtBxvy1zoJq/dW
	 iaKobMg/GWXs8QB1JifO2BgmoMQcG13cVFFczgrJxZ8IRhtSo9J/ppFgQQL5ys8h2L
	 pq3BE2FBBuIBQ==
Date: Tue, 23 Sep 2025 05:59:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/7] sched_ext: Use rhashtable_lookup() instead of
 rhashtable_lookup_fast()
Message-ID: <aNLD8w2ZILVbERwG@slm.duckdns.org>
References: <20250922013246.275031-1-tj@kernel.org>
 <aNJJydxk8ItUpBJd@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNJJydxk8ItUpBJd@gpd4>

On Tue, Sep 23, 2025 at 09:18:33AM +0200, Andrea Righi wrote:
> Hi Tejun,
> 
> On Sun, Sep 21, 2025 at 03:32:40PM -1000, Tejun Heo wrote:
> > The find_user_dsq() function is called from contexts that are already
> > under RCU read lock protection. Switch from rhashtable_lookup_fast() to
> > rhashtable_lookup() to avoid redundant RCU locking.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  kernel/sched/ext.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index f5873f8ed669..df433f6fab4b 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -207,7 +207,7 @@ static struct scx_dispatch_q *find_global_dsq(struct task_struct *p)
> >  
> >  static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
> >  {
> 
> Maybe we should add a WARN_ON_ONCE(!rcu_read_lock_held()) to make sure the
> assumption is correct and catch potential non RCU read locked usage in the
> future?

rhashtable_lookup() already has that as it uses rcu_dereference_check()
internally.

Thanks.

-- 
tejun
