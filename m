Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254214;
	b=gngLSGqINsgLmMEmHKeA7B15cu72zLXYoXoIsokPW7o23fnQTtBbeQHtmVf1SfzUdIZL
	 UrTH3sHqB0MPcGGMatdl6UFggs5idOFrpCkVsH2b6ErTD4uYrgWX4bwLBr+abaut63vX/
	 h5v0Bwbpkuh5Djt8ezFXqEJN6jg7Y/oJyGDMzvl2prJ4OEQ4TZ4e/rxpb8dYwI1iwZmYo
	 +TTTCUfuiYsXIOmHFqQlYcR9f+PJAS0UvfgFn2FEUKKObR7PWB5FnQTd6fytqinFoXyxP
	 RtpwREi8BfPrWrbZwrNx4g/uymJpR63k2V4udTgfArjeYya9zklM5wCCERRXLZGyXJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SXqdVx5FuRoJfcSZ0X9tPlMemMPV7a99j+mnsg7v/74=;
	b=GJozx6IATia5gxgpUow3M2ftJRklqFo3ApUHfHOXi2kxrvA/xYValJkolFBRB1uv2AMI
	 ZYWDpAOiDTX9BcdAeSktE2qOTf32UTTkKRqlVq4B7BslXp5/Z9IriKjz26RfrDWPUT4h5
	 GZiWfxtTl7BFMPxr59YLSD/PYI1EybfE1fYOAsfaGm+ox3KSddz/fM/VtOv7+3w0hcAZ5
	 QUFVpGFDWA9Az7ugnKGFXb/+D15DTp1jIzQBmEhi7uBMKIJIPPTbLMvBS9ZQ01Ej0wD28
	 Fsj5VhVyOu9K1i2dZ8wDEH3/RDPHvs4TkMe7wdkImXpB1A7JEa+j0dIKMKpVIt/b68Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YfFuiDeq;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9A606A33F
	for <sched-ext@lists.linux.dev>; Mon,  9 Nov 2026 19:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2C9A606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YfFuiDeq
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5348aaba5so1333745e9.0
        for <sched-ext@lists.linux.dev>; Mon, 09 Nov 2026 11:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794254212; x=1794859012; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SXqdVx5FuRoJfcSZ0X9tPlMemMPV7a99j+mnsg7v/74=;
        b=YfFuiDeqYsSMeosoYOw4tUdhEFBvIPgwmtAzCxlKY5Zj5AUcfMS82PoccC+6AYndBe
         /5dZBJ0S9PubV+sgEG8Ynwx+Xk/tiqM02veupp+S9OMFd3fP5GV+B4JEklaT8vzUYUb+
         Tyg8cT47GpnyOtDCk6cL3xaXrJtEKTBBF6oNbfIog+EOVSmSzO2vTwJp1C5/x2s3Fjlt
         hJi9FRjtzN5o8SNBugGKYtplItU7wqtnZQyXx1BxgWIcTymsVo1BMv4lvD2tTwa04wbf
         nDG1TwI8loTXs3ye3VMAKooHD76DzqlVTiuD228deOWp3Yo8Aa1bKsvs/gnsmDxngoDp
         /qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254212; x=1794859012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SXqdVx5FuRoJfcSZ0X9tPlMemMPV7a99j+mnsg7v/74=;
        b=k5Th4C9e899PU7jNnrZ2UO7ao66O+VhTqLFY6BKof5x9NpoP/SgiBVooRXFFcJOCo5
         fMb6IT1u1/NY08zTcKGTa9vsjrPjnNnShadjtxbzYOxPZebq7ubluVl0+CNxJzg8Hi9I
         wfA5Ceff/FOGSA6TTgwdJwbeh3lCagJmFP3cFVrNonu0wYYAuuQqNF4K5XLU5jHeEGbd
         frig65EASKyLhalv1o0pImcUKQtm2AE26BmmwTwa7xms1bEZs5yA++rYz5dfpnVwpnQt
         E8QA9JGRbQAVX7Gpq+t5TCxoGO4sIeZnJJTKumek0M5FxjF3/Z4KNIUEM5xzk/3WE4q9
         woBQ==
X-Forwarded-Encrypted: i=1; AL+hErF0bJ2P5cEFuVmMcd3lPjRyd+huMNN840Ke6YXkFLyuQtuK5rm4gsrAfaLabXp5A0eCegCQDYwvBn4=@lists.linux.dev
X-Gm-Message-State: APuU4Z/ujNsLepo/suuJyI4gXraoZCkVvvsZ1XRSvvS/MdeR78IjY17V
	F6gA9rrE3FUWks7gZs65mXLwzGCOhKQwLaXhezy7MlBvWm8NIbEjDdzj
X-Gm-Gg: AYBFou2cDlT/tLtoWHSgsDByUnSqjHfh3UxeG4DDaELlCGV2TS9U0+H/+Fvt3Zb6ngj
	mYgPbouG1fAkmgwlC/UjqCXyudpvIwiPi5R54T7s/tdlXHgTlXyYJjLCQcEKSI4NiVEqbl3p9qU
	8MQ5PwkdT264GXeFHtsU6F7nLZXC6s+rZjHmMo+uXhEKBSjQXRASSa8xDeTZm1DBl4xAFVbmTMr
	lxY4xhWlMOg9zMN7luq0VgXdGqXqapXxIunkSMKD+I19AF3nuUUhNYcJ5KuaEOle/Qe+qHTOXeV
	V1kumP8dENQbnUjkged1tehqCOyQbSanFaDmlvztt3QfKFHc/b4U2mXBXPYymstRiwEWxawghIN
	knXt0sP0v5NeXQp94pfGcqcXcZi+d0YiMAp9wAhyVNs/Yhp6ZGs/zvANU1iGCyMmV13LU+zSvR0
	4IPFhKc0d5dIetqLcK/0ZdFSmAv3rMA2Wr+T/UpAqOpMBC6quWAACLg3d4rUw9zL9FhFFarCeMl
	ulc0Fww9v7CMUxmRKK1G9Q6oJO21qTAFHI66PWCdexczaaLWOA9yn1sq77C8nykYGNqbAKDAkcb
	+TVFSW6KUXBGLt8bUGqmroH9MiEr1jdSnMMqtMMoieY5MJc/aDEGGEc=
X-Received: by 2002:a05:600c:4812:b0:4a2:417:7db5 with SMTP id 5b1f17b1804b1-4ba0233982cmr3105225e9.2.1794254212140;
        Mon, 09 Nov 2026 11:56:52 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a6b0sm10595085e9.5.2026.11.09.11.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:56:51 -0800 (PST)
Date: Mon, 9 Nov 2026 22:56:47 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting
 CPU
Message-ID: <avIh4MZjVyQuF6Yo@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-7-vincent.guittot@linaro.org>
 <au7SabL5pfbsApyB@scheduler.schedules>
 <CAKfTPtBfXOcAd=5RkYepRn15Hg=id9FQ3jh1tQoewOtUSrsjHw@mail.gmail.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBfXOcAd=5RkYepRn15Hg=id9FQ3jh1tQoewOtUSrsjHw@mail.gmail.com>

On Mon, Nov 09, 2026 at 04:55:23PM +0100, Vincent Guittot wrote:
> On Sat, 7 Nov 2026 at 09:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> >
> >
> > Hi Vincent,
> >
> >
> > Sashiko reviewed this one so I'll just put here my own concerns instead
> > of repeating.
> 
> Regarding sashiko's feedback about cpu state ranking, I chose this
> ranking on purpose.
> For !SMT :
> - 7 CPU is idle and fully fits (i.e. return immediately)
> - 6 CPU fully fits and is not idle but we can preempt current because
> of slice so the task will run on the best CPU immediately
> - 5 CPU is idle but doesn't fit uclamp min. On such a CPU, the task
> can easily miss its deadline
> - 4 CPU is idle but doesn't fit at all. This is even worse
> 
> For SMT
> - 7:CPU is idle and fully fits (i.e. return immediately)
> - 6: CPU is busy and fully fits. Although CPU is not idle, task can
> preempt current because of its slice and run immediately on a CPU.
> This is similar to an idle CPU (and maybe even better). While writing
> this, I realize that I should probably check the lag too
> - 5: CPU is idle but doesn't fit uclamp min. On such a CPU, the task
> can easily miss its deadline
> - 4: CPU is idle but doesn't fit at all. This is even worse than -5
> - 3: CPU is idle and fits for task but sibling is busy
> - 2: CPU and sibling are busy and fits for task and like-6 task will
> run immediately
> - 1: CPU is idle and doesn't fit uclamp and sibling is busy
>   0: CPU is idle but doesn't fit at all, and sibling is busy.
> 
> Note that with the push mecanism we could look for another CPU for the
> task that will be preempted
> 

Thanks for the great explanation! My only concern is on 6 and 2, as I
explained in my first message, below.

Sashiko also pointed out other concerns, it would be good to check them
all out.

> >
> >
> > Look here:
> >
> > CPU1: CPU2:
> > FA    RA
> >       FC
> >
> > CPU2 has 1 RT and 1 Fair tasks named RA and FC.
> > Let's say RA is running on CPU2 and FC's slice is 10 ms.
> >
> > And let's say FA has 8 ms slice, and a fair task named TC is waking up
> > with 9 ms slice:
> >
> > * We look to CPU1, 9 < 8 is false so we return false
> >
> > * We look to CPU2, 9 < 10 is true so we return it.
> >
> > But the problem is, CPU2 has a RT task running and we are going to
> > compete with the RT task. In that case it can be worse than CPU1.
> >


Thanks,

Kayra
