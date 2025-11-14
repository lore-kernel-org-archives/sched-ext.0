Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4778C2222B2;
	Fri, 14 Nov 2025 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763083503; cv=none; b=dntXF/6I6/VJBmL54l81XUiOomyNATyAJgUgfY0ZMPKQGqI7SutBwtRgvn8joEaGrm8wBovij7ebbIF4XNp175zSWrOx3y9TxTFtVupwShgpnCvBfPGdeSyKKSUuwdnuisW/++JMERhO+dZ8O39hCUYfOlesf4eXI0kqEkBXgFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763083503; c=relaxed/simple;
	bh=rXdovdy8AmEKdm1Iem17KqyJwPGKWYIGCXm/1hGqe0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ2U8F3bA05QCYV7x8f34u5Ad3C0KRB5YDryuD/9jJ9KyP1eqannW7NSRi+3uuHhzQgmVCz9f8IbSAK1FLkEh7oxx9iXGHBajefzQ8FU26eIttNw8pqeZU/ufs3Crtn64wT0iKJTLeKU856ASdhlpOx25k/cECyuTWfrAdaeqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwGUCxJi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwGUCxJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF61CC113D0;
	Fri, 14 Nov 2025 01:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763083502;
	bh=rXdovdy8AmEKdm1Iem17KqyJwPGKWYIGCXm/1hGqe0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwGUCxJiICQIxs+eSIRce7Sa8AZDC0Ah9Qw9cFkBCjPXH/AWLdOjK9t+t+FtI99Ak
	 Bzxn3a2G/hXkNxLJIrMK++5QW3uYwaE390EEc1Amgj6kPXuVO/Ax3/fo/CgcI+RkTk
	 2+x+tH3WlgQSsxHPvW+g4unrZ0JU09KcUo8/BRADFZfjFI0Um00yEi0b6j0rzRIZvk
	 Y0wjl92IeehSduoox+MClm96Mnjyl3C/8SuWauoEWwTpP/IcVoN2eI29KzdZtQdvQH
	 HxTfflPh9yFOLZWnVBt7NbURqTxTy6zGyiRXkEnETUnIoZwVaFuMJMInjMtv1/RRKG
	 tn0H7Ek6zOMCw==
Date: Thu, 13 Nov 2025 15:25:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH 09/13] sched_ext: Hook up hardlockup detector
Message-ID: <aRaE7ckOxUtDCcqU@slm.duckdns.org>
References: <20251111191816.862797-1-tj@kernel.org>
 <20251111191816.862797-10-tj@kernel.org>
 <CAD=FV=Ujf7PJxBANGv4e6oVa9YMS4sNLvxp=u+=5n5aaAAn9Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Ujf7PJxBANGv4e6oVa9YMS4sNLvxp=u+=5n5aaAAn9Cw@mail.gmail.com>

Hello,

On Thu, Nov 13, 2025 at 02:33:08PM -0800, Doug Anderson wrote:
> > +bool scx_hardlockup(void)
> 
> It's really not obvious what the return value for this function means
> and it's not documented in the kernel doc. Could you put it there?
...
> handle_lockup() and its return values also don't appear to be
> documented and it's not super obvious (since it goes on to propogate
> to scx_verror()).
> 
> I spent 5 minutes looking, and my best guess for handle_lockup() behavior:

Will add documentation.

> If it does nothing, it doesn't print anything and returns false. Then
> we'll continue to do a hard lockup.
>
> If it has previously kicked scx, it prints the passed message and
> returns false. Then we'll continue to do a hard lockup. Why does it
> need to print a message in this case, though, since we'll print the
> message once we return "false"?

If abort was already initiated, it does nothing. No message printed. The
message passed into handle_lockup() is for reporting on sched_ext side.

> If it disables scx it doesn't print anything and returns true. Then
> we'll print a message about scx getting disabled and skip the hard
> lockup actions.

If it iniates disabling, it prints out that sched_ext is being disabled.

> Also note that the CPU number you print here is a bit confusing. With
> the buddy lockup detector the CPU that's locked and the CPU that's
> running are different. Shouldn't you pass the locked CPU into this
> function if you need to include it in your printouts?

Good point. Will update.

> > +       printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
> > +                       smp_processor_id());
> 
> Should the above be "disabled" instead of "disabling"? Mostly because
> (I think) it already happened. Otherwise as a reader of the code I'm
> looking to see where the disable happens in the future and I don't see
> it.

It initiates disabling but disabling is asynchronous. The first step of
disabling - aborting in-flight operations and falling back to safe in-kernel
scheduling is done synchronously by scx_claim_exit(), so there's an
immediate effect; however, there's whole lot more that happens
asynchronously in scx_disable_workfn() afterwards.

> > @@ -196,6 +196,15 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
> >  #ifdef CONFIG_SYSFS
> >                 ++hardlockup_count;
> >  #endif
> > +               /*
> > +                * A poorly behaving BPF scheduler can trigger hard lockup by
> > +                * e.g. putting numerous affinitized tasks in a single queue and
> > +                * directing all CPUs at it. The following call can return true
> > +                * only once when sched_ext is enabled and will immediately
> > +                * abort the BPF scheduler and print out a warning message.
> > +                */
> > +               if (scx_hardlockup())
> > +                       return;
> 
> Should your test be before the "++hardlockup_count". If you return
> early it doesn't seem like you should increment the count?

I don't know. It is still a hardlockup event. We just first try to abort
sched_ext as that has a reasonable chance to resolve the condition, and, if
that succeeds, there will be messages indicating hardlockup occurred and
sched_ext was disabled. Wouldn't it be confusing if the reported hardlockup
count doesn't reflect that?

Thanks.

-- 
tejun
