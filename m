Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C53D3CED
	for <sched-ext@lists.linux.dev>; Tue, 24 Mar 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345924; cv=none; b=Ij8gow1ir0Bjv567yrSOebSisn1XH64uyeXjiJVsmPOCNIR0hOIanKL+8iPc7VNlCQF5WG8LP6QF19h8U80RzlGGol/LQHyL8grSMu6/e4rbm27gb/jaB05g1NkRX9anepNfwnKPZNZMUxXKK5PhTLZdqeO3osAM3YZvlzmSYEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345924; c=relaxed/simple;
	bh=y3AsW7L5Psfl56mA2O5mVBeP/ktDVN8O9jd9O8FkiNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFb9E9MV3G7tc9FaLx1yhpBk0Q0Z4eHpyOY7qXy1Y0qbYvegBNNZ4v9KpCA2eNZkE1Gg2footkP2LdYtNFs6HId6v+kX/me9UDTHNWWGJW6m1+gdcEaD4guMgPhzg9dIMoDZmdHJhow4JxiebjKdqWaVJdqXXCHRJfQFvJbSUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+iCqyog; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+iCqyog"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-359fea895b5so734284a91.0
        for <sched-ext@lists.linux.dev>; Tue, 24 Mar 2026 02:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774345923; x=1774950723; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNSQKR96Ph6PU2+WTxUXBVZPeZlunKVNf4AkRpX9SqY=;
        b=G+iCqyog/PXF3ppH+cfHhEE9LDeuq/oyz7QvmDhRrAkK6IGLWKAHWAUin1njQayVyQ
         ys1GwBZVa9+WQ2q4lxvtzFtf6T2fOPcRa3ATJ6DScM0o5whsoGmeTUFq3dXsSzlkicJD
         ed8T3k8WUnk6PJmxLnhaabqr17UcnRop08dJT5OMqsj07sZj/LWtsFIEdr47TxLr2fQf
         xEb7LgagYYntCCcyW9YgMEo73G0T3UmLWJxOZD2U4nzleeBgyl2zne83wGM+NC/xxCnS
         qm0gBLd+xpZGsGJh0yow9oz97pW+7ep+O9RX1S4xKar9G9GUd3QJm6yb29MmEDi0uJud
         J8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774345923; x=1774950723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNSQKR96Ph6PU2+WTxUXBVZPeZlunKVNf4AkRpX9SqY=;
        b=tJneS0Do74V5DgTy+OlCN0iMro2bk84MXY2s1sGOx++iTNBRIp8JQdXmkokpuRz3Nj
         L7YG/CWcWAV7QZyXWQ9TKjPKJhKCi2v4NfZwOVuGRTYj7ISo/HD/FMXd7jz5jkaTiBd+
         fWcJz+3IJzvjs61tyIh+XuBx1NjdsYtmY2XxIWjDhb/geC69PMXMN1FEPhGhwIABUgiz
         1PKgoGpsc0+C5+pCSZYFxzyeDdZiZ/pPeum9J1MWvr6KFC+3bJyov1H6Prtb4/l8tp2I
         zXWnNnfQgGob8pLvwDM80qeCEpYyxwtST3P1IE3XQp6XSMWZTiaMNITDgiY3wJGFu1Wy
         H1KQ==
X-Gm-Message-State: AOJu0YzxEd2ITnknrDEKfcaBFnBy0XkPuYGQbWruxIbkAW0KwtJnFWhz
	MnDngG4dCc/rLyyDGpmKMA/V1m2M70yOECBKlxxyiErXRsjfGzVnFeZBTziVwg==
X-Gm-Gg: ATEYQzx0E8s8yvBIFFKfg6J7TNXqh/f1q4ojcwSrFLH2e9K6XMUxwJW+CdJVhCh/swC
	L2PMNExHMfueiuws17ma6zNfBkpOZLPMpQYalvZWNkFSzs1Vd7J2a4aAHvN9tyLHX/0skDl0pmr
	322j8BaRMM5QJAa8nss8Cm1gzOD/8ivahP/F7N3NTPXA3oXbxVQ7+t7PZJ60nr5HloxIgV/NmVH
	wLcTM8vYofSAk0dcL7ZyNH26kLPce5JRK4S4MrKwlh62FXJNL/Hvsvy0Vgsrdwnq/GXPaPeTVwb
	BM0QKnIMb6gtOIps5Q8G8SOoXlbCdjC8+yqW8qAoSsMzlib+E7dDNs43HJSuBEpatRQqfrqytgf
	Xc6IOLwNRsq6pxX4s9XL+SDIimInyITYpVWCGfMFfGp4mc1TAAqKJmrFQAMcnBV8FJpHJegmWiv
	aBmCrrYN1aqeEL1Ed8nRU1aIXpf1gw
X-Received: by 2002:a17:902:e947:b0:2ae:3a77:a1eb with SMTP id d9443c01a7336-2b0827c3e2cmr147474365ad.39.1774345922629;
        Tue, 24 Mar 2026 02:52:02 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:c95d:66f0:4661:427f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835161a0sm167963535ad.10.2026.03.24.02.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 02:52:02 -0700 (PDT)
Date: Tue, 24 Mar 2026 17:51:56 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [RFC PATCHSET sched_ext/for-7.1 0/3] Remove __COMPAT prefix from
 BPF compat wrappers
Message-ID: <b443ekzuewazgq4f3jxnsxdxomjprahzihks2jqxp6jjjzw5eb@cs5n5r2iaauo>
References: <20260323172145.25689-1-yphbchou0911@gmail.com>
 <acF53-EU7azY08Me@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acF53-EU7azY08Me@slm.duckdns.org>

Hi Tejun,

On Mon, Mar 23, 2026 at 07:35:27AM -1000, Tejun Heo wrote:
> On Tue, Mar 24, 2026 at 01:21:27AM +0800, Cheng-Yang Chou wrote:
> > As suggested [1], move away from the __COMPAT prefix and make compat
> > wrappers transparent so schedulers don't need code changes for
> > compatibility.
> 
> I don't think we need to create churn for this. We can just avoid adding
> __COMPAT on new ones and phase out existing ones over time.

Make sense.
Thanks for the clarification!

-- 
Thanks,
Cheng-Yang
