Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AFB256C8B;
	Fri,  6 Mar 2026 04:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772770651; cv=none; b=rKIF0EywGnTNtU+NarWt/dqxYQioszbOIXdxN//9Lq7WxOkuiE9kpJJrwFcXwz0FGCulZo/NpUCDHfi54gRxyOaEMY49RRzisE2FkReb+SOSQc5QmBd5hSFuUgc/An2O0ZWJ+IxkFEBWE7qQ8TQ5my+67soNwFmoKzYAOMwqD5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772770651; c=relaxed/simple;
	bh=EcGy3VH2EIAvY/yasG4W53pv/P+DEusAAkPyb1GmWgQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=jstvnIGBCYHMXaeA1/rSdJO7AbyAdSrIwyOPFjWAueda3AmZgluXngo+7XhkrbW/csdfrQ1ouQ/cLjrhvQndv+n5ghyWqXZUnS5Xipd0oFQKNVadLRLQa+MD99n/i6bQIVk9Y3lvZS23r300l5f3Mr+CYeHZsAAKYVcW+JqhrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh02/ZWa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh02/ZWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161D4C2BCB1;
	Fri,  6 Mar 2026 04:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772770651;
	bh=EcGy3VH2EIAvY/yasG4W53pv/P+DEusAAkPyb1GmWgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jh02/ZWakuV/mXMNGMs5NPQgeFwfYmmkicTJPW2W7BvzieK61ELGvFWHD39+GR3ix
	 H3kRr8xUxraLNMYIVinTvyE7kJK0ZrtbhfxOl3MPXcy3wugHxfSjwXGp13Gbsklvq/
	 esahFBbHHugG90YJQCk1+UHkRjuqnrWTcKTakv/wgyBgKEajQzJbvcESL7077cswWm
	 JK7eKgJk6vE1Awo+LI6/0V6hJ08pd8YrPDhKyUDtDsYY0SPVnSzqeFBoLfQH7dxExf
	 cAnHakPGO7XLX1qZTLHHdYyRywp4K2+Cyj7ymx5k7w6QlMiCtxhLRfBIXQeGbCa0v4
	 c6yPblr/xIU0g==
Date: Thu, 05 Mar 2026 18:17:30 -1000
Message-ID: <9785874e854a32bcd0e393e06357b81e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 emil@etsalapatis.com
Subject: Re: [PATCH 03/34] sched/core: Swap the order between
 sched_post_fork() and cgroup_post_fork()
In-Reply-To: <20260304220119.4095551-4-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
 <20260304220119.4095551-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Peter,

How do you want to route this patch? I can take it through sched_ext tree
if that works for you, or you can pick it up on the sched/core side. Please
let me know.

Thanks.

--
tejun
