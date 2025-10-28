Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA05285058;
	Tue, 28 Oct 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671239; cv=none; b=fRpep7vscg5i4diRNpV3lNeuWw8gZGLQdFBujNC1cp/SMT/H2aLkcjGED88Nh1Jz0jrmyqf9vA26rt8jB/c5vK3ZsLXuuXEeWXGWRddLplKPdL10GyXWD883cVNgATkGXk8YmLFzdEXwtEEfNcPiMuOS86umhiIj2zNgKk7qPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671239; c=relaxed/simple;
	bh=OnSAW2zDw/OL5sivcbq0+RLhJsVfKn5l3mZ8G8eZoKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8w5d0SuYNxlyIIjzllFIvQrZ++CSblmANSezBPszvZPydvffhBJwMEVl/bZ7neiSm7mto8ij8y6N4yOaCDxlAZTmjuXXUFFWUNRmMecA2JeqC+rkQoWwdRrU97VkAw0voTiFXfxq1QYLq3Yr4kpnNznSxzb4s60+mU7aD+kr38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svg/GQM+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svg/GQM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62564C113D0;
	Tue, 28 Oct 2025 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761671238;
	bh=OnSAW2zDw/OL5sivcbq0+RLhJsVfKn5l3mZ8G8eZoKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svg/GQM+6x0MHFM3Z90/JuijOfzGnjYHRKNqwpEnWZRILCM8U3tcbFAOiBrlrHlfj
	 BFPAnGVORNE9iTswPi5EKSwkOp0XlMuxMN+YJuOK6bOdd5HJRn5InMVHvR2EKMqfKA
	 ofVGdxEfm5T5x0VsT6oidibdgV43JScAKGgPazdkQoPxv77cxfM8wkcdG8BxwhQgGZ
	 Nb8ZTCFJzEkcWzpSEhlbLGYqm7e2ejcpQIItV54wR8RNZ26ldWQTQx2IbN94biPybK
	 w0jSAFTtTpJiYAz3HvYD9e4w+EFKJm+N5Hi6K8ztD7FM/lOcCQqm2jBudNjp3gsOu6
	 UMjQqFRZfXiSQ==
Date: Tue, 28 Oct 2025 07:07:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <aQD4RdAEpBSeI7nQ@slm.duckdns.org>
References: <20251025001849.1915635-1-tj@kernel.org>
 <20251025001849.1915635-4-tj@kernel.org>
 <20251027091822.GH3245006@noisy.programming.kicks-ass.net>
 <aP-XAGrWQY1d6Bq9@slm.duckdns.org>
 <20251027181028.GB988547@noisy.programming.kicks-ass.net>
 <aP-3QsygWJRn6Z2u@slm.duckdns.org>
 <20251028110153.GZ4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028110153.GZ4067720@noisy.programming.kicks-ass.net>

Hello, Peter.

On Tue, Oct 28, 2025 at 12:01:53PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 27, 2025 at 08:17:38AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Mon, Oct 27, 2025 at 07:10:28PM +0100, Peter Zijlstra wrote:
> > ...
> > > Just for my elucidation and such.. This is when ttwu() happens and the
> > > CPU is idle and you dispatch directly to it, expecting it to then go run
> > > that task. After which another wakeup/balance movement happens which
> > > places/moves a task from a higher priority class to that CPU, such that
> > > your initial (ext) task doesn't get to run after all. Right?
> > 
> > Yes, that's the scenario that I was thinking.
> 
> So I've been pondering this a bit, and came up with the below. I'm not
> quite happy with it, I meant to share that new queue_mask variable, but
> this came out.

Yeah, something like this that creates global state tracking from wakeup to
dispatch would work. However, from sched_ext POV, I think TP route probably
is a better route at least for now. Once reenqueue_local is allowed from
anywhere, which is useful no matter what, there just aren't good reasons to
maintain ops.cpu_acuire/release(). It doesn't allow anything more or make
things noticeably more performant or easier. It's always nice to be able to
reduce API surface after all.

Thanks.

-- 
tejun
