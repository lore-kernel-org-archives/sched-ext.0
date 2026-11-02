Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618148;
	b=KlfAY80JIlggGhupljTqC3uI4/1DMB8NmTLqh0s/Wa5XH2Txa0oxVg4yru945Xl01oqG
	 w2jIMAUF+Qg007VBrJCkYvYVP0BmZPqnzelvR7zIPttIsr+YTlFDeLWNzW5srFB2dhoU4
	 ZbzJsNKTDW6TCJZXdQwnn5B0xeu5fYLJaybL11Z/DxbV8kmmpoJDx5l06Q/6H29+dT7ZV
	 x9N/irrhROCxcjJvjuM9IlDbisl7pCcBswZbovHVNqcadf86D61o/hTB5oI3PzHKY/wI0
	 SGVW6nN6ZsJjbroS+5cYAcV3s9UtgEJswhFIGHQxhzuUoAka/WJ9vUEqjUmNLtQprqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618148;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=j3k2JcIDr9e6NfXKHf9MQ7O+/Axvni6jr8jzTqhwKMc=;
	b=C7lzlNYqlSqd14S+bL8D6XW83uA9SZN++GKl83crnISfmO8naacfmnOb0oHMvK9/ZYaK
	 5GhOJY4Qs8mvtYTRzpfp0XHa445n75xdqpyFo1NU8EF04kx2xgS1UL2ahWgHoVB9uqNaA
	 AWVX7x5AD4DcZviGapVkAJ5m9gDBPhjg00dB25zh1Ez5nrJ0GaTK2eW9QBFL1MHu0jBJ5
	 2HI3/uAOpY6reFJsonO6IpiABCd61es0XSfVsZkY5TIeZXb0kC4J35Fooh0jSGtSa7S5O
	 v6eb8X2FuxSarDUpnJ13DFKcjM11QKJckYs4146svI+PasAwNTWjtVGzs2sNv5yVGLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q99Oixhz;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA4606A32E
	for <sched-ext@lists.linux.dev>; Mon,  2 Nov 2026 11:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6BA4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q99Oixhz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793618146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3k2JcIDr9e6NfXKHf9MQ7O+/Axvni6jr8jzTqhwKMc=;
	b=Q99OixhzJMXl9IEx9Dz/Uz9G7Hs36VunLJ1HDPBqzBbfRTOEvYX5x1y0wJ0XfIuZyOaFW4
	Bk5n0qRaUPohrUO0CBLdJ5lT43AkhDeAAghQfFPtv9uMy5neV/rfLhkXVIE52OLcLL2zhu
	5e8Dmmfkyt1ERBCTsZ9yNcC05ovdehg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-G45LLi8WPOqrALzqg9ZoHw-1; Mon, 02 Nov 2026 06:15:45 -0500
X-MC-Unique: G45LLi8WPOqrALzqg9ZoHw-1
X-Mimecast-MFC-AGG-ID: G45LLi8WPOqrALzqg9ZoHw_1793618144
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4ae2756fa7aso12594685e9.0
        for <sched-ext@lists.linux.dev>; Mon, 02 Nov 2026 03:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618144; x=1794222944;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j3k2JcIDr9e6NfXKHf9MQ7O+/Axvni6jr8jzTqhwKMc=;
        b=mt80cvs5jpBEPqIWruFZ1QqhB++gaQfecL14Am0CiBe5q6XWWCMTdUTeyyW5VRcGsB
         5jJjMKStXng3tAbPLruTKThoi6SJekLZ0jVf6dqYVeZmBHF1kVUvZD9d//CpvlTHP5Mn
         bZmCnh7mPE4yLINAxMgwDmZPEYM8/dIfct2Ckzmrc8oJfDKd7NNycZKTcsA1ixBSPwQm
         MUm3o44ubmHo9JIsRBz17Sag0ijutozYT9Advlo8oNMMCjMqjzOrqXuMQA8ytemscy2T
         CJlO20i/HWWZpUcJr5MkKb8LcLH5L8B/E2woib5BFlHpEt9vYtmL5aBjXZ0GEq6HKNM6
         b0Yg==
X-Forwarded-Encrypted: i=1; AKwUvBymLKuHXfW3M/0CZjzxZgybMVxgLsu7rfnBBl2a1UKcTR1J9Rlq3MZaVnx/RzZl7fwbnsyVVgGWuKA=@lists.linux.dev
X-Gm-Message-State: AFq9FYIEb1TiaW/e+GrYKiD+nVQDOqn2waQW9AKu2HlYYvy69SZuJahs
	c/ZV0+J9jNCVvvPLH1luIQufDUzVyUr+YexRSVXPz+/RjesWYXAcTNjbixBYrua6miDn+15Rakj
	veBLxd0ulMsapbo7h9IjHqtF6qvojxR65pQ28yL5VyT9/S37C61ibAtC/TgR6OA==
X-Gm-Gg: AYBFou1886Z9tJ73GB8k47F4IGBldyyrgbDUEcKur2xHTEL0W5MkMRPoRoRTbsF4GK9
	jGDpKKAy+viUeUKmW7Zb2dionhXQVcn/rDrabq2rij03trnUaEBtj2VkH39O+bhXqG0g+ZnCgGV
	rx0l+mjUHWdV6/WGz7kAdryGr8HNpUj6ucNqf7ptwBtch5vG6VD9rUxrQszJdCk69WIk8nb6Wq0
	N9AQqvGj/IjPHizwsviVjROt9UPz2H2TGvQ05JFdQsgpUGWnvIOMHvoMg2KPeHBnwkM2P4ukNQ5
	n2w7X50KyfkWV8PupAdbGBEo6AwWchLA2u5nbh8+hJJ86+MHRYCz4U9KSBiU5t5YPGQ+T62RYzD
	eRsBizJd4Efvssx3tGQC49hidBo+og9/lMx5g8Elt8KoLtam3mLxSpZ1rOouk+KojajwIdqhuYZ
	wp1w==
X-Received: by 2002:a05:600c:19d1:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4ac1970b9f7mr220395065e9.34.1793618144155;
        Mon, 02 Nov 2026 03:15:44 -0800 (PST)
X-Received: by 2002:a05:600c:19d1:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4ac1970b9f7mr220394775e9.34.1793618143852;
        Mon, 02 Nov 2026 03:15:43 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9b54dsm19099569f8f.47.2026.11.02.03.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:15:43 -0800 (PST)
Date: Mon, 2 Nov 2026 12:15:41 +0100
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
Message-ID: <auhw3ctxwy8qeOvs@jlelli-thinkpadt14gen4.remote.csb>
References: <2b5fb3f22bca6aa383be8f4781923392@kernel.org>
 <auRh42kZI1xLIWNr@jlelli-thinkpadt14gen4.remote.csb>
 <1a24bcdde0bb6e4a8c839351002e841d@kernel.org>
 <auhhGAjRtuSb5JP7@jlelli-thinkpadt14gen4.remote.csb>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <auhhGAjRtuSb5JP7@jlelli-thinkpadt14gen4.remote.csb>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MdNUzPaQYmdMohPwoPf-LEmBCWXrU2xD0_l7vaUeP-g_1793618144
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 02/11/26 11:08, Juri Lelli wrote:
> On 30/10/26 14:47, Tejun Heo wrote:
> > Hello, Juri.
> > 
> > On Fri, Oct 30, 2026 at 10:22:43AM +0100, Juri Lelli wrote:
> > > Does the below help?
> > 
> > Yes, it fixes the leak. On abf8c33470f7 with the patch, the reproducer leaks
> > 0 in all three cases, and 60s of random policy churn ends with total_bw back
> > at its starting value. Two problems though.
> 
> Thanks for testing and reporting the additional issues!
> 
> > sched_setattr(SCHED_OTHER) with SCHED_FLAG_KEEP_PARAMS on a sleeping
> > DEADLINE task leaves it DEADLINE, but each call releases its bandwidth, and
> > its exit releases it again. total_bw relative to before the task became
> > DEADLINE, with a 2ms/10ms task (0.2 CPU = 209715):
> > 
> >   after the DEADLINE set        +209715
> >   after the 1st KEEP_PARAMS call      0
> >   after the 2nd                 -209715
> >   after the 3rd                 -419430
> >   after the task exits          -629145
> > 
> > After that, sched_setattr(SCHED_DEADLINE) for a new 2ms/10ms task fails with
> > -EBUSY while a 3ms/10ms one is admitted, and offlining a CPU fails with
> > -EBUSY.
> 
> sched_setattr(OTHER, KEEP_PARAMS) on a DEADLINE task doesn't make much
> sense to me :).. I'm inclined to think we want to fail early in this
> case.
> 
> > Switching a sleeping DEADLINE task to SCHED_OTHER after its CPU was offlined
> > crashes in the __dl_sub() the patch adds, dividing by
> > dl_bw_cpus(task_cpu(p)), which is 0 for that root domain:
> > 
> >   Oops: divide error: 0000 [#1] SMP NOPTI
> >   RIP: 0010:switched_from_dl+0x13a/0x3e0
> > 
> > Unpatched mainline only leaks in this case.
> 
> This one looks like a pre-existing issue which my total_bw fix makes
> worse (w/p it we leak but don't crash).
> 
> Let me see what I can do about both.

Would you be able to re-test with the patches at

https://github.com/jlelli/linux.git fix/dl-total-bw-leak

BTW, it looks like I could verify with reproducers I pushed to
https://github.com/jlelli/sched-deadline-tests/commits/fix/dl-total-bw-leak-reproducer
but I'm not sure if they are similar/equivalent to what you have at your
end.

Thanks,
Juri

