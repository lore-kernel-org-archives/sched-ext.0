Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D161A2545
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759947646; cv=none; b=gG73vTIFlW5TGxJceSSWb2hmW2cJdQpjkGEPBtKOy2OCmmLvNB1kTawvj7KJL5pqDWe33qC1NILDDwvl3VDgahKZfWaAQc7tabkI+fOLI5ns+HW12MoxGvy19AJLXUHXGawOnczF+yeJ50BRa/JwmPqLSAMfqVbgYW0pxurqOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759947646; c=relaxed/simple;
	bh=BIer1vahMoSTNf/8VQeJIF0T9DRb8ixp0DXUjfiI/pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiC3qi+hE1K9JhYRdUUczFEzuM8ZiticEXjhhdyqdEWeG0mjYC0cCuYSa1efLRdMJzsbcDE7iw5c14uiek/LiOMFhiPXyVF0znQn9PuDYRH5Ma6bL91/Epayx16wJbeMbKGHxiYiNWFOF+td4dd9Eg+4E9P8y2wgj5gsUBES5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6m3tVzk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6m3tVzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34B1C4CEE7;
	Wed,  8 Oct 2025 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759947645;
	bh=BIer1vahMoSTNf/8VQeJIF0T9DRb8ixp0DXUjfiI/pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6m3tVzkfpgn3SU4MTcpBXwaSznWF5wHyhAo9UeHkm5a4igXdeWIbuTUydP1oHM06
	 96S1mFwcivpPAahvyfdUa/dHWV6zb5j60MFSqmMakpM88LYqsjM4WG4oUistTl7r0g
	 1bZkVPiDXjEoCjNWBSDWaGNj/giCIo9uoLNZ4VRManqtxBjwGCTuf0EptM9E6T92PP
	 9ji02zePiIn2BOjrEhY4HTcM2CJkefH2UaAFYRaAZKJywyjqKOe65fFu3Dm0/OQuY1
	 ygbJd5e0S+5nW3CLIOPczKx6dCKbZbBYA75NeJTiEFHiQG02Pv2n0ovQVkG/UbWCFq
	 bsjroz2M95R2A==
Date: Wed, 8 Oct 2025 08:20:45 -1000
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, suzhidao@xiaomi.com
Subject: Re: [PATCH] sched/ext: Add tg->scx.idle which tracks the current
 state
Message-ID: <aOarfQm218sITkrG@slm.duckdns.org>
References: <aOVmuWwyLUNkPG7S@slm.duckdns.org>
 <20251008021031.630303-2-soolaugust@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008021031.630303-2-soolaugust@gmail.com>

On Wed, Oct 08, 2025 at 10:09:39AM +0800, zhidao su wrote:
> Add an idle field to the scx_task_group structure to track the current
> idle state of a task group. This field is initialized to false in
> scx_tg_init() and updated in scx_group_set_idle() when the idle state
> changes.
> 
> This allows BPF schedulers to check the current idle state of a task
> group directly from the scx_task_group structure.
> 
> v2: Add tg->scx.idle which tracks the current state

Hmm... maybe a blank line here? I don't know whether there actually is an
established convention but I don't think we usually put version delta
descriptions in the tag section.

> Signed-off-by: zhidao su <soolaugust@gmail.com>
...
> @@ -4273,6 +4274,9 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
>  
>  	percpu_down_read(&scx_cgroup_rwsem);
>  
> +	/* Update the task group's idle state */
> +	tg->scx.idle = idle;
> +
>  	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_idle))
>  		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_idle, NULL,
>  			    tg_cgrp(tg), idle);

This can be either way but scx_group_set_weight() sets the weight after
calling the ops.cgroup_set_weight() is called, so let's match that.

Thanks.

-- 
tejun
