Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597783E2746
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939892; cv=none; b=J9yWDfkTOYoAbsQGSEQkTN5LsxLGsQVo7DOqTmnun1XTQY6ynmko9ui2pPtyQO5J4m4yVJsM1T4Bi6sK3jMVrdm9iuP7VFWdRQxIIxpRuBUBnrxI0OXPSmF2zl2xVURZnMiybdxEQtiVkcu6iTlZL0wQbSJ2sFEPdKFdMH/bC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939892; c=relaxed/simple;
	bh=z11t9LwXEAps95nmJFn9bgrfWgmUbK8OsamIUC9xo1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2pvXshVq7rhaRqitQ1ZSraL4Je1Rkj0gz9a59XHa0peQ9lWQnE8AgOrTSgAfoRxDPU2UXJZQ+NuS59pYErFFHR0aj0TinxuDjIRIgBMxNs9n2gKjQJiJlEudxHxUpgle/nel5cn/iC/Dl4tY+oZSGuZ6eG8LmYq7BT5P78zuAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=B/Lo457f; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="B/Lo457f"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b966dd74so10934305e9.3
        for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783939886; x=1784544686; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0xXW5DaPK6zTkeDY542N1FQHx5XzZ6y+YRGl+QSs6T8=;
        b=B/Lo457fDsJ5UnqMVndwOWi2pdwe1wkrsmOVa1oSknZjENuNcUiGz70HxsVzV83wgU
         mUqKENmuS3GQe2coxpfEYNky6ztaSq/XiXit7PxMaVCm3Uzju4mH6thKXfP9oEKhMLVd
         kbjf/48AeMYk1cP1PjXBv54HIufiPrZ5SRT+jKwdjC/YUMuylPRhNyGRyv0IgrfSCYbw
         KV8lF8LV3i6lmn1VuOyUb7OuGhBRyUVrlL4+ctlCUd7Jsyx4KwPAuD45ZgWN+yll6gvP
         96yT1hkyw5MWc+Bs9C8q39qPgPfogwLziN6/bgocHrWpt30fPGdpYXJQT1dDmkBgQIcp
         /OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939886; x=1784544686;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0xXW5DaPK6zTkeDY542N1FQHx5XzZ6y+YRGl+QSs6T8=;
        b=bWG748vl56uj4PxeOc/ktet5W5I8JBRjkP/a3D2IP+rTDjPe/vfe/ZUV7z/N9wTpnG
         ep48r268RbzREUcOBUwkqHrcVC3yPgDBs5Ext7CZ3giKQZXnb001D5jLbw8sfBCN8A+6
         xhzJifxCs3uFPoFjlB99faxdA1DO8MInIMLJfZm8lDBKOXY65gUEqmMqczXfHqd8mIXk
         h4L2kCkqIDgZ3oDM4/zrgIR+HadEIEeQSuinGCoHOIaDncIPl+hxdkWR4w05WXsNtpAu
         B9zuHdqpRrcPX1YyBamz53Y3SvKBb83fdR8NzSkIrY3P30yXtaGrl/7VXkc55060owmB
         r68w==
X-Forwarded-Encrypted: i=1; AHgh+RpWBKwDZ0P3+w6m6wlRGF3J/ef3SZj1MAAfza0n5sL931YjfSowgErGGYLv+nRIVATorZaBb73FquM=@lists.linux.dev
X-Gm-Message-State: AOJu0YwOXl+fFMUselVZF+MyNvttwTB38vwhVGIli4SglaT2ba4YQiiR
	k1EpQ3sR+50FZ/t6+26dAUnVUKY9/MEqz6o4fmuM9Z7lWvaUh4QXxsRzyZ+B16qvDyY=
X-Gm-Gg: AfdE7cnDo0eOqrZfa7HJLYdABao1pzD0cZwwrNN1vG3x7glyTjoMULRj+h43Z2PiJe7
	Q0DG3dEtaGzIkyR2h9EJ+AJ/OnoUZsEB1Q3p9gveqCrOLfxq/qS3ezoAH/5NrI+00y5iR3cQm51
	YvWz+xr5vP4sCVRxZ3E1jvy9eiHDxTFvN358mzuG041JGTx700963cuBAACyws4O4MhkY79imgl
	NVJOd5wo5Y6VIPvgxqQUbpiWa4QzGCR4ZLoezb6yfR912KymjWzuYNPSeRXvkDdmLETE7cNC+/x
	9x8bXE/IZFHnTLGlhGTmmIma+c3g+hmHA8eXTTVPAKhnnPR/5J0DlMrx25XkKjDfqOuSK9o839H
	IUln+y5YSU0QUqAE5HJ7+8bH5lcpz3fM84k1RkY9YiHpUd/KCY6uDl4mozgkWl2Pz7OFl8ENiAC
	TX4P8sXXRRyg==
X-Received: by 2002:a05:600c:1906:b0:493:c8a6:b517 with SMTP id 5b1f17b1804b1-493f883b7e8mr84731245e9.38.1783939886273;
        Mon, 13 Jul 2026 03:51:26 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3b85sm573716585e9.2.2026.07.13.03.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:51:25 -0700 (PDT)
Date: Mon, 13 Jul 2026 06:51:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tejun Heo <tj@kernel.org>
Cc: Matt Fleming <matt@readmodwrite.com>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	"ziwei . dai" <ziwei.dai@unisoc.com>,
	"ke . wang" <ke.wang@unisoc.com>,
	Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 1/2] sched/psi: Create the psimon kthread outside of
 cgroup_mutex
Message-ID: <20260713105123.GB276793@cmpxchg.org>
References: <20260712174619.3553231-1-tj@kernel.org>
 <20260712174619.3553231-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712174619.3553231-2-tj@kernel.org>

On Sun, Jul 12, 2026 at 07:46:18AM -1000, Tejun Heo wrote:
> a5b98009f16d ("sched/psi: fix race between file release and pressure write")
> made pressure_write() hold cgroup_mutex across psi_trigger_create(), which
> forks the psimon kthread for the first rtpoll trigger. As kthread creation
> depends on the whole fork path, the commit inadvertently created a lot of
> unwanted locking dependencies from cgroup_mutex.
> 
> sched_ext got hit by one: its enable path blocks forks and then grabs
> cgroup_mutex, so a pressure write racing a scheduler enable deadlocks, with
> every other fork piling up behind.
> 
> Fix it by splitting trigger creation so that the worker is forked with
> cgroup_mutex dropped and the kernfs active reference left broken. The latter
> matters because rmdir and cgroup.pressure writes drain active references
> under cgroup_mutex. Publishing the trigger last keeps error reporting
> synchronous and preserves the of->priv lifetime rules.
> 
> The trigger registered in the first stage pins the group's rtpoll machinery
> across the unlocked window, leaving only creation races to resolve. The
> catch-up poll on installation covers scheduling attempts dropped while there
> was no worker.
> 
> v2: Retagged sched/psi (was cgroup).
> 
> Fixes: a5b98009f16d ("sched/psi: fix race between file release and pressure write")
> Cc: stable@vger.kernel.org
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Edward Adam Davis <eadavis@qq.com>
> Cc: Chen Ridong <chenridong@huaweicloud.com>
> Reported-by: Matt Fleming <mfleming@cloudflare.com>
> Closes: https://lore.kernel.org/all/20260710100441.2653477-1-matt@readmodwrite.com/
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
