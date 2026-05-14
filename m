Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC2330662
	for <sched-ext@lists.linux.dev>; Thu, 14 May 2026 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750036; cv=none; b=edrm09cXYIe5bCtwPSf5B7A9m5uE1ZO6a47wHnzLDOU/v9juHi2KxGfJSTZVFj9fHlfB/fy3qvR1YkgX1KiM1Oc9iW0hchwexd6Lx9mKLQhBQO7xLiIY4F9mKRYFOoEvKTGv5aWVI9JDFdd1N0YCG2q96RtC1TaOqNOn6++17y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750036; c=relaxed/simple;
	bh=ZXkmqI4qu2HKDSgM9Z5W9p1fVi8LeQOqmxHRdo4RKFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu/n+LY4KoQnObLsOyXp+Nee/yN7IbTBuDKLQZRXzZYkJbv4bOEICycNHcKVt82QTof0AuZMAiY+sLoY6U0lWC2hv+2JNAKFUnUqm1R9MoirCc6wBZ+i+L2zele+liXwEkz97s6U5hD+mr0UIfNHtDnFqDEa5fFkRoxMpgnYKGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=STf94R1q; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="STf94R1q"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8E06B26771;
	Thu, 14 May 2026 11:13:52 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RlyBlo3wzAE4; Thu, 14 May 2026 11:13:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778750032; bh=ZXkmqI4qu2HKDSgM9Z5W9p1fVi8LeQOqmxHRdo4RKFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=STf94R1qt4tAXMJSt/UuJFyw/urIzWAnYJVIruwySuaOaHhFz5Ru9qTQCf67edaCk
	 RhGWanV6sW5POyaqHnXsumklZTHV/g60hBegCF7rBxwzg4/LiHaVnspDIDHqU6Ieeh
	 gyb9malNbsVLB1n4/xQPvyQ50Yc5nseGpXbIf2c42CjKlyLFWUK45/+iCFocdYwd9I
	 /Jn5kdIP6JenzQWywtdOpmqqeN9cwxx/9yK9yw/25ue0rO/VTJ2iSiuU+1bHDkFiUj
	 c3cOeKOM7D1ZnfRRvJoBOovQgdItiMqhjXxXgS3XKcr0SaCNqt97swWi+TrWnmhF6p
	 7/hYe6xr1ujmg==
Date: Thu, 14 May 2026 11:13:49 +0200
From: Samuele Mariotti <smariotti@disroot.org>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, void@manifault.com, 
	changwoo@igalia.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Paolo Valente <paolo.valente@unimore.it>
Subject: Re: [PATCH] sched_ext: Fix spurious WARN on stale ops_state in
 ops_dequeue()
Message-ID: <agV8-RlKEkiAbd-h@cachyos>
References: <20260513095329.4029345-1-smariotti@disroot.org>
 <agSKJbtmpRPLgYJW@gpd4>
 <agSpf9QRx4zqhZxx@cachyos>
 <agTYojgRwDH67QMC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agTYojgRwDH67QMC@slm.duckdns.org>

Hi Tejun,

>Let's not do the WARN and exit. We shouldn't get this wrong and if we get
>this wrong, it's going to be obvious from lockup detectors. Can you please
>add a comment explaining the retry condition tho?
>
>Thanks.
>
>-- 
>tejun

Thanks for the feedback. If I understood correctly, you prefer no retry
limit, letting the lockup detectors catch any real bug. I also added
unlikely() since the stale case is by definition rare.

Here is the updated version:

/*
  * If SCX_TASK_IN_CUSTODY is not set, opss is stale: finish_dispatch()
  * has already claimed the task and cleared SCX_TASK_IN_CUSTODY. Retry
  * to get a fresh view of p->scx.ops_state.
  */
if (unlikely(!(READ_ONCE(p->scx.flags) & SCX_TASK_IN_CUSTODY))) {
     cpu_relax();
     goto retry;
}

Let me know if this looks good to you.

Thanks,
Samuele
