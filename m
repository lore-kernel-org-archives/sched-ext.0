Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604849;
	b=HywIKjnzgwScrNICNP+wtELcL9gyRqn7kWtnJp8Jry4KJL8IHl9pqIJ+/vljW5ZFQkgB
	 /QmTwYeqGN3Ert8N4bULonwpfCbH4gfohLB8VwdRU7pl+NbRZD/nq6VuoRhT+T5Hi+91W
	 Df6zkh/GrR9GeRVUiU5jyNYBrIPiK8V4ogVQYGrpqJ7MmkqlFOFZa7fPrcewvsUFJLcVE
	 ekuv7BMMx61A4Q8w5bq9LnketqclMmtpWPcby6ufp1L+hyu6zOwknW8CZ6JWkvSLIh+pF
	 cVIwRgQHdHqiFO89uFC7K0UYiOdrP1xC3KHbTPW4IOTl8WPosuIlJDoiu6oMPu/LrJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Dhj/6IC/S9UakA2XJuOoikLp4Ldc+YWWX4fLcWh8PR0=;
	b=3gbPJNEXoVe72HRV6Dq2Fne6hqMRJPrp+r8G56K5AVLcM2WIZ147Gxr56xNY1YOZBDcP
	 haZQZNOrl7beT8sY2e4lFscW9Do3ZQzFfC7LXkhtRgZD/tb9ddEVtXDjCYbE24tJ/51Nk
	 FO6+zGb6PfKP2DKWLUk5NTheg1HJI6sOeqiURAI3oHIK3RL5bCE9ZDADmnWDMf/3XEjT4
	 gjBdbj0+lCpIBmPjV9cfcQJfFvd6uTqKyV4P2qHVYJwLYXAIE8ydteV8S2ZAjJvqWoOYW
	 p65bNyC/bj1oA4sfdm4NUhqQ98QzQB5ExrYO0+18Q7KqvxIfYUZYHsuqu9jM/e2PUZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cGgmY5e4;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF062606A32E
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 11:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF062606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cGgmY5e4
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49953abe51fso40108975e9.1
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 03:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795604847; x=1796209647; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dhj/6IC/S9UakA2XJuOoikLp4Ldc+YWWX4fLcWh8PR0=;
        b=cGgmY5e4ztw9fxLzy2h6pXowy6ZVO2gOGxu4eE8R9hpseIMS+BStQTnjXP5QSSRY1p
         HyRcyWkE38dk5EG9HVAGoMgEDliaTqOqKFbN1y/symJJzee/qrjbBpZyDYbI5X8VlKu9
         ReLfgOzqYrWyETjMo8ONZma28ZnKLSu558MDAP7Bb2Po0mzjFyirN5hxgmFBE1+jK2Ka
         CtqMrNWFwHju3BgIDIoB+nlUkzWz7OIdS1HWWXJ50X3OHjw1evmoFfrzQKOlQdLDaElt
         jK0lSD/UaXcmXth0iPT0PRdI8CqxR0yuQwHj7mrg9dVzCspe68qe7gI0AmGBzG2GMjzo
         r49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604847; x=1796209647;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dhj/6IC/S9UakA2XJuOoikLp4Ldc+YWWX4fLcWh8PR0=;
        b=Q4qM1CQphXxcRzwkbqnHiVrJZUuE7DNPMJgCD72TGhNazOZneQJDqJcbyNo27iHnuy
         1KLoSftursXm8ugBt6wXjStP6q5vNE4a1/DyT6K32iSl4MFmy+qJ9lkQC2pQ7lCHBVmR
         hx6o3xnCvUmXoQRLlAGgFUEPoTDjtr/d3VXyWbHFflYT+u1Ix07ODbAEFYhOVBeEPqaT
         Xroc8O2fi5JH58gVpjVZ729mcx3EkKABL2MwqU0c5BxZD8pUEi2lFPqhOsrUt8IQphWG
         IeatCWFtg552qt7WazOfJ3K4R2GVbhrqTvApQ9KEuDpmzo9Kn8Scjo4y8kIiEbcZWi2d
         o64A==
X-Forwarded-Encrypted: i=1; AL+hErH5FFYmz35xcTNKdTFEGvepKtmwNGGzTlJ+1DXxi8N5o8qmc3JE6sLc4WFVo0LmNMoZdxeLhu2lkaw=@lists.linux.dev
X-Gm-Message-State: APuU4Z8A4GEjNyvLz+rBCtYrfytBpk5zPKsqvdD/TrV0Q2FHnA2EaSrx
	FNDGCfl7JhjZ9qsVwEl0gVy6zdY4ff17fNlSrqr4W2bSo2EI1pPMo2RvYa6SvmeYYsMcf8a1gpO
	9k3rGh4bzM6bj/g==
X-Received: from wmjy5.prod.google.com ([2002:a7b:cd85:0:b0:4bb:6476:9406])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e8e:b0:4ba:59fa:510e with SMTP id 5b1f17b1804b1-4bb8893014dmr358786765e9.23.1795604846985;
 Wed, 25 Nov 2026 03:07:26 -0800 (PST)
Date: Wed, 25 Nov 2026 11:07:26 +0000
In-Reply-To: <d0843faaef949300df9b51a09e36a696@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123170846.3165648-1-jpiecuch@google.com> <20261123170846.3165648-2-jpiecuch@google.com>
 <d0843faaef949300df9b51a09e36a696@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125110637.211132-1-jpiecuch@google.com>
Subject: Re: [PATCH 1/3] sched_ext: Fix ops_state and ops.dequeue() locking
 races in dispatch
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, fangqiurong <fangqiurong@kylinos.cn>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

On Wed, 25 Nov 2026 00:18, Tejun Heo wrote:
> On Mon, Nov 23, 2026 at 05:10:32PM +0000, Kuba Piecuch wrote:
>> @@ -1871,8 +1884,10 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
>>
>>  		if (unlikely(dsq->id == SCX_DSQ_INVALID)) {
>>  			scx_error(sch, "attempting to dispatch to a destroyed dsq");
>> -			/* fall back to the global dsq */
>>  			raw_spin_unlock(&dsq->lock);
>> +			if (rq != task_rq(p))
>> +				return false;
>> +			/* fall back to the global dsq */
>>  			dsq = find_global_dsq(sch, task_cpu(p));
>>  			raw_spin_lock(&dsq->lock);
>
> I don't think the task needs to go to the global DSQ here. The scheduler
> is being ejected at this point and bypass is going to cycle all its
> runnable tasks. Maybe we can just let go of the task and return, for both
> the local and remote cases, and let the abort path recover it? What the
> BPF scheduler sees after scx_error() doesn't matter as long as the
> scheduler can be ejected and all the tasks are recovered. That'd get rid
> of the bool return and the retry in finish_dispatch().

Good point. Every caller that can pass a user DSQ here (direct_dispatch(),
finish_dispatch(), and move_task_between_dsqs()) has @p on its rq's
runnable_list and can't run on an rq that scx_bypass() has already walked,
so clearing ops_state (when SCX_ENQ_CLEAR_OPSS is set) and returning after
scx_error() leaves @p to be recovered by bypass just like
SCX_EXIT_ERROR_REENQ. Will change this in v2.

> Also, can you please factor out release_dispatching_and_lock_task_rq()
> from dispatch_to_local_dsq() in a separate prep patch?

Sure, will split that out into a prep patch in v2.

Thanks!
