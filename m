Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3347F3E170E;
	Thu,  9 Jul 2026 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636120; cv=none; b=RaUF3nZjnghpUYXpYiTLJaGusAdvEPZGjbKmavQECFBW4Qjgk5+471rTir8sMQxeyCzzSxr/AIt5vm3m7YU6GhI+b01OZg3nAnswBGuxRBKk15yNNnXp4chYOeS6TZW/OxpQLYugwmub+A04upvRAc5oob1vJr3hrm3ezIK2Gy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636120; c=relaxed/simple;
	bh=onDt9/RR3IjqupkXriktF+KXWc8DB41AuM1K6M48qCk=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=oqnCTGqvA1N2hp9pAPNPQ8T86DDyjmcA9pKY7/eJ5iKN8K9YeidtSbCvMcOer4AhmN9ZUwj8NVOZAZ7wdW5LgzMn5+5q7Q1cby/W81wWhI9PhaI+pPGvEsCy/xuKpWYCYLxB6dBhdTqnqXmzCkMES8SNbN6NQGDvVydUoyt2dOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdXr4UmF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdXr4UmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CA31F00A3A;
	Thu,  9 Jul 2026 22:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636119;
	bh=wmVYNEc3ky5bZuS9Dk0Vk4DThIwz8LwP8rRWi2o/gJA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=kdXr4UmFqX8X4SGaNH7XSRA/HebaWpRirIZMiUl1eglElcExfMpV1wBKSO16TWGyH
	 oXUBbwDRdkyMurKK+oca7fWX5lV2rPHgpBDl1FwGoR81klLTj5KPuzuaIBMZNWCKVJ
	 x5XqcWQu9WsQfd0WkYNiLUFcXG7WOvHYeaH3A140+f0AvmppVTX7iPtDuet2hBCZA4
	 KaGSM6MJjbprDhWmNrJVbJM1RTDiURw8MUa6voZhAv/RozkUkHBic5LVNtWQGS3Ix0
	 uTOWCZ8/RGkFvIcF6BD2qCZIIZl/lLDW2UaNdDOMabSKJEpt2uPDjlWuUYEKX3XJjB
	 lnEVtbaj1588w==
Date: Thu, 09 Jul 2026 12:28:38 -1000
Message-ID: <8c20f1fbc2018fdac5dfa7b78839f4a9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708215520.8C5461F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-21-tj@kernel.org> <20260708215520.8C5461F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 20/40] sched_ext: Stop resolving a disabled scheduler's programs
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 21:55:20 +0000, sashiko-bot@kernel.org wrote:
> - [High] The `sch->dead` check was omitted from the
> `!CONFIG_EXT_SUB_SCHED` fallback version of `scx_prog_sched()`, leaving
> the Use-After-Exit hazard unfixed.

Good catch. The =n stub skips the dead check, making the post-exit drain
this patch adds a no-op there. Fixed in v5 - the stub now returns NULL
for a dead root like the =y version.

> This is a pre-existing issue, but can a parent scheduler bypass the
> newly introduced dead flag and invoke a torn-down child scheduler's
> ops.dispatch()?

Not reachable: scx_sub_disable() unlinks the child from the sub hash
before setting dead, so scx_find_sub_sched() already returns NULL in the
claimed window and scx_bpf_sub_dispatch() bails before ops.dispatch().
That path is gated by hash membership; a dead check there would be
redundant.

Thanks.

-- 
tejun
