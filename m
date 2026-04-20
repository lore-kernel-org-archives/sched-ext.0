Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B9243376
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698523; cv=none; b=FN9UOj+QMKmtepr03tD4jrpTs9qQW2ew2VoLXugo5x85gw2u30T5Vd1MRp/nQTUMmFr9QERiPQGSr1PnBDVxdj3/pO8awD+mjwgn9jZTrjrIlX1dWGpwycgLuWtPcr15OTDp2Uv/FrL23bmv46DrB0ayIcuuNCuP86+UIRAHDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698523; c=relaxed/simple;
	bh=4FBzaTTpqnBIU5pKUXm8hcufAfCWMbiCv8ZWdgT+yl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I3niJDggsb6dd64UGfk/h+Cb7FOwG6x4IkTEpCrDaSJICdEGA0/MYjnD4ZoEg126aiVr2g4KMMzrWxa7xN0JjNmVL1LMIL6ggWA8RxKcwzsLpT33Bx8zXbLuehait9A3Sk+FQGQO2fkPU4lgNgyYoGxjDFCDkT33bmMMDmBXl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kQ7/OZs6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kQ7/OZs6"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488c2a4e257so24579725e9.3
        for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 08:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776698520; x=1777303320; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwGV37PmpmtYXDrq8CTJScazFpYTg5Jf3sXefLNUVm8=;
        b=kQ7/OZs6BejKJkgukTVzZrjm/ISRDCbmNZMRc+QzKVs8m0ghOKSLzmuegb7wonZFBH
         uM8Vo+xuDr3A2gqhlE1DZOqPqKX+P9ofXcZrYM/1zsP0RgVutiDLpMUpeZ392m3qfldS
         cnn6OVOjkfHB66Mph/8WObw1yMiRX7piSIcJpLSKNnrUmKLCO5xK539wVkv0mkiNI7z8
         O1T179jHuCe+tivu0faqAUDVCcXkAmeYDQBzIkNqeV2Y8ntV3iE5qcpkk0LiBS1DOxfA
         bWoWYtYDgYtnHDNvQWYlplWrfV8k4F3zhC1j0w7JXkKXXKgCzCgv+qZmAC2hlZHMWCr1
         R2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776698520; x=1777303320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwGV37PmpmtYXDrq8CTJScazFpYTg5Jf3sXefLNUVm8=;
        b=iP4UiHuFeQw6GsXGuzDIVOnEVXvtdOA1qCU0GyhjL/HHbv1x3Nm/EqLPHrdgDCloPE
         Y2kzlZSa4VbVZwK9CqHvs0oEA+nf+GQKUzxGjFx6M1lsauYM/NqExZ8aoP1PtEsnGwNa
         zQoMjiEol0tmM71pjB6PNW3bwOFnAyKXy+0isRsdtFdP+CwYUm0aQoJKmsvlHUr6Qk81
         ZoUgxDX4rdnzX0yVGT69HLgKP9Ybhxxu5aBeMkurSiANSj7s/ZPvaq1L7reI49NLZPTz
         ew1FxGZXu3I4DWfo1KfTsk5f9dRlBSl24wLlXeFETRRxYva/sNzdzXygMBCnjjbzeCgP
         QCvg==
X-Forwarded-Encrypted: i=1; AFNElJ+uRJSevCxWhv7VtEDoJiGiCbSBv8aOeO8EOk72R5qXHW3mwP3QOt9QBR6SGeWPS3r7o2haQ3hBloo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4puwBEPxVaSsBJN3eOX8i3d5FwCHX2m4US0c2Lw01b3ip7F1v
	hi2QiqPFlmjrvNNi4HBCbw1PJ67ugj06lOaIiPkywwtd+qnhj0BXNJTGN6Emlc6sS5wVCozAKtc
	+YJ6rsfqquuXKUQ==
X-Received: from wmjl23.prod.google.com ([2002:a7b:c357:0:b0:485:f1d7:164d])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8586:b0:489:e49:f766 with SMTP id 5b1f17b1804b1-4890e49f7d8mr63279735e9.17.1776698520338;
 Mon, 20 Apr 2026 08:22:00 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:21:59 +0000
In-Reply-To: <20260420230420.G737d@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260420143939.3636883-1-jpiecuch@google.com> <20260420230420.G737d@cchengyang.duckdns.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DHY3280DLSAP.3PP7V3KZK618F@google.com>
Subject: Re: [PATCH] sched_ext: Documentation: add note about multiple
 ops.enqueue() calls in a row
From: Kuba Piecuch <jpiecuch@google.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>, <linux-kernel@vger.kernel.org>, 
	<sched-ext@lists.linux.dev>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Cheng-Yang,

On Mon Apr 20, 2026 at 3:12 PM UTC, Cheng-Yang Chou wrote:
> Hi Kuba,
>
> On Mon, Apr 20, 2026 at 02:39:39PM +0000, Kuba Piecuch wrote:
>> Commit 84b1a0ea0b7c
>> ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
>> introduced the possibility of ops.enqueue() being called multiple times
>> in a row for the same task without intervening calls to ops.dequeue().
>> AFAIK this was not possible before that commit.
>   ^^^^^
> Nit: Do we really need this line in the commit message?
> Perhaps we can just drop this?

I put it there just in case someone was actually aware of a scenario before
that commit where we can have multiple ops.enqueue() calls in a row.

Regarding removing the line: yeah, I guess it's a bit redundant.
I'll send a v2.

>
>> Document this behavior as it may be surprising to some.
>> 
>> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
>> ---
>>  Documentation/scheduler/sched-ext.rst | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
>> index 03d595d178ea..fba09aa1cd4e 100644
>> --- a/Documentation/scheduler/sched-ext.rst
>> +++ b/Documentation/scheduler/sched-ext.rst
>> @@ -339,6 +339,11 @@ The following briefly shows how a waking task is scheduled and executed.
>>       leaves (e.g., when ``ops.dispatch()`` moves it to a terminal DSQ, or
>>       on property change / sleep).
>>  
>> +   Note that ``ops.enqueue()`` can be called multiple times in a row without
>> +   an intervening call to ``ops.dequeue()``. This can happen, for example,
>> +   when a task on a user-created DSQ is re-enqueued using
>> +   ``scx_bpf_dsq_reenq()``. The task stays in BPF custody the entire time.
>> +
>
> Thanks for adding and clarifying this. ^v^
>
> Acked-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
>

Thanks,
Kuba
