Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC756346FC3
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446623; cv=none; b=AXn95i8jeBwXtuOaBDaIE1gZKvcACu5eT45uIaeyOH8A9ukmH2gTWO3H9ijP5gSgWeziu7CGoJomXEeh0uHWbDYG482ocfpFzuwo6+qixr2+L7EprymkNgEJ/LbDXxWv2/rLV1ZrIb1WJ3N35NJYjHbP1TIPGNsfAOOb6/hVCz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446623; c=relaxed/simple;
	bh=Sa0oha1nXXLB0rTFNx9x5A1xRvOnbmpCUxuZ823XGbY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iI4Vc6QJ1XJqpGrsmvVaN4fjmZe+vsLz0iWEWgJkalhDw0L3SS2wWj+/iQs2gtcMQ1rZWsTxCP8tpEspxS8H95sawhhPRaVmWAd+avu0AVqQOjkPr67toeHWg4WfDIMK0lDt1nCtAjZ5o+cltpCdA0xEJC8bS9xNMAk+rYKDYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZNPQj6h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZNPQj6h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769446620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sa0oha1nXXLB0rTFNx9x5A1xRvOnbmpCUxuZ823XGbY=;
	b=AZNPQj6hwWFpv1oFzu/OSoOlYf/5xb9KTsXe0hVOnobT5s5dBgyQEi0y57vxOoSTCEDylR
	4FlnNb8wida/ycWBNNTikk6JrK2NAfERhLSqtn1EsLrnUf0rU5VoG8bXNOUsNFOOAxD/DN
	FSHSjnMX+BI7V6vCAT6wUKquoztK6a8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-5zMJFzEcN7u8iXFeTNbBIw-1; Mon, 26 Jan 2026 11:56:59 -0500
X-MC-Unique: 5zMJFzEcN7u8iXFeTNbBIw-1
X-Mimecast-MFC-AGG-ID: 5zMJFzEcN7u8iXFeTNbBIw_1769446619
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-502a13e3e55so188031501cf.3
        for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 08:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769446619; x=1770051419;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sa0oha1nXXLB0rTFNx9x5A1xRvOnbmpCUxuZ823XGbY=;
        b=mMGeakP1NByfsCbNSd9Gc0gnIJ7BzF6i8Ou+pTlLU7Rg/Ay8tcHoNdUcMwbso/Hant
         Q0ydqiP0cAMJzgExcH4uRYLQ7pvrGv60tnOLuBh0YOLZxT/+UvZpKa94eE28vc8DjMJd
         58OfD0lSS3B/sZJY8pZp6gWwfxEgxbnVTmMl4fOFXrEhTDyTANIqVAdIQ/7V3aZgHUSw
         okpeALFbZAAA5IiZgjrMDPNPIl7L6FE/tDWZg7stLR+f4fKWWHf8/3Fwhd1SlsTFsQAY
         X9QmvqbPc03EuXexI8kdC5LPFo6J+QwjXzKj/D8PUagSSb5C0gw175yxNyQa8T74ARP7
         9UgA==
X-Forwarded-Encrypted: i=1; AJvYcCWA4pif2HEuBrO45gIxmcGFjVqKR/+uvd1NVXwmcoIu8zZbB10/z06npBV+ldZaeQP7hSlZvCtY6tY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx56FoxCvR1JuL9GzTKWY93vB4vOgqhydOp0BmTqgiJbCtmEg6d
	YJ/ifVcHQJl6bqnNwJLOvpGGcasnDss/B/n5izao6uVUTvhnEaL3ZSLVN+aX1p0Ij9mAsfFqfQ1
	kJLdpGRPiznimAesG5KDmL35NTEyMHX6gc+qfCQkPhWMf4vsp7LEKcw4A1MNnCg==
X-Gm-Gg: AZuq6aJ6kLar1Llv1uWWYX6bZKnJdj5m2DIhgHxS8prnxjZ0v19XtOYyK6gV6lWx/+P
	HOlOwxwoNwq2k7HCqVEJzTggNFHO4sGkrHx/ZdDVfAD4rCrIl7/M7UuMYyKCYD9nrMDG7KTCW/B
	H20eCDrR1O+Xeu/tZIUkxrNa12Cbk9+ljSsLRCM5hNcp1xRpeZbkDRMraxyRfd+9Nm8DbRqvwbD
	1HO0cy0myq6tyrdah0L8O4R6ab3Qxq3eYO1OEcOUYrQPUrdu+DFK2F6Oj4gUxsI+W+AnwOONR4g
	BfJe2OpaRVfEva5WPVBxwEda4TcugQTfNVxzZedXq9txCtOXYX5r3E2P0G8NeBgOJxPyH9dcjYi
	MwTEZwg==
X-Received: by 2002:ac8:5716:0:b0:4ed:b5d8:a192 with SMTP id d75a77b69052e-50314c688a7mr73753861cf.38.1769446618838;
        Mon, 26 Jan 2026 08:56:58 -0800 (PST)
X-Received: by 2002:ac8:5716:0:b0:4ed:b5d8:a192 with SMTP id d75a77b69052e-50314c688a7mr73753551cf.38.1769446618458;
        Mon, 26 Jan 2026 08:56:58 -0800 (PST)
Received: from [127.0.0.1] ([195.174.134.45])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7f86137sm85662341cf.23.2026.01.26.08.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 08:56:58 -0800 (PST)
Date: Mon, 26 Jan 2026 16:56:52 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
In-Reply-To: <aXeWnzI3ymUSm3Cu@gpd4>
References: <20260123161645.2181752-1-arighi@nvidia.com> <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com> <aXeWnzI3ymUSm3Cu@gpd4>
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Correlation-ID: <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n7JCt8ks1fbm8623Tpi9XfzZjQ45JKt7qm-ytcQaPuc_1769446619
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2026-01-26T16:30:45Z Andrea Righi <arighi@nvidia.com>:

> Hi Gabriele,
>
> On Mon, Jan 26, 2026 at 03:20:12PM +0100, Gabriele Monaco wrote:

>> In the sequence you described above, I wonder why the enqueue is never
>> replenishing. As far as I understand the runtime should remain <=3D 0 on=
ly as long
>> as the enqueue occurs before the deadline, after that it should simply r=
eplenish
>> a new period (pushing deadline and restoring runtime).
>>
>> What am I missing here?
>
> Replenishment is not triggered directly by enqueueing, but by the
> deferral/replenishment timer. In this case the timer is never armed: stal=
e
> dl_defer_running makes the enqueue path believe the server is already in
> the running phase, which suppresses deferral arming, causing
> start_dl_timer() to be skipped.
>

Hi Andrea,

thanks for the clarification, but I think I observed the enqueue/dl_server_=
start replenishing a new period when running.

Something like:
dl_server_start()
=C2=A0 enqueue_dl_entity(ENQUEUE_WAKEUP)
=C2=A0=C2=A0=C2=A0 update_dl_entity()
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replenish_dl_new_period()

should happen if the deadline is in the past, unless I'm missing some condi=
tion down the road.

Still if it starts before the deadline, the server is going to get throttle=
d as you observed, and perhaps since in your tests the CPU isn't idle, we d=
on't stop the server after that dequeue and then we never replenish after t=
he deadline (because we never start and as you mentioned, the timer is not =
armed).

Can this be what you're observing?

Thanks,
Gabriele


> Thanks,
> -Andrea
>
>>
>> Thanks,
>> Gabriele
>>
>> [1] -
>> https://lore.kernel.org/lkml/20251111111716.GL278048@noisy.programming.k=
icks-ass.net
>>
>>>
>>> This results in starvation of the tasks serviced by the deadline server
>>> in the presence of competing RT workloads.
>>>
>>> This issue can be confirmed adding debugging traces, which show that th=
e
>>> server skips the deferral timer and is immediately throttled upon
>>> execution with negative runtime:
>>>
>>> =C2=A0DEBUG: dl_server_start: dl_defer_running=3D1 active=3D0
>>> =C2=A0DEBUG: enqueue_dl_entity: flags=3D1 dl_throttled=3D0 dl_defer=3D1
>>> =C2=A0DEBUG: update_dl_entity: dl_defer_running=3D1
>>> =C2=A0DEBUG: enqueue_dl_entity: SKIPPING start_dl_timer! dl_throttled=
=3D0
>>> =C2=A0...
>>> =C2=A0DEBUG: update_curr_dl_se: THROTTLED runtime=3D-954758
>>>
>>> Fix this by properly resetting dl_defer_running in dl_server_stop(),
>>> ensuring the server correctly enters the defer phase upon restart.
>>>
>>> This issue is quite difficult to observe when only the fair server
>>> is present, as the required stop/start patterns are relatively rare.
>>> However, it becomes easier to trigger with an additional deadline serve=
r
>>> with more frequent server lifecycle transitions (such as a sched_ext
>>> deadline server).
>>>
>>> This change is a prerequisite for introducing a sched_ext deadline
>>> server, as it ensures correct and predictable behavior across server
>>> stop/start cycles.
>>>
>>> Link: https://lore.kernel.org/all/aXEMat4IoNnGYgxw@gpd4/
>>> Signed-off-by: Andrea Righi <arighi@nvidia.com>
>>> ---
>>> Changes in v2:
>>> =C2=A0- Update state machine documentation
>>> =C2=A0- Link to v1:
>>> https://lore.kernel.org/all/20260122140833.1655020-1-arighi@nvidia.com/
>>>
>>> =C2=A0kernel/sched/deadline.c | 4 +++-
>>> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>>> index c509f2e7d69de..e42867061ea77 100644
>>> --- a/kernel/sched/deadline.c
>>> +++ b/kernel/sched/deadline.c
>>> @@ -1615,7 +1615,7 @@ void dl_server_update(struct sched_dl_entity *dl_=
se, s64
>>> delta_exec)
>>> =C2=A0 *=C2=A0=C2=A0 dl_server_active =3D 0
>>> =C2=A0 *=C2=A0=C2=A0 dl_throttled =3D 0
>>> =C2=A0 *=C2=A0=C2=A0 dl_defer_armed =3D 0
>>> - *=C2=A0=C2=A0 dl_defer_running =3D 0/1
>>> + *=C2=A0=C2=A0 dl_defer_running =3D 0
>>> =C2=A0 *=C2=A0=C2=A0 dl_defer_idle =3D 0
>>> =C2=A0 *
>>> =C2=A0 * [B] - zero_laxity-wait
>>> @@ -1704,6 +1704,7 @@ void dl_server_update(struct sched_dl_entity *dl_=
se, s64
>>> delta_exec)
>>> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hrtimer_try_to_cancel();
>>> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_armed =3D 0;
>>> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 0;
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_running =3D 0;
>>> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_server_active =3D 0;
>>> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // [A]
>>> =C2=A0 *=C2=A0=C2=A0 return p;
>>> @@ -1813,6 +1814,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se=
)
>>> =C2=A0=C2=A0=C2=A0 hrtimer_try_to_cancel(&dl_se->dl_timer);
>>> =C2=A0=C2=A0=C2=A0 dl_se->dl_defer_armed =3D 0;
>>> =C2=A0=C2=A0=C2=A0 dl_se->dl_throttled =3D 0;
>>> +=C2=A0=C2=A0 dl_se->dl_defer_running =3D 0;
>>> =C2=A0=C2=A0=C2=A0 dl_se->dl_defer_idle =3D 0;
>>> =C2=A0=C2=A0=C2=A0 dl_se->dl_server_active =3D 0;
>>> =C2=A0}
>>

