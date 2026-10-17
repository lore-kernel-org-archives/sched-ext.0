Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F8335564;
	Sat, 17 Oct 2026 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792251293; cv=none; b=s5f5RAHwU9JTJhxsFGLM+CWWBWcUMYrh9KuN45bOMee2hTtdskEvPKzH8kp6eS1G/7JyxP8orH5SrUZ+BAbv8meXGAWPU288ctsC2Qys5CF7lAQqQRUBr5sP/IWWOwVyj5DTWqADJOJ961grSdp7HFnGVaaUcEgdKF3EeidsCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792251293; c=relaxed/simple;
	bh=knKj83kC9Pa15/JKa76TN7pqvVyqcXpP+n+F4bX8X0s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=WH+reTPRmsEwdZidOg9KQ57iIUv9w2XFNloVX7w6Z/Rn/zgGJOOYr1eMwul7NOyJ2NinQ9OkpQJvrYEFpquZjmzWxwy+u2iIQmuRsjq7faNcD4zmdWl/5H5LE8uUBLV86o7uMulPf8k4VOxW1i/pHSRSoa0dke/dm+DiwZOoxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOjafvyB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOjafvyB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECF31F000C5;
	Sat, 17 Oct 2026 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792251292;
	bh=P6eSEPDU4Hu/7uSKGKQaQE94wDVs23XOfBMz/+7zl6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FOjafvyBmuiGkt3zUVM0tQNfjhCYRs5wgJ7KNVkGSRrE40Gj1xTYPfhsGMjL4Rv4F
	 M3iz0eeHyarYMyHHqEKOjTXtvUbVZee0sd/dqWIfz/Q1qLZ4J8OMG6yah7SPrR41R8
	 jiac+WSORa6Wvc4E8KUqNuCg5CkRfhBU+7ff5rEO+4DFXv4vVkCwFgtHbmHJ0i+8eP
	 jSaXEL14uVhVEaY97qXVMqxci3joeuJwwrKPvY/F7pqu4S/NIMsDgkgm1YRGutM1BW
	 wK6KNXXkvuvfZgwjbSU99PiBEkoaF67gTKDlk70Ce07BiDCGoDK37IwwD9lRVoUMUN
	 QYrjKvBZNCE/w==
Date: Sat, 17 Oct 2026 05:34:51 -1000
Message-ID: <5df189160a62dada9a26b92404addce8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix bypass leaving the running task protected and bypassed tasks stranded
In-Reply-To: <atNKHI9K-_Rbh9Og@gpd4>
References: <20261017053717.3162619-1-tj@kernel.org> <atNKHI9K-_Rbh9Og@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sat, Oct 17, 2026 at 12:12:44PM +0200, Andrea Righi wrote:
>  - when merging for-7.3-fixes into for-7.4, with proxy exec the slice and the
>    protection belong to the donor, so I think the resolution should use rq->donor
>    instead of rq->curr, both for the strip on bypass and for the eviction on
>    unbypass. With rq->curr, a blocked SCX donor would keep its protection into
>    bypass and we'd act on the proxy owner instead.

Yes, the merge into for-7.4 will use rq->donor for both.

>  - not a regression and probably transient (I haven't verified it):
>    bypass_lb_cpu() doesn't look at caps, when the nearest non-bypassing ancestor
>    running a bypassed sched's tasks is itself a sub-sched with caps only on some
>    CPUs, could a bypassed task still be moved to a CPU it can't stay on, until
>    bypass lifts?

Yeah, that's already being worked on in a separate series.

Thanks.

-- 
tejun
