Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C5271471
	for <sched-ext@lists.linux.dev>; Sat, 18 Jul 2026 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344307; cv=pass; b=AVGi/iSKOf4OWp4EPYOMQ5TWn/W++PBGs197hDlIDeWvXBjSBC+zUyk9ZfzdiXD9ID3BlY0QKPvRUXQCl7QWeqmKHYG+Jr1Fl2bBrcZVSqah2feZnpjIkmEniqZ6xaYSrJ/fXOmz2MEVKrA43zE521lX42g2BcMPJNtvhWIwP6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344307; c=relaxed/simple;
	bh=EA80wkaUgFJ9Jk1LU1ZYw2h/se2dBHEHv4C6Wa69fiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQNB6auk6KEuWA6DrSUh78zRxSBnAg6DSIVUHyCKlCsXa/rE+K2Dd5iY+51bX52xyLgX6BOkKBZBAl0V1bTXN1cblVpcxd2Q6Fd//SE/tH/t78/B1xn8TqtbeKGZX9E+a7+CM4+dORxXvg1k3IjwdYG7lqd88arU/7SKdXA/KZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOtT6wAN; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOtT6wAN"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso5544947a91.3
        for <sched-ext@lists.linux.dev>; Fri, 17 Jul 2026 20:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784344306; cv=none;
        d=google.com; s=arc-20260327;
        b=irs24igJdKZwnBP1Cnu6iDU7dQcBtaZnvLIzhzYl1Xh3HjhrQGczgCo1pADoK8nXIG
         PCRws4e8uG511aKHyPwAR9+z4VfU4K5RklOwFh9TMgHVBxEfxxoI2y879dQ3Xwilq/7E
         xskS/Gnd9D/a4TkEnxl3KkAqdfFYT5xIdeoP4/L5b7R86Om/0YU9Vpk0rE+7myddLt60
         KzPZucQwJ3a+FaNzIku0lONoTclI5Zu/k5M4/AgFBQ5etQh93OLsTKlEL1pElY364bSH
         FCIsqLMq4xWiqcXxgwFxI7gZHdBQsi2MZbHd0voL96rkCdiRE5Dhz2MOMJd1c6JmvOGe
         NcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EA80wkaUgFJ9Jk1LU1ZYw2h/se2dBHEHv4C6Wa69fiY=;
        fh=uBvDwo8ENAIlWkgh5C9LYY5WUb2Xus4zWhAApv5gGko=;
        b=VAR/orgrWEsEK8wwkRTRf6eyun+jLhYgXguV6fX9Ut0jfX0MS0F/I1mMDLMs3MrHdR
         vI5gSO4kZpv15RN1PfWg8UA/dfEpzOEr9o1pv8hGz7YJd4l3O4ijefHYMFAflnqTitJb
         +h88jgbsM/n84iHGPPAQi3NPFRg65drvTka4ev3aaL2aobeQkHfITnsF8DU8Bm++p7qj
         DFIBRgQJPGsJDauakXxIA0NFBAsU2BUR7a8GuNrNAdzMK1kMxEHMtBHcjjTAk6mrGNmw
         r7erL9hHQ6e28bb1d9Q0xROuJAmhfmjBPuODr0t01jOdvJqDV3EYNBVZnIwiXzz/QzZM
         Vvjg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784344305; x=1784949105; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EA80wkaUgFJ9Jk1LU1ZYw2h/se2dBHEHv4C6Wa69fiY=;
        b=MOtT6wANSZYh+/ZPAJOQrUjV6s8oCdBSfif1YDQAg6tSGKnFwAFGlYTWAmjTHM2BFa
         /wzy6yFpa3cWtirggh4lwz3qcKdWdCIR4y1X6QXdrth0Nu/pTfdYwtKU69Uv/M+6YbV3
         XDN44E3RK6C2hJsCQCO9AGkwBZZ3K90GwvfStkn1TIzkZUWR8kdD6M8zRasYuFpFXIkd
         pwxxeR9M3UmGBJjrxIrETApYmyr/40olZqLbg0fuJcTvooDdIzuMO4qgxPJMAzDs6cxa
         B/JcvpFW9xhAbfhmgDUBdtHlDPiwsp8zPvKdm6oGbAMRUB7vmNwOMA33PHB0nEjNy6Vh
         P2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784344306; x=1784949106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EA80wkaUgFJ9Jk1LU1ZYw2h/se2dBHEHv4C6Wa69fiY=;
        b=qWF2mw6EQgJ7VqVSxOEy3h87KSTxH7VOWbLN/L+lklGgZmPlc+xxWED83sARZqFSyh
         FCOoAt0lvAH8S5c2XaR1wXX8c+slr4qUoa4Bxk8sdrVClW+Qv0uhxQ93CNZ5gTHovtiO
         Oc2jPTSsZ6Ol9oVqX63oy5Vqwht3110cghJfxcncDLYwUA89SbGjDpbHdr1sLx2UhoPE
         fAs/ao3LZDrBSTcMV4q/4pmBZuPZbecufjkNk59LTdHJV83P+b/Aru5ymHDgSgO/nKdP
         Qn2oE5X3E6aMPLNXeAXq5ykwgDLsXQvPKyF7YZluyfxzktxBX5fX7KwCOOUm9JZYI+Nv
         N+Mw==
X-Forwarded-Encrypted: i=1; AHgh+RoYzNbTnOyGQszlt53/d4C8eJ+t++MWT1Ead9XBECPLqqJ5G27L8L9oClNZwsNriGqMqo5AxpsRkPo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxMKn2RU4crMvejWbmvjvjzwyfWg5Zy5EqPivVdGY5bekXfZVlI
	1dlSGirD1psupok6JrghIq8l2h8VlzngnKVrYwYAfz7c+i1BYSM6MRs9B8+to3tes4u19iXtUul
	q6LviptQ8JtysBF6IglIK4wnAePoiIA4/UbrHqts=
X-Gm-Gg: AfdE7cn2yjdlEqA1oiT/jBmlBXOKYxMWFwgt+N+NIODY4coTw3Hn7YVvaUCWZyEmWy2
	XSUxTfC6cmGQx/Ncf9LdU12bWvqegG9FKidDuy09jzGjTyiDANxOn3cdYIZoLGYBK7LU37Hu4q5
	ux1DQx4jsRYS3VUK4mRgbf9GCmN1hPeVG02Wqz5YWX9tOKTQ0ha3dx+vr9z7J/pXM7ARcHeQnFS
	ITAWnCugwf1cGk+CM0ovz0+5+HIetKN8LlrUaMeNPKoWqOPV7tJpm+kpQIstWaTTIGKiV0X27Sf
	uq1d+6eAOwSM2OCuF4Rd6KBh7g2lgt5EMNrmY8LHLwm1fiVkZ9vbHnxdcvEFqtPpa+ViivdibxC
	1b2/yxKfwv9VGTw==
X-Received: by 2002:a17:90b:2f8f:b0:36d:689a:cb27 with SMTP id
 98e67ed59e1d1-38e4b538f90mr5397683a91.24.1784344305079; Fri, 17 Jul 2026
 20:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716132229.61603-1-arighi@nvidia.com> <20260716132229.61603-2-arighi@nvidia.com>
In-Reply-To: <20260716132229.61603-2-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 17 Jul 2026 20:11:32 -0700
X-Gm-Features: AUfX_myXNUW7KjXTayUqm5dk8aBnnbZM2sYx-7n6SSbmyA-Y9W4fq8UVyCRmjfY
Message-ID: <CANDhNCpiX7WB0XguQisf5u6Q6iJuFcNv6FiyO=mvWiOjHNoMoA@mail.gmail.com>
Subject: Re: [PATCH 01/11] sched: Make NOHZ CFS bandwidth checks follow proxy donor
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

On Thu, Jul 16, 2026 at 6:22=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> Proxy execution separates the scheduling context in rq->donor from the
> physical execution context in rq->curr. sched_can_stop_tick() checks the
> latter for CFS bandwidth constraints and only does so when nr_running is
> one.
>
> A retained proxy donor keeps both the donor and mutex owner queued. The
> check therefore misses a constrained FAIR donor and may stop the tick
> while its runtime still needs to be enforced.
>
> Check the selected donor instead and remove the nr_running restriction.
> The donor being a queued FAIR task is sufficient to require bandwidth
> accounting regardless of other runnable tasks.
>
> Fixes: af0c8b2bf67b ("sched: Split scheduler and execution contexts")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260713164807.E5ED21F00A3A@smtp.kernel.o=
rg
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Acked-by: John Stultz <jstultz@google.com>
