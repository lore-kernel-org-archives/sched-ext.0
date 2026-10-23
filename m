Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784152;
	b=hba/xUCKV+YfnzeFXmuEZjW+6bgojiXLXSLk8hkZLnR5LeJHJTsZ4wtVehSJayL2wZ2Q
	 QWGykwhc1m5wu3tJ7zwZZzzEyfGGMyGQhUGubB+3k8vD/RM5uh1vw84bglyLcosK5N3nr
	 100mubQrK6LRNdcVC7BnlL54z1+Y7b9PjgW6ppU5mkUxIcABI1OhpZNXNToE6BGnSH7DU
	 XywU4omEHib4iLIR3vRRdvRgHq+xweL41fM5/Ytv3CK+Ao/ZXGuQuSZBcJBUMogALm2dB
	 cJabD+DYIy5JnwZ5gUMIeayCBLCvemWNvI+c8iL2sMsTU4cGxcfteNoqluAhNRo9+vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784152;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=X/K/xlMU8VWsC9nqOTbUQAuFMVle3BpL/szm2o/O0q8=;
	b=w5fZ3JWgU2Hq8mXfuOGQkAkycdEWapi1AEiVik2rI9hcOjRrn2rYcTVj4hKsASSq5yAw
	 tPTWBn4D/9k+tKZLOcDc2rOOLeqlJob2Fg2qeBGy5d+BOiDdq9SzIkyxYnIpOzrLCpc1Z
	 GPgMDSOwRTmJldQCWyXYWBaUpx80uTch02hoeLKhpEYN+BmGe2upnGjWznKjDMYthORga
	 rgUILQlTLdR9COfHq2p78gXm8mhWsuI2ik/WZHlQwOaOO3rEPV2+Zw/KyfSUeYXbAFpdw
	 A2uQzKy1H/6//zWXNkYY+5xNM7rUW2CaekV4FNvAeRkc5OcTRpz6AX/zr+vq1wc7YDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HeGD9YgC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C913606A31F;
	Fri, 23 Oct 2026 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HeGD9YgC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDF51F01828;
	Fri, 23 Oct 2026 19:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792784151;
	bh=X/K/xlMU8VWsC9nqOTbUQAuFMVle3BpL/szm2o/O0q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HeGD9YgCJhvz+f30AkaO/mHFQZY+NnL6zPHkNEn7UblSTl8csBDZ99L3rSVNLT4Gx
	 o47Ik2I+TEPMsI8Q6hBjUu2KXKMqsI2FtpTx8XEsZH4DE7E25CprfeC9r47SADKCTi
	 cXt2yIokFtK1VIKVjvNRDtSOy2r9hUGm0SUE+MbbN9DZR8P198/Dd70MeSd5Wk6JLh
	 C9ewYE2jFSQkG/ORgPl2d7Hy/YpDtZZPH3fZGFDXv7kRkGCEQfkgrEGq4WhRpmxsdn
	 BlgmaFRNzsuUqJ7VXPIoXAeJgQayXHeQFJGWHgWKEG2NJL0fz0UhAeWywhUlrQrLB+
	 pOK6fFPxstW2Q==
Date: Fri, 23 Oct 2026 09:35:50 -1000
Message-ID: <bba1b0e8d484f3da05cd956fb8052705@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/core: Preserve WF_RQ_SELECTED across queued wakeups
In-Reply-To: <20261023144811.2230393-2-jpiecuch@google.com>
References: <20261023144811.2230393-1-jpiecuch@google.com> <20261023144811.2230393-2-jpiecuch@google.com>
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

On Fri, Oct 23, 2026 at 02:48:04PM +0000, Kuba Piecuch wrote:
> ENQUEUE_RQ_SELECTED tells a sched_class that ->select_task_rq() was
> called for a task wakeup. sched_ext exposes this flag to BPF schedulers
> as SCX_ENQ_CPU_SELECTED. However, the flag is lost for queued wakeups,
> which a BPF scheduler can opt into with SCX_OPS_ALLOW_QUEUED_WAKEUP.
> This also results in undercounting SCX_EV_SELECT_CPU_FALLBACK events.
>
> Preserve WF_RQ_SELECTED for queued wakeups in the same way WF_MIGRATED
> is. This way, ttwu_activate() receives WF_RQ_SELECTED for queued wakeups
> and passes ENQUEUE_RQ_SELECTED to activate_task().
>
> Fixes: 3539c6411a7c ("sched_ext: Implement SCX_OPS_ALLOW_QUEUED_WAKEUP")
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
