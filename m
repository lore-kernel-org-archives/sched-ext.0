Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE8F456DE8;
	Wed, 12 Aug 2026 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554439; cv=none; b=ZNdXJJkx1ePB7lMGh2Cp/hgMxSHrJsnKzpFwuuLDEJmozXwCRXVmieYFL88Zm2ueqcQhoBaclRzQk5HF4e19hVE3ul1ZZqo99OHa5kQODUvf4qqJ7s4eEjLHEoR20ZgrpzAYQ9zY8qVTivxnDJz4IHCc/WdOgEme8YbVwQ38/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554439; c=relaxed/simple;
	bh=qA23OLbF+92LjoMQ2DgO+GdcAxtdUa1TXeEx5QSGmpc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=BaWyJ4V5sOCg033VYIGg6i/4y6pkPHfbsws5J7BDyQ0qS9k2HnI1G39g2AKrTvV4mXod+j/4LVU/7SKNe9VA7vZH2pYvTd3mGfJdI3POTIimC4xQ2zpo/1a6kn6tIsfzCr3QFKsM84HqWyUF6Kt4wfmhiMuWFaNYK6G4r9fzYpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W33U73Rq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W33U73Rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36FA1F00A3A;
	Wed, 12 Aug 2026 17:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786554429;
	bh=EzNvsu9jfNBedYO+eksIf8bJWDGN85RoQ429NReMnf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W33U73RqAa3Jln2JCu1W2SaH4o0Dd7SfrTt/n6N4hr/Y8Rg4LISI5+wWFndpgaG2U
	 L9/7lBILKCphXSe5PcE+QhEh/KBrZy9OkGcEEE6daYnXU6gzOOUNaEtWsMDUL4pv0b
	 vgVtaUqjL8N81NJ3yVV1iMgGWQBojazjrr8j1izbfbzQG7oGnvw2K4CFXTT89mOXge
	 mSs7ad5Z5V16qOUzw+I8b+XXeUbu5O9zBzKVKxAC5fof3v/U9L1TzSf69PJIZSx3jT
	 /Eg6LecSu42P6WWUYMQhRKrIQ+4HRm8Itw7N8zE9HKjL4XZmCCdw5/KCfIhWC7Ea7X
	 FKJJ0jDIARDuQ==
Date: Wed, 12 Aug 2026 07:07:09 -1000
Message-ID: <3d7d3b740cb76ceb2e965c31e3e03b46@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 Peter Zijlstra <peterz@infradead.org>, ElXreno <elxreno@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.2-fixes] sched_ext: Fix core scheduling
In-Reply-To: <20260807210221.232543-1-tj@kernel.org>
References: <20260807210221.232543-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

>  0001-sched-core-Handle-pick_task-releasing-the-rq-lock.patch
>  0002-sched-core-Make-core-sched-flips-wait-for-in-flight-.patch
>  0003-sched_ext-Replace-SCX_RQ_BAL_KEEP-with-a-dispatch-ve.patch
>  0004-sched_ext-Fix-this_rq-assumptions-in-dispatch-kfuncs.patch
>  0005-sched_ext-Count-rq-lock-releases-in-rq-scx.lock_drop.patch
>  0006-sched_ext-Fix-rq-core_pick-corruption-under-core-sch.patch

Applied 1-6 to sched_ext/for-7.2-fixes with the following updates:

- Peter's Acked-by's added to 1 and 2.

- 2's Fixes tag updated to 539f65125d20 ("sched: Add core wide task
  selection and scheduling") with stable target v5.14+ as discussed.

- 3 updated to also drop the SCX_RQ_BAL_KEEP plumbing from the tools
  autogen enum headers as Andrea suggested. v2 posted in reply to the
  original posting.

Thanks.

--
tejun
