Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565938;
	b=tpGxhpnJ+FLLq4RiZLZycSxSkguMKo5lGSrX6JYDEdh1LacYiO5xD/6GFXERBJGyY7hD
	 H/ywzi3WxV9vPhIR5qQeuAJSMHSjKfYMb49AETCTUWc3vFXKVdfuXzzjRVbJfJ4au+L6p
	 Z+C4bqatGAxMSu1tCuKHIuBXAOr0jsYswEYJGuKkmx0wBVF0fUD+B/CVtkDQQ48uMtAak
	 XCXBPKx98AK6tNgg1W83Izxx0eitqHpTMYQehzQNT3cAJs0hxIIto9QupYM0tdVWiS/gj
	 HupT3eH0DP66eMxIqzWsjZtQtiWkHjECSnlGhW28IhP4K+k3S3mkigLkAIRymHCiWwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565938;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VByEMW5eTFcK7rVk2zpRVxi6Obs9wQPMsVXZdsparmU=;
	b=k5cPpJ8jRpMNjQeNprQe/YlG5tAxHos77NLms/+UwmJARUodyLbkQ03u7CIcIQnBglXg
	 Ij/zT4vAOeKL5Sp6hQbiu44R2C2WfQZNxhyla3xrzCRXxTNBkmUaT5pOWEdT3QUMb4f8O
	 eH/2Yv9HA6OkNoQaw4J4rTTKqWg8dwNs3dIGovqsQAV4yLSC6mwHlezNBybtAm1tWd+5L
	 r8OyZf9jj+D7m0JShqoDhfGpz7x5SX6B/PvUPHndTErai2LaOVg7+trCzfyAWFHe9D5OM
	 zFMkIfJtC1J6z8VKQwULZJ6ewnYaeJ9xMX6leuj2eoibkbU+cCpVDbMFrWO5o7fS5sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMES0cAH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F2606A31E;
	Wed, 25 Nov 2026 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMES0cAH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CDB1F000CF;
	Wed, 25 Nov 2026 00:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795565937;
	bh=VByEMW5eTFcK7rVk2zpRVxi6Obs9wQPMsVXZdsparmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aMES0cAHE+oPRoz9KjUNNSog9gaJxQVRF7tWHXOJ+ggu8yBSqm+0zBKrdH9DPCOtt
	 oES+yhrKi7pApN7HrmXgKTaeSnsiHkUSTUFPDB/HqihSY1UQ6tKOZX9j/bXDeADBUJ
	 lOR5vnbw5laefmLhUC05R9jiRxJC/CKj+Wi/+9MQJ3pfQQAVD0+WuPDjhnnuJChhfQ
	 Nc6c0k9Qi6SqHwDXXdA1R5sxlzpFnm72T2cBWX6Zy3CqJQEGVjkLGq83lSe7g9quHY
	 CE5z4maV/SU3D4hCEAY+GBEAcyM590tLelP24zsySaQhpnL3VwkfSozX1HdokENnCW
	 TL6DtdgxUskpA==
Date: Tue, 24 Nov 2026 14:18:56 -1000
Message-ID: <d0843faaef949300df9b51a09e36a696@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, fangqiurong <fangqiurong@kylinos.cn>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched_ext: Fix ops_state and ops.dequeue() locking races in dispatch
In-Reply-To: <20261123170846.3165648-2-jpiecuch@google.com>
References: <20261123170846.3165648-1-jpiecuch@google.com> <20261123170846.3165648-2-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Kuba.

On Mon, Nov 23, 2026 at 05:10:32PM +0000, Kuba Piecuch wrote:
> @@ -1871,8 +1884,10 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
>
>  		if (unlikely(dsq->id == SCX_DSQ_INVALID)) {
>  			scx_error(sch, "attempting to dispatch to a destroyed dsq");
> -			/* fall back to the global dsq */
>  			raw_spin_unlock(&dsq->lock);
> +			if (rq != task_rq(p))
> +				return false;
> +			/* fall back to the global dsq */
>  			dsq = find_global_dsq(sch, task_cpu(p));
>  			raw_spin_lock(&dsq->lock);

I don't think the task needs to go to the global DSQ here. The scheduler
is being ejected at this point and bypass is going to cycle all its
runnable tasks. Maybe we can just let go of the task and return, for both
the local and remote cases, and let the abort path recover it? What the
BPF scheduler sees after scx_error() doesn't matter as long as the
scheduler can be ejected and all the tasks are recovered. That'd get rid
of the bool return and the retry in finish_dispatch().

Also, can you please factor out release_dispatching_and_lock_task_rq()
from dispatch_to_local_dsq() in a separate prep patch?

The approach looks good to me otherwise. Can you please send v2 with the
above updated?

Thanks.

--
tejun
