Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557322550D4;
	Mon, 10 Nov 2025 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800254; cv=none; b=J9bo4hx3BqrdyECHagHT7Nj2TjDy9bDZTCdy65Z7O84M2obk3Z5rIBxMag4RCof8/QAbirOUikzr/dF7D3dqo3azLb1tzJx5MjySHSg5sCRdLscVw/HjR0H9gQpxh6Lmzn3UU1+jjULcgUK2RnsU1Mx4mf8NmXc8eyTMA6uX9xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800254; c=relaxed/simple;
	bh=8+lAHIqieOOtVnVVbRaiVbcQW8h7wJOabZhBh1JIluk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+WwXfFbODFHfMbiofTyB6IvVJuXFW3iH3yzQITcRI6BaMefiaP65VWTZ+utRK/coJcX8jZm3hzfm/+IAoX5x098RGfTXy1eGT4PoHu+NskYv0BxN8Ed4K3jK50D6JxDt1+c3C1FNO+U3P7xM1zjknz4aQfX5zyZVhDla0I6Yd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1WWIiqc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1WWIiqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E8AC116B1;
	Mon, 10 Nov 2025 18:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762800253;
	bh=8+lAHIqieOOtVnVVbRaiVbcQW8h7wJOabZhBh1JIluk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1WWIiqc9ZSwaS5SwGimqLVGQOUOqtPtX8FJdnSTFmdwzq7FAWLT4qHAUrRVRdsFe
	 VDayr+2oUXNx5pkOmbIi2QGn4rL0QPar9Es7uSn1w5FcjS4lc73BBwoAa9lacEHFy4
	 V1r6UQNzB7imRCbSW6bo5zos5xJ5SnZZgYVYVIlLEnGuIlrbRktHrqxths/MYBqT4w
	 IKMZLKzR3qjeDOZDxmcrb2pvP+SnxB1pA54bUikOZO6E+V+ouB7DpPpKiXQLjRurVm
	 25si24rKrNEPUXV9GmxITztTHEkKiHadM1XKke6BcB1wUIidF4x8sPS677XOl1I7BX
	 I/OmYk1Ppy8jA==
Date: Mon, 10 Nov 2025 08:44:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] sched_ext: Add scx_cpu0 example scheduler
Message-ID: <aRIyfJWJ6fcW5frO@slm.duckdns.org>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-12-tj@kernel.org>
 <aRGkHhAWTWdWELAY@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRGkHhAWTWdWELAY@gpd4>

On Mon, Nov 10, 2025 at 09:36:46AM +0100, Andrea Righi wrote:
> > +void BPF_STRUCT_OPS(cpu0_enqueue, struct task_struct *p, u64 enq_flags)
> > +{
> > +	if (p->nr_cpus_allowed < nr_cpus) {
> 
> We could be even more aggressive with DSQ_CPU0 and check
> bpf_cpumask_test_cpu(0, p->cpus_ptr), but this is fine as well.

I did the following instead:

  void BPF_STRUCT_OPS(cpu0_enqueue, struct task_struct *p, u64 enq_flags)
  {
          /*
           * select_cpu() always picks CPU0. If @p is not on CPU0, it can't run on
           * CPU 0. Queue on whichever CPU it's currently only.
           */
          if (scx_bpf_task_cpu(p) != 0) {
                  stat_inc(0);	/* count local queueing */
                  scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
                  return;
          }

          stat_inc(1);	/* count cpu0 queueing */
          scx_bpf_dsq_insert(p, DSQ_CPU0, SCX_SLICE_DFL, enq_flags);
  }

This should be safe against migration disabled tasks and so on.

> > +		stat_inc(0);	/* count local queueing */
> > +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
> 
> And this is why I was suggesting to automatically fallback to the new
> global default time slice internally. In this case do we want to preserve
> the old 20ms default or automatically switch to the new one?

Maybe SCX_SLICE_DFL can become runtime loaded const volatile but anyone
who's using it is just saying "I don't care". As long as it's not something
that breaks the system left and right, does it matter what exact value it
is?

Thanks.

-- 
tejun
