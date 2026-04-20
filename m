Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E78727FB35
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697927; cv=none; b=uwRUAe6qpb3wQuktgNVxEfDbsj1Je1Y2cET2ikxnbKcW6EbG5CSGKpUpM5Qj17KGdx9NHbSTLT3+9Lzcbz/vvlaiuVJbEajwnvEYQQdhTOR/NBMVHZD2HSblnpsXjQx2EhHuv32PNufSovzLL2BCkKKgO8I8EH+sql5kzeh+szM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697927; c=relaxed/simple;
	bh=bVRFppeRBD+RgwIoaV2mBXyf6u1g27z+N3mgh0JJ4ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUExA1LpFAzBi65b6tFeVOEULfhyodj3HJDwAdcyq2yAblNF+rPKdA67pO0OWX0XnGqD15rfGJ9BYPuJX62PnJJuqYHb52CpF9QYC05Xc4QfqOdUjS+P9azEZB//yne4hTjrRtcc7C6yh+qzU5Fkk8G8UViKms8WoRmnMt8xUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFRBFNe6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFRBFNe6"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-358ed696623so1373430a91.0
        for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776697925; x=1777302725; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHNE5ar4Vwoc6rK3RRSpgvp9k4ljOyO8+zo3RBbEFLs=;
        b=NFRBFNe6Vy14jyCb29rDYIuimHPxvcC47ud6E23PiMAYm8uoy5svn2EDuZIMUXva6N
         psRVhLKO7HFM4l+VqZkJSKaNHKEEsQrJI9us6NWRo4dyDKD5ao6pY0CZMDyLpXTCVmGI
         pNE29Cgl+XtgmEnb+DZtbgoTLKOelc26EauqFLt3CmBvUG+vFZJOdjcWB9Od0gNLH4o1
         F+Xwk6JizXZi+i4N4tnVG5tYNU+35iRU8i1dK/w+D9brxpVWLL4ZM2woLjZFKB5SdEN/
         cn3VkD7l4S5s2av86tpJw2YS8tEjnZBldHtNpS0MLmJL5tpOEMjkAAV3mGGnhT9fylQg
         X3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776697925; x=1777302725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHNE5ar4Vwoc6rK3RRSpgvp9k4ljOyO8+zo3RBbEFLs=;
        b=ZGygI57ItvFlgdR+8HrgxtiIwvTYQjwcO3mdROYnLsyF0XjYdQIAOAbDo16FtDgLQo
         d4d+WxytRAh4M+CoKAYmiVt8kCZK2anSx9ANTiY+dRFrGRphsXer8e2gCs8AzkO6qELQ
         0dGqvHNdV5WU58r0OcSzsgqty7F8aae4VDnWGkJB4JmT/+qJhOxNNotaa3fplm+qjZFL
         QJ5TlLXn6KNnQXbAB/3JaW47utI4Dr65juAgwFB+vav79+x67gU9PPpt56q515MCz3sM
         BRjmhv2ANnd1tENaWoOdzZl6L98DV9Kss2ieYcoOcPcKbkwBCa3Ja6KgHf0UDf5kymEz
         x1Ow==
X-Forwarded-Encrypted: i=1; AFNElJ+1hkkpdLno+RxlKOHgdhlM7Tu1TwfWd9sFMyxC83wkwncpTG9qwoOVSojwR+hH7OTP3p9oLhNL/qw=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywk110F79xb4uw1vvo3/9WnaKaSkMnaaJS4pcxUMLjJb7aj3zHo
	Mus/tVYaVdp3xvtOmGzKHOXmgszxPMHaUIbs8L8KhjAX6DsBc0QvKi2mL3+yjY3z
X-Gm-Gg: AeBDievxmquEMqG8cD0mvT2FqY9Gny5WEsByOJwn+ZuMITOqSLzX79uqpuvDPYPgjAg
	W9dMkmF5K6O4Go/WlucZrNtGXtTayVG9y2ytuAZI67qjKpj5uck0N/aMtS1t10l4SqIzLSSy6qI
	9XBCc9JpA87bqHZbBNN/zd7J0gvHm8bkN2foN7wrwhQ1yFpv0i2ZlSnlKmNWAn3MFiDe1gHZofP
	xEw/k5VY0DvWka5fKot2QgNPlNnJPqiVPzLRpA7pBhyqPr6f4ZK6oKbfEAOe3yrDhn5T1aqrTDm
	bTrUuQ9XpeR2qb9z14TFq8/W07S8zNjZ9PnLyUfSbxoer9wvpUNUykPJNarc8iU4IPX+97f0kJC
	s6wai3RVKL464l1xFg9cFbhybX+hwV0LASD5L7wRxYc+c1IpV4nZ37cYb417hLTUjfqCYRbmU1H
	Ce9lSjvyhtJa4YCQNlg2bh8V/dAndcQXmO3Fu52xUb00KNfQf3+CM7nqn2ml4WhSP9JL2iJ6+Lu
	UmZtzplNfR5MVAe
X-Received: by 2002:a17:90b:164a:b0:35f:b572:ece3 with SMTP id 98e67ed59e1d1-361403bd001mr14763148a91.6.1776697925137;
        Mon, 20 Apr 2026 08:12:05 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614189343esm10729449a91.6.2026.04.20.08.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:12:04 -0700 (PDT)
Date: Mon, 20 Apr 2026 23:12:01 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: Documentation: add note about multiple
 ops.enqueue() calls in a row
Message-ID: <20260420230420.G737d@cchengyang.duckdns.org>
References: <20260420143939.3636883-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420143939.3636883-1-jpiecuch@google.com>

Hi Kuba,

On Mon, Apr 20, 2026 at 02:39:39PM +0000, Kuba Piecuch wrote:
> Commit 84b1a0ea0b7c
> ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
> introduced the possibility of ops.enqueue() being called multiple times
> in a row for the same task without intervening calls to ops.dequeue().
> AFAIK this was not possible before that commit.
  ^^^^^
Nit: Do we really need this line in the commit message?
Perhaps we can just drop this?

> Document this behavior as it may be surprising to some.
> 
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
> ---
>  Documentation/scheduler/sched-ext.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index 03d595d178ea..fba09aa1cd4e 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -339,6 +339,11 @@ The following briefly shows how a waking task is scheduled and executed.
>       leaves (e.g., when ``ops.dispatch()`` moves it to a terminal DSQ, or
>       on property change / sleep).
>  
> +   Note that ``ops.enqueue()`` can be called multiple times in a row without
> +   an intervening call to ``ops.dequeue()``. This can happen, for example,
> +   when a task on a user-created DSQ is re-enqueued using
> +   ``scx_bpf_dsq_reenq()``. The task stays in BPF custody the entire time.
> +

Thanks for adding and clarifying this. ^v^

Acked-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

>     When a task leaves BPF scheduler custody, ``ops.dequeue()`` is invoked.
>     The dequeue can happen for different reasons, distinguished by flags:
>  
> -- 
> 2.54.0.rc1.555.g9c883467ad-goog
> 

-- 
Cheers,
Cheng-Yang
