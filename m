Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59E46D0B5;
	Tue,  1 Sep 2026 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293609; cv=none; b=lPKjEmVFT0WNt7yqkLR9a6p5icoToRE+0PKnQPC3t6huUdI6eFpE9/UPzH5SU/9vjI09kF+Wp5SBMybT7/dzd4CCwjzxisP3F/V3Hxw7Tmdw2KYdIyDn3h98ytEsCu2dz4ZsKTg7ENzsL6PF/PRmBw4rH9MqrMAeiXnd3Qch3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293609; c=relaxed/simple;
	bh=sZC4lhTNx1WuJA0vUAZ3vxyZa9Nmvox5IW+gl09YkuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQ9uzTu33x3LZY3nLnpzZ19nJVlqyHYH2qnVXf+KgIi9vBZQ/UCZgWLEl0ENLJaVUt5PkIkMvpG7widQtz31Zx1N4qQE4f87yTGufOfnS6n/V7CuPCzPrAddSX8BocVHJ/pn1axKF+nwsXp0xKPzsp0Nyax8bE6yIutVMoOiY1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNXufvuG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNXufvuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF18C1F000E9;
	Tue,  1 Sep 2026 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788293608;
	bh=wIb1oKiXgc3Cp+TE8sUKFj514QLKiu23r1PciBkOqO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KNXufvuG5X1sdAhqFetTuvQR6UMeI4sItBXPmCX+o1XKRfCUYCnQCVHxEmOqRMUE6
	 pN0BoJU3sHTYVEwgKmaI8DiFWyi3/TybHPKKakGS2HUWMo9wZ6m/pPMG3Ux5O4WxMW
	 ASyY3bOcObfvdXJ9LIycH3oU3OLVZ4wg47DoJDK974gUUNZ163YIf0UpZwpSSvds7m
	 C6XemJ7HT+rxfMHHYWuUi9DW2fOmCmpmZ5fARqb9e4hWK/YOwvAHqy/8i0D3QIgJCm
	 OMRZ5hi2mKS9flNM4o1HC98UlA+WSxC1BOMu1htsfY2qnQNEYezLRTU+lP7ElPHXC5
	 5gZcamqLX8PXQ==
Date: Tue, 1 Sep 2026 10:13:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Wanwu Li <liwanwu@kylinos.cn>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Reject NMI calls to lock-taking kfuncs
Message-ID: <apcx5yUysXEuEYAf@slm.duckdns.org>
References: <20260901095652.1009104-1-liwanwu@kylinos.cn>
 <apcsyS2j-N8j5-BN@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apcsyS2j-N8j5-BN@gpd4>

Hello,

On Tue, Sep 01, 2026 at 09:51:37PM +0200, Andrea Righi wrote:
> AFAICS, the lock-taking and state-changing kfuncs do not have a meaningful use
> from BPF_PROG_TYPE_TRACING. We could move them out of scx_kfunc_ids_any into a
> separate set registered only for BPF_PROG_TYPE_STRUCT_OPS. The read-only kfuncs
> could remain available to tracing programs.
> 
> This should include:
>  - scx_bpf_kick_cpu() / scx_bpf_kick_cid()
>  - scx_bpf_destroy_dsq()
>  - scx_bpf_dsq_reenq() / scx_bpf_reenqueue_local___v2()
>  - bpf_iter_scx_dsq_{new,next,destroy}()
>  - scx_bpf_cpuperf_set() / scx_bpf_cidperf_set()
>  - scx_bpf_sub_grant() / scx_bpf_sub_revoke()
>  (... maybe others that I'm missing ...)

Hmm... but it *is* useful to be able to e.g. kick a CPU or trigger reenq
from a trace event, no?

Thanks.

-- 
tejun
