Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26662CCC5
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126472; cv=none; b=KI87m4JPsb7cfCoan5QfeIoLzJnj81AtiQjxuevMxymmBzHeqm3kNBtuyZwQDJIazd7UdJ6076eM49E8eHV2wg9iT8lH0xh2yI0bbdxG+C2R9aJiYY8Zheo/IYKKpQW+6oHcqUYCyeoo9gKW061zZcIhnfs/nDHcFk/SiZWamj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126472; c=relaxed/simple;
	bh=aGouokrM8mJnKJvhDV6HgF76R3G0Y9rbbW38WPCx60g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=r3DyQ3kc3ySytNch89sIB656GuFV47fi9pBnWKrjChh+XJAB4fDcJDujmggiks0wTnqwvxtysxvKyQAxZFLVMGgoXmHPizSR4uTzKUzZPGbm0aTctpcgho+1hKlAx8T3gFE4gMvreF+BLrDMN3BnDtr6xEXRHRWlH2WsHKy2DWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMEZsEtb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMEZsEtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDE61F00A3A;
	Sat,  4 Jul 2026 00:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126471;
	bh=aGouokrM8mJnKJvhDV6HgF76R3G0Y9rbbW38WPCx60g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UMEZsEtbS2+gIggwr6lMxFmTFAjl1eNSFQ9lwH3nG1FVvACTaOtHaJ/IU72GyCXTe
	 axuWCA58A7sb7Nm55I8wJHsNXQwGd0CIRhXi1mny+pZw3VzxGJKEcLxjg/5eZ13yYw
	 pFibVlHdldZzu/3ZtEJ7vi9BILSHw3y16sjz9QEFfZCvF9Uf7v2JEY3Y4jvWMjlJI4
	 chW5ZFjdyGwYaTt+rks5THz+d5veiQcvsTD4J2eGtr7dsRjs+TnK/MrrvLV5Q2y5g9
	 EzgTtIEiV9sV6c8vFBh9tKXjdNfSQxFjNLUTJ4kHoymUI5jLegyGFf8boHwxoi+znI
	 U4x1UqTJ89OCQ==
Date: Fri, 03 Jul 2026 14:54:31 -1000
Message-ID: <b15777e5dae5fbc21e411d574908bad0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 21/32] sched_ext: Add reject DSQ for cap-rejected dispatches
In-Reply-To: <20260703125746.0D8371F000E9@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-22-tj@kernel.org> <20260703125746.0D8371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [High] Infinite loop of deferred requeues for exiting tasks or tasks
> on offline CPUs when the sub-scheduler lacks capabilities.

This is intended - re-rejection is unbounded by design and a capless
sub is ejected by the stall watchdog, as the function comment notes.

> [High] Tasks undergoing migration (with p->migration_pending set) are
> incorrectly rejected to reject_dsq and then skipped during
> reenqueuing, leaving them stranded indefinitely.

The WARN is an assertion. The migration stopper clears migration_pending
before the re-enqueue, and queued tasks are skipped by
scx_reenq_local(), so it shouldn't reach here. If it turns out it can,
force-admitting it like migration-disabled is a straightforward
follow-up.

Thanks.
