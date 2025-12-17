Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE7A33B6E9
	for <sched-ext@lists.linux.dev>; Wed, 17 Dec 2025 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973056; cv=none; b=lRInVL9pV4DK6iKF0SiKABgrWUq4hH1NS7vqnOBkgEpkqpJsW0ldkB5A0+NVrWNEShD4Z8QiSmpnAhFMm0p5ci1lRbN7TB8LnlWWoELeyoive+W8PYe9D6wRBoefp/luvtgNJKqTTcrhWpiTcvIP7hWfEQMDobPV7Yygfi1FoCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973056; c=relaxed/simple;
	bh=2nSEZnYz8i0wCoqWFIGWTe/zyoi0uztU0wWVmvJex2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhosmiZ3RRmF1qXprhau8QzTYafU/m4Yn9IlAW5raQ6KKDf5SmEb1T5+GHjBfXMD4fnvR9opgWhLRxY+mmjjI/T0uiNbdIKNKJe8KS2//V8SqbXe9RZ+120fpnXqWW16RSMAuwbXcmVxjOT/sjRrnvwZJJ3Y0XDIt2iyOOjynGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 826BA14BF;
	Wed, 17 Dec 2025 04:04:06 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 259083F73F;
	Wed, 17 Dec 2025 04:04:11 -0800 (PST)
Date: Wed, 17 Dec 2025 12:04:07 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: sched-ext@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com
Subject: Re: Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at
 sched_change_end
Message-ID: <aUKcN9jKInzxM8tB@J2N7QTR9R3>
References: <CA+G9fYuphjUO2x6qP2qPBFGSYz2WPp8fdGdiNGtyd1PmEVJrmQ@mail.gmail.com>
 <aUGVACX9sd4IUR9k@J2N7QTR9R3>
 <CA+G9fYv-h1ONWq232S0BxpdWy52ysPs1VPzKV6ZypSV6B_VSpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYv-h1ONWq232S0BxpdWy52ysPs1VPzKV6ZypSV6B_VSpQ@mail.gmail.com>

On Wed, Dec 17, 2025 at 12:41:39AM +0530, Naresh Kamboju wrote:
> Hi Mark,

Hi Naresh,

Sorry for the prior reply being a little blunt, and thanks for the good
natured reply; I've tried to provide some more constructive notes below.
:)

> On Tue, 16 Dec 2025 at 22:53, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Dec 16, 2025 at 05:09:52PM +0530, Naresh Kamboju wrote:
> > > The following boot warning is noticed on qemu-arm64 devices booting
> > > Linux next-20251215 on wards.

> > > - New regression? yes
> > > - Reproducibility? yes
> > >
> > > First seen on next-20251215
> > > Bad:  next-20251215 and next-20251216
> > > Good: next-20251212
> > >
> > > Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at sched_change_end

> > The warning you quote should be the *FIRST* line after you mention "The
> > following boot warning".
> >
> > That should be quoted *exactly* as the kernel logged it, without being
> > prefixed by "Boot regression: arm64:", which the kernel didn't log, and
> > which is redundant given the title and surrounding context.
> 
> The additional prefixes were introduced for internal statistics
> tracking and report classification purposes. However, I acknowledge
> that they reduced clarity in this case.

That's fair enough. My key complaint here is just that the initial
message had:

| The following boot warning is noticed on qemu-arm64 devices booting
| Linux next-20251215 onwards.
|
| [ several lines that are not the warning ]
|
| Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at sched_change_end

... where a reader has to skim through all the irrelevant lines, and
then it's not clear that the line beginning with "Boot regression:
arm64:" was the actual warning.

Whereas if that were formatted something like:

| The following boot warning is noticed on qemu-arm64 devices booting
| Linux next-20251215 onwards:
|
|   WARNING: kernel/sched/core.c:10851 at sched_change_end
|
| Note: full splat at the end of this mail.
|
| The testing system has characterized this as follows:
|
| - Architecture: arm64
| - Failure: Boot regression
| - New regression? yes
| - Reproducible? yes
| - First seen on next-20251215
| - Bad:  next-20251215 and next-20251216
| - Good: next-20251212
| - Some other attribute: foo
| - Yet another attribute: bar

... it'd be much easier for a reviewer to spot the exact warning, since
it's up-front, where they'd expect it, and exactly matching what the
kernel output, without any additional notes.

All the metadata being grouped together after that makes it easier for
someone to skip over it when they don't need it.

[...]

> > > [   14.696414] ------------[ cut here ]------------
> > > [   14.696418] WARNING: kernel/sched/core.c:10851 at sched_change_end+0x168/0x188, CPU#12: ktimers/12/117
> > > [   14.729321] Modules linked in: cppc_cpufreq(+) arm_dsu_pmu(+) fuse drm backlight
> > > [   14.736718] CPU: 12 UID: 0 PID: 117 Comm: ktimers/12 Not tainted 6.19.0-rc1-next-20251216 #1 PREEMPT_RT
> > > [   14.746190] Hardware name: WIWYNN Mt.Jade Server System B81.030Z1.0010/Mt.Jade Motherboard, BIOS 2.10.20250506-1P (SCP: 2.10.20250506) 2025/05/06
> >
> > This doesn't look like a "qemu-arm64 device" to me. Are you *sure* this
> > wasn't bare-metal on a "WIWYNN Mt.Jade Server System"?
> >
> > If not, why is QEMU passing that gunk to the guest!?
> 
> Apologies for the confusion regarding the platform identification.
> This warning was reproduced on both qemu-arm64 and Mt. Jade.
> The log is from the Mt. Jade system.

Cool; thanks for confirming!

Mark.
