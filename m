Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47911AC44D;
	Wed, 22 Jul 2026 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763350; cv=none; b=AWvZW11vfzIJ+oHqxoxbuoHck1f5zGTZaB+K0Uh0byPr8jA2obf35u2B5XM47U/hgZt4cko5O0lFOBcxapYPBsRgXOMn86cGHZ/CFDm0Q7ZpPKhJUUIMdWkODbq2tIEBm3jbSBNl1dcLjrGRSba3vPSDhPJfnohR/H4R1YAY3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763350; c=relaxed/simple;
	bh=9w98hS2TfDhntHnrn3jguLKSFDRMQ4uKSDe6YxsD40M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References; b=nUma43Xur3i1B2l4p9L2CugY5HHnH3zRXfEi714IhM7sTfCXBpYNCwiGZj9cHuBDrtMdwSGaVG1WDT+qUhmJvpjAa4/6zytb23Yq6MXFsrZW6mOSKnXCrFwKCAKDp2xL29P2iiS25xnDdwNsYB/Hf3VnwfuI3wVm9qkpbE/s08k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igRpw3+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igRpw3+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF851F000E9;
	Wed, 22 Jul 2026 23:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763349;
	bh=LH119mwgEwnDe7yf1XKKMrd2W6TXNF6hXWATBdP8vrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=igRpw3+FJovHFN9d2Qisua94xLe7Y6FcjjF9j7Q8m33dQVi/i789c2VNx3lkt26qE
	 sEOXr+nSE3QSmSQ5fVLMjiumjcF5zfXTQUIqwKIHPq2lPVGkVRIJY21YT0gCu3iTxE
	 lzUuReDhRxrSwX3hui2EDiX7pQQzoXjkadoyxoMHmvGq+Vwkul0GcMsVDO50UFVJSd
	 JDQnnuMt+6ZNZso4KUTlP6PmLvmOC/z1A/viFDGX6mq4q7bc5MD0D6lZtJxYehB1Uy
	 MPKIGwzrHDyHiIGJ3SQkwIFbWgnBpFb/lfREIpgiFYiaRi929h3wtgXdcMI7g8emnd
	 nZAZ4jAA/04Hg==
Message-ID: <7a3647c91dac2faa35fd6ba29119806a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] sched_ext: Block proxy donors across scheduler transitions
Date: Wed, 22 Jul 2026 13:26:03 -1000
In-Reply-To: <20260721063242.552774-5-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
 <20260721063242.552774-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Tue, Jul 21, 2026 at 08:31:25AM +0200, Andrea Righi wrote:
> @@ -7168,7 +7168,8 @@ static void __sched notrace __schedule(int sched_mode)
>  		 * task_is_blocked() will always be false).
>  		 */
>  		try_to_block_task(rq, prev, &prev_state,
> -				  !task_is_blocked(prev));
> +				  !task_is_blocked(prev) ||
> +				  !scx_allow_proxy_exec(prev));

The condition fits on one line.

> @@ -7721,6 +7722,8 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
>  	if (prev_class != next_class)
>  		queue_flag |= DEQUEUE_CLASS;
>
> +	scx_prepare_setscheduler(p, next_class);
> +
>  	scoped_guard (sched_change, p, queue_flag) {

Calling directly into sched_ext from rt_mutex_setprio() and
__sched_setscheduler() isn't the prettiest. This may want to be a class
callback invoked from sched_change_begin() on the incoming class before the
queued state is recorded - the existing ones are either too late or on the
outgoing class.

Peter, what do you think?

> +void scx_prepare_setscheduler(struct task_struct *p,
> +			      const struct sched_class *next_class)

Fits on one line. Ditto for the declaration in ext.h.

Thanks.

-- 
tejun
