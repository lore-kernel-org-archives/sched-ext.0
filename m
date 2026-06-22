Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6807433F5AF;
	Mon, 22 Jun 2026 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149075; cv=none; b=HN76JnxS3bUhd4L8rXiFXfTZHl97qQxfqI/TGrb/DEmgmHM9Xwgd6tAc4xdRumo+ZUiaJZManrzWbFwCm/IH9rUP8/ima6fiuvOThdz/AqhlfRGm9IZYaWIdm6r2gg8o3K6WwPXIJwqjtA6mXuJUjGaeyiunj8y2P7N54o2CoOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149075; c=relaxed/simple;
	bh=xxrQiZit283gFOCRPVj0BAAxA7nl2cHHH1szJ8rlyrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6YjMTvJttTKu9USLR6zk7us2AIeBpegJ9BNpO/qvE6c6hAInHgJfFpGg0eDzaK9jZZmVo2fKnFipod1jyXRZztGyoND/bAhQriy+MVI9tWgkkjhngpB/yGBkx30kJltAoaDrsMcMZHeuPXVlPzP/14MHxi5EAzlPCFD5PkD140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQZ2oizT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQZ2oizT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC9C1F000E9;
	Mon, 22 Jun 2026 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149074;
	bh=bpGQXG5JbudUzcK7rhb2SYPGMn61YSS8qsUp6Sjgaeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lQZ2oizTtp0ulguYeKhjy3qt2SvIX+ZqYvV/dqW9m93xm0exqxAFrEJU3g/baFhZ6
	 Y5aBG+GMh/8ss0wkv24O1NJ8ER9LXS7W/tN6LGULlHbYv3QiLwitZCKfMRL6ddjgzm
	 soq6DqEcYivAsScOvnarhXrA720R6ZkuX9JUs9jwKwfOSnMjn63ndxtq6mhOMp5hyf
	 4bRTal2XuW72InKzNJmmSa8r/MD0Esn82LuJcR7pjNhrRpi4vXfmjA2eJXKN+qHEDp
	 Ljyk+bt7ubwMtt7vv/ExjkqW+dYmpweWX5NvArwZymbSxn29HhBxN7qDVeAhUJMHhq
	 uhi6YC7LHzXfg==
Date: Mon, 22 Jun 2026 07:24:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Move sources under
 kernel/sched/ext/
Message-ID: <ajlv0Wq2yu4D-F_T@slm.duckdns.org>
References: <20260621163026.434856-1-tj@kernel.org>
 <20260622084657.GZ49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622084657.GZ49951@noisy.programming.kicks-ass.net>

On Mon, Jun 22, 2026 at 10:46:57AM +0200, Peter Zijlstra wrote:
> Can I take this opportunity to remind you that most of the ext files are
> not clangd 'clean' yet. That is, they don't cleanly compile as stand
> alone entities, which causes LSP/clangd enabled editors to throw a ton
> of errors.

Ah yeah, let me clean that up too.

Thanks.

-- 
tejun
