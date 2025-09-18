Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1993C465;
	Thu, 18 Sep 2025 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221828; cv=none; b=TPfrM/bTvuN9pFjcs6KKZiwocikqrVcULFQ6+jmo5pmy001aIQ7DhamaZM0wKbfw9UON9PYkcYd8J3P/FtAw7dHH83+ildhkwX2AEKWB6iJrOGmUW/CPN/QVvj6x8Mo7hhZIKvuFDI5huBSqXB01Lr3pNbZPrRikLpvGkvvXzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221828; c=relaxed/simple;
	bh=N+Mvh62o0AvBb7Y/WJc8zLNQ1YcEIvI6uDSo3975hIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKeB2tqnHdP9WWlvc7zIPK9unW21CfnShPyHM/tMw7APWppencOSixiEH4cqvZwTOdZVwEhjentuGjSjmO/zkMtao5Z3LLZRQAgxDqL3wglPtERbuBWQGRCnCl66m8y6k2KcMSaYr2ZZ+rs/5yBEDqV47IBwqlo0yUI2BXwdQv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+WsXM75; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+WsXM75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCB6C4CEE7;
	Thu, 18 Sep 2025 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758221827;
	bh=N+Mvh62o0AvBb7Y/WJc8zLNQ1YcEIvI6uDSo3975hIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+WsXM75BzpAbWZlo8YHArFtUwoaRp6A2G4Qt74QMzV3a7654GKLZPoFRY4Zo5DgR
	 d9wpLtwxuzFJq5/4pHF1hjvuzCSW6WVK35DP5v+8qL2RUazvCpNMg5sHCtcvWOf79/
	 B0RtoAiii78JjWHuMXMp1TXDhdZXcp3Cq601rateu0LXZD9dqWm16B38UD0sjRFfbu
	 y5S/g3LGMKIdoIqBV+HfLvMnPcHcHW+qTsk0NkPp6KEFRnGmAoLKaKm6i94w/3SYgU
	 EUGHWjy9o4my7KVahnDV89aKFMeMWax0uXuaPktKDRXvh5pL29M7d/bp5ME4ZpujRn
	 HA5v5gM+Ar+FQ==
Date: Thu, 18 Sep 2025 08:57:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-6.18] sched_ext: Add migration-disabled
 counter to error state dump
Message-ID: <aMxWAhJlE2Ah-f8t@slm.duckdns.org>
References: <20250918170602.2441024-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918170602.2441024-1-arighi@nvidia.com>

On Thu, Sep 18, 2025 at 07:06:02PM +0200, Andrea Righi wrote:
> Include the task's migration-disabled counter when dumping task state
> during an error exit.
> 
> This can help diagnose cases where tasks can get stuck, because they're
> unable to migrate elsewhere.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

I did s/nomig/no_mig/ for a bit better readability and because other keys
are using _ as word separators (e.g. dsq_id).

Applied to sched_ext/for-6.18.

Thanks.

-- 
tejun
