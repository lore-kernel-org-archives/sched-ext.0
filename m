Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F404F5E0;
	Wed,  3 Sep 2025 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756933061; cv=none; b=t1UDyKmU8dn3b7foOCkVSBNz4n/qljO/3LUonVMnrPzqYZ2wiFw0kCHeQ3GDaFNunvSYJGaJ++rLzAD4Ojwh68itNIxZl1H00iwv0r3duRIiGy7yB7WyO1UKzSYOSp7V9lUptQA0O0ULONiMfPoKj0RAOzhzIgEIy7a1NJ/XcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756933061; c=relaxed/simple;
	bh=f/KWYTA/DxpHnAzgn5OQod2RUCvIH1M7xETk4wmHHkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsleCHcj+ZL7PGkTemsTdPU0h3LRI9C10xjKKdFbrDTn2wshTGvoBcrnY391GK3/f4QxJDnc+4MhKVfHEXK/6hrVSeL6lCX5aMFiZBPymI9ExebX85xNUbfba0l9k9mZ4C+JO7iVnZUYMIhuBjZt0q9je/zPC2Z+lqOOJ4g/ecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji1YyKyg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji1YyKyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F0EC4CEE7;
	Wed,  3 Sep 2025 20:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756933060;
	bh=f/KWYTA/DxpHnAzgn5OQod2RUCvIH1M7xETk4wmHHkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ji1YyKygbp0FQk0KAUrs6L8RptQPsE1zLNHBMQRQKXDHoZ6NpuJnIQyKV7WK9moXS
	 Ip35U2v7OzpXdAPJqvgN7Zr/xc8PNtNEFH0x3iV8JpFg5g6WCR9zwUFwcaQTaKviqv
	 Hv5m5j5BlGVSjyeQCWT484PCz0iFAtRCP9HSoqlVwVJ9yQHIK2fIEIinqmPLNpT8xY
	 MXx/jiDJgnriHGyDoPMLJnm/VEo/J+0WCQs3QFWH4/HSAN2NPiKrmtgKouyf1kSbru
	 +dO3VBscSvggsNyGI2aA81S20V8jJVJx4C9OAwvpxRBI9GTHASR66wOHWTKY49aZRl
	 FKkBAz25lEMXQ==
Date: Wed, 3 Sep 2025 10:57:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Use cgroup_lock/unlock()
 to synchronize against cgroup operations
Message-ID: <aLirwysOBpAGubIy@slm.duckdns.org>
References: <aLeANmpO03QiPgSX@slm.duckdns.org>
 <aLg4SsZHY66n3Vi2@gpd4>
 <aLhvUpkanqxNHyZe@slm.duckdns.org>
 <aLipid4JRKEac1bS@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLipid4JRKEac1bS@gpd4>

On Wed, Sep 03, 2025 at 10:48:09PM +0200, Andrea Righi wrote:
> On Wed, Sep 03, 2025 at 06:39:46AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Wed, Sep 03, 2025 at 02:44:58PM +0200, Andrea Righi wrote:
> > > >  static void scx_cgroup_lock(void)
> > > >  {
> > > > -	percpu_down_write(&scx_cgroup_rwsem);
> > > > +	percpu_down_write(&scx_cgroup_ops_rwsem);
> > > > +	cgroup_lock();
> > > >  }
> > > 
> > > Shouldn't we acquire cgroup_lock() before scx_cgroup_ops_rwsem to avoid
> > > a potential AB-BA deadlock?
> > 
> > There's no existing ordering between the two locks, so any order should be
> > safe. The reason why I put it in this particular order is because any
> > cgroup_lock() holder has no reason to grab ops_rwsem now or in the future
> > while the opposite direction is still unlikely but theoretically more
> > possible.
> 
> Isn't scx_group_set_weight() called with cgroup_mutex held? In this case
> the order is cgroup_lock() -> scx_cgroup_ops_rwsem, or am I missing
> something?

Oh, no, cgroup_lock() is only held for operations that change the cgroup
hierarchy - cgroup creation, deletion, controller enable/disable, task
migration and so on. Writes to control knobs doesn't acquire cgroup_lock().

Thanks.

-- 
tejun
