Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3645E2F4A14;
	Sat,  6 Dec 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765036751; cv=none; b=OpOojpDDoohcclZrSmeHB9XsTZuv7teir5l/TIW8ZWJj1hSsarlJakPC8mZlTDXs00hMjmEQmPbzcc5CpbWXR02sjes786NBLVAzZhQXhOeE7TvDhfrMCxIf3jVfuHmvrh7n67t1hMT2x1I9Q41H2mlLWAqp3DrQy/bbEcgn7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765036751; c=relaxed/simple;
	bh=012+E8xXKUl7FevUciQLG/+3QL0/VhlwzljEA6HF1YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p96amAMcVENd8Z+WZk5ATmRYHwCSB4E1WLBg2mMMTYyOac4YYY+FHZUy0AGoKzwX5sYmLj16CuY2q3F1Q3rLCGCYuB93+3NoYVJtUqKfV4YkRrkFf60Cx7oLYxzHvKLlADgHTbnrREWsDK5Q4POgW2d4vn1XcEuuj4Vy0jlbooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDa3Hv5V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDa3Hv5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89657C4CEF5;
	Sat,  6 Dec 2025 15:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765036750;
	bh=012+E8xXKUl7FevUciQLG/+3QL0/VhlwzljEA6HF1YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDa3Hv5Vta3nXLus3rLhEvAo7vXdIAMywXpeT092hrJsNJhDbPYv8Yu/+fBi3it/l
	 kh3SqVs3vPsidvmK13v8yAhaRyZ7LHJ5w/c4TKzSU4edfgmYJ/9L97e+BBbT3j3yt2
	 29O1waZRjd6yAUifmT0x8SQvAs88vVtXhvbMl7sfWmEJeMq7Z7s5W8U+0ZaIM1c6En
	 vTARuLPi0Cy3ksA4h1ABe8qvGwopu1Rm9vP0aWyzXFhwwYLsVlVvdRqvEFBT5NMjo8
	 zsXr8cAd/IFfAmNjy7VC25mBSFBhL9pGAEOIBSw7egTWNDiLymL+MY4srtOetqeKxp
	 +aLFDjI1N1C5A==
Date: Sat, 6 Dec 2025 05:59:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/ext: Split curr|donor references properly
Message-ID: <aTRSzTVeGfME1N5y@slm.duckdns.org>
References: <20251206001451.1418225-1-jstultz@google.com>
 <20251206024724.GA71744@joelbox2>
 <CANDhNCoe21MYZUmOoa7G0ecU9SJKTFtEp-LjOJXAsCj-ZpQb6Q@mail.gmail.com>
 <c31bc7c2-52b4-4a91-ae0f-259411145432@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c31bc7c2-52b4-4a91-ae0f-259411145432@nvidia.com>

Hello,

On Sat, Dec 06, 2025 at 09:56:50AM -0500, Joel Fernandes wrote:
...
> At a high level, my understanding is BPF schedulers have a lot of say in how to
> schedule including precise time slice and preemption control (give or take level
> of control and performance reasons). You can in fact have your own 'userland'
> queues that the kernel is unaware, IIUC. I am not sure if proxy exec will
> transparently work for all those usecases. It will probably work properly only
> when BPF scheduling in userland is simple and most of the scheduling is done by
> non-BPF kernel code.

Maybe this can be resolved by proxy execution explicitly telling sched_ext
to essentially dequeue the proxy-executed task so that it's kept more
transparent. However, I wonder whether it'd be a useful first step to first
deconflict the two config options. ie. Allow sched_ext loading disable proxy
execution dynamically so that people don't have to choose between the two
config options. I don't know the code intimately, but, from just skimming
it, it looks like it can be drained with a static key and some percpu
counters.

Thanks.

-- 
tejun
