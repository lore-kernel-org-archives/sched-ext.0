Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B65C224AF7
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554401; cv=none; b=YJHidwGejl8U04BJMwqNLj+wgWWdIfvKKz7iLSLHKidOemd8oNOXdHkSkssq7G6ik5nC0tKIdtEGNtkikq+E5Fdb8lwHvy2ytG2/CcuomcJ4gzcpbx7LqZTiI2lprbqOX6NCeEMgdz8IB5UIORDEhvwXF3fk8Jjs/rgD8Lp/+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554401; c=relaxed/simple;
	bh=yErnXYl5X4Of962vZ6jR3I1S0C0vfHvKgPeZ/k1lZnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fij/fCXswExh6OR2bbG0/LrysL8dBgk3nX6ryeLF3zAt9xKR0NgFuN7oQ2SXzo2eIi0fNZCGdECuq8buBKUY/x1oybnpd9qV7ZuAWb8G1JlcyBwptVzG6TNQ8Z/E7/J2jFOrGg+AkvaXmdpva1R7Wwe7+g25I1GRGO47mvDmLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W95yzJHA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W95yzJHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1ECC116C6;
	Thu, 26 Mar 2026 19:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774554400;
	bh=yErnXYl5X4Of962vZ6jR3I1S0C0vfHvKgPeZ/k1lZnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W95yzJHAVIJs6VRD1Vd7z2GNmEXOD4PTwI0HAE+TL5pGjin8NSfA2bxy7A8aG3Xp+
	 Z38hEyZxFhy6rQNuI9bmT19kdeqmDJwz57lp3UeGAYDsU3PuhZ5IBPT9Rk0faKmz8n
	 jOvfGUwKDeYVm/p4xG1xQrqzrZTABZ16uH8+26xVvMz4cLTHrfuejD78SQaXTr4fpa
	 t3+SDpJ/P4H5lnkfzIQXrYlH7v/CPCBZU6VPpFke0IYIVZu94DH5/8a0hVsE6ZJIR7
	 wlMZwSuinnpbxpikXF1qpBfMGkEDr4chSe1hh2R4/ypVAtFXG/VcyfnBAjQCx0aDk0
	 2149gxliXyi1Q==
Date: Thu, 26 Mar 2026 09:46:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: Fix scx_bpf_dsq_move_to_local___v2() to
 handle SCX_DSQ_GLOBAL
Message-ID: <acWNH2Kp2k6K__Zj@slm.duckdns.org>
References: <20260326091756.816828-1-yphbchou0911@gmail.com>
 <acUXEy9NUVMb40Lh@slm.duckdns.org>
 <2bpxb64ymbxgtzodc5bxdmh5w7klr3xokyt7wccb2lzn3arxwp@yhu3jj4ury7w>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bpxb64ymbxgtzodc5bxdmh5w7klr3xokyt7wccb2lzn3arxwp@yhu3jj4ury7w>

Hello,

On Thu, Mar 26, 2026 at 10:24:54PM +0800, Cheng-Yang Chou wrote:
> Since the error message only says "invalid DSQ ID" without distinguishing
> between "DSQ not found" and "intentionally unsupported terminal DSQ",
> would it be worth adding a comment to clarify the design intent?

Yeah, sure. Note that. Local (along with user DSQs) now support
reenqueueing. When a task gets in a local DSQ, it either gets picked up by
the CPU for execution, gets dequeued for e.g. property changes, or can be
reenqueued. However, the BPF sched can directly iterate local DSQs or move
tasks in them. Global DSQ is similar but dosen't support reenq, mostly
because it's difficult to define the scope as SCX_DSQ_GLOBAL maps to
multiple currently per-node DSQs. This may change in the future.

Thanks.

-- 
tejun
