Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF542BF3F4;
	Wed, 22 Apr 2026 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776878649; cv=none; b=ecN81imScKQKLlfH9iyeiEPmDl8SwbtuIYKFIRwzZOWS13B6SVEtrX9cVSdIVWo4kl0nRsYBMyQuP3qDe84O7Ml2+9oRTSmeLzmmPnTToq2p1r12wZ0xujqreaYd6Ms5Vq5WSmy3EZBq19lnSBPNv09Z0ehF1WfXA7l6ksvfMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776878649; c=relaxed/simple;
	bh=V3pEWrnQvi5a6LYjnd3EQVj4UbCYUq/w1lPWAQcG0is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLq/4X+C12lGYvFRlqiVQht9hAQX1B5eZpKEojC9MzD70bs7+iRGPicJ+GJBZtKQOcPzXZbfgICpKISce6eDKDiib06RoX3KNod/OQRa2n71w+lrPjNi7v1ALUV1NpoClFC1zMZ9I/tZlOwht/ZyfcnFgNYOaTWtFzv/qLlD5p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMkbXpr5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMkbXpr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FBDC19425;
	Wed, 22 Apr 2026 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776878648;
	bh=V3pEWrnQvi5a6LYjnd3EQVj4UbCYUq/w1lPWAQcG0is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMkbXpr5BSHppt7BZ9xGpehWSE4w6T3NlrtnAtT/FQ4iJK0IemiAFAdluqsuYop/q
	 ybp52585brPBPgAS29Rbbd1uYlurrrgobfFOB7P97eqvTfeo03u9118tauAPUCLYDa
	 NnpA7pLZPKVGRk/OdNlgwQuM00LmBdc7eSuRkmC7jLcqd4ZW3GYL58Y256aiQ0sIXN
	 H1uus0x0wy/fOD/F5Jp/cgqwtNbrseSwAFlo1AvV4T5+aJQpeR4rQzQhIWx8zrLHDK
	 LtTqHb1YnTQfLkGnrG6cThglBlRFFEbcGRvZLIMhT9H6Ffw6fj6pP6OXBVWpAr0EVM
	 GgcEoKya4sZAA==
Date: Wed, 22 Apr 2026 07:24:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Richard Cheng <icheng@nvidia.com>, arighi@nvidia.com, mingo@redhat.com,
	peterz@infradead.org, void@manifault.com, changwoo@igalia.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, newtonl@nvidia.com,
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: sync disable_irq_work in bpf_scx_unreg()
Message-ID: <aekEN_dlewzVi-Hq@slm.duckdns.org>
References: <20260422100938.35781-1-icheng@nvidia.com>
 <20260422183307.Gf0f8@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422183307.Gf0f8@cchengyang.duckdns.org>

Hello,

On Wed, Apr 22, 2026 at 06:51:13PM +0800, Cheng-Yang Chou wrote:
> Also, scx_root_enable_workfn() has the same pattern in its error path:
> 
> 	scx_error(sch, "scx_root_enable() failed (%d)", ret);
> 	kthread_flush_work(&sch->disable_work);

Yeah, can you please add a helper - e.g. flush_disable_work() - to package
sync and flush and use that in both places?

> > +	/*
> > +	 * sch->disable_work might still not queued, causing kthread_flush_work()
> > +	 * as a noop. Syncing the irq_work first is required to guarantee the
> 
> Perhaps s/noop/no-op/? Though it's just a matter of taste. ^_^

noop is used widely in the kernel. In general, I don't think we need this
level of language policing.

Thanks.

-- 
tejun
