Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249633BBBD;
	Wed,  2 Sep 2026 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331500; cv=none; b=M2OXlM1xzy381i5jKUY7H9khSlb4CJX0wGFnVJWiP0YWtEOLawTXeVl5uDskwd9eZVkUVWHdBJ7AdblEtP+JTn9DbbrhLcHAxdsptiVrUPj3u91UFvvxNu9BeqJA47nBjUI/tbpFByV3DSd5MadgTY4kZM0w//m7MlaNQRHqv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331500; c=relaxed/simple;
	bh=NUuwNZ/QMlWFfV+xYcq7rRZrkdEenKWkTHl5DIXeCrU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Oak5KHqZoCWKTht9BHu/X3jVJsYVeTlR1gLPsaEa3VSwrwzVHiK1F/M7ue0ffp4BR2Zs/KSKLD6cViS5wcos3csX/C6OF0Ur2hc/hxfiDH+5O7RCk/qAqzaRxCbkZM7aiCXQS2SnPQesK+ezjb1ewebGp/wHEqEupTnk1Q6s5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaaGZAke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaaGZAke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833021F00A3A;
	Wed,  2 Sep 2026 06:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788331498;
	bh=/CBLym/vSOaW1EUlay1WguJ6tPiiOBBP63ZGMjQZitE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jaaGZAkez03/yePsvSYEA5F7kQ8Im6HbxF6ipSO0mat8p6NHQYBrIrvjibAgLRQCI
	 iL51dh5ro5rugfXtxTa+qarocVVtkLkzTOWmuZk21QJFNVEptNFwswp2TSj9WA2W43
	 tCjbCI+Ah5kyzDratJkvGvQSjTFMSDaxUVeVlHbLTjz7lzWW/GWHPoD8iH6DRhapyn
	 LxpWWMQxpwOpbwbjbEamBqhIwGikIK/tw9qoleG4uroyE/jGTYjXaZrwGTAQdnWVKk
	 ViBA5kgDiUr9dYeU8ugxWYdb1iPc9evhwfaaROiZfC1KYxXnrK0jvqKIeHh9iLFTPQ
	 D5MxjRrXfLBlg==
Date: Tue, 01 Sep 2026 20:44:57 -1000
Message-ID: <49faaba5039a29f38ab6f254da6fb8dc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Reject NMI calls to lock-taking kfuncs
In-Reply-To: <20260902023124.1422942-1-liwanwu@kylinos.cn>
References: <3a9bfba228c46c69408fe1ef392e60f0@kernel.org>
 <20260902023124.1422942-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Wed, Sep 02, 2026 at 10:31:24AM +0800, Wanwu Li wrote:
> -	if (sch)
> -		destroy_dsq(sch, dsq_id);
> +	if (!sch)
> +		return;

unlikely(!sch) like the other kfuncs.

> @@ -9756,6 +9755,9 @@ __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *i
>  	if (!kit->dsq)
>  		return NULL;
>
> +	if (!scx_kf_allowed_ctx(kit->dsq->sched))
> +		return NULL;

new(), next() and destroy() always run in the same context, so reject in
bpf_iter_scx_dsq_new() and drop the checks from next() and destroy(). With
kit->dsq left NULL, both are no-ops.

> +static __always_inline bool __scx_kf_allowed_ctx(struct scx_sched *sch,
> +						 const char *who)

No need to wrap.

Thanks.

-- 
tejun
