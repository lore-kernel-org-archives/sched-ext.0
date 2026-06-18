Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B42EFD95;
	Thu, 18 Jun 2026 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798152; cv=none; b=DiLhaCX/C2Fqm7Rp3OhqmYiZc2+NoWsED3DkGgXwAWXooOa9xHb8GoWtXShI8z9RakCujIBGGh7aTl6LKrX4BOJsj8KapYPColjbtTxVBjDlecbLGhlFLWZS6NRGP4Wa81iNo5RObj/LHxfp1mYGxps7k8xOFbEx4MmZldqJA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798152; c=relaxed/simple;
	bh=r7gvIgG2Wdh0b/AP9uLqvFIL7+ZYHaGv8j2GMvtG7MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iE3QnodoK+/5wwDx3fI7xr3m99/J2uEKO2fMFYgKyteAAV6OOxnVxV25hNJotNLN5FCXRB5zN0jtVNUr0x1txXZmPjgExhhvQjnz9vW1pVlndUKydDG/Xq8cnPdjZG1JuL0j0ON1uZMUyi7hPksKbP2YSKglw8Nhs7Y/d2F5tBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0SRswW3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0SRswW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41461F000E9;
	Thu, 18 Jun 2026 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781798151;
	bh=Kj7+KL+PSumQZfnfcRRsBskhS6ytmgonRpTvAHPL8Qc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=H0SRswW3hXDY/wvKnVHjJOpKTCcBqODOHPu9zJVNweNB7ngkZIi7gN83o27onYfRZ
	 wb/pZ0wNJcn6chha1413Bob1w9UNOgTB0z4xzAGTBxL9o6eOTgEQv7rbr7rlfqTxZZ
	 MkYjanilmzHZ9KCes+iJsYkrpxc8TSfetzOyUa3zvME+hsL+wJxK3t6jIOIdM4MQ/4
	 qDXgvCfSCRiVHeHTIYlpF/DYu78Waoz2aImGuYGoOKpwFMDMSbRXO0IYTas6ubcQWs
	 d7WNGn3Sek0pt1J8sKJk9Znb0HNaLjtY9P7T8tzhF1EuFd+kGOg4q1375zzZqzQ8U1
	 t2cpvTgNhNIQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B84AACE0C39; Thu, 18 Jun 2026 08:55:50 -0700 (PDT)
Date: Thu, 18 Jun 2026 08:55:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: sched_ext/lavd hard lockup in old call_rcu_tasks_generic
 needadjust path
Message-ID: <120adbd6-08f6-4eec-83cd-523e25489707@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260609104733.1184001-1-mfleming@cloudflare.com>
 <2179fc11-3bd5-4d2e-9ad8-609e3356ec09@paulmck-laptop>
 <aiqxpzgl2YVVSARw@matt-Precision-5490>
 <1ad83f53-7897-40bc-a503-5a71031aa27f@paulmck-laptop>
 <aivaGbCzC4oaD05n@matt-Precision-5490>
 <3bbd4298-eb01-4784-bee5-caab3d3647b9@paulmck-laptop>
 <ajErr_GEejCD7n47@matt-Precision-5490>
 <35337ded-add4-4689-8f61-73f583a69b36@paulmck-laptop>
 <ajOWZ3JvlmihMNAH@matt-Precision-5490>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajOWZ3JvlmihMNAH@matt-Precision-5490>

On Thu, Jun 18, 2026 at 07:56:05AM +0100, Matt Fleming wrote:
> On Tue, Jun 16, 2026 at 08:24:55PM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 16, 2026 at 11:56:19AM +0100, Matt Fleming wrote:
> > > 
> > > What about something like this?
> > 
> > Not bad, actually.
> > 
> > But we are going to have to similarly bypass call_rcu_tasks_generic()
> > soon enough, though only when interrupts are disabled at the time
> > of the call.  One complication is that it would need to interact
> > with rcu_barrier_tasks_generic(), which would need to remove any
> > pending callbacks from bypassed call_rcu_tasks_generic() invocations,
> > as in llist_del_all() and enqueue the callbacks.  A well-placed
> > raw_spin_trylock_rcu_node(rtpcp) should suffice for the serialization.
> > The trick is that rcu_barrier_tasks_generic() is not obligated to
> > wait on later calls to call_rcu_tasks_generic().
> > 
> > Is this something that you would be interested in digging into?
> 
> Sure, I'll take a look.

If you have questions or suggestions for the surrounding code, you know
where to find me!  ;-)

							Thanx, Paul
