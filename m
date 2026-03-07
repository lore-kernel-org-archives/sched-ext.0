Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F62690EC
	for <sched-ext@lists.linux.dev>; Sat,  7 Mar 2026 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772910703; cv=none; b=IA0AbCzZ5EvpgItcvIOmGYAO/xXH+2NAqsTxswBwWtwArLrMMOZgJuuZCRutKkfylNkRqkXzBh67Bt6t7qGN1p6HqGUtGm0EAQ38cZiiBEzGwmdHXQIycjbO0ZX4IvhA6dNqHnC0TOxKEZdHYUVoHITItf7Meiv1Izvl9XMXBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772910703; c=relaxed/simple;
	bh=ZZNPgAT5sUIf0nI1NirtDnwnRxRUhZfJVWDBBpox0MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0qnlNHUdGKF7B3fJ0Ah0fOPKbctP2L4JZREyB14cmAOA4oRyMomdiFrBRwfPn3sj79mN4k9tFWhk/UtouciVMAA3tZdLHgYCV347heZ8wTZPyEAziNcaQWmYxKsN3XHwf38UNyT/1lecPwnXY3IR5GOaP9WCseY0cm8gFT/KFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZntY1zf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZntY1zf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013ABC19422;
	Sat,  7 Mar 2026 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772910703;
	bh=ZZNPgAT5sUIf0nI1NirtDnwnRxRUhZfJVWDBBpox0MI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZntY1zfBFBJlGEmGL69ZbZJjP0g/Qr8deT+Gal1DqhSHgd+yTeaIP5p8xt4RDRFO
	 9LmSf2/3vI1QF5V+vmdpkPzH/zMMUWQ//AUeqRtn9+uTMQBruPsFemTRZKHlPc4mwh
	 6nQ6lrSBfb24o+xGWB1C50VOfR4rUhRIjmIBgJ4a/nFu0mM5xsbKnvDWa0pf9VyQ+n
	 /+H3W4kibS2FPZGare+4pX21aburdAX2hqDVvjY0MyPDWhC49QuI02FRzht0BY/+BY
	 ZnQBp5we7rsuaGrZcTSkqFb4h32oLG1XzkxvQUeDqG/1de9c6/Wg0ld9d8C8S6SCBQ
	 6SVEQe4aEWfpg==
Date: Sat, 7 Mar 2026 09:11:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] sched_ext: Use READ_ONCE() for plain reads of deferred
 reenq flags
Message-ID: <aax4btmx6JIQLBc2@slm.duckdns.org>
References: <20260307190843.4117532-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307190843.4117532-1-yphbchou0911@gmail.com>

On Sun, Mar 08, 2026 at 03:08:43AM +0800, Cheng-Yang Chou wrote:
> commit a90449b12682 ("sched_ext: Optimize schedule_dsq_reenq() with
> lockless fast path") introduced lockless reads of drl->flags and
> dru->flags via READ_ONCE() in the fast path of schedule_dsq_reenq().
> However, four read-side accesses in the locked slow path and consumer
> functions use plain reads without the matching READ_ONCE():
> 
> 	/* schedule_dsq_reenq() - local DSQ path */
> 	WRITE_ONCE(drl->flags, drl->flags | reenq_flags);
> 						   ^^^^^^^^^^
> 						   plain read -- KCSAN data race

Does KCSAN actually trigger on it? The writes are protected by
rq->scx.deferred_reenq_lock and reads are protected together with it. These
shouldn't constitute racy reads.

Thanks.

-- 
tejun
