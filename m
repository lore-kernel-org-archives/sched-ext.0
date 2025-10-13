Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE72D73A8;
	Mon, 13 Oct 2025 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380897; cv=none; b=G5HNKilbyLI7zFWk1wXF92WtP9CcCyxLVaQK01nQJj6uBbNfLAGjQ4UA5UUPeJi0Uzuzesjr8oqC4j1xj0EZ5oviEaGvDqcO48q88unD8MqFYpbNinwZwS1CpVdjuAdK+5Bq2CHdTX0VJdrSy9hxNEhhJB/LzphTZVg8fGTlWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380897; c=relaxed/simple;
	bh=i7Fg3wAXicb6TailRO+JhgEV6cD82vTHVe7redF22yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3KT/yKivpRPpC7xUI4qBieSmuwaF3Zibq9bKt174eJorC1QAiozcAu0/Th0LM6wfOjdEeCvZyhKk1pE1zwCo0vGKv+FbxVaKPUkmUNLba1DUJFOaXc333zJ6N683/+UMMEdVruvxrYD+DEHSNEvwWJhw2ghZC09FPWmmwvZegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4JaRO0W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4JaRO0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07EAC4CEE7;
	Mon, 13 Oct 2025 18:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760380896;
	bh=i7Fg3wAXicb6TailRO+JhgEV6cD82vTHVe7redF22yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4JaRO0W2BOmg2HT4YwNno9dIIZ+AJTZlRvTGiHIgOaBI6Uf9ak81t1ZAYcrIP5Cy
	 j1m4I+ipJ7NLy3jxZO91qAYZhA57gza7QMjnCjhoUbAy4tJAphquZxq+TeHU/EsB+B
	 nO5xo9PK0fMbSaEP7F3NgEavpmtBrmWjy+S905infHGcLcxheuFoNjCHm52oZzo88D
	 HltBX1RQI0lQvhQQCezKiIV5ZYJ3oYLYIUzgFEen16la+PoknpmT1Mwsqu3bgpRaeQ
	 CSDELBjy9ybb0r9SRFW7isHC7a3k2XuBdEuA/LPItaUIl2AER4N8C8NepF1/TgwNor
	 q+M1e2FtH1tWw==
Date: Mon, 13 Oct 2025 08:41:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Exit early on hotplug
 events during attach
Message-ID: <aO1H4IjG5YnI3cwm@slm.duckdns.org>
References: <20250904055716.87268-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904055716.87268-1-arighi@nvidia.com>

On Thu, Sep 04, 2025 at 07:57:16AM +0200, Andrea Righi wrote:
> There is no need to complete the entire scx initialization if a
> scheduler is failing to be attached due to a hotplug event.
> 
> Exit early to avoid unnecessary work and simplify the attach flow.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

I applied this to the wrong branch and lost it in the pull request. Applying
again to for-6.19. Sorry.

-- 
tejun
