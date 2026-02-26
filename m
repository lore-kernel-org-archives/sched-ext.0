Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77071332ED0
	for <sched-ext@lists.linux.dev>; Thu, 26 Feb 2026 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131158; cv=none; b=qdzX4BgkMjPnjwOJmLSBPk2EeQ2t3ex3o7OBspu97tyexqFZQTbTQPRn2hNc4EdILJRGwrL6Ckv68chDT6goyDqoIiRxwKkJjyyS9FFiHVesxG+QGJpy7m2MaXwEfXZJRL4ITsfPfDKlWx0SubnLOF3aDxLOv5+C0JJ/GaJ+g8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131158; c=relaxed/simple;
	bh=WXLJBRwPRH5Tybm6J8jtA40mG8q5sKCMY4FYsNnsoig=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Orh6YSVL+J4sPMIkazUrX051kIrKuD0UXB7jNSjs6QHPMQ0EGI6crtGSs5cv+JscRjvaBKkFdBxZc1JQ0jrqxgI5r8hdrR/6SGiXQ5zBDDFLMgn+nUis3/rAlmZq6itg2LcBZPAdI4PsJqsu7Vd4TMlQ3ArbWrf3Wgcwh4dn1E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsKt6O16; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsKt6O16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772131153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXLJBRwPRH5Tybm6J8jtA40mG8q5sKCMY4FYsNnsoig=;
	b=FsKt6O16OT8jZuzBFr5CfwbyJaEDcAIq5vUiNoJqcOFe+yMO2fEqPseAT3JFCI5k1OQ85e
	231Awx4v9d0NCuFNLVGhN+Z6xxDTBW7HaNv5xxU5M18x81vzl/ciR3SfNU5XiEftWIVE+4
	T8DssHbvIqemZ8cBHJ7iRlegC5zwlu4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-VRkrQxRMO_C7j_O_6zPv8g-1; Thu, 26 Feb 2026 13:39:12 -0500
X-MC-Unique: VRkrQxRMO_C7j_O_6zPv8g-1
X-Mimecast-MFC-AGG-ID: VRkrQxRMO_C7j_O_6zPv8g_1772131151
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836cf00787so23466585e9.1
        for <sched-ext@lists.linux.dev>; Thu, 26 Feb 2026 10:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772131151; x=1772735951;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXLJBRwPRH5Tybm6J8jtA40mG8q5sKCMY4FYsNnsoig=;
        b=J0lNDneVCWPKHxZHC9e7ZDpDjAs+waesE3nGZql3juQSpHLSvPUnwe4nItYLpPE/A5
         t/qs/HAEmDRMBEXDLWM1RMAUlraOYfaFgbIamchWge9loyqxvFopYgK8IJUTqJq3BurF
         pJrXpVcM1tboItdOjoOpew7nuIOzKnJY5FVu99wbNibyFkFUWhd4Ielcrk2v1DVPtBhR
         F53ScTk8Lpx9TzYdYs11EKjo6azkqpdCfiE54gLe0c3KtYz8kVlAucNPDpHbNOe3xtMV
         yfxrYucCH6YEgVQzecCISLBZ5eqXW3uBA0sg5qJyyN/2Odn2GqeotNxjB5iJvLyEBiRy
         e8pw==
X-Forwarded-Encrypted: i=1; AJvYcCWUKoTSkBzd1tXqDcWxJp5qZB7jIBYopXDIkwUxOsi9nNPDDvqP2A3VRUsrF7lBgz9Z+X+JsiZMrtE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxRSCZMvZkIsE6o/p5c/JpfuovWvA5NGxqHiSL5q5bxhOMdPdNH
	Q/v5wAs1lglpyWfdwRDKQ8wTxbmXBS2PL5kkrLr82JLUzN+tBt01f2v2+b7kWu8YbqCdfsnh/BN
	0sQidmHuVYN7ElRigRekLE3r/3tsh7fT86fVBvf7FSWjwKDKr1VSoX9U7EN2XKA==
X-Gm-Gg: ATEYQzx1iFCLUWzb1bGJkHTXiPMn9Yv5UjZq9+PRQWZAD3tkZ7Dn8xsfO5ydoDXoTCe
	CHuy4MmFDtF7kPUZav/z3sqxHd/jJ9HCmqOO/wJH1RCvT9RSDTldn0doe6kb2inI/Buueb8Yd4p
	UZXEwvvoulx1mIxDJpDIqTbgBaYxvykvcEQhakcfQkoMkJhl2hCv/hsHUefBZdzPJDOJZiGCMTd
	LxZzrFENZ6IkQaaEfeih2mHPHJkPVWgacyOq0d+NlU0Co2I+CALfUuDjQTIK6K8UpaG6iAgZXfd
	cXPGiFDqHdgLxZSzcjNoOmLrAbYm0uj3nNXBGxsei3h60CqdKLgYXZqlBM1I/3qZR9i0pzzUk7Z
	0iHuN8fV6rm0cwJXx7w==
X-Received: by 2002:a05:600c:3544:b0:47a:8383:f2b2 with SMTP id 5b1f17b1804b1-483c33f3357mr65519295e9.17.1772131150826;
        Thu, 26 Feb 2026 10:39:10 -0800 (PST)
X-Received: by 2002:a05:600c:3544:b0:47a:8383:f2b2 with SMTP id 5b1f17b1804b1-483c33f3357mr65518855e9.17.1772131150355;
        Thu, 26 Feb 2026 10:39:10 -0800 (PST)
Received: from [127.0.0.1] ([195.174.33.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd702e7bsm181703545e9.5.2026.02.26.10.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:39:10 -0800 (PST)
Date: Thu, 26 Feb 2026 18:39:07 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Message-ID: <b45f7954-12d1-428f-9702-059c10ddcbea@redhat.com>
In-Reply-To: <aaCI08IDGXTLvwT8@slm.duckdns.org>
References: <20260225095122.80683-1-gmonaco@redhat.com> <20260225095122.80683-15-gmonaco@redhat.com> <aZ8snSHWw-U0lVz2@slm.duckdns.org> <8fbc3ced19fb0c2a2171708073fa51ae308755b5.camel@redhat.com> <aaBlJT9Mac9KQpKL@slm.duckdns.org> <f49a6db6f0070350cb2d2b023b5733a3646996f2.camel@redhat.com> <aaBrMr5O4455oU31@slm.duckdns.org> <deb203ab-7564-4bef-b4bf-053c6ec08f27@redhat.com> <aaCI08IDGXTLvwT8@slm.duckdns.org>
Subject: Re: [PATCH v6 14/16] sched_ext: Export task_is_scx_enabled() for
 verification
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Correlation-ID: <b45f7954-12d1-428f-9702-059c10ddcbea@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gn9qLq1PZBVq83c3phioUSnPjWLdU7Z04nardOO5WI0_1772131151
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-02-26T17:54:35Z Tejun Heo <tj@kernel.org>:
> So, I don't know how rv works (searched a bit just now) but from kernel's
> POV, it seems to look mostly like an additional tracing framework, and
> testing p->sched_class against exported pointer value seems like a good fit
> for the use case, no? It's not like task_on_scx() or state testing is going
> to give you a "better" result anyway and it's actually rather confusing to
> use them outside scheduler proper as these are expected to be used while the
> task's rq lock is held. I don't think rv wants to (or even can) synchronize
> against scheduler internals. Using external observability mechanism seems
> like the better fit here.

Yeah you got a gist of it, essentially RV would be running from the tracepoint contexts, so in this specific scenario it would be synchronised with the scheduler.

Grabbing a pointer via kallsyms and comparing that will do exactly the same job, just a bit more "unofficially".

I can do that if you think such an "official" function won't really be useful. Indeed if that function wouldn't make sense without the rq lock, tracepoints are probably the only valid use case..

Thanks,
Gabriele

