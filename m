Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E094B30E831
	for <sched-ext@lists.linux.dev>; Tue,  5 May 2026 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970159; cv=none; b=VbRJhiROUZxGez4lFt7rTvODWM/vka0wQxevjOsFbZ/mxNW0mPINMhNGF09eaxW5GMBN9QPbX04IO3kA6nNW6MOAsTfGAgysj+1M7IZBdA28aKq3KFtgmntAEzpnKIg/Rp5nXT3aVvP+eq5VWsrPW8y02gbuXsfKLsSIEd70+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970159; c=relaxed/simple;
	bh=hJGwJg5mSZLDRKOVlhF+uT/spvPBAeBFPKUZm6yxGQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFQHPel6YrxD1nVISixcSSXfHlgGhk5jMxRUydLH5FOnOWM8JF+pMB61H+Yybt87SbwFg76BUUpD+WXZsY4ocJOldW2gDj9PkKoQcP5yaY1lMc9w2kg1cQlyGUKXaeDDaZp6aVr93XzxSdfzSBz6SQKYRzROiQxb1YfGNg9BJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DR2x3TEU; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR2x3TEU"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3650a4eb605so2179966a91.0
        for <sched-ext@lists.linux.dev>; Tue, 05 May 2026 01:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777970157; x=1778574957; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ei/a0my4gmUeb4OZ1t1yPoOC9vaBWAkDWySmtj7cfRA=;
        b=DR2x3TEU+UGQSJbGi2Nk1lxl2W5PBDvQO8qXZYnNp705mk36ZRHO8jIsdgza7ajnzu
         0Ms6ZhtOKy93boOOHdF0f7V7T07ugonxBiV5xb2Tafd55NZijIh9vCIKMsTw24zSJrz5
         Z9ribtE5grja2TajugR1HNlTjZttCFyxbfVOu/GMqlJ/87Ip44LphvFwWe87Ff2oncND
         riZsiVqSvx/5ov+8Z8OdNXXNpX8UV/zYOGPe23zddGd1bUrfAVAJkGnfBpyJlQw8FFLF
         N1DXnE004FgYa1AEwsjOJSid3bMJpxw3QXMFJ92hm2Knt3J7SJgUa48eDV5wvc9Tp/ZG
         NXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777970157; x=1778574957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ei/a0my4gmUeb4OZ1t1yPoOC9vaBWAkDWySmtj7cfRA=;
        b=iCfiuJmps3iMVpyGeEosYf7JU6wdpGxs5a1egALr6XBl2TZmLA/BVNuHvSbeXrY910
         PVjJ3nPtIgp8OJGHCA4k4K84sKndLmo4V85fxAWHvr+0Sm2lgcLWeQHruwAjbuwNBgq/
         Kzgr4/C6IM/CQERPnYoL8z9VBVhVDasxsXrqoCeVUW/jEVYmJWpp91lSquiBm/PsrYrA
         4G+6MsM1UBb16kRiVT4r2y6BGaoRSNpqXmipAOQh+p8EMtBhwOYbsOVdydT1Ka38eehV
         GA9d6exZB6ZHi6qnYzK6EKNNs+CHmb+Eh+SziR3Ni1DNv1NaWzH3AD0gc4s/+yA+TXyt
         o24Q==
X-Forwarded-Encrypted: i=1; AFNElJ8WrZzdmdQKzARpazEAn43rtX4fs5bbm5Mh3P8xhNTU/u9jEb8By2hzZhCcmp78/9qwXPPqjP4LwqQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwAcgA444ssFJgLv3bHY9Vv3UeaVPEjaDA6GItTz6ZipD/O4n7N
	p24OR3EuD7c+4gXYo1Ww718j8C4Wg+OnVigUEdUSTY5wdLWWQto1jtkl
X-Gm-Gg: AeBDietArapvcEIFXZhKt4Ahu5dua9eM1YnYECXGt1bwsDUSnvHPo5kGuhRwcTHklOL
	6cvqDSCkUifVzvhCW4/HUxa28sLPQ5hfSld7DQXYD+gRKZHBILqfek8H5XTrqSVRAVlrT5TrRUg
	x/qeMfRyMKeYyuwNd50lESyMeQihzFjl/zD2EJdPMjziq5EwH4wpAs24xSdIA2g49Q17TprDqkQ
	CY6EHC9nY3K1bGP+3HxY442R4ZCbYSa2edzNc2ZMiayVU6A+Lt/CGsGwvKPg+1/ks0+u62ou8tj
	PBPYbE5XyuvoTneWaDjBfMiX/eGS0AcnyOXv26Rpl9Mt5qTWqNxjY4491ncH48xoNjySieLAYle
	8L3mCDVaQMwaN/0MnySvdWoBKAlvZBv6BR2N0217jEDzvml8znIykt0YavM4b5dD7TI0jqsBXfo
	KyTMjmkfGhe1DxMDH0G+DL7IB5SO2Y7dWG1FH0eaqmBx4FZLKCldbov4L5XZarputo6Geuj4e3h
	sT4+571aUTfQEvL
X-Received: by 2002:a17:90a:e7c1:b0:35f:b7f5:9b3 with SMTP id 98e67ed59e1d1-3650cd863d1mr13719073a91.3.1777970157264;
        Tue, 05 May 2026 01:35:57 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-109-31.dynamic-ip.hinet.net. [36.225.109.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec027690sm14337636a91.13.2026.05.05.01.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 01:35:56 -0700 (PDT)
Date: Tue, 5 May 2026 16:35:52 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, Kuba Piecuch <jpiecuch@google.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
Message-ID: <20260505162907.G7f07@cchengyang.duckdns.org>
References: <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
 <acHJED4iAeytdC2l@slm.duckdns.org>
 <20260422142633.G7180@cchengyang.duckdns.org>
 <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com>
 <20260426093756.Gd781@cchengyang.duckdns.org>
 <DI3TFV6PNXZ7.3OR8GY5SBIEZ7@google.com>
 <20260502000039.Ga94c@cchengyang.duckdns.org>
 <DI9QFXIX3Z0R.23PU1FB6DEMPS@google.com>
 <afkOqQRB1YqSlL4x@slm.duckdns.org>
 <afkWfRVZjvieQdyD@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afkWfRVZjvieQdyD@gpd4>

Hi Andrea,

On Mon, May 04, 2026 at 11:58:21PM +0200, Andrea Righi wrote:
> On Mon, May 04, 2026 at 11:24:57AM -1000, Tejun Heo wrote:
> > On Mon, May 04, 2026 at 08:00:50AM +0000, Kuba Piecuch wrote:
> > > Random thought: If exposing qseq values to BPF directly is undesirable, then
> > > perhaps a less objectionable approach would be to expose them as opaque
> > > cookie/token values? Same semantics, but fewer SCX internals leaking to BPF.
> > 
> > Yeah, cookie sounds fine to me and let's clearly note that this is for
> > schedulers that don't implement properly synchronized dequeue.
> 
> I also like the idea of exposing cookies and extending scx_bpf_dispatch_cancel()
> to support direct dispatches, it it doesn't introduce too much complexity (it
> shouldn't be too painful).
> 
> Cheng-Yang, just to make sure we're not doing the work twice, are you planning
> to work on this?

If you are already working on this, I can help with testing after your
patches! Otherwise, I'm happy to help.

FYI, I'm already working on deferring ext_server bandwidth to SCX enable
and releasing it when disabled, but it still needs more testing!

-- 
Cheers,
Cheng-Yang
