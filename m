Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5356B40DFA8
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974634; cv=none; b=AgMtJIfjsdCwec2il4eX+T1lhwQJkejHUiflsaew9xDYDzzwtPqn5MNfS/m93iYjgBTGH20BxKQt+IJUtu/duWiO50RzDNE+9gt5hcrVgxO/SMSffA3fB2FiW4zDtQrkQa3hfYe+ap9dYKHNYrfWzbHvIm1xUYYsYYTB+6UpY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974634; c=relaxed/simple;
	bh=88D6n42hHBginyUlsBuZx6d74baBjPj5PUCPzUJNaFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OkxZYt5ea3DdVDjpi2I23+HAKLXWNjOQ4+gJRI2y0z8F2rRA/5I3DF0QCpNuWKbx/esksWGx8CfeKqrEfUaLQ+O3euofUJbRvXrJpdxHlgVMq8knilrGcVL4haEImJYOCJcnprQ7U29VyUFi9POCcdmPttWSRZIi5dJllxl9j5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6n04KNf; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6n04KNf"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48a548b585cso26007415e9.2
        for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776974632; x=1777579432; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcERZJmtOPbxdqesXvSzInYm/8CS6RdqVfONcfaSFZ4=;
        b=b6n04KNfHOI806X6TKAfrDTkerPO9vGyULJ0qaufZ+Zb1iCaFw+hrMMywzsJFxgx/f
         YDhB+0dO99QENrZpIwtNX2L5OU3OaNndNshYI5xu4JRNffcZbU+iWZ5x5zhHEmxgp/In
         Hfuz5N061bVS7ogu2YSh3EMBOsO2ElU7I7PqM8y51/6iOl8fsxEFZz0qhNH3gbwkkKqu
         PRunqL7ApKnHpIwfrfOWgLv3ESuhE8GNK70Ql80CfkSlishpkB4nv+bFoHQih+lHEfRn
         auqDv9cA5EwjvEDK5hzQT+H9Q3hgX7F1p7iVRPy9Q7YczL2lxiagyHnAK4hhS0ZSPXld
         4zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776974632; x=1777579432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcERZJmtOPbxdqesXvSzInYm/8CS6RdqVfONcfaSFZ4=;
        b=giXkL0aH+kYXJt5ArJsoWPzTXFfpSSR3v5P16WIunzc9DBDXqkrmbajDpnDkDoll/T
         zEuvKF+w9eGAa6d/dluV8is2ZAW1ayLyYdY42EVQMg7cf/XHHi9AIhmoT/KYwmrOSicE
         FoD3hDgbFBVOeI+LACmjsR6HpB0Fq/Vno2IOFdTRttn+KmCXVDyFzynfgWC6ueHCoNZx
         6M1YRirynsmqLhXN3CoP5rTrDtftp+ESR2k7tuf2C1Yd2DqVJvuggSkvAgNiOFM6DKCe
         abdkuamvGluZO6pL9DPiIlN9iq9rLJKd5HrK+1/+qiyd9WoVtqe1oUw1KsN1jfvkM995
         g3eA==
X-Forwarded-Encrypted: i=1; AFNElJ/actPz5YSbYLMXKLSX2nB9ep7VcTOu/vnXPz/KQHQTrrJy/cQBwTQ5CT+p0Tg6QNZ1iqOHBbL7/Hg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9/HOt7BEPqTyyybZCESTM7vsqeR+dp962DmDTWgOuJYOxnAdI
	PT8jcz4MgGs2wBnWbLiS0unCx9CQ062solN+pRD6Xbr8ZJ5NDAnWn5PsN5F/Rv9T7ivb3IH9Sd4
	Uf2SpofUGo6Y2cw==
X-Received: from wmd5.prod.google.com ([2002:a05:600c:6045:b0:488:c686:2b56])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8183:b0:488:b187:3c with SMTP id 5b1f17b1804b1-488fb765ab5mr416322805e9.14.1776974631613;
 Thu, 23 Apr 2026 13:03:51 -0700 (PDT)
Date: Thu, 23 Apr 2026 20:03:51 +0000
In-Reply-To: <aepzL1xOEqh73hHo@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <DHZPHUFXB4N3.2RY28MUEWBNYK@google.com> <aej8cmhZVhsqogr4@slm.duckdns.org>
 <DI0FTX13UW17.1IZJ9TMG9EFRA@google.com> <ad24a49fd02d7b397976975a13767bb4@kernel.org>
 <DI0RERGK9HKZ.Y3HZ3N7J3RJY@google.com> <aepzL1xOEqh73hHo@slm.duckdns.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DI0SXNWQZSTV.39HPITQGOG1YS@google.com>
Subject: Re: SCX_ENQ_IMMED potentially leaving dispatched tasks lingering on
 local DSQs
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>, <linux-kernel@vger.kernel.org>, 
	<sched-ext@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu Apr 23, 2026 at 7:29 PM UTC, Tejun Heo wrote:
> Hello,
>
> On Thu, Apr 23, 2026 at 07:12:18PM +0000, Kuba Piecuch wrote:
> ...
>> I think these two cases show that we don't necessarily have to migrate a task
>> for wakeup_preempt() to be warranted.
>
> I see.
>
>> So to cover all cases (that I'm aware of), we need four checks:
>> 
>> * wakeup_preempt() in dispatch_to_local_dsq() in the case of rq != src_rq &&
>>   src_rq == dst_rq
>> 
>> * wakeup_preempt() at the end of move_remote_task_to_local_dsq()
>> 
>> * wakeup_preempt() somewhere on the scx_dsq_move() path, but only if we're
>>   moving the task to the local DSQ of a remote CPU (?)
>> 
>> * nr_immed check before returning RETRY_TASK
>> 
>> > Adding wakeup_preempt() to local_dsq_post_enq() for every insertion would
>> > work too, but I'd rather keep it in sync with how core sched handles
>> > move_queued_task() and only add it where it's actually needed.
>> 
>> Does having four separate cases to handle, not all of which involve task
>> migration, change that calculus somewhat?
>> I believe all of these cases will be handled if we add wakeup_preempt()
>> to local_dsq_post_enq().
>
> If we call wakeup_preempt() unconditionally, we'd be calling
> wakeup_preempt_scx() on every dispatch, which isn't too appealing. We can
> add an ENQ flag to mark these sites specifically but I'm not sure whether
> that's necessarily better. The invovled code paths are inherently subtle and
> finicky, so might as well just add the calls where they're necessary. What
> do you think?

I don't like the idea of maintaining the separate checks, precisely because
of how subtle and finnicky they are. I worry that it will be difficult to keep
all cases covered as the codebase evolves.

As an optimization, we could skip wakeup_preempt() in local_dsq_post_enq() if
rq->next_class == &ext_sched_class. That should make the performance impact
negligible in the common case, WDYT?

Thanks,
Kuba

