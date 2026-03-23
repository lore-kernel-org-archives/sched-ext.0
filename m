Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC32737E3
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288078; cv=none; b=OAlv0uyZniNoVSJVP5LeCbLrGqqcRgg4664VcDlywTgFKZLK1SzRyj0juZrDGnCfo+zEn50x1eH0YJyLT3FV8pBTWcXplGHzkciCb9/D3avnYJlxdwWJJZzeb1W43WH/3TJkCbKmf0vVCInU3ognyRp8icVfLHHxcLTdqkyaNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288078; c=relaxed/simple;
	bh=JMlTOJwmGW0S9iwuWF72cWxIlxXghnF+P2EuInH9G6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLS7S31ggf9VkAsIEw99NN89iQazdGBosRk8t+sYtr02x4AgupcqAuRZ7uR7wBgtQ9I+1TtKbGVFe8ZUKrj0iLMpf2PG9PCdD2OV3OImtoFtInojd0Q1SJWo1gG7iXr2ejM7zkE0x6uyt3KH05pKivdzi0BCe97EqZFn9ybCTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPRYlAEH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPRYlAEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA628C4CEF7;
	Mon, 23 Mar 2026 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774288077;
	bh=JMlTOJwmGW0S9iwuWF72cWxIlxXghnF+P2EuInH9G6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPRYlAEHvMqpvndpatrlDVyTjfKSPu0sfbFrYVpCQWxkRg5wH6zX3OaTzrzT+L2ny
	 5A9plo0ZM6J3FNdw1N40YzDQ5bLNYjwMJRZQdCqOZerhSeSUol+726fid8HSyr7niZ
	 VW0IENG9OlYK3XK1oAv7P5wXWPyBJrYTCi5Tj9HPvaldu5qnnAhuPEvpk6+037RbIV
	 nuYXTNONMgznklfwbGp0gHoyPvEUOG7olknEkgzfwzE0WG3qcmNVy525qF/2vj6HUM
	 E2z/qDkbw/baSKXxRSucppA9X6PyPMTFiJ6CCK4U5zz/Uxx5Jzf/SGUxcFB0QYTaVj
	 bSNtpz8bejnYQ==
Date: Mon, 23 Mar 2026 07:47:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Fix invalid kobj cast in
 scx_uevent()
Message-ID: <acF8zKIsBST6Gha_@slm.duckdns.org>
References: <20260323104848.3879920-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323104848.3879920-1-yphbchou0911@gmail.com>

On Mon, Mar 23, 2026 at 06:48:29PM +0800, Cheng-Yang Chou wrote:
>  static int scx_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>  {
> -	const struct scx_sched *sch = container_of(kobj, struct scx_sched, kobj);
> +	const struct scx_sched *sch;
> +
> +	/*
> +	 * scx_uevent() can be reached by both scx_sched kobjects (scx_ktype)
> +	 * and sub-scheduler kset kobjects (kset_ktype) through the parent
> +	 * chain walk. Filter out the latter to avoid invalid casts.
> +	 */
> +	if (kobj->ktype != &scx_ktype)
> +		return 0;
> +
> +	sch = container_of(kobj, struct scx_sched, kobj);

I'll apply as-is but you don't need to move container_of() here. It's just
address calculation, not a dereference.

Thanks.

-- 
tejun
