Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C93330B15
	for <sched-ext@lists.linux.dev>; Mon,  5 Jan 2026 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612448; cv=none; b=tZakpvJ6ZK5LJD7jlQI4opMAyMqIV/tloNds4T0BTalUGEZxPbumCx99xdnJWAoHURA5tNsWnYUfUrLHSUm4u9ifwYUYBnKPZZUyogBpduhylhYqLC631WNEQ52jCbJNs898FVfdLzPsHuDJ3267c4i8SWr6sW3M59yrBgpj7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612448; c=relaxed/simple;
	bh=VUXdc9hwk0T2er9DTckmrZex4qeCTOgDcVRoChu5qdY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=KqA50IO8hOXA8SqC8XSdzVODd3OOaLKmixqQTJrKB6iFfPRBz6JQOHIN8sSP+K1cfIeJiuQGhGE8bSqwOoMe5SCukFJXBmjdlh8KhMKDEfiL380gFdts6Qx6WfF6S179uu0Lexji2X95EmACGFbKaDrLsGbJNjnONs4cKlBoBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fonB3Pv6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fonB3Pv6"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so9427633f8f.3
        for <sched-ext@lists.linux.dev>; Mon, 05 Jan 2026 03:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767612443; x=1768217243; darn=lists.linux.dev;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qHDzkZJACXcp+eQuf4jUc4YyVkIXXCNoOh0gjbwoPI=;
        b=fonB3Pv64Fee0s36TOhWlpdIvqxaZbHtcQbSPjGPUJ7md+vvVva9QgjBqsvsQbRRUP
         M/mORNJ1AbyG/P78zSYwZQrd+pQy9uth9rXg9FKdBteljK+qWVOgj0xXGYM6I2QKUldM
         2P8CnGQkepB2rRYlTfrN9WNVrBEM4ilzh1gDzA1TYs7VTc1A6ewdYRHl7k+5P7pp9cEh
         K8jJlIAkcA7hzpS0yAWUnp78Zw+xBRor0EETB3EqSuCEGbE+t30EuvQNJrmViylyshkl
         Ld52rOCUqgaqz2sBqFrcRHHjB9xmq4/SyLH0pq7b2bC4V3iu7JI+5rD5Tohgi9fMHqXW
         v8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767612443; x=1768217243;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2qHDzkZJACXcp+eQuf4jUc4YyVkIXXCNoOh0gjbwoPI=;
        b=KxHlUd/c+ZEX9ns/rrEshL20Iw0+wKgD2xFPmQbhP9tBIC9DJHZLLcyKsJOplGDp7a
         fblbwEJTupQ/X70Ezw2624fJVE4s/l27+IvI7ZLAm161DDqsn6v3vSGxWp5/NHOjH5X7
         5yNF98S67Q1mM4iwphAiQ733+Y6SWdv/oVRRhiVe0mjqw6YISUzdGduV5PMpGdFMmpLu
         Mu+0J81OQwp6WXJSxzC4QNrj8ZxouFyAQpkfltxdYEdCePZqZbATzfN4IXbzeFDT1ony
         kKZLTcmgFGOKoIbAg4S6bgwFnfqF6GET7/906UfVkb2ipAAHDwVE88zlMT4ilOGFyBhY
         j77g==
X-Forwarded-Encrypted: i=1; AJvYcCWP4ig+QhpNsEPKEH+KOT4Il3QNbO42wWXEKyvJBmlgumPkHoCiheneWcS8LM9OhTb4sUbKxIEb9Ww=@lists.linux.dev
X-Gm-Message-State: AOJu0YwRVj0SkWVpFKO5O+djAmBsENi78SKJ18P4tIiuxPtjfUVh20EA
	CQWP6UB8Yuiy0BxiFRpqCRJXCoiN0co5HRj1t3Oz1JP3ql6+GQzj2nms
X-Gm-Gg: AY/fxX7mwDCrzQviVcnubnwd9hl0/wPkMynF897aeLcaagFbhWy5iv/VUfa4C6bifHd
	3/G5bLGO2cHAh34sNRSQM4G+IUpHMYDQy0pyCLIOfZu2UnmKyNRvSGzUYE1YchQz1fyiMCvBCpg
	HqObBEx5Q+18gCAIK8Uu7tl0h+q5/YJ4CmbNzJ97Rcd336vkxkCaCNmFFJBRj/xXIaYHOz1Yhcx
	hzEBhKMmcAOsjZVoeDkfYyksz3pmUAZtEDAv9V50T/kA47iyrZctHvuShXKcaUTUvShysWlfzFX
	CyLjKUcNvx/uOjGY06CZedIKK7dQjy7tYmc7tokRhOANxj9bB4qPKRl4WuIOQHkLC0oTcTlg4tE
	ZIwfg7qzqDQv6+kMWb6LFQM8M/ngoj6aMrKzraxwUb8mDXsDqcD2QGQiiT263pOvc/+JkQ/kGsg
	xGNQeAZ2F271MD3XX9M7VWiuQ=
X-Google-Smtp-Source: AGHT+IEe3zf1IkKFKkWJiFRWFG2kWewA423+4tt5YeHwRg6lgVblS3TIR8XO7sEvsL2qPIhcXvtY5g==
X-Received: by 2002:a05:6000:25ca:b0:431:5d2:4526 with SMTP id ffacd0b85a97d-4324e4c9df3mr65957051f8f.19.1767612442851;
        Mon, 05 Jan 2026 03:27:22 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:fc71:3122:e892:1c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327791d2f3sm69505535f8f.11.2026.01.05.03.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:27:21 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 6.19 4/4] PM: EM: Add dump to get-perf-domains in
 the EM YNL spec
In-Reply-To: <20251225040104.982704-5-changwoo@igalia.com>
Date: Mon, 05 Jan 2026 11:19:16 +0000
Message-ID: <m2bjj8i9xn.fsf@gmail.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
	<20251225040104.982704-5-changwoo@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Changwoo Min <changwoo@igalia.com> writes:

> Add dump to get-perf-domains, so that a user can fetch either information
> about a specific performance domain with do or information about all
> performance domains with dump. The YNL spec, autogenerated files, and
> the do implementation are updated, and the dump implementation is added.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  .../netlink/specs/dev-energymodel.yaml        | 12 ++++
>  include/uapi/linux/dev_energymodel.h          |  3 +-
>  kernel/power/em_netlink.c                     | 58 +++++++++++++++++--
>  kernel/power/em_netlink_autogen.c             | 16 ++++-
>  kernel/power/em_netlink_autogen.h             |  2 +
>  5 files changed, 82 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/netlink/specs/dev-energymodel.yaml b/Documentation/netlink/specs/dev-energymodel.yaml
> index af8b8f72f722..1843e68faacf 100644
> --- a/Documentation/netlink/specs/dev-energymodel.yaml
> +++ b/Documentation/netlink/specs/dev-energymodel.yaml
> @@ -47,6 +47,11 @@ attribute-sets:
>      doc: >-
>        Information on all the performance domains.
>      attributes:
> +      -
> +        name: perf-domain-id
> +        type: u32
> +        doc: >-
> +          A unique ID number for each performance domain.
>        -
>          name: perf-domain
>          type: nest
> @@ -136,6 +141,13 @@ operations:
>        attribute-set: perf-domains

I think this can be changed to 'perf-domain' and you could remove
the 'perf-domains' attribute-set.

>        doc: Get the list of information for all performance domains.
>        do:
> +        request:
> +          attributes:
> +            - perf-domain-id
> +        reply:
> +          attributes:
> +            - perf-domain

If you use 'perf-domain' then the reply attributes would be:

  reply:
    attributes: &perf-domain-attrs
      - pad
      - perf-domain-id
      - flags
      - cpus

> +      dump:
>          reply:
>            attributes:
>              - perf-domain

You can then change the dump reply to be:

  dump:
    reply:
      attributes: *perf-domain-attrs

The dump reply for multiple perf domains would then look like this, no
need for the 'perf-domains' wrapper:

[{'perf-domain-id': ...,
  'flags': ...,
  'cpus': [1, 2, 3]},
 {'perf-domain-id': ...,
  'flags': ...,
  'cpus': [1, 2, 3]}]
