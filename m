Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A563F0AA0;
	Tue, 14 Jul 2026 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016478; cv=none; b=aLyhULKdbroqGNr6afxunBKBov6Vjq7T6fYP9TcSy0d9P8vaeL48pqRSf+KErb51+PdZufh1i+vnsPGXvXll6D6Ma7VksDcPOsHgnwFlBvi8czazGGB5E4ZzNeDO/+daspZIj6jl261dxt6PjJ9SENLhP4Us7PM6cpTMSWKzCvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016478; c=relaxed/simple;
	bh=mbgpAQwQS2vNOh73zey4moJt6+td8yO56JIF+aohg+g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=RhbPNCP38JI460aFwhOImoLfIhhKuvkDVLMezXKRY4I15vqX+GI5sS4pLn7xjvn5ENcBUDPp3XmFhB/t9oRdCD3FYzn4imPCEWjPwMWExUxMfVdhRttZrRp6l9VfaUYrmQL7TZoZiIOlYzIR138omVHmVSLiGKac0ZXI4LDwWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms5JjVzR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms5JjVzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A271F000E9;
	Tue, 14 Jul 2026 08:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784016477;
	bh=3wyBFXyMO7sgWOiaXC2spJ2TETtPHaLL16KRqNjDm/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ms5JjVzRKijnfyVS9rvvYiBara6DbBhc0QHo//53VUhkxvrqhbu/HrWU75UaQJ+Jp
	 kl5+IS+qUfSVxgnDyCUTp5vfJdTf3PuCnj8MU8tSQsHvTTJfpIlZ4zImGV9lfMsVDw
	 lBPO88abpCZEOkR/j0G4xGW7MRgcHP4bpUgfWcPvgvHlKqtlKk+Y0WcL2EXrIGserd
	 M4byFT3oVwSsEe45psN/hfEZQiKRY2LJs7Mug2a6SdP9O7qbtCfi3CpxAsA/xZli5D
	 TvNc8qsJoGcbDKI6CTZBB8OqSL+sZG+INYGKChsTloDbD3/iXKqh4+rhXII06sfzS8
	 aPRuGYfNq0SXg==
Date: Mon, 13 Jul 2026 22:07:56 -1000
Message-ID: <0c1ff2150bd93a29f4c1272fd63c54f5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 sched_ext/for-7.3 16/33] sched_ext: Add sub_ecaps_updated() effective-cap change notifier
In-Reply-To: <alXQmHduNITfgdct@gpd4>
References: <20260709225041.1695495-1-tj@kernel.org> <20260709225041.1695495-17-tj@kernel.org> <alXQmHduNITfgdct@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Tue, Jul 14, 2026 at 08:00:56AM +0200, Andrea Righi wrote:
> This is a nit, so feel free to ignore. I was wondering if we could wait
> indefinitely in this loop if the target CPU never reaches balance_one().
> However, I think the only way to never trigger balance_one() is a higher class
> monopolizing the CPU, but this can't happen because of the ext dl_server.
>
> In that case, should we document this "dependency" here? Something like:
>
> /*
>  * The active EXT deadline server guarantees that balance_one() eventually runs
>  * even under sustained FAIR or RT load.
>  */

The guarantee is weaker than that. The ext dl_server is armed only while
the rq has ext tasks queued, so an ext-idle cpu monopolized by a higher
class can prolong the wait.

Rather than documenting the dependency, the wait can be removed
altogether. llist can't unlink a single node but the list can be rebuilt
excluding the node being drained under the rq lock, the way
____active_del_barrier() in i915 does. Will follow up with that.

Thanks.

--
tejun
