Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840240099E;
	Wed, 16 Sep 2026 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592495; cv=none; b=YERJEyEhUOusP6p2syhu/Ti2O1ux/k6N5nmVa/FGTLclLwWAD1w04BUQd9JTzTtQmdoBBAkGpbhUixRE/8UgSE9LaXxLI5wOmZs52+pprbpY5xBSFuyBUWfHJGs414X+WhZYJBuhJQNpEVC7MlI4yBjeecOBt3TcDZfylHIJVdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592495; c=relaxed/simple;
	bh=aUL1lYMCWU1CL0TxcmNGvHxXIVoSjj++a6jdsmlfTUw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qiHWqHSxezM6XHrhi7BF58eLWyT1MrTMRQggsxNptnI3l+yaJUt/Wad4ZZUaxhO62Uh1IR2GaPxZ3DAQKYnScvnrCneFXh7VL9dd/VubNxZk7QdVLLKSuPGCTrGplqhBVxdgKhAii1yvM4pZ1m4rfHOmzn3DSPhEiob2CVsO758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkpqkX7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkpqkX7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065541F000FF;
	Wed, 16 Sep 2026 21:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592491;
	bh=Yh3Mioctk8nS8dlDqGjEhAsA/B+YYwNEBj0F7ydd2Xg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KkpqkX7Qju/nux+bFhKs59UlqVQIKYdZuqTVtFsH4/WDxoaCqaphZ9brZIO4GZOVN
	 ItqB7oQyWltA1cT9mhqp3rrly8ogKOI2RtvlRSoln3T7A5nOVnIG0tZIsAwvuP+S6W
	 +YpL7A/hHOixocIFRYDlZ7PxgHb0ontQtZip7c3Q1sb0CGcfhJ/GSTmzaCg96p9EFK
	 NPk/2OBc7MLIIlvtbRuJLrQdNPtvTEU5rAxp4tmgZsigMSlqFbUiNCFzHN9AYKR2hR
	 PyHfUO/kea2WNk7K9qNB/A8fPvblhryiTNFqGPjitBLYHnif/sCLqJEmgA4oXle9jp
	 FI41H2BN2Vlcw==
Date: Wed, 16 Sep 2026 11:01:30 -1000
Message-ID: <fbec605f57bd861a9b4c53f16e7f0197@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: Tejun Heo <tj@kernel.org>, arighi@nvidia.com, void@manifault.com,
 changwoo@igalia.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] sched_ext: Don't run ops.dequeue() with a DSQ
 lock held
In-Reply-To: <20260916070753.3343113-2-fangqiurong@kylinos.cn>
References: <20260916070753.3343113-1-fangqiurong@kylinos.cn>
 <20260916070753.3343113-2-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Qiurong.

On Wed, Sep 16, 2026 at 03:07:52PM +0800, Qiurong Fang wrote:
> ops.dequeue() can only call the "any" kfuncs and none of them can lock a
> builtin DSQ, so the global and bypass paths can't deadlock; however,
> all DSQ locks share one lockdep class, so iterating any user DSQ from
> ops.dequeue() there trips the recursion check.

"there" has no referent. "on those paths" or similar.

> +		 * The custody transfer happens under @dsq->lock so that
> +		 * later consumers see the flag clear; the callback runs
> +		 * unlocked - it must not run with a DSQ lock held.

The callback isn't unlocked. The rq lock is held on every path. Only
@dsq->lock is dropped. Say that it runs after @dsq->lock is dropped because
it may lock a DSQ itself.

> -	/* @p is on @dst_rq, an rq-owned @src_dsq is covered by the rq lock */
> -	if (!dsq_is_rq_owned(src_dsq))
> -		lockdep_assert_held(&src_dsq->lock);

This leaves @src_dsq unused in scx_move_local_task_to_local_dsq(). Please
drop the parameter from the function and its callers, including the three
in sub.c.

Thanks.

--
tejun
