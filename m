Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95F4CB5B;
	Tue, 23 Sep 2025 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654796; cv=none; b=Yo7RsT4oWRgnK4iGvNYOtO4Wp0inqd2Dd1MtPZHBMdroQglBIJOCMymbGF2var4K8ZzpNlGMuUn+fFTycyK+kKV/k83ivp/9QT4BPdq4qpIhRXzgQ/mwvc0AYxaYui7k51RgOJkPT1RXshiphYHaBNyWzK4ThTOcsG9g9ME/h+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654796; c=relaxed/simple;
	bh=62nJ+GaD6RlaE8RKcQvGW4mnf6A/9qPq6WTajHxYmHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJe5sajlgxSnAu3MVN24Xrn4YIGk275rjh+iLIV4hdY5O9g3uEgH9fbaHV2BQ5geUJ4dONlLRUQ20VgYuqvOGBsyKICEGmMZyrrCTH04+n533x79hNxeg5Rw+Moyg7+BW2JalJZWBEO4kcg948MZAOwgGMbh+zOBwNULsKkMjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyo3gMrH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyo3gMrH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C6CC4CEF5;
	Tue, 23 Sep 2025 19:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654795;
	bh=62nJ+GaD6RlaE8RKcQvGW4mnf6A/9qPq6WTajHxYmHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyo3gMrHxwAZxRcnOCcL1ErEg5FVlJtVTBWkSPcX4wSuTY8DQGFXZPVSHVjtgG/mh
	 gCSVHdSZ4AEXjpvoMdkOlw0Rg0psqji0ZXurzSJQSt01FEoeKDJi6m7HEQ8+Xbgpij
	 8tIGf0rYSqOK8FOMhr+eldySXJhXQf0osvmO5V+fopOldjx1QR4NCWwn2QW8MrxUky
	 3y5WNpRt3aFreWV/3juezjnfytzpWIKCdg/Yx/1PukYpMPRc6wRThRQzxVDHCkYOpe
	 v7Vo54BaoofuxY79aIDwunB8KQWuZxRyCt8LX0ULRxALwgkpdsLCub7YW16XKL/eYS
	 LJfgNGD9ifP3w==
Date: Tue, 23 Sep 2025 09:13:13 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCHSET sched_ext/scx-misc-a] sched_ext: Add @sch parameter in
 preparation for multi-sched support
Message-ID: <aNLxSYPSX5pteEPZ@slm.duckdns.org>
References: <20250922161436.358949-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922161436.358949-1-tj@kernel.org>

On Mon, Sep 22, 2025 at 06:14:29AM -1000, Tejun Heo wrote:
> This patchset systematically adds the @sch parameter to various sched_ext
> functions in preparation for multiple scheduler support. This part is
> needed regardless of how the rest of the multiple scheduler patchset
> develops. The changes also remove a bunch of naked scx_root dereferences
> that trigger sparse warnings. The changes are mostly mechanical parameter
> additions without functional changes.
> 
> The patches are based on sched_ext/for-6.18 (ac6772e8bcda) +
> "sched_ext: misc cleanups and improvements"
> (http://lkml.kernel.org/r/20250922013246.275031-1-tj@kernel.org).
> 
>  1 sched_ext: Separate out scx_kick_cpu() and add @sch to it
>  2 sched_ext: Add the @sch parameter to __bstr_format()
>  3 sched_ext: Add the @sch parameter to ext_idle helpers
>  4 sched_ext: Drop kf_cpu_valid()
>  5 sched_ext: Add the @sch parameter to scx_dsq_insert_preamble/commit()
>  6 sched_ext: Drop scx_kf_exit() and scx_kf_error()
>  7 sched_ext: Misc updates around scx_sched instance pointer

Applied to sched_ext/for-6.18.

Thanks.

-- 
tejun
