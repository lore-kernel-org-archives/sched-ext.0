Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8533C3F58
	for <sched-ext@lists.linux.dev>; Mon, 27 Jul 2026 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182575; cv=none; b=mceYMOGI6ElWScXiB03wp4Pwg4ktnaBaUjHgdGOmuPQiy3pcRaRZqYHXh/MtC4t9vQNPNxwVjFMeASwWuXoBCj6AS5OBvBFFjToa/ujKCb1F8fHiP++5gE3naBZPf/1YAKHOZKqCMAkKYwtRgu2jo1v0AFnZjkjs8JpnNF9WgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182575; c=relaxed/simple;
	bh=cTNwrvAoJrZzLxe8BUTGNuni7BprgmS7imIk88xAgwg=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=WgZLx8h2vczNle1jEA9qrCCM5Kw/wgCJFIsC0yI3/3METdO6aQwjM3Xy+NFRzruVdv2D6FrzcFT5GI7baNE/eJw7wJA2yr2DsTj0GjCbVl1yoxd8DGi5f/KsInMcPLo/4Pxs8URRj3qQIxbA9JiZnAWdEgzKdCPwEnO6X+FnGug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jd5vIGyj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jd5vIGyj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27151F000E9;
	Mon, 27 Jul 2026 20:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182574;
	bh=cTNwrvAoJrZzLxe8BUTGNuni7BprgmS7imIk88xAgwg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Jd5vIGyj/PJUINZOwzgSiEVRw0EtBnH6i1effn9ai+RwNBjP1coVNfrOhaxwJjbU3
	 Wp7V0yFbo9gwIGj41S7u0lyfjYW3OpzTRqAtHH7dFLnJgsywsHdzfH0m/NRJC4DOoD
	 zdSlxv3lyWyr9Nqq/YIhX1PlfVtGRhuY8EM5PUcScFltyWBkWr3t/4Xqe3yknkKRZR
	 BcqDiQF2hri+Rm8XmqF6iz48VF0pphwj6DKFgkCmeeTwK9aoCnu+Qe8o+WRKiutMHV
	 VHMp+2Z5VW+wxiH6wod0D0EioPg/VjkZD8RElld7/itUptOSDzlbmrO+0K1sLFUH8b
	 0l+6e0vTDVqzg==
Date: Mon, 27 Jul 2026 10:02:53 -1000
Message-ID: <e111bf08e6f123ae25b9281cc5a03fa5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260726220016.D958B1F000E9@smtp.kernel.org>
References: <6649066b805d5660b598f3155c30daac@kernel.org>
    <048d8cc6b8e9be48ec0e6e431afc75cd@kernel.org>
    <20260726220016.D958B1F000E9@smtp.kernel.org>
Subject: Re: [PATCH sched_ext/for-7.3] tools/sched_ext/include: Regenerate enum_defs.autogen.h
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Sun, Jul 26, 2026 at 10:00:16PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Is the SCX_REENQ_LOCAL_MAX_REPEAT to SCX_REENQ_MAX_REPEAT rename actually
> present in this tree?
>
> Looking at kernel/sched/ext/types.h, the old enum name is still present:

The rename is in 7706d6e4f2e3 ("sched_ext: Bound per-task reenqueues and
eject the owning scheduler"), the commit right below this one on
sched_ext/for-7.3. The review base is missing it.

> [Severity: Medium]
> Will this cause build failures for BPF schedulers that check for
> HAVE_SCX_REENQ_MAX_REPEAT?

No. With the above commit in the tree, vmlinux.h carries the renamed enum.

Thanks.

--
tejun
