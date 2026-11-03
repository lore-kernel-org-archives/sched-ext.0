Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705392;
	b=3weNjM9X/PISJbG3yrWsOr9VlHccxGcmAF2HlEfUlUpMjB9rJYL776EVRoe6hvjYbdoI
	 1j5SiDc2TlRNn0Yu6iBcxtduEScdWkJB1/bOUjqW1WAzSGWaAoDvLZuSHPekFJMO93m4E
	 k+W8sVNI5KyQdPLkfTvkaiG1IeiDyqj2WFkmh0FPvfaRDt3K+mbP7Obihu8uSvDkP5i0S
	 ESH4cKKW485FBBpd4ZMJ4s6at+WnZpDSeIPLf7YwTTE/NGTt9tBmcWFYX8koef9zZLRPR
	 Df2hc+peYeRhqpLybTt0BnSpLu8gxr3d6JfebGTfF14qKKbo/3zqK6eQa217dHP/bQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705392;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=oqpCgjchCrdMivoMsP5bHNfJWAP3TxpXuX0zI0mcmjU=;
	b=aLwiLxHs2fJrmLEVCnvKF/6URu2qT+u6jYZctMtBYt4+lXJVA8powzdVQYyXSsQO3L3U
	 jv5rL7U6ppMqVnzTTuyHcGFnX3YPQR8HKX4KWGJtKbZiyF1QNKIvLp+6Cvk3GsAA58m9a
	 1gV4ZkXX3FJMNlQ1SE3WDafi921to/EotLI+sxpz5sgUili5poFrs+jpdbxZ9tjKTNNSS
	 7j8zlI9nGM4I0rMaBh2o85JHH/zE3cTWID3hCbHeuqAhOEaRSbVKMWiMOyzfJmqS3ju4e
	 4GR8IT5iZhZ55NiCM+AK6+oDJWvUTjKg/oM97ydXp0mrKeE53mGgqC6tP+h/g6eJOBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W9VLyRyb;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0138606C541
	for <sched-ext@lists.linux.dev>; Tue,  3 Nov 2026 11:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0138606C541
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W9VLyRyb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793705385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oqpCgjchCrdMivoMsP5bHNfJWAP3TxpXuX0zI0mcmjU=;
	b=W9VLyRybhhxlYe5/e0f1V/YI9mNU5375wRXxIjIKIVI0AFWKCePI+E03N0BPmcVnSImCGn
	WXKROXw79rvzRIQPVuD5ff8EjwUCMvRWwn1Mlj8W3fzwtKMAZK6l/kONZN0bs/TM1494Nn
	W9gPGTs1rmsRlFhgJaIolgZ3HJlf8UE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-fNF9wbnOPlix1ZfYxpbbkw-1; Tue, 03 Nov 2026 06:29:44 -0500
X-MC-Unique: fNF9wbnOPlix1ZfYxpbbkw-1
X-Mimecast-MFC-AGG-ID: fNF9wbnOPlix1ZfYxpbbkw_1793705383
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a20fd059ddso28553015e9.0
        for <sched-ext@lists.linux.dev>; Tue, 03 Nov 2026 03:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705383; x=1794310183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqpCgjchCrdMivoMsP5bHNfJWAP3TxpXuX0zI0mcmjU=;
        b=Pz2ELPrgAOYRwgEbFPcvEHeFt+yIwD+TLWdZnugP36IzzkYhHBTNszPBUQd2/r4HCp
         2n+Not2cXui140G1lQDJONLJ3eRFJYVmgfqQIAE9/Mc6k9B52urG4HsMYmT60iOSl4Yv
         5UoK7cXqWRtpDlTmDrcNdWLbyzCjDOAK/cT+BgdvixzfeczyzajGWUHdkoiw4rYAGSAn
         RSBFr6E4qT5ViAVGHgY1TsAWewQeS4Ls6U9cA2FJTZ/pAVP9lvRUerc7hM8HiNyXX1NS
         QAd3WVr38KcPMkJKzpxTgC0oOH46/vAD/HQ2Dxb2cRDE7Kfq5Pe1JcoYzz24YPe9Rg6x
         b45w==
X-Forwarded-Encrypted: i=1; AKwUvBxfWDtu9o6yK7E5lXyLjUJQwaAN7BxAh/d805ccWc7tvI0N9kolgtOboqwhkgj0/BFOdtjf7NEbXKQ=@lists.linux.dev
X-Gm-Message-State: APuU4Z+x0nxAQeKc+vZJu0tRAyFDF58mugT8enGJVNi3nNlk5xWlRovp
	/bQP1z2VmqklZx0/j5Sman367ZErOeelzEpo3u/ROWujZ5gASlxgSJOuPtnDhyQFRdA08/0AoYs
	SfiYaIibVqWjKq3FIqq7f07KopYNtKtOe4tUtZd0UOZulUEYmKJ2SOnGAdYHGmQ==
X-Gm-Gg: AYBFou0ac2laF5cSYWK/g7FQNje86PnhXBWM/WofqEMnG3pgqzp1V/HOsc9v/ddvc3S
	XjhXIGx/NU1rhZ+UEQx3FKMyBkckrYy6tRvz42xaL9po3OclHN2xaHJV9IS5ue8Hcr1cCWzB8oT
	gG9GRfJmgG+Q4L6geox8NzBj4+mYLJoD/8RJNSYar3f13ieMiNPcPIiDWV8Ht1JsP6B+t/nf97A
	TSM5bqabpq+KCibHjrn6c8I4c8nEFEokqu2Y1cVr/Poz9KCIM2EjuswpJ/X/31Ox2XKaChfXZyg
	JC7LcDcy6acsD+hudkvzxXJFib27Pg2UQwmBixJSRESrSPlH3RqpeeZUvUtZsh49rk2eA/ODhWP
	2/pbUZyPyFTJlCMJ8LDnPuE9QttGFq/4/6+Mry6jmYs17SPUQ7zArfZj7+e8Po/tWTA0Zr5K3Er
	LwyQ==
X-Received: by 2002:a05:600c:1f93:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4ac180f2fd3mr305846665e9.30.1793705383430;
        Tue, 03 Nov 2026 03:29:43 -0800 (PST)
X-Received: by 2002:a05:600c:1f93:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4ac180f2fd3mr305846255e9.30.1793705383088;
        Tue, 03 Nov 2026 03:29:43 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa38bb4asm49981275e9.6.2026.11.03.03.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:29:42 -0800 (PST)
Date: Tue, 3 Nov 2026 12:29:40 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: sched/deadline: total_bw leak when a task leaves SCHED_DEADLINE
 while not queued
Message-ID: <aunFpOODCbZ9UtiE@jlelli-thinkpadt14gen4.remote.csb>
References: <2b5fb3f22bca6aa383be8f4781923392@kernel.org>
 <auRh42kZI1xLIWNr@jlelli-thinkpadt14gen4.remote.csb>
 <1a24bcdde0bb6e4a8c839351002e841d@kernel.org>
 <auhhGAjRtuSb5JP7@jlelli-thinkpadt14gen4.remote.csb>
 <auhw3ctxwy8qeOvs@jlelli-thinkpadt14gen4.remote.csb>
 <0c5a32d85c3bf4d9fa3bacafa510b51f@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <0c5a32d85c3bf4d9fa3bacafa510b51f@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hRGKGfYIPMdhZ6GRefefrEchC0zLFgupTvprsB4zo5U_1793705383
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 02/11/26 06:34, Tejun Heo wrote:
> Hello, Juri.
> 
> On Mon, Nov 02, 2026 at 12:15:41PM +0100, Juri Lelli wrote:
> > Would you be able to re-test with the patches at
> >
> > https://github.com/jlelli/linux.git fix/dl-total-bw-leak
> 
> On 473adf013e43, all three are fixed.
> 
> Tested-by: Tejun Heo <tj@kernel.org>
> 
> > BTW, it looks like I could verify with reproducers I pushed to
> > https://github.com/jlelli/sched-deadline-tests/commits/fix/dl-total-bw-leak-reproducer
> > but I'm not sure if they are similar/equivalent to what you have at your
> > end.
> 
> They cover the same cases as mine.

Thanks for testing!

Series (including additional fixes) sent out as
20261103-b4-sched-dl-bw-fixes-v1-0-dd761fe005b4@redhat.com

Best,
Juri

