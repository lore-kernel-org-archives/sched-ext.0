Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F647D94B;
	Thu,  8 Oct 2026 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450619; cv=none; b=a6lQgWB8XzgraQz4jlg+tKf8Eiw/K1oCppv6Ecds6uwAm33sh6fzl2AEH7WYyuDYu409Nw1Joo95BBEoaFY351SMUsSUJyNnq3ebh5HmB4/EG/aitCxYBaGYVlm7huK/qwaCLRk2OiIcLzStATGDI5qrJoLFEaZMQGPfiI8wDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450619; c=relaxed/simple;
	bh=gHXiZOjSPhy7yIYQ5MQBzefZj48yRXjuS8rQGuDjlMo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKgiUofXdv1l9Ph0MQN+L3o/b7v+uBKiU2+Ylv1rvt6dY0+BEKYWhl7pnhrSd0V4YXxlnnLxqjeoXKqAjc/XKdkXukUlgKkzynezZKMocNoOd2Q4QzHFzW3YUvBvj+6grH+E+vBrp6CJtLEeFhNsN/cz8P6x1Uu0uKROJ9UohMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmPTbvLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmPTbvLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09DE1F000FF;
	Thu,  8 Oct 2026 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791450615;
	bh=9cHiO4vEi5SO1lugwnlKoeeteE2nFoFExmsN+xw5w7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dmPTbvLyWbFIYgOl0WwR6UYrL10nJp4xNJpAuH2/Qdagla3tsQQ/u/fCX2yxmHOlD
	 0a0yvk5uXmbApa0R93L/eVqdnrKW4w8CYxcpgNH6HOdKxYNhTWrXchyVTey7d1jA8u
	 3EzYfnnbm6wnIYaH0sq5nthXsAuhtMDZ/YvOm2RMxN/5qjgaD6dCOdvgnfcMJDdD5N
	 B7qGB3aoZd/xWN4YSaBnYTz2904+KjznimhFX3ybFHVr8q7UI3qLKMqERfAYgoul1y
	 0Ma3/oLz4Kl6T71z4eSL/UV33+MwKLeqF8yLzN8yCezI2thfRXq6YOd17rOMqA5bZl
	 GzzyJ7emzcwZg==
Date: Wed, 07 Oct 2026 23:10:13 -1000
Message-ID: <68208eef89abff9423de730ef585327f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: David Vernet <void@manifault.com>, sched-ext@lists.linux.dev,
 Andrea Righi <arighi@nvidia.com>, linux-kernel@vger.kernel.org,
 Changwoo Min <changwoo@igalia.com>
Subject: Re: [REPORT] sched_ext: sub-scheduler tasks are severely under-scheduled vs root-owned tasks
In-Reply-To: <163e2397-0e3e-4cc0-842b-0d36598d13d7@linux.dev>
References: <163e2397-0e3e-4cc0-842b-0d36598d13d7@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello, Tao.

On Thu, Oct 08, 2026 at 04:36:49PM +0800, Tao Cui wrote:
> A pair of minimal cid-form test
> schedulers: a parent that grants SCX_CAP_PERF | SCX_CAP_ENQ_IMMED over
> a cgroup to a child, and the child writing cpuperf target 1 from
> ops.tick().

Can you explain exactly what you tested and how, including the scheduler
source and complete reproduction steps? This isn't a useful bug report
without that information.

Thanks.

-- 
tejun
