Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348B346E6C;
	Mon, 16 Mar 2026 05:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773639829; cv=none; b=B1Y3+m4IHMkvJ5m9xr0+Ov4fX6vtwhQruHYwislppL1Rw2KY7tKCiYt5N9YP1p8Q74pjwBosZg9cr5uvHZPErFKYuw3Q7F10WakWrpKmp3yNFipiilc+4Ymoz6lwl5zdlsAvteKU0goHRn5W2AMk/QwihIz467SwsnbsrwxSn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773639829; c=relaxed/simple;
	bh=K6KloAj6Bj+0EDic5lLF4lXgNFriBz5wmP+uzlWv+oE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=O+Ci5urewy9km5k7La4D2cuD0HI7oDJPMa0Bj7zbEU9R+h6Y7+ihSteJfG7VuHUY02OKriQcqd/4DbNMKwbU1MKeVs1a7jQ0OQ3O1PQzfDDvFLtxaH9L4DSSshjWfRDWGsVgKSezZ7PlSgR4aLSGWSYNzIXcZOxzN38WSeLj8AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdlaymzI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdlaymzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A1CC19425;
	Mon, 16 Mar 2026 05:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773639829;
	bh=K6KloAj6Bj+0EDic5lLF4lXgNFriBz5wmP+uzlWv+oE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EdlaymzIB9V5qGBs1W46fQmQ8tblpAoch47l2AcztYbm9sUZOOQ+ZBBLcDvdVMcq9
	 tGnjLqP82soR+ATnPh4G3Cw+u09/SVuemtsysWmsoE625j1vnnHnpTViiKPTnUVDp0
	 LVzO7WWGc+gS7eSCAc5FatkDs9UHjXtJl+iOwPqkIKxbzDUwtCh2c1mXnt8jjzH/3P
	 W55aCoLv8d2K5D90DSianb2a8fqFSmMtfdHgIdedY2gtHkozl6Hfq+6a5q6L8VXweS
	 eBV5Vl/dGUPJkLyroGzod0M4/DDCbG9DOa6CZgxEeSFG1qU6Tfe83+MwUPRA+Hcyen
	 GTPLy5JPm4m1g==
Date: Sun, 15 Mar 2026 19:43:48 -1000
Message-ID: <fd14e347a72d374cb02bebc9c505a891@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: Use kobject_put() for
 kobject_init_and_add() failure in scx_alloc_and_add_sched()
In-Reply-To: <20260314134457.46216-1-devnexen@gmail.com>
References: <20260314134457.46216-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Thanks for pointing this out. Using kobject_put() is the right approach but
the release callback (scx_sched_free_rcu_work) also calls cgroup_put() on
sch->cgrp, which was already set at that point, leading to a double-put with
the caller.

I posted a patchset fixing this along with a pre-existing cgroup double-put
on the abort path:

  https://lore.kernel.org/r/20260316054328.838304-1-tj@kernel.org

Thanks.
--
tejun
