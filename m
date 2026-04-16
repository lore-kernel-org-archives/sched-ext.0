Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644EF3FCC
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776315733; cv=none; b=qWkwn6fe0MKocKT0NFG2mF9Yhh5vbu+RAaugmaeGZQrZ3SwYzhK2//dzaplKCmrV0lIXdXUtFps8Lv39QiF4Bu47GAZ3/luGCNe9+bwQvTOwvuk+VbR3yhGZzL7W3ZTP71uuhRVyteaYpGfl2Wumq3GCeeo5QN5qatCcUisjezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776315733; c=relaxed/simple;
	bh=Qw8DxF0aKSi2cgqXR2ywTjiOu/drTOFeZ5oRUKpwNNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cppc0EkGHovasMYWoQJcJ8aohMZF2yR/koMzo72McNk7iADNkLGntnddEOQtwd76bCYGO0NP2Y0H59nAUptr/NMaHkIzWUPMvuCFp2KPRmp4ARNbdNAj+AutG+fuGuzubQ1BGQUyNdxmb686/FcilkM5yWVk6ce+ZM+b47h9scM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh8ePk2f; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh8ePk2f"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso4849501a91.2
        for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 22:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776315732; x=1776920532; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8w0UFz50pwCfEEFsCgc3fUK9YMukoigInppvLm4bqWA=;
        b=Nh8ePk2f4r3VGPoPj6I90GtG6oFgPfcJwmiRem5d+AAJPXJznSf2wQ+D2lcXJ2tnpk
         e1Om+bh23VICxjD81KKnYyVMTbzRyhBZm1jx+sd5WB7y/BY3cNhVLVbTAbdwcXE6BhFQ
         dMIS+bew5YoyqnKZkJKsSd7yu2c6QVzhfKvWf7+DftfIjgryWwq0WaXVe2JwSanDIkvb
         dBCt4PMzFUoT2ASw9HUyuMAHctshhR+xq0H85IC2u9DvqA0I1BHe++7Wl0wgsxnwum3d
         AUV5ToKiD8ANB06NHu394dqw/9kRSU5dv1Joz3a2QRQrThciHNfQWJ1HsRPDDaLigfEe
         VENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776315732; x=1776920532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w0UFz50pwCfEEFsCgc3fUK9YMukoigInppvLm4bqWA=;
        b=UkKAMea4RYm5m1FM3SJ+NsyrEiVqfDs/LtsdwjMkCgjrTf2PoKfc09sGmGe6ULiyqy
         sXfqkgGZOXcLA5S7okPEKDuphzYgat2nksv8t0ARzFEfjHvG13plW8/SzX+eGKucETCd
         0PVt+ZCmHEeUM3342ZixoMJa5GAnk6Gzc4yl/fn+vCzdFooFww5r33gd+Zjjde9eD9g0
         GldBYosWhYg3GnTpZJa/rXhwTWjMHF6+x3HT9scZrUmpJ1VvoFUgc3HeF64kRtCzWY8U
         T78SkgJwJZDAX5WT8kxB1hKOMQmPehef1fiQtvDYnGYX5UF7HcTpKiJja0rbn//naKu6
         bFDw==
X-Forwarded-Encrypted: i=1; AFNElJ++4/tpH6mQtEhoecF+0iIgbslCBZOjvMp1Heb4qxk5sgIT8yQ4f8h9tpjNe942w304/POm+dW0jGE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxiWbQB0vcDzYM+3YdVkc1HcoQeZyFT0Gxj1fW9Uo0RY3bX2NvD
	HF20FOasOSyUa6Oa0YSMCXPSNeEa9rxd9c1UgtigCDFJPZns+6lAH+K6
X-Gm-Gg: AeBDietQMpk3mTKfGjUqPp17R3LicMCUmKfjghcyQS8LfqwDwvX0DR3UhLBclmjSaJc
	EnwOrnoGpkrX0RcZf4MG1OdQE8Mf7eLB/E+weMl1LtXSC1HjFpNxiEsKixrt59adiIz3SyQfmSy
	0Zsr+ERDxG+t+f1d5Q886EJVmjroB41chxyvn9ReA8FjDeolpT/o5qPiF2x2gKpCP9BMmkvir6o
	SKBTyn9kMN7y2V0+kN5PmSIOcDz3nXap8hwQ06TK/L0HVmB7EHCXadudK43t+T4kMKscjNoBASD
	kHjIWihXXy2C0maP+8V2qSuUXp0+DRmLzJgVno6BhbCPlGME23mzWAggJsXMSvA1Pz4fSZkHHaF
	9HC0U/NXdxuHGiPFRiQfIpC4xS2Q/O49n+dqsouTrr2PFdbLGK6gMHWSGC6fAJPiKOA6vFoDYWf
	DSthwJ+NHOtnUVQGWKpI58aF0Px0XS7p0Jq6ho
X-Received: by 2002:a17:90b:4b86:b0:35f:b86f:6ae6 with SMTP id 98e67ed59e1d1-35fb86f6d97mr15000316a91.22.1776315731495;
        Wed, 15 Apr 2026 22:02:11 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:49:cbd5:ab58:206c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd0aa006dsm1541309a91.14.2026.04.15.22.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 22:02:11 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:02:06 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Cc: arighi@nvidia.com, changwoo@igalia.com, chia7712@gmail.com, 
	jserv@ccns.ncku.edu.tw, sched-ext@lists.linux.dev, stable@vger.kernel.org, tj@kernel.org, 
	void@manifault.com
Subject: Re: [PATCH] sched_ext: Prevent RB-tree corruption in
 scx_bpf_task_set_dsq_vtime()
Message-ID: <xm6y76b24y4tnru4tbpm6kgcmnruduzfeqihz7hla4uotab7ul@onc572gdkyyv>
References: <20260415193459.933175-1-yphbchou0911@gmail.com>
 <7ad57375-c651-4fb0-8279-bc3423157255@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad57375-c651-4fb0-8279-bc3423157255@kylinos.cn>

Hi Zhao,

On Thu, Apr 16, 2026 at 09:49:56AM +0800, Zhao Mengmeng wrote:
> Just discuss, if is better to use WARN_ON_ONCE instead of failing the
> scheduler, just like the check in the beginning of dispatch_enqueue().

I think this is more like a misused scheduler API.
dispatch_enqueue() uses scx_error() for the same category of errors:
- scx_error(sch, "attempting to dispatch to a destroyed dsq")
- scx_error(sch, "cannot use vtime ordering for built-in DSQs")

That said, I don't have a strong opinion on this. :-) 

-- 
Thanks,
Cheng-Yang
