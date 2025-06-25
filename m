Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8730749E;
	Wed, 25 Jun 2025 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892826; cv=none; b=a21K2E7Ua54WC8gLr6GjiI5RR1Ylx/1jMUKb3i2ncZRGqawB3v/cV/KgW9AI0TQFOMpJhfBpKH18INKg5VrDTW+BkRhRDgT04i0cgWMrzefcvGKntuosKNrwx2FHM5oVTs1p2bVN9As3TbZSOjviCIrAzAGFiZs3A7DP9RkvRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892826; c=relaxed/simple;
	bh=ltCoo6osxwk4k0lJLXSGNXx2b4oy+RQ6KefWTPp+Wy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXW9gPhXGGIBZATnrpyoQozZU9wovpKBS7TfZLNXSct2WauszJc27lJqrzsUSvtw3DCTbpXLmL6r68f/t49b8/LAaa5+6XS+7R/RwG1vMkcFEeb0XGNTfb9Hxo3f4EZvgBCdWxmZa6j3WWwH9tjbhTsomqmBhm0mqX8BEpd14QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnaDl0w9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnaDl0w9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEB6C4CEEA;
	Wed, 25 Jun 2025 23:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750892825;
	bh=ltCoo6osxwk4k0lJLXSGNXx2b4oy+RQ6KefWTPp+Wy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnaDl0w9eVbydX2XwvO1tA0RjK8Z5zEMLte/cJireSUaav4f3nlGlECwQMoJk1Sgj
	 wuXLDKBO2y9my+4Jd6CTgZdZ4Pie7aSfqbrkO798pLPWCm4+cnhyyIKeL5jEw2fGdg
	 v3SLPvzmgbiSFSglBeBUT9vVXdJhak3uk9WYY8voB80DdXFJrym58UwbdsUPS/A3bv
	 m1f3UdGJKsXVI+vLk4leLqeWrlzn4UikyEgRtzCn1xEhVdC6KEjtlEyoMdtkLu9EZt
	 Aut8fHNQ4pBRadWGqfjCvZR+FWGAtW96ZKP4JSz3TECEMKziGBGp35XWBMmbhh3yXv
	 pqzIh0DHnL7gQ==
Date: Wed, 25 Jun 2025 13:07:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Henry Huang <henry.hj@antgroup.com>
Cc: arighi@nvidia.com, changwoo@igalia.com,
	=?utf-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, "Yan Yan(cailing)" <yanyan.yan@antgroup.com>
Subject: Re: [PATCH v3] sched_ext: include SCX_OPS_TRACK_MIGRATION
Message-ID: <aFyBGAce73hzbPhQ@slm.duckdns.org>
References: <aFmWGi8n1ndB1K_M@slm.duckdns.org>
 <20250624030314.48808-1-henry.hj@antgroup.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624030314.48808-1-henry.hj@antgroup.com>

Hello,

On Tue, Jun 24, 2025 at 11:03:14AM +0800, Henry Huang wrote:
...
> We will traverse the per-CPU map information in ops.select_cpu() to select
> the appropriate CPU. To reduce the competition for the rq spinlock, tasks are
> likely to run on the CPU selected by ops.select_cpu().
> 
> However, I can think of two scenarios where passive migration may occur:
> 1. set_task_allowed_cpus
> 2. cpu_stop

What do you mean by "passive migration"? The above two cases would still
travel ops.enqueue(). There are cases where ops.select_cpu()'s return value
or the local DSQ that ops.dispatch() targeted are overridden, mostly when
the CPU goes down inbetween. Are you referring to those cases?

> There may also be some passive migration scenarios that we haven't thought of.
> This could lead to incorrect information in the per-CPU map. Therefore,
> we hope to track enqueue_task_scx and dequeue_task_scx to ensure that the
> information in the per-CPU map is accurate.

Even in such cases, wouldn't something like the following work?

void my_running(struct task_struct *p)
{
        struct my_task_ctx *taskc;

        if (!(taskc = lookup_task_ctx(p)))
                return;
        if (taskc->cpu != scx_bpf_task_cpu(p)) {
                /* update other stuff */
                taskc->cpu = scx_bpf_task_cpu(p);
        }
}

Thanks.

-- 
tejun
