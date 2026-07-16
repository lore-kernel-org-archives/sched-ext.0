Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E53C3F6D;
	Thu, 16 Jul 2026 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237379; cv=none; b=Qv1FKDVHJlaV8/XS32p/R38sevHu3SJNFCXjBqwGcRTONLwsJIhhyVMLizlUC1uI6WKYfHD6Lf6DWNE+YAERMecA7Nuxx7234a1au/589E5uO+b0fGF+Fp1GHFN5HC+iFtUfmORGrfDI6wLDFl891oqcRzpQV5I2jrVuEr8Ju7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237379; c=relaxed/simple;
	bh=iHhKHZwMjn2Y0qBy+r7cHIWTZUnbzBKZTt0+Z9/NfJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGhVmoaxJL3pykVeBwkXtRzrn60RukRqjTzkftAV+7hZbY7OPR1a7vLDbyBUNT8YLpJ9l+tydHfhIS8nMvQcCZ160KEfVqmTxdZCDBESzsGOR4GvXglaLkSrmC4rF86NvGB8z0pJqbe/w1KiacJSYvhFG06Q+oBABVwe5FFkb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lwuf4SZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lwuf4SZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFC41F000E9;
	Thu, 16 Jul 2026 21:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784237378;
	bh=xC8BkQ15Ke5dZ75LRZUPah7j0eIbv2+l7v8KGiu9l94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lwuf4SZhrOZlJP6W6/TPEZ8xNJ6wzMnTLUiUYHPewWD56c/8fJS1Ogx96eKwQjy81
	 oT8V8cITjguuTzBadzK3AAwuPiEjipRRh6uqy4pCkByNK1xvsQp8doHSQn8C8GyNTw
	 nwEmOpJuu2bxO4gHQ6rfxLPhFgpxzWoTG5G/GNjvMBjs37oTxmUUKeAOjsUIhxfqzM
	 mmnSn9eCg2nwkbWU/QuBuUzNTxhQsVfZexMChwtc7NQLF3U4bsc9H5vBBRHbs17/Q6
	 Rdu/sNqUQmQd1kxxfwWUEUmamkhRsmN0azTZAYG8qtd4crHFCbKAfvwmuY1HHHOfuf
	 dFHEMoVtIjh4A==
Date: Thu, 16 Jul 2026 11:29:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] sched_ext: Fix TOCTOU race in consume_remote_task()
Message-ID: <allNQY8BZ7qMQjmm@slm.duckdns.org>
References: <20260716132229.61603-1-arighi@nvidia.com>
 <20260716132229.61603-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716132229.61603-6-arighi@nvidia.com>

Hello,

On Thu, Jul 16, 2026 at 03:20:40PM +0200, Andrea Righi wrote:
> When pulling a task from a non-local DSQ, scx_consume_dispatch_q()
> filters candidates without holding the task's source rq lock;
> consume_remote_task() then unlinks the selected task, drops the DSQ and
> destination rq locks and acquires the source rq lock before migrating
> it.
> 
> Whether the task may be remotely migrated can change across this
> handoff. In particular, proxy execution allows a task to execute as
> rq->curr under another task's scheduling context while its own
> scheduling context remains on a DSQ. The task can therefore become
> on-CPU or migration disabled without dequeueing its DSQ entry or
> clearing holding_cpu.

I don't think this can happen w/o proxy execution. The task is enqueued and
can't be dequeued or start running without grabbing the DSQ lock. Before the
DSQ lock is dropped, p->scx.holding_cpu is set and if that hasn't been
cleared, we know that nothing else has touched while we were switching
locks.

If this no longer holds w/ proxy execution, adding further conditions are
fine but let's make it explicitly for and confined to proxy execution
enabled cases. The logic there is already subtle and I want to avoid adding
misleading checks.

Thanks.

-- 
tejun
