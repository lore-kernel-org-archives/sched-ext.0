Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967B2773D8
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784996103; cv=none; b=qvoO0KmsN7JboUK8DjcOE+zAsvTNTM7nHN44Qd1rD+s9sosYrzHAvePnIw8MC9JdEQkZ9cjoNyqQFgks5JBwGzrCK4OewvQJgULD4IH05qf69CpnpFpHLOTu10m7GY4dGH4EU3s7PmjRbEWGAqmiRTTAIyCY+YLsI4RWrZDK2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784996103; c=relaxed/simple;
	bh=H4kdwotORbnpHIA425WKtuPWl7BBqA6+Bc6Xf12o39Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nz6OGtWWXEofRzBi4xkehzOwK3Qlph8oRFe/ryrFhTFi4iIZzdvXEkh59CZ43YlYCRKhD5JW3nwravUtWsUy9UZqHl+BCtqtdR846loxWeiqxmf+AC2YsC7TTTnxe/hg9/SqXV5mt+GzrSeplBSXd0COs05z2sfVI1Q3sv+Za4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCNMc9ao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCNMc9ao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F141F000E9;
	Sat, 25 Jul 2026 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784996098;
	bh=eqTAzFiKxwEN3ckr1vpqpHiflUw4qTACJg2rmCE5tSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DCNMc9aoEO2LP2B3E3jQlZPXkKv50ORiUh8VhO/82sAjXhqVYULOrR2EZuUdecAOo
	 VwpTTfvgq1ijouf7jFFTMKMJF7yHhbRe3dEq+VFhp/WP9H1XdcY7ZrqYU/iclFIkfT
	 vKkHqlq1bQxddyq/dojlVlC8vbTqHvS/dlzETD00s6vxMx7SU59tUB5XKdQGpDTix9
	 qLyxYwTASBIP29luz2wlaXdpxRzff9+fel8woi38XY2h2h62D8X1zU7G/zghBLfEX7
	 3pn/WZw3NwSTYFVrzsAN6G3BaDzgP6GsJNJ66hl4rFMOHw0sk1PjImNvuzxWkf9HZq
	 oUWbkIRRcfsyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/14] sched: Add sched_ext hooks for proxy execution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260725160513.57477-6-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
 <20260725160513.57477-6-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 16:14:58 +0000
Message-Id: <20260725161458.C4F141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The comment explaining the `should_block` argument for `try_to_bloc=
k_task()` does not reflect the newly added `!scx_allow_proxy_exec(prev)` co=
ndition.
--

--- Patch [5]: [PATCH 05/14] sched: Add sched_ext hooks for proxy execution=
 ---
commit 273c97aa298de804b9f343db4905abce55a2409e
Author: Andrea Righi <arighi@nvidia.com>

sched: Add sched_ext hooks for proxy execution

This commit introduces scx_allow_proxy_exec(), scx_proxy_donor_start(),
and scx_proxy_resolved() to observe proxy execution splits. It adds their
call sites in __schedule() as empty preparatory stubs for sched_ext.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 66e9ba50f5639..c9d77b1e2fdc7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
[ ... ]
> @@ -7172,7 +7172,7 @@ static void __sched notrace __schedule(int sched_mo=
de)
>  		 * task_is_blocked() will always be false).
>  		 */
>  		try_to_block_task(rq, prev, &prev_state,
> -				  !task_is_blocked(prev));
> +				  !task_is_blocked(prev) || !scx_allow_proxy_exec(prev));

[Severity: Low]
This isn't a bug, but should the comment directly above this call be updated
to reflect the new logic?

The comment explicitly states that only task_is_blocked() is passed as the
argument to keep mutex-blocked tasks on the runqueue, but this patch adds
scx_allow_proxy_exec(prev) to the condition without updating the explanatio=
n.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725160513.5747=
7-1-arighi@nvidia.com?part=3D5
