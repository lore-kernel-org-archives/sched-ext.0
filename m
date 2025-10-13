Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CA4C81;
	Mon, 13 Oct 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381068; cv=none; b=N0N05/WAKcrwy8kOz6qk4+eVX43Ymb/QQeYMNK+4uVRV9fnT7TIdyRibKH8iIJncNYz2FDLsvTE0NTwKUfgJ3I6+IaTcBYc8HJDpgFLj/syKMoIPinutHil+QWKOXYVaoQ7ShWJe1jFRNKLndlouQoS4YCUWEXoGOhb/n9aiY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381068; c=relaxed/simple;
	bh=InByBTsCq4HZFvNKDvEYwuUxU9EgT7FAJcnx8+I3AqU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Izf0xIdk5ZALmdJFevyM4bh2tFktJ0dF+PWV2eWqsXJ0lOIT7HbOhjASyNouVyRpVefGxrq0w+VOJG6oMIT0dVUJRtRaOiTUdU5HI4kf+8eWH7xFjyL2vMF6NbMr5jsJojgT0E/793dMUKGHEfmvrXOQrs+SXjBvzf9WVWnQQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjkR3Pjw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjkR3Pjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BE9C4CEE7;
	Mon, 13 Oct 2025 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760381067;
	bh=InByBTsCq4HZFvNKDvEYwuUxU9EgT7FAJcnx8+I3AqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BjkR3Pjw87qxlJf9Bu1B1vfXDDpZCb2Y5yuLD0AhVdeV+OS1WwleYceE9LaZ9c++Z
	 6XSJk3uh83G1QOaST3l1Q3aP8cZeXqT+2WN1QLd9kKXjMyRSB+WMNhzFTSmbgL5Cfs
	 lrzt0bvV1Okj3ZYFhe6+9HGXjGgsYVsmXcQlrc2r8CwzgzMCnjtBbRM2ic0epnLlLK
	 vcLxQ++VGzV4kCPjX8g7SrSWtwZskRWyMJuK3HrcADopJYgJQigaD7tqfy76gxgfde
	 5qxfQlKFaGOiSQDzS+bnMQXwU2+r7igJKwkPnCV7fhDxcTwNsazcYQ2HTnfnY8pfUZ
	 TDc5ITnv1p0Iw==
Date: Mon, 13 Oct 2025 08:44:26 -1000
Message-ID: <27ed885043e6dc3e9c2feb2e9a247658@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Phil Auld <pauld@redhat.com>, Andrea Righi <arighi@nvidia.com>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using kvzalloc()
In-Reply-To: <aOb3Hv0uPv9G7N33@slm.duckdns.org>
References: <aOb3Hv0uPv9G7N33@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Tejun Heo (1):
>   sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using kvzalloc()

Applied to sched_ext/for-6.18-fixes.

Thanks.

--
tejun
