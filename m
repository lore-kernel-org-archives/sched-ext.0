Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B3034C98C;
	Sat, 17 Oct 2026 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262629; cv=none; b=jQKHdLQHd9mO2MBVqBLOdxHJgaYOmf7/v853kTeK3a0HpjnFS6kXpfxHJO/Xe6NPBRR8cJmd/hO7U3D+LpaVLJ+bdGqj70JEw5yH/0Aifqs6heYaWKlP6ZXFWNYSJzoaKn0zEpcSl8GhDcXWJkdTvZEwgyocHxBsl8L02Hc1dKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262629; c=relaxed/simple;
	bh=y8ExBTAzTHGONyxcdjk6r0G3qPFtynGEMKvBwzEZZnc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=n7gYLHFabmCZqsO5bARLGrSXMHe5+55psZ+Um2+Er3sReN7pgEAw6A9BydJNiYJwurK+HurqQP2GiVzPhj3QJ2zuSl3gtefEY0z6r6zQTEVq6IaEyfFt1UMoG1KGKpyrF5gWdU2cMN8Xv7ZUzM4R5rgqd7wOL1rAaS+5V/U8+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AferkPHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AferkPHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E841F000C4;
	Sat, 17 Oct 2026 18:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792262628;
	bh=y8ExBTAzTHGONyxcdjk6r0G3qPFtynGEMKvBwzEZZnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AferkPHk+yqBL49ynhyotZXW+u+UfjQitJcKGSFg3X2jedIPzj8IeTb7GoYBduS1O
	 9CmKriNGJrPxRLBGPlq3qCu0xJLZRT4H6HX/iqj8CJmeM8DgfBPBHA8ZEa9lr+OJy/
	 /stukboYQT5MVjwX39MfElX7cbaGH+qrbCZFL0z6Rd1flkLHtMVynZDqNJJZmWRzY5
	 3UtO3r6bzUqOPLLkKp2oGE/SFtmF5s6zOjwopWaleXW6o1tKBmqbsmPTc4Hno1SX4F
	 gU6FZZNAg1/QIbDKoJEJlRDoNoP6XD5+wuA924MxgwOK76rxqvYWACZSj9pbtVSUZP
	 QCHhGJbAHuMow==
Date: Sat, 17 Oct 2026 08:43:47 -1000
Message-ID: <6ee796c005fe3cf9d5c3d29aecde0079@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 5/6] sched_ext: Report the ecaps loss when a cpu goes offline
In-Reply-To: <sashiko-outbox-175737@kernel.org>
References: <20261017164556.4136807-1-tj@kernel.org> <20261017164556.4136807-6-tj@kernel.org> <sashiko-outbox-175737@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Sat, Oct 17, 2026 at 06:14:02PM +0000, sashiko-bot@kernel.org wrote:
> The comment notes that scx_enabled() cannot change during hotplug, and that
> without a live root the ext class will not be picked and the wait would never
> end. However, static_branch_disable(&__scx_enabled) in scx_root_disable() runs
> before cpus_read_lock() is acquired.

static_branch_disable() takes cpus_read_lock() itself in
static_key_disable(), so the flip waits until the cpu down releases
cpus_write_lock(). scx_enabled() stays true across the down.

> If the offline CPU had not yet picked ext_sched_class before __scx_enabled was
> disabled and ext_server was detached (for instance, while a fair or RT task
> was running during ext_server's dl_defer window), __scx_process_sync_ecaps()
> will never be called on that rq.

The drain doesn't depend on the ext server. scx_offline_ecaps() runs
from sched_cpu_deactivate() after balance_push_set(), so once the
hotplug thread sleeps in the wait, balance_push() moves every task but
per-cpu kthreads and migration-disabled ones off the cpu. With
scx_enabled() still true, the cpu's first pick with no fair task left
runs the ext pick, whose dispatch_one() processes the marked sync.

Only a per-cpu kthread or a migration-disabled task that never sleeps
could hold it off after the ext server is detached, and that would be a
bug of its own.

Thanks.

--
tejun
