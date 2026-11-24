Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516166;
	b=12NMbeqpd3K2bh96+hcD4mzGcrHVD/LNlL3ITjcLOaMgB9cHyHN67Xo0EKAmu8OT1W1l
	 ROMU7GSSvCpoGT3b2NAJOdlM2zljBC0vb4ro6Ppc3pIhWP257meFWYUNmzeXRwxTKukHw
	 XkUz65/ZbnrKONiZG1dbJyT73hmQm6p5YSBxRgINRacg4Ieagz5PK58Hra/QbSN+VVZ94
	 +MhPRs9hniNIPsxe93Kfzv3pirchj8wnoUqo9SbfYbJhydlvktGakYSTz0ojK9+GkxBJ6
	 Y/3dw+yNqXpH8RnFVRHtIAqSHLIoty+fNejQji9CHMGS9gOZozv0H8cc959Meiv+WnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8DPto8EVmQeRqjuegAdBfODKwtsnd0yVddUJOx12zys=;
	b=VI76/H1xIzikIbIs8zKzc2+IE3rluPBnvsTVPyFJBd9l9g8Cv60js9Iuj3Tmd+wjI1wK
	 4P3Dvdx4GDo/Oo8Xlp2zcM4T2kZq6WC24tnuOGwPHidURpYLlDUBImllx0ykJeZ0dHfRr
	 pA+V3sjLGbTwY1+mLvtqBGyolvt/2QpxVHJBNs1StJYDtfmMoCxwDK6sHykLKNCXMNGrw
	 nQWJi9CdU1fhdaqX9/+Gtj5lmlKsq358uWnYIT4nqIpWa5oBmIGVvrjya7rv4Ijh/3jDM
	 BFxSz3ne57QcZKepKvV353ZNw+/JXNEV66R5nxPWnc1JXJffYqtbjVLNPN4Z/Z7O67w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pqMQvDuh;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A69606A321
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 10:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24A69606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pqMQvDuh
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-490d2ac331bso3799952f8f.0
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 02:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795516164; x=1796120964; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8DPto8EVmQeRqjuegAdBfODKwtsnd0yVddUJOx12zys=;
        b=pqMQvDuh1tTOSJ51cmmbGqhqouMLNcj+dMyJtz48Bu/+lg1DHagaDb3pItDKWrmqAh
         BsP70J/myt/8fXSfAYzI8FTd6zBMekEN4Lebtbd95X20fTsbnLlNxifY7osw2XGnMFpu
         PodB/9cZziYBQyb+PL1St8cRN1rkTP6CYy6Kh7JlAcevDbCDEGf87fJWN4Ly268bz4qr
         5KI8BDJ0TtH4bdCRjx+5dhWX2pd/st5gqW2h2kP80ky0Ntbq8dLINPL8f21EKCHmVFlr
         mevTAoT8Kbt9IhdRS4gE/4wBlGZpIEJRBLC/Wx99upJRGfLMXchuFh1XNSsHxUyOnutq
         V4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795516164; x=1796120964;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8DPto8EVmQeRqjuegAdBfODKwtsnd0yVddUJOx12zys=;
        b=quSLXkFHzIeDq3ReZVqcUPWFJT9MhNstnGVPbfNnLicNJ0PIWpzO6brlhge/n/APPR
         Fy7gTEfxK4rbmYM6ajk/jGVVdlIIiO3nHQCfoUIm0g2GDAwTjnIkC76Wc+4jfn2zCfRs
         qhh61/r/G9ioLIVXbbRPPvrK4czL/mh75D7bd27MPpE3XR4WISDsqm7JF+djvwDZbNWa
         KohEzGjI/l2s1gvBl121OBZ13ajXHYGk3yoq25laaoN7SNG1FbJU2hEcffkjO3shgwtr
         HWLgL35w5gyhTSq65j6wMFuy+UXDYdTeIg+UaonLQAkyCkc/FiGmqrTpF+y4cOMoL96a
         I9Qw==
X-Forwarded-Encrypted: i=1; AL+hErEvvgjbfP5DGPAX+B2p3RnhpIdvGsGTyDNY84iRwuidVlrInX9SzPsirTTvcqLcmCoKgDgAlIjCRDw=@lists.linux.dev
X-Gm-Message-State: APuU4Z+GQ8OyVgMmfejXRHFXMcdXqxg/M4lSrhthYBP5BJnOguQLZ2bK
	UcPmTRDeVREAM3v9NyGqH8P1ENHqneKLvmlWaN5vFamY5jR/5CyCbFvgVNXm6Ng2DnGjw4dYG9v
	q4X/b4jPoVJcVvg==
X-Received: from wrqn16.prod.google.com ([2002:a5d:4210:0:b0:4a7:5aab:c222])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40c9:b0:4aa:f8a3:3cf6 with SMTP id ffacd0b85a97d-4abb3955aa0mr28954373f8f.30.1795516164147;
 Tue, 24 Nov 2026 02:29:24 -0800 (PST)
Date: Tue, 24 Nov 2026 10:29:22 +0000
In-Reply-To: <awVEFDoGl0ZqiHN_@gpd4>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123145927.577162-1-jpiecuch@google.com> <20261123145927.577162-2-jpiecuch@google.com>
 <awVEFDoGl0ZqiHN_@gpd4>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124102813.217423-1-jpiecuch@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix suspicious RCU usage in
 KF_RCU_PROTECTED kfuncs
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ryan Newton <newton@meta.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Tue, 24 Nov 2026 08:00, Andrea Righi wrote:
> Can we express the existing protection in the dereference checks instead
> of adding an RCU lock/unlock pair to every call?
...
> Can we use rcu_dereference_all(dsq->first_task) for the return instead?
>
> That accepts explicit RCU readers and the implicit protection provided
> by disabled preemption, softirqs or interrupts, while retaining the
> pointer-access ordering and lockdep checking.
>
>> @@ -11957,6 +11959,8 @@ __bpf_kfunc struct task_struct *scx_bpf_tid_to_task(u64 tid)
>>  {
>>  	struct sched_ext_entity *scx;
>>  
>> +	guard(rcu)();
>> +
>>  	if (!scx_tid_to_task_enabled()) {
>>  		struct scx_sched *sch = rcu_dereference(scx_root);
>
> Likewise, changing this to rcu_dereference_all(scx_root) should be
> enough.

Agreed, will switch both to rcu_dereference_all() in v2, and convert
scx_bpf_cpu_curr() and scx_bpf_cid_curr() to match.

Thanks,
Kuba
