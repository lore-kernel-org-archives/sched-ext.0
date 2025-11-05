Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F93D311C3B
	for <sched-ext@lists.linux.dev>; Wed,  5 Nov 2025 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352459; cv=none; b=aAoLbLPUdTRrkjFbTpAU6BhKuZIsd38u2sXjx9eDHMQ/jMaljLojjEN6LLhCiQMxlYMGG0XHYWjt/oJg5XHVy4jFPGNrvc1IdXF3EvuRbKCALvsgV0o6MpYjcXGwaaZdmvNzmQXF+w80mEUSK1CQUBaScts+cDo4m8Nfc0BUEeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352459; c=relaxed/simple;
	bh=nu4doHrXZq6HHEdqAu78Ax8NqoZY5xgxh+gqivufsTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fFC0aO2yZmu/QATNjo1uhtAMGJbi+/OF+PBBddSYYHMJtZDTSOI1QiWCjheCqkcPBVdaBYOjxU4U1BXmvOI7CUgDdbOCd95831vYBHlXLwoC8APvc4JxiDSe7IJnvkmrGh+NISIdul7z8pAAZUQUxAEeIMSTbIaoA9Sgj3Ku9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alEaJXtS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alEaJXtS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762352456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2VtDGz1DOqvvFYKW79um0LglA9g/B0whzTAe9JWcYQ=;
	b=alEaJXtS//QnOtIayKntPbmqo9nkuUK4SWosxQjo5v7KP+LD7CwpVxCZvlOqv2X/K9OyNh
	Yl7X+llYECvVLVoZGpd3dZwXOqsCEG0D/dSrN9ZXP7BWjldtI895fPUxKc33heG4CmmqVQ
	1dGiJf30NVTM4B4R4Gj3UBpSDkLy1sE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-dSICk3_HN8Cx89LYp66I5Q-1; Wed, 05 Nov 2025 09:20:55 -0500
X-MC-Unique: dSICk3_HN8Cx89LYp66I5Q-1
X-Mimecast-MFC-AGG-ID: dSICk3_HN8Cx89LYp66I5Q_1762352454
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so87655725e9.3
        for <sched-ext@lists.linux.dev>; Wed, 05 Nov 2025 06:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352454; x=1762957254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2VtDGz1DOqvvFYKW79um0LglA9g/B0whzTAe9JWcYQ=;
        b=pJXuERAElaE9JoKxLu3iitdJW6l50JI9IeGxienOCBCnAlgAApbImtz3NNFyEnxRfl
         qPQecnJbmg1mrChScndkQ1eI/PKQlJFw8ELWTMD9lvZByt792kUMt5/9IrdULjNcpwrz
         ven/IGzRFLaPsJzqWkKSF0bDdahMLEzJbEfrIpAOVG9f0POjBju31NdMcuErkbGRYatl
         XsgfugPBU1bhHiMy6O74waKVrlBPk4TI3iMfYjOExZRzskn9ezmEErjoFHiMjiCMe+Ac
         GbqwzoarucZqLx6HW9457cxnP4j8GXS7OeDN1lQ7NNjxr65DOGMenoDH3UpNefJcynw0
         tNOg==
X-Forwarded-Encrypted: i=1; AJvYcCXDz0P/yIAhbM6lqUyRk9qtz0T9Z8PlZF+Z7WvhMOkIs20mGO2v0c1XuPFroYpIFsFOwZHdGYT6G4Y=@lists.linux.dev
X-Gm-Message-State: AOJu0YwGX4AGm+qkhKAmsG8fbx0VFrFreG1JHcppeBRFwG5CbuqmVwQK
	lBjNKzZELcwW11VYR+qlOYqRV3VE2NcU5xBAFYaqfYCJidVjWnbsjZXzO1DtPPq6fXT+6jBZCWF
	O+L52hse/K6pXAys4f1w6IOceME5qQrJOPcELz2h1UjB7T4VYMZAqBWUF5aEtLg==
X-Gm-Gg: ASbGncsEbtsOJrpduREa1bE7uijR26chiz3cIoHcxq+iPlrkrosldtEiHxH4tAqWuA2
	klNY9pmAqq5pD/D4cZbZa7HRrletkqPXGzr5ku0F0zHEDDxTo5p5d8xu8GieM2Ywbe5uP9kRbqC
	jP1ILUOjaF1H0MPa26+IXS+OuNKYf04+MNKViVpxSwE+01pahNjmlFZ/YtkQB/sLDxRyEzVeFOm
	FcmasS2I4VdLAbvp7/kymzI/Qyz3PMZhq+TDr7cCPjSVAQWIKXFbUoXimaRyk0H1RTl7OgDwErf
	S7KFnUI6LhqnFBEX9tLT+5pO3b4tEx6zO6HpnauIQ3n7MZkLFGXA2IO2/zA6OZ6yGCTTSrbfMlB
	OfMGK7l2kyjcPvkF3BNltGQ+HMO6XHQ==
X-Received: by 2002:a05:600d:8312:b0:475:de55:9304 with SMTP id 5b1f17b1804b1-4775ce9bc9amr22409105e9.19.1762352454079;
        Wed, 05 Nov 2025 06:20:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD225S8D0eAzSRqCZNY8jiiXPUZkIB3X3AaRb7e9hIqiHytYJtBJefyIehRQDx2ycUxkcH5w==
X-Received: by 2002:a05:600d:8312:b0:475:de55:9304 with SMTP id 5b1f17b1804b1-4775ce9bc9amr22408905e9.19.1762352453617;
        Wed, 05 Nov 2025 06:20:53 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc192a96sm11270694f8f.13.2025.11.05.06.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:20:53 -0800 (PST)
Date: Wed, 5 Nov 2025 15:20:50 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v10 sched_ext/for-6.19] Add a deadline server for
 sched_ext tasks
Message-ID: <aQtdQnLxnh7z7a0w@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <aQtVe9LKuQ_W3qwY@gpd4>
 <20251105135911.GQ4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251105135911.GQ4067720@noisy.programming.kicks-ass.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3QciQCccrw4GnZG1_S8UEj_ZMQ1-mZVWJz68uKDQgm4_1762352454
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 05/11/25 14:59, Peter Zijlstra wrote:
> On Wed, Nov 05, 2025 at 02:47:39PM +0100, Andrea Righi wrote:
> > On Wed, Oct 29, 2025 at 08:08:37PM +0100, Andrea Righi wrote:
> > > sched_ext tasks can be starved by long-running RT tasks, especially since
> > > RT throttling was replaced by deadline servers to boost only SCHED_NORMAL
> > > tasks.
> > > 
> > > Several users in the community have reported issues with RT stalling
> > > sched_ext tasks. This is fairly common on distributions or environments
> > > where applications like video compositors, audio services, etc. run as RT
> > > tasks by default.
> > > 
> > > Example trace (showing a per-CPU kthread stalled due to the sway Wayland
> > > compositor running as an RT task):
> > > 
> > >  runnable task stall (kworker/0:0[106377] failed to run for 5.043s)
> > >  ...
> > >  CPU 0   : nr_run=3 flags=0xd cpu_rel=0 ops_qseq=20646200 pnt_seq=45388738
> > >            curr=sway[994] class=rt_sched_class
> > >    R kworker/0:0[106377] -5043ms
> > >        scx_state/flags=3/0x1 dsq_flags=0x0 ops_state/qseq=0/0
> > >        sticky/holding_cpu=-1/-1 dsq_id=0x8000000000000002 dsq_vtime=0 slice=20000000
> > >        cpus=01
> > > 
> > > This is often perceived as a bug in the BPF schedulers, but in reality
> > > schedulers can't do much: RT tasks run outside their control and can
> > > potentially consume 100% of the CPU bandwidth.
> > > 
> > > Fix this by adding a sched_ext deadline server, so that sched_ext tasks are
> > > also boosted and do not suffer starvation.
> > > 
> > > Two kselftests are also provided to verify the starvation fixes and
> > > bandwidth allocation is correct.
> > 
> > Peter, Juri, this has now been tested quite extensively on our side and
> > we're considering applying these patches to Tejun's sched_ext branch.
> > 
> > Do you have any objections or concerns?
> 
> Yeah, I want to finish this first:
> 
>   https://lkml.kernel.org/r/20251101000057.GA2184199@noisy.programming.kicks-ass.net
> 
> Because as is, the whole dl_server stuff isn't quite right.
> 

And I'm spending time on "[PATCH 04/11] sched/deadline: Add support to
initialize and remove dl_server bandwidth" which I am still not 100%
sure is correct (or that is correct how we handle setting runtime to 0
for fair_server today). Apologies, had some travelling and pto, but
should be able to write something more about it in the next few days.

Thanks,
Juri

