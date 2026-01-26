Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1333C514
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437223; cv=none; b=L2y37zRijzW/h4ZXP/zDzDnpKQ503Q/oPV8h7iazAz6rf2yCnlTC2qzedWCubcITTb9dl+2yl0loeGgVCeh75v31v5E3Vw8t6/9gePbGobDiyEGg1DMQ96Cq9jmPMOefrR0bq3BpbabFBAJEXOPncGzzK/TBr9nRB9lq9TzRkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437223; c=relaxed/simple;
	bh=qZlVdTm3KcK/5yf4RyWYsKL5cNhfVDEKnyS/nsYS9ME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfSdYMi83MN4eRNo42kxxPQ5DYMb9bQO/ticHBxsISxAfmabJZdlRlEhxZ/XxkVia3p69w78w6hQaMkEAFUpbG+uBOiqPezGWstbstjIrdpK189DODEXz2TbGsAp9VNx8gpbt3xt4mjLe84QNKMm6B0ihDOrnekmTNt7Ek6U1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkBnhiE/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkBnhiE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769437220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qZlVdTm3KcK/5yf4RyWYsKL5cNhfVDEKnyS/nsYS9ME=;
	b=TkBnhiE/cWG06afvuNkXiG7e8wAe5X+DKeo2dyu6Kga6xTRCCERGVf/ESURt2ADnPCX8w2
	U9OKEN1OdxBELSg+BhYq+I2N0bzLB2CNqdl+HhA+EkIndpjqlYxfl4H3nfnDR9r7Oq2n+7
	v6hBLJlMIQF0rsXWmamarMUpUmY+CJM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-kCTcrCwCNxm3tsVRd9qkWA-1; Mon, 26 Jan 2026 09:20:16 -0500
X-MC-Unique: kCTcrCwCNxm3tsVRd9qkWA-1
X-Mimecast-MFC-AGG-ID: kCTcrCwCNxm3tsVRd9qkWA_1769437215
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42fdbba545fso4130237f8f.0
        for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 06:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769437215; x=1770042015;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fG1OxMornZ72vrWdkK/L/931jxhh8ttLn2tvmGHTing=;
        b=Wt5Bdd8OE/P1p/Zec7AoJStZqyb0dushI8lCYUN8gfR/73ENqQcH8h7SW85Ni3qmcP
         KzKP/EG0RnGP2AY5U/Sqx9sYd1Oc5lMXq+xBHDksdgJ2t+rnNHZIsuQ5FaME4gesMCss
         0SgrvUmqTIf6VrUqElpXAZhaQOLxHLJ5yEIcmbG+ceexi44eskbC0GVOnzuk8g/W7A2v
         6dfuoLixN698hnEqBYjIoqqVk+xBC6vGd1KYfDLITj14M1FDpFn9w0rNF8fGbDPI+vAN
         8U5xgBq+0Mhk86Y8yNrovwjExTCsN7jeUCyE083Ig3dPP4UhCIHvlf2Y52UtLUEGdm0s
         EfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqzjrkQEOi1lv45jk3iHO6uKk4noKFeTk/LDDS2wAE/+chxOGc4nQ0U9VktKgf2hBs950Rwlwk9W4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwjbLqlfvZYIme8JiBuo9FAsaW1IETlPGmFVmKAFa87TUEM9EET
	NyWTvBfYPv1RjVn3Y/G7AzUaqfrG1SxruS9qLIFxyYSXNocxh4CxFbe58ti7bLchwQnzZU31Ci0
	TL8LG2t35qy+kAj6+L5VVcQ5hSnBMCReKa/h8vYc6N7K5wQluJvPHhWyh9igyAw==
X-Gm-Gg: AZuq6aJshavckaTFt53Vas0Yny5Skl8O+N27640wrtAvalU/bLiC9Bzjc7juy7+4kma
	2tmjYezouSesjDTTEe5Nk/v39VYZUr8T79tNy6TgLNB1QiKtgRxksTEtJFtkDDSCcs8T5TLPyZN
	rvQkc9weDAQ1t1mr6sMELnQAvx5o/I7F7I2g4IBpD06CXG+YD0Fxz8vArQ+Gne2oQ1JIyEN/ZcJ
	27zCJtBSYdd5L9nTCG8yF7GF7djfvUJLHd4S6+4A774Xqoc/+YOqVbflLEppvf/KcUOVUB5WR1z
	OmUxVVLKeiGsF+Bmh8uhiCkYNcx0pU3chGcGWk8cqHoh+tKw7gHG4dnoGNbE6U/4BQC05HERE7S
	GjzzkzOiKZZDVChD//8V+Zp3xllsygTqeIKfj+9Fe/IX1DcAAhydo+uR31rrdTqrfWiPz8o++7f
	T9Y3W94dlr
X-Received: by 2002:a05:6000:ed1:b0:435:a43b:2dde with SMTP id ffacd0b85a97d-435c9b1af15mr6839218f8f.15.1769437215296;
        Mon, 26 Jan 2026 06:20:15 -0800 (PST)
X-Received: by 2002:a05:6000:ed1:b0:435:a43b:2dde with SMTP id ffacd0b85a97d-435c9b1af15mr6839182f8f.15.1769437214786;
        Mon, 26 Jan 2026 06:20:14 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7c8efsm30933323f8f.42.2026.01.26.06.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 06:20:14 -0800 (PST)
Message-ID: <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com>
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
From: Gabriele Monaco <gmonaco@redhat.com>
To: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot	 <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman	
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tejun Heo	
 <tj@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, David Vernet	
 <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Daniel Hodges	
 <hodgesd@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 26 Jan 2026 15:20:12 +0100
In-Reply-To: <20260123161645.2181752-1-arighi@nvidia.com>
References: <20260123161645.2181752-1-arighi@nvidia.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EKrjD68gT_q2_0yw4LWGtyszIZ-1vAYItUbqpCXYWkA_1769437215
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-01-23 at 17:16 +0100, Andrea Righi wrote:
> dl_server_stop() can leave a deadline server in an inconsistent internal
> state across stop/start transitions, causing it to bypass its required
> deferral phase when restarted. This breaks the scheduler invariant that
> a restarted server must re-establish eligibility before being allowed to
> execute.
>=20
> When the server is stopped (e.g., because the associated task blocks),
> it's expected to transition back to an inactive, initial state. However,
> dl_server_stop() does not fully reset the execution state. As a result,
> the server can be logically inactive while still appearing as if it was
> still running.
>=20
> When the server is restarted via dl_server_start(), the following
> sequence occurs:
> =C2=A0 1. dl_server_start() calls enqueue_dl_entity(ENQUEUE_WAKEUP),
> =C2=A0 2. enqueue_dl_entity() calls update_dl_entity(),
> =C2=A0 3. update_dl_entity() checks (!dl_se->dl_defer_running) to decide
> =C2=A0=C2=A0=C2=A0=C2=A0 whether to arm the deferral mechanism,
> =C2=A0 4. because dl_defer_running is stale, the check fails,
> =C2=A0 5. dl_defer_armed and dl_throttled are not set,
> =C2=A0 6. enqueue_dl_entity() skips start_dl_timer(), because
> =C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D=3D 0,
> =C2=A0 7. the server is enqueued via __enqueue_dl_entity(),
> =C2=A0 8. the scheduler picks the server to run,
> =C2=A0 9. update_curr_dl_se() detects that the server has exhausted its
> =C2=A0=C2=A0=C2=A0=C2=A0 runtime (or has negative runtime), as it wasn't =
properly
> =C2=A0=C2=A0=C2=A0=C2=A0 replenished/deferred,
> =C2=A010. the server is throttled (dl_throttled set to 1) and dequeued,
> =C2=A011. the server repeatedly cycles through wakeup and throttling,
> =C2=A0=C2=A0=C2=A0=C2=A0 effectively receiving no usable CPU bandwidth.

Hello,

I remember wondering why defer_running was kept after stop and Peter sugges=
ted
it's to avoid penalising tasks with short sleeps. [1]

Clearing defer_running on stop is in fact removing the edge from A:init to
D:running , isn't it? The server should be able to start as running and not=
 only
deferred (dl_defer_armed and dl_throttled set).

In the sequence you described above, I wonder why the enqueue is never
replenishing. As far as I understand the runtime should remain <=3D 0 only =
as long
as the enqueue occurs before the deadline, after that it should simply repl=
enish
a new period (pushing deadline and restoring runtime).

What am I missing here?

Thanks,
Gabriele

[1] -
https://lore.kernel.org/lkml/20251111111716.GL278048@noisy.programming.kick=
s-ass.net

>=20
> This results in starvation of the tasks serviced by the deadline server
> in the presence of competing RT workloads.
>=20
> This issue can be confirmed adding debugging traces, which show that the
> server skips the deferral timer and is immediately throttled upon
> execution with negative runtime:
>=20
> =C2=A0DEBUG: dl_server_start: dl_defer_running=3D1 active=3D0
> =C2=A0DEBUG: enqueue_dl_entity: flags=3D1 dl_throttled=3D0 dl_defer=3D1
> =C2=A0DEBUG: update_dl_entity: dl_defer_running=3D1
> =C2=A0DEBUG: enqueue_dl_entity: SKIPPING start_dl_timer! dl_throttled=3D0
> =C2=A0...
> =C2=A0DEBUG: update_curr_dl_se: THROTTLED runtime=3D-954758
>=20
> Fix this by properly resetting dl_defer_running in dl_server_stop(),
> ensuring the server correctly enters the defer phase upon restart.
>=20
> This issue is quite difficult to observe when only the fair server
> is present, as the required stop/start patterns are relatively rare.
> However, it becomes easier to trigger with an additional deadline server
> with more frequent server lifecycle transitions (such as a sched_ext
> deadline server).
>=20
> This change is a prerequisite for introducing a sched_ext deadline
> server, as it ensures correct and predictable behavior across server
> stop/start cycles.
>=20
> Link: https://lore.kernel.org/all/aXEMat4IoNnGYgxw@gpd4/
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
> Changes in v2:
> =C2=A0- Update state machine documentation
> =C2=A0- Link to v1:
> https://lore.kernel.org/all/20260122140833.1655020-1-arighi@nvidia.com/
>=20
> =C2=A0kernel/sched/deadline.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c509f2e7d69de..e42867061ea77 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1615,7 +1615,7 @@ void dl_server_update(struct sched_dl_entity *dl_se=
, s64
> delta_exec)
> =C2=A0 *=C2=A0=C2=A0 dl_server_active =3D 0
> =C2=A0 *=C2=A0=C2=A0 dl_throttled =3D 0
> =C2=A0 *=C2=A0=C2=A0 dl_defer_armed =3D 0
> - *=C2=A0=C2=A0 dl_defer_running =3D 0/1
> + *=C2=A0=C2=A0 dl_defer_running =3D 0
> =C2=A0 *=C2=A0=C2=A0 dl_defer_idle =3D 0
> =C2=A0 *
> =C2=A0 * [B] - zero_laxity-wait
> @@ -1704,6 +1704,7 @@ void dl_server_update(struct sched_dl_entity *dl_se=
, s64
> delta_exec)
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hrtimer_try_to_cancel();
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_armed =3D 0;
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_running =3D 0;
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_server_active =3D 0;
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // [A]
> =C2=A0 *=C2=A0=C2=A0 return p;
> @@ -1813,6 +1814,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
> =C2=A0=09hrtimer_try_to_cancel(&dl_se->dl_timer);
> =C2=A0=09dl_se->dl_defer_armed =3D 0;
> =C2=A0=09dl_se->dl_throttled =3D 0;
> +=09dl_se->dl_defer_running =3D 0;
> =C2=A0=09dl_se->dl_defer_idle =3D 0;
> =C2=A0=09dl_se->dl_server_active =3D 0;
> =C2=A0}

