Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13933E171C;
	Thu,  9 Jul 2026 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636126; cv=none; b=iNYTCRwbrpC4uxJdkDTu1wX2MdWfC6/i74W07mnX3NtDI++wmBJimmE4J13Ok+DprG8A8a1PLvXNFx1Xx1yG9L85uRXQEQiGdphuTEyry+tFjAsMRhLYkCKXPIxEAUfSowRMTzbTSuy2wcZVz1+cGuboiF5xDMfIiAQJpJGm2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636126; c=relaxed/simple;
	bh=zwGZRRJ2oRDqW2zaKxS5nwkAlH6De4VMSSS47NHmC8w=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=DWpV1qngc7TXDSspVN6jJt4jJtExYNrzUaxyWFKyfjmfVR6ll38ITjjaGxiGRiaJ+XoJcX5qPTIKYq46dam8bZ1cS8vKY2XBmXRR8xjtIzXQXwaYZr3qxIhICNz5yrvFr/9qvT0qb+Op4h9RCdXRrWd17jZzBsgwR41oV/AwXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQIgTXBv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQIgTXBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C531F000E9;
	Thu,  9 Jul 2026 22:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636124;
	bh=FUGllrpi6X4OIOp1Lgkry8O7iu6KO1kd82usB4AQEjo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=OQIgTXBvtVqxySE4dNM4+NgqFWs3vvvYIKWL6nY6PJq/KdEzz4l7oErrDV5yrndBZ
	 +dG3WHe1LPO1sgU6iRo/YAZXoZJVNSuf4qhySs+UoT8PiBsTmir3QfaJOyugULxLcd
	 sJui9kQWoRlR2yHbshHmnzk/Jjz5tsNP7gkfZN4q6AewJRk/NknNNtsKQXquTO25WA
	 Jf8zQGb/+V1Q1N/R+ZYZmmXpVYS9DHDNlOYuIZwYtXjQAQg8molgYr1N9OVVxxyUiE
	 wf7sOGv3A7enLQ7laWyAvjiPy45OKOQigBYi5GtOO8ph5VVgm2g8oZOvHkmFnswncB
	 Yht5r7Xy+yApA==
Date: Thu, 09 Jul 2026 12:28:43 -1000
Message-ID: <d31f4aeeb88036e4e77e2e296731fdc3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708215333.747381F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-30-tj@kernel.org> <20260708215333.747381F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 29/40] sched_ext: Route task slice writes through set_task_slice()
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 21:53:32 +0000, sashiko-bot@kernel.org wrote:
> This is a pre-existing issue, but does this lockless write to the
> task's slice create a dangerous data race with update_curr_scx()?

The lockless write this race needs no longer exists after this and the
following two patches: scx_bpf_task_set_slice() writes p->scx.slice
directly only when the caller holds the task's current rq lock, and every
other caller is routed through the deferred slice_oob path, drained under
the rq lock at the top of update_curr_scx() before the min_t().

Thanks.

-- 
tejun
