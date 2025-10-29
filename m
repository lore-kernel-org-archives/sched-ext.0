Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA22E0901;
	Wed, 29 Oct 2025 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750721; cv=none; b=DgL1GI+JbTL4LhueTrobvHFj8iZtutj9ghJMQ7u4yXk2mTQSyZtZUHu7aFCdMXz4i2p7pYKAairD0RIRElXEbiLAD0zEdo9BybxyV8m6wad0ftk7WWAOBDt5bgJGepaecrBT/I6IJlzusZJdWQqQO59IsAboqDTrl6mflI7TmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750721; c=relaxed/simple;
	bh=p8U6eXtI/y0u8cy9tTh7hEYJQEBjW65osHVr+rdqzWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLSnMF/9Q6CC+c4gZ/L9XvYeitrxAvGukt3X5IyYVMk777rKJUzkASA3pkF9SiQ6Hq9UxO6ACjCkFQu5CkVEfLVMdWLHdOeJTQ/GW3Ji25WII+WimYPej2/DoM+uR7R+8MP442psWnMjrMeCj67uz9iG+A2xXcKtFIVfgs1CPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLt0YjKm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLt0YjKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD200C4CEF8;
	Wed, 29 Oct 2025 15:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761750720;
	bh=p8U6eXtI/y0u8cy9tTh7hEYJQEBjW65osHVr+rdqzWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLt0YjKmQFILafJC1zKCzuWAUUICI6A6dIdS2d466CrL7PEQdgF4YdrDAew6Pvj9B
	 lZ80XrAO/w4o/fBxWPzU5c+Zz3LQiQBhpDsbSHtzrCjCmZ6mWQTi09aicjZ4jHcI30
	 ffvkOncJJqck/hJC0P5cWSBMWUntfvmnTzp6GMAweZ4vp7Mnax+Aeu036V3THPBRbs
	 qn0QpmUnZ1QSSV6uWgQgP0uc7PT5QMq9Ct4llmFNCeADlC72LjAZiIero7T9DDeGoj
	 0RtrmQhQ9juf4Rj2yA8KWP964OAU56VU6Yi33fMpoBxK8HLiOHg4XTrERvuEr3Jwg2
	 NK7tR5ihak31w==
Date: Wed, 29 Oct 2025 05:11:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH v2 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <aQIuvlNSUAEGISl6@slm.duckdns.org>
References: <20251025001849.1915635-1-tj@kernel.org>
 <20251025001849.1915635-4-tj@kernel.org>
 <aP-3vOtH9Dyg_R9w@slm.duckdns.org>
 <20251029104546.GI3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029104546.GI3419281@noisy.programming.kicks-ass.net>

Hello,

On Wed, Oct 29, 2025 at 11:45:46AM +0100, Peter Zijlstra wrote:
> On Mon, Oct 27, 2025 at 08:19:40AM -1000, Tejun Heo wrote:
> > The ops.cpu_acquire/release() callbacks are broken - they miss events under
> > multiple conditions and can't be fixed without adding global sched core hooks
> > that sched maintainers don't want.
> 
> I think I'll object to that statement just a wee bit. I think we can
> make it work -- just not with the things proposed earlier.

Sure, I'll massage it a bit before committing.

> Anyway, if you want to reduce the sched_ext interface and remove
> cpu_acquire/release entirely, this is fine too.
> 
> I might still do that wakeup_preempt() change if I can merge / replace
> the queue_mask RETRY_TASK logic -- I have vague memories the RT people
> also wanted something like this a while ago and it isn't that big of a
> change.

Yeah, being able to create some kind of interlocking from ttwu to pick_task
is something generally useful, I think, even if I don't use it right now.

> 6.23 is a long time, can't we throw this out quicker? This thing wasn't
> supposed to be an ABI after all. A 1 release cycle seems fine to me ;-)

We've been discussing about compat policy lately and I think what we landed
on was maintaining compatibility, when reasonably possible, over one LTS
release + a couple non-LTS releases, which comes out to ~1.5 to 2 years.
That seems to give most people enough sliding room while not choking us with
too much compat overhead. This is a bit more work but it is actually
surprisingly not that painful with all the BPF compat features, and seems to
hit a reasonable balance.

Thanks.

-- 
tejun
