Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452240D576;
	Fri, 12 Jun 2026 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272833; cv=none; b=kmGsMIMGMvVop9o0PWD9Gvpd3AQKRnfBTeEmeGVCkMPLp5FK6yNQ0bw8JBtFXASVD965W8c8UrE6l395LdTWQvTcggxvKu0HV6jgvaAKYKH5cNZmiR6DBRZ/wudqjQN/s9SrXhQBgQGvD8MyWvC9vhNgvkjjZalIdgN5DxOCU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272833; c=relaxed/simple;
	bh=xUeJX+S/CQCpFhnAkQ+QIeB2jYkFlV5culLAyWNTQaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQIcBLMyyUepys2YazJperrS96gEhca/RA11jXPxHa2prhf4W+55kXSd9KjHotiMCmsCov9Oz49b7oBgC04/o2/6xzpGr9R+FgUafb7py5aC4Lzth82SBQz3YJA0TDL6YTJr0J/J0rLxdwR2EAT03q4WQd4jzb55yB4vUAGsmqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbEsazvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbEsazvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB531F000E9;
	Fri, 12 Jun 2026 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781272832;
	bh=PRG56YsYAD7Tgw81ozd9SUC3xvZ91zqROwDXjC7uQIQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=BbEsazvWD6naM3YRoBRUaLJ8bwXd8esVj5/qvb1OCgaOZZxAX910xfg0bYlg0r+4l
	 Qmi9Di9Vc8yi/9fA3T3FSUfMIE2ShIb1sRoviYMZqll1RKrdzIRcJfoYBC40X2LeXQ
	 ca4gWIo0JqEx4gIhl3CPi/DQtAXlZ3lSQW4lWcf+hokEAF4IekmbK7dkoIunoMNn3L
	 wXfXTL/rzQkqHjzrD/IQbouDZKRqvH84mivG0SfadiB06ugrcG3eAlr8bz2d1crNhL
	 AYlyMe+IBq/EP+dUpdR+Tkh2hQvxLUF0TaMKKgGBQaI3EsiI3lcXPExzhFNTAeY2z4
	 Okbt+C9kMTATg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F1F01CE0535; Fri, 12 Jun 2026 07:00:31 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:00:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: sched_ext/lavd hard lockup in old call_rcu_tasks_generic
 needadjust path
Message-ID: <3bbd4298-eb01-4784-bee5-caab3d3647b9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260609104733.1184001-1-mfleming@cloudflare.com>
 <2179fc11-3bd5-4d2e-9ad8-609e3356ec09@paulmck-laptop>
 <aiqxpzgl2YVVSARw@matt-Precision-5490>
 <1ad83f53-7897-40bc-a503-5a71031aa27f@paulmck-laptop>
 <aivaGbCzC4oaD05n@matt-Precision-5490>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aivaGbCzC4oaD05n@matt-Precision-5490>

On Fri, Jun 12, 2026 at 11:55:57AM +0100, Matt Fleming wrote:
> On Thu, Jun 11, 2026 at 06:45:14AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 11, 2026 at 02:02:58PM +0100, Matt Fleming wrote:
> > > On Tue, Jun 09, 2026 at 04:23:23AM -0700, Paul E. McKenney wrote:
> > > > 
> > > > Does commenting out the 'call_rcu_tasks_generic+547' printk() avoid the
> > > > issue?  If so, that printk() might be deferred or some such.
> > > > 
> > > > "But if you cannot trust printk(), what *can* you trust?"  ;-)
> > > 
> > > I tried this and it still crashes so apparently not! I'll keep digging
> > > to find the real cause (it's somewhat cumbersome to reproduce this hard
> > > lockup).
> > 
> > If this code path is nevertheless involved, one thing that might speed
> > things up would be to do bursts of call_rcu_tasks() from lots of CPUs,
> > then avoid doing any call_rcu_tasks() for some time, then do a single
> > isolated call_rcu_tasks().  Or maybe you are already doing this.
> 
> Thanks, I managed to shrink the time to reproduce the lockup and it's
> now clear that the bug is an ABBA deadlock on cbs_gbl_lock.
> 
>    CPU #1
>    ==========
>      sched_ext_free()
>        task_rq_lock()                               // acquires rq->lock
>        scx_exit_task()
>          SCX_CALL_OP_TASK(.exit_task)
>            bpf_task_storage_delete()
>              bpf_selem_unlink()
>                bpf_selem_unlink_storage()
>                  bpf_selem_free()
>                    call_rcu_tasks_trace()
>                      call_rcu_tasks_generic()
>                        raw_spin_lock(cbs_gbl_lock)  // BLOCKS: CPU #2 owns it
>    CPU #2
>    ==========
>      rcu_tasks_kthread()
>        rcu_tasks_one_gp()
>          raw_spin_lock(cbs_gbl_lock)                // acquired
>          pr_info("Starting switch ...")             // still under cbs_gbl_lock
>            console_unlock()
>              wake_up_q()
>                try_to_wake_up(repro)
>                  raw_spin_lock(rq->lock)            // BLOCKS: CPU #1 owns it
> 
> Given this, I can see why removing the single printk() didn't fix
> anything, and we can expect any code path under cbs_gbl_lock that wakes
> a task could trigger this hard lockup. Right now in 6.18 that's a few
> printk()s and a WARN_ON_ONCE().
> 
> This issue doesn't exist in v7.0-rc1 because of commit c27cea4416a3
> ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast").
> 
> Is there an easy way to defer call_rcu_tasks_generic() work so it gets
> executed without rq->lock being held? I'm assuming backporting the SRCU
> patches would be too invasive for LTS?

Huh.  Looks like I did not implement RCU Tasks Trace in terms of SRCU
any time too soon.  But there is also RCU Tasks and RCU Tasks Rude.

If we don't backport the SRCU patches, then the obvious alternative is
for call_rcu_tasks*() to defer to IRQ work when invoked with interrupts
disabled.  Or is there a better way?

							Thanx, Paul
