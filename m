Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624536;
	b=kuR9XXMmAuvq4Fyl/wgCkrM+evG080ircLLaZUQCo83Bk4+CeehMFme0RtkRxzBbJrG/
	 ayTkUr95DcHOHSnufzcZE9tjmqvOfdROQxafzosEWpzx95fq8hcqtkEtOWRSX8r6pNLWv
	 Nr01VvXcMOURudq2SbGOeDUfmKStn2m3bcUgNPglE/RXN6lJHa4hwaekxJsISgxQqyFwN
	 6N+oKs2162sKP/akyrgJcM11mfMKnMVlgyt0RvG9QKnJGmye2QE5PFYdxO8/yfDQW8afn
	 f/wYSFfgMjs6LMGTuwUz3hLpyGApVBNVZCnAhsaLp/4QV8NW08HsZgwbEOzw3cn6KBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624536;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/YKfZM6yT5AZ153zVZKdwhkCJPeZ7HtGqlNJPbIPqQg=;
	b=rKA+aMDzFiQKlDZ0ve6lj1lLesLxUTI2bCa378dYbjo16P4+sHPKrpKtqD9kAAY+y/zq
	 UOI0Yax/X9SHiMASjJjsIexXFBcrkozOyhnBsLuVOU0HqFacd0JAtI9r6+RktplgUb3CW
	 KNlZJXRL2qSCv3fgkMWIjVqjVew1pvm8byFOebgensJjg70BT+UG+ObFwmgg6LTa39Pw8
	 u9rkxT52vGAqxwPQAFz//BrO6N/zXkguTTALcAkNjuOlqt4a3Bzz/0B5mlfnilUjUI3hY
	 zuGtSL+kLEpvTR7a5N2x/1AqHZP5ODH6mbHb5LCr2hDFAspXps5DA9FxBrWAgS4bWxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFHivguQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027EB606A33B;
	Wed, 25 Nov 2026 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFHivguQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924A61F000D2;
	Wed, 25 Nov 2026 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624535;
	bh=/YKfZM6yT5AZ153zVZKdwhkCJPeZ7HtGqlNJPbIPqQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YFHivguQLEZIjapphR280eTXn39iPRY9e5/0zRzPyVK7ZTpeliiugQQNuur5Ogscr
	 O7SAzLe76I7JpKBOpR1tXOtte/TIQ9k6rXTf4WO81DW09V918VIZibn/5ev9mhBH2U
	 53H7e40Yrc7f6tlyTRqknMB7S8NuJWtzRDQ/+XJV7uMMNDlOXFJCH0lLigYBDa1taG
	 Mt20EmTMJgyAhrHvNNXfFNsZpKQU388Cqy1pVRbeHhwZv/HeLUT5Vr5BzAWVvuYwAq
	 lp5I7zVTUDJHwXIVOaXxkMue/UZihhaNt11+9h5/mu5BgleStawueXt14tmlLjhJqK
	 FnUOJI33BKtuA==
Date: Wed, 25 Nov 2026 06:35:34 -1000
Message-ID: <456251eff6ba27382294d6478969b856@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, fangqiurong <fangqiurong@kylinos.cn>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.4-fixes] sched_ext: Fix ops_state and ops.dequeue() locking in dispatch
In-Reply-To: <20261125112553.1539758-1-jpiecuch@google.com>
References: <20261125112553.1539758-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Kuba Piecuch (4):
>   sched_ext: Factor out release_dispatching_and_lock_task_rq()
>   sched_ext: Fix ops_state and ops.dequeue() locking races in dispatch
>   sched_ext: Remove scx_wait_dispatching()
>   selftests/sched_ext: Test that ops.dequeue() runs with the task's rq
>     locked

Applied 1-4 to sched_ext/for-7.4-fixes.

Thanks.

--
tejun
