Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DC346A11
	for <sched-ext@lists.linux.dev>; Fri, 30 Jan 2026 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788369; cv=none; b=Q9OSsD+ua4uyT5HMrL2iL4Wif499KTfhKiPnm77zLWTs+X3933HnsQMP92l18saXU3wtKYFwsMF/pMf+5A4JW2EnzM0CPY7QlVDtpD4Awx9Izj/+UXnDGFwycsk7Nu7Tu9ULcEHq4DScol04LQ36JtwIO1U5cgxzQSvLbRjW6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788369; c=relaxed/simple;
	bh=cpCvyg62fVsk1ZAi89TrC2rcNynQCm+2wIz499mabhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rkM6NppHOBgxaForRrKHwPr2dKI4/c8z0TqaYNAfHCOoHfKu9QfQzl+GF1JqGHQa0xAlHuuQkQlBixBzJo8wjCvfg9V8S6l3d0qsLJlvxyiyq3ccrg0ZdiKiKK4Tm7Pr8hPd8zIyIRQ1DLfzogQ3M+CQGoXxH6OXfdYW6xkNjyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+9jjMFI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+9jjMFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769788365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2tkov5NxL/NLp4XBzFhVlIHpLIWpK/8uaTzvTGh+XA=;
	b=A+9jjMFIuyL5UMcZ5AlHs2Aj3BwHU2j5oOjvo+OL3BRJRyqXJnWFPuSwnIqnky27ZhlmOy
	PcynHbtETk22ylB3dv/Z9SWqngeD0wCfjav+sIIelz5cN4cJXBRd/ak+pOM801pjuk9G+f
	VpLXAi3NTmZoY/L95TA30oDR1fr4hEg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-E1YHl3vyOk2S2mBYY0k2kQ-1; Fri, 30 Jan 2026 10:52:43 -0500
X-MC-Unique: E1YHl3vyOk2S2mBYY0k2kQ-1
X-Mimecast-MFC-AGG-ID: E1YHl3vyOk2S2mBYY0k2kQ_1769788362
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43065ad16a8so1879764f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 30 Jan 2026 07:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788362; x=1770393162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2tkov5NxL/NLp4XBzFhVlIHpLIWpK/8uaTzvTGh+XA=;
        b=kCLuzBMTdW1dtpnHO7aT1jcP2KK6n4bk0BQCQp/wX68ZQak0hU+aysCF4B9L8LJKe5
         l63z6FThxB98x+dc0OO3uhqP2XqNxlRhZGyeEExlQuxFOvBzMJxgMJw2L/ggXuokCaOv
         5YGqJ+l/cxyv+Z56qwR6T2uW3kOWmJuI8zypeE5rSm8+oBdMrauzR1n3+S8swi14IHSi
         FR4Momg48oXg/DOSjtvQsios9X6H2wIckRpRkhFDKBk42AIltYfytFsSDgxFmBe9WbDp
         l4oHyYyDOJY6pv0ku/cOA5I1iz9T5rY7g4CsMTzRaOW0wW+Saf/eQIIQzs2rn0KDHC0A
         oE9A==
X-Forwarded-Encrypted: i=1; AJvYcCXxuEHL7AAvQ0/tkhpVEabjCBdHcy04JpHqNU1NnT5QCOtBuUUUheBmIihBuoKnEzF3PGHiyGo3TLM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7ORFgSa+lX648FSwPhmKWRF0MdZgy86iXjxPG/51v4DCKW1ZG
	Aru+1cNexwxRvnupvbT2xuKbIRgqVgYjyQqFOV/lK58VBO0z1bHQ5i9hzok5tozYhV5uKMC4xYj
	fE13Ye3y71jtmguj9TSZHvgPXotcynuc3uqUv4YHfYB1K0u2KsPPwVAh86C35GQ==
X-Gm-Gg: AZuq6aJ0ctiy1x0ksZ4TSXF2+c2Ji68Zzr8k+h0jbGb0yje/JrzCQ+Jo3llwrlBgsFY
	75frzUzmhVWv+HCix9Lq1r+WxoD8MeOSHqwfjDeIUxIDZDw7XsFQDpwykJfh4O50WR1emXvcO2c
	4hJwnu5rng7V/tJdryyXBMsN+IvLSFRihq0JHlc4DGFAfehb0keQjH2e720GYgXu6p5bxAPrQjd
	Yp94vj3PzEdPE8t0NwMZnZQOhjCfCcoDeQoPevyqJnv0oL7d/UtcHNVRNB6YE1BIf6lhFKDfI0K
	bXWOEHc6mYRts/m0v4U/tSBYMmJGiu3G4415Cxh5kJg0Ozhp2O2QU/rxZDjtPmJwDWC0fFIXfZV
	CXSOYX1lKb5W0R7lYJpX4Y909L6jw5+rpcDMaT9uF
X-Received: by 2002:a05:6000:4025:b0:435:b068:d3da with SMTP id ffacd0b85a97d-435f3a6f7bdmr6138187f8f.4.1769788362012;
        Fri, 30 Jan 2026 07:52:42 -0800 (PST)
X-Received: by 2002:a05:6000:4025:b0:435:b068:d3da with SMTP id ffacd0b85a97d-435f3a6f7bdmr6138142f8f.4.1769788361581;
        Fri, 30 Jan 2026 07:52:41 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e483asm22089774f8f.3.2026.01.30.07.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:52:41 -0800 (PST)
Date: Fri, 30 Jan 2026 16:52:38 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Righi <arighi@nvidia.com>, Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Message-ID: <aXzTxh2jgcGf3JdD@jlelli-thinkpadt14gen4.remote.csb>
References: <aXfcGynN92kyw5Co@gpd4>
 <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
 <aXjJG-72XEqvaVtL@gpd4>
 <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
 <aXkJ8_zLVSuToLxe@gpd4>
 <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
 <aXoSFOONWJmdyCQB@gpd4>
 <20260130122413.GA3306656@noisy.programming.kicks-ass.net>
 <20260130122620.GB1079264@noisy.programming.kicks-ass.net>
 <20260130124100.GC1079264@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260130124100.GC1079264@noisy.programming.kicks-ass.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -fVTT7GzSMYY4sERD_d18g26swcZeXugYK9VtAUS3zY_1769788362
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 30/01/26 13:41, Peter Zijlstra wrote:
> On Fri, Jan 30, 2026 at 01:26:20PM +0100, Peter Zijlstra wrote:
> > On Fri, Jan 30, 2026 at 01:24:13PM +0100, Peter Zijlstra wrote:
> > > On Wed, Jan 28, 2026 at 02:41:40PM +0100, Andrea Righi wrote:
> > > 
> > > > Just to make sure we're testing the same thing, I'm currently using
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git, branch
> > > > scx-dl-server.
> > > > 
> > > > I'm running this test inside virtme-ng:
> > > >   $ vng -vb --config tools/testing/selftests/sched_ext/config
> > > >   $ vng -v -- tools/testing/selftests/sched_ext/runner -t rt_stall
> > > 
> > > Apparently you also have to actually have that runner thing built from
> > > that tree.
> > > 
> > > Anyway, all I seem to be able to get (on x86) is PASS: 1 :/
> > 
> > Argh, that tree has the dodgy 'fix' in. Let me go revert that.
> 
> This seems to work?

Makes sense to me. Also handles nicely the CBS wakeup rule.

Thanks,
Juri

