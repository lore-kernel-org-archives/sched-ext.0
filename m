Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC872D780A;
	Mon, 13 Oct 2025 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381626; cv=none; b=Md3VhlD3/HPBF+UYexYlQwGZK0yllyuWKleCuvcfpZrmRDgY6jRZnpJhVHlG3LkIj56rVNsEFaocreXrUpNlEtrfSE2whrA46D1RTUek6cDHJZry6DVTwH8v4PsQKLmRD53D84oeaEmqjTKlOT83FNUO6iw5YEoNG5MfY1u8oeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381626; c=relaxed/simple;
	bh=wgHs/bx7/W6rrOaxhoN0JIIBZi5fMF82kbFYl5rNQLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lorApCripjfDHiO/flCHxsNfZrDU48X5AxfDzagqVz3XG0oOJ1U3cxV2sUNAiFsYdOqqGm9BNXj3x12qWg7o6oFquB/uWKPM9WVLsKPh3Tx1gRq4EmPxVL9VRZ2rP5Zup4gsFFMEuNuU5wE8Z/p1SIVX1CVtZRFcIhWH+gugJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrEL3j+L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrEL3j+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EEBC4CEE7;
	Mon, 13 Oct 2025 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760381626;
	bh=wgHs/bx7/W6rrOaxhoN0JIIBZi5fMF82kbFYl5rNQLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RrEL3j+LTabJgHWwbbCsg9y+ApEKWkuafAESdg+C+F237MM8J/LAIOU3LARXHpfah
	 HW4eD+aFiz6n1aP5lK4rBEn/xZmugS9eMRyYLT6QDE3bMsXUez5G3Z0tNW/LaYUWgl
	 EgnEC/WpVF9e1gi7cSYwhFxRadyBg+xr6booSzre5KQIJfJIW2YXd36JySQ8EuU1Ao
	 dgb8XPrxtIAx4tlvnB4O4rjWCQrzy09FWOow2z41Zzp5mzU56a0LjJ4F28kcVbaKYd
	 mKAN+FXI5J6QHdZMRGKyKpWVAWE4pEuwPTTRPBb0BLKJtl0AMbmCAvZ1pe4Y9jdqrC
	 EyoCLMduOYttg==
Date: Mon, 13 Oct 2025 08:53:45 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCHSET sched_ext/for-6.19] sched_ext: Misc changes with some
 prep patches for sub-sched support
Message-ID: <aO1KucWcGLQQORBt@slm.duckdns.org>
References: <20251007015147.2496026-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007015147.2496026-1-tj@kernel.org>

On Mon, Oct 06, 2025 at 03:51:43PM -1000, Tejun Heo wrote:
> Hello,
> 
> This patchset contains misc changes and some prep patches for future
> sub-scheduler support.
> 
> 0001-tools-sched_ext-Strip-compatibility-macros-for-cgrou.patch
> 0002-sched_ext-Add-scx_bpf_task_set_slice-and-scx_bpf_tas.patch
> 0003-sched_ext-Wrap-kfunc-args-in-struct-to-prepare-for-a.patch
> 0004-sched_ext-Make-scx_bpf_dsq_insert-return-bool.patch

Applied to sched_ext/for-6.19.

Thanks.

-- 
tejun
