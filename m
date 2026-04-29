Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD1738F65A
	for <sched-ext@lists.linux.dev>; Wed, 29 Apr 2026 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777462176; cv=none; b=f9sKNDOJ/JClnDUG5TH+mg7p2OQz6sAK4C7T4yNxSPLcLIJJ6J3UY0kZA4NxnkwhJbIPIIfGlFff2wYJ02G++twy8jADYKjX+Fzxd2D1pTmaLAmunQkGUrpa74Voyf0U3updMVhVTHiEXzvDLAWGttNvwTwiGfuMibAIny1mOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777462176; c=relaxed/simple;
	bh=OiUzhrZJLkDZP06J6ooHys9O40j7xQ02uTFTKpDHJgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwtR5QdvDN67orkSOwORhfOhN242K9DouM+Dh5X/n9Luw7n+ZEP3Pf1GxS4/SnzYSjeB+le5xqTBwyRDW9iJVYIbD2wY9vSGccZrSV81gKIfe/QnVtZ/ACO3NNFc9TWrRNXEiFkrPxftWFZclNP2VxbMSc8OTgc5+PEqPOQ3UkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fuh0RD8V; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fuh0RD8V"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so6399786a91.2
        for <sched-ext@lists.linux.dev>; Wed, 29 Apr 2026 04:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777462174; x=1778066974; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NTIjqimKTBZoU8q+dOmcyW6ZXhIfzpj1hrXXkypP6ok=;
        b=Fuh0RD8VlOoKZ9ktKotT2bNcxhkvpUgI24+WGGU8gLCtDCYV5JOnx3raaqXhtTJQtQ
         Jy6MEpvhaSHadMdFctrKQLiDQAfxnzn5ahSDFMdmmTkFz9gZ9rJIk5t4wRmbXOGYRRWo
         RYCkmVA424o++vw2ev3ux3DmYmHTnU271PJX+A0L3rugdMwyXF74ccEdcFcfr1pN5A17
         DFVA8cKrYTPVztVRZzxuGO5fug4ed8ufMywaFHTlHm9jAg4LEapd2wuuQWaikAKrChLE
         Cg+UweLwka10DXbDQdDekK9hCR+mcfLoLQ+VmkyqwEUlXJe6YkPGoJqqu0UqjG47U6vH
         xEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777462174; x=1778066974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTIjqimKTBZoU8q+dOmcyW6ZXhIfzpj1hrXXkypP6ok=;
        b=s82I53yi/OK1dMVCbrfJQ3ygQpccfPHvhNg9nGEPjjAIYhN2d8skME1CjKLohlKzr9
         Rum6SayveXZ9MrzhrClJyMfQ5shSKxS2bR4MTziL9fHWzKKdk2vYF2H8ftIiz+VBX27o
         DDOmDQBJoTVUbssSXzwnzYNUzDLOoBqfAywtl+OBFC+HnkS3WqcaP/XgKUTZB52tctG6
         HSbSlAFxWirxHqi6dZ6LdpCpyFRZQj2XJ+KLw4IpSksYAKAlHQTfIfd8qGDLIYELdLlc
         uSaO552irH89tNNXolehThu1UfsjWVJ4PPN6DSM+VP+NM+1FUnp8TQ864IYr1xnxM2Ph
         9aHA==
X-Forwarded-Encrypted: i=1; AFNElJ88mMH5g4uve+FqRzqj8D+FkemQOMImmtljamxxDrmGfeUjNFsho0/prjR9WTgdkVrsaFscVQQMJfM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxeYCgXCryPUn55J4o45JkYZGoGegVFdkYI8Y3CHS9OIrWziJKx
	+hLP2H4r/Hv7N0qWv5d/nJRJYo223qbxlLSsteJHzdWXxgiEOuQnJMyx
X-Gm-Gg: AeBDievP8CQf47xA1+nBJYHxzlCVoe7Dvy7z1CBjNyzdJsrlr/Sa6j7qL66Mt4WvrXY
	Y8MUztzrDT5Q7l4da+2UAHyJZ7R9C+3FVTf1ZDEq+9uyp58UbFF1iBGRQ5LcaP37HUrGb+NWZNj
	8RW1OZyyiegTw0lTFKHy80OrdkmM+Yd8XayGaUU03zPHFifzBrrGgoAOgBWqdIq0tHVFMtxUeea
	niUY7Dt3V7jQexbJCFi4n/Xl9HhnJGrmtntAEA5vCpACHKvDXcyJauM3+fm6qfqgja31z8V3Hav
	lAH4ubDegkaqUGrrKKbn6rHzVAZOQlR67BxPBlEk5rS2uUNUyZ+/3j0TM2kaGMcvdGcBrJQarmi
	/TSN74hpLJHhUlxQFIEyxVKVMumrZRp0N5TheJ5jH9LOu+8TAzgUlv67xUJlX3GWpStgfWYKjDJ
	w0VDAvRX28OSi5wl+dy0XVmxzBvKAuN42nQRk9vg88jNfxSx1MPlpWWALtVK4A/tEmGnz2uUg+m
	VlwXCiywqktjh9P
X-Received: by 2002:a17:90b:48c9:b0:361:472e:3be6 with SMTP id 98e67ed59e1d1-364a0f63e5cmr3448553a91.26.1777462174393;
        Wed, 29 Apr 2026 04:29:34 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-83-234.dynamic-ip.hinet.net. [36.225.83.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988772ca0sm21162815ad.11.2026.04.29.04.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 04:29:34 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:29:30 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Changwoo Min <changwoo@igalia.com>, void@manifault.com, 
	arighi@nvidia.com, kernel-dev@igalia.com, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 0/3] sched_ext: Improve exit-time diagnostics
Message-ID: <20260429192218.G59fd@cchengyang.duckdns.org>
References: <20260429082318.420146-1-changwoo@igalia.com>
 <e7cbfc99b52b4b7059267bb81498179f@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7cbfc99b52b4b7059267bb81498179f@kernel.org>

Hi Tejun,

On Tue, Apr 28, 2026 at 10:57:27PM -1000, Tejun Heo wrote:
> A few things I noticed that might be worth a follow-up:
> 
> 1. scx_rcu_cpu_stall() takes no cpu, so the captured exit_cpu ends
>    up being the detector rather than the stalled one. We could
>    probably plumb it through from print_other_cpu_stall(), where
>    the stalled cpu is known.

Do you mean we should change the function signatures to pass the stalled
CPU through, e.g. panic_on_rcu_stall(int stalled_cpu) and
scx_rcu_cpu_stall(int stalled_cpu)?

> 
> 2. scx_hardlockup_irq_workfn() already has the hung cpu locally, so
>    passing it via __scx_exit() might be a bit more robust than
>    relying on irq_work routing.
> 
> 3. Minor: "on cpu N" (kernel) vs "on CPU N" (UEI) - the casing
>    could probably match.
> 

I have a draft patch and can send it out. If Changwoo or anyone else is
already working on this, pls let me know!

-- 
Cheers,
Cheng-Yang
