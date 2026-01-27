Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB49229B2A
	for <sched-ext@lists.linux.dev>; Tue, 27 Jan 2026 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503986; cv=none; b=SK2G+4RDfYLQDZLWLUHXIshkmjSA+mN9ItTJ6AlqVZy+PJ6sk/+E0CtHEXO+eFOAkeA7epTY4FaXWzTYwEPQ2XPewVbH3rhuPuoTCHoPfLL+XRiz3BLE0ImfDtdk8ync/Wq+WJVlzgM8R6U9RHsY8slfBkJfoPHws7Jnan7ZSAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503986; c=relaxed/simple;
	bh=HARrLeRvlbAVyFhYP8StMCmJTs00OtP9eCqLafd59bk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=urML20V5Ln0b8txRIoWvHkmuLQ+YSdN2zLjrkt1ObgSvYiSAA5hHxGBcbNmM2ul4+s2MncyJmUMbjwSVD8CtddtvSpw/cVhLQWXubgv1KFNMmQJXA9xAhkm3cl44p+Gvg3RNle7yl8FE1AwvnUj0MP5On8KpLu+CkR1ACuUWopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=es3XWelk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="es3XWelk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769503983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HARrLeRvlbAVyFhYP8StMCmJTs00OtP9eCqLafd59bk=;
	b=es3XWelkneVyJdB4O5E8H+o7usTzK7Lrdo+fXD4L/+RLv9icqwyjD7rC0w0x8cQZ2hP8Uh
	gLNsDqIp4gObdhvj+NIFbliDiIqwh8aqL4gh1v3Z8byzioCYx3b3bSjnEPFA6+1ABHenTT
	P1Wc+9YQcOwOnQV3QKwvBCkWoBAxExQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-obTCgSkBNSmd8JCIVZ0YcA-1; Tue, 27 Jan 2026 03:52:52 -0500
X-MC-Unique: obTCgSkBNSmd8JCIVZ0YcA-1
X-Mimecast-MFC-AGG-ID: obTCgSkBNSmd8JCIVZ0YcA_1769503972
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-432c05971c6so3926540f8f.1
        for <sched-ext@lists.linux.dev>; Tue, 27 Jan 2026 00:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769503971; x=1770108771;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HARrLeRvlbAVyFhYP8StMCmJTs00OtP9eCqLafd59bk=;
        b=I6bcSqdRboU2gigL+kgLM00ui+AF5HcC5BmwUQTzYvOAOxdSENfwk/bjSF0DchLto6
         R3VTIpjkZ70ZJdS7k0k0M2XFtfDq5E05yWsLctOV31efc1oDR12pIEHIkEGRxMBSbrw+
         U0pHru9HBPUNc2NmMWeaGb+jl6wp1/tyoKbzSx+X2v2RlG2fAZEWTdVUwYMs8QZRTIqF
         6hJcjnvM9D50YJ3ResRxrW8xUtcLkHplY2YMTUw88+W8ahj4OamW1JUS3HWtdS/gr7df
         PuHoAVfeST1EO83wGSmY7AblD6Ohsil7lqAyq43lktz5FH+SOx/G0ITWEImEH1ifLFy4
         O8kw==
X-Forwarded-Encrypted: i=1; AJvYcCWtmE5/VpAEhXXR0yIBABzNCKb9njeGh/IpwxChAFbAvlTtbnuoce0giVlMenq1apn9LS/x8rPcg+0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9/C07zBri84JFoZXoiMcfIKZVjF7kL/2Qh4pnNwU7SfMfO1jb
	Ns23APDm7qhFQAKXibwq5K6bORV9S/1BZwGJlshGjF+KFlx1Hzgzfuy/DkLFyp39CdOI8XBu6E2
	8wGIeyMRFJOaiGRH39naGcqQuGGSiRO1QsS4uI96a1tszmI01Z0L8IyRUjhQdGQ==
X-Gm-Gg: AZuq6aKREe3k2UdrOQ/o7xDThQeMl5rNpQzBDt01li+ihZo7jvEUi+7oxALSJaJu9AV
	BKTujZQO7Uk+osdhN2YX+Yi3vrYZVvfxo4rMlBPBpxqihC1bUGqKHrRs7W0zk/0B0R80K+WZxbT
	8N4vNWUtJ41hnpaW52LKAaVOTN938zst83llyOog8AXrSUQ4VxX6A6ST+CLLcwfkB9ZPHIFUjKs
	AAZa8oh2uOdFOBT1shcdAolf2PGmoLz+y5M2OvCdoxAnHJZFcN1xYyCU5UBPFNnZsLHV/Upiner
	1n3t7Lsz4IY2409cAMKNbM3GxpFJU02rS7PuTotFwjRkXtNQ6Nr7BSb3BMeTIRx4DJ2xNPOhTkU
	Gr3e+
X-Received: by 2002:a05:6000:1787:b0:435:97ff:7d35 with SMTP id ffacd0b85a97d-435dd0a88e9mr1366666f8f.4.1769503971489;
        Tue, 27 Jan 2026 00:52:51 -0800 (PST)
X-Received: by 2002:a05:6000:1787:b0:435:97ff:7d35 with SMTP id ffacd0b85a97d-435dd0a88e9mr1366636f8f.4.1769503971107;
        Tue, 27 Jan 2026 00:52:51 -0800 (PST)
Received: from [127.0.0.1] ([176.33.57.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e7156dsm37237149f8f.20.2026.01.27.00.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 00:52:50 -0800 (PST)
Date: Tue, 27 Jan 2026 08:52:48 +0000
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
Message-ID: <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
In-Reply-To: <aXfcGynN92kyw5Co@gpd4>
References: <20260123161645.2181752-1-arighi@nvidia.com> <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com> <aXeWnzI3ymUSm3Cu@gpd4> <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com> <aXfcGynN92kyw5Co@gpd4>
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Correlation-ID: <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -xqwePcHyLV7MaSBTL6NwoD9kWBuz5Zf0Zp25q7CYfM_1769503972
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-01-26T21:27:11Z Andrea Righi <arighi@nvidia.com>:
> On Mon, Jan 26, 2026 at 04:56:52PM +0000, Gabriele Monaco wrote:
>> Still if it starts before the deadline, the server is going to get throttled as you observed, and perhaps since in your tests the CPU isn't idle, we don't stop the server after that dequeue and then we never replenish after the deadline (because we never start and as you mentioned, the timer is not armed).
>>
>> Can this be what you're observing?
>
> Yes, I think it matches what I'm observing.
>
> In my case the server is (re)started before the deadline, so it immediately
> runs with exhausted runtime, gets throttled, and is dequeued. Since the CPU
> isn't idle, we don't hit a path that would stop the server cleanly and
> reset its execution state.
>
> At that point, because dl_defer_running is still set, the restart path
> assumes the server is already in the running phase and skips arming the
> deferral/replenishment timer. Therefore, once the deadline passes there is
> no remaining trigger to replenish a new period and the server gets stuck in
> a throttled-but-running state.
>

Alright thanks. I believe your fix would work even if you reset the defer_running only when the runtime is exhausted.

This way we'd still keep a bit of benefits of the start-running sequence if fair/scx tasks sleep and run back when the server still has runtime.

We could even keep the defer_running as it is and mark the server as defer_armed (with laxity timer and stuff) only if it starts in this exact condition (runtime = 0 and deadline not expired). But this may just be overly complex for little benefit.

What do you think?

Thanks,
Gabriele

