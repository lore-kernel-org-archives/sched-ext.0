Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EFA1925BC;
	Thu, 17 Jul 2025 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776430; cv=none; b=OM6+TLqbHwxDpD6ojL9/U/gRM8K8Zc2Srlf3JieeioTvoqOmnW2hv7Asax5Oq1S5ydL1U5NJ+mMi9UwGBTg5QAc1GQUk75e68yNGskxHThDn9GfJ8GL3kqXz2DZysykby6qkabZsFGLv7QxonOwEz7FoDNwabecqzKPW59uIeDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776430; c=relaxed/simple;
	bh=MXCaEo4tA72p/Xmh6nSTniYL+kDuOh+jZGNAykR8nqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezQqYYYfoiMo0PQU6l53cY4/F/grkngrHeHpjlSnGfNDSPuMgzkywGyt5Jh7210Jp8vBhuEk5NZclexKr+/7LX+amB6QcerALJ8RQ46YFnVO+TBQTOX9I22jh8PD0Ku14diwfMG8d18GZQLn8i6u2fdz/g8aOUNR1g0pq26YZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuPZ5Pc8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuPZ5Pc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB9AC4CEE3;
	Thu, 17 Jul 2025 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752776430;
	bh=MXCaEo4tA72p/Xmh6nSTniYL+kDuOh+jZGNAykR8nqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuPZ5Pc81ZB41YqP3M8YWI7Iha6A1oN+Gi1aC5ndHPFaYjXGNGNZmjUnRNsIye3Eq
	 DzlvIy3+qQjypk3n74walWOzgXtGzXd4N8GknDNPCtdxLqVsO/Y3xx4jpqEYkBMo3F
	 2TBlWdPWve6lADp26sXWLPCc8OPrec62rPMZ4RbXjMs5AOdLJ+W55bevYZ6OpB4jT6
	 b5ie8bToDIg+yQz5VaSr5S4Y4oOCxR3WPhtq6b9qwcFZlTiJPDh/TORbcs09GHkSvF
	 SRjj2pSj7jYkqXKHTYmLjWk7rgyt/62oU4CZMaa+buwYVPyI0EVcP8A+tke6VY0u6M
	 nqpw4x+0JMMZw==
Date: Thu, 17 Jul 2025 08:20:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: idle: Handle migration-disabled tasks in idle
 selection
Message-ID: <aHk-7UvELcnx8-wO@slm.duckdns.org>
References: <20250705054351.332038-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705054351.332038-1-arighi@nvidia.com>

On Sat, Jul 05, 2025 at 07:43:51AM +0200, Andrea Righi wrote:
> When SCX_OPS_ENQ_MIGRATION_DISABLED is enabled, migration-disabled tasks
> are also routed to ops.enqueue(). A scheduler may attempt to dispatch
> such tasks directly to an idle CPU using the default idle selection
> policy via scx_bpf_select_cpu_and() or scx_bpf_select_cpu_dfl().
> 
> This scenario must be properly handled by the built-in idle policy to
> avoid returning an idle CPU where the target task isn't allowed to run.
> Otherwise, it can lead to errors such as:
> 
>  EXIT: runtime error (SCX_DSQ_LOCAL[_ON] cannot move migration disabled Chrome_ChildIOT[291646] from CPU 3 to 14)
> 
> Prevent this by explicitly handling migration-disabled tasks in the
> built-in idle selection logic, maintaining their CPU affinity.
> 
> Fixes: a730e3f7a48bc ("sched_ext: idle: Consolidate default idle CPU selection kfuncs")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.16-fixes.

Thanks.

-- 
tejun
