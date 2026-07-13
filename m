Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD24314A5
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950538; cv=none; b=YcbKYMv8qUCvwE3b+jJh83eeD8IxUhIpW+0qElc1wDMF9RRVdYngC8DWL/Z+DgbbVOjzrsp7l348iXC5nbFHgIL1Kx3DqjzupRBAJ+BjJgzhm/ZxtOLzwyQQD5DZyu1ZLBJZMBV1yyvKZVyfV2v3XMZcRD9p+dJcYkGnqUgmZq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950538; c=relaxed/simple;
	bh=+UeBgr/3oETL59f/IS+j1IQ/p/NMk8/4+wpi5kr0WO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgiresdCEqKzanjAgtPEmepXptBc66vcOorjvIwkS3RwgE1StQIQ24GUZ8oqJO69IPD+OQE2NG508uhruxU+DxvIcYKSOaQDQng3/3YOlLAORG6fM2SrG1I9h5kXHtkiEPceLDV8FASm/rV0o2XSvHZKjaYKhCiTXC8zlrABCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=q7jtwkds; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="q7jtwkds"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69a5ecbbfb2so4796898a12.2
        for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783950535; x=1784555335; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eXn5kMcR5nKmIutY68IqK6aV4F4qyXcvYDJKsjI+c7U=;
        b=q7jtwkdsA0rLeutWqpyewQSjhLGSK+3bNTaVGCYKh0asXbfaqNAHNkPlO8Cs8TP/FA
         HTVaWUsKFqKe4voJVYeL/u843qJbzWmYzz68jE8ojMrS9fKbfMVHvVt/aLft19JeU9cm
         /+GkXJhS/AUL0XpQkOi5uQs8ows54UBNHzl0v/aJAay/nvnptSiCxLirjLLGsdganCTB
         GK2n1rN1e3fKvk/3PeY6uhnW8D2IOWTTGVq6PZV6FsacWR2rMCNkOfSqls7MYMq7gXFg
         S/LPiDsCPF1a2UmkRaA3JvqpEc3vXPkRCtcwTozn7Wl2oOQeVRVJuxYgrvIGNbVbeK5f
         E6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950535; x=1784555335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eXn5kMcR5nKmIutY68IqK6aV4F4qyXcvYDJKsjI+c7U=;
        b=SLG6s+zG6E83l1JDuI0QavUbeHdfQ6sz1W2BEQyjXLb4dK9Sd7ZPwZJ+pkRiCMFNTn
         C5giJmMK2Cruh6XBcl02rSvXnH5BxsnkEBmuPUyYRa/U5qJsqFUub5E95KGs75bF9aBb
         IqDjAOg6H3PBzklJqdri5RMiOeFklb/xlgyuWoKSdOuEWxkTdP72s0erGVXntSAC28vD
         HLfObG+/ompaBHzN5r975D9MngCmQEAszoC6gcqz7yfr1hSJnrTqC8KAo/fL7YHBA1fh
         3FfXlnhnj5Yc1BUo5dYA8onB7hM4BVufvayxzaQP63jWiSVxTWZHqnRriFqnSFMPMRlX
         Qh2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrBXFtq57aFoAPfPpmy2cho8/vD3kcCwS38qpXMhs1iMFdbC1PKFigAp0VCDZfHQ0XgPdP9HDbBPcs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzfmjzMMOLgWwaYPiVnovQceyicK2DBJ7kgQQ0t2xVex32ch7Rm
	JFP73ZotbkeIGH0UTtrrJiDRPxriCSF77NBvsixVEKbqOEsSmrKWAjsa/Q2jYZuCFFA=
X-Gm-Gg: AfdE7cmhWvFczEVZkhfFPdpcKj3m2jGUh2uCJH2Jlvfk60JuEc0uiFy6qcnTtO+IziU
	x9el8gIKJZDrOlcrDpRRmlZJ4cTsSp0++BA0EVH625DLVpv/86ZiYmqkc+4dRcIog75cCdm4Ho6
	u6B6aRHaHKt/reow0G3ogs5nmZUTv3PfAF1qPJfAHex/pbJoD4M3Hfrnlza18K5t8DL0z9GWp5f
	zgLRJvo8piDke0aP7FEJrh0Wc3A4Zjhc0h7MC9iDKlxapKbJrgg9ObFhclxIeJuLTvCtLb6JgqJ
	8HXmNDHnQ6n7QQ89KuFZHKyOiZdmRnkjixPftishFvEChjBNwOfcY79WQPjWRi92p5fIaIG2dW8
	YMFdCi1jBsDaZoGiAItovZ7Il9NM9dXQZQHF/wE3fvz1PSxWV9konY6j6osprTrm/qQKlqkb2H5
	PC
X-Received: by 2002:a05:6402:3512:b0:699:6415:750a with SMTP id 4fb4d7f45d1cf-69c5f12197cmr3696963a12.23.1783950535377;
        Mon, 13 Jul 2026 06:48:55 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1f19::319:116])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d78a08sm16555473a12.18.2026.07.13.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:48:54 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:48:54 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>, "ziwei . dai" <ziwei.dai@unisoc.com>, 
	"ke . wang" <ke.wang@unisoc.com>, Matt Fleming <mfleming@cloudflare.com>, 
	sched-ext@lists.linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@cloudflare.com, Sashiko AI <sashiko-bot@kernel.org>
Subject: Re: [PATCH 2/2] sched/psi: Shut down rtpoll_timer in
 psi_cgroup_free()
Message-ID: <alTsuUssizMKh0lW@matt-Precision-5490>
References: <20260712174619.3553231-1-tj@kernel.org>
 <20260712174619.3553231-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712174619.3553231-3-tj@kernel.org>

On Sun, Jul 12, 2026 at 07:46:19AM -1000, Tejun Heo wrote:
> psi_schedule_rtpoll_work() is called locklessly from the scheduler hotpath
> and can race psi_trigger_destroy() taking down the last rtpoll trigger under
> rtpoll_trigger_lock:
> 
>   psi_schedule_rtpoll_work()        psi_trigger_destroy()
> 
>   rcu_read_lock();
>   task = rcu_dereference(rtpoll_task);
>                                     rcu_assign_pointer(rtpoll_task, NULL);
>                                     timer_delete(&rtpoll_timer);
>   mod_timer(&rtpoll_timer, ...);
>   rcu_read_unlock();
>                                     synchronize_rcu();
>                                     kthread_stop(task_to_destroy);
> 
> The group can then be freed with the re-armed timer still pending, and
> poll_timer_fn() runs on freed memory.
> 
> 461daba06bdc ("psi: eliminate kthread_worker from psi trigger scheduling
> mechanism") deleted the timer synchronously after the synchronize_rcu(),
> which prevented this but raced trigger creation instead: the deletion could
> cancel the timer that a new trigger set armed during the grace period and,
> as creation also reinitialized the timer at the time, corrupt it.
> 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy") moved the
> initialization into group_init() and the deletion into the locked section,
> trading the creation races for the window above.
> 
> Neither placement in the destruction path works. A pending timer firing
> while the group is alive is harmless though. poll_timer_fn() just wakes the
> rtpoll waitqueue and doesn't re-arm itself. Bind the timer to the group's
> lifetime instead and shut it down in psi_cgroup_free(). Nothing can arm it
> by then. timer_shutdown_sync() because the timer is never armed again.
> 
> Fixes: 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy")
> Cc: stable@vger.kernel.org # v5.10+
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260711000434.36C4A1F000E9@smtp.kernel.org/
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/psi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
 
Tested-by: Matt Fleming <mfleming@cloudflare.com>
