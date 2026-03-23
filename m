Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C42F4A14;
	Mon, 23 Mar 2026 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291295; cv=none; b=L+JcgY8veLUycOg8u9W4pErBj5LlxuV0Zz/QDF/zTlZx2erOPZIH9hcpdc5AULJn/pWQfxy/y9DhiUxT4t3g14tEWkL5Dpp+0wTsppbWMpMXAxHY3ypRxhg0qS40xmuY2pX9ikRGgOZWqkqHgR23UVTcOnG4lVXY9ZnyR76bZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291295; c=relaxed/simple;
	bh=g3hddMKcyLyL5L0TOBei1JAxjLAYpv4RTuItnVW9YTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHzRXSEcKDMladHqMhcQ7iI559gERVapQVuy/+TynGUZPlUNFEp8bXSZwA2vbyjFXMaup7IhL0QAoZtw5frCDZ/NnHvJHicvtEg4Mjx+XLQWz2PupQiKND1nS56s43qfK/A41lbQ4xfXBjsTC4eKb5IsjL0Bg/5Mp5wmlDclfCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6IV/niw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6IV/niw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57201C4CEF7;
	Mon, 23 Mar 2026 18:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774291295;
	bh=g3hddMKcyLyL5L0TOBei1JAxjLAYpv4RTuItnVW9YTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6IV/niwpq7lxu1ix0JIt9Oxog1DRLtR+/ivrULJQrfovZYVcTa0eUr2fl83EuaD5
	 TYZQuwulBPsNq+PDL47kZjtE4/IFHq81D7PiaBQ+Qn9okkajGOxEvZZGyV1n28osvI
	 9o0esWaL10laWLvN40Z2wA/Ugq5q9btsCl1CEGQR21Bs5uU9rGK+7ymMYtexZgpmVf
	 ZwRD4L0LI0eREXwdpj33HYk4pQvQ0+vENARXOCWZIpnJo0QZhjjjBklcE+cbz34XgT
	 WgPdMXlC0EDk22v9H5EAwhGDigKgfgH6/YzTPgmzDN4qrPWkFgevaRXlmm//NBLbDi
	 GPArQI6JFPcnA==
Date: Mon, 23 Mar 2026 08:41:34 -1000
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	peterz@infradead.org, mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH] sched_ext: Use READ_ONCE() for bypass_depth in
 scx_bypass()
Message-ID: <acGJXu8dZwCfFO5s@slm.duckdns.org>
References: <20260323111202.3960280-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323111202.3960280-1-suzhidao@xiaomi.com>

Hello,

On Mon, Mar 23, 2026 at 07:12:02PM +0800, zhidao su wrote:
> In scx_bypass(), pos->bypass_depth is read under scx_sched_lock to
> update per-cpu BYPASSING flags:
> 
>   raw_spin_lock(&scx_sched_lock);
>   scx_for_each_descendant_pre(pos, sch) {
>       if (pos->bypass_depth)  /* bare read */
> 
> However, bypass_depth is written by inc_bypass_depth() and
> dec_bypass_depth() under scx_bypass_lock (a different lock):
> 
>   lockdep_assert_held(&scx_bypass_lock);
>   WRITE_ONCE(sch->bypass_depth, sch->bypass_depth + 1);
> 
> The read side here holds scx_sched_lock, not scx_bypass_lock, so the

It's inside scx_bypass() which is holding scx_bypass_lock throughout the
body of the function.

> two sides are protected by different locks, constituting a lockless
> concurrent access. All other read sites consistently use READ_ONCE():
> 
>   L1237: if (unlikely(READ_ONCE(sch->bypass_depth)))
>   L4083: while (likely(!READ_ONCE(sch->bypass_depth)))
> 
> Add the missing READ_ONCE() for consistency with the rest of the code
> and to make the concurrency intent explicit to KCSAN.

Plesae do not send patches to address KCSAN issues unless you can reproduce
KCSAN warnings and always attach the output of KCSAN.

Thanks.

-- 
tejun
