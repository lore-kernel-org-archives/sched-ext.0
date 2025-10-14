Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5601A83F9;
	Tue, 14 Oct 2025 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473775; cv=none; b=c/uDd9YUMSCbpLC5mO/XGPOnwSs3KXF9yzrhhPiTJhCPT/8cyULo7CPKQMi88ttalnpffAoJVOOEtgqjPWJ3hsXX6Nf9bINsNshH0Yhdx+TF6X95I119UUPrGfPe5x4MMOJ2x8ieuAbqaFKBmxwzhnzbuwO9CvJGc783wN6Ec54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473775; c=relaxed/simple;
	bh=5jbs4l78BR2lm11sd8NglbRKKTewM4N5bbk9Ox/sn8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIKRZxaTRf8DDkx0TsL+L6Q32s+fydy2Z2P8DFiJO8qnHQLY9A7M4vjhCQgzXstGDhblayu7uAf733GrTTSJZW6EYgpRpL4LrlbFWjk1tSGPfSN8Trkb8IgWW2Uc3pnTmeNX7CCbSOMLmzK/RxLgAHSxgvsaOkb1rvgcRl9aoGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHOPAnEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHOPAnEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DF2C4CEE7;
	Tue, 14 Oct 2025 20:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760473774;
	bh=5jbs4l78BR2lm11sd8NglbRKKTewM4N5bbk9Ox/sn8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHOPAnEFU4fswgBE7tMtjhxZNUNvov3oC1zcwNyQC/jOlXXyoYjnIE3GF1L4CkmSA
	 KVa8TqraIuIxNyxZclACxc0wXpBN2aKKNhBVDcl7OR20fWmaI0lfTOEaqqA7j64EHA
	 dYrTjEXkn+1PijuwB+NRsF18TYmrx62GI9U/Ge5M/cUcEoVRSYoqNgoGVaziph5wZ7
	 LrNdbEOEtjxXI5VgV3bT0h/QLicMvOlnFMST/dKd34YoZ+BxNNTCVnUItoEyfwugDb
	 hyW2r/wYbNHyN6EbalYsNtg6zl82kN4W7TIfLRDSRdiW7Gad67qRI5dNsJYRyIWOEP
	 b4tX8saGeY3Cg==
Date: Tue, 14 Oct 2025 10:29:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Phil Auld <pauld@redhat.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18-fixes] sched_ext: Fix scx_kick_pseqs
 corruption on concurrent scheduler loads
Message-ID: <aO6yrTkjUqMrq3cH@slm.duckdns.org>
References: <20251013203634.47362-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013203634.47362-1-arighi@nvidia.com>

On Mon, Oct 13, 2025 at 10:36:34PM +0200, Andrea Righi wrote:
> If we load a BPF scheduler while another scheduler is already running,
> alloc_kick_pseqs() would be called again, overwriting the previously
> allocated arrays.
> 
> Fix by moving the alloc_kick_pseqs() call after the scx_enable_state()
> check, ensuring that the arrays are only allocated when a scheduler can
> actually be loaded.
> 
> Fixes: 14c1da3895a11 ("sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using kvzalloc()")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.18-fixes.

Thanks.

-- 
tejun
