Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2F84315A;
	Mon, 11 Aug 2025 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932109; cv=none; b=bNehGSGUa4EZ20PsuVE2G6CvyLHfIXw+p7ntuepTrihU5A5yJhDxU+5k8zjk/EVxS3NbSOFJvYGJ+6yGhxjO6h9t/ahyfFUfDeKyWMsChevAdBdgINjozDbcbrH/y/yvyrsERrJEc6uf14CCxwmiTUvK8X3fC5LuqwkDRJFup0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932109; c=relaxed/simple;
	bh=Cfd4uOaakFu71BLj4bWH0zH9dw3qu+n89q2tGbiG6Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3cMXWnYYmtvUFA3Ckcg8yK4fh7D3RGjJqZkXSKyhoFofg/Ly4Am2grcBJthlAAPgSJ2wNToOH6KkYO/ynj9hCwaGAnSVhpe0oe/F10inG+pZjMkoXbb/RdVHGrdpHw7yi/GRWUGDEZIgp2fqCkjnwWQ+wYZNSjdvDKlleSJFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUQPHby5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUQPHby5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0DFC4CEED;
	Mon, 11 Aug 2025 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754932108;
	bh=Cfd4uOaakFu71BLj4bWH0zH9dw3qu+n89q2tGbiG6Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUQPHby5gwLeLdKNjaHFpxSBJTx9Qo4yq/kqG7Wa/D6ITBUGGEYn2nf3Y6tLy3Cg8
	 qhEmwbRsio3lAnI/vczf8hLyPqh1GK5bwlEBH9f4BSg9FEuc0aSzQDH9qBKhnBD93T
	 Uhx0aLRTjsoLV6PwwEQWCHaTuFDxRwSoCLre4iE35JoSv7bjSSsFVug/CAYq+PDxci
	 sBvqNXa1PN37yE+uw7MsGf0XJxmv09GWIof2TeS4UCiNaKTBkPhw6kuMU18Q2r2bAa
	 X6pFI0rMWidPriqi9qVytuu1fbBGFoZs5+SAl/cHsN2r8xDUakspbfgXHzfhqooW1N
	 0DYB1RV/aS8Ig==
Date: Mon, 11 Aug 2025 07:08:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: arighi@nvidia.com, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v3 2/3] sched_ext: Provide
 scx_bpf_task_acquire_remote_curr()
Message-ID: <aJoji6OmdoJyfpbc@slm.duckdns.org>
References: <20250805111036.130121-1-christian.loehle@arm.com>
 <20250805111036.130121-3-christian.loehle@arm.com>
 <aJea_sEq9pRWgShm@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJea_sEq9pRWgShm@slm.duckdns.org>

On Sat, Aug 09, 2025 at 09:01:18AM -1000, Tejun Heo wrote:
> On Tue, Aug 05, 2025 at 12:10:35PM +0100, Christian Loehle wrote:
> > Provide scx_bpf_task_acquire_remote_curr() as a way for scx schedulers
> > to check the curr task of a remote rq without assuming its lock is
> > held.
> > 
> > Many scx schedulers make use of scx_bpf_cpu_rq() to check a remote curr
> > (e.g. to see if it should be preempted). This is problematic because
> > scx_bpf_cpu_rq() provides access to all fields of struct rq, most of
> > which aren't safe to use without holding the associated rq lock.
> > 
> > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> 
> Applied 1-2 to sched_ext/for-6.17-fixes.

Reverted due to compatibility issues. Let's try again with warnings as
discussed in the other subthread.

Thanks.

-- 
tejun
