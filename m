Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA61A9F9B;
	Sun, 19 Apr 2026 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622324; cv=none; b=D/5oYcY4Rk/vzS0EiNoRdyHUB+RRYWQ1vYrwWRyzFkQ3QZG7/hPIoJ1TWUM6JxwlXQqwvuDMinyPFlTpBHBaaMcGnWXfC8kELl9GiLI010hI0A/lLwHHLJteO02ipzKYPtF5ba4d8sVQAiGYpVqVo6+kZWTmFMkLKfwjg9pbL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622324; c=relaxed/simple;
	bh=+pOVrcbp0ehItog1kot/CF76DHnqefQL9SL47SIf+Ck=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=VoWLN44izueJvdQC2zFl4A0ZRVJB88qHuGE5MJfnBrB4MtJvdR54nBg+WajsnIYaYd5rKIxyrooyPNmZTTHfYa4RhRPR4OFXaFvp561mLKZ8VhXPnuRho6L2HkpsLOGgsXEZDohdvFDM9MfNjmC36cpXLc3DB2ZbVQXkJCBao7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbLHTTJ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbLHTTJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A733DC2BCAF;
	Sun, 19 Apr 2026 18:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776622323;
	bh=+pOVrcbp0ehItog1kot/CF76DHnqefQL9SL47SIf+Ck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pbLHTTJ3GDRLr3ePK0R6qjS9yh0EsE1qznl/3eedV4u+bs/UXEbv5OETIBa3JY/tI
	 usB2LzeeriiWpBBiKjLJep9WKsOfgoXnefRZDKaaELk/D91q+s/RrPyUu0hluefJTz
	 A1y2KLyYDbnN1uNKwzXYb9anBdH28/6girRIE19d6CrkFuRDw2hdl5No+BveJoKrma
	 QCHzO62yMkWBsKKJLqa/K0fLpFN2WcFRmR70fTYRUBCZQ0duK+gqN9QyQk75nvnsJi
	 wWFvIZBG1Pr0flBhy2g0QomQJnUmwEJ7uHa3un57BH9JHYMHn3+yokCruHj3ZbylNn
	 PDsnfKGRFeisg==
Date: Sun, 19 Apr 2026 08:12:02 -1000
Message-ID: <070b4b9e6b56a0c9e2e61423f35837b4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: add p->scx.tid and
 SCX_OPS_TID_TO_TASK lookup
In-Reply-To: <aeUKt4Mv7NPZIrLW@gpd4>
References: <a19c8c74d7c767bc9865b75d6de7c723@kernel.org>
 <aeUKt4Mv7NPZIrLW@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Sun, Apr 19, 2026 at 07:02:47PM +0200, Andrea Righi wrote:
> I'm wondering if we should have a teardown function, called before disabling
> SCX_OPS_TID_TO_TASK and destroying scx_tid_hash, to explicitly remove all the
> scx_tid_hash entries via rhashtable_remove_fast().

rhashtable_remove_fast() doesn't clear tid_hash_node.next either - it
just unlinks from the bucket chain, leaving obj->next at whatever the
chain successor or nulls-marker put there. So explicit drain wouldn't
give us a cleaner post-state.

And the stale pointer is never read. After the static key is disabled,
scx_post_fork/sched_ext_dead/scx_bpf_tid_to_task all gate on the key and
skip the hash. On re-enable, rhashtable_init() creates fresh buckets and
task iteration re-inserts each live task via
rhashtable_lookup_insert_fast(), which unconditionally does

    RCU_INIT_POINTER(obj->next, head);

at include/linux/rhashtable.h:838. Lookups always traverse from
ht->tbl[hash], never from an embedded node.

Thanks.

-- 
tejun
