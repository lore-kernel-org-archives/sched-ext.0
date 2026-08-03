Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C232345ECF;
	Mon,  3 Aug 2026 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795584; cv=none; b=E0+2OPOoh9VNG7yfe+K8C6wWiyqRpJDDHgHiVtgbh1/P3BvfqOkE9IW/56opCgYEg2iN232FWnfDhh5Sl0hDA4vGqgPoA3saldyIRl6fuIo4DVK70IbQs2ioxjv/0gCpttoLurXvw3fsQSHPcFSj61qKHMcr77x5/YrwMRd2H20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795584; c=relaxed/simple;
	bh=HmQiHc1Nfnp6esOAKkjFHuBB3BU8IJv/VVPmjwXfjPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dpvl2zrrQE2NiZxv+svZKSpcpB/9Ky6xTS/C44F7EfpmANIoIW7Q/jZU5B+ILUDrB7EZfa4ILq2tWNxBm1PtlmJcIoFLa8XCr2I2fYYP/lFAzGTtesBlVpB8/VuHl+ZiPB4EIpkYQsRoNPXCrB3bqdngvfzEsCqBez87945AMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So3+RaRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So3+RaRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4981F000E9;
	Mon,  3 Aug 2026 22:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785795582;
	bh=KfsB1BG/ckB5Aj8Y2LckUgB9n4K/LDxIWSyCEIAZg1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=So3+RaRuT+sYM680rEuaS4o5f2q4rezfsLxSWx4C8HBRf2sNyVfEbmD65vnYfYtG1
	 gdRUnAa6B6kqcKbi9Kj2FxgdCur1/y04UrHoeVYtO0P2ziEEWQV4nMDJkpLDf+KlbJ
	 xLTkQ45U+EUdD8XdS/21LdBnhuKOH/zigAEmsyOlSgxzBzttz/4pMsS9PO2xhcd/t4
	 FcQjTIXUoKEThzmxRmcyD2Np0pDj0UYtPMVDmT7kxDyxCluk7vZ+WjF7CWh8d5dkkP
	 LEOs+KCPvRxem6SKbirlBlQEmHi7xvCVvdoFgi/TYsNYQx2zstHLrpOnfxEWfuFl3I
	 rqCbAF0MVG82Q==
Date: Mon, 3 Aug 2026 12:19:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] sched: Allow enabling proxy exec with sched_ext
Message-ID: <anET_g4lpeMRgIcl@slm.duckdns.org>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-16-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728154425.1549660-16-arighi@nvidia.com>

On Tue, Jul 28, 2026 at 05:43:33PM +0200, Andrea Righi wrote:
> Now that sched_ext can handle proxy donors and BPF schedulers can opt in
> to blocked-donor enqueueing with SCX_OPS_ENQ_BLOCKED, remove the
> !SCHED_CLASS_EXT dependency from SCHED_PROXY_EXEC and allow both options
> to be enabled together.
> 
> Acked-by: John Stultz <jstultz@google.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  init/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 5230d4879b1c8..0817e62266e03 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -934,8 +934,6 @@ config SCHED_PROXY_EXEC
>  	bool "Proxy Execution"
>  	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
>  	depends on !PREEMPT_RT
> -	# Need to investigate how to inform sched_ext of split contexts
> -	depends on !SCHED_CLASS_EXT

Nice.

-- 
tejun
