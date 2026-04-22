Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228372D5436
	for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776821018; cv=none; b=qmjobEhX7utesu/vABmhDeZWHzazCjP/jD6MyFg+V+3GV8YDO4dlHV7sgTUGuKskfKw6nLo3hRw+/c6zb5bNlz+gUWKYcdPyAkrfRCktX1vvzFigHPd+3KF+7kIdJkfrxxbB4/vjLiJwDtoprNtqh2pZF09E81GoDxbgiwNm520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776821018; c=relaxed/simple;
	bh=bVaMdgkx+lIojBcrKUGpyboZMA05m+0YN54LK/A7dTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lam5sroezR3hWwQ4qbS6VSO8X/RsnvtyNIVGzWi0nTUpHeEbtqD53QiCgcBNZnFHnFCxYXlexDIjDrE1bohuWLYDS4ZwdTAlBvtdHEiwBoOFAja08AClYEUGHEPYd0jXhMR7ZWzKOCf072tTDC0tByu40afoht75H2W0Snw7GdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4KWyrK1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4KWyrK1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso3322317a91.1
        for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 18:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776821016; x=1777425816; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=93XI6b6ByOCzNa1FWodfwbq6SgsFQ+R4K8Po/BxwyTs=;
        b=N4KWyrK1O/SeQV0jvq0hGJrAuZibixkEW7LdeKFAPWn7HqAUj/mz4Z6sS/dqmf1cPE
         Kj/XEmjHf424OaiJVozkA9+D2vKLVDwA31eO8L/ClIFoEruepv23B9xGIR1as2w5JoXC
         ddVf/qw0pRUqGtGx/imQeQ12s/bP/1WLFkJXXVatLAhAOPLZC2Y4bddPCneSNob56l0C
         Fxxv1l2dfCyet66hewvXj6Akl1sOWhd3TXmfJbpIbUU+gW6vSHQOvSFN1kuolVCldExN
         r/qQjFjyjGiuJLQgpx7kNoyxJ1wzs8hprEDzrBjbjY+fp6oO3AYuQo/GJffznDz6zKiO
         npGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776821016; x=1777425816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93XI6b6ByOCzNa1FWodfwbq6SgsFQ+R4K8Po/BxwyTs=;
        b=Y5c6Ko1GmG2+/JYsk3o6y+1ybToCyV2YIcvONmBC0Ebza1YD6Ckj52uFO77Zaxuwkj
         SU/XDcJGUHvJxObq8R7tJfTe9BfaEACCwAPqEKGPMTLd5J3mTBtTIxw+wKivGpVwpLPc
         soaQnJI8exdoHeQLGs+JN/KE4ZgtrmgPNPgERT6xubYU/58+F++0E/59rQESmVNrWXQX
         oS8MBuIGnR0jc2wndEIeiQXDQYaAeHvkxkF8cg5YKZusC9wqJdmqrTZ4z16bKGL7WfiP
         Pp0B7fQwsYb3u9GOKyMI1jwbsW5IgxmdjLxFxRKnjniXfgclR4kda42q9kesXQz/4K5u
         97ZA==
X-Forwarded-Encrypted: i=1; AFNElJ9r+Oly30iKnzMihPn+LTCmWtQtJzeXEgKdkQVwqIZfiAQnrHOdFRBcbGVYWpfjOdgvldWlK/tBj+Y=@lists.linux.dev
X-Gm-Message-State: AOJu0YwwgvoWu6bhA89IG8BrhXGnAw+uAQmtjjEtJEfLib2cQpodmMpr
	Yq3i2u9uiB7dWcGsN0MJz9T4/xzscY5anmUwilrF2qWWPrFJjOAz5XvY
X-Gm-Gg: AeBDietsc5ZXWhI0ykvmJA6vYWQssl7Jm05+lp4za4vHfnsdXJL6jBxq7RKYAck1kji
	wAO58lPsq0zBGGehRhD91VJct1rgFGArbKY5nFuGA19pw1vCmRAF3Xxw4rgI6XXvv9UruXtc8fs
	5BwjE9rFrfu6yaFId2bVUq0vewFCL3PrmgHYLCWjUJUL3vDD3ysJHF9h1+dcK0EAN61V9EiOMMX
	8mix7OsZ+Ur544s7uYteXSvEBwEZs0JG8m6WqCXODygWKw60fWeVmJqqeAqNTP67/tATOTBvDqm
	Bst/C3X78EKoiIkijIckwVRcHMCpnJC+nCSfZaMtu54nihHRIcDTc70UtobxlV2226bLrt8oit7
	SRqvOKcT7TpXZyZA6fyUZWvb2IZRXqFj7AwHxduBoOaZrngyI+vfZri5qfK9hiUtF8X2Xqsrwo4
	6csCEypp8bFbh3Q4tmg75QksjT/VwQPUqPDjXyyiGjTniKCMBSuEJSooX02SELsJ1hunmwpWiVR
	bd9v/uzhY0fAii8
X-Received: by 2002:a17:903:124c:b0:2b2:57df:264d with SMTP id d9443c01a7336-2b5f9f61ad2mr227023885ad.33.1776821016314;
        Tue, 21 Apr 2026 18:23:36 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cdc6sm143067325ad.46.2026.04.21.18.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 18:23:35 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:23:31 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, emil@etsalapatis.com, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCHSET sched_ext/for-7.2] sched_ext: Topological CPU IDs and
 cid-form struct_ops
Message-ID: <20260422090721.G2bdb@cchengyang.duckdns.org>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260422015408.Gac88@cchengyang.duckdns.org>
 <366940a49ecc5307db2654c49b137a4a@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366940a49ecc5307db2654c49b137a4a@kernel.org>

Hi Tejun,

On Tue, Apr 21, 2026 at 08:33:51AM -1000, Tejun Heo wrote:
> > 1. Regarding the ext_cid feature (same as ext_idle), is it feasible to
> >    implement this within the BPF arena instead of the current approach?
> 
> No - cid-form struct_ops translates cids <-> cpus at the ops boundary,
> so the kernel needs direct access to the mapping. Building it also
> pulls from cpu_to_node() / cacheinfo / sibling masks which aren't
> reachable from BPF.

I see. Thanks for the details. (I was wondering if there might be an
opportunity to contribute here, but it sounds non-trivial. I'll just
keep it in mind for now.)

> 
> > 2. I noticed rust/kernel/cpumask.rs is already in tree. ... would it be
> >    a good time to start adding Rust abstractions ...
> 
> I'd wait for a concrete in-tree consumer before growing Rust
> wrappers speculatively.

Agreed, it's definitely too early for that.

Should we also update the doc? Perhaps adding a dedicated 'Topological
CPU IDs (cids)' section would be better than just a one-liner. Also,
is there a need for a standalone selftest? I noticed scx_qmap already
utilizes ext_cid, so I wasn't sure if a separate test is required.

Happy to help with either, thanks!

-- 
Cheers,
Cheng-Yang
