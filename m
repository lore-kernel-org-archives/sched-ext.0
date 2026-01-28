Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E86B2FF169
	for <sched-ext@lists.linux.dev>; Wed, 28 Jan 2026 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769593843; cv=none; b=OsKV0ds++cPI4WiuIoueTYOTAXkfkrVdhOv3Ez7yuUrUYFcoSOJabWg7XsdNd0WzRf1IyPm0+glzSwi8MBQ8gfNBPI9uiKiBUZ29K7jznC7TZQzYB8UKGOwuLg4RUVU61oecLj8P/uaQ/TTUj9PdUUELZLvh/XT4q7G4y8a1W6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769593843; c=relaxed/simple;
	bh=PQEiF8r8P9hGm/afNAaoJ7wn7IiuGrfi3afaM/Wvt28=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nC8jcFxRf/OFo6H3JcG7T0kUTE7IgmXOgyICSIh+pLRhyEtAyrNADhG1NNnaZfIqj8JVvPQ0YhDYSvxYGewB0V4SsBTGcyMeUHWwhVKmsoYmTVAIFYkzhuDkIvEdwmkbd01PSu1Eeg5/v8pwas1EFSEIxeUr7XJugRnIDZsxk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXAiFLSM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXAiFLSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769593841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQEiF8r8P9hGm/afNAaoJ7wn7IiuGrfi3afaM/Wvt28=;
	b=MXAiFLSMvti0d3Vft/SeGG04cHwrB/hV83CfZlRwOgVvMg8xtDU6ummKmNsVYUpqkxhqui
	BxIs/wgfZ4swD1bRIwhKjc+BKbBoIQ+D1MdKmMhsokTy3YgUHftprVkzjc4PwQgMWQYe5W
	XXSTCPWuhm+K3vjIZ8xcwjb5l3AP+1M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-2GxxyuNMO5mljOgwdpw1NA-1; Wed, 28 Jan 2026 04:50:40 -0500
X-MC-Unique: 2GxxyuNMO5mljOgwdpw1NA-1
X-Mimecast-MFC-AGG-ID: 2GxxyuNMO5mljOgwdpw1NA_1769593839
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee1fe7b24so58025335e9.1
        for <sched-ext@lists.linux.dev>; Wed, 28 Jan 2026 01:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769593839; x=1770198639;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQEiF8r8P9hGm/afNAaoJ7wn7IiuGrfi3afaM/Wvt28=;
        b=IUM7WsB14ow4HdguLiHusIonyX36F13Os8A+j5F8+Gi4em2x9icebPSsiaSB90QPuk
         ZdRIzgBTb+J15k02cGVQaoGjoADle//AMqazt+pI5VMl2Kjz9IOvNLGYKD7G3dvQ1K05
         KTy8ESOHKqaaNSQkxOiS1pEoTuQzmyQ3UtKyELg/hF3qAaT93rhOLHiKuXWa4o+q67IJ
         v4csySJojSI5e4TQLUFpt7jS6LSRpssettrrcWt3K81AAokDZJPLPMAJCoc3rojRzpFp
         YLhJEMn36yrrvWLrvrmiox/90nwCnn0+VSCSbebC2XwLwLAfat4WOhovi9uZTDLGbEnu
         wRoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcZDTprEuC5USFaGOYqguLwm3lTDvGOHjNnV4bEem0q9YCF/QkWKXLFCP9GCAIohvVtvhVCAYPsJk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyhSMivIpO9lZt2f1fBdGc3equp6RWJvMoJ7n1g44GjEEAOebz6
	11mEYkDMC1Z7jC64/OjhQbwxjwCeVkxofDMNyBdbJn5f76wP5hvFXGOFyyESiYDPugo/PyV+T9V
	msgSWFthVqzFScwV4kiGuFw+yDcAhEOjNIO6D1yAfo6MTpFtByQ8dgPDjCEKF/w==
X-Gm-Gg: AZuq6aIgSJSF2oMenf1B7f0h3iD/2RJa7xRTihBDNU12Ie68xLEIV1b8vh5y1B3Hiaz
	PaMLr5tejpQ6ObbCUDbMLkqV6+hBo3+sfu8WBNUaIYMJE266O6IgSDBguWLvj0XA28tor7LovNZ
	dOWZZW6yXA0Id1FSmX2HwM8Hik4JkMsvBn5mxoXum+ItKBWocZRs4ztUDR4+nlVJUamdHhR4zvl
	Ql6ONOtrzS+JWLSB4OkbIDv37kb4/QbeDEemMN66LvcA264B5hLcxcP6Wgo3quli95HDQW8YH3b
	z3uoyka+5NomMdjoXErDW6+keE9sUmVYBGYd3C0jpM5DkHYoK9EXVBxfLVItZBLV3zYU2lKx6DI
	z0TOjWQ==
X-Received: by 2002:a05:600c:4689:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-48069c55610mr51648705e9.19.1769593838644;
        Wed, 28 Jan 2026 01:50:38 -0800 (PST)
X-Received: by 2002:a05:600c:4689:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-48069c55610mr51647885e9.19.1769593838043;
        Wed, 28 Jan 2026 01:50:38 -0800 (PST)
Received: from [127.0.0.1] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfccsm5488885f8f.17.2026.01.28.01.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 01:50:37 -0800 (PST)
Date: Wed, 28 Jan 2026 09:50:36 +0000
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
Message-ID: <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
In-Reply-To: <aXkJ8_zLVSuToLxe@gpd4>
References: <20260123161645.2181752-1-arighi@nvidia.com> <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com> <aXeWnzI3ymUSm3Cu@gpd4> <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com> <aXfcGynN92kyw5Co@gpd4> <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com> <aXjJG-72XEqvaVtL@gpd4> <be763631-f677-4bad-8285-69dbfe29db54@redhat.com> <aXkJ8_zLVSuToLxe@gpd4>
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Correlation-ID: <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 022qfg25IToAs873pQxd7tqNc9lvQBBurDOSyu-3148_1769593839
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-01-27T18:55:02Z Andrea Righi <arighi@nvidia.com>:
> Unfortunately checking only runtime <= 0 isn't enough for the sched_ext DL
> server case:
>
> # Runtime of EXT task (PID 2025) is 0.000000 seconds
> # Runtime of RT task (PID 2026) is 4.990000 seconds
> # EXT task got 0.00% of total runtime
> not ok 2 FAIL: EXT task got less than 4.00% of runtime
>
> With the unconditional reset the EXT task gets 5% of the bandwidth. I'll
> add some debugging to figure out exactly what is happening.

Thanks for testing it. That's quite strange..

I run your test on a kernel without ext server, as far as I understand, the test is kinda indirectly checking also the fair server and that does not fail, right?
At least that's what I get on an arm64 machine with 128 CPUs.

After letting the test continue on failure I get:

# # Runtime of FAIR task (PID 22503) is 0.240000 seconds
# # Runtime of RT task (PID 22504) is 4.750000 seconds
# # FAIR task got 4.81% of total runtime
# ok 1 PASS: FAIR task got more than 4.00% of runtime
# TAP version 13
# 1..1
# # Runtime of EXT task (PID 22511) is 0.020000 seconds
# # Runtime of RT task (PID 22512) is 4.970000 seconds
# # EXT task got 0.40% of total runtime
# not ok 2 FAIL: EXT task got less than 4.00% of runtime
# TAP version 13
# 1..1
# # Runtime of FAIR task (PID 22518) is 0.240000 seconds
# # Runtime of RT task (PID 22519) is 4.750000 seconds
# # FAIR task got 4.81% of total runtime
# ok 3 PASS: FAIR task got more than 4.00% of runtime
# TAP version 13
# 1..1
# # Runtime of EXT task (PID 22525) is 0.000000 seconds
# # Runtime of RT task (PID 22526) is 4.990000 seconds
# # EXT task got 0.00% of total runtime
# not ok 4 FAIL: EXT task got less than 4.00% of runtime
# ok 24 rt_stall #

Mind that it's expected for the ext task to starve (I didn't apply the patches enabling the server).

After adding all your patches [1], also the ext passes the test (i.e. gets boosted just fine).

I tried disabling all CPUs but CPU0 and run the same test and it hung (bad sign), then I also enabled CPU1 (total 2 CPUs online) and again I see both fair and ext getting their share.

What am I missing here?

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/20260126100050.3854740-1-arighi@nvidia.com

