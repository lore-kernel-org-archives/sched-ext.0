Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031073816E9;
	Mon,  2 Feb 2026 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052204; cv=none; b=GJ/RFruq21mOwVCu0NAQX59Wv8ulTa2zEBGaV5wWiQ7Ckq1GOT5sAfGw/6CpThlWd9otH4wgI9Fag4Ym72GHWit8ZI4obn8U9mVt2l+2jA0jCG30LToUQ5W1OAaqZVWLft3W2TTtM3pqtWEZQzZMXeeO1arcsilcplMf+xL4F3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052204; c=relaxed/simple;
	bh=OCZrRaYmUIPVi/4aOJl9SNbNd4SdCEzfWBfZQt+eZVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J50v6LbWUUyUbH7dHWwpIMA/TxQv2Nk2VtJVSL9ztZ7A7A122lg72GV5FRMwo9fJtZIBARciI4Jky+dmuSHZyqv3NrQUjJAw5B1Ynlt08l5d2gm2Kfa4dnZKYn6FXtbdkx5mTbJsZArwvcVKc1iMDgVv+xAUxnQMUEsAY9tmW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUN3uBZD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUN3uBZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C7BC2BC86;
	Mon,  2 Feb 2026 17:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770052203;
	bh=OCZrRaYmUIPVi/4aOJl9SNbNd4SdCEzfWBfZQt+eZVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUN3uBZDV93PnVwleUKFoXFfURIsEPXXBdFXnDKSXev2+nVmFx07IZLaHBLW/Cb7X
	 16MiInpqxf6Tdxl1T/5DWACyptq7d7/R5lzecIv/9r3GN4S+1AK3ZGX8yYexzG324s
	 fvGrhnlcbXwtw747pyLbkY4AZnTTkxMLKP/TT6uUVLcQhWpMcnRjNl/wkK4iHrm57M
	 ZElrBdMt57UR9Xqoy+JfaIbrg9gjUTj3VqS1ME9Z09mRzyp7KfICnyGI2UaqpY2KpQ
	 Lvjrrt2iu7d0K+DKURPv0lpPD347maHAx2RGWknkrKC4DXFWPDh8YjgvyLzs/LcGZS
	 StcuapDh8Lqpw==
Date: Mon, 2 Feb 2026 07:10:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix NULL pointer deref and warnings during
 scx teardown
Message-ID: <aYDaao9Xb_Bkv0NH@slm.duckdns.org>
References: <20260202151341.796959-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202151341.796959-1-arighi@nvidia.com>

Hello,

On Mon, Feb 02, 2026 at 04:13:41PM +0100, Andrea Righi wrote:
> @@ -2619,6 +2619,9 @@ static void set_cpus_allowed_scx(struct task_struct *p,
>  
>  	set_cpus_allowed_common(p, ac);
>  
> +	if (unlikely(!sch))
> +		return;
> +

I don't quite understand how this would happen. set_cpu_allowed_scx() is
called from do_set_cpus_allowed() with task_rq locked. ie. the task *has* to
be on sched_ext for it to be called. It's straightforward task rq lock
synchronization, so there's no race window.

Combined with the failures in switching_to_scx() and switched_form_scx(), I
wonder whether what's actually broken is more something like the disable
path missing some tasks?

Thanks.

-- 
tejun
