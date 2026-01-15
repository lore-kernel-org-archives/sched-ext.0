Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D43A0E8E
	for <sched-ext@lists.linux.dev>; Thu, 15 Jan 2026 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768485418; cv=none; b=B15Mv+agO1CPidPs2lAI7wYDE+csTY4qNRDpfRg7Da3ut/6U6F4ZKHoeBTdbnPc/aW55o1bh58Mn8moEXSMvvQixu5YEcy0cTFbgoMVpGmLyDh6UxlNRzrFwfQrIndCsVfg2DoiiQ2od78c0sZq517Vt6hwtaN+MR7p6aRjNmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768485418; c=relaxed/simple;
	bh=FnyOTPf4m8Mp4nl4SL3AW2LPS9qsrPeFd58UUFtyVMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=upIsa6HlaEewjBBphT2aaFQRrNTADcoWC4KSm91OdfjLAdIVxUtnSR/wa/whIqzfdWhOqhgRlr3AVh3LSHimVqrN5rZZkA1dZuLkBSRGqeHESZHb2NAHxuP4PqPrOBEWAInUXfBWhDQpNbrOP9D7y4qJE6PFLO7bILoOSovb+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z68PYJjA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z68PYJjA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768485415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ane5kaNtNeusJK518LJGVJnPrrb1Tm+pD0hxe99rrg=;
	b=Z68PYJjA0mAbT66b231audfFaUuMsdCDew/LC4SmO0vvJbhRIApg4b1gH3p1Yg6H93JPXZ
	RDcK8SF1fhU6EeuesCpTm4TABn0U2kSSw7qCOKXYm4P/PMAVmu3cnLUsYaeejfNUD6SwwW
	yu5YLKWxXpunmS5K2WXLZE7UbyebZ7M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-TIS65zVCN66-CTsfQi5Dbw-1; Thu, 15 Jan 2026 08:56:54 -0500
X-MC-Unique: TIS65zVCN66-CTsfQi5Dbw-1
X-Mimecast-MFC-AGG-ID: TIS65zVCN66-CTsfQi5Dbw_1768485413
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4801c632124so3634515e9.2
        for <sched-ext@lists.linux.dev>; Thu, 15 Jan 2026 05:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768485413; x=1769090213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ane5kaNtNeusJK518LJGVJnPrrb1Tm+pD0hxe99rrg=;
        b=adxV8vzsnFTZb0CguFJ5MAFU4H8C2hly+xEGH2XFS3sO1vf9lg+0R0GlZjZfx1GsDh
         YLMdadddekaoM1A6DzG8DS/BdBh84UGMSM7AhbJTJBgP5vhRIq3jWLZ/MmgS+Ess3HA/
         dtusxjG8VRF04GU42KfGWyb4rWIxFWG1vgxhMBV4v+nFWtXVtcGlivglFwLDC45cX+pV
         2MQnQxL5czT6E+BwqCSooB4GodgIz1OIZMn12uzQLv2eOZT32TftQQm2OXuVwEGbVv7z
         dW38Q9Bd0ePiKVC4zbxXxWskXUJTU3a6QnMk02/0Mlm5DdAFpurohIQ89juEeqCLpykN
         KKeA==
X-Forwarded-Encrypted: i=1; AJvYcCUqAK5zWivJlC2kkXuUjo9Hxhzua2ySii7d+9lK9eB/mmX+642OANM9A0ijeqgfygsDtKUzi7jj1O0=@lists.linux.dev
X-Gm-Message-State: AOJu0YyxeJixEdDv0vY9sqQH4it94nyOUDyLCN6M8yY9eK5stUW4bi+Q
	0w2qG4H/MN5e38g2CthbUiermQGYui6Xf3qNoSzSoOYRoLqA5/1y9F347PFytMg8y8nJbuG1W2+
	iUnz8MY+n0euxDRGRDEB362Dbl6RGoUqNFKt4JdQbb5oIKPc/V1OOsZMT/7qwDQ==
X-Gm-Gg: AY/fxX779C760uEg8p9UYUrDS5wETBnQnYI05xCam3J7QgtKJPZcHI6w/drktayX1jc
	C+BoAlaXu11GmaSQb1roi1vpDTHbhqGkLttNN+HScjTQ02CFrtI71yHZTC+Dbofpz0iZeG/zJPv
	4C+6T5pwjM3Wl424oT0NPBCQOMgekUiBEv1ZWWVouiqqLlHkhx96tN53gAflnUVZTHXE+FBz43i
	gmww6sO1ec3TdGPCx3nNHOakZwbqJZvidMvffyuWkSJploRABmVVQapjdYnZUs6l6Fvy0SZzPbt
	vBqI/+2MP5+fxHIbneIHCVIxrHhWuLUnZ2qKrn3SNhGAhUeTnNggWxFqaYYq0GDhSkAnYvY3VZS
	Srqk9yltWQBxT8XhvBX/0PzcB3aw+NEb5JiKFM8vP
X-Received: by 2002:a05:600c:5287:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-47ee32e07c3mr82027575e9.6.1768485413212;
        Thu, 15 Jan 2026 05:56:53 -0800 (PST)
X-Received: by 2002:a05:600c:5287:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-47ee32e07c3mr82027055e9.6.1768485412762;
        Thu, 15 Jan 2026 05:56:52 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6535ddsm6044623f8f.15.2026.01.15.05.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 05:56:52 -0800 (PST)
Date: Thu, 15 Jan 2026 14:56:49 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Christian Loehle <christian.loehle@arm.com>,
	luca.abeni@santannapisa.it
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <aWjyIROG6AqXtm1G@jlelli-thinkpadt14gen4.remote.csb>
References: <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <20260113114718.GA831050@noisy.programming.kicks-ass.net>
 <f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>
 <20260114102336.GZ830755@noisy.programming.kicks-ass.net>
 <20260114130528.GB831285@noisy.programming.kicks-ass.net>
 <aWemQDHyF2FpNU2P@jlelli-thinkpadt14gen4.remote.csb>
 <20260115082431.GE830755@noisy.programming.kicks-ass.net>
 <20260115090557.GC831285@noisy.programming.kicks-ass.net>
 <21da68c5-e6ec-4ffd-81eb-e1fda13dd7af@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <21da68c5-e6ec-4ffd-81eb-e1fda13dd7af@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TvcMg8y7LQdAjQhIwgS-MMrGCfIlEBOq6s0iO4GLPKI_1768485413
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 15/01/26 14:13, Pierre Gondois wrote:
> Hello Peter,
> 
> On 1/15/26 10:05, Peter Zijlstra wrote:
> > On Thu, Jan 15, 2026 at 09:24:31AM +0100, Peter Zijlstra wrote:
> > > On Wed, Jan 14, 2026 at 03:20:48PM +0100, Juri Lelli wrote:
> > > 
> > > > > --- a/kernel/sched/syscalls.c
> > > > > +++ b/kernel/sched/syscalls.c
> > > > > @@ -639,7 +639,7 @@ int __sched_setscheduler(struct task_str
> > > > >   		 * itself.
> > > > >   		 */
> > > > >   		newprio = rt_effective_prio(p, newprio);
> > > > > -		if (newprio == oldprio)
> > > > > +		if (newprio == oldprio && !dl_prio(newprio))
> > > > >   			queue_flags &= ~DEQUEUE_MOVE;
> > > > >   	}
> > > > We have been using (improperly?) ENQUEUE_SAVE also to know when a new
> > > > entity gets setscheduled to DEADLINE (or its parameters are changed) and
> > > > it looks like this keeps that happening with DEQUEUE_MOVE. So, from a
> > > > quick first look, it does sound good to me.
> > > If this is strictly about tasks coming into SCHED_DEADLINE there are a
> > > number of alternative options:
> > > 
> > >   - there are the sched_class::switch{ing,ed}_to() callbacks;
> > >   - there is (the fairly recent) ENQUEUE_CLASS.
> > > 
> > > Anyway, let me break up this one patch into individual bits and write
> > > changelogs. I'll stick them in queue/sched/urgent for now; hopefully
> > > Pierre can given them a spin and report back if it all sorts his
> > > problem).
> > Now live at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/urgent
> > 
> > Please test.
> I don't see the balance_callback or the double clock update warnings
> anymore.

FWIW (as I wasn't seeing the reported issue) I had a look as well and
tested locally. Patches look good and nothing to report on the test
side.

Thanks!
Juri

