Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE793115AD;
	Mon, 22 Sep 2025 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559979; cv=none; b=jJNdKkCLcu4ZOsF/f99uMz2WOj3TnxY99wcAbJ0N/rsCydr5t5G4XE5sXNxUZ76polt5BDWr+ejTNeN+uOVBw6UD5epdsBEEetqjlsKqjf0wjeygLfg/E/oB6ggoJFnGucTrgiOsoloG1eANWqRFcQ76/JMMrWNfRaLUJ8y6X1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559979; c=relaxed/simple;
	bh=OCuXQqhvk5cSivdHAJGWAda1tAp8A7a/ttMvbmq2wGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xnwhbwl9nEMp6lPDV9q+IEDJ6AcmSQ5D+flntRqHRaXO4a1XXunZrNgUJGdyjw3Ob3Gz6/sWFspPTCVD4j+qganQxiaf3NrGpqbTwtfy2pVaMmws+07iBJ+PrhLBCuwjP/WDrYXmj7tyuoOg0VlyGMVKlPdQzq8qUmtWp8GG7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmVqeYKQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmVqeYKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBA5C4CEF0;
	Mon, 22 Sep 2025 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758559978;
	bh=OCuXQqhvk5cSivdHAJGWAda1tAp8A7a/ttMvbmq2wGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZmVqeYKQoOtTipuonon3LQCHIfKgyaAgXWpIy6IO69OXLQXCRsgF8UsVRfCE/66ae
	 GUTIcHpkFl/m3n6gFzLYWi8ED+tHEa5y6ObBd2uYGQK8RnvB9yAnWxrJbvWmy3Rari
	 LxN9kwNmwC7k4LVYOKI3ryXGdFSuraxcM1veRXZNjpE6wtvKA8B1AjZtiw9+wUDs3m
	 Rko5wTSAF70tnYqU8cSv9WZsWSIDn/8AQ5wkoJclhBXz8RRP0kgBIdnNhy3efE+KJI
	 eguSy3CHMDmzUkIBo0q2PLv+SELOPmT3HAWrKbxqYv7TYdYWP5KnguQNSWBFL62lx7
	 zC05ClgKmapSA==
Date: Mon, 22 Sep 2025 06:52:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: idle: Handle migration-disabled tasks in BPF
 code
Message-ID: <aNF-6bmzGgY5QaEp@slm.duckdns.org>
References: <20250920132621.16263-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920132621.16263-1-arighi@nvidia.com>

On Sat, Sep 20, 2025 at 03:26:21PM +0200, Andrea Righi wrote:
> When scx_bpf_select_cpu_dfl()/and() kfuncs are invoked outside of
> ops.select_cpu() we can't rely on @p->migration_disabled to determine if
> migration is disabled for the task @p.
> 
> In fact, migration is always disabled for the current task while running
> BPF code: __bpf_prog_enter() disables migration and __bpf_prog_exit()
> re-enables it.
> 
> To handle this, when @p->migration_disabled == 1, check whether @p is
> the current task. If so, migration was not disabled before entering the
> callback, otherwise migration was disabled.
> 
> This ensures correct idle CPU selection in all cases. The behavior of
> ops.select_cpu() remains unchanged, because this callback is never
> invoked for the current task and migration-disabled tasks are always
> excluded.
> 
> Example: without this change scx_bpf_select_cpu_and() called from
> ops.enqueue() always returns -EBUSY; with this change applied, it
> correctly returns idle CPUs.
> 
> Fixes: 06efc9fe0b8de ("sched_ext: idle: Handle migration-disabled tasks in idle selection")
> Cc: stable@vger.kernel.org # v6.16+
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.17-fixes.

Thanks.

-- 
tejun
