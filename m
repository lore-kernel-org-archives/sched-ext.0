Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6D25A354;
	Tue,  2 Jun 2026 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436109; cv=none; b=kUt9VeH0pDW43F3f2F06WIp/nWwjmV5gUtfbTdmUqHP7IvyMN3fEws1fWizOtdt5xkduKGAK1OAh9j+OSkPE05ZJP22XjY7Gp+/vsrwCZ6k1WEZLWxdfCI0XL0Lqfw7Xi6qnWyQnVpeldXrrwgJB2CYr8xW9kstHoqRznpbtPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436109; c=relaxed/simple;
	bh=REfy5mn8nQwaNi6G6ovusUsfMY9q6eD6ChWnuc9SBks=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=tCuIqMFs1zd0c6kPGaVhMfWx3wWPDwAqHB9VU4v9JhlPFNygkRClMhCHyKUd54VV+rVaOAfqYBjQTBrk10BeLckjhcaQtDC6cba4yA97Sq65/Mf9XtgZiIEijkrHqE9QikmIfCj1Tygp53ARdfaubAWmAuDZTc2m4hS7vVECzHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYAQPZ7x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYAQPZ7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104F21F00893;
	Tue,  2 Jun 2026 21:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780436108;
	bh=REfy5mn8nQwaNi6G6ovusUsfMY9q6eD6ChWnuc9SBks=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=DYAQPZ7xkR8OS0eF+M/6M84FZ5nuIBWgQIc6XFR45V/fZZLEYOwrKi31VMohhohgb
	 oK8muedj8x2/hFG7eIa57Czd6EXjU6HIUaXMdsYUUzeBoYcTbw83rRTvrIp0IU8ICg
	 q8Lhj8ftYWwDWe0mtQZS6xuM8VjG/TWSCl0CorAYSzIUDdQSkHqjrVdpNfebwE5kWx
	 oIvM2a530pDIWjBHKaiKQXH6YWwH4W/cNSTUzhkMjUlYn1L6zkpplOL3CgkXizEo2l
	 nBybrRVya7gXD748O6jDo+sWP7cUj9lOZ5PqcZ3lRL8DZ30/CEWSh1hwdfS++t/xGQ
	 F5HDzTt8zGRmQ==
Date: Tue, 02 Jun 2026 11:35:07 -1000
Message-ID: <2b340d37989e89733df49c23f3ccd26a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Matt Fleming <mfleming@cloudflare.com>,
	kernel-team@cloudflare.com
In-Reply-To: <fd46c41cbae0ea3194b9d8c1c8efcefc@kernel.org>
References: <20260601124156.2205704-1-mfleming@cloudflare.com>
	<fd46c41cbae0ea3194b9d8c1c8efcefc@kernel.org>
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task()
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1-fixes.

Thanks.
--
tejun
