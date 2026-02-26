Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B13D2FF5;
	Thu, 26 Feb 2026 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119334; cv=none; b=YC8O38Cwl8x4ikvePQ+XsMPm1Ah00Bzn5PRyJ1TXZqXpoc3TN1sbe8Uw/ExGysulH6QNp7Y2zhkbD1nQ/wQe+Sc3MNHRa59fPjEfG4Ps19db+GM/cKSRx6xD89VVL/ZeCOCRrGJF4JskMiP7Tyyid40R4DddqJEfMo4BdKbq8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119334; c=relaxed/simple;
	bh=MBbNwudkADFdHHgGePERLxFAWmwSoGLXaiy9nfRY2Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOysBJEWnP3HajZsEI7kUiMd8PUIna4Na/E/TFpZ+a6DVbWW7UEGOxoMW1yA4wDa0i+o8GTKsEXkGMWjA9uuU4Awh15OgXwtn/Ddx3+gyWDnaITRlAHjvdu4r9h2oVEoUxYS4arByEEYONnZoHLW2vqTr+oxu/H5XA/y5/axRPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcgEKWfD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcgEKWfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502CBC116C6;
	Thu, 26 Feb 2026 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772119334;
	bh=MBbNwudkADFdHHgGePERLxFAWmwSoGLXaiy9nfRY2Kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcgEKWfDZjMyqt+RoQ747oDHbbOosIJSk1rN9DMKFrynac6F82b1Eu6xLcaZhx5fn
	 EMhdzKeX4qrXnd8TOjtmgMxQ7aVRaBzCb3L5e+rFnSqTSYM9wUGwOc/XAmWPZY3agb
	 kpRs2gnJIaIJiHgRppUO0jm0OXgZPhT678/OPrOMAvzhOZ5ctqFgXaUJ0ZsNrtQ+kh
	 OJKxkf84sSXUWQYDZgYAfmCDmvXsvM9PxgtYUfMZcTzlA9eh7QQ+NCfBbUUISKgwmH
	 cUfnXM0leUshhP3R5zI9+ARTnrlkFPZQaDfN+5eF2JNemv7FBFJ7HT65UhKOTEoILj
	 PbzTJwq4Z2V0g==
Date: Thu, 26 Feb 2026 05:22:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 14/16] sched_ext: Export task_is_scx_enabled() for
 verification
Message-ID: <aaBlJT9Mac9KQpKL@slm.duckdns.org>
References: <20260225095122.80683-1-gmonaco@redhat.com>
 <20260225095122.80683-15-gmonaco@redhat.com>
 <aZ8snSHWw-U0lVz2@slm.duckdns.org>
 <8fbc3ced19fb0c2a2171708073fa51ae308755b5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fbc3ced19fb0c2a2171708073fa51ae308755b5.camel@redhat.com>

Hello,

On Thu, Feb 26, 2026 at 08:10:52AM +0100, Gabriele Monaco wrote:
> On Wed, 2026-02-25 at 07:08 -1000, Tejun Heo wrote:
> > On Wed, Feb 25, 2026 at 10:51:20AM +0100, Gabriele Monaco wrote:
> > > When a sched_ext scheduler is loaded, depending on the configuration, it
> > > can handle also fair tasks, however it isn't trivial to understand if a
> > > certain task is currently handled by fair or ext outside of scheduler
> > > code. This can be a problem when writing verification or observability
> > > tools like RV monitors.
> > > 
> > > Export a task_is_scx_enabled() to allow quick classification by using
> > > the scx state SCX_TASK_ENABLED.
> > 
> > This test already exists - task_on_scx(). Please feel free to move that out
> > to include/linux/sched/ext.h.
> 
> Mmh, right, thanks for the pointer!
> 
> I see task_on_scx() is used in what looks like some sched core hot paths (
> pick_next_task() -> prio_less()), but I presume not inlining it isn't a big
> issue.

I mean, you can always export what task_on_scx() accesses.

Thanks.

-- 
tejun
