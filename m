Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF06296BCA;
	Mon, 11 Aug 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931072; cv=none; b=sJjZmk9sJT7hQ+VyqEy7H/D9oYeEizRQrdKLEfYo/nnUwGWxDekcsd797KvXRh0FtqtYTW08eon1pHy/r4aecFOPRcEjz0bDfd3f+l7c1Qigu2wYBrXtqdThmVyy3FPWKD7rPePjdOm3xbtXpN0ayCqiRWWLMwAAGu5mcMqwUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931072; c=relaxed/simple;
	bh=ELJRrye4XmgHiNxU4wdyLCtAW++9gjCj4DicN+IUdHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqgOgqR98mH74PBdEdjJ6rmJD7bqOs7UBuPMOTjF+xTNl16p7Til8mjmYTvBo8jMzbHGVZZdFpaqdF0Skcem7Ra9TjZ0MClbrG3DKcwoR/xjjG4S1arsNwWamH05PcnBaVXfqLUlTSRmL7jr4ZhHPwqU5GXqMn92Z2nunEjhtTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRoRTh2u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRoRTh2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7449CC4CEED;
	Mon, 11 Aug 2025 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754931071;
	bh=ELJRrye4XmgHiNxU4wdyLCtAW++9gjCj4DicN+IUdHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRoRTh2u3XlEzucP7N1P+L5fIhmGFEFZwrCD9rBJ/dc5dOsyTttK1hxfyg3otDQSJ
	 xEMbsUy9UGhhNU2sXV4LpRBh5mTUq856ZFHK+bx8m/auXo7IcqrOCtkay2rb2pbTff
	 aR5+7ydCpQzfkZ/aDW9u7VFYmIoNdvrncY5VsDA3LmBFXT+0ohhNJb8ug/HzxF5qDR
	 bR2+VAthnOSQSHP/uNdahZ8x3VOj7Z8T2j6KgzvpJs6eQwMnFwr72n9n1zRTElWhyF
	 FJLEYYojLgcevZB8BzpAxOOho1pXiV0wnNY1NcLZgzwcTRcvagRsUZd2RSOo+2v7GW
	 WjITrjErVqbzw==
Date: Mon, 11 Aug 2025 06:51:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Jake Hillion <jake@hillion.co.uk>
Cc: Andrea Righi <arighi@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>, void@manifault.com,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	changwoo@igalia.com, hodgesd@meta.com, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v3 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
Message-ID: <aJoffsJn0tbJrwcs@slm.duckdns.org>
References: <20250805111036.130121-1-christian.loehle@arm.com>
 <20250805111036.130121-4-christian.loehle@arm.com>
 <aJebkj-neVJNKEJ4@slm.duckdns.org>
 <aJh6BWX7rYCNrzGu@gpd4>
 <y23etey3foin5nrxgj6e4g373b3ap6oxqa5rrvuvwyus3umw5s@bgh3d6uuga5t>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y23etey3foin5nrxgj6e4g373b3ap6oxqa5rrvuvwyus3umw5s@bgh3d6uuga5t>

On Mon, Aug 11, 2025 at 03:35:05PM +0100, Jake Hillion wrote:
> On Sun, Aug 10, 2025 at 12:52:53PM +0200, Andrea Righi wrote:
> > Yeah, this is not nice, but they would be still broken though, in PATCH 1/3
> > we force schedulers to check for NULL and, if they don't, the verifier
> > won't be happy, so this already breaks existing binaries.
> 
> I ran some testing on the sched_ext for-next branch, and scx_cosmos is
> breaking in cosmos_init including the latest changes. I believe it kicks
> off a timer in init, which indirectly calls
> `scx_bpf_cpu_rq(cpu)->curr->flags & PF_IDLE`. This should be NULL
> checked, but old binaries breaking is pretty inconvenient for new users.
> 
> As Andrea says, this is the already merged patch triggering this.

Lemme revert that. I don't think we should introduce breaking changes
without grace period.

Thanks.

-- 
tejun
