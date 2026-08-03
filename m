Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC4C3A63F2;
	Mon,  3 Aug 2026 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789402; cv=none; b=AO7UUR5PBCQLdLhOC8UpT73t1A1lNQh9lxafYJ6KTGgMCnoGEfgQuj+unnEr/Ulh4W1socVzOWHgYrgoDHMzlJqtFCF4OYZ44+9teXEuou264ZpLX8tL2JtO/mWE60xmF5VXrghdygoGXOwNPUkdhRO/Ybf8C8pzSWQApf0i3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789402; c=relaxed/simple;
	bh=+Nnm90WwXIAHsFwypoUtkSaINOkZj8vb2mS6G/siPNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW6e3G7bd2NK/ktrRZGPcS1bhyx8VvScIsvrH8OR/nyRFv4nQ0YIrquGOwhIOP3Bug+A0yWs8ezSPs0MZuqulmHluWW94GTF6SPzLCkOi0QvjPa8MQkpUzGooG4KME+IiTR3wkzWFwy5PHANK2KE7Mtr5h50LI3xu1vRYAEZ59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaVlSoj8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaVlSoj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553771F00A3A;
	Mon,  3 Aug 2026 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785789401;
	bh=EZDdgsM7CaBT2uXC9uYwCc9GQpztNIQoQk80pJ96bXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AaVlSoj8tqUbSkrPAHX/ywI8exoz7FYF7NuwxfnXEDw8LxHvK2ks4pUhQUOcTPTga
	 JtUrVQYtoZFCq68AgttaR9pYljGw2Q8nZV+Kp83o7qP7GlzoYqrkVtgPmvENBDhRrE
	 52KQg3RXVoNPF5HhbQlQggMBSQZBDiYrMozL53iHgXCaZEqUlUK+JUJ0afOAmUZRth
	 fUBzPXIcLX0UjwRuc1N42yZErNmzUuyP/kVfPdCsFuBf5ColOLpZPtW52PYkGGQDBs
	 v23ePvCm2tqTbQUwj71+OpMQjjyt4T35RJZyb3yXbBWTlPksrixYJ+bFYx4M+vUuhN
	 5Tqy8zfEfjHbA==
Date: Mon, 3 Aug 2026 10:36:40 -1000
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
Subject: Re: [PATCH 07/15] sched_ext: Block proxy donors across scheduler
 transitions
Message-ID: <anD72EDnXYgSg5Eg@slm.duckdns.org>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-8-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728154425.1549660-8-arighi@nvidia.com>

On Tue, Jul 28, 2026 at 05:43:25PM +0200, Andrea Righi wrote:
...
> +static void prepare_switch_scx(struct rq *rq, struct task_struct *p)
> +{
> +	lockdep_assert_held(&p->pi_lock);
> +	lockdep_assert_rq_held(rq);
> +
> +	sched_proxy_block_task(rq, p);
>  }

Are there use cases where proxy execution instance needs to survive across
class changes (the mutex rt PI, maybe)? If not, maybe this can be the global
behavior?

Thanks.

-- 
tejun
