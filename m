Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFD7299931;
	Mon, 31 Aug 2026 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195201; cv=none; b=UgzFGwIRJ806oDO+SprMUlgI4PbdWEcQSk1vvXrPR2jGKkESOgKFlbA+7HHW7zkJYRMmi0nCj4YPm0MTLAOrMLdI6XLPJIzaZxbZ1RZBhAaEPRghf/JoSL87X5CDWIqmW9MiYUj6+SL0eSIXGZBs+FDg1neJEgOU/8XyIjjxIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195201; c=relaxed/simple;
	bh=Hf55CNxHwi5Gw0KwaOg6hD/UJKALjfT7NNNrrFvTdho=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=o9sRO8+fz3yopuJet/XJ5Wn2o3G5RkOXuH2e+KpULl74uTCGeYgLHomgYALup9D+NNBd+t0MXn+k9ArDGHu0huAPIajxwXeHgLjRIaiIqcaM4qewFMqtuZA2wbJdg2Y6xzpEzf2rhLtqWvcdLKKEGx1wODm96YoJ4m5xXxah4Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dV29g4ng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dV29g4ng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C80D1F000E9;
	Mon, 31 Aug 2026 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788195199;
	bh=pf6uOZhyPK0D+MhWcYqIwphY7/5m+gbhgEZYMoPdIkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dV29g4ngMECQh9GMaRtRnURMBhk63VcKwFvShuhoAvGyDBHJv+nscWeJgUx8rzITf
	 tphApeta6SGi+pfbtwWwsJjios/WID+gqiZGK94fdcypF4ZWxgr/VeslH0HR9Tzzsp
	 CsUgFFq1osVC7n5IymdmScReg0HMXeCo3jm3jEeiIGL1G+rGdoFUzU3sFnLd55ruSe
	 wvf0rATnEnFgAQ9lpGruV6CY2cv86nXvSkol0Klgj0GBydp68VqfjXeAMUFzIttZ5L
	 KsrY1FYT1GglkrpPjQnkCjBqSKTk4b2Z41agrcaWqu1GyQHCyjoCn3sd4qcE9nep5g
	 qjSNr5Eh8LO+A==
Date: Mon, 31 Aug 2026 06:53:18 -1000
Message-ID: <7f7fd4b14d356bd6d0f423591f39a6cf@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix timer pinning and return value in scx_central
In-Reply-To: <20260827080738.829103-1-liwanwu@kylinos.cn>
References: <20260827080738.829103-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied the following three patches to sched_ext/for-7.3-fixes:

  sched_ext: Fix timer pinning and return value in scx_central
  sched_ext: Fix vtime delta loss in scx_flatcg cgroup migration
  sched_ext: Check bpf_timer_start return values in scx_qmap

The scx_central description attributed the -EINVAL fallback to
central_init(). It has lived in start_central_timer() since d6edb15ad92c
("scx_central: Defer timer start to central dispatch to fix init error"), so
I updated the description accordingly.

Thanks.

--
tejun
