Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B93C3C02
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 00:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594264; cv=pass; b=gO9Zpe7g9acbJQ5FiGK9Z2+ZdZ1Ag0xt2oAHV1xkTj4mOLAIPKONAC5hMdJnlOy930T1eunA6e+4PHK/h0pKMUx7X5x5oQyO+4fqhWksoRe6CxhiTe79A111Lau4UVLemtio0AyM4/elwV6UFCEF07WFxB8jo7b5PmZREuf6km0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594264; c=relaxed/simple;
	bh=Hqi9xZJHYKoDfMSncJymEizZnYBmqve/UlNMpzuBaIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmOqj4Wxxs7IJyMBnaw2Q3j0DmpSMTfBLXdQgDoXZICvqQMWptWJO5r360f+08Gb5ztNzFEqTv3UQ0Cf3JydGnP8o/8WtRXczz0FlTXxKMZ6Y4iDSaJ0PmjFbVRLJjVCnUUCc6ttrUCnKFVFdEgVIadOFtZuL2EjRymLnxZREwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOx4+4PG; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOx4+4PG"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so4704774a91.1
        for <sched-ext@lists.linux.dev>; Mon, 20 Jul 2026 17:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784594262; cv=none;
        d=google.com; s=arc-20260327;
        b=oSBvDCCARvMZ4AdsDsHCt18WiaRAtGey2RpFSkEmZoo4PfrtK4wJas63DMY6eYbssk
         jw6WaW1QTUr8H4vcnioNrLeJ2LZwqdOdL7NTxwsMSqDy3p3+VTdhVYsu5zxQcq/fn+2W
         FFYlZJS3ioiHDhYSfVRVz9k3AKiLCrgp4ILRe7hRiHxqjwKjj+B/z6PqhCAaVM8qcfdw
         /ki21z+Qka/H2LkSx6hHmPJCvQl+R8HGOFx/bHtnAOFP1hGodm4fcSiT9TUY01lmEf8R
         lgizVq76PIhLo3DQ4fjRnpbuill75bScMVbERZ/TMotWWEYs11vhwYuyLSMgS4/Fmj1k
         pqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GOg0efsnZISb028xKsJifrOMJ9PM4D4mn5DKt+FPgu0=;
        fh=VU6NlzUF3ireMiiwFfOKHttkA3pHjPaxMmlsAeqBKHI=;
        b=eO3XNn1CLGMC+KKVBP8gbY2AkV8e4qwvSTPoHcUt1wm6AJYzoRfeL2OrOFq2TnkAM3
         hMeuJgiv/eZ+j5ohsJnCUiIpoWd0XRhW9QYEZaevIdk6VgFRn+a84nVYF7xgWi/72K+Y
         909F/qoBbYjO1iJkXP+cDPKL+i8r8KSeciWOJ5+NeOh1m9mC2TaS29c6PG0ibGBG6kYN
         BB+1LKAtumF1sZTngnonLE+rhDOX+QFhtKs5mhdgYSIsy8piY1GuveppnjeLBrew9HTZ
         fgr2NMToavy2d8gpbgADnvepiFsjXkex821m8+hMVgEpcvLWdNhUw97NJbqZ0JjLlOVT
         0TFg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784594262; x=1785199062; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GOg0efsnZISb028xKsJifrOMJ9PM4D4mn5DKt+FPgu0=;
        b=IOx4+4PGMF4+B4UuyPuGCfQHUD3//5XkRGXs3Nbi4oYN7FwtGSzkAOvoP05Q90ZQ7f
         oXk83zERiLYhHbJ4szuI+e8y+aFp5KJOdX+9ixel+sJ0uXNTeY2jeK3uggiatouIKfKK
         p6NpvrJ1nVI59DpqLEAxlrySmIhrDz+f7V9PSl54i/KHfl5Czp5eDa+X93hENxsxCCQB
         qqRSD4djlhIx26W10meEtNeVm7DgYAobAltPwS5DE6MSlJO/jCVkceGJqXagUFcrsG4w
         Q/fXHW842NRQ2F0DumRP8j6Ymts5hwhaXtvBOumtIbbPHWETY32air791Dc5GpMZiCVc
         85ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784594262; x=1785199062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GOg0efsnZISb028xKsJifrOMJ9PM4D4mn5DKt+FPgu0=;
        b=kZcJw30WyFDS3XW1ReHvM2Z6MCwyPIKeDE/xf4vP7UyOjnpNCwePD+v9ENlQZ8qRlV
         81DddjKKfbHLnc/0j6PhfY+nuyOUc1+nYYOXowZQiBv8OfEmrdUJeVUAFaJQ31uhT1Op
         8Swa0JzvKc+AKkn+LkWMRrMuWyG4zi3577LY3iZlc8OUILVIcDafkMQdMRIdqWz/s4Mc
         lGctFb/qd87MUEzZ82K37z1Z61H/4RxSrP3hTb/I9dXRxsISOxbUUaiKkQaS19tNmhZq
         cCAt8semAYCpqOCjtN4gf3wem7NaUqWzwnhlbjXimex5Gh61JWXGFnIfWPWRtVZvk8hS
         pegQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJsl5Jl1CSAMnB2Mm9+qex9A7C8C5vSpJa82OsbzAirsf4WB5DRPykalMri/zXTyUkXwi2y0WOfvo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwEscHGwBqzuDrXf2yG6uhZVJy42gKecaxDp1VfVpBt/DSk0u64
	f41mBaU8XdC4XcdKvUfHVvIC5mv+uBY5zyZErFP4KvFn4oyxk1IRMazOXf9aTcx+32VYReRx9Dz
	PF7GQEug6ZwioKg0M/8n9r560gitKkL4jc2z3c7w=
X-Gm-Gg: AR+sD13ZriQyoXTN3+E+IbVgIksLLx+1x2jMA9M1PbOna0SyPSYyX1Ow84T0uMLJkVP
	ajaogOel08LTxmMWFHvqJQK1LgEPwJlG/BSING2ficPPXYhqn1pAYkCOr4/rrNV9YPz7NaroNB5
	LbIB0dZDb4JQqqsCVA9gOmKaI7R9w2ud6HcLQS1J26zi4hELN6JdoKIWCBf5Lb7euA3WBQ322c6
	8DsqUkAPtCS/WrKgGcHrOYXaWDaYPo76btUnjeXAEjSfS5L9gKclAqh42+ZerrTKb4e0ggV6JMt
	xqyWJwhzzu6g03sJ5f04spBvW/QxoPOnXOU/Dpb5PzCXYXzRFanLEguo9hxn9/q9oTDC/FeGEoq
	Tv+SmkK+m7XktYw==
X-Received: by 2002:a17:90b:2244:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-38e4b402565mr14781661a91.11.1784594261376; Mon, 20 Jul 2026
 17:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716132229.61603-1-arighi@nvidia.com> <20260716132229.61603-9-arighi@nvidia.com>
 <CANDhNCq4pijyx=h5mcqFji0hDQSOPDqkS7LdeYcUKNneX_wNsw@mail.gmail.com>
 <CANDhNCp01g3PN4=hZgCBLUn79_H++y8hyAr4RZP+C3MYckon7g@mail.gmail.com>
 <aluMWf5H936NXA0N@gpd4> <al5GZXcH7D0s3I5d@gpd4>
In-Reply-To: <al5GZXcH7D0s3I5d@gpd4>
From: John Stultz <jstultz@google.com>
Date: Mon, 20 Jul 2026 17:37:29 -0700
X-Gm-Features: AUfX_mwhyl42W3v6u57Bfi8nnbJubHg8PVq4T9mQBJQp-LAUxcJxjjNa8i7qQJQ
Message-ID: <CANDhNCrKXY3pTcsK4bSdeMRyUPjzdB+FBwF9A+p-djQ0TxCirw@mail.gmail.com>
Subject: Re: [PATCH 08/11] sched_ext: Delegate proxy donor admission to BPF schedulers
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, 
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 9:02=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
> On Sat, Jul 18, 2026 at 04:23:40PM +0200, Andrea Righi wrote:
> > On Fri, Jul 17, 2026 at 11:50:20PM -0700, John Stultz wrote:
> > > I'll work to prove this out a bit further next week.  I suspect we'll
> > > need something somewhere between activate_blocked_waiters() ->
> > > scx_do_enqueue_task() to skip enquing of is_blocked tasks when
> > > SCX_OPS_ENQ_BLOCKED isn't set.
> >
> > Your theory looks correct to me. I was also able to reproduce this. I t=
hink the
> > problem is that scx_prepare_task_sched_change() calls sched_proxy_block=
_task(),
> > but the latter has nothing to do when the donor is already off the runq=
ueue
> > behind a sleeping owner.
> >
> > When the owner subsequently wakes, activate_blocked_waiters() unconditi=
onally
> > reactivates the donor while is_blocked is still set. Since this activat=
ion
> > carries ENQUEUE_WAKEUP, sched_ext treats it as a normal wakeup rather t=
han a
> > blocked-donor admission. The donor can therefore enter an scx scheduler=
 that
> > doesn't set SCX_OPS_ENQ_BLOCKED (scx_pair in this case), eventually tri=
ggering
> > the warning in put_prev_task_scx(): unexpected proxy donor without
> > SCX_OPS_ENQ_BLOCKED set.
> >
> > I think we can fix this by checking scx_allow_proxy_exec() in
> > do_activate_blocked_waiter() before reactivating the donor. If the scx =
scheduler
> > doesn't support proxy donors (SCX_OPS_ENQ_BLOCKED not set), the task sh=
ould
> > remain blocked and will be activated normally by the mutex wakeup.
> >
> > While looking at this, I noticed another issue in the same path:
> > activate_blocked_waiters() currently passes ENQUEUE_WAKEUP because the =
generic
> > scheduling classes need wakeup-style enqueue accounting. However, this =
is not a
> > real mutex wakeup, the donor remains blocked and is only being made run=
nable so
> > that it can donate its scheduling context.
> >
> > As a result, even a scheduler that sets SCX_OPS_ENQ_BLOCKED currently r=
eceives
> > this sleeping-owner activation as SCX_ENQ_WAKEUP rather than SCX_ENQ_BL=
OCKED.
> > That's because the existing sched_ext test:
> >
> >   p->is_blocked && !(enq_flags & SCX_ENQ_WAKEUP)
> >
> > doesn't distinguish a genuine mutex wakeup from this proxy activation.
> >
> > Maybe we can address this by adding an internal ENQUEUE_PROXY flag to t=
he
> > sleeping-owner activation. The generic classes will continue to see
> > ENQUEUE_WAKEUP, preserving their accounting behavior, while sched_ext w=
ill use
> > ENQUEUE_PROXY to expose the event to BPF as SCX_ENQ_BLOCKED without
> > SCX_ENQ_WAKEUP. And a genuine mutex wakeup will continue to be reported=
 as
> > SCX_ENQ_WAKEUP. What do you think?
>
> FYI, I've applied your sleeping owner changes + the scx-proxy-exec patch =
series
> with the changes mentioned above here:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-proxy=
-exec-next
>
> Everything looks good on my side so far.

That's awesome! Thank you for your efforts here!  I'll start testing
and playing around with this branch!

Though, looking at your patch stack, I'd rather not make my patches
under review a dependency for your patches.  Peter has not yet put his
laser-eyes upon my series so there's no telling how much rework they
may need (and it does have some subtle parts that I'm sure he'll have
feedback on). So just to allow your current series to be able to move
foward, would it make sense if I added your "sched: Distinguish proxy
activations from wakeups" patch to the end of my series?  It looks
like there's not much interlock on the rest of your changes (though
I've not carefully reviewed the diff from your scx-proxy-exec branch
as they are on different bases), so maybe that would just work and the
rest of your series could move forward?

thanks
-john
