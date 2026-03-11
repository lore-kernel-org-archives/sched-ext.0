Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E753D7D9A
	for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227418; cv=none; b=iopZHXeAHUWjhMvjL9tT4E31NFyWGZMi2yNYk7Bx34b9Wwvt46mtbFyzh5Y2EwtIQ8fge1YpKkJ2ufxm+vz15zDT1noxMGNQQ2/WYyrFYOse6drny/7PuF5akAgUyJKcnCjAlwvP3FMM8RUdo0VWIBaWz3dvncfdVL54kZ+VVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227418; c=relaxed/simple;
	bh=zWuI1bVRtCrY4Vn3SI31YBqX6MOiwVdU58L2T8nCE4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXDA8AfrQHiD5+siAVPdVXD2xCJf6RKB3qc8zPg1b89HjbyC6W2i+TcKZXx15goW31fwhFK12INXEi5l5C7AzKG2MqgYUK9kibMtFJqC8sKbjzgxmSGP4vGEvDxOQV4dherZAtEoo6Xa5juF35QKYyUNeO66gkGeeoOBOBjvSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=lGGhj/we; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="lGGhj/we"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439ac15f35fso10409069f8f.0
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 04:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1773227414; x=1773832214; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7pFJ6CG81cno/CoatDry73R9ImO5x5r/hD6f/HlZv0=;
        b=lGGhj/wew+B/l1C9LJmQcjOaOWJ9uRJ7B10UR8yJ1pJRE0UiezSRTvTE4aIBw5mMBd
         g1S5MkNRFUiZ87hMr/G70zebLlXNqGT8aSwt+fdEvARfLwWL+rViM5R+3xqa5vOFUVKD
         mvaPpDodAmLZQKmZ8j0Pw+mL4oYSwtZfUmZ+0ynnS5/5BpEuJeR97bm06RlgRj70+FRR
         h/dgAqufE3Bg0anSRxHJ4wWVLMkojuK8yTOoDNZGys46UesbRlV104PZM5SQ6mNjW6cu
         IjaS3uzET4hvzOW9PDPPBwGgn6g0/TUE3CNjhIzhwJNyM+lHvqmL6Ra6kGZt6sfYTjZV
         lbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227414; x=1773832214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7pFJ6CG81cno/CoatDry73R9ImO5x5r/hD6f/HlZv0=;
        b=ZzMUex08GgUNf4Hc/EJfRQ3836DVx5nJq/ELGVF04Gs+t2lnql3dKWs72eb5zejKPB
         IhsJXr79ug2p5OQ1ET7bw7psNSF+zWOBUns0QNS+xKVdQhAk10n22zAiiLTRE7ReQyx4
         6uX/buA6Jir0CUrJT5ouDWk3IhhHzp+WS6jK7P//7MBwYLY9eU10XGkkaDng/a/DZ9hY
         rcsSnjoWfVGqALER9dVe3IKUqf3cJ6usDvnnsSOws3PEt2q3tT+Rcg2WGxCiMh0Gzdxh
         /f05JG4J4ntYGi+bqLejmuYrs5IZ6kFqT2NJVteOeeHnhPk58kNpALhjGFIEzhm5ferz
         NOsQ==
X-Gm-Message-State: AOJu0Yy/9FYbkDphDQvLIubes/hJkflpd6SdOSnmhsH0TPAZ2e+8ldM5
	AxJYOwpy9gmox1UgJKpSIpfJeBQVSD/G7KduLINQTTKPMB1ShyNYl/oX6phxzmmbLDgFlO1Ev6x
	wujDZ
X-Gm-Gg: ATEYQzwW0ICH/ZDYIGiZCVfvshAmkN3QdfKDWSuJvqbHpvHcZ1bASwNyV4jsW9DGEb6
	SXEX4q3Ydj45hhIX7kd4fKk7suMkyvxOdwHltg56AEtPmbpTSJD2F51YMjdSSGl/Egw3Lov98/1
	+fxJCxzxNbROmAMyUM4zE368CfVGu1ivfjGWzbtfrQ1kyzn8+BP9nStWfFq5S9fzyvocM8Xf31P
	MNH6x+tdDbKzOkuTBSSHC8N1KsT2zLZozkaVwjUFOBd1u75z29ETymSTXQHX45YUeFTZ4MCLC+9
	q9QWmciN43yInr/xwMmI3KZt8/wNFleWqXmmzNXYuTw/0IpFuf8v2heFpj6EQNoAEE7f9xB6ejg
	bDvFewfIMjGqfK7r0GyKufi9+B9bmINGZwmsw3npYFFe1/MY7tmeFngRSczL36errTEBaaU7svW
	uQZ9bwHDs=
X-Received: by 2002:a05:6000:2906:b0:439:936b:bff4 with SMTP id ffacd0b85a97d-439f8439118mr4116834f8f.46.1773227413525;
        Wed, 11 Mar 2026 04:10:13 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3d8:12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f8224420sm6120465f8f.39.2026.03.11.04.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:10:12 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:10:11 +0000
From: Matt Fleming <matt@readmodwrite.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, kernel-team@cloudflare.com, 
	arighi@nvidia.com, void@manifault.com, changwoo@igalia.com, peterz@infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: sched_ext: Partial mode priority and fallthrough to EEVDF
Message-ID: <abFEFlivu8vk5pex@matt-Precision-5490>
References: <20260310145213.1060649-1-matt@readmodwrite.com>
 <abBidFKC2Hp6Wca-@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBidFKC2Hp6Wca-@slm.duckdns.org>

On Tue, Mar 10, 2026 at 08:27:00AM -1000, Tejun Heo wrote:
> 
> Hmm... I have a bit of hard time following how that's different from partial
> mode. If you want the scheduler to decide whether a task should be in SCX or
> fair, you can do so from ops.init_task() by asserting p->scx.disallow. If
> you mean that you want to switch dynamically on each scheduling event, I
> don't think that's a good idea given that each hop would be full sched_class
> switch.
 
Oh no, I don't want to switch dynamically at runtime. Doing the
classification once at BPF program load time is fine, but AFAIU
p->scx.disallow still gives us two scheduling classes (SCHED_EXT and
SCHED_NORMAL) where tasks in the fair class get chosen first.

> As for the ordering between the two, I don't know. How are you using partial
> mode? No matter how you order them, the behaviors on pathological cases are
> pretty bad and I've been thinking that most would use partial mode to
> partition the system so that some CPUs are managed by SCX and others by fair
> in which case the ordering doesn't matter that much. If you're mixing the
> two classes on the same CPUs, I wonder whether this is something which can
> be better dealt with the deadline servers. Andrea, what do you think?

I want to use SCHED_EXT to schedule the most latency-critical tasks
because a custom BPF scheduler allows me to make better CPU placement
and preemption decisions. Doing it with partial mode allows me to
progressively switch services over to SCHED_EXT without needing to take
on a mass migration for 100+ services in one go (something I'm trying
to my hardest to avoid :) ).

To clarify my "fallthrough to EEVDF" comment: if I could run in
full-mode, use disallow to keep most tasks EEVDF, and have SCHED_EXT
tasks scheduled with higher priority than SCHED_NORMAL then this would
tick all the boxes.

I have experimented with isolating CPUs where all tasks running are
SCHED_EXT while other CPUs run the SCHED_NORMAL workloads, so that's a
possibility. But not all our servers are configured that way and given
that we run heterogeneous workloads on single machines, it's a tall
price to pay capacity-wise if we can't fully utilise those isolated
CPUs at all times.

And to limit the pathological case in my experiments so far I'm using
cpu.max to cap CPU bandwidth (thanks to scx_lavd's bandwidth support).
All our services are systemd services, so we can set limits to guard
against complete meltdowns.

Thanks for the tip on the DL server. This looks promising and might
solve my problem nicely. I'll reply in more detail to Andrea's post.
