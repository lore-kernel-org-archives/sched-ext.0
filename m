Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28453314A4;
	Wed,  4 Feb 2026 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770237310; cv=none; b=jZyhLM4UM2sPV7/Jij5AnSe+DwaR+G9x2VUOAwkthlux6QigrWh1mOixLYQh1gw8PhrDCKEZO8Smbs6Env6GCHhmrqgjCeppc2u2gjlywwH8QGG4M8ObpA8GevU/GNVdbZri7AuMTMsbOf0ynChwqO7lrygpOyk8jscBEbvecMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770237310; c=relaxed/simple;
	bh=+dl+qRFSKU27rrTtvQzFeQr6KnCLJZ7C/WC2ZXdmjf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwTntGgGJ/QSv+bQmzLtncP/pS8s91Lvf8LZxqE5n+fAa8d9eP53fhVUMX2T3ZC8WpcDTA2Pbh1a5OT3I1m0q3cqBWL4ajUqMnl5TmeLFcyM3qiGpnk/sUEJrDbXBN8hy4EFRXzksicTMZ1NU/PyVTKtDI59T/AOC+dLfymgu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlgPwqwF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlgPwqwF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71524C4CEF7;
	Wed,  4 Feb 2026 20:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770237309;
	bh=+dl+qRFSKU27rrTtvQzFeQr6KnCLJZ7C/WC2ZXdmjf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OlgPwqwFh8s+gDSh9sXJ1D0fMZ3EZ6nY4Z+U2tgNp8vyfXmGJV0yy30uLzkr7fsju
	 ROJU2v/1KeTXIoRv/wBxx2bn2URFFKvYrQSSOl2p/smq0YGDPIxcBIh+0xa8GxJA6T
	 SbYi9BRz5CbQyNjz9UncdrTXqVML29yibn51Dw9KaO7Jmz7V3Zm6gHsXacmq9j4dtZ
	 gmYeknRqC62yRNN7vkwUXHdyyLuJJAd81fvYKS2rwg1l3JxUk8Et7nak3LZwdRfrjK
	 6ykDoUz98rd1Ep4LS1UOrnMn5QdqZtfEqJvxV+k4mwRGeJ0ARHb0ecO0trrFJA3DS5
	 +dn6748DdWIxA==
Date: Wed, 4 Feb 2026 10:35:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Jake Hillion <jake@hillion.co.uk>, zhidao su <suzhidao@xiaomi.com>,
	David Dai <david.dai@linux.dev>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ryan Newton <newton@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/ext: Add cpumask to skip unsuitable dispatch
 queues
Message-ID: <aYOtfCoL2vfvFprQ@slm.duckdns.org>
References: <20260204093435.3915393-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204093435.3915393-1-realwujing@gmail.com>

On Wed, Feb 04, 2026 at 04:34:18AM -0500, Qiliang Yuan wrote:
> Add a cpus_allowed cpumask to struct scx_dispatch_q to track the union
> of affinity masks for all tasks enqueued in a user-defined DSQ. This
> allows a CPU to quickly skip DSQs that contain no tasks runnable on the
> current CPU, avoiding wasteful O(N) scans.
> 
> - Allocate/free cpus_allowed only for user-defined DSQs.
> - Use free_dsq_rcu_callback to safely free the DSQ and its nested mask.
> - Update the mask in dispatch_enqueue() using cpumask_copy() for the
>   first task and cpumask_or() for subsequent ones. Skip updates if the
>   mask is already full.
> - Update the DSQ mask in set_cpus_allowed_scx() when a task's affinity
>   changes while enqueued.
> - Handle allocation failures in scx_create_dsq() to prevent memory leaks.
> 
> This optimization improves performance with many DSQs and tight affinity
> constraints. The bitwise overhead is significantly lower than potential
> cache misses during task iteration.
> 
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>

As Emil pointed out earlier, this adds overhead in general path which scales
with the number of CPUs and the benefit isn't that generic. Similar
optimizations can be done from BPF side and throwing a lot of tasks with
varying affinity restrictions into a single queue frequently scanned by
multiple CPUs is not scalable to begin with.

Thanks.

-- 
tejun
