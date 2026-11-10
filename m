Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794317538;
	b=HWctZpEeHdcU7Yz+vJpSprrbciD5JtVQZdhM0ad7mTN6F5Hfoe8Ax/T363eosIVMcjNk
	 WjYtswXdgDaE9xU/5ALvW8TYRbYaYC43TCyBXI1WcteVAwWKa/y4BML4nEZSXV0y/ycxv
	 mcvj/okhtSVrvqSU+l+wrs9bz9X4Pu23j/heD27oBOzkC1zr/vU8NCnmHf3r7rNX5NOLC
	 TMvyrp0EKM/b9kiESu/lSzN/QGHqd7YMj6Lyh++blSU/jIzaFkAdB5S3osSdqP70a7elh
	 e4VLxPZYVG8lB/2fn4bab9wHQt3pQZAtbrm0dNaWGozU8pUbGMHFrDwfZzbEbjU+xGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Pj4rH1eXEm9TWaNRKej2G25c6TaNFuIIDHh9BKw0CNc=;
	b=PogWK1/AoZr9R8xGNdbIQ4IjQ3VVCyNgdjEVfr/X6hK3gub9SNwijN+wazwYUuE3sfQe
	 KJkT8mBtoHUiz652c0q59364ToUH8DCuAQ1O6SRNT4BHo76nF5S88Acq0tTbtbfRaNsKc
	 bLOQ4v8FsVq/MHtzz2gILHwI8FyRTvrUHub0S1uKOv/EupHvivNPAAfwi/botDr4+qx46
	 hdPV43fvbELc0R0is7lb22kGhieFF262448wA01+B5hkNJ8rq/d1JKMv9z1SI6wh0V0uo
	 DNSgHvs1xGVz+vHo0JT3MGTfmDdvLUa6f+eiq59Z8M5pf0DNGabcswoKrKZ8LyzKTow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ISrFcgit;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF27606ACDF
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 13:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BF27606ACDF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ISrFcgit
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b244fb7fffso2492588c88.1
        for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 05:32:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794317537; cv=none;
        d=google.com; s=arc-20260327;
        b=klyKBswFSDzH/TaM2GWI6WpRX3eCOMVSNmTjfDV23WuMeiBM090+LAp7kY9MP2+n9Z
         gLKPg/DpfRU4zTq/T9dhZZ2SMxU3NbHW5dW8vZ66k3j0bUCUpnkTjv2NyjzhAIQgKSpD
         Sit/l62o/CbEIi6XyqZcny7JBfM9zCAF3qdgvxZrggvWkzAwx/4TyVMKy70XiQoG8WGc
         m/Q+BEVLD2GV/rtE0UIyea67Xlhpy30sid/SzB4HWxBQdnEIAWXz99bymkUwfhxCfzhF
         5BHyngwzf/1Jt+GEqi+5QPl5HXjIRC5QNq40aJs3BibjfnbCofSOT6/wM7fm/8LpOOFx
         Uu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Pj4rH1eXEm9TWaNRKej2G25c6TaNFuIIDHh9BKw0CNc=;
        fh=2Gvz7Bt0XS9vLQK5d43az0XGCbC0cNvDhN8QxOxDHLg=;
        b=C7JEGOXEoC27gxeNrdCb8rI3FJvnLbrVqiJBXbWMi/bQtgyPfaHFky9LIYVNZgS7+A
         6bZxqc4LpzYu5s3CSRiUs9NT02IOjtwbP9r1qoULvtQwPfEPNKwojwNBhoTJSkC3cqp1
         COVpZGWo7iCeRXIosW5r6fEF+30qmwFIptsmMHxd7BzdCx1JJLL83kD80PUTPOi86gGh
         X7GvfCuOA1Qoy6Rtf+UG019JGtE0gXLIDCHpPwoc+wUQvFNl2kPHN19AeVVBPtelaVfa
         RhnqW5k6PtTrX/nAwTmwzhWoYKqqqOwpWi9rttoQStRDPUFIpkTqWNi21QZSqKfbhpsI
         7C3g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794317537; x=1794922337; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pj4rH1eXEm9TWaNRKej2G25c6TaNFuIIDHh9BKw0CNc=;
        b=ISrFcgitMxbhDE4U0XGPXxDr/jePCwyzrpAShlCXetQVN94EphqBjKXuZkBOWoU9FS
         ktlqKM1w5rGJiOAM9DqZXGGzQS2crc27uA7WlDw2w7+nJrbnwyrZfJtrKrxxWXiIbwiV
         NfDmkcqMbysDJieRXTVi36fYgVaYGuxkaMUlUDP7IJGj2tYCA+lSBIQ8Ibrd9rh8IEzV
         +8ClFHAKIfGVJoMMCgmBwj8ye/d+lS8/gV/zFUjjhtb2wokz7TeqVP+CA8EYOVn6sXVL
         cuFvIyWTZCUY433xOKyEG995lJQrsDUw0GY4d5zW/MOIFIeBN7/7PlcmLw99bZVBLFbY
         Y1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794317537; x=1794922337;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pj4rH1eXEm9TWaNRKej2G25c6TaNFuIIDHh9BKw0CNc=;
        b=PKsMtuJJ1QXz858cC5IiRox9Z23lI9/25Wj/7OublGqs5NDjILm0WKYPi51ZCP/lU7
         SXJXyn2OBouo9yuk+h2UU5tJTUvm4Cg0Ahc6sgEuPRq5bLoP7Ld3X9uqF7Sd6/Odl1UG
         Vl9Cg2RIwFoAeywIUFCH97CQf/2eTQ+yw+DUtBX+xP2HF8xvsBb/97CmuT/Dpgl/Qv+2
         7IR4Q0XvjxzTMux32VwXc/JlyVYVvHprkKYYa3+beX2vl49ul1GsCygz58trjqh73inD
         L+geMDojWKLWTHjjZLdOHOvS72+86vYsqCg8UnlZ7ZWJnL7aqCdfB1P9MtgeLPYFTflQ
         PMSw==
X-Forwarded-Encrypted: i=1; AL+hErGde7DnUt7wKekz1aDGoSEkyfQAabu5HbLy5CE3HLdYsg3ec8wrXhugWv0h3CWu+Z5BasNNCrwdvUk=@lists.linux.dev
X-Gm-Message-State: APuU4Z/lVDi0OIP7/RjVeqhYv6LwTqICAlBtAxkN88C0H6vGi92n10Ff
	CdJ1gsI4sA4GVnS3Z4/fVwRSg2tjjYwG45/Alv47rOvIDrCDMCNz8r+4vdazifrDWZE7vL9QBjM
	DwOCH6psKNwAyMstSlYB8HSsvn47vgunr8ptUSfZmXA==
X-Gm-Gg: AYBFou1d7S2hj8sizn2oVxwjoKSnnAePAFx550+JQhCBs8nOVrjTkVeI9aF9m5fMEK0
	vi0der+MW/cynhdjqnPwn4T/hN/UAKiHDxM6ZbDDwAwp/Vd70OJB+BPjkEWRpg13jm5gY422fi+
	lWTj07lFnFvWCbFJN7cj4e4rfihBEvPZnx8J1rPrKME3ojG1GFQ7vcrCJb7XVJgfWdOl8LV88C0
	AUK8qLg5qkTIM5/xqq0D2FYgm/f90Y/YQEcBB5+HLlDot6+zAcOa8c7tc71mVX/cUXRzn4LlSFT
	pHUB/7ZAcmlgpSw59LwAEtaa08Ni9HtuzO3GvV12tyScQBbLnJIYXlwWK3KhNCi8/3f4nO5asEg
	iUs99LL1HcoYNMMzWzMjGXaGaAxfq1njtnU4GVYF5qmax1WaUt+4zoDscTNXEodjeCdDnaw==
X-Received: by 2002:a05:7022:7f01:b0:1b2:43ac:d3a3 with SMTP id
 a92af1059eb24-1b3b5fee2aamr3361789c88.24.1794317537291; Tue, 10 Nov 2026
 05:32:17 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-7-vincent.guittot@linaro.org> <au7SabL5pfbsApyB@scheduler.schedules>
 <CAKfTPtBfXOcAd=5RkYepRn15Hg=id9FQ3jh1tQoewOtUSrsjHw@mail.gmail.com> <avIh4MZjVyQuF6Yo@scheduler.schedules>
In-Reply-To: <avIh4MZjVyQuF6Yo@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 10 Nov 2026 14:32:01 +0100
X-Gm-Features: AclHuK_-u2urQ3RFkBLSdBCNdaeJlRcvSlcfMQXUBnI1scU56PsAWcpbh6wLOOg
Message-ID: <CAKfTPtALwo_aQ_31nF631_7hs1YfYzNUXdY1zC=jUB7P7_QRmw@mail.gmail.com>
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting CPU
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 20:56, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> On Mon, Nov 09, 2026 at 04:55:23PM +0100, Vincent Guittot wrote:
> > On Sat, 7 Nov 2026 at 09:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > >
> > >
> > > Hi Vincent,
> > >
> > >
> > > Sashiko reviewed this one so I'll just put here my own concerns instead
> > > of repeating.
> >
> > Regarding sashiko's feedback about cpu state ranking, I chose this
> > ranking on purpose.
> > For !SMT :
> > - 7 CPU is idle and fully fits (i.e. return immediately)
> > - 6 CPU fully fits and is not idle but we can preempt current because
> > of slice so the task will run on the best CPU immediately
> > - 5 CPU is idle but doesn't fit uclamp min. On such a CPU, the task
> > can easily miss its deadline
> > - 4 CPU is idle but doesn't fit at all. This is even worse
> >
> > For SMT
> > - 7:CPU is idle and fully fits (i.e. return immediately)
> > - 6: CPU is busy and fully fits. Although CPU is not idle, task can
> > preempt current because of its slice and run immediately on a CPU.
> > This is similar to an idle CPU (and maybe even better). While writing
> > this, I realize that I should probably check the lag too
> > - 5: CPU is idle but doesn't fit uclamp min. On such a CPU, the task
> > can easily miss its deadline
> > - 4: CPU is idle but doesn't fit at all. This is even worse than -5
> > - 3: CPU is idle and fits for task but sibling is busy
> > - 2: CPU and sibling are busy and fits for task and like-6 task will
> > run immediately
> > - 1: CPU is idle and doesn't fit uclamp and sibling is busy
> >   0: CPU is idle but doesn't fit at all, and sibling is busy.
> >
> > Note that with the push mecanism we could look for another CPU for the
> > task that will be preempted
> >
>
> Thanks for the great explanation! My only concern is on 6 and 2, as I
> explained in my first message, below.
>
> Sashiko also pointed out other concerns, it would be good to check them
> all out.

Yeah, will fix the set_idle_cores too

>
> > >
> > >
> > > Look here:
> > >
> > > CPU1: CPU2:
> > > FA    RA
> > >       FC
> > >
> > > CPU2 has 1 RT and 1 Fair tasks named RA and FC.
> > > Let's say RA is running on CPU2 and FC's slice is 10 ms.
> > >
> > > And let's say FA has 8 ms slice, and a fair task named TC is waking up
> > > with 9 ms slice:
> > >
> > > * We look to CPU1, 9 < 8 is false so we return false
> > >
> > > * We look to CPU2, 9 < 10 is true so we return it.
> > >
> > > But the problem is, CPU2 has a RT task running and we are going to
> > > compete with the RT task. In that case it can be worse than CPU1.
> > >
>
>
> Thanks,
>
> Kayra
