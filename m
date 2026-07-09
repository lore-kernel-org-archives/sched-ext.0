Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F13E92A9;
	Thu,  9 Jul 2026 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636123; cv=none; b=k4lqr2e+jZpPXstmXA1QrQdtA9yOmNN8KnlMmpZ70Gmshn7j1/FWIU1sogxF+WM7VYLLFil0fRuXb0zio8m35yeaZ1h5AbhWSro1VWqUIZrXQcq3/ahLBvvS62zcK5HJw5uzmdpuzccJHKKD9FXaty2/82GSY9U693/1USLeH78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636123; c=relaxed/simple;
	bh=yukayPXSXwumUTotp0xxSs7h4Hv8FuZGTAQpIwkgAZw=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=hTb9knx2hhKrEiVK9ZGCzBPvbMy7lMNVXAsdI9eTk7mq9VuAsjdD5foATpcTEsGVm08Lq+1TEcrBQNZtr61ZWngR2lo2h9EJh/34r4ajX4jiVw8hZ+XY9LcJc+3KB2zpUB9N4mmneFZUmcSgNwokWfDk4meorcerTXlusW9MC2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwa3Gcax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwa3Gcax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252921F000E9;
	Thu,  9 Jul 2026 22:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636122;
	bh=UKGis5kLe7KAxMRvg5ZRScszf40L5DWj0e6MqmTd6yk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=lwa3GcaxRSSAytjJJPwVG/C8TXWc2a1ig4Peje4TrAgWiN6hFcDpiaJ+6Sz7tYnrn
	 /QyMtvvwNNpYiyw8wmHHl1Us7iMErLzdXSMYDXPczkUZeXv5i+1G6tWRXOe6W8ESdx
	 oP4IEbIc/1rjbyT4paCy5zmsXNlm28ALa2qyKqwkngyVeq5wu2tS4G3bxMiM7UlmbH
	 At+oz5w8VMgpoLAZWaXdi6rkkakEXhmS89kdS6ov04Xe8O1egmB1RCZJfsVVat//lU
	 X0lULqxEm/jJKI1/dJvAgBeDtrAnSdEbrC+Mjv87yXBkmwB6ApGdqWFc32lTAQmQNq
	 RchsqWc2GWlLg==
Date: Thu, 09 Jul 2026 12:28:41 -1000
Message-ID: <ed79c466f00108cc744439512edc032e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708220220.87C181F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-25-tj@kernel.org> <20260708220220.87C181F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 24/40] sched_ext: Add sub_ecaps_updated() effective-cap change notifier
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 22:02:19 +0000, sashiko-bot@kernel.org wrote:
> - [High] `scx_discard_ecaps_to_sync()` loops infinitely if the target
> CPU is starved by RT/DL tasks, stalling scheduler teardown.

The loop only spins while the target cpu never runs balance_one(), and
the ext class has DL-server forward progress, so it gets cpu time and
drains the node even under saturating RT/DL load. A class receiving zero
runtime forever (RT throttling fully disabled plus a spinning FIFO task)
is a pre-existing system-level failure that breaks far more than this
teardown path. No change.

Thanks.

-- 
tejun
