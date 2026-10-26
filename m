Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050293;
	b=HG68szJaljswVwBhJaQ8pTGbV8qOLuqg3FWNdw/E+7/n3jcEyhMnisvyadMXth2gfcfG
	 7Z2XDqCQ57e0Y4vW+zrOcocdazKQnYmWhI9T6+siB9pterAU8TvHwppFvqMLLwek6a4OU
	 oi6gRnVKL6dt/bDLW9Ig2slgtDtDZrm+imiX3164oWJrRqHRGGJjv5Y1HZZiXB+fZcULm
	 sDkzqL1SFzulQ1E21h/8RmWp1t4b8DcuywDEyy4T/Hz54+h5fwDkPjRx2EqvbdT8MZD93
	 bzTF46HPKr1+A+t1HRXjBGAGqQLEVBDc3mHVUO3h+HQfcEYkAaENtXpmcw9MzgTmbCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050293;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=fvDEfDKrOIFMJbdC7jL9RLeUV9T1wiYhfnqw8lq/hsQ=;
	b=zRkP5rZFHFmSBHIPNtdfwN6hBbN/D1NobymvF0H6o8aIsdPh9N/29g1p78ICC3Z1vHlv
	 eKwLRO8dRoll5WhuYDAkVLYC5GpNqPb1my7wrm4arcoE+lCOfJwKzmon2jbUKv0EgA0T5
	 ECzigFxgzM3z9jR8dSidhqVjm5WAu31o1hRQxDazair3oj4+wMTlOrdRLX/Th3NZdmkCP
	 s7xxuKzkLNMOPardQrSi1P7d4bVEhhQp0HNI2G5k4bNc+tT5zXZQOdrHjQgEjHOsgtjnp
	 4+Fjzd1N4T7FjmY28OTK+2kgup8uXm+WNwVLkYjBoPQFLJzSruUDeitlrB6WMoxN8gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oZAU/SE3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD54606A321;
	Mon, 26 Oct 2026 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZAU/SE3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C333F1F01825;
	Mon, 26 Oct 2026 21:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793050293;
	bh=fvDEfDKrOIFMJbdC7jL9RLeUV9T1wiYhfnqw8lq/hsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oZAU/SE3g2YWzW10SrYrEwpjWX/+YKQDmnDJHitZgE6hehs0BQOnau53/1FVMkYMl
	 b0lTZC4/Z6vsy1TYceGW6A+Z1e0DGnV9cTY9IDSkxNk5sA4eU4AgEMMkf04/K6v9W/
	 Y9sqhwTK9SsF9TrQgJ1+ujAyCQWBeioC78FEPogSDBf5Ytpp5Nu4VncLUq6lEix8xH
	 4SWUpeD1IIsroV2dIhpKUHDOK8aTQRjEarL5YjwVWCn/YAZko2F6cmRb8zWaM0EOYk
	 qMFg3sPeXoPG9YLm65QAyPokX2J83mRI7QY3yEs9P1HaEMhw0anfi4WzpBzKcCAeTh
	 YW92v0fSj5IqA==
Date: Mon, 26 Oct 2026 11:31:32 -1000
Message-ID: <3e758373745216d349e2d70afb42b7b8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 19/17] sched_ext: Fix the stall watchdog blaming a bypassing owner for a stuck task
In-Reply-To: <at4l0yXTk7T_ouk0@gpd4>
References: <20261023175608.4120910-1-tj@kernel.org>
	<20261023200640.272834-2-tj@kernel.org>
	<at4l0yXTk7T_ouk0@gpd4>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello, Andrea.

On Sun, Oct 25, 2026 at 04:52:51PM +0100, Andrea Righi wrote:
> Should we recheck watchdog_timeout after changing sch?
>
> The stall test above uses the task owner's timeout. So, a bypassing
> child with a short timeout could potentially cause its host to be
> ejected before the host's own timeout expires.

Yes, and the same mismatch is already in the dsq->sched blame that
2c91169377f4 ("sched_ext: Blame the DSQ's owning scheduler for a
runnable stall") added, which is in v7.3.

The blame doesn't need the DSQ at all. scx_exec_sched() gives the sched
running the task: the owner, or its host while the owner is bypassing.
That covers both the bypass DSQ case and the rescue/local DSQ case this
patch handles. The watchdog blames that sched and uses that sched's
timeout for the stall test.

The task's wait also carries across a bypass move. It waited under the
owner and then gets charged to the host, or the other way around when
bypass lifts. The fix restarts the wait when scx_bypass() requeues a
task, except for the root's own tasks.

So, I'm dropping this patch and will post the fix on its own for
sched_ext/for-7.4-fixes with a stable Cc.

Thanks.

--
tejun
