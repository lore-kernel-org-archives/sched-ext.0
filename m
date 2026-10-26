Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041176;
	b=LPVL6LdirzyHGyvT74YmcAVCQkqX7+mYCnjnfivNLwaPSB05klY0O4/GVi84QlrBvgvi
	 ngP68i5V2bO+gFun6htGWh2RDInQ3pqeqc4OVkpoMPXJAw2wnZjgnN1YifWbquiGSjtoa
	 fwyXL3T6UUpBoBrPvWTpyBGsyOtarjbWyVA9+cMGu8LxYHh/gdNS+nyOt4E+mSxC8sIDJ
	 zUPjzLM22GqZfcoxupHHqGbwnYV2qtDPjnVwXDnYFHZoZKfUVPEhqpQ0E+Fiuej0i5JsT
	 wp3aa2hzYPfKYtFwDNHdYJVKnJIMfIuRV9kbHzBUxj6awMIagnzlhxvcGVTmNmqHVzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041176;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=vTjqmSt66KfvF8vPxCFY9aUVyzzoVUV2p70ZlxlokqQ=;
	b=BdzJi+zZnETAa748oxgmM83TntN2qaFSXw8zH+nIQOkIKJZF1yVccosqYUKVjpexsRYy
	 yqHpjEXdV0H3hIG1joGvT1qvGlZzxI0PpqT+Rzxi0Oe43Z3jPME4/wUqkuLcHN4/UQDPM
	 1uWGgbcwiV0w9ItZOVB9UMaZyweSk9W4yYiEZ7XUBRqBPKdbdjI6mmobZx3IuM/J4Hc8J
	 3ArayFEr0zdG5Yh0iSs85nV0B/MijSEBfIO6QiOYv0K6WkiyabS1oiFLez0ujnW2v45+B
	 Gr4iEw+KiPYNV9AcGlyKbWniAeWr/1glNj/ZruNvsJVXczcbIy559pj7UhTqAmqVTlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATGWt3xL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE087606A31A;
	Mon, 26 Oct 2026 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATGWt3xL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C831F01825;
	Mon, 26 Oct 2026 18:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793041175;
	bh=vTjqmSt66KfvF8vPxCFY9aUVyzzoVUV2p70ZlxlokqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ATGWt3xLPP9m/pjNLo1pz4ihUN2X7V+ARSOYQQjWTsEelrvUu7LOmcwSXsdgM/G03
	 Gdd0vf+ap7jG9Me9glo+aREIsHT6O8VnWMBdchsVt2LSPqpCu87fc8Pk+32zIT0OVX
	 2xjt/RTdWluektV6j65lSyhxhlBLhbQ1jxw3Ih6QsV1oH6iP8z1IAeUGSZJ7KFe7DK
	 dFhJsxnLKHIJQZxQaMKYupLZxlv+V7AnDryx2iMiZb6WOgSsqZVa30c6t7V25+JlYi
	 Ku/Dkv5u2eB4O5hZghI/9gT6AVuE9tzRi4gwhvxLr6Lvr45qvzCCy+hUAZmTbigUPN
	 bPHPSN07g8zWw==
Date: Mon, 26 Oct 2026 08:59:34 -1000
Message-ID: <ebefec7ae9cb7f3ffc405bac53a6e95f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Guikun Yang <yangguikun19@qq.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] sched_ext: sub-scheduler kfuncs use struct scx_sched beyond the RCU read side under sleepable ops
In-Reply-To: <tencent_572AA31E5369BE41464E9DDA4CEDA2DA7C09@qq.com>
References: <tencent_572AA31E5369BE41464E9DDA4CEDA2DA7C09@qq.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello, Guikun.

On Sat, Oct 24, 2026 at 03:47:07PM +0800, Guikun Yang wrote:
> The four sub-scheduler kfuncs scx_bpf_sub_grant(), scx_bpf_sub_revoke(),
> scx_bpf_sub_caps() and scx_bpf_sub_kill_bstr() obtain the child
> scheduler through scx_find_sub_sched(), which is an
> rhashtable_lookup() call.  rhashtable_lookup() is the _fast variant:
> it takes and releases the RCU read lock internally, so the returned
> struct scx_sched * is only valid inside the caller's own RCU read-side
> critical section.

There's no use-after-free here.

rhashtable_lookup() isn't the _fast variant. It requires the caller to
be in an RCU read-side critical section. rhashtable_lookup_fast() is the
one that wraps itself in rcu_read_lock()/rcu_read_unlock().

> The kfuncs themselves only take guard(irqsave)() (sub.c:2323).  They do
> not hold an RCU read lock and take no reference on the scheduler, yet
> they use the returned pointer for their whole body, for example in
> scx_bpf_sub_grant():

scx_bpf_sub_grant(), scx_bpf_sub_revoke() and scx_bpf_sub_caps() do
guard(irqsave)() before the lookup, and the lookup and every use of the
child happen inside that IRQ-disabled region. scx_bpf_sub_kill_bstr()
takes guard(rcu)() explicitly.

Since v5.0, a region with IRQs disabled is an RCU read-side critical
section, and synchronize_rcu(), synchronize_rcu_expedited() and
call_rcu()/queue_rcu_work() wait for it (see the comment above
synchronize_rcu() in kernel/rcu/tree.c). Whether the sleepable program
holds an RCU lock of its own doesn't matter.

> There is no synchronize_rcu_tasks_trace(), call_rcu_tasks_trace() or
> kfree_rcu_tasks anywhere under kernel/sched/ext/.  A normal RCU
> grace period does not wait for rcu_read_lock_trace() sections, so a
> sleepable op running inside the teardown window keeps using the freed
> scheduler object.

scx_unlink_sched() removes the sched from scx_sched_hash before the last
reference is dropped, and scx_kobj_release() frees it through
queue_rcu_work(). So the grace period before the free waits for any
kfunc that found the sched in the hash.

Thanks.

--
tejun
