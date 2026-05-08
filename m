Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CCC3A5434;
	Fri,  8 May 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253265; cv=none; b=qzHG32OfFO8RQvQ0K3QFucoa23olvMUi5sqIshtJI+Gx42pXNDc3D4A5WNAphl0UdhDUbr8AgOzcPqo7Jqa+dtxtdvbaJpzlUWi6RqsFbqW8X9vwZMUR4IlHNnoNobj1VJvP6d9py4tCgCB8OUtKD5+lPacd9omqM/v8HVs6pNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253265; c=relaxed/simple;
	bh=4A3g73tUe/f9eCg52wt689njQ6MqO/rsjcOU8EC1DAE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=r0vF6aYzNBHieqSVu7Uxpy9Xk0rHalVPQ1MCN4Yuy5zO6uKLhDnDsrF0to9BaBm7pjcEQH6TkXKo2IyRfAxFtI9q7cjgx8n2Ps9FSgtnBM8t3/Kyrw/mMoWkQ75oNo5vKWuQG/9cshtChoNXsTDGOfHb7yylDePjrmbsZZB50JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0CyiG/a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0CyiG/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9350BC2BCB0;
	Fri,  8 May 2026 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778253264;
	bh=4A3g73tUe/f9eCg52wt689njQ6MqO/rsjcOU8EC1DAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J0CyiG/aka+ak+dyrfdHvz05Uos6fVi+nC9FyLyS6ivE7al252FtkhAbcmsfmtWqU
	 NS9gdhygmbwdd8HYnW4fKahfOvhTokvWRtgSgb64B4i5/WpYzTw3A9/pq8qvxTq4IK
	 HSeJo6Q/gChbLNql4yq55M9JGZvA3ve21B51FjQ8YSwrIeb7QLqe2zdOUvuwbQkzmp
	 hGDbJWvEHnHaB1uUEeIVjWUiEHZjO9Gf+1G3rX4Pu2x0iXxCNp4BlleO6eE4rXBbFt
	 yR6aNj3JDRhlByuF9ViU9KBnltUBNX7tVaVIWDCMbNfdLKEN8Dxl6JwZfz+1bgmnWJ
	 2C0eXJ0zmiQyQ==
Date: Fri, 08 May 2026 05:14:23 -1000
Message-ID: <23171ae4eb5169b8db31a1c46ea2d709@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	yphbchou0911@gmail.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Use IRQ_WORK_INIT_HARD() to initialize sch->disable_irq_work
In-Reply-To: <20260508115045.23739-1-qiang.zhang@linux.dev>
References: <20260508115045.23739-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1-fixes with the following Fixes: tag added:

  Fixes: f4a6c506d118 ("sched_ext: Always bounce scx_disable() through irq_work")

Thanks.

--
tejun
