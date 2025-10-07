Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C861EA7C6;
	Tue,  7 Oct 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860553; cv=none; b=EHuc5lIjBZ9PQwl2FKh5DOpMEtV+Xn5jvD/cU82srLJQhcaR9j3Kj8MDoqC5oM6s18T165eD0+iJJhw3RY8SbIcf9451O3UpwwVSonzq3utsaFxLun/hot1UbsyWoVQEAmRxKlafsh81hq0gsik0C1RmaKiX6iG4SgTILL0IzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860553; c=relaxed/simple;
	bh=UX+Nd8nJSBEFtATXulPAqG4aQn9E0J/BWbqh7t2nbOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz/UG3TVNm7fUYc3Qo4dqS1Hu/OwsaAZIHScQIIDPWt4jgFy50K9AYABXJb8dmKzkQUuchzCYEic9Nym6qzzhZ2jbkqgZGZLJiDgZy6HStb8fGIYA4sujhtSLyPHrOT0q20lYzaXaxgN2bCU9NeAcdqFL9wOQXmMVf79vf4OlSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nthb5xLr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nthb5xLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89E8C4CEFE;
	Tue,  7 Oct 2025 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759860553;
	bh=UX+Nd8nJSBEFtATXulPAqG4aQn9E0J/BWbqh7t2nbOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nthb5xLrrmh79shz5ZizuG6tbq7jbUjpchu6XMd3mGFk06ygWdRa4qOdDHBi0zCWR
	 jtlItiHkxPpUbhKV7oVa3PcAtKy31qxjSl/oqtk2fbEquAdmvO8f+h9fegKajvWmlA
	 Mbhoga7LlDc/j04BVDmdLGTlnz2kDZQuyfyQkyZJPlOpVmP+aYf110PnDmNw4mFjy7
	 xYXF7/fvRm/4LH7MmbR7evbjrZKWvS60Laz19LOe7jpD1oKlFlkm/QS/FseT/FcR2U
	 CAXt65/6P/QYXwk8u6mgg2dxY9pIvda8LTKcu7EkBycC8nkZ33i9jT5mIG7hExDs04
	 pHjcMVeXqqwiw==
Date: Tue, 7 Oct 2025 08:09:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <linux-lists@etsalapatis.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/4] sched_ext: Add scx_bpf_task_set_slice() and
 scx_bpf_task_set_dsq_vtime()
Message-ID: <aOVXR5sIPG_L8OLC@slm.duckdns.org>
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-3-tj@kernel.org>
 <CABFh=a7LA2MZHH-PeiDw_2VRdfqXbrimTsY=yeR7gsmg94doAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABFh=a7LA2MZHH-PeiDw_2VRdfqXbrimTsY=yeR7gsmg94doAA@mail.gmail.com>

Hello,

On Mon, Oct 06, 2025 at 10:56:45PM -0400, Emil Tsalapatis wrote:
> > +/**
> > + * scx_bpf_task_set_slice - Set task's time slice
> > + * @p: task of interest
> > + * @slice: time slice to set in nsecs
> > + *
> > + * Set @p's time slice to @slice. Returns %true on success, %false if the
> > + * calling scheduler doesn't have authority over @p.
> > + */
> > +__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
> > +{
> > +       p->scx.slice = slice;
> > +       return true;
> > +}
> > +
> 
> Q: Do we care about protecting slice/dsq_vtime these fields with a
> lock (e.g., to let them be atomically changed w/ other
> proc/DSQ state? If so, should we limit them with the kf_mask to be
> callable from specific BPF ops?

I think it'd be the calling BPF scheduler's responsibility to synchronize if
there are multiple writers. I don't think such scenarios are likely tho.
Schedulers almost always have clearly defined chain of custody for each
task. Also, there's nothing to synchronize on 64bit machines. These are
isolated writes (ie. adding locking doesn't change the possible outcomes).

Thanks.

-- 
tejun
