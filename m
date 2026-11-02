Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614113;
	b=fEin4Ly9kHatMB9m4y1i+arpd1T9lUWbje7REVGVowQLLP0Nu6xs/XP0FRifqlgiiYSx
	 dTjf/GAnScklxmfHe9/RNM750ENKSBfKvYeN7VEt2+KBI8PcsvpS+5WHffHqsqMtW35+I
	 w3KuIFjTgr5UYo95+ITnPdHXrrjOg+qkNFidK9BA/cjSo08uscKu0+q10jWlFnlguKmoj
	 Imu1KHefhh9C2uWhP2/pLol038/s4zs20wEv0C8H9NQcSdy527wCu5rEeFWQScwMz+rBX
	 yJGE05TQqPxDbnwiyfjPSOmfCKMGmzzqeiFIdr6lLBfmgfSeFOSbH6DiZmT9qYinVYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614113;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=2QAuBoqKuE+cIrY28tIIRA/uX6efXaA0O83MjGB9jy0=;
	b=mkXQTyfy84V9SHMOgg0FBsxlRtejEI8UtOGR2aEU/tJaVfpXkLCNsuTaIsWbuwC3Y80W
	 Vp13oq8wTbb87wEVsTJH4zR0tmgwpGGnbwGoNX+FDB2+SsGVy8jKT147E8sqzp3Jvu0PC
	 ms+d8Fj1Q7StfAMMXv+9rnsZAw1jiGV1cwKrvhoBZhZSNtwsbH7P8AextyxKHjNangoQq
	 odw68Mjp8K6puWI7CzT0knQysFa8RxCqrLL532oa8yoa3hUHYlaLoUCDeoXFLyOcfltnG
	 KRhLpO+S1jADusKLut5i+787SRJUJEy1CEknqIUuMEzfjl44yl5i2izWL2V1ezLOGHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b4nA+M5p;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3370606A338
	for <sched-ext@lists.linux.dev>; Mon,  2 Nov 2026 10:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3370606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b4nA+M5p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793614112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2QAuBoqKuE+cIrY28tIIRA/uX6efXaA0O83MjGB9jy0=;
	b=b4nA+M5purcRMCh4zfZJMDIyF0dBiNa2Ko3iNf2eTJOYPirfzESyWXLkBIFYsL9naoM8ji
	q/EY+lbhWl914sDuT3dtx9BVAjipPKi+MAMr76ufacX8ENHDFaQhkHL1iQWAq7F5iokN/R
	h5Zypw8QtGRtT1pb8rGpf8cW9O1dNy8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-gwS1lsCCP-mGuhQmUCqdyw-1; Mon, 02 Nov 2026 05:08:28 -0500
X-MC-Unique: gwS1lsCCP-mGuhQmUCqdyw-1
X-Mimecast-MFC-AGG-ID: gwS1lsCCP-mGuhQmUCqdyw_1793614108
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so1338351f8f.1
        for <sched-ext@lists.linux.dev>; Mon, 02 Nov 2026 02:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793614107; x=1794218907;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2QAuBoqKuE+cIrY28tIIRA/uX6efXaA0O83MjGB9jy0=;
        b=wyrs9H71wdlCCm8RQDpJONGYROhEZbFc0CDs1M9J3xYwauFQC5GWeRVhleVfc6jioc
         JuTJKCifbjHCATKEgw0CX5CVIDl+xg8xFP06qs7+nypaRKpiijaFw++mJRTrqcVVPu9y
         76dhEJOccdGiv378YsolQSn06FlIZM9oPXeUylk+ZQla9sx7Gy87PBIuuiKrt4GKuxAY
         CWLhmf5W5Qkl5hsWpQlVJgKz9EDyYAckthJMiVw6yNLBgT5LO1scF57nzNM1ztduBjXt
         KlB0kiIMPnQS/WPS7hyLr1YUizKHbn4XwPmLK77urM+mYx4pF4Dzzu+3wtx1+nvXyTne
         DF8g==
X-Forwarded-Encrypted: i=1; AKwUvByhwYBn4IYkNcYA8TlBT8Yz869SRgejMGCfopraRjx3jsmamC0lQo30WFfuzFC8oMAgAi7InHcijnQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYI+afQ2JttFRCiUsyep59kQDafhgd2B3obNfS4J125VGsnWCp3W
	/iGffTWusVpeAdEJdgKzxxjmbjA5sZDH6yDi0tXAKWnwFCEDQp7DgHJ+FCR4Tbc5vSVs5VGbDO2
	K2NU2x2Hn+fzAz2IcQWmH8ZBzQXh6peq7Fsk9LVG7xdciQlmNsNr9XMJAU3okhw==
X-Gm-Gg: AYBFou1/c1ah1e+U6CJzf4wCwNSxZZlCzClG5B7YA+xUglSmPXHYQWmKA62Cco1hkI+
	5OgenPA5jHSIHkv1eu7bVxSjYqeAss5pKNxdPF0UAIW2mu6lywr+s25qxFF5HWsnJ2K25kFmq1B
	K1DBFpMtS0y2CqG+ktAORHrUPWpConCRSRCuQJxsGhlbZwk+JNclV4Zoc23xGbvcs5vOaYNcBUg
	iDsbpPkJwSKcYdMUkE2+tJ2VBnMe03ZL7tEY+fSr60KPUuiGSekBz0fGhW3fqumkIUat05wJ6z8
	tS9VkR0laerHgheQWfGTX8AMaXhU070xw2o2CHC/4OOZMuU1nMPcKacXpDoVvFTjXXeB7614zwq
	EuJ8PrHD4rIqbDghT4gepX3jgTTGL7D6Z85EbgEN7ts/1Bd3y2I2pmucznpBfkM5KrwAZaVLqiM
	f5IA==
X-Received: by 2002:a05:600c:3f14:b0:4a3:59ee:86b with SMTP id 5b1f17b1804b1-4ac14ec873emr214702925e9.4.1793614107489;
        Mon, 02 Nov 2026 02:08:27 -0800 (PST)
X-Received: by 2002:a05:600c:3f14:b0:4a3:59ee:86b with SMTP id 5b1f17b1804b1-4ac14ec873emr214702595e9.4.1793614107099;
        Mon, 02 Nov 2026 02:08:27 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe7700c3bsm239439385e9.0.2026.11.02.02.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:08:26 -0800 (PST)
Date: Mon, 2 Nov 2026 11:08:24 +0100
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
Message-ID: <auhhGAjRtuSb5JP7@jlelli-thinkpadt14gen4.remote.csb>
References: <2b5fb3f22bca6aa383be8f4781923392@kernel.org>
 <auRh42kZI1xLIWNr@jlelli-thinkpadt14gen4.remote.csb>
 <1a24bcdde0bb6e4a8c839351002e841d@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <1a24bcdde0bb6e4a8c839351002e841d@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H94dlKMN3eRlnbeCBI0g7DBlgSFh7SKD-OqRvi9DXJk_1793614108
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 30/10/26 14:47, Tejun Heo wrote:
> Hello, Juri.
> 
> On Fri, Oct 30, 2026 at 10:22:43AM +0100, Juri Lelli wrote:
> > Does the below help?
> 
> Yes, it fixes the leak. On abf8c33470f7 with the patch, the reproducer leaks
> 0 in all three cases, and 60s of random policy churn ends with total_bw back
> at its starting value. Two problems though.

Thanks for testing and reporting the additional issues!

> sched_setattr(SCHED_OTHER) with SCHED_FLAG_KEEP_PARAMS on a sleeping
> DEADLINE task leaves it DEADLINE, but each call releases its bandwidth, and
> its exit releases it again. total_bw relative to before the task became
> DEADLINE, with a 2ms/10ms task (0.2 CPU = 209715):
> 
>   after the DEADLINE set        +209715
>   after the 1st KEEP_PARAMS call      0
>   after the 2nd                 -209715
>   after the 3rd                 -419430
>   after the task exits          -629145
> 
> After that, sched_setattr(SCHED_DEADLINE) for a new 2ms/10ms task fails with
> -EBUSY while a 3ms/10ms one is admitted, and offlining a CPU fails with
> -EBUSY.

sched_setattr(OTHER, KEEP_PARAMS) on a DEADLINE task doesn't make much
sense to me :).. I'm inclined to think we want to fail early in this
case.

> Switching a sleeping DEADLINE task to SCHED_OTHER after its CPU was offlined
> crashes in the __dl_sub() the patch adds, dividing by
> dl_bw_cpus(task_cpu(p)), which is 0 for that root domain:
> 
>   Oops: divide error: 0000 [#1] SMP NOPTI
>   RIP: 0010:switched_from_dl+0x13a/0x3e0
> 
> Unpatched mainline only leaks in this case.

This one looks like a pre-existing issue which my total_bw fix makes
worse (w/p it we leak but don't crash).

Let me see what I can do about both.

Thanks,
Juri

