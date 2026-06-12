Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753663644C9
	for <sched-ext@lists.linux.dev>; Fri, 12 Jun 2026 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261762; cv=none; b=W63xbrNnxGQuZ2Omn/kr9B/z2euvOHiwQCuCqEnZgONpEDa55WzuZhoizG+XrjSW8LuTID3z9zSJURbaFe31dVCqbLTh8d1zNqjGChFS25MqZUgjy1NP5Mv3NDYPFnRhyr4C0o4nMGaKON385qUkarsiEQzYMJ0IP+SRS7T23WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261762; c=relaxed/simple;
	bh=PVTWmbBly8zPDbKOtQD2k3g2UibP+X+DNOW3OaousuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sp/WOuZv86m1IQWLmNH9NfKU9vxT1PSVehEnFUaJ56UYJw++gbFnKvVjJPNSoqmBVCy93IOSvYeQjFdWUe0ATfXtGlw0UmYTB/p1cXwVFafAqZUDzqqLDbrmDWaJnOscLvXnRNMZfCTLg59EKuzgLeL0mwxPWkLOe/mmkSDv4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=ck/hIspk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="ck/hIspk"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so8670175e9.1
        for <sched-ext@lists.linux.dev>; Fri, 12 Jun 2026 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1781261760; x=1781866560; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHVu3uBcu4MSdS4JcY9TeCqwQdHofeukrk2Mu99OLtM=;
        b=ck/hIspkfHt+9UrPCbTcaza53eqrZ+Jalub0HT3vCjwZN8m15XAFNkwc+Ftc8ZUGpi
         hLLgRsBSY26JW61ITlstixGbX4SFHUxO6QIa4mr6h5g1NQaEKxoVAt+Ozrns6MmrSo5/
         H7YvMik8gJQVTlBvEW5vHg4At7hvpGrqvqypZQPD5zjwUjFm/b5jxuHWY4nd+oWZIquJ
         3U1bc+E4cSLglLdXK5AhFcNQ9qO2QjBd/QttT1Gvddr2lsNva7wqssTTCGfcVaySj5+0
         6g9Bv55EHVH54mcL31/FDzNv+8F2YD7y82V1xSDoe2IsD/BaHAYcIJeWaNlv8uTnfXH6
         IuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781261760; x=1781866560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHVu3uBcu4MSdS4JcY9TeCqwQdHofeukrk2Mu99OLtM=;
        b=O5ZTLTlXV+iU6/o0/NPc/5cisKC1j9udd9YrJK3s2yMO8zIqDHindU3yv/HpCdTa8r
         PkwC7H1f96o3qXxw4qTs0IhZgQFPDyQpJB171fQ0a0AKmk+OsiCU7PZCQLtHsFjspvDD
         LStWC32Nyl9VNNUcF4OkgLlrXx9lCT99SSlMEkJziSJieRM1mJXUBakhvxFW66IFg9Ty
         tiHpz0Xm8cC+2779jA6HmwdynmofFXFqu3XztkFv2PI8LjHXyZ7O4lBIuwMc7P75Hx/s
         tkcojI22pwxdBA5wHY4BTIZvAcphd7UpFrQeAqDdXuGlcP71KUNlSHQqo1F52JM4QvUK
         AZ5w==
X-Forwarded-Encrypted: i=1; AFNElJ95JC7M2LwOTrjNE1bVVjOAQ5xGKE70HJBxMlEIAffGqVtDxN/+hHdVP0ot4bbmhRkdBPzGZSdsMS4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7b16RxCO4sukgcWsnXp61wQX7pIfzLz0CFlhS/Syq5jwglpn5
	lXYKjuTRwYznLbO/QfDj8uvRdue+FU+BzFYPFp1Q3XUKMjFJqouD0WAYdbP4C5pcNBw=
X-Gm-Gg: Acq92OHQ67qI0RBLLez6ymqRq0ed212na6itBLT/q0SOHpyCqMqdZl6cjFsDqTi6CWl
	H9vXWX3NlQI7eP091IXePvMBZZxLsg/L/sEeJYN831zd8Xm+prqxVuEOWauwQBI/m1WDvbhfGPX
	wpEedBJKDlpWI7hW0Oet+YOxACDw5e8yLg+Dms+z+w0x8ui/UAdZpJsqylXG/HIy/bRhYKPsYyl
	xPgjoBXVV9j2LGx/F3FGzvG1OFO9D6GymBj8um9kWFuWQDK6ECN26dDTfpwqSBkwu/mTDGpVTpk
	nJGleTzB5LdBEKpncmatBxIO+BxGPcnpmmrZykvACLypp46Xaz55t7jChrKzZ1ITSgdMeKo0qeH
	3Y4pO4YCTdbOYKs4PEOVzf3+5Nd+gCXFRzGIVBjCTP0gy6IE2GMkdqOqWbvUZWdYh6MrcaHYdpX
	ZbEB8Fzxc8
X-Received: by 2002:a5d:5d85:0:b0:45e:dacb:8885 with SMTP id ffacd0b85a97d-4606dbf15a9mr3363704f8f.35.1781261759486;
        Fri, 12 Jun 2026 03:55:59 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:2696::3d8:8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cf5d9sm4111442f8f.32.2026.06.12.03.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:55:58 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:55:57 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: sched_ext/lavd hard lockup in old call_rcu_tasks_generic
 needadjust path
Message-ID: <aivaGbCzC4oaD05n@matt-Precision-5490>
References: <20260609104733.1184001-1-mfleming@cloudflare.com>
 <2179fc11-3bd5-4d2e-9ad8-609e3356ec09@paulmck-laptop>
 <aiqxpzgl2YVVSARw@matt-Precision-5490>
 <1ad83f53-7897-40bc-a503-5a71031aa27f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad83f53-7897-40bc-a503-5a71031aa27f@paulmck-laptop>

On Thu, Jun 11, 2026 at 06:45:14AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 11, 2026 at 02:02:58PM +0100, Matt Fleming wrote:
> > On Tue, Jun 09, 2026 at 04:23:23AM -0700, Paul E. McKenney wrote:
> > > 
> > > Does commenting out the 'call_rcu_tasks_generic+547' printk() avoid the
> > > issue?  If so, that printk() might be deferred or some such.
> > > 
> > > "But if you cannot trust printk(), what *can* you trust?"  ;-)
> > 
> > I tried this and it still crashes so apparently not! I'll keep digging
> > to find the real cause (it's somewhat cumbersome to reproduce this hard
> > lockup).
> 
> If this code path is nevertheless involved, one thing that might speed
> things up would be to do bursts of call_rcu_tasks() from lots of CPUs,
> then avoid doing any call_rcu_tasks() for some time, then do a single
> isolated call_rcu_tasks().  Or maybe you are already doing this.

Thanks, I managed to shrink the time to reproduce the lockup and it's
now clear that the bug is an ABBA deadlock on cbs_gbl_lock.

   CPU #1
   ==========
     sched_ext_free()
       task_rq_lock()                               // acquires rq->lock
       scx_exit_task()
         SCX_CALL_OP_TASK(.exit_task)
           bpf_task_storage_delete()
             bpf_selem_unlink()
               bpf_selem_unlink_storage()
                 bpf_selem_free()
                   call_rcu_tasks_trace()
                     call_rcu_tasks_generic()
                       raw_spin_lock(cbs_gbl_lock)  // BLOCKS: CPU #2 owns it
   CPU #2
   ==========
     rcu_tasks_kthread()
       rcu_tasks_one_gp()
         raw_spin_lock(cbs_gbl_lock)                // acquired
         pr_info("Starting switch ...")             // still under cbs_gbl_lock
           console_unlock()
             wake_up_q()
               try_to_wake_up(repro)
                 raw_spin_lock(rq->lock)            // BLOCKS: CPU #1 owns it

Given this, I can see why removing the single printk() didn't fix
anything, and we can expect any code path under cbs_gbl_lock that wakes
a task could trigger this hard lockup. Right now in 6.18 that's a few
printk()s and a WARN_ON_ONCE().

This issue doesn't exist in v7.0-rc1 because of commit c27cea4416a3
("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast").

Is there an easy way to defer call_rcu_tasks_generic() work so it gets
executed without rq->lock being held? I'm assuming backporting the SRCU
patches would be too invasive for LTS?

Thanks,
Matt
