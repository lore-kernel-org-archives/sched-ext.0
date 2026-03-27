Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2B8281503
	for <sched-ext@lists.linux.dev>; Fri, 27 Mar 2026 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774638113; cv=none; b=PZjxSiQt2iBNTRh90ARwIkO6D2Y/zD2e47LOVAIedVlKLs8PkI8UbVhR9EDtCXtvI4puPYDCUNgsoxiXP3Rhquv973O/Wyvy6+hykRmqiiAKj4qRgrvcTBQicIXsowAUfTQJqqNVawAh9vx3q2rAUy9LiR3ZZYKQUphwMkZC4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774638113; c=relaxed/simple;
	bh=LiWRraASJpgGhbI/QSJB6HOBO2yS/0VJunAELmhXhYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3KpIGdv0Cc6U+qgm7syjSmubuE2jcSGZnzPSjzZxNhPy6lupfD+vLL+OSrWGzJ2iqti+3cWUyjpMn2oQGsaJR7O3fP0Rb7RAidTIorM+EEPRQ3xEKlyGPvGndo/tX+C05fe0ffd2QKSjUgQ7s7TrEwhHYXzOKch74XhPmomFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENiwZXfL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENiwZXfL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b23f90f53aso3251355ad.0
        for <sched-ext@lists.linux.dev>; Fri, 27 Mar 2026 12:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774638111; x=1775242911; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0SRbtILbJJpo13jSj5rB57hTbH7kFXYmzjKB0QBv+Hs=;
        b=ENiwZXfLuBEFH9+IJyQC1GMnBS4ChtFXS38BolkNkEbAar13xAkuPOj0PyoDw/IlEr
         3NnjD5L0lcz+VWfIfQJjAC9UanCLA3OjYk4vW7yk33PPX9V1gM9aM3vLW8g1xM0DuZbU
         TeseW/3jF3nZCrkLxmtEZe7PDPTSM45p+o+aSUULiNcRNZstaWwVUNL+709V+enAkmkG
         9iYmq6RNwEEF+weUHEf+B6RFSQyUB19gnElJwjKXmnj4/9/wJuXgE3x54tKQ+AdSfIRb
         3G2aGuXDSda4tpshasvpQuDAbA7HdKnLcGI4F1S33Pam1KV1OpGTqtwNLvpziCiarvBU
         IpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774638111; x=1775242911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0SRbtILbJJpo13jSj5rB57hTbH7kFXYmzjKB0QBv+Hs=;
        b=dEP2y/EVyHGdzBUXMlSDjzLOC4ZcUa7gSI+abBEp1Qw6pYyHCUS6P4o+DwQ1O/J8O6
         d9UU9XxZzQPN1dXQagj5WRNYwBiaw9wZ/wEOjLsuoe4oCS5ajEzhliYhT3kNa+IVIdU6
         LVGrNOP2q4rWiZvdM9tJ0n/5xoUtglbUj/hWeiq+5IJu78XO/c1dJeOj3EcdXZkSyyao
         9qEtTe95aIG/5fvpzDQV9bNa1rnZ5cElKJ/a4nEW8L/7f4ih6b8U3G6UO7RoYd3B3z36
         VywaQk/koWS74mXLRTFhwIMyIXbuNaxKy7UMQZAq61vfWAlD6X39hZ1+Wn0ErvCxSRgJ
         +bnA==
X-Forwarded-Encrypted: i=1; AJvYcCX9wkXvTXqw8N8qjHvJzoa6cpKfSa1dEiz0IW/oUKAWJBCym5HZ8dMtDG5wjoD954w4nJ+Zb+aTEvY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxFgpqzdjSiFqY738lHvdiFPQxWHSxr5hxmYcX/yAIgBgbc2t5a
	E6zcwGTThSrRSGBqYpdlAqOmzzk5cOiH65vZJa0BQg/21KokWMCte7Lg
X-Gm-Gg: ATEYQzzHw5uI1/IU5zfGvSlAWFTjy4XpF9xAwlSIfF9qPsdTtcNlFzwX7ynfJviT+JT
	nZUPSHnlyfouu41w2r7oDbLW+prlqVLHNHUk1Ogtio5bPTjIlwws9p7SK4FNx03tJ336hoUfkqb
	jGG0CN877BdKVktyxrsnDPrTc02n0h10Voaa9tdWrbCVUO6RiA501y0MX38i112djoiXVSB0V5S
	jrpSKEFCbBJe4aUErmIg7Y7w14HIIufdY8XLijyMINbVLQsBarzxI6ysr6rvSCRclOGO6JIjyHU
	Axoo6oxSnpF40o93BEWC4LcQrIoWm4tTkrlAqownB0Xr71Sx0l73cemFJ0NO8KHxVH0q+e+wdm+
	bhlVwieD5nee2FBep/NZ6Nt47iTksdB6wzxeCUfd3ifKO408nQxbpISLDjplj43ut/QRs3Pwz8E
	42JJT5DCFkbyfZMTUXtKgAbdli4Vg=
X-Received: by 2002:a17:902:db0c:b0:2b0:a980:367c with SMTP id d9443c01a7336-2b0cdc20304mr41331515ad.2.1774638111025;
        Fri, 27 Mar 2026 12:01:51 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:367:9d63:195c:593f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242795195sm198815ad.61.2026.03.27.12.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:01:50 -0700 (PDT)
Date: Sat, 28 Mar 2026 03:01:45 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sched_ext: Fix print_scx_info() build error on
 !CONFIG_EXT_SUB_SCHED kernels
Message-ID: <rifaebh3yg7awjrfhbnhbs4gshbynt44uqje6guvs76osgly2d@zvry7xpcdsok>
References: <20260326081021.687711-1-yphbchou0911@gmail.com>
 <tmzdbaqgbe3vypfbm6gdih6svfs6pyrdpnklgmmwc47brnika6@vtcswuax5dxq>
 <aca8A9UdYV8nElsB@slm.duckdns.org>
 <gunjxqantrttj335ai73vkvddqj5swkkfwvm5abkwprhiwjwwz@wktl537f5qim>
 <acbPa75X2LMsUUnv@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acbPa75X2LMsUUnv@gpd4>

Hi Andrea,

On Fri, Mar 27, 2026 at 07:41:47PM +0100, Andrea Righi wrote:
> On Sat, Mar 28, 2026 at 02:21:42AM +0800, Cheng-Yang Chou wrote:
> > Hi Tejun,
> > 
> > On Fri, Mar 27, 2026 at 07:18:59AM -1000, Tejun Heo wrote:
> > > On Fri, Mar 27, 2026 at 01:35:53PM +0800, Cheng-Yang Chou wrote:
> > > > Hi Tejun,
> > > > 
> > > > On Thu, Mar 26, 2026 at 04:09:15PM +0800, Cheng-Yang Chou wrote:
> > > > > scx_task_sched_rcu() is only available when CONFIG_EXT_SUB_SCHED is
> > > > > enabled. Wrap the call with #ifdef CONFIG_EXT_SUB_SCHED and fall back
> > > > > to rcu_dereference(scx_root) for the non-sub-sched case, which is
> > > > > semantically equivalent.
> > > > > 
> > > > > Fixes: 60d4b17e886a ("sched_ext: Choose the right sch->ops.name to output in the print_scx_info()")
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Closes: https://lore.kernel.org/oe-kbuild-all/202603261453.8kiJImYo-lkp@intel.com/
> > > > > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> > > 
> > > Have you tried reproducing the problem? This is trivial to try to reproduce.
> > > You aren't even doing the absoulte minimum. Before sending patches, read the
> > > relevant code and reproduce the problem. I get that AI makes it easy to pump
> > > up the volume but try to reduce the volume and improve the actual
> > > contribution. Otherwise, I'll have to mostly ignore your emails.
> > 
> > Actually, I can reproduce this error on my end with the provided config.
> > This patch does fix the issue.
> > 
> > I'll make sure to include the test log in my future submissions to
> > avoid any confusion.
> > 
> > Here is the full log for this reproduction:
> 
> For what I see It should be fixed already in Tejun's branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git
> 
> From kernel/sched/ext_internal.h:
> 
> #ifdef CONFIG_EXT_SUB_SCHED
> ...
> static inline struct scx_sched *scx_task_sched_rcu(const struct task_struct *p)
> {
>         return rcu_dereference_all(p->scx.sched);
> }
> ...
> #else   /* CONFIG_EXT_SUB_SCHED */
> static inline struct scx_sched *scx_task_sched_rcu(const struct task_struct *p)
> {
>         return rcu_dereference_all(scx_root);
> }
> ...
> 
> Try with the for-7.1 branch.

Thanks for clarifying. 

I see that the fix, and I have verified the build passes there.
I'll make sure to cross-check with the latest branch next time and not
fully trust the robot's base tree...

For future robot reports, should I strictly follow the provided reproducer
steps, or just apply the robot's .config to the latest maintainer tree?

$ # on for-7.1 branch
$ wget https://download.01.org/0day-ci/archive/20260326/202603261453.8kiJImYo-lkp@intel.com/config -O build_dir/.config
--2026-03-28 02:52:55--  https://download.01.org/0day-ci/archive/20260326/202603261453.8kiJImYo-lkp@intel.com/config
Resolving download.01.org (download.01.org)... 2001:288:6:91::a87, 2001:288:6:85::a87, 23.220.230.175
Connecting to download.01.org (download.01.org)|2001:288:6:91::a87|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 258088 (252K) [text/plain]
Saving to: ‘build_dir/.config’

build_dir/.config 
100%[====================================================================================>] 252.04K  --.-KB/s    in 0.02s   

2026-03-28 02:52:56 (14.8 MB/s) - ‘build_dir/.config’ saved [258088/258088]

$ make W=1 O=build_dir ARCH=x86_64 olddefconfig 
make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/ 
make[1]: Entering directory '/home/eric-wcnlab/dev/sched_ext/build_dir'
  GEN     Makefile
#
# configuration written to .config
#
make[1]: Leaving directory '/home/eric-wcnlab/dev/sched_ext/build_dir'
make[1]: Entering directory '/home/eric-wcnlab/dev/sched_ext/build_dir'
  SYNC    include/config/auto.conf
  GEN     Makefile
  GEN     Makefile
  CALL    ../scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  DESCEND bpf/resolve_btfids
  INSTALL libsubcmd_headers
  CC      kernel/dma/mapping.o

  [...]

  CC      kernel/watch_queue.o
  AR      kernel/built-in.a
  GEN     kernel/kheaders_data.tar.xz
  CC [M]  kernel/kheaders.o
  CC [M]  kernel/torture.o
make[1]: Leaving directory '/home/eric-wcnlab/dev/sched_ext/build_dir'

-- 
Thanks,
Cheng-Yang
