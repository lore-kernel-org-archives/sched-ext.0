Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1094D389449;
	Mon,  9 Feb 2026 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658132; cv=none; b=jlxeAJHdXnA7Hs+aG6ocKDXCAZgvzm+GqzVxxeSoJkeci+YOVpYoUg2H35Do98sKghuBTMujfeXRIm4G0VnFPkrcsBo0EmD5BCSJAcwrVkNRANZXO5M9AXPhtkIglTutwwT6XKqMSgFj9XN0zHYKdn8tS/mOtlnIElZzylNFAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658132; c=relaxed/simple;
	bh=r5paYUan2KCbIbx7qF7TvehPLnQsRcqoX092y0UionU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pazx5vIet5XtSspdWRE1xurNhZt1ZHgev6+tUyrJI3lW38tVBd1Yae+fdcQ/Wp5IX0/AhH2IdAcnAMqY/j7WxVnhEc0koXlWNeCrdZ6HXZPNtlW1hN1926FaOsWb1poGBSFhBavp80FJ6ncLxhca3K7c+JeRZKQNWb9ncYLMoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj8A7hM2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj8A7hM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E3EC116C6;
	Mon,  9 Feb 2026 17:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770658131;
	bh=r5paYUan2KCbIbx7qF7TvehPLnQsRcqoX092y0UionU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uj8A7hM21D5ydu6qQns8GSIO6QGVcy06D2DRiVqL3zSNlZ4nu3Y6RIxcbY1xI5od4
	 GcG8Qn3H0vvZV/KzpBIYs/49xrQ1K9Yjqh1JcSyZl/sWFuSDQo1986u90hFslSCBmy
	 hoUkq5+hk4UO5atWm4VWmeFCD3/cpeawR81TBipFNrOBkuQf9GDi5/zGr7x04tSQ+z
	 5XRMb0JHimL5h0X+JUFSiK0tJJIib6T0L0K2E9jcYtE4DcWWMeEaQBHvQd6e+GlKvJ
	 QhxfN81cwLF+s1tanomOSkam9RDJDetyNbS01f5Ib4YHSyuZk5YZ67Afnn2YQWD8ER
	 J1J1y7Uyj72Gw==
Date: Mon, 9 Feb 2026 07:28:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYoZUoyKCxk2bYiy@slm.duckdns.org>
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-2-arighi@nvidia.com>
 <DG860JW64VVD.31BS2QTEB8XZQ@etsalapatis.com>
 <aYcFOVlJhUU5huNd@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYcFOVlJhUU5huNd@gpd4>

On Sat, Feb 07, 2026 at 10:26:17AM +0100, Andrea Righi wrote:
> Hi Emil,
> 
> On Fri, Feb 06, 2026 at 03:35:34PM -0500, Emil Tsalapatis wrote:
> > On Fri Feb 6, 2026 at 8:54 AM EST, Andrea Righi wrote:
> ...
> > > diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> > > index bcb962d5ee7d8..c48f818eee9b8 100644
> > > --- a/include/linux/sched/ext.h
> > > +++ b/include/linux/sched/ext.h
> > > @@ -84,6 +84,7 @@ struct scx_dispatch_q {
> > >  /* scx_entity.flags */
> > >  enum scx_ent_flags {
> > >  	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
> > > +	SCX_TASK_NEED_DEQ	= 1 << 1, /* in BPF custody, needs ops.dequeue() when leaving */
> > 
> > Can we make this "SCX_TASK_IN_BPF"? Since we've now defined what it means to be
> > in BPF custody vs the core scx scheduler (terminal DSQs) this is a more
> > general property that can be useful to check in the future. An example:
> > We can now assert that a task's BPF state is consistent with its actual 
> > kernel state when using BPF-based data structures to manage tasks.
> 
> Ack. I like SCX_TASK_IN_BPF and I also like the idea of resuing the flag
> for other purposes. It can be helpful for debugging as well.

One problem with the name is that when a task is in the BPF scheduler's
custody, it can be still be on the kernel side in a DSQ or can be on the BPF
side on a BPF data structure. This is currently distinguished by SCX_OPSS
state (queued on the ops side or not). We do say things like "the task is in
BPF" to note that the task is not on a DSQ but in BPF proper, so I think
SCX_TASK_IN_BPF can become confusing.

I don't know what the right name is. When we write it out, we say "in BPF
sched's custody" where "BPF sched" means the whole SCX scheduler. Maybe just
SCX_TASK_IN_CUSTODY?

Thanks.

-- 
tejun
