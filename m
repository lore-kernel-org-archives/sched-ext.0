Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A77E30F816
	for <sched-ext@lists.linux.dev>; Tue,  5 May 2026 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972443; cv=none; b=frNY6JbzSwPo27+uE0OBOjXNgcJUArNaxB2dlRdPMl+/GsrnDeaSJ6RLbdLWkoBhLOMi0fAWJ7v3dRLmZMuxkxVVQi5F3pOgfSHa4tC+2hK9qcUOKEy9ApVe19z6ss0HA6r4RpW7yS9nCoG1a5XCJYd8PRc6EK/qslXqgGoVDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972443; c=relaxed/simple;
	bh=ozZTD3AagtSW8An+sSwE03SzOTDlXwzRcRkGC1PNPmw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rBSlwrfbZtlQdQFQBYWGs/4y6Ju/5oSYuqN12iO7FNGuXVloQNStAcdMEHjXujFrSZJpW1ut1yzth7n1oH+/R8Zl06unqJvTtbZWyq47ayAOHv/7EUDXbiohaZz8vHqF2pdPm6x+sgmQAQyjNgOOj3Lso3UuoHLSjys2OT2fStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J4mEEEEx; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4mEEEEx"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d7a5b9678so4027705f8f.2
        for <sched-ext@lists.linux.dev>; Tue, 05 May 2026 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777972439; x=1778577239; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CfOXjO28QWIi6sr7QzygIUlzNqE9gXOJzKbu5PdV2ZA=;
        b=J4mEEEEx+KhNxaKjXXdSrJ4R1mV/bRxRr5TkKW0rdqgbOOpoNe45NVCzS12EcOHEkQ
         FMInJhGOyLKfEA+Xj4op/CeuL2CWXL1OjMJ/rQ+PYzt+H7SowHVynSsoikgVMjQulmDd
         9N8s3c32kc9fd6w6c2xoUlhjoF41PaewouJSve86NiXCC23dEvvmQk9rj9qRcFMTlW9O
         C9126Zmj1T9Q23OhonifxRHAqvDbD7GO41OrSN5pVW2zg4jip+UDPHM1sw7lILX/TIGT
         pafQDs4/LWBoff3d06C/Nh474bZs2yDd800B0ZPZwmwx7iRZe0jWbs1ol03WbEyisDc8
         Z1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777972439; x=1778577239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfOXjO28QWIi6sr7QzygIUlzNqE9gXOJzKbu5PdV2ZA=;
        b=nlOAIQ+RwJ6uoVCPKx2YvHrj+RKxgdRcrNdTU5HqKgcJbG0hEGT80VfaWmWSND9yPO
         sLzIgIRYRkiA3X3flaehlCNyk56nnfOwBYgsgcQxF8cQ11xcn3WlOvd3zjMQDXMAnv/G
         +cjQdHqtt8/W3l83iu9Vn0M5J9ZnLjl0XDlOj6E1lu17bG2Uf9kksaKXj7NV2ZU/lzcU
         vLhxzTdmykiyJE+RWQL2L/D6F3vKlyBSa4+E9IBFATZPCOG79FtlPTRBI/QYLEnkiNtv
         62TY4zNupAmSVr3vKj50ILKSwUW3Y9+nGHycZ4O8PmgsEHR8x2iqHzcqjb67phJMdjI8
         J5qw==
X-Forwarded-Encrypted: i=1; AFNElJ8nn5IOZhXqRv5qF9pJKebRIubQYl1YqMiURAIXJHSwkxab0QZC61SKXR0CFMKj1Rmb66kNEcNjKaQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/HtK6+ysJeYMquhqziGCRRnleVtMCF5MudoZYTB94JMsjqGwH
	BF84InEX6huQqoyFrihM0Z3JjK3bacyc0usCOY5SZnSohSman/QHEk4hGouPWA2HXnSMYWSnvxp
	4wS2TT7pmogOibg==
X-Received: from wrru2.prod.google.com ([2002:a5d:4342:0:b0:44f:298e:92c4])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c09:b0:44a:fe14:3738 with SMTP id ffacd0b85a97d-44bb32fd771mr20846119f8f.10.1777972438478;
 Tue, 05 May 2026 02:13:58 -0700 (PDT)
Date: Tue, 05 May 2026 09:13:57 +0000
In-Reply-To: <afmq4DtGZcf4Zh5D@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com> <acHJED4iAeytdC2l@slm.duckdns.org>
 <20260422142633.G7180@cchengyang.duckdns.org> <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com>
 <20260426093756.Gd781@cchengyang.duckdns.org> <DI3TFV6PNXZ7.3OR8GY5SBIEZ7@google.com>
 <20260502000039.Ga94c@cchengyang.duckdns.org> <DI9QFXIX3Z0R.23PU1FB6DEMPS@google.com>
 <afkOqQRB1YqSlL4x@slm.duckdns.org> <DIAL292DWST9.1UIAWWSHW1UMB@google.com> <afmq4DtGZcf4Zh5D@slm.duckdns.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DIAMMLYHMK8R.2B472NGCJEKP5@google.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Kuba Piecuch <jpiecuch@google.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, Andrea Righi <arighi@nvidia.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue May 5, 2026 at 8:31 AM UTC, Tejun Heo wrote:
> Hello, Kuba.
>
> On Tue, May 05, 2026 at 08:01:58AM +0000, Kuba Piecuch wrote:
>> Could you elaborate a bit on what you mean by "properly synchronized" here?
>
> If ops.dequeue() synchronizes with the dispatch path so that the task being
> dequeued is either dequeued or dispatched, there's nothing else to protect.
> If ops.dequeue() wins, the task won't be dispatched. If ops.dequeue() loses,
> the task should already be in either the dispatch buffer or local DSQ and
> the kernel dequeue code will shoot them down. In the former case, at the
> dispatch buffer flush time, the task would either be already dequeued or
> re-enqueued with a different qseq and ignored. In the latter,
> dispatch_dequeue() would remove it from the local DSQ.

I see, makes sense. Thanks!

>> On another, slightly related note: I'm considering making scx_bpf_dsq_insert()
>> and other dispatch-related kfuncs that manipulate only CPU-local state
>> callable while holding BPF spinlocks. This is something that the comment above
>> scx_bpf_dsq_insert() explicitly mentions:
>> 
>>   This function doesn't have any locking restrictions and may be called under
>>   BPF locks (in the future when BPF introduces more flexible locking).
>> 
>> I'm not sure what "more flexible locking" means here, but this can be
>> accomplished by simply adding the kfuncs to the list of kfuncs callable under
>> spinlocks in the BPF verifier.
>> 
>> Are you aware of any previous work on this? Any pushback from BPF folks?
>
> That comment was written before bpf_spinlock was introduced. Please feel
> free to allow thoes functions under bpf spinlocks. BTW, there's also arena
> spinlock that is implemented in BPF proper, which is already used by
> multiple schedulers and likely to be the default option in the future:
>
>   https://github.com/sched-ext/scx/blob/main/scheds/include/bpf_arena_spin_lock.h

Ah, interesting, I didn't know there's a pure-BPF implementation of spinlocks!
I haven't really had the chance to play around with arenas yet, looks like I'm
missing out ;-)

Thanks,
Kuba
