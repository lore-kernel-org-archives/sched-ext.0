Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB523E8340
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940222; cv=none; b=nEgbaruPwABfr8fngEAvqWv3EMqAQ2exGqS8XusiwU1UVTo0cpYg+9Je6osA/EAQKaFPpGePTkOKHO+8+0V8VIa1XtNp0kHclNf7bf5d89CXKdytMH7zMyA8wpRPJZWByLFDJifUFVyk9zYdWDbipbzqRykVqzwbZYTFpw59zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940222; c=relaxed/simple;
	bh=y7zI6WWCN62EttLtA8m/eJMwaY6HfV7JtvtgKW2u+RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIt11GAy63w3H+r8LUVmr4/Ir7xmlB+/LaiYrrjj72XBEvZ7GaKgBloSI7DhtkNGE2h0/ZLskxmW+G/9Q6n/pY9uj44KQu16h34tJ1ZacrnUlx7iFUq2rLQF0GEUlht/1TPKaBqwUX9YTgVcyzHDPDrCOQFXnhU1uNXoeOWmVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=ZCLieiI0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="ZCLieiI0"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47d70879764so1861694f8f.2
        for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783940218; x=1784545018; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Dhj2OBMuhusOZcXZldE/EzCpMTqXXR0jxmWBxe1EX0=;
        b=ZCLieiI0/uxOP/xrFe7pxki/fUp06KFQX+C+JwlAaAHgy8W90MTD1cqMZNEeJ6GxSt
         ERPQoJDsby868Gn8gjNqvtJ/0CHAVZGxB8BjT8ffmAi1rvgYHgfnFyUUHuq1LADKqa5v
         XfDaqGoKN2sZP6N7fh1dI/cqjUJWqxWmSIcwzgRo3O0HCFssU+UH1C/cNBfCK3QSm+x9
         mOkudXCp6kG61SJnAO5hpWUURhN4M+v0RcB6PfsbVmT5Y794FTPDdqApx0X6ApODTcrb
         AeCyv61kM+k980x/hoqgPTOJpm5Ky2tM88mbNzrd5GV0byUUZAC46BH3eEXpV23szpCR
         pgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783940218; x=1784545018;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Dhj2OBMuhusOZcXZldE/EzCpMTqXXR0jxmWBxe1EX0=;
        b=ZMArh4pcZ243cDOzxMwGCDCUg+If2Du4Yg+UQGnnWS0jXs6p/+nB7W+pHnGPhkGsOd
         oLtbv33OxaXR0B8GMzNoelOK9lot4silejIxImAheXYTyGGgseiP0UkfUq+8uLuYppSQ
         mTXlO8NEG0GmaGS5W+V1Ri7ul90qQt22xCCHGd8TVoBP8P2y+yCXiAzpRddmvx0FgiNK
         AVBQep06k2HTmk4qAY//+mnBkbk4LIYlV2SwH6rtKluiknkXxx8mhNMLqQam4H70J7oU
         G4OxxfYaJ4hA4tnaaZA8PdIwxEMSu7HCvbdABKoHSZ0jxDWZd+ou7h7P0yaPkT/uys43
         utrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUhXDSsICoQEdtiPhIl5su6wS8fc+eq4yM6YBpKxdvd+4yn25ADbMYtdzzYrpfzregF42D4ecOpH4=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi9p49fp/+wEEyIxx1M2lJDeX8+ZHef2Rg2stpiry8NeOOuqi2
	YDhPmJXH2C8YjftVkDVgHwZa6QmJHtUhyi0QEWCLNK/Mo1/+wd3rFPFFptPK27UteJU=
X-Gm-Gg: AfdE7cnCw5AantC7lb/v4Gw+3/STFVoyokhvGEL65Dy0faYvJ3w+Jd3zpLUF7r5G6TE
	UhYt8dGfuK9Onc0ysOHWpc43W6RLaFtROrBQk/9fy8sZOe0Wg/Y0fH3c59tkrUG08RTCL4ududO
	xFtk/UeMnXpN+xMJE6KpKDFJFgLCWvyP3zzhijI+3TXfXJN8MtUpLhke2xh5xqSKK2LvpNZma58
	inL7+6Yvdxtadqdzm18zftIjHBPG+o5Fi8BJ9tXQgactBZguifk7MVw4sjqzfPlxYwP9H6C9g8F
	VsgpSYWYR0GVtwEPi9RRkTJTGvg2FXejJEmZHd4qj4SeUo/XHOeBTI8br6nHsWxoScRdysHW3Ot
	NNMz6d0dzKTa74h7452YlknWw1mGTHIN6uCt6VJf6mX4MEk/JgENZ28OYN5tPEfUw3atOt/ADmI
	A62yNFl61fBQ==
X-Received: by 2002:a05:600c:a016:b0:493:f442:3de9 with SMTP id 5b1f17b1804b1-493f883174amr85181725e9.27.1783940217582;
        Mon, 13 Jul 2026 03:56:57 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73ae14sm352682965e9.11.2026.07.13.03.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:56:56 -0700 (PDT)
Date: Mon, 13 Jul 2026 06:56:55 -0400
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
	stable@vger.kernel.org, kernel-team@cloudflare.com,
	Sashiko AI <sashiko-bot@kernel.org>
Subject: Re: [PATCH 2/2] sched/psi: Shut down rtpoll_timer in
 psi_cgroup_free()
Message-ID: <20260713105655.GC276793@cmpxchg.org>
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

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Both these patches look good to me, but Suren can you please also take
a look?
