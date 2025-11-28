Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B72FFF89;
	Fri, 28 Nov 2025 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764329877; cv=none; b=XLZhkGuJMBYKG/3Wrqy47G7Iu08InSXkbMAfA8mJu515TtuTeSP9nHLzSgoRDKPTZ4T3IW6G3ZQQY4clhlOtXDq/fRYLXIJd5k6Q7xvNxWzicGjzkQOicLO0jxrE+CpRhI/SMqftAZufg+J41M8cRcudw30ct1slWVdQG1rj87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764329877; c=relaxed/simple;
	bh=z+4jax6hlPDQ82JbshNnQ5jPCAkiEulTbneYJG3Dggw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvZMpSSmpV+Et4qnW3yqJXpR1cBs7hzi4UHrGYYa9EHqLtibjS/b31Xuozac7J0n+DRCIQpiHa3+TJZ3nx6VQmJlh7/RZjXNExABWNtbUf65vcbF3xcvXyEafwMkPrC8tKijQdo2cOCvTLXjj2/40tdzlRmNF32MlQ5X744lFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N3WxZIuX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N3WxZIuX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z+4jax6hlPDQ82JbshNnQ5jPCAkiEulTbneYJG3Dggw=; b=N3WxZIuX85mN+JGRGIcwsSovdh
	j6FdbRLjBg0jalmqNJf4ZIwVT5NjHlG9AjAw6j9G71zdDabhs8XQYSQHRziG7IvAxjqQBxkyqp0UU
	cyyG1w3H/2g9uDzY1mCkivz6kQpz6VIJjX9RytqHn+ML1JBjuAI941xsj6OFtV9NbV1fhbpdtemjs
	mTzfX1lqo407IfLc+oiEL1jkgJRqIhXKAIOWFyIPxJ5hXlEYZcKA29g7W43pmQQNln8bhKcZgHhUP
	ef6fowvwlADpafOmLG4D6hHm5+JCdN41tiVhK5uxEp64fJUN93NCRTb/z480hdbFfE/3Zf3Mc9wUQ
	zQw/U/rw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOvvl-0000000Bo1d-1wG8;
	Fri, 28 Nov 2025 10:42:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1D119300230; Fri, 28 Nov 2025 12:37:45 +0100 (CET)
Date: Fri, 28 Nov 2025 12:37:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: mingo@kernel.org, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 3/5] sched: Change rcu_dereference_check_sched_domain()
 to rcu-sched
Message-ID: <20251128113745.GK3245006@noisy.programming.kicks-ass.net>
References: <20251127153943.696191429@infradead.org>
 <20251127154725.647502625@infradead.org>
 <20251128105723.GZ4067720@noisy.programming.kicks-ass.net>
 <20251128110416.GR4068168@noisy.programming.kicks-ass.net>
 <87d98b6e-b534-408a-bd27-0610de0e81f4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d98b6e-b534-408a-bd27-0610de0e81f4@paulmck-laptop>

On Fri, Nov 28, 2025 at 03:21:41AM -0800, Paul E. McKenney wrote:

> Would rcu_dereference_all_check() do what you need?

Yes, clearly I should have read more of that file.

Let me go try that.
