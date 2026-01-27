Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6632E62B7
	for <sched-ext@lists.linux.dev>; Tue, 27 Jan 2026 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529653; cv=none; b=jf+jv4lPhBeMdoxHHXmGnxh2Q96yNHb/+viP0P2X9nVGgwl58+D3NmE0XGeQZBGgMn1n7Hct+nrGjtk+Y5jx2eToHOnTj9d1yvFryRPI2DydjlxCrXzzj5sv6lajT9qwogkNoFp4SNPZbZGag6zpJAhXn9DMdw9zniN82SdS9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529653; c=relaxed/simple;
	bh=bCEyxMDbMXjcD5Q4ndMCEOt8U5L9TJj6jcgUsqmd2D8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RHZokGiRGD2XxSkpYYVRCmBBeX0DOl9mL9dsUgXiAzCwxxttzZWOp8Q8vP1P/IOk7ETr8SKpIMpG1wvhO2qGrXfrS8vAPRy6omId3oDCDyRn6vtI2O2acyVrZCoEooSTcTCE/Kfwe0rRBw5t0xAJ3biG4xwkuzFWqCrCba9vZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvWiWn7s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvWiWn7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769529647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCEyxMDbMXjcD5Q4ndMCEOt8U5L9TJj6jcgUsqmd2D8=;
	b=dvWiWn7sAoQmbDZCE1zRY7HchTWsCpLK6UkmJ+Tj4DkWtuphgH9bU2VO0TKe0rz7ZnOP/x
	G+/u/kf1/Me+/kqIPj/kr/2jPhHteCTDmAEhIlEa/t9rQXY+M9cnt59At/hyoDWBO7rzvy
	Gaew62tuWd03dHvRW1SttUju1QFLoGM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-ajyBkrZSPmyNL_hDDd1lOg-1; Tue, 27 Jan 2026 11:00:36 -0500
X-MC-Unique: ajyBkrZSPmyNL_hDDd1lOg-1
X-Mimecast-MFC-AGG-ID: ajyBkrZSPmyNL_hDDd1lOg_1769529635
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8773bf3ddbso501411866b.1
        for <sched-ext@lists.linux.dev>; Tue, 27 Jan 2026 08:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529635; x=1770134435;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCEyxMDbMXjcD5Q4ndMCEOt8U5L9TJj6jcgUsqmd2D8=;
        b=EOlS6sVEOb2x9vLMghfirkPIcLk2ZXXBaTr01zxkzO4WB8x/M96FbxTgk3jq9FPplv
         NwXRTHndLkzZV/PQ0OvxgltOZ7QoxUG6A5Wq58IN4jUPH25iGufOjKBzTooajiyrCIXQ
         RpS76TUI8GhBwVETkpo4/QdBd665F3fHufkX3XekbcF+Yr1iuoLh8jCG2SvV3CqdDPAZ
         a1oUd27+ziLRu9CZ2kk9IG+Is/g/Yz5n7FOXAPfgJiRxmkOnB10f4MndE5d8LRqfb0Ys
         KN4dnoMwqQPuY7qBlq+me/CT0S0fQddn1wVkDy+Rp3OuoHwEORZiEDg1uBzZEbqUeHv3
         b/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXJ/voCJFkzUmYp6oanJqAy7lsdZjPK/UKjIqeQPcjP3ylyEU+lxY3h5hPmcYABXj7cwWFnE8P6WeQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyELkAMDLARQVgApkHmCD8iVzBTvscON4LmqakzjAv3DqYHAdrx
	jsCdFC5cnpnxuoYd7L4VQ0vZjoHh1AdofOHMSbb57/g5HaZeXT/ZSGjRsL4m4I0HtMVuajgsoWX
	FVKvnVoofM5haGzJqR12Z3JyjB54rdb2+OJr9S9QiXHwkecPXzBQ0v2E2TfmoAA==
X-Gm-Gg: AZuq6aKJyhGzNQc1/ptqklGE/taeY4VQ0byCyBg/lqvPWaX5VsRRESKsLfxDZaxuZf/
	T4HO78r4SKadOQwt5cwe2ofTVnMV0oZoGrcVA8Wu6VP5ccwpJQx+l27UvWrN72PFcbUKDcJnXmg
	kEzDqYW2BeqDO5enVCh1lauRXC9syoAAfZ5PNMycY5PUy33RY4SfWmGQz2smSEDrfgGt2+0UkDF
	s3NcH8lunuGBhQAPc9AQGgRau1dn77qhKmlAv+dIMw3nSd9sbuPNYcydgKqLckZuYnnRwonhjdl
	whsozYpAuIYdOpUslO4D8FR4DnfV4iUp4qnWtj/581M7jeGQn1pwAUJzYrOJyHKeX5JDah0cDLj
	2yJ43ow==
X-Received: by 2002:a17:906:c108:b0:b80:751:ee62 with SMTP id a640c23a62f3a-b8dab3048a2mr175431366b.14.1769529634934;
        Tue, 27 Jan 2026 08:00:34 -0800 (PST)
X-Received: by 2002:a17:906:c108:b0:b80:751:ee62 with SMTP id a640c23a62f3a-b8dab3048a2mr175427966b.14.1769529634427;
        Tue, 27 Jan 2026 08:00:34 -0800 (PST)
Received: from [127.0.0.1] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b445747sm802335766b.30.2026.01.27.08.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 08:00:34 -0800 (PST)
Date: Tue, 27 Jan 2026 16:00:31 +0000
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
Message-ID: <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
In-Reply-To: <aXjJG-72XEqvaVtL@gpd4>
References: <20260123161645.2181752-1-arighi@nvidia.com> <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com> <aXeWnzI3ymUSm3Cu@gpd4> <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com> <aXfcGynN92kyw5Co@gpd4> <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com> <aXjJG-72XEqvaVtL@gpd4>
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Correlation-ID: <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w8ul_vig-FuVl8xXDZIXc5Fb_GVsXYrpe8ZsiWZTR0Y_1769529635
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2026-01-27T14:18:29Z Andrea Righi <arighi@nvidia.com>:
> I think my case should work also doing something like this (I'll run some
> tests later to double check):
>
> =C2=A0=C2=A0=C2=A0 if (dl_se->runtime <=3D 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_se->dl_defer_running =3D 0;
>
> In this way:
> - short sleep + remaining runtime > 0
> =C2=A0=C2=A0 - dl_defer_running stays set
> =C2=A0=C2=A0 - restart can go A->D directly
> =C2=A0=C2=A0 - no extra defer / zero-laxity penalty
>
> - stop with exhausted (or negative) runtime
> =C2=A0=C2=A0 - dl_defer_running is cleared
> =C2=A0=C2=A0 - restart must re-establish eligibility
> =C2=A0=C2=A0 - deferral / timer is armed again
> =C2=A0=C2=A0 - no stale "already running" server

Yeah that looks like the neatest to me.
Fair tasks are a bit more penalised than now but won't be if they really sl=
eep before consuming the runtime, which I think was the whole point of this=
 logic.

> However, I think the right assumption should be that both runtime **and**
> deadline are still coherent, so we should probably do something like this
> to be fully correct:
>
> =C2=A0=C2=A0=C2=A0 if (dl_se->runtime <=3D 0 ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_time_before(dl_se->deadline=
, rq_clock(dl_se->rq)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_se->dl_defer_running =3D 0;
>
> This makes the stop path slightly more complex, so I'm not sure whether
> it's preferable to go in this direction or just unconditionally clearing
> dl_defer_running, which is simpler and more explicit from a state-machine
> point of view.

I think it's trickier than that. The state machine is coherent as long as t=
he the server is restarted after the deadline, no matter when it was stoppe=
d.

This check should probably be done at some point during dl_server_start().
But yeah it's probably an overkill.

Thanks,
Gabriele

