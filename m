Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2967F2CCC5
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126474; cv=none; b=N0G8K7ocbWrQOcY49U6bFu0LidSjdaNdoe5ldqkdTbiuWHdJpfZKk6wEGdAxp6gJ1q2P5vBh7MxaA0wBOU/hbfUtaxqHcPiZxTqPjMu1nPPg52wviFh9VURfrwT4uLQSjBe6O3i90cqJAQxQAOCdCcSjoa9BkQgggrhkGj1DUaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126474; c=relaxed/simple;
	bh=8mPifWpz5U4PLYEqo7OA0nfZLZbqs1QyGJm7iYUBdSE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=uciHobXA1SpMd69doVPDXF52QxhN6jQCybrE9Ze7qZdMYN8txw+Pz5Pv8FhRQzDyPsJa8IbXsQIPSGSlA8BB3XcT2l4h0lUpKCap7N5674tRHgLK93pRlfm3K0xt6XYjMZvlEQolx4MXphN6nokfNzz1Q4LclCeUpzkh6/Qy0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehMvlCkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehMvlCkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987B01F000E9;
	Sat,  4 Jul 2026 00:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126472;
	bh=8mPifWpz5U4PLYEqo7OA0nfZLZbqs1QyGJm7iYUBdSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ehMvlCkbxEIH2R+eLs/aCMlLAEyjjaT+2qODRZot6hTzdKm3K+SRo6XDZ1smlWPYY
	 MBAeAGlj4SURi7DDtyJ3+TMMGK2frrqhtK22ClFr3FIzwCECmnDDr+Hn50ISQCGSkO
	 ESCjXekqOao2YIDEuWyFJWbwVWOdv3RSVr+tIoWPJIoojR5VRGfhuOw67RiAXg8JDY
	 Ppm/yjkc4A/DwaVAGRCZq4SVxavo3N83efxcTsqqjVWldTVYJVj142grNjzltbABem
	 xQkee6kPsH8Zqo1pD4VhevpraHtsAJvUCyn/pU8RUtcVLowzIQwmNOahJEHWgiZoMN
	 brhd/sdZTxu2g==
Date: Fri, 03 Jul 2026 14:54:32 -1000
Message-ID: <741196180f7803af3bf9e6c62233a031@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 25/32] sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice
In-Reply-To: <20260703133420.C16B11F000E9@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-26-tj@kernel.org> <20260703133420.C16B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [High] scx_bpf_task_set_slice() assumes holding task_rq(p) implies
> exclusive access, but blocked tasks can migrate locklessly, allowing
> capability bypass and data races.

v2 will gate the direct write on task_on_rq_queued(p) in addition to
scx_locked_rq() == rq, so a blocked or migrating task takes the
deferred path that re-validates under its real rq lock.

Thanks.
