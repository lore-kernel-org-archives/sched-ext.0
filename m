Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98339A04F
	for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420994; cv=none; b=XyQC+4h4o/wHkaiY5cw1mOITjD6/J7Au83E+euufwXHiW4Jpmtz3idtnr4l8xBlL3A4BnVASXvhcg/xEXhO24Hj4sLABX/5KVB1tXixyF//9rir1YiXrHm0UaYEzeNZVGiv8orBG5IJJHLi0zz7HQVwTlmlTlHeXKzg2rgyteGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420994; c=relaxed/simple;
	bh=Lj5m3gZf2BBOMWYGImGJXaK4/TxGT5kEP3q5C6wc0Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNdI+OJG870UfB9FdimHZED6IFXSINr/zXVe5qMx5SAFQdH8aFcovrMDBPutaeOgiXvN/SRCBwF+m+NvbYzrEMXypURGeknwZNUNN4wgFo/5CnxrJLzEGi3N04+JIWSCV0Xct/s4fvIyWpuX9Ys6jw6+qF/oTLbbzrWS0dsNDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXVBeIbn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXVBeIbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4911BC2BC86;
	Fri, 13 Mar 2026 16:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773420994;
	bh=Lj5m3gZf2BBOMWYGImGJXaK4/TxGT5kEP3q5C6wc0Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXVBeIbn6AItLmcUpG/TGgEl1pXrx2qpfApyeUws8yuNh/fH1e125dQimc6FVNiTB
	 gzApsylGpiweL6VRMlkoJ0cmwjCSFsnWC8Zsl6DXZ8FXel69y9modF34OMER9LjtHl
	 F2PmLfrwxpVjx9eiD0CnHvMdCaHdlju5sKARmPqHGYvrqJg/BwigGYr6TSr3VlCfGL
	 rJLLBbA1uEzZkPeKg6YI+G/Jngyq7tbdcV8T/A7cyZ8QVz9OYTQerhhoxtPhUXmUd4
	 dv83B6sTpKln9NDNZKP6a8ICWCOI0CslBc1wUN/NRgiAFO+Lav2d6xg9THJYa0j9l3
	 nf8yJOq6QmF2g==
Date: Fri, 13 Mar 2026 06:56:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v3 1/2] sched_ext: Update demo schedulers and selftests
 to use scx_bpf_task_set_dsq_vtime()
Message-ID: <abRBwZCwaYNqRSpj@slm.duckdns.org>
References: <20260313014944.1234667-1-yphbchou0911@gmail.com>
 <20260313014944.1234667-2-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313014944.1234667-2-yphbchou0911@gmail.com>

On Fri, Mar 13, 2026 at 09:49:43AM +0800, Cheng-Yang Chou wrote:
> Direct writes to p->scx.dsq_vtime are deprecated in favor of
> scx_bpf_task_set_dsq_vtime(). Update scx_simple, scx_flatcg, and
> select_cpu_vtime selftest to use the new kfunc with
> scale_by_task_weight_inverse().
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> ---
>  tools/sched_ext/scx_flatcg.bpf.c                         | 9 +++++----
>  tools/sched_ext/scx_simple.bpf.c                         | 6 ++++--
>  tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c | 7 +++++--
>  3 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index a8a9234bb41e..c734ef616c7f 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -551,9 +551,10 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
>  	 * too much, determine the execution time by taking explicit timestamps
>  	 * instead of depending on @p->scx.slice.
>  	 */
> +	u64 delta = scale_by_task_weight_inverse(p, SCX_SLICE_DFL - p->scx.slice);
> +
>  	if (!fifo_sched)
> -		p->scx.dsq_vtime +=
> -			(SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
> +		scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);

Wouldn't it make more sense for delta to be inside the if block?

Thanks.

-- 
tejun
