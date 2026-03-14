Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C92D3EE5;
	Sat, 14 Mar 2026 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773479095; cv=none; b=UNkRtw4C59Q62l1Lk7i/AAHMHbre4V62kjhXjFgEcHY/QjJJt9EIVPfW9xne+xojqGuJSEXcXkVu7WgRomm7C/Mg2DIhdysqvEi+PbhrKHcd95vzOrSJcJsh2M1Iwok6WcFIgeoti4TWvHo4CsZwUHoZEI/hQqzgHPvGtcZ64uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773479095; c=relaxed/simple;
	bh=uZtu01RYIsVKns4vmPF/TDGYmHuBpiShOv9vDfXQBDM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=MITsUVFj7RO8i9uQKLNx8Im7sr4im00+jY4+9SNo4Dvs7/9PexDMMuVlF21CvCYGwUskf9L9LCH6WTSvTx9MiOuyJVT+8MmheG2qw9fllctlHVn544wdj4urgnp5BleQJ9ujuXUqQWxzUK/qfQBtDZPt8eO7J9nJdrKX8aY6xa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNKHszGS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNKHszGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A53C116C6;
	Sat, 14 Mar 2026 09:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773479095;
	bh=uZtu01RYIsVKns4vmPF/TDGYmHuBpiShOv9vDfXQBDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sNKHszGS6lRRPPupBs9UDyf0kCGHgco9Rf3okMnhBwt8Py+kuvNRdIdpCv73yC+3W
	 zBHU34EIP49ZLAEhZmztQDjsQjPU5oXwE+1PRO2QVfNVo1Z+OU5IBa3ict5AHeMb9T
	 Cpt+DaKpWp5Pn0WYWDs0NJqBd610tQkLIttLawQPJQrmGFuYFGz9zbiDojbMUnjJWi
	 ZrqG+CvPNvF/DO8aOnqcdN+N10YA9eo1RpuuKTI3EMhTZjCmbU3B+iTmwSJsb+YmSU
	 jCm5sUe5rTER4clXCeFQapyMZ1DnIdB2Vbz4NQowU6EmhftMlOBcFgN//laJjHsZ/c
	 qh8qPz8woOyNw==
Date: Fri, 13 Mar 2026 23:04:54 -1000
Message-ID: <719a1f3866dec56f2c233cfc433bb5f3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 jserv@ccns.ncku.edu.tw,
 chia7712@gmail.com,
 linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH v4 0/2] sched_ext: Update demo schedulers and selftests
 for deprecated APIs
In-Reply-To: <20260314033708.26483-1-yphbchou0911@gmail.com>
References: <20260314033708.26483-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Patch 1 looks fine. For patch 2, ops.cpu_acquire/release() are already
removed from the tree, so this patch doesn't apply as-is.

Also, a couple minor things:

- select_cpu_vtime.bpf.c: There's an extra trailing blank line before
  the closing brace in select_cpu_vtime_stopping().

- maximal.bpf.c: The sched_switch tracepoint's prev_state parameter is
  typed as unsigned long but the TP_PROTO declares unsigned int.

Can you rebase and fix these up?

Thanks.
--
tejun
