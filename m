Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABA520DD52
	for <sched-ext@lists.linux.dev>; Wed, 25 Feb 2026 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043601; cv=none; b=QEXwEK2kpEotoxOu07TxBhBhWWtT+DxssenQSmAh0mnZxqREIBDbpxZwaSA2inYPVqIE2Qt9VfjI1oHlMcZK4qkibOOlKsNLb0uA2ei2/3SJZKgk55Z0Qb5lAp80OdUJm6jg/xnkgHFhHnkVl/bI5CDlABrqe993p8Bl7XKnsDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043601; c=relaxed/simple;
	bh=iOnABT/hXjsS7VN0zyzjRtGILQrEldn2RJAtL/ZZBdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFWYporV67fkaix1Sf+iPtQs86+3BdVMEe3EeegNoQ9Plf8MUN5uZJZJ/6szTx1iN+IqMNOvTKGxionX2efY6gJLcYGjd2EXQblYklBUWcHumwAQ8HYjpRr3m9kqG9eVlDkznamKjVEXrn+qWGB+QG2il9JFSiVxkM49evbG1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyMvOj/J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyMvOj/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36FEC116D0;
	Wed, 25 Feb 2026 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772043600;
	bh=iOnABT/hXjsS7VN0zyzjRtGILQrEldn2RJAtL/ZZBdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SyMvOj/J7fpUmLdpvg05sn7pe1d/06s8GG40zEWLcvWVBA54uA2SgCPTDfzaP87qI
	 lIx/fyTmoBZHWwYAu1C0nlV5BWWhon7jASNn5ZoKdo3WdzRG0Djrp7eqOqcjZxkSgr
	 n3l5EY/a2VY4kIDO93JveWWg/Fwo8Ve6XIAp8+eHPP+14skZvOleDpmsVxNfIrYX9f
	 xWqljJR08BKxp/FyEzIWPyNW9eC5v5MUuWxr0PJ+8+u5gi3pBT9xJ8b4iuiHs9MmDD
	 n9E27kWT/UCe4347ZpyD2M3U5VTcg1Uq1I2hvqgJ+lgjgv+zcRcA5JNGIh6OI9OrHX
	 dpIWfCUfhSpLQ==
Date: Wed, 25 Feb 2026 08:19:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] sched_ext: Prevent null deref in scx_dsq_move()
Message-ID: <aZ89Tyy-oQ7skH7z@slm.duckdns.org>
References: <20260225181624.427916-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225181624.427916-1-yphbchou0911@gmail.com>

On Thu, Feb 26, 2026 at 02:16:24AM +0800, Cheng-Yang Chou wrote:
> Add a null check for the `sch` pointer at the start of scx_dsq_move().
> This prevents a panic if the function is called when the sched_ext
> scheduler is not active.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  kernel/sched/ext.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9280381f8923..79d8184e4e11 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5990,6 +5990,9 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  	bool in_balance;
>  	unsigned long flags;
>  
> +	if (unlikely(!sch))
> +		return false;

But sch is from src_dsq->sched. Can you describe a scenario where that could
be NULL or do you have repro?

Thanks.

-- 
tejun
