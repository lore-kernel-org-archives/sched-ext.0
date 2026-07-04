Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5AD13E41A
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126471; cv=none; b=LNxK5yuMOPG+4VqnRzKlCSD7Dsnc7RUwfWwSJhnRnlJweVRzUXHMkvhySf4tY/ZCF7oTx/pQQSG16lUxN9kt6fJEPFccihVexH3HWrRuLHy//koSABs7tRnKVqU6M5d3A+9byHFnDE9oOO01SlZZciDb+F6otuxvsJOY9xYcQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126471; c=relaxed/simple;
	bh=VEmaHY7E12HHAzLFRo2NAW8ZycfsIX+LpH0zN6qCOOw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Gg2PZDEQFgAUXpttMe1gGwtPUcc32QFk0FL5YzegTste+4/D7POcDXVlzvNJSkd3vl1OvAG0TZgdVyc0n6Dofs6ntyGS97HhQVoTHTYwhiQCLHaWPZStjBS8+95cA3Nwl8gSBzFdRL4s4a07gFMMvq9gjJlDLURVGy4FYz4UKco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/iIslPt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/iIslPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CF41F000E9;
	Sat,  4 Jul 2026 00:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126470;
	bh=VEmaHY7E12HHAzLFRo2NAW8ZycfsIX+LpH0zN6qCOOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K/iIslPt/1fS44ZZe44UO0uaLxLnGn6pTlcxmFW5Y44LSfhQqPoE6XUMablhifR8h
	 o/4dvxSXP4VYTAx78KfeHGIHEb/h1MNlGIsm9yhZq0A0qQm9baxj4aBkJJPQQbmelt
	 S6TmEsSd5X0VSzxYkh1qh6wUUdkkrIsQSheLA8Lrh2Ff1Apu8qk5UVXUciddYuTX9h
	 4gD1QaWwa53XkibtAbrQFruWHTM+iyyhPHioLEhBTtOfWOsZ0zFr3s5ysxixiE046X
	 B+qlgHMwmglzXbtOaV0/HrKeo0wQeiIuiv3EIwERnVuF6tSyEyL/Rbu4m8KyFHBw29
	 NfhA85MaXZ1ew==
Date: Fri, 03 Jul 2026 14:54:30 -1000
Message-ID: <09530649ce94e18e60061a448d9a6714@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 19/32] sched_ext: Add sub_ecaps_updated() effective-cap change notifier
In-Reply-To: <20260703122514.03E091F000E9@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-20-tj@kernel.org> <20260703122514.03E091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [High] Early clearing of `ecaps_to_sync_node` in
> `scx_process_sync_ecaps()` causes a Use-After-Free of `pcpu` and `sch`
> during sub-scheduler teardown.

pcpu is freed only by the post-unlink queue_rcu_work(), and this CPU
stays non-quiescent through balance_one() (the rq-lock handoff keeps
IRQs disabled), so the grace period can't complete before the write.

> [High] Concurrent freeing of a sub-scheduler can permanently discard
> ecaps syncs for all active sub-schedulers on a CPU that is coming
> online.

v2 will change the discard predicate to !cpu_active(cpu). The online
reseed is queued before SCX_RQ_ONLINE is set, so gating on the flag can
discard a live sched's reseed; cpu_active() brackets the reseed
correctly and matches scx_process_sync_ecaps().

> [High] scx_discard_ecaps_to_sync() can hang indefinitely in a worker
> thread if the target CPU is continuously executing higher-priority
> tasks, locking up the system RCU workqueue.

The ext deadline server guarantees ext_sched_class bandwidth, so
balance_one() runs and drains the sync. Disabling the DL server and
saturating the CPU with higher classes is accepted starvation.

Thanks.
