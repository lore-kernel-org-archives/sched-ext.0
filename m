Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795593564;
	b=uI1kXeFKrNucc6xeyWrpNI4oSqWHyZeWZ1HpuyfVT711v5ha+UOVOwWuWHx7sXJxDwww
	 vunWQzPURdjRF87e2nUxNjAh3fOuPpMDldnZ7h9Qzf0nUzV0Dvg5dbEViRdpOZOZskokX
	 MkcQH30cylL2/eGyneEOvWYYne6qIaFkhOz8xd58/jX2eVvpWy21Bs5uQ6oJ5jMpo/wE9
	 i03Jwpuhvy+umQhUZufHor8vY3ZwmBOIsBOUmwl5+IbTkLsoYOLoGpnLkSbHPCESNzPu2
	 yJ8h8VIO41hksidn4Qs1fqFFElS9ZfkF7x1w7vgdTe7w3X2TGs1Jbh9dQsP0rXQYtHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lPt1APWAuM+EKrwwPM+5moxwmnQPMXvp+cSe81HAQX0=;
	b=38N6+zk7knDXhZE75ky3OuUJakXeE7rq8YIYv7WeeX8JRiOH0TzzJCXh1oqykBnNPl2S
	 QmEJmCUBKZ/NAujfOJEhZPc3TcMQOOWjksR648lyruSDxiQvenvPYjJnrah7kdPi305wp
	 wM36GtaX8eKKe4kli9G+R9thOP0yoISj1QjLJbnRrOJp1hb+Ise+fTbT1JY3D/1nO6y3y
	 /t8qKETKtZlNQu1JOlq9h5LlimlH/TcMhkbDSoY3XFzMoseC8TB8cCALkxTcw8dY1vq9f
	 mp9FwHNcDwWFFZ3+OL6bD8WIkvFZF70MuJAE+ls3BhgkCmwZuHhV6e3Q0pPGEII/1qQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wcaK9dUL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D6606A321
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 07:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 894D6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wcaK9dUL
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b894a5ce3dso7435282a12.2
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 23:59:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795593563; cv=none;
        d=google.com; s=arc-20260327;
        b=csbzBHxkWO7Y6eg5owbgcakU50hQvbpi7SOgV6fzMaxAcWL/MIBc5EQz+42Lr+7WYE
         YfpzDRp419mpjQGd+ArDN84E346NAfGwmbJ16MtHPKwEu4GqBahEOYfvYkwqJkpZuPqI
         3L+pDTcN1gNkYG7BtbD1j+gGopddUSFdkOfcU9yXzkqNi4ScxaR+zgCuk7RHtymaXZ4/
         h7lh1LPxk0TzQYxI8lmVZyih9YWkXvhNCZQNuw+W3GlT4D0ImVb+mE5EyJVJnsMfXJXG
         zDTI31RavQbqbWLJKUJcuMGSP01rVNOrGLS3/v4dPlTmUR3icjKUDbmV5yDhs9Zl7yuc
         r73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lPt1APWAuM+EKrwwPM+5moxwmnQPMXvp+cSe81HAQX0=;
        fh=SeBQZpOBEKMbuKg0AqCYNuv1TxzHHmZb05OKgvxD4ug=;
        b=nKK22dJ7aG+dV1QDEwmtUbH9nbdzSnKESY2LpAm1D0gdeS5gesplIP+3nWhKgxG92t
         ph4Dwh5hFXV0axmnbjbYReNC7i/J8UwB6NPSOCiB0jijGZgfOWMeXxZ/Mho+pJAlyL3b
         lx/NZ6CSRCufPMF1mThya6gCAMye8EfzXr40DEX5KVOhzQe688f20KSZoYQNojyp5fV+
         p3oRc2l8lspHfyZrWcqci1/Ijy2X+mlx4bFKKJn25ojDYsYEc+SWDgZWH2/ZeYkY8EKu
         z40OsdhHzANwe3+iS3LJuHk3iBFWZNmBpINfEr0b0UFHQIPANRK2/nojwK4CVWeUyKDu
         D0Dg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795593563; x=1796198363; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lPt1APWAuM+EKrwwPM+5moxwmnQPMXvp+cSe81HAQX0=;
        b=wcaK9dULEBjc9GITARETCRaB4Bp/cqhLKbXq6oRXnw6O7HdG7H1kf8QFecVrzLxUo4
         2WGrA/wohIFgalG3br+oQRV5adjEEI5s5cplaZ3+kr97X5xucnijZcuRRDZ77r14WsFR
         fUHGs6erNjdjTs1oKx1hHE7pmJ6rwE4GZ7CJi+N57423mcaK9f6em2UlgA8CMSDldsKe
         /gJFOeC9Y7nr+0wclFpgMk7p55gGq60vqUepEdZh+MG/iCiGkbrHLKrKN/+KROeMMaoO
         oat7bwraF3XeQaYUrMNbsxo5SpRq8tyTSPOj3YV1DRBkKUwh/g9Agf4GPe0HDqV2L/al
         IFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593563; x=1796198363;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lPt1APWAuM+EKrwwPM+5moxwmnQPMXvp+cSe81HAQX0=;
        b=M7PDbabUpetHlnPmqbORmEYJG0c3JcExeH15M6i1MT7sy3e64/ZrScguIdMtPIC9ul
         EKgA2Sj5hdXnri6T/x/TWQLlrO504DixEBhZxPMmE7ifUYulvTG1G0fhiTuTT4QMcEgf
         xaT4ytb1wFyyFlU7pK1wXvpgtmRTP0ONElgx4vvmZuaI+O69umTnqetH4cWrrCel5SWc
         jTtz3WkOhC5ipnMDdkmPEqUvzrOb7CMoudZN6BDqiRh8eJUBKELwHIKU8uf/0j0cG5et
         G0KPlhHuN8ymxxa9ZJ3Y4azZO+8bbjVebzhYqFVjE8WNGwc+3PklX3/ta7QZhUpHvC4l
         IztA==
X-Forwarded-Encrypted: i=1; AL+hErFnAa5zNK9J2P3G6m86Q235WTAG/LzTHi3L/IpI2xbBW/4yEFIfoVGz33EXxTtdOcSgz5I8fsS4jDM=@lists.linux.dev
X-Gm-Message-State: APuU4Z+vmw5dNoUsuCXqS5o7W+Woa7uzUgJX9cQGxvQlxlBeBS+l0tun
	liTr9tsJSANZOlBHuXD+L149eAWgmoYm823pkcSkyLmmLD+flxTVHsnR07REzkfR+8nuWBDSUDF
	iX/uQ1B2KchVx5NCkebXU2JZvDcb9ODbvi8Zg8P0kGA==
X-Gm-Gg: AZFdTZdUnIlKZJhVLrcQCZviFG89Xepr167JqHvAZa1hcTdgWMDWvn85TmtO7AULQc9
	660qACRv9nY3VqaZTc94JDVI2fytkx+24sYbXp6OMsnA6KxuLY5T336wvjNJNw4OqePkKarxLXx
	2Pbj1CGduuiSDDOGFrr+e/Y6hLZoPP+jw6+vdqaaEhzQMOJBbckWLy6J1pASQOLRYqcfjzIjUMU
	v8pzevwD1HIQsjSAgOcGpXs9zwE9yHg0aqGSE+DgDo3+S+fpYoY1WDLwcLGjndxCVQqY75pwEYH
	l8KyZQA9wYBHERQ3qh3RoMPCnS0TamJAfgKvn7GfkVRlkTKPk+ec3cPZSDbPS/dc7E3uKcEon5U
	NsandsfHBQOmWNvGuKWRKic/dQHJicNPDJ/Oj3UMOOJNIyZPWjHEhjB5mxQSWH8Frg+Q=
X-Received: by 2002:aa7:d94a:0:b0:6b4:2960:d38e with SMTP id
 4fb4d7f45d1cf-6ba37e874dcmr9501044a12.26.1795593562901; Tue, 24 Nov 2026
 23:59:22 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org> <20261123140513.849567-1-qiliang.yuan@linux.dev>
In-Reply-To: <20261123140513.849567-1-qiliang.yuan@linux.dev>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Nov 2026 08:59:10 +0100
X-Gm-Features: Aa3M54p2o-4OXRV5MRF0nedJcIovnM36DUkkwJL8BE3h8cyZzFyeML394K6ItNU
Message-ID: <CAKfTPtAN0K0Ly1tM-2R=-9qLx=Nh5p9+GHeqRLHy-nbeAxZU0Q@mail.gmail.com>
Subject: Re: [PATCH 00/18 v3] Improving latency of short slice tasks
To: Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Qiliang,

On Mon, 23 Nov 2026 at 15:05, Qiliang Yuan <qiliang.yuan@linux.dev> wrote:
>
> Hi Vincent,
>
> On Fri, Nov 06, 2026 at 04:19:27PM +0100, Vincent Guittot wrote:
> > The 99.9th percentile are a bit worse mainly because of the decay/reset of
> > positive lag. Eternal positive lag was beneficial for cyclictest which
> > doesn't do anything while running and slowly decrease its large positive
> > lag.
> [...]
> > The test were run with the default 2.8ms slice to check for some
> > performance regressions
>
> I ran the series on a fully loaded and an overloaded server-style
> topology, to see whether the push path costs anything when every CPU is
> busy. Guest with 32 vCPUs on an EPYC 9654 host, set up as 2 sockets x
> 8 cores x 2 threads so that it gets SMT, MC and PKG domains, on

Thanks for testing

> tip/sched/core bfee16fd01d4d (patch 10 needed task_tick_scx() to take
> the new rq_flags argument to apply there). The four kernels were booted
> in turn, 3 rounds of 3 runs of schbench -m 2 -r 20 each, median of 9:
>
>   workers  metric              base   +01-04   +01-15   +01-20
>        32  wakeup p99 (us)     3116     4648     4648     4632
>        32  request p99 (us)   34368    25568    25952    24992
>        32  rps                 4327     4907     4898     4919
>        64  wakeup p99 (us)     5656     7736     7640     7688
>        64  request p99 (us)  194304   162048   161536   163584
>        64  rps                 2507     2532     2529     2532
>
> The wakeup p99 increase, +49% at 32 workers and +36% at 64, comes
> entirely with patches 1-4; adding the push patches does not move it,
> while request p99 improves by 16-27% and throughput is the same or
> better. So with every CPU busy I see no cost from the push mechanism
> itself, only the lag decay effect you describe above, which here also
> shows at p99. hackbench (4 to 32 groups) and tbench (32 to 128 clients)
> with the whole series are within -5%..+3% of the base.

Yes, clearing or decaying positive lag softens the capacity of a
sleeping task to preempt at wakeup; that's why you see an increase in
wakeup p99 but an improvement in request p99 and rps.

The push feature doesn't impact your figures if you keep using the
same slice for all threads.

>
> Thanks,
> Qiliang
