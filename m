Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C51DD9AC
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126469; cv=none; b=jvdRPgj4xruNfXftRo14k0W6+tz5FB2hdsYDUOUfBP8aoTe0U5sWr+NLkJHMgUhpmqSUpVIk72NFIE4rm6VtZRjr501DH9fdD7S77ClERvcR9dX/LjXLFzai8M8ZVlwXjdQHqvVgNNSggULHlL5TX2mpqz/8w47lp0Xu1Wan80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126469; c=relaxed/simple;
	bh=SN9ahTtnq/MgVNLlsh7Pb/kpYbXLhGKCOuGCex4MUAI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=QPCvgChCfVDAxSTpUtkS32/Qz9FRDSEXOOT+I7qG2hbvDIzvwBl6qVuHUN+sEkeFG3jzm7zz67rL+0xvX5J0OM2MC5WtWMQjU5xxKJs7XlUsnskXr9aXgXj3OvlL5Fk1f4XgZr/vexvyTA0qc1UzQ2+5M+MWRRSZV6CyM6IHMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REOYI4ky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REOYI4ky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947A61F00A3A;
	Sat,  4 Jul 2026 00:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126467;
	bh=SN9ahTtnq/MgVNLlsh7Pb/kpYbXLhGKCOuGCex4MUAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=REOYI4kyuw5G7MeEz+49uZlfoyP5wccJLrfcqRy0AT8ph5LOkD1WB5HqCxbVonQxA
	 /QVISsqunnMd/21g0JecWrNGaRgGb+uBgiOgdebsnsx/TFFAmeOSYSRuTNr8nyB01S
	 d437BOndcL6F6hNNJeBAI4P+NhESb0E2UpzvoGlowv8LK8l+geFqeAXDtfXF0Tc9ep
	 qmzCXJv4w9YwLO9+hCjO8qy+MQdd1JqO53eEN4Hck03C90WPOSOTX6roqPjm1tiiWm
	 JoWmK6WUpSvgD85n618dsdVZIp0d+1fo97dZO26428nL91h8+JgOxmf9+8V61gOi5z
	 PQbDLHo1u+jQQ==
Date: Fri, 03 Jul 2026 14:54:26 -1000
Message-ID: <1b938308c11af04b9915084da21a19c0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 14/32] sched_ext: RCU-protect the sub-sched tree's children/sibling lists
In-Reply-To: <20260703104933.0151D1F000E9@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-15-tj@kernel.org> <20260703104933.0151D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [High] RCU-001: Remove Before Reclaim Ordering violation during
> scheduler teardown

On unlink vs. grace period: the synchronize_rcu() before
scx_unlink_sched() drains in-progress ops, not the free. The sched is
freed by scx_sched_free_rcu_work() via queue_rcu_work() after unlink,
which waits its own grace period, so the order is unlink -> grace ->
free.

> [Medium] RCU publication order violation in scx_link_sched()

On bypass_depth: v2 will write it before list_add_tail_rcu() so the
payload is set before the node is published.

Thanks.
