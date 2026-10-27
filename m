Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110140;
	b=DWPAoKw6728JRGbrS6ngttBk9+/vNeAFXXovSwqzoEkyhCUxLtgNzEEvMD0AhTeFC3gR
	 zVeFCJSxNwWGBUBdqjLWu8F2XkBIJJYN0s2MC18MLDfuBF3miG7PzUvvUvjD1GZNal29w
	 aUC1MAJf/atI9WDu7lnb4UV++sqnpCg8HnsjPFGPLR/BErfpHYDmjfMSt7bGY40AguDyr
	 ONnLOoGa3wiAFzAMXbZ8agWMycoqMZysC3TdhyQw8tumn+Mg5XIMQ+xXmo2iTUHPpfwjd
	 DdPVatq7JU6GmT9qvhWLJNDqPPD6jbSBlqK9btfjKQYJoL7HnF6Nl1i2IpceXGkiMWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110140;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=2dtL6jl4/hq2bElCEXWbNii6D363tMBVB39KbEeYxxw=;
	b=DUYZKAdfpZ/vhOiG2Y4hX+oURlpjfvce3DnFIuxZMP0P5fa5unFuMEx7slVHVBNTWPE6
	 s1oU99s53EPuBmiFe8IKTAI31vaUFU329b694aql32fehsc/xF2yCHgchUK9kV/m9f2ms
	 nKdhRGu/naKr7NvWmXdNalX8PRqv9soylrhk8ccKtF8VTh5CZcf6rUncs6KdNsVfDtE2B
	 JNV2cm9/hoBFxAAoUUv8a+jho2bcbLqtqJ1cSjBAA6q3UCJSG22iGBBgdVInV1MqXQOS/
	 lWBI2oS0o+lREm0VD+Pv9KSxQcgopI3mjlrIdFU3hjdXsmCp4e5BbZr836qvoQhOSmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKdjoG2k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6760A3812;
	Tue, 27 Oct 2026 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKdjoG2k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09E01F01345;
	Tue, 27 Oct 2026 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110140;
	bh=2dtL6jl4/hq2bElCEXWbNii6D363tMBVB39KbEeYxxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eKdjoG2kY5Kd0ZFlwd5CoiRCRX0Bg6BfEnC8PqCxqBh7bph3BpfLnQOvWL3GVsPmN
	 npEmC+etciBqtq6S9YKxIYr0PlJFHWVuQLUnR2LB3haW68+FSd5KYo85QgV6+zxTU+
	 zoa/QD01OdWdlgxk03SnzEx/d7W11hOw2HAhjNk1iHOTQnm1ELnzwl9elUX+hVKqAv
	 Gh2BvWZgH6ynu3JyyHZKEuz7h6vJuIv2KMFjHfMKb43Q8lgB4Z66znZigXZRj5KDrd
	 3GB1FnEsEQ365sXbsT0I2AAH0vddZ3BdBe55wTQxDWj2gg0u3mrcM2m7RMiFLZWNY/
	 4RfoP7r5taTmA==
Date: Tue, 27 Oct 2026 04:08:59 -1000
Message-ID: <4e5cef40129723ce203194f7a637b0d0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 13/18] sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE
In-Reply-To: <sashiko-outbox-185966@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org> <20261027001749.1821379-14-tj@kernel.org> <sashiko-outbox-185966@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello,

On Tue, Oct 27, 2026 at 12:44:18AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> When bypass_enq_target_dsq() resolves p against host via
> scx_resolve_local_dsq(), p is placed on rq->scx.rescue.dsq or admitted to
> rq->scx.local_dsq, whereas scx_task_sched(p) remains the bypassing child sch
...
> Should scx_rescue_charge() and check_rq_for_timeouts() attribute a bypassed
> task's rescue usage and stall timeouts to scx_exec_sched(sch, cpu_of(rq))?

The host is responsible for running these tasks at that point and is the
one without the needed caps. Fixed by "[PATCH 20/18] sched_ext: Fix the
rescue overload pick ejecting the wrong sub under bypass", posted in
this thread, which charges the rescue time to the host.

The stall attribution is fixed by "sched_ext: Fix the stall watchdog
testing and blaming the wrong sched under bypass", now in
sched_ext/for-7.4-fixes as 93b1512ca69f. The watchdog tests and blames
the sched running the task, which is the host while the owner bypasses.

> [Severity: High]
> What happens if a running SCX_TASK_NONE rescuee leaves its bypassing parent
> without changing scheduler class, such as via scx_sub_disable() ->
> scx_rehome_task(), scx_cgroup_task_migrated() -> scx_rehome_task(), or
> another scx_fail_parent() -> scx_punt_task()?
...
> Should __scx_disable_and_exit_task() also call scx_task_slice_ended() and
> scx_set_task_slice(p, 0) when p is in SCX_TASK_NONE?

Right. Fixed by "[PATCH 19/18] sched_ext: Fix use-after-free of a NONE
rescuee leaving its sched while running", posted in this thread. Leaving
a sched's control now resets the task's fields, a re-home and the exit
of a NONE task included.

Thanks.

--
tejun
