Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6EA2ECD3A
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916609; cv=none; b=KmXccrkVhyG3LtP+TBewH6Wq2sgoEidIYDUsWyyLcXBuAyNVRv13K7wt4nMJlSWoNf6btIz85nAJ/Os8c9w2u+JjfmWUn1PSphwDM3ccNrdRIGDeOnwEKSIe+lGmYfV5UO9awdn+XwJ17TJ3mEt8Dte88NTjqce4iu5MFjRN+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916609; c=relaxed/simple;
	bh=UTW5mtv7Lyr9/eDXszw01FGvctILLITZPcdY0ymNFqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qg3gef9VRSzTdELnXkC5W15ID39HUmpS9IQX7Kd1f0w+tfLrkhOqynjp2SHDtShdjE++Y3omBQU9Y1PHSqYW6N7Pscxj3Eut1z+aKA1qNn8AFa8QmO/MZI3x+aFkZzg05+WPmwHUKA5Q7m+1KWaac2mQUjZDQbSSePQMgE9ltvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwuwcgaY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwuwcgaY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759916606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ru66GWqBbf75/3gN0RGafI2ekfutqLRJQg30YGzf8Nc=;
	b=TwuwcgaYUmavtLrm9POJqzNg/1NX99NKrLcaSPq1UucTSupKsQZQSlmNGRCGcFoH+CyLUU
	4M75y+qBSoqT5nwGKMu3m6O11ksbhfI2Z695GEzNsctT1ytndzoaFX+WtShkF8iPlGdCuW
	f9RPXGYKalXwXtSGIu0ocf52Lg9uL/Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-o8iwtznOM5yW5vkmNmGYhA-1; Wed, 08 Oct 2025 05:43:25 -0400
X-MC-Unique: o8iwtznOM5yW5vkmNmGYhA-1
X-Mimecast-MFC-AGG-ID: o8iwtznOM5yW5vkmNmGYhA_1759916604
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e7a2c3773so3142595e9.0
        for <sched-ext@lists.linux.dev>; Wed, 08 Oct 2025 02:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759916604; x=1760521404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ru66GWqBbf75/3gN0RGafI2ekfutqLRJQg30YGzf8Nc=;
        b=Iv+NE1ge/molYesewaeVO3OfXmJEqmqfAUDH2CkErEvdLOdLg0tzI+aTj5E7NuN2+Y
         q5rZhftBWdzjyZavz8yACmojMuC8ZyemOjwouPoNk8wigOkxHJROFUzeFLzmi9hTpa9H
         jcmAwk9QFiqFdRrSRerP1FWcCgc3u4baMx07ZAUGVKjjfYwL+j7thPVZlxUueC24fdGd
         IqBPpLAa89s0+jt0ZYF9T9mUyFGltnac6UOcaFPCC6Yi5N2Eb/sskYQ7naJgna7EemwU
         JLR7YGxxB89adAgaa4/RaZqtvni8Y6KUSBqsGWrpAd+E4p8p0YOrLlYbLId2Mexqh4ai
         mfmw==
X-Forwarded-Encrypted: i=1; AJvYcCUu/RVA/ASw/aqeNz3F0gw3z4cZtE2oXPcTdm+5pQyY2B+oLXdyblCEg2SYQudxOV11BSIA4G48Bak=@lists.linux.dev
X-Gm-Message-State: AOJu0YzW3N2oPcHG0qusGmsg7OMPnMdiignw1kJ22pko3hoSnbhGzU2y
	jukoC3SWHto0OIzsHFG0dUZqmyTRjWF8/kbstSoJQoiRs+WswGI3GolSE/O5I/l4zpoFBobvxWo
	OUlt34ybHrgr071ajwxtQh2cE+xGF0OJpfgly0yT9QgXJvRGEq1cI3MSxZQgJxw==
X-Gm-Gg: ASbGnctT2pLWjUkFzKqM1nX+5+z7hEIBY5P+V77OqF82fO2p2hS1U8Nx1hDVlSRUZrN
	DgurVyi4oDSOhq5NDHksvGlur1ETs6RzPHP9Jjig6ZjE5z5tr2erMQcGqe+vT99DX1Vx2Rmy+2V
	qOys1jhI6LkohTiM2WlYXMeZxdkc24Dha8KkbPwoOLYy37YAKBafRAte5YB1oErG8cPjiOp0cBT
	JDJyQzD4GPDJw+BKzg9ISN1/eiXBuXWQg5GUNskFXZGWA1zpqsVE38NnmUvXQ0UNNTPSZNPVcJX
	4r7Jrfpxma66kBpACLGNbYaWdTwNmtvfdDvMxMVC8IbN+kMBVkuKBJulCAVZ/bc9sVGgyY7Xmcs
	cmw==
X-Received: by 2002:a05:6000:310b:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-4266e7beaa3mr1451512f8f.19.1759916604384;
        Wed, 08 Oct 2025 02:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9rUnK+CzKM3Tge7L83s/7DmaOGIMKz5YVjnXrE4Jnj285Du60+ERNzF+vGaZ3ET1i00K20g==
X-Received: by 2002:a05:6000:310b:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-4266e7beaa3mr1451484f8f.19.1759916603909;
        Wed, 08 Oct 2025 02:43:23 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f01a0sm28969251f8f.48.2025.10.08.02.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 02:43:23 -0700 (PDT)
Date: Wed, 8 Oct 2025 11:43:21 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 10/12] sched: Add locking comments to sched_class methods
Message-ID: <aOYyOYrzoKDLCl7F@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.694841522@infradead.org>
 <aOTjSla1Yr3kz7op@jlelli-thinkpadt14gen4.remote.csb>
 <20251008070419.GR4067720@noisy.programming.kicks-ass.net>
 <2025100822-drained-foe-2426@gregkh>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2025100822-drained-foe-2426@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZL92P9uJds5Xx1VlP4zQwpI-aU6RLTjrJthmRLcRu1Q_1759916604
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 08/10/25 09:33, Greg Kroah-Hartman wrote:
> On Wed, Oct 08, 2025 at 09:04:19AM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 07, 2025 at 11:54:18AM +0200, Juri Lelli wrote:
> > 
> > > Not for this patch, but I wondered if, while we are at it, we wanted to
> > > complete documentation of these flags. My new AI friend is suggesting
> > > the following, is it very much garbage? :)
> > 
> > Heh; its not terrible. I've been playing with local LLMs, but mostly
> > I've found they struggle with getting enough context to not be utterly
> > demented. And when you up the context window, they get unusable slow :/
> > 
> > Setting up and configuring the whole pile of subtly interlocking stacks
> > of software to get anything useful out of this stuff is non-trivial (it
> > reminds me of the sendmail m4 days).
> > 
> > > ---
> > > 
> > > From: Claude <claude-sonnet-4-5@anthropic.com>
> > > Date: Mon, 7 Oct 2025 12:44:13 +0200
> > > Subject: sched: Document remaining DEQUEUE/ENQUEUE flags
> > > 
> > > Complete the flag documentation by adding descriptions for the three
> > > previously undocumented flags: DEQUEUE_SPECIAL, DEQUEUE_THROTTLE, and
> > > ENQUEUE_INITIAL.
> > > 
> > > DEQUEUE_SPECIAL is used when dequeuing tasks in special states (stopped,
> > > traced, parked, dead, or frozen) that don't use the normal wait-loop
> > > pattern and must not use delayed dequeue.
> > > 
> > > DEQUEUE_THROTTLE is used when removing tasks from the runqueue due to
> > > CFS bandwidth throttling, preventing delayed dequeue to ensure proper
> > > throttling behavior.
> > > 
> > > ENQUEUE_INITIAL is used when enqueueing newly created tasks in
> > > wake_up_new_task(), allowing the fair scheduler to give them preferential
> > > initial placement (half vslice when PLACE_DEADLINE_INITIAL is enabled).
> > > 
> > > Signed-off-by: Claude <claude-sonnet-4-5@anthropic.com>
> > > Not-so-sure-yet: Juri Lelli <juri.lelli@redhat.com>
> > 
> > Is this the generally acceptable form of attribution for these things?
> > I'm not sure what the official guidance is on using these AI tools.
> > 
> > Greg, you have any insights here?
> 
> First off, Claude can NOT sign off on anything, so that's a non-starter.
> All Red Hat people should know that :)

Yep, knew that. But I felt guilty nontheless as I didn't touch the
change at all. Current SoB was kind of a (silly) joke. :)

> Otherwise, there is a draft of something that was going to address stuff
> like this floating around by Dave Hansen, I'll go poke him to see what
> the status of that is.

I believe it was suggested something like Co-developed-by: <model> and
then Signed-off-by: <human>, but indeed curious to know how that
discussion ended.

Thanks!
Juri

