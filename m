Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654E14A8E;
	Tue, 23 Dec 2025 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766462460; cv=none; b=JJirdJJfb2nX1BkjT7MKbGQYdSak2Z5+QSWDPFYOnBCmv+vx18GvDqHymiEOKqIQGR2cHBvS/DF6Mhko9HFnznLSoaZxI9813Z77iVso4Mw1uBJ4YW9TYm1nnkZZvLEq4Sgl1E6sagkdDO/LMl/mLcLhQd+fyO3fTzKRpT6IbD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766462460; c=relaxed/simple;
	bh=EaG/rLxQXcgmoe5lTr9U+J0863HVgn4txzyDURggLgk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=PI1Y8Q3/3NVFLiRIiYrZFzqeFfXuNsnLxBv8jeEiLDeN8wDErFP5BXs4FgEoJs5gyFFiolv/WgbkAsfIvIjzhnlyIdiM+Ig9L930y90NAuT/3GB6AZ2vFdvjk4nhR4TVHq+zAuT3JYAhQ7WC9lNNL61oNGyuPGMuvvUWIMRokNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECTtZ8dp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECTtZ8dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C94FC116B1;
	Tue, 23 Dec 2025 04:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766462460;
	bh=EaG/rLxQXcgmoe5lTr9U+J0863HVgn4txzyDURggLgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ECTtZ8dpX+PjAvBZKNN+pUh8CWQFFaP6uZEuIC/z72n9Y6igR25FLkb8tG4Sk6iHU
	 uVDHdBCJ0FZR1mGHPuqv7Y/005vSaFncIXcWmcl4cjv5ApjyptwElOXNrdituhZ2ZD
	 xM2xCIhx6KYJXZqGxNJH0vg2WnQ/8clMXbR+cokBrokkLHPa02CyJdF0Z0yoLhc68I
	 MVhdZCeuAcJINwQK3w6bqi5EFYNiCC1ULNWRGzbiOE4b4XtShfUn7W/LvLenHX5gH0
	 OsY/dX6xFFwHEtQ+wjnmYAnYj9kaNqQcgpKpP7zGQKHzAkfpARqie+VZ6l1A77NXJb
	 HT8Xl8JCt9xdg==
Date: Mon, 22 Dec 2025 18:00:59 -1000
Message-ID: <682c3b7818107ce0e757b51bdb17b955@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 emil@etsalapatis.com
Subject: Re: [PATCH] sched_ext: Avoid multiple irq_work_queue() calls in
 destroy_dsq()
In-Reply-To: <20251222115318.18997-2-qiang.zhang@linux.dev>
References: <20251222115318.18997-2-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.20.

Note: Commit message updated per Andrea's suggestion.

Thanks.
--
tejun
